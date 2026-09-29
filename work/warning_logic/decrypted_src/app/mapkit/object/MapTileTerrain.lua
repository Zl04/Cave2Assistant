local lume = require "thirdparty.lume"
local MapHelper = require "app.mapkit.MapHelper"
local MapDefine = require "app.mapkit.MapDefine"
local MapEffectColorData = require "app.mapkit.model.MapEffectColorData"
local MapTileEffectColor = require "app.mapkit.object.MapTileEffectColor"
local SceneManager = require("app.game.SceneManager")

require "app.mapkit.tostring"

local MapElement = require "app.mapkit.object.MapElement"
local MapTileTerrain = class("MapTileTerrain", MapElement)

local TerrainLayerCount = 2  -- use two layers of terrain texture to make some gradient or tint animation 

-- this terrain class can present both Terrain Wall and Terrain Ground
-- Wall is composed by three sections, wall01, wall02, wall03
-- Ground is only one section, floor01
-- the first section must by add on the Ground Layer of Map
-- the second and third section should by add on the Node-On-Map Layer of Map

-- 构造
function MapTileTerrain:ctor(terrainData, tileWidth, tileHeight)
	-- assert(terrainData ~= nil)
	
	self.visionLevel = MapDefine.FarestTileColorLevel
	self.sections = {}
	self.effectColorDatas = {}
	self.effectColorObjects = {}
	self:set(terrainData, tileWidth, tileHeight)
end

-- 析构
function MapTileTerrain:destroy()
	self:destroySections()
end

-- 设置地块数据和宽高并更新分层
function MapTileTerrain:set(terrainData, tileWidth, tileHeight, map)
	self.terrainData = terrainData
	self.tileWidth = tileWidth
	self.tileHeight = tileHeight
	self.map = self.map or map
	self:updateSections()
	-- self:updateEffectColors()
end

-- 设置地块数据并更新分层
function MapTileTerrain:setTerrainData(terrainData)
	-- if #self.terrainData:getTerrainNames() == #terrainData:getTerrainNames()
	-- 	and self.terrainData:getTerrainType() == terrainData:getTerrainType() then
	-- 	return
	-- end
	-- print("MapTileTerrain:setTerrainData", tostring(terrainData))
	self.terrainData = terrainData
	self:updateSections()
	-- self:updateEffectColors()
end

-- 设置视野等级并更新分层
function MapTileTerrain:setVisionLevel(visionLevel)
	self.visionLevel = visionLevel
	self:updateSections()
	-- self:updateEffectColors()
end

-- 添加整个视图到传入的地图上
function MapTileTerrain:addToMap(map, position, zorder)
	-- 保存参数
	self.map = map
	self.position = position
	self.zorder = zorder

	-- 设置section1为地面, section2及以上为装饰物
	for sectionIndex, section in ipairs(self.sections) do
		for terrainLayerIdx, terrainLayer in ipairs(section.terrainLayers) do
			if sectionIndex == 1 then
				-- printfmt("tile terrain section %d resource name %d add to %d", sectionIndex, terrainLayer:getTexture():getName(), map:getLayer(MapDefine.LayerIndexGround):getTexture():getName())
				map:addNodeGround(terrainLayer)
				if (terrainLayerIdx == 1 and position.coordX and position.coordY) then
					terrainLayer:setName("<MapTile | x = " .. position.coordX .. ", y = " .. position.coordY .. ">")
				end

			elseif map.mapData.caveMode == PublicDefine.CAVE_MODE.MODE_PET and sectionIndex == 3 then
			elseif SceneManager:getInstance():isInPuzzle() and sectionIndex == 3 then
			else
				map:addNodeOnMap(terrainLayer,true)
			end
		end
		self:setUpSectionWithIndex(section, sectionIndex)
	end
end

-- 把这个地块从地图上拆除
function MapTileTerrain:removeFromMap()
	self.map = nil
	for index, section in ipairs(self.sections) do
		for i, terrainLayer in ipairs(section.terrainLayers) do
			terrainLayer:removeFromParent()
			-- terrainLayer:release()	
		end
	end
	-- lume.clear(self.sections)
end

-- 返回所有层的可见状态
function MapTileTerrain:getSectionsVisibleStatus()
	local visibleStatus = {}
	for _, section in ipairs(self.sections) do
		lume.push(visibleStatus, section.visible)
	end
	return visibleStatus
end

-- 更新所有的层
local count1 = 0
function MapTileTerrain:updateSections()
	if (not self.terrainData) then return end

	-- 初始化所有section变量
	for sectionIndex, section in ipairs(self.sections) do
		-- 清除是否创建层纹理的标记
		section.hasView = false
		-- 初始化隐藏所有层
		for terrainIndex, terrainLayer in ipairs(section.terrainLayers) do
			terrainLayer:setVisible(false)
		end
	end

	-- 根据配置名称创建层纹理
	local sectionCount = #self.terrainData.terrainNames
	local sectionIndex = 0
	for i, textureName in ipairs(self.terrainData.terrainNames) do	
		-- 准备数据
		sectionIndex = sectionIndex + 1
		local section = self.sections[sectionIndex]
		local category = self.terrainData:getSectionCategory(i)
		local terrainType = self.terrainData.terrainType

		-- 创建或根据传入参数更新section
		if (not section) then
			-- 创建新section和其纹理表现
			local coloredTexName = self:getTerrainColoredTexName(textureName, terrainType, self.visionLevel, category)
			section = self:createSection(coloredTexName)
			section.coloredTexName = coloredTexName
			section.category = category
			section.terrainType = terrainType
			section.visionLevel = self.visionLevel
			self.sections[sectionIndex] = section
		else
			-- 更新section和其纹理表现
			local coloredTexName = section.coloredTexName
			if section.category ~= category or section.terrainType ~= terrainType or section.visionLevel ~= self.visionLevel then 
				coloredTexName = self:getTerrainColoredTexName(textureName, terrainType, self.visionLevel, category)
			end
			self:updateSection(section, coloredTexName)
		end
		section.hasView = true
	end
end

-- 创建新的section
function MapTileTerrain:createSection(coloredTexName)
	-- 初始化section
	local section = {}
	section.terrainLayers = {}
	section.visible = true
	section.setVisible = function(section, visible)
		if #section.terrainLayers > 0 then
			for _, terrainLayer in ipairs(section.terrainLayers) do
				if (section.hasView) then
					terrainLayer:setVisible(visible)
				else
					terrainLayer:setVisible(false)
				end
			end
		end
	end
	for i = 1, TerrainLayerCount do
		local frame = cc.SpriteFrameCache:getInstance():getSpriteFrameByName(coloredTexName)
		if frame then
			local terrainLayer = cc.Sprite:createWithSpriteFrameName(coloredTexName) 
			if terrainLayer ~= nil then
				lume.push(section.terrainLayers, terrainLayer)
				terrainLayer:setCascadeOpacityEnabled(false)
				terrainLayer:setCascadeColorEnabled(false)
				terrainLayer:retain()
				-- 重写C++此方法,如果纹理一样不替换。避免耗时操作
				terrainLayer.setSpriteFrame = function (_,frameName)
					if terrainLayer.__frameName ==  frameName then
						-- print("名字一样 不处理")
						return
					end

					if not frameName then
						printError("terrainLayer:setSpriteFrame invalid fileName",frameName)
						return
					end
					terrainLayer.__frameName = frameName
					getmetatable(terrainLayer).setSpriteFrame(terrainLayer,frameName)
				end
			end
		else
			printError(" createSection setSpriteFrame no found spriteFrameCache=",coloredTexName)
		end
	end

	-- 如果有创建层, 设置section大小为最底层大小
	if #section.terrainLayers > 0 then
		section.width = section.terrainLayers[1]:getContentSize().width
		section.height = section.terrainLayers[1]:getContentSize().height
	end
	return section
end

-- 更新section
function MapTileTerrain:updateSection(section, coloredTexName)
	for i = 1, TerrainLayerCount do
		local terrainLayer = section.terrainLayers[i]
		terrainLayer:setSpriteFrame(coloredTexName)
		terrainLayer:setCascadeOpacityEnabled(false)
		terrainLayer:setCascadeColorEnabled(false)
		terrainLayer:setVisible(true)
	end
	if #section.terrainLayers > 0 then
		section.width = section.terrainLayers[1]:getContentSize().width
		section.height = section.terrainLayers[1]:getContentSize().height
	end
	section.visible = true
end

-- 销毁所有的section
function MapTileTerrain:destroySections()
	for index, section in ipairs(self.sections) do
		for i, terrainLayer in ipairs(section.terrainLayers) do
			if not tolua.isnull(terrainLayer) then
				if (terrainLayer:getParent()) then
					terrainLayer:removeFromParent()
				end
				terrainLayer:release()	
			end
		end
	end
	lume.clear(self.sections)
end

-- function MapTileTerrain:updateSections_bak()
-- 	if (not self.terrainData) then return end

-- 	for _, section in ipairs(self.sections) do
-- 		self:destroySection(section)
-- 	end
-- 	lume.clear(self.sections)

-- 	local sectionsVisibleStatus = self:getSectionsVisibleStatus()
-- 	local sectionCount = #self.terrainData.terrainNames
-- 	for i, textureName in ipairs(self.terrainData.terrainNames) do
-- 		local category = self.terrainData:getSectionCategory(i)
-- 		local section = self:createSection(textureName, self.terrainData.terrainType, self.visionLevel, category)
-- 		lume.push(self.sections, section)
-- 		-- the hidden section
-- 		if i <= #sectionsVisibleStatus then	
-- 			section.visible = sectionsVisibleStatus[i]
-- 			if not section.visible then
-- 				-- print ("update section hidden", i)
-- 				for _, terrainLayer in section.terrainLayers do
-- 					terrainLayer:setOpacity(0)
-- 				end
-- 			end
-- 		end
-- 	end

-- 	if self.map and self.position and self.zorder then
-- 		self:addToMap(self.map, self.position, self.zorder)
-- 	end
-- end

-- function MapTileTerrain:createSection_bak(textureName, terrainType, visionLevel, category)
-- 	local coloredTexName = self:getTerrainColoredTexName(textureName, terrainType, visionLevel, category)
-- 	local section = {}
-- 	section.terrainLayers = {}
-- 	section.visible = true
-- 	section.setVisible = function (section, visible)
-- 		if #section.terrainLayers > 0 then
-- 			for _, terrainLayer in ipairs(section.terrainLayers) do
-- 				terrainLayer:setVisible(visible)
-- 			end
-- 		end
-- 	end
-- 	for i = 1, TerrainLayerCount do
-- 		local terrainLayer = cc.Sprite:createWithSpriteFrameName(coloredTexName) 
-- 		if terrainLayer ~= nil then
-- 			lume.push(section.terrainLayers, terrainLayer)
-- 			terrainLayer:setCascadeOpacityEnabled(false)
-- 			terrainLayer:setCascadeColorEnabled(false)
-- 			terrainLayer:retain()
-- 		end
-- 	end
-- 	if #section.terrainLayers > 0 then
-- 		section.width = section.terrainLayers[1]:getContentSize().width
-- 		section.height = section.terrainLayers[1]:getContentSize().height
-- 	end
-- 	return section
-- end

-- function MapTileTerrain:destroySection(section)
-- 	local count = #section.terrainLayers
-- 	for i = 1, count do
-- 		local terrainLayer = section.terrainLayers[i]
-- 		terrainLayer:removeFromParent()
-- 		terrainLayer:release()
-- 	end
-- end

-- 根据不同层级的section来配置不同的基础位置
function MapTileTerrain:setUpSectionWithIndex(section, index)
	local pos = {x = self.position.x, y = self.position.y}
	local tileHeight = self.tileHeight

	-- 处理2层(地面和第一层装饰物)以上的位置
	if index >= 3 then
		for i = 2, index - 1 do
			local height = self.sections[i].height
			pos.y = pos.y + height - tileHeight - 3
		end
	end

	-- 处理地面层的锚点位置
	local anchorPoint = {x = 0.5, y = (section.height - tileHeight * 0.5) / section.height} 

	-- 处理1层(地面)以上的锚点位置
	if index > 1 then
		anchorPoint = {x = 0.5, y = tileHeight * 0.5 / section.height}
	end

	-- 设置位置, 锚点, 和z序
	for _, terrainLayer in ipairs(section.terrainLayers) do
		terrainLayer:setAnchorPoint(anchorPoint)
		terrainLayer:setPosition(pos)
		terrainLayer:setLocalZOrder(self.zorder)
	end
end

-- transform

function MapTileTerrain:transformToVisionLevel(visionLevel, shouldShrink, progress)
	assert(self.terrainData:getTerrainNames() ~= nil, "terrainNames is nil")
	local wallExtensionVisible = not shouldShrink

	for sectionIndex, section in ipairs(self.sections) do
		if sectionIndex <= #self.terrainData:getTerrainNames() then
			-- section:setVisible(true)
			-- local str = ("section %d 's coloredTexName is nil"):format(sectionIndex)
			-- assert(self.terrainData:getTerrainNames()[sectionIndex] ~= nil, str)
			local category = self.terrainData:getSectionCategory(sectionIndex)
			local oldColoredTexName = self:getTerrainColoredTexName(self.terrainData:getTerrainNames()[sectionIndex], self.terrainData:getTerrainType(), self.visionLevel, category)
			local coloredTexName = self:getTerrainColoredTexName(self.terrainData:getTerrainNames()[sectionIndex], self.terrainData:getTerrainType(), visionLevel, category)
			if sectionIndex <= 2 then
				-- the Ground and Wall base section, only handle the color tint animation
				local bottom = section.terrainLayers[1]
		        local top = section.terrainLayers[2]
		        if progress == 0 then
					top:setOpacity(0)
					
					
					top:setSpriteFrame(coloredTexName)
					
		            if oldColoredTexName ~= nil then
		                bottom:setSpriteFrame(oldColoredTexName)
		            end
				elseif progress == 1 then
					
					top:setSpriteFrame(coloredTexName)
					bottom:setSpriteFrame(coloredTexName)
					
		            self.visionLevel = visionLevel
				else 
					
					top:setSpriteFrame(coloredTexName)
					
		            top:setOpacity(255 * progress)
		        end
		    else
		    	-- the Wall topest extension section, should not only handle the color tint but also the fade in out
		    	local layer1 = section.terrainLayers[1]
		        local layer2 = section.terrainLayers[2]

				section.wallExtensionVisible = wallExtensionVisible
		        if section.visible then
		            if wallExtensionVisible then
						if progress == 0 then
							
							layer2:setSpriteFrame(coloredTexName)
							
		                elseif progress == 1 then
							layer1:setOpacity(255)
							
							layer1:setSpriteFrame(coloredTexName)
							layer2:setSpriteFrame(coloredTexName)
							
		                end 
		                layer2:setOpacity(255 * progress)
		            else
		                if progress == 0 then
							layer1:setOpacity(0)
							
							layer1:setSpriteFrame(coloredTexName)
							
		                elseif progress == 1 then
							layer1:setOpacity(0)
							
							layer1:setSpriteFrame(coloredTexName)
							layer2:setSpriteFrame(coloredTexName)
							

		                    section.visible = false
		                end
		                layer2:setOpacity(255 * (1 - progress))
		            end
		        else
		            if wallExtensionVisible then
						if progress == 0 then
							
							layer2:setSpriteFrame(coloredTexName)
							
		                elseif progress == 1 then
							layer1:setOpacity(255)
							
							layer1:setSpriteFrame(coloredTexName)
							layer2:setSpriteFrame(coloredTexName)
							

		                    section.visible = true
		                end
		                layer2:setOpacity(255 * progress)
		            else
						layer2:setOpacity(0)
						
						layer2:setSpriteFrame(coloredTexName)
						
						layer1:setOpacity(0)
						
						layer1:setSpriteFrame(coloredTexName)
						
		            end
		        end
		    end
		else
			section:setVisible(false)
		end
	end
end

-- helpers

function MapTileTerrain:getTerrainColoredTexName(textureName, terrainType, visionLevel, category)
	local color = self:getTerrainColor(terrainType, visionLevel)
	local isUseSplit = false
	if self.map then
		local isSplit = self.map:getIsSplit()
		if isSplit == 1 and tileCount then
			local tileCount = self.map.mapData:getUsedTileCount()
			local height = self.map.mapData:getUsedTileCount().y
			if self.terrainData.y == math.floor(height / 2) then
				isUseSplit = true
				if terrainType == 0 then
					textureName = self.map.mapData.name
				end
			end
		end
	end
	
	return MapHelper.getMapTileTerrainColoredTextureName(textureName, category, color, isUseSplit, terrainType)
end

function MapTileTerrain:getTerrainColor(terrainType, visionLevel)
    local colors = self.terrainData.colors
    if colors ~= nil then
    	if visionLevel == 0 then
    		return nil
    	end

    	local color = nil
    	if visionLevel > MapDefine.FarestTileColorLevel then
    		visionLevel = MapDefine.FarestTileColorLevel
    	end
	    if visionLevel >= 1 and visionLevel <= #colors then
	        color = colors[visionLevel]
	    end
	    if color ~= nil then
	        color.a = 255
	    end
	    return color
    end
 	return nil
end

function MapTileTerrain:setVisible(visible)
	for _, section in ipairs(self.sections) do
		section:setVisible(visible)
	end
end

function MapTileTerrain:updateAppearance(progress)
	for sectionIndex, section in ipairs(self.sections) do
		if sectionIndex <= #self.terrainData:getTerrainNames() then
			if sectionIndex <= 2 then
				-- the Ground and Wall base section, only handle the color tint animation
		        local top = section.terrainLayers[2]
		        top:setOpacity(255 * progress)
		    else
		    	-- the Wall topest extension section, should not only handle the color tint but also the fade in out
		    	local layer1 = section.terrainLayers[1]
		        local layer2 = section.terrainLayers[2]

		        if section.visible then
		            if section.wallExtensionVisible  then
		                layer2:setOpacity(255 * progress)
		            else
		                layer2:setOpacity(255 * (1 - progress))
		            end
		        else
		            if section.wallExtensionVisible  then
		                layer2:setOpacity(255 * progress)
		            end
		        end
		    end
		end
	end
end

return MapTileTerrain