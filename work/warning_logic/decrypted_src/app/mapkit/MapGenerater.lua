local gridsModule = require "app.mapkit.grids"
local MapDefine = require "app.mapkit.MapDefine"
local MapHelper = require "app.mapkit.MapHelper"
local swapGrids = gridsModule.swap
local makeGrids = gridsModule.make
local setGrids = gridsModule.set
local printGrids = gridsModule.print
local lume = require "thirdparty.lume"

local use_custom_random = true
local MAP_INVALID_COORD = PublicDefine.CONST_DEFINITION.MAP_INVALID_COORD

local _M = {}
local groundCoords = {}

local isInBounds = function (x, y, bounds)
	return x >= bounds.x and x < bounds.x + bounds.width and y >= bounds.y and y < bounds.y + bounds.height
end

local adjustCoordInBounds = function (x, y, bounds)
	if isInBounds(x, y, bounds) then
		return x, y
	end

	if x < bounds.x then
		x = bounds.x
	end
	if x >= bounds.x + bounds.width then
		x = bounds.x + bounds.width - 1
	end
	if y < bounds.y then
		y = bounds.y
	end
	if y > bounds.height then
		y = bounds.y + bounds.height - 1
	end
	return x, y
end

local function rectContainsPoint(rect, point) 
	return point.x >= rect.x and point.x <= rect.x + rect.width - 1 and point.y >= rect.y and point.y <= rect.y + rect.height - 1
end 

local tileBrush = {
	x = 0,
	y = 0,
	dir = "N",
	boundsX = 0,
	boundsY = 0,
	boundsWidth = 0,
	boundsHeight = 0,
	isWE = function (self) return self.dir == "W" or self.dir == "E" end,
	isNS = function (self) return self.dir == "N" or self.dir == "S" end,
	isInReservedRects = function (self, _x, _y) 
		if self.reservedRects == nil then 
			return false
		end
		for _, reservedRect in ipairs(self.reservedRects) do 
			local borderReserve = 1
			local rect = {x = reservedRect.x - borderReserve, y = reservedRect.y - borderReserve,
			width = reservedRect.width + 2 * borderReserve, height = reservedRect.height + 2 * borderReserve}
			if rectContainsPoint(rect, {x = _x, y = _y}) then
				return true
			end
		end
		return false
	end,
	turn = function (self)
		if self:isNS() then 
			self.dir = _M.random(0, 1) == 0 and "W" or "E"
			if self.dir == "W" then
				if self.x > self.boundsX and not self:isInReservedRects(self.x - 1, self.y) then
					self.x = self.x - 1
					return true
				end 
			else 
				if self.x < self.boundsX + self.boundsWidth - 1 and not self:isInReservedRects(self.x + 1, self.y)then
					self.x = self.x + 1
					return true
				end
			end
		else
			self.dir = _M.random(0, 1) == 0 and "S" or "N"
			if self.dir == "S" then
				if self.y > self.boundsY and not self:isInReservedRects(self.x, self.y - 1) then
					self.y = self.y - 1
					return true
				end
			else
				if self.y < self.boundsY + self.boundsHeight - 1 and not self:isInReservedRects( self.x, self.y + 1) then
					self.y = self.y + 1
					return true
				end
			end
		end
		-- printfmt("brush turn to %s,%d,%d", self.dir, self.x, self.y)
		return false
	end,
	walk = function (self)
		if self.dir == "N" then
			if self.y < self.boundsY + self.boundsHeight - 1 and not self:isInReservedRects(self.x, self.y + 1) then
				self.y = self.y + 1
				return true
			end 
		elseif self.dir == "E" then
			if self.x < self.boundsX + self.boundsWidth - 1 and not self:isInReservedRects(self.x + 1, self.y) then
				self.x = self.x + 1
				return true
			end
		elseif self.dir == "S" then
			if self.y > self.boundsY and not self:isInReservedRects(self.x, self.y - 1) then
				self.y = self.y - 1
				return true
			end 
		else -- if self.dir == "W" then
			if self.x > self.boundsX and not self:isInReservedRects(self.x - 1, self.y) then
				self.x = self.x - 1
				return true
			end
		end
		-- printfmt("brush walk to %s,%d,%d", self.dir, self.x, self.y)
		return false
	end
}

local function calculateIndex(x, y, width)
	return y * width + x
end

local function makePath(grids, start, bounds, stepCount, basicTurnChance, increasingTurnChance, reservedRects, roomGroundCoords)
	local path = {}

	local directions = {"N", "E", "S", "W"}
	tileBrush.dir = directions[_M.random(0, #directions - 1) + 1]
	tileBrush.x = start.x
	tileBrush.y = start.y
	tileBrush.boundsX = bounds.x
	tileBrush.boundsY = bounds.y
	tileBrush.boundsWidth = bounds.width
	tileBrush.boundsHeight = bounds.height
	tileBrush.reservedRects = reservedRects

	local function makeGround(x, y) 
		if grids[y + 1][x + 1] == 0 then
			return
		end

		local coord = {x = x, y = y}
		path[#path + 1] = coord
		
		grids[y + 1][x + 1] = 0;

		if roomGroundCoords ~= nil and type(roomGroundCoords) == "table" then 
			lume.push(roomGroundCoords, coord)
		else 
			lume.push(groundCoords, coord)
		end
	end

	-- printfmt("generate ground at %d,%d", tileBrush.x, tileBrush.y)
	makeGround(tileBrush.x, tileBrush.y)

	local madeStraightCount = 0
	for i = 1, stepCount do
		local chance = _M.random(99)
		local turnChance = basicTurnChance + madeStraightCount * increasingTurnChance
		if turnChance > 95 then
			turnChance = 95
		end

		local moved = false
		if chance < turnChance then
			-- turn
			moved = tileBrush:turn()
			madeStraightCount = 0;
		else 
			moved = tileBrush:walk()
			madeStraightCount = madeStraightCount + 1;
		end
		
		if moved then
			-- printfmt("generate ground at %d,%d", tileBrush.x, tileBrush.y)
			makeGround(tileBrush.x, tileBrush.y)
		end
	end
	return path
end

local function makeWall(grids, x, y, bounds)
	if isInBounds(x, y, bounds) and grids[y + 1][x + 1] == -1 then
		grids[y + 1][x + 1] = 1
	end
end

local function makeAdjacentWalls(grids, x, y, bounds)
	makeWall(grids,x, y + 1, bounds)
	makeWall(grids,x + 1, y + 1, bounds)
	makeWall(grids,x + 1, y, bounds)
	makeWall(grids,x + 1, y - 1, bounds)
	makeWall(grids,x, y - 1, bounds)
	makeWall(grids,x - 1, y - 1, bounds)
	makeWall(grids,x - 1, y, bounds)
	makeWall(grids,x - 1, y + 1, bounds)
end

local function getRandomCoord(bounds)
	local x = _M.random(bounds.x, bounds.x + bounds.width - 1)
	local y = _M.random(bounds.y, bounds.y + bounds.height - 1)
	-- local i = 0
	-- if i == 0 then
		-- printfmt("get random coord %d,%d in bounds %d,%d,%d,%d", x, y, bounds.x, bounds.y, bounds.width, bounds.height)
	-- 	i = 1
	-- end
	return x, y
end

local function getRandomRect(bounds, size)
	local x, y = MAP_INVALID_COORD, MAP_INVALID_COORD
	local count = bounds.width * bounds.height
	for i = 1, count do
		if rectContainsPoint(bounds, {x = x, y = y}) and rectContainsPoint(bounds, {x = x + size.width - 1, y = y + size.height - 1}) then 
			return {x = x, y = y, width = size.width, height = size.height}
		end
		x, y = getRandomCoord(bounds)

	end
end

local function getRandomConnnectPointsToRect(rect)
	local entrance, connectPoint = nil, nil
	local x, y = 0, 0
	local dir = _M.random(MapDefine.DirectionType.North, MapDefine.DirectionType.West)
	if dir == MapDefine.DirectionType.North then
		x = _M.random(rect.x + 1, rect.x + rect.width - 2)
		y = rect.y + rect.height - 1
		entrance = {x = x, y = y + 1}
	elseif dir == MapDefine.DirectionType.East then
		x = rect.x + rect.width - 1
		y = _M.random(rect.y + 1, rect.y + rect.height - 2)
		entrance = {x = x + 1, y = y}
	elseif dir == MapDefine.DirectionType.South then
		x = _M.random(rect.x + 1, rect.x + rect.width - 2)
		y = rect.y
		entrance = {x = x, y = y - 1}
	else
		x = rect.x
		y = _M.random(rect.y + 1, rect.y + rect.height - 2)
		entrance = {x = x - 1, y = y}
	end
	connectPoint = {x = x, y = y}
	return entrance, connectPoint
end

local function getConnnectPointsToChamberRect(bounds, rect)
	local entrance, connectPoint = nil, nil
	
	local dirs = {MapDefine.DirectionType.North, MapDefine.DirectionType.East,MapDefine.DirectionType.South,MapDefine.DirectionType.West}
	local swapIdx = _M.random(MapDefine.DirectionType.East,MapDefine.DirectionType.West) + 1

	dirs[1],dirs[swapIdx] = dirs[swapIdx],dirs[1]

	-- dump(dirs)
	local x, y = 0, 0
	for i,dir in ipairs(dirs) do
		
	-- for i = MapDefine.DirectionType.North, MapDefine.DirectionType.West do
		-- local dir = i
		if dir == MapDefine.DirectionType.North then
			x = rect.x + rect.width / 2
			y = rect.y + rect.height - 1
			if y + 2 <= bounds.y + bounds.height - 1 then 
				entrance = {x = x, y = y + 1}
				connectPoint = {x = x, y = y}
				return entrance, connectPoint
			end
		elseif dir == MapDefine.DirectionType.East then
			x = rect.x + rect.width - 1
			y = rect.y + rect.height / 2
			if x + 2 <= bounds.x + bounds.width - 1 then 
				entrance = {x = x + 1, y = y}
				connectPoint = {x = x, y = y}
				return entrance, connectPoint
			end
		elseif dir == MapDefine.DirectionType.South then
			x = rect.x + rect.width / 2
			y = rect.y
			if y - 2 >= bounds.y then 
				entrance = {x = x, y = y - 1}
				connectPoint = {x = x, y = y}
				return entrance, connectPoint
			end
		else
			x = rect.x
			y = rect.y + rect.height / 2
			if x - 2 >= bounds.x then 
				entrance = {x = x - 1, y = y}
				connectPoint = {x = x, y = y}
				return entrance, connectPoint
			end
		end
	end
	return entrance, connectPoint
end

-- generate map in path walk way
function _M.setRandomSeed(seed)
	_M.__seed = seed
	lume.clear(groundCoords)
	if use_custom_random then
		if _M.randomGenerater then
			_M.randomGenerater:delete()
			_M.randomGenerater = nil
		end

		_M.randomGenerater = Avalon.RandomGenerater:new(seed)
	else 
		math.randomseed(seed)
	end
end

function _M.random(a, b)
	local value = nil;
		if use_custom_random then
			if b == nil then
				value = _M.randomGenerater:random(0, a)
			else 
				value =  _M.randomGenerater:random(a, b)
			end
		else 
			if b == nil then
				value =  math.random(a)
			else
				value =  math.random(a, b) 
			end
		end
	-- print(debug.traceback( ))
	-- print("seed",_M.__seed,"value",value,a,b)
	return value
end

function _M.generatePathWalk(config, grids, x, y, generateRandomRoom)
	local width = config.width or 0
	local height = config.height or 0
	x = x or 0
	y = y or 0
	local roomGroundCoords = generateRandomRoom and {} or nil

	local mapBounds = {x = x, y = y, width = width, height = height}
	grids = grids or makeGrids(width, height, -1)
	-- dump(config)

	local pathBounds = nil 
	-- if generateRandomRoom then 
	-- 	pathBounds = mapBounds
	-- else 
		local wallReserved = 1
		local borderResrved = 1
		local reservedSizeInBounds = wallReserved + borderResrved
		pathBounds = { x = x + reservedSizeInBounds, y = y + reservedSizeInBounds, width = width - reservedSizeInBounds * 2, height = height - reservedSizeInBounds * 2}
	-- end 

	local reservedRects = {}
	local startX, startY = MAP_INVALID_COORD, MAP_INVALID_COORD
	if config.chamberWidth ~= nil and config.chamberWidth > 0 and config.chamberHeight ~= nil and config.chamberHeight > 0 then 
		local size = {width = config.chamberWidth, height = config.chamberHeight}
		local chamberRect = getRandomRect(pathBounds, size)
		-- printfmt("chamberRect %s", tostring(chamberRect))
		if chamberRect ~= nil then
			local entrance, connectPoint = getConnnectPointsToChamberRect(pathBounds, chamberRect)
			if entrance ~= nil and connectPoint ~= nil then
				if entrance.x < connectPoint.x then 
					startX = entrance.x - 1
					startY = entrance.y
				elseif entrance.x > connectPoint.x then 
					startX = entrance.x + 1
					startY = entrance.y
				elseif entrance.y < connectPoint.y then 
					startX = entrance.x
					startY = entrance.y - 1
				elseif entrance.y > connectPoint.y then 
					startX = entrance.x
					startY = entrance.y + 1
				end
				lume.push(reservedRects, chamberRect)
			end
			-- dump(entrance)
			-- dump(connectPoint)
		end
		
	end
	-- dump(config)
	local pathCount = _M.random(config.minPathCount, config.maxPathCount)
	local sx, sy = 0, 0
	for i = 1, pathCount do
		if i == 1 then
			if startX ~= MAP_INVALID_COORD and startY ~= MAP_INVALID_COORD then
				sx, sy = startX, startY
			else 
				sx, sy = getRandomCoord(pathBounds);
				-- printfmt("generate path start %d,%d", sx, sy)
			end 
		else
			local coord = nil
			if roomGroundCoords ~= nil then 
				local groundCoordsCount = #roomGroundCoords
				local randIndex = _M.random(1, groundCoordsCount)
				coord = roomGroundCoords[randIndex]
				-- printfmt("get new path start %d,%d in coord count %d", coord.x, coord.y, groundCoordsCount)
			else 
				local groundCoordsCount = #groundCoords
				local randIndex = _M.random(1, groundCoordsCount)
				coord = groundCoords[randIndex]
				-- printfmt("get new path start %d,%d in coord count %d", coord.x, coord.y, groundCoordsCount)
			end
			if coord ~= nil then
				sx, sy = coord.x, coord.y
			end
			
		end
		local stepCount = _M.random(config.stepMinPerPath, config.stepMaxPerPath)
		makePath(grids, {x = sx, y = sy}, pathBounds, stepCount, config.basicTurnChancePerStep, config.increasingTurnChancePerStep, reservedRects, roomGroundCoords)

	end

	-- print ("map bounds", mapBounds.x, mapBounds.y, mapBounds.width, mapBounds.height)
	if roomGroundCoords ~= nil then 
		for _, coord in ipairs(roomGroundCoords) do
			makeAdjacentWalls(grids, coord.x, coord.y, mapBounds);	
		end
	else
		for _, coord in ipairs(groundCoords) do
			makeAdjacentWalls(grids, coord.x, coord.y, mapBounds);	
		end
	end

	-- add by zp 打印地图信息
	-- local mapStr = ""
	-- for y = height - 1, 0, -1 do 
	-- 	for x = 0, width - 1, 1 do
	-- 		if grids[y+1][x+1] ~=0 then 
	-- 			mapStr = mapStr .. "*"
	-- 		else
	-- 			mapStr = mapStr .. "."
	-- 		end
	-- 	end
	-- 	mapStr = mapStr .. "\n"
	-- end
	-- printfmt("generatePathWalk  grids:\n%s", mapStr)
	

	local countX = 0
	local countY = 0
	for y = 0, height - 1, 1 do 
		for x = width - 1, 0, -1 do
			if grids[y+1][x+1] ~= -1 then 
				if y > countY then
					countY = y
				end
				if x > countX then
					countX = x
				end
			end
		end
	end
	local countXY = {x = countX+1, y = countY+1}
	grids.countXY = countXY
	return grids
end

local dungeonMonsterSpawnConfig = (require "Resource/profiles/commonProfile/ProfileDungeonMonsterSpawn")[1]
local dungeonConfigs = require "Resource/profiles/commonProfile/ProfileDungeon"
local dungeonRoomConfigs = require "Resource/profiles/commonProfile/ProfileDungeonRoom"
local configMapConfigs = require "Resource/profiles/commonProfile/ProfileConfigMap"
local terrainConfigs = require "Resource/profiles/commonProfile/ProfileTerrain"
local randomMapConfigs = require "Resource/profiles/commonProfile/ProfileRandomMap"
local storyConfigs 		= require("Resource/profiles/commonProfile/ProfileStory")

local MaxDungeonLevel = tonumber(ConfigManager:getGeneralForKey("maxDungeonLevel"))

local function adjustDungeonLevel(dungeonLevel, sceneType)
	local adjustedLevel = dungeonLevel
	if adjustedLevel > MaxDungeonLevel then 
		printfmt("dungeon level %d is greater than max level %d, use max to load configs", adjustedLevel, MaxDungeonLevel)
		local stage = math.floor((MaxDungeonLevel - 1) / 5) + 1
		if sceneType == PublicDefine.SCENE_TYPE.CAVE then 
			adjustedLevel = (stage - 1) * 5 + 1
		else 
			adjustedLevel = stage * 5
		end
		printfmt("adjustDungeonLevel %d to level %d ", dungeonLevel, adjustedLevel)
	end
	return adjustedLevel
end
_M.adjustDungeonLevel = adjustDungeonLevel

local function parseDungeonConfig(dungeonConfig, mapConfig) 
	local teamCoeffient = 1
	if mapConfig.gameMode == PublicDefine.CAVE_MODE.MODE_TEAM then 
		teamCoeffient = 3
	end

	local roomIDGroups = MapHelper.parseNumberGroupsString(dungeonConfig.roomID)
	if roomIDGroups == nil then 
		return nil
	end
	local roomWeightGroups = MapHelper.parseNumberGroupsString(dungeonConfig.roomWeight)
	if roomWeightGroups == nil then 
		return nil
	end
	local roomIDGroup = roomIDGroups[teamCoeffient]
	local roomWeightGroup = roomWeightGroups[teamCoeffient]
	if roomIDGroup == nil or roomWeightGroup == nil then 
		return nil
	end
	local newDungeonConfig = {width = dungeonConfig.width, height = dungeonConfig.height, roomUnitWidth = dungeonConfig.roomUnitWidth, roomUnitHeight = dungeonConfig.roomUnitHeight}
	newDungeonConfig.roomConfigs = {}
	newDungeonConfig.roomWeightMax = 0
	for i, roomID in ipairs(roomIDGroup) do 
		if i <= #roomWeightGroup then 
			local roomConfig = {}
			roomConfig.roomID = roomID
			roomConfig.weight = roomWeightGroup[i]
			roomConfig.weightRangeStart = newDungeonConfig.roomWeightMax
			roomConfig.weightRangeEnd = roomConfig.weightRangeStart + roomConfig.weight
			lume.push(newDungeonConfig.roomConfigs, roomConfig)

			newDungeonConfig.roomWeightMax = roomConfig.weightRangeEnd
		end
	end
	if teamCoeffient <= #dungeonConfig.roomNumMin then
		newDungeonConfig.roomNumMin = dungeonConfig.roomNumMin[teamCoeffient]
	end
	if teamCoeffient <= #dungeonConfig.roomNumMax then
		newDungeonConfig.roomNumMax = dungeonConfig.roomNumMax[teamCoeffient]
	end

	local shopRoomIDGroups = MapHelper.parseNumberGroupsString(dungeonConfig.shopRoomID)
	if teamCoeffient <= #shopRoomIDGroups then
		newDungeonConfig.shopRoomIDs = shopRoomIDGroups[teamCoeffient]
	end
	if teamCoeffient <= #dungeonConfig.shopRoomNumMin then
		newDungeonConfig.shopRoomNumMin = dungeonConfig.shopRoomNumMin[teamCoeffient]
	end
	if teamCoeffient <= #dungeonConfig.shopRoomNumMax then
		newDungeonConfig.shopRoomNumMax = dungeonConfig.shopRoomNumMax[teamCoeffient]
	end
	local potRoomIDGroups = MapHelper.parseNumberGroupsString(dungeonConfig.potRoomID)
	if teamCoeffient <= #potRoomIDGroups then
		newDungeonConfig.potRoomIDs = potRoomIDGroups[teamCoeffient]
	end
	if teamCoeffient <= #dungeonConfig.potRoomNumMin then
		newDungeonConfig.potRoomNumMin = dungeonConfig.potRoomNumMin[teamCoeffient]
	end
	if teamCoeffient <= #dungeonConfig.potRoomNumMax then
		newDungeonConfig.potRoomNumMax = dungeonConfig.potRoomNumMax[teamCoeffient]
	end

	newDungeonConfig.mapAppearanceIDs = dungeonConfig.mapAppearanceID

	return newDungeonConfig
end
_M.parseDungeonConfig = parseDungeonConfig

function _M.generateDungeon(dungeonConfig, config)
	dungeonConfig = parseDungeonConfig(dungeonConfig, config)

	local roomUnitSizeX = math.floor(dungeonConfig.width / dungeonConfig.roomUnitWidth)
	local roomUnitSizeY = math.floor(dungeonConfig.height / dungeonConfig.roomUnitHeight)
	local roomUnitNum = roomUnitSizeX * roomUnitSizeY
	if dungeonConfig.roomNumMax > roomUnitNum then 
		printfmt("dungeon config room number max %d cann't larger than real generating room num %d", dungeonConfig.roomNumMax, roomUnitNum)
		-- return nil
		dungeonConfig.roomNumMax = roomUnitNum
	end
	local roomNum = _M.random(dungeonConfig.roomNumMin, dungeonConfig.roomNumMax)
	local unitMap = {}
	for i = 0, roomUnitNum - 1 do
		unitMap[i] = -1
	end

	local adjacentOffsets = MapDefine.AdjacentOffsets

	local function getNextUnitIndex(unitIndex) 
		local unitX = math.floor(unitIndex % roomUnitSizeX)
		local unitY = math.floor(unitIndex / roomUnitSizeX)
		local offset = adjacentOffsets[_M.random(1, #adjacentOffsets)]
		if unitX + offset.x >= 0 and unitX + offset.x < roomUnitSizeX then 
			unitX = unitX + offset.x
		end
		if unitY + offset.y >= 0 and unitY + offset.y < roomUnitSizeY then 
			unitY = unitY + offset.y
		end
		return unitY * roomUnitSizeX + unitX
	end  	

	local shopRoomNum = _M.random(dungeonConfig.shopRoomNumMin, dungeonConfig.shopRoomNumMax)
	local potRoomNum = _M.random(dungeonConfig.potRoomNumMin, dungeonConfig.potRoomNumMax)
	if roomNum < shopRoomNum + potRoomNum then 
		error("generating dungeon room num must bre greater than or equal to shop and pot total num")
		return 
	end

	local shopRoomIDs = dungeonConfig.shopRoomIDs
	local potRoomIDs = dungeonConfig.potRoomIDs

	local unitIndex = _M.random(0, roomUnitNum - 1)
	while roomNum > 0 do
		if unitMap[unitIndex] == -1 then 
			roomNum = roomNum - 1
			if shopRoomNum > 0 and #shopRoomIDs > 0 then 
				shopRoomNum = shopRoomNum - 1
				unitMap[unitIndex] = shopRoomIDs[_M.random(1, #shopRoomIDs)]
			elseif potRoomNum > 0 and #potRoomIDs > 0 then 
				potRoomNum = potRoomNum - 1
				unitMap[unitIndex] = potRoomIDs[_M.random(1, #potRoomIDs)]
			else
				unitMap[unitIndex] = 0
			end

			-- printfmt("make room %d at index %d", unitMap[unitIndex], unitIndex)
		end
		unitIndex = getNextUnitIndex(unitIndex)
	end 

	-- local mapStr = ""
	-- for y = roomUnitSizeY - 1, 0, -1 do 
	-- 	for x = 0, roomUnitSizeX - 1, 1 do
	-- 		local unitIndex = y * roomUnitSizeX + x
	-- 		if unitMap[unitIndex] == -1 then 
	-- 			mapStr = mapStr .. "*"
	-- 		else
	-- 			mapStr = mapStr .. "."
	-- 		end
	-- 	end
	-- 	mapStr = mapStr .. "\n"
	-- end
	-- printfmt("unitmap:\n%s", mapStr)

	local dungeonRoomDatas = {}
	local grids = makeGrids(dungeonConfig.width, dungeonConfig.height, -1)
	for i = 0, roomUnitNum - 1 do
		if unitMap[i] ~= -1 then 
			local unitX = math.floor(i % roomUnitSizeX)
			local unitY = math.floor(i / roomUnitSizeX)
			local x = unitX * dungeonConfig.roomUnitWidth
			local y = unitY * dungeonConfig.roomUnitHeight

			local randWeight = _M.random(0, dungeonConfig.roomWeightMax - 1)
			local roomID = 0
			roomID = unitMap[i]
			if roomID == 0 then
				for _, roomConfig in ipairs(dungeonConfig.roomConfigs) do 
					if randWeight >= roomConfig.weightRangeStart and randWeight < roomConfig.weightRangeEnd then 
						roomID = roomConfig.roomID
						break
					end
				end
			end 
			if roomID > 0 then 
				local dungeonRoomConfig = dungeonRoomConfigs[roomID]
				if dungeonRoomConfig ~= nil then 
					if dungeonRoomConfig.type == PublicDefine.DUNGEON_ROOM_TYPE.ROOM_RANDOM then
						-- generate random room
						local randomMapID = dungeonRoomConfig.mapID
						if randomMapID ~= nil and randomMapConfigs[randomMapID] ~= nil then
							-- printfmt("generate random map %d at unitCoord %d,%d coord %d,%d", randomMapID, unitX, unitY, x, y)
							local randomMapConfig = randomMapConfigs[randomMapID]
							_M.generatePathWalk(randomMapConfig, grids, x, y, true)

							lume.push(dungeonRoomDatas, {bounds = {x = x, y = y, width = randomMapConfig.width, height = randomMapConfig.height}, mapID = randomMapID, isRandom = true, reached = false, roomConfig = dungeonRoomConfig})
						else 
							error("random map ID {} invalid", randomMapID)
						end
					else
						-- generate config room
						local configMapID = dungeonRoomConfig.mapID
						local configMapConfig = configMapConfigs[configMapID]
						if configMapConfig ~= nil then
							-- printfmt("generate config map %d at unitCoord %d,%d coord %d,%d", configMapID, unitX, unitY, x, y)
							if dungeonConfig.roomUnitWidth >= configMapConfig.width + 1 then 
								x = x + _M.random(0, dungeonConfig.roomUnitWidth - configMapConfig.width - 1)
							end
							if dungeonConfig.roomUnitHeight >= configMapConfig.height + 1 then 
								y = y + _M.random(0, dungeonConfig.roomUnitHeight - configMapConfig.height - 1)
							end
							_M.generateForMapConfig(configMapID, grids, dungeonConfig.width, dungeonConfig.height, x, y)

							lume.push(dungeonRoomDatas, {bounds = {x = x, y = y, width = configMapConfig.width, height = configMapConfig.height}, mapID = configMapID, isRandom = false, reached = false, roomConfig = dungeonRoomConfig})
						end 
					end
				end
				
			end
		end
	end
	return grids, dungeonRoomDatas
end

function _M.generateTownOrGuild(config)
	local width = config.width or 0
	local height = config.height or 0

	local grids = makeGrids(width, height, 1)
	return _M.generateForMapConfig(config.level, grids, width, height)
end

function _M.generatePetPVP(config)
	local width = config.width or 0
	local height = config.height or 0

	local grids = makeGrids(width, height, -1)
	return _M.generateForMapConfig(config.level, grids, width, height)
end

function _M.generateStoryMap(config)
	local width = config.width or 0
	local height = config.height or 0

	local grids = makeGrids(width, height, 1)
	return _M.generateStoryMapByConfig(config.level, grids, width, height)
end

function _M.generateStoryMapByConfig(configMapID, grids, width, height, offsetX, offsetY)
	local ox = offsetX or 0
	local oy = offsetY or 0
	-- dump(storyConfigs[configMapID])
	if configMapID ~= nil and storyConfigs[configMapID] ~= nil then
		-- printfmt("generate config map ID %d with size %d,%d at offset %d,%d", configMapID, width, height, ox, oy)
		local terrainID = storyConfigs[configMapID]["mapID"]
		local mapAppearanceID = storyConfigs[configMapID]["mapAppearanceID"]
		-- print("terrainID",terrainID)
		if terrainID ~= nil and terrainConfigs[terrainID] ~= nil then
			-- printfmt("generate terrain ID %d with size %d,%d at offset %d,%d", terrainID, width, height, ox, oy)
			local terrainString = terrainConfigs[terrainID]["terrainString"]
			if terrainString ~= nil and #terrainString > 0 then
				-- printfmt("generateForTerrainString for config map %d terrain %d:\n%s", configMapID, terrainID, terrainString)
				return _M.generateForTerrainString(terrainString, grids, width, height, offsetX, offsetY),configMapID, mapAppearanceID
			end
		else 
			-- printfmt("invalid terrain ID %d", terrainID);
			local err = string.format("invalid terrain ID %d", terrainID)
			-- error(err);
			printError(err)
		end
		
	else
		printfmt("invalid config map ID %d", configMapID);
	end
end
function _M.generateConfigMap(config, configMapID)
	local width = config.width or 0
	local height = config.height or 0

	local grids = makeGrids(width, height, -1)
	if(configMapID == nil) then
		configMapID = config.level
	end
	local mapAppearanceID = 0
	-- 小黑屋
	if config.caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON and config.type ~= PublicDefine.SCENE_TYPE.BLACK_HOUSE then 
		-- local dungeonLevel = adjustDungeonLevel(config.level, config.type)
		-- local dungeonConfig = dungeonConfigs[dungeonLevel]
		-- if dungeonConfig == nil then 
		-- 	local errstr = string.format("no dungeon config for level %d", dungeonLevel)
		-- 	error(errstr)
		-- end
		-- dungeonConfig = parseDungeonConfig(dungeonConfig, config)

		if dungeonMonsterSpawnConfig.bossFloorID ~= nil and #dungeonMonsterSpawnConfig.bossFloorID > 0 then 
			local index = _M.random(1, #dungeonMonsterSpawnConfig.bossFloorID)
			configMapID = dungeonMonsterSpawnConfig.bossFloorID[index]
			if dungeonMonsterSpawnConfig.bossFloorMapApearanceID ~= nil and index <= #dungeonMonsterSpawnConfig.bossFloorMapApearanceID then
				mapAppearanceID = dungeonMonsterSpawnConfig.bossFloorMapApearanceID[index] 
			end
		end
	end
	-- printfmt("generate config map %d map appearance ID %d", configMapID, mapAppearanceID)
	return _M.generateForMapConfig(configMapID, grids, width, height), configMapID, mapAppearanceID
end

function _M.generateForMapConfig(configMapID, grids, width, height, offsetX, offsetY)
	local ox = offsetX or 0
	local oy = offsetY or 0
	if configMapID ~= nil and configMapConfigs[configMapID] ~= nil then
		-- printfmt("generate config map ID %d with size %d,%d at offset %d,%d", configMapID, width, height, ox, oy)
		local terrainID = configMapConfigs[configMapID]["terrainID"]
		if terrainID ~= nil and terrainConfigs[terrainID] ~= nil then
			-- printfmt("generate terrain ID %d with size %d,%d at offset %d,%d", terrainID, width, height, ox, oy)
			local terrainString = terrainConfigs[terrainID]["terrainString"]
			if terrainString ~= nil and #terrainString > 0 then
				-- printfmt("generateForTerrainString for config map %d terrain %d:\n%s", configMapID, terrainID, terrainString)
				return _M.generateForTerrainString(terrainString, grids, width, height, offsetX, offsetY)
			end
		else 
			-- printfmt("invalid terrain ID %d", terrainID);
			local err = string.format("invalid terrain ID %d", terrainID)
			error(err);
		end
	else
		printfmt("invalid config map ID %d", configMapID);
	end
end

function _M.generateForTerrainString(terrainString, grids, width, height, offsetX, offsetY)
	assert(terrainString ~= nil, "should generate with valid terrain string")
	-- if grids == nil then 
		-- grids = makeGrids(width, height, -1)
	-- end

	local ox = offsetX or 0
	local oy = offsetY or 0
			
	local terrainRows = terrainString:split("\n")
	local rowCount = #terrainRows
	for y = 1, rowCount do
		local terrainRow = terrainRows[y]
		local columnCount = #terrainRow
		for x = 1, columnCount do
			local c = terrainRow:sub(x, x)
			if c == "x" or c == "1" then
				setGrids(grids, x + ox, y + oy, width, height, 1)
			elseif c == "." or c == "0" then
				setGrids(grids, x + ox, y + oy, width, height, 0)
				lume.push(groundCoords, {x = x - 1 + ox, y = y - 1 + oy})
			end
		end
	end
	return grids
end

return _M
