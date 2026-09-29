local MapTileData = class("MapTileData")
local MapDefine = require "app.mapkit.MapDefine"
local MapHelper = require "app.mapkit.MapHelper"
local MapEffectColorData = require "app.mapkit.model.MapEffectColorData"
local lume = require "thirdparty.lume"

local DEBUG = false

function MapTileData:ctor(x, y, z)
	self.x = x or 0
	self.y = y or 0
	self.z = z or 0
	self.width = 0
	self.height = 0
	self.reached = false
	self.isExplored = false
	self.isShowIcon = false       -- 是否显示
	self.terrainData = nil			
	self.decorationDatas = {} 
	self.effectColorDatas = {}
	self.placeholderDatas = {}
	self.roleDatas = {}
	self.buildingData = nil
	self.townDecorationData = nil
end

function MapTileData:addRole(roleData)
	-- add by zp 用于过滤错误的相关打印
	local found = false
	for i, theRoleData in ipairs(self.roleDatas) do
		if theRoleData:getSpriteID() == roleData:getSpriteID() then
			found = true
			break
		end
	end
	if(found) then 
		print("MapTileData:addRole category,type,coordx,coordy=",roleData:getCategory(), roleData:getType(), coord.x, coord.y)
		printError("MapTileData:addRole is repeat role into table.")
	else 
		lume.push(self.roleDatas, roleData)
	end
end

function MapTileData:removeRole(roleData)
	local found = false
	for i, theRoleData in ipairs(self.roleDatas) do
		if theRoleData:getSpriteID() == roleData:getSpriteID() then
			if(DEBUG) then
				print(("remove role %ud %ud at %d,%d"):format(roleData:getId(), roleData:getSpriteID(), self.x, self.y))
			end
			table.remove(self.roleDatas, i)
			found = true
			break
		end
	end
	if(found == false) then 
		if(roleData) then 
			local coord = roleData:getCoord()
			print("MapTileData:removeRole category,type,coordx,coordy=",roleData:getCategory(), roleData:getType(), coord.x, coord.y)
		end
		printWarn("MapTileData:removeRole no found removeRole.")
	end
end

-- 添加装饰物
function MapTileData:addDecoration(decorationData)
	lume.push(self.decorationDatas, decorationData)
end

-- 添加装饰物
function MapTileData:removeDecorationForID(decorationID)
	for i, theDecorationData in ipairs(self.decorationDatas) do
		if theDecorationData:getID() == decorationID then
			if(DEBUG) then
				print(("removeDecoration %ud %ud at %d,%d"):format(theDecorationData:getID(), decorationID, self.x, self.y))
			end 
			table.remove(self.decorationDatas, i)
			break
		end
	end
end


function MapTileData:isUsed()
	return self:getTerrainType() ~= MapDefine.TerrainType.None
end

-- destroy tile to ground
function MapTileData:isDestructible(debug)
	if self:getTerrainData():getTerrainType() == MapDefine.TerrainType.Wall then 
		if debug then 
			printfmt ("MapTileData with wall is destructible %d,%d", self.x, self.y)
		end
		return true
	end
	
	if not self:isReachable() then 
		for _, decorationData in ipairs(self.decorationDatas) do
			if debug then 
				printfmt ("MapTileData %d,%d has decorationData is destructible %s", self.x, self.y, tostring(decorationData:isDestructible()))
			end
			-- add by zp 这里修复了装饰物对于是否可以挖的逻辑，只要有一个不能挖就不能挖
			if not decorationData:isDestructible() then
				if debug then 
					printfmt ("MapTileData %d,%d has decoration destructible", self.x, self.y)
				end
				return false
			end
		end

		for _, data in ipairs(self.placeholderDatas) do
			if debug then 
				printfmt ("MapTileData %d,%d has placeholderData is destructible %s", self.x, self.y, tostring(data:isDestructible()))
			end
			-- add by zp 这里修复了装饰物对于是否可以挖的逻辑，只要有一个不能挖就不能挖
			if not data:isDestructible() then
				if debug then 
					printfmt ("MapTileData %d,%d has placeholderData destructible", self.x, self.y)
				end
				return false
			end
		end
	end
	if debug then 
		printfmt ("MapTileData is not destructible %d,%d", self.x, self.y)
	end
	return false
end

function MapTileData:isReachable(debug)
	for _, decorationData in ipairs(self.decorationDatas) do
		if not decorationData:isReachable() then
			if debug then 
				printfmt ("MapTileData has decoration not reachable %d,%d", self.x, self.y)
			end
			return false
		end
	end
	for _, roleData in ipairs(self.roleDatas) do
		if not roleData:isReachable() then
			if debug then 
				printfmt ("MapTileData has roleData not reachable %d,%d", self.x, self.y)
			end
			return false
		end
	end
	for _, data in ipairs(self.placeholderDatas) do
		if debug then 
			printfmt ("MapTileData has placeholderData reachable %d,%d", self.x, self.y, data:isReachable())
		end
		if not data:isReachable() then
			if debug then 
				printfmt ("MapTileData has placeholderData not reachable %d,%d", self.x, self.y)
			end
			return false
		end
	
	end
	if debug then 
		printfmt ("MapTileData is ground %d,%d", self.x, self.y)
	end
	return self:getTerrainType() == MapDefine.TerrainType.Ground
end

function MapTileData:canBeNodeOfPath(debug)
	for _, decorationData in ipairs(self.decorationDatas) do
		if not decorationData:canBeNodeOfPath() then
			return false
		end
	end
	for _, roleData in ipairs(self.roleDatas) do
		if not roleData:canBeNodeOfPath() then
			return false
		end
	end
	for _, data in ipairs(self.placeholderDatas) do
		if debug then
			print ("MapTileData has placeholderData canBeNodeOfPath", self.x, self.y, data:canBeNodeOfPath())
		end
		if not data:canBeNodeOfPath() then
			return false
		end
	end
	-- return self:getTerrainType() == MapDefine.TerrainType.Ground 
	return self:isReachable()
end

function MapTileData:canBeEndOfPath(debug)
	if self:getTerrainType() ~= MapDefine.TerrainType.Ground then 
		for _, roleData in ipairs(self.roleDatas) do
			if roleData:getCategory() == Category.TRIGGER_NPC 
				and (roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE or 
					roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE)then
				return true
			end
		end
		if(DEBUG) then
			print ("MapTileData canBeEndOfPath not ground")
		end
		return false
	end

	local canBeEndOfPath = true

	for _, decorationData in ipairs(self.decorationDatas) do
		if not decorationData:canBeEndOfPath() then
			canBeEndOfPath = false
		end
	end

	for _, roleData in ipairs(self.roleDatas) do
		if not roleData:canBeEndOfPath() then
			canBeEndOfPath = false
		end
	end

	for _, data in ipairs(self.placeholderDatas) do
		if not data:canBeEndOfPath() then
			canBeEndOfPath = false
		end
		if debug then
			print ("MapTileData has placeholderData canBeEndOfPath", self.x, self.y, data:canBeEndOfPath())
		end
	end
	-- return self:isReachable()
	return canBeEndOfPath
end

function MapTileData:hasDecoration(decorationID)
	if decorationID == nil then
		-- print ("tile has deocraion", self.x, self.y, (self.decorationDatas ~= nil and #self.decorationDatas > 0))
		if #self.decorationDatas > 0 then
			return true
		end
		for _, placeholderData in ipairs(self.placeholderDatas) do
			if placeholderData.typeName == "decoration" then
				return true
			end
		end
		return false
	else 
		for _, decorationData in ipairs(self.decorationDatas) do
			if decorationData.ID == decorationID then
				return true
			end
		end 
		return false
	end
end

function MapTileData:hasRole(type)
	if type == nil then
		return self.roleDatas ~= nil
	else 
		for _, roleData in ipairs(self.roleDatas) do
			if roleData:getType() == type then
				return true
			end
		end 
		return false
	end
end

function MapTileData:hasNPCType(npcType)
	for _, roleData in ipairs(self.roleDatas) do 
		if roleData:getCategory() == Category.TRIGGER_NPC then 
			if npcType == nil then 
				return true
			else
				if(DEBUG) then
					printf("MapTileData111 %d,%d has roledata with type %d find npcType %d", self.x,self.y, roleData:getType(), npcType)
				end
				if roleData:getType() == npcType then 
					if(DEBUG) then
						printf("MapTileData222 %d,%d has roledata with type %d find npcType %d", self.x, self.y, roleData:getType(), npcType)
					end
					return true
				end
			end
		end
	end
	return false
end

-- function MapTileData:addColor(color, opacity)
-- 	local colorData = MapEffectColorData:create(color, opacity)
-- 	lume.push(self.effectColorDatas, colorData)
-- end

-- function MapTileData:removeColor(color, opacity)
-- 	for _, colorData in ipairs(self.effectColorDatas) do
-- 		if MapHelper.c4b_equals(color, colorData:getColor()) and opacity == colorData:getOpacity() then
-- 			print ("did remove color at tile ", self.x , self.y, MapHelper.c4b_to_string(color), opacity)
-- 			lume.remove(self.effectColorDatas, colorData)
-- 		end
-- 	end
-- end

-- Accessories

function MapTileData:setTerrainType(terrainType)
	self.terrainData:setTerrainType(terrainType)
end

function MapTileData:getTerrainType()
	return self.terrainData:getTerrainType()
end

function MapTileData:setTerrainData(terrainData)
	self.terrainData = terrainData
end

function MapTileData:getTerrainData()
	return self.terrainData
end

function MapTileData:getDecorationDatas()
	return self.decorationDatas
end

function MapTileData:getPlaceholderDatas()
	return self.placeholderDatas
end

function MapTileData:getRoleDatas()
	return self.roleDatas
end

function MapTileData:getEffectColorDatas()
	return self.effectColorDatas
end

function MapTileData:getBuildingData()
	return self.buildingData
end

function MapTileData:getTownDecorationData()
	return self.townDecorationData
end

function MapTileData:setX(x)
	self.x = x
end

function MapTileData:getX()
	return self.x
end

function MapTileData:setY(y)
	self.y = y
end

function MapTileData:getY()
	return self.y
end

function MapTileData:setZ(z)
	self.z = z
end

function MapTileData:getZ()
	return self.z
end

function MapTileData:getWidth()
	return self.width
end

function MapTileData:getHeight()
	return self.height
end

function MapTileData:setReached(reached)
	self.reached = reached
end

function MapTileData:isReached()
	return self.reached
end

function MapTileData:setIsShowIcon(isShowIcon)
	self.isShowIcon = isShowIcon
end

function MapTileData:hasShowIcon()
	return self.isShowIcon
end

function MapTileData:explore()
	self.isExplored = true
end

function MapTileData:hasExplored()
	return self.isExplored
end

function MapTileData:hasUnreachableDecoration()
	for _, decorationData in ipairs(self.decorationDatas) do
		if not decorationData:isReachable() then
			return true
		end
	end
	return false
end

-- 判断是否为地面
function MapTileData:isGround()
	if self:getTerrainType() == MapDefine.TerrainType.Ground then 
		return true
	end

	return false
end



return MapTileData