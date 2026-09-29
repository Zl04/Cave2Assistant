local lume = require "thirdparty.lume"
local MapHelper = require "app.mapkit.MapHelper"
local MapDefine = require "app.mapkit.MapDefine"

local MapElement = require "app.mapkit.object.MapElement"
local MapTileEffectColor = class("MapTileEffectColor", MapElement)

function MapTileEffectColor.getEffectColorName(color, opacity)
	return MapHelper.c4b_to_string(color) .. "O" ..tostring(opacity)
end

function MapTileEffectColor:ctor(terrainData, colorData, tileWidth, tileHeight)
	self.sections = {}
	self.sectionsVisibleStatus = {}                                                                        
	self:set(terrainData, colorData, tileWidth, tileHeight)
end

function MapTileEffectColor:destroy()
	self.map = nil
	for _, section in ipairs(self.sections) do
		if not tolua.isnull(section) then
			if (section:getParent()) then
				section:removeFromParent()
			end
			section:release()	
		end
		
	end
end

function MapTileEffectColor:set(terrainData, colorData, tileWidth, tileHeight)
	self.terrainData = terrainData
	self.colorData = colorData
	self.tileWidth = tileWidth
	self.tileHeight = tileHeight
	self:updateSections()                                               
end

function MapTileEffectColor:getTerrainData()
	return self.terrainData
end

function MapTileEffectColor:getColorData()
	return self.colorData
end

function MapTileEffectColor:getTerrainColoredTexName(textureName, color, category)
	if textureName == nil or color == nil then
		return nil
	end

	return MapHelper.getMapTileTerrainColoredTextureName(textureName, category, color)
end

function MapTileEffectColor:updateSections()
	for _, colorSection in ipairs(self.sections) do
		colorSection:removeFromParent()
		colorSection:release()
	end

	lume.clear(self.sections)
	lume.clear(self.sectionsVisibleStatus)
	for i, textureName in ipairs(self.terrainData:getTerrainNames()) do
		local category = self.terrainData:getSectionCategory(i)
		local section = self:createSection(textureName, self.colorData:getColor(), self.colorData:getOpacity(), category)
		lume.push(self.sections, section)
		lume.push(self.sectionsVisibleStatus, true)
	end
end                                           

function MapTileEffectColor:createSection(textureName, color, opacity, category)
	local coloredTexName = self:getTerrainColoredTexName(textureName, color, category)
	if coloredTexName ~= nil and #coloredTexName > 0 then
		local colorSection = cc.Sprite:createWithSpriteFrameName(coloredTexName) 
		if colorSection ~= nil then
			colorSection:setCascadeOpacityEnabled(false)
			colorSection:setCascadeColorEnabled(false)
			colorSection:setOpacity(opacity)
			colorSection:retain()
		end
		return colorSection
	end
	return nil
end

function MapTileEffectColor:addToMap_bak(map, position, zorder)
	self.map = map
	self.position = position
	self.zorder = zorder

	local tileHeight = self.tileHeight
	for sectionIndex, colorSection in ipairs(self.sections) do 
		-- TODO: 第二层会导致灯光效果穿帮, 目前没有太多这种情况, 暂时不去掉中间一层, 以后可以直接继承在着色器里
		-- if (#self.sections < 3 or sectionIndex ~= 2) then
			local pos = {x = self.position.x, y = self.position.y}
			if sectionIndex >= 3 then
				for i = 2, sectionIndex - 1 do
					local height = self.sections[i]:getContentSize().height
					pos.y = pos.y + height - tileHeight
				end
			end

			if sectionIndex == 1 then  
				map:getLayer(MapDefine.LayerIndexGround):addChild(colorSection)
				colorSection:setAnchorPoint(0.5, (colorSection:getContentSize().height - tileHeight * 0.5) / colorSection:getContentSize().height)
			else 
				map:getLayer(MapDefine.LayerIndexNodeOnMap):addChild(colorSection)
				colorSection:setAnchorPoint(0.5, tileHeight * 0.5 / colorSection:getContentSize().height)
			end
			colorSection:setPosition(pos)
			colorSection:setLocalZOrder(zorder)
		-- end
	end
end

function MapTileEffectColor:addToMap(map, position, zorder)
	if (map and position and zorder) then
		self:addToMap_bak(map, position, zorder)
	else
		map = self.map
		for sectionIndex, colorSection in ipairs(self.sections) do 
			if sectionIndex == 1 then  
				map:getLayer(MapDefine.LayerIndexGround):addChild(colorSection)
			else 
				map:getLayer(MapDefine.LayerIndexNodeOnMap):addChild(colorSection)
			end
		end
	end
end

function MapTileEffectColor:removeFromMap()
	-- self.map = nil
	for _, section in ipairs(self.sections) do
		section:removeFromParent()
		-- section:release()
	end
end

function MapTileEffectColor:transformToVisionLevel(visionLevel, shouldShrink, progress)
	local wallExtensionVisible = not shouldShrink

	for sectionIndex, colorSection in ipairs(self.sections) do
		if sectionIndex == 3 then
   			local sectionVisible = false
   			if sectionIndex <= #self.sectionsVisibleStatus then
   				sectionVisible = self.sectionsVisibleStatus[sectionIndex]
   			end
			
			colorSection.wallExtensionVisible = wallExtensionVisible
	   		if sectionVisible then
	   			if not wallExtensionVisible then
	   				colorSection:setOpacity(self:getColorData():getOpacity() * (1 - progress))
	   				if progress == 1.0 then 
	   					self.sectionsVisibleStatus[sectionIndex] = false
	   				end
	   			end
	   		else
	   			if wallExtensionVisible then
	   				colorSection:setOpacity(self:getColorData():getOpacity() * progress)	
	   				if progress == 1.0 then 
	   					self.sectionsVisibleStatus[sectionIndex] = true
	   				end
	   			end
	   		end
	   	end
   	end

end

function MapTileEffectColor:setVisible(visible)
	for _, section in ipairs(self.sections) do
		section:setVisible(visible)
	end
end

function MapTileEffectColor:updateAppearance(progress)
	for sectionIndex, colorSection in ipairs(self.sections) do
		if sectionIndex == 3 then
   			local sectionVisible = false
   			if sectionIndex <= #self.sectionsVisibleStatus then
   				sectionVisible = self.sectionsVisibleStatus[sectionIndex]
   			end
	   		if sectionVisible then
	   			if not colorSection.wallExtensionVisible then
	   				colorSection:setOpacity(self:getColorData():getOpacity() * (1 - progress))
	   				if progress == 1.0 then 
	   					self.sectionsVisibleStatus[sectionIndex] = false
	   				end
	   			end
	   		else
	   			if colorSection.wallExtensionVisible then
	   				colorSection:setOpacity(self:getColorData():getOpacity() * progress)	
	   				if progress == 1.0 then 
	   					self.sectionsVisibleStatus[sectionIndex] = true
	   				end
	   			end
	   		end
	   	end
   	end

end

return MapTileEffectColor

