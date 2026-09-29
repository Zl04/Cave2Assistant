local MapDefine = require "app.mapkit.MapDefine"
local grids = require "app.mapkit.grids"
local lume = require "thirdparty.lume"
local MapHelper = require "app.mapkit.MapHelper"

local MapData = class("MapData")
function MapData:ctor(mapConfig, appearanceConfig, title)
	self.title = title or ""
	self.level = mapConfig.level
	self.difficulty = mapConfig.difficulty
	self.sceneType = mapConfig.type
	self.randSeed =  mapConfig.randSeed
	self.width = mapConfig.width
	self.height = mapConfig.height
	self.caveMode = mapConfig.caveMode
	self.stageSeed = mapConfig.stageSeed
	self.hasChamber = (mapConfig.chamberWidth > 0 and mapConfig.chamberHeight > 0)
	self.isCopyFromTeam = mapConfig.isCopyFromTeam or false
	self.cantUpdateCheckPt = mapConfig.cantUpdateCheckPt or false  -- true为不能更新
	self.canQuickDown = mapConfig.canQuickDown or false  -- true 为能够快速下楼
	self.petMonsterLv = mapConfig.petMonsterLv or nil  -- 用于测试显示是否有宠物怪的楼层
	if(mapConfig.dreamSceneInfo) then 
		self.dreamSceneInfo = mapConfig.dreamSceneInfo or nil
	end
	

	if (self.sceneType == PublicDefine.SCENE_TYPE.TOWN 
		or self.sceneType == PublicDefine.SCENE_TYPE.GUILD
		or self.sceneType == PublicDefine.SCENE_TYPE.TOWN_CAVE 
		or self.sceneType == PublicDefine.SCENE_TYPE.MANOR
		or self.sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT) 
		and self.caveMode ~= PublicDefine.CAVE_MODE.MODE_PET then
		self.ISeeDeadPeople = true
	else
		self.ISeeDeadPeople = mapConfig.ISeeDeadPeople
	end

	printfmt("ISeeDeadPeople %s", tostring(self.ISeeDeadPeople))

	self.name = appearanceConfig.name
	self.number = appearanceConfig.number
	self.tileWidth = appearanceConfig.tileWidth
	self.tileHeight = appearanceConfig.tileHeight
	self.decorationPlist = appearanceConfig.decorationPlist
	self.appearanceConfig = appearanceConfig

	self.isSplit = appearanceConfig.isSplit
	self.splitName = appearanceConfig.splitName

	self.usedTileCount = nil

	self.tileDataMap = {} 			-- nested key value map to store tile datas
	self.effectColorDatasMap = {} 	-- nested key value map to store effect color datas of tile
	self.usedTileDatas = {} 		-- array to store used tile datas which has terrain
	self.dirtyTileDatas = {} 		-- array to store dirty tile datas which has been updated, and need to update persentation

	self.dungeonRoomDatas = nil
	-- 处理英雄模式特殊事件
	self._specialEventIds = {}
	-- 变形列表
	self._defomationArr = {}
	
	for y = 1, self.height do 
		self.tileDataMap[y] = {}
		self.effectColorDatasMap[y] = {}
	end
end

--获取难度
function MapData:getDifficulty()
	return self.difficulty
end

--模式
function MapData:getCaveMode()
	return self.caveMode
end

-- 获取场景类型
function MapData:getSceneType()
	return self.sceneType
end

-- 是否boss 场景
function MapData:isBossScene()
	if(self.sceneType == PublicDefine.SCENE_TYPE.BOSS) then 
		return true
	end

	return false
end

function MapData:setEnterCoord(enterX, enterY)
	self.enterX = enterX
	self.enterY = enterY
end

function MapData:getEnterCoord()
	if(self.enterX and self.enterY) then
		return {x = self.enterX, y = self.enterY}
	else 
		return nil
	end
end

-- 判断是否从组队复制的副本
function MapData:getIsCopyFromTeam()
	return self.isCopyFromTeam
end

-- 获取梦境当前等级
function MapData:getDreamLV()
	if(self.dreamSceneInfo) then 
		return self.dreamSceneInfo.dreamLv
	else
		return -1
	end
end

-- 获取梦境当前BOSS
function MapData:getDreamCurBossIndex()
	if(self.dreamSceneInfo) then 
		return self.dreamSceneInfo.curBossIndex + 1
	else
		return -1
	end
end

-- 获取是否可以更新存档点
function MapData:getUpdateCheckPT()
	if(self.cantUpdateCheckPt) then 
		return false
	else
		return true
	end
end

function MapData:getCanQuickDown()
	return self.canQuickDown
end

function MapData:setCanQuickDown(canQuickDown)
	print("MapData:setCanQuickDown", canQuickDown)
	self.canQuickDown = canQuickDown
end

function MapData:makeTileDirty(tileData)
	lume.push(self.dirtyTileDatas, tileData)
end

function MapData:makeTileDirtyAtCoord(x, y)
	local tileData = self:getTileDataAtCoord(x, y)
	if tileData ~= nil then
		self:makeTileDirty(tileData)
	end
end

function MapData:setTileDataAtCoord(x, y, tileData)	
	if not self:isCoordInBounds(x, y) then
		return
	end
	self.tileDataMap[y + 1][x + 1] = tileData
end

function MapData:getTileDataAtCoord(x, y)
	-- if not self:isCoordInBounds(x, y) then 
	-- 	return
	-- end
	local t = self.tileDataMap[y + 1]
	if (t == nil) then 
		return nil 
	end
	return t[x + 1]
end

function MapData:getEffectColorDatasAtCoord(x, y)
	if not self:isCoordInBounds(x, y) then
		return
	end
	return self.effectColorDatasMap[y + 1][x + 1]
end

function MapData:setChamber(entrance, connectPoint, rect)
	self.chamberRect = rect
	self.chamberEntrance = entrance
	self.chamberConnectPoint = connectPoint
end

function MapData:isCoordInChamber(x, y) 
	if self.chamberRect == nil then 
		-- printf("chamber not exist %d,%d", x, y)
		return false
	end
	return x >= self.chamberRect.x and x <= self.chamberRect.x + self.chamberRect.width - 1 and y >= self.chamberRect.y and y <= self.chamberRect.y + self.chamberRect.height - 1
end

function MapData:isCoordInBounds(x, y, reservedSize)
	return grids.isInBounds(x + 1, y + 1, self.width, self.height, reservedSize)
end        

function MapData:isCoordUsed(x, y)
	local tileData = self:getTileDataAtCoord(x, y)
	if tileData ~= nil then
		return tileData:isUsed()
	end
	return false
end

function MapData:isCoordDestructible(x, y)
	local tileData = self:getTileDataAtCoord(x, y)
	if tileData ~= nil then
		return tileData:isDestructible()
	end
	return false
end
 
function MapData:isCoordReachable(x, y)
	local tileData = self:getTileDataAtCoord(x, y)
	if tileData ~= nil then
		return tileData:isReachable()
	end
	return false
end

function MapData:isCoordGround(x, y)
	local tileData = self:getTileDataAtCoord(x, y)
	if tileData ~= nil then
		return tileData:isGround()
	end
	return false
end

function MapData:hasDecorationAtCoord(x, y, type)
	local tileData = self:getTileDataAtCoord(x, y)
	if tileData ~= nil then
		return tileData:hasDecoration(type)
	end
	return false
end 

function MapData:hasRoleAtCoord(x, y, type)
	local tileData = self:getTileDataAtCoord(x, y)
	if tileData ~= nil then
		return tileData:hasRole(type)
	end
	return false
end 

function MapData:getCoordinatesInVisionRadiusForCheckFunc(cx, cy, visionRadius, checkFunc)
	local offsets = MapHelper.getVisionRangeOffsets(visionRadius)
	return self:getCoordinatesInOffsetsForCheckFunc(cx, cy, offsets, checkFunc)
end

function MapData:getCoordinatesForDestructibleInVisionRadius(cx, cy, visionRadius)
	return self:getCoordinatesInVisionRadiusForCheckFunc(cx, cy, visionRadius, function (x, y)
		if not self:isCoordInBounds(x, y, 1) then
			return false
		end
		local tileData = self:getTileDataAtCoord(x, y)
		if tileData == nil or not tileData:isDestructible() or tileData:hasNPCType(PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE) or tileData:hasNPCType(PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE) then 
			return false
		end
		local adjacentReachableCoords = self:getCoordinatesInOffsetsForCheckFunc(x, y, MapDefine.AdjacentOffsets, function (lx, ly)
			if not self:isCoordInBounds(lx, ly) then
				return false
			end
			local ltileData = self:getTileDataAtCoord(lx, ly)
			if ltileData == nil or not ltileData:isReachable() then 
				return false
			end
			return true
		end) 
		local hasAdjacentReachable = false
		if adjacentReachableCoords ~= nil and #adjacentReachableCoords > 0 then
			hasAdjacentReachable = true
		end
		return hasAdjacentReachable
	end)
end

function MapData:getCoordinatesReachableInVisionRadius(cx, cy, visionRadius)
	return self:getCoordinatesInVisionRadiusForCheckFunc(cx, cy, visionRadius, function (x, y)
		if not self:isCoordInBounds(x, y) then
			return false
		end
		local tileData = self:getTileDataAtCoord(x, y)
		if tileData == nil or not tileData:isReachable() or tileData:hasRole(RoleType.Monster) or tileData:hasRole(PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then 
			return false
		end
		return true
	end)
end

function MapData:getCoordinatesInOffsetsForCheckFunc(cx, cy, offsets, checkFunc)
	local coords = {}
	for _, offset in ipairs(offsets) do
		local x, y = cx + offset.x, cy + offset.y
		local tileData = self:getTileDataAtCoord(x, y)
		if tileData ~= nil and (checkFunc == nil or checkFunc(x, y)) then
			lume.push(coords, {x = x, y = y})
		end
	end
	return coords
end

function MapData:getCoordinatesForTerrainWithOffsets(cx, cy, terrainType, offsets)
	local coords = {}
	for _, offset in ipairs(offsets) do
		local x, y = cx + offset.x, cy + offset.y
		local tileData = self:getTileDataAtCoord(x, y)
		if tileData ~= nil and tileData:getTerrainType() == terrainType then
			lume.push(coords, {x = x, y = y})
		end
	end
	return coords
end

function MapData:getTileCountForTerrainWithOffsets(cx, cy, terrainType, offsets)
	return #self:getCoordinatesForTerrainWithOffsets(cx, cy, terrainType, offsets)
end

function MapData:getAdjacentTerrainCountAtCoordinate(cx, cy, terrainType)
	return self:getTileCountForTerrainWithOffsets(cx, cy,  terrainType, MapDefine.AdjacentOffsets)
end

function MapData:getCornerTerrainCountAtCoordinate(cx, cy, terrainType)
	return self:getTileCountForTerrainWithOffsets(cx, cy, terrainType, MapDefine.CornerOffset)
end

function MapData:getAroundTerrainCountAtCoordinate(cx, cy, terrainType)
	return self:getTileCountForTerrainWithOffsets(cx, cy,  terrainType, MapDefine.AroundOffsets)
end

function MapData:getSize()
	return self.width, self.height
end

function MapData:getTileDataMap()
	return self.tileDataMap
end

function MapData:getLevel()
	return self.level
end

function MapData:getTitle()
	return self.title
end

function MapData:getDirtyTileDatas()
	return self.dirtyTileDatas
end

function MapData:getDungeonRoomDataAtCoordinate(cx, cy)
	if self.dungeonRoomDatas == nil then 
		return nil
	end
	for _, dungeonRoomData in ipairs(self.dungeonRoomDatas) do
		if MapHelper.boundsContainPoint(dungeonRoomData.bounds, {x = cx, y = cy}) then
			return dungeonRoomData
		end
	end
	return nil
end

function MapData:addShowMiniMapIconCoord(cx, cy)
	local titleData = self:getTileDataAtCoord(cx, cy)
	if titleData then
		titleData:setIsShowIcon(true)
	end
end

function MapData:removeShowMiniMapIconCoord(cx, cy)
	local titleData = self:getTileDataAtCoord(cx, cy)
	if titleData then
		titleData:setIsShowIcon(false)
	end
end

function MapData:isDungeonRoomReachedAtCoordinate(cx, cy)
	local dungeonRoomData = self:getDungeonRoomDataAtCoordinate(cx, cy)
	if dungeonRoomData then 
		-- printfmt("is dungeon room {%d,%d,%d,%d} reached %s", dungeonRoomData.bounds.x, dungeonRoomData.bounds.y, dungeonRoomData.bounds.width, dungeonRoomData.bounds.height, dungeonRoomData.reached)
		return dungeonRoomData.reached
	end
	return false
end

function MapData:setDungeonRoomReachedAtCoordinate(cx, cy, reached)
	local dungeonRoomData = self:getDungeonRoomDataAtCoordinate(cx, cy)
	if dungeonRoomData then 
		dungeonRoomData.reached = reached

		for y = dungeonRoomData.bounds.y, dungeonRoomData.bounds.y + dungeonRoomData.bounds.height - 1 do
			for x = dungeonRoomData.bounds.x, dungeonRoomData.bounds.x + dungeonRoomData.bounds.width - 1 do
				local tileData = self:getTileDataAtCoord(x, y)
				if tileData ~= nil and tileData:isReachable() then 
					tileData:setReached(reached)
				end
			end
		end

		-- printfmt("set dungeon room {%d,%d,%d,%d} reached", dungeonRoomData.bounds.x, dungeonRoomData.bounds.y, dungeonRoomData.bounds.width, dungeonRoomData.bounds.height)
	end
end 

function MapData:getCoordinatesReachableInRoomAtCoordinate(cx, cy)
	if self.dungeonRoomDatas == nil then 
		return nil
	end

	local coordinates = {}
	for _, dungeonRoomData in ipairs(self.dungeonRoomDatas) do
		if MapHelper.boundsContainPoint(dungeonRoomData.bounds, {x = cx, y = cy}) then
			for y = dungeonRoomData.bounds.y, dungeonRoomData.bounds.y + dungeonRoomData.bounds.height - 1 do
				for x = dungeonRoomData.bounds.x, dungeonRoomData.bounds.x + dungeonRoomData.bounds.width - 1 do
					local tileData = self:getTileDataAtCoord(x, y)
					if tileData ~= nil and tileData:isReachable() then 
						lume.push(coordinates, {x = x, y = y})
					end
				end
			end
		end
	end
	return coordinates
end

-- 获取变形事件列表
function MapData:getDeformationArr()
	return self._defomationArr
end

function MapData:getSpecialEventIDArr()
	return self._specialEventIds
end

-- 
function MapData:getHaveSpecialEventDeformation()
	if(self._specialEventDeformation) then 
		return true
	else  
		return false
	end
end

function MapData:handleSpecialEvent(heroCaveActionIDs)
	self._specialEventDeformation = false
	if(heroCaveActionIDs) then 
		local allSpecialEventArr = require("profiles/commonProfile/ProfileSpecialEventID")

		for _,eventID in ipairs(heroCaveActionIDs) do 
			local specialEventData = allSpecialEventArr[eventID]
			if specialEventData.Type == PublicDefine.SPECIAL_EVENT_TYPE.SPECIAL_EVENT_TYPE_DEFORMATION then 
				-- if specialEventData.eventFloor ~= "" then 
				-- 	local typeArr = string.split(specialEventData.eventFloor,";")
				-- end

				if #specialEventData.value1 == #specialEventData.value2 then 
					self._specialEventDeformation = true
					for key,value in ipairs(specialEventData.value1) do 
						self._defomationArr[tonumber(value)] = tonumber(specialEventData.value2[key])
					end
				end
			end

			table.insert(self._specialEventIds, eventID)
		end
	end
end

function MapData:handleHeroCaveSchemeIDs(heroCaveSchemeIDs)
	self._heroCaveSchemeIDs = heroCaveSchemeIDs
end

function MapData:getHeroCaveSchemeIDS()
	return self._heroCaveSchemeIDs
end

function MapData:handleTitanHeroCaveSchemeIDs(heroCaveSchemeIDs)
	self._titanHeroCaveSchemeIDs = heroCaveSchemeIDs
end

function MapData:getTitanHeroCaveSchemeIDS()
	return self._titanHeroCaveSchemeIDs
end

function MapData:getNumber()
	return self.number
end

function MapData:setUsedTileCount(count)
	self.usedTileCount = count
end

function MapData:getUsedTileCount()
	return self.usedTileCount
end

return MapData
