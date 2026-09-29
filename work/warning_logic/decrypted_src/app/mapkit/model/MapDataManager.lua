local MapGenerater = require "app.mapkit.MapGenerater"
local MapDefine = require "app.mapkit.MapDefine"
local MapHelper = require "app.mapkit.MapHelper"
local MapData = require "app.mapkit.model.MapData"
local MapTileData = require "app.mapkit.model.MapTileData"
local MapTerrainData = require "app.mapkit.model.MapTerrainData"
local MapDecorationData = require "app.mapkit.model.MapDecorationData"
local MapPlaceholderData = require "app.mapkit.model.MapPlaceholderData"
local MapEffectColorData = require "app.mapkit.model.MapEffectColorData"
local MapGen = require "app.mapkit.MapGenerater"

local grids = require "app.mapkit.grids"

local lume = require "thirdparty.lume"
local Grid = require "thirdparty.jumper.grid"
local Pathfinder = require "thirdparty.jumper.pathfinder"
local map_random = MapGenerater.random
require "app.datas.PublicDefine"
local MonsterSubType = PublicDefine.MonsterSubType
-- local map_random = math.random
require "app.mapkit.tostring"

local MapDataManager = class("MapDataManager")

-- Generation Restriction

local function createGenerationRestrictionGridForMap(mapWidth, mapHeight, generationRestrictionConfig)
	local gridWidth = math.ceil(mapWidth / generationRestrictionConfig.gridUnitWidth)
	local gridHeight = math.ceil(mapHeight / generationRestrictionConfig.gridUnitHeight)
	local grid = grids.make(gridWidth, gridHeight, 0)
	grid.width = gridWidth
	grid.height = gridHeight
	grid.maxCountPerUnit = generationRestrictionConfig.maxCountPerGridUnit
	grid.unitWidth = generationRestrictionConfig.gridUnitWidth
	grid.unitHeight = generationRestrictionConfig.gridUnitHeight

	grid.getGridCoord = function (grid, coordX, coordY)
		local gridX = math.floor(coordX / grid.unitWidth)
		local gridY = math.floor(coordY / grid.unitHeight)
		return gridX, gridY 
	end

	grid.canGenerate = function (grid, coordX, coordY)
		local gridX, gridY = grid:getGridCoord(coordX, coordY)
		return grid[gridY + 1][gridX + 1] < grid.maxCountPerUnit
	end 

	grid.generate = function (grid, coordX, coordY, count)
		if not grid:canGenerate(coordX, coordY) then
			return 
		end

		count = count or 1
		local gridX, gridY = grid:getGridCoord(coordX, coordY)
		grid[gridY + 1][gridX + 1] = grid[gridY + 1][gridX + 1] + count
	end 

	return grid
end

local sharedInstance = nil
function MapDataManager:getInstance()	
	if sharedInstance == nil then
		sharedInstance = {}
		sharedInstance.__index = sharedInstance
		setmetatable(sharedInstance, MapDataManager)
		sharedInstance:init()
	end
	return sharedInstance
end

function MapDataManager:new()
	printError("can't creat another MapDataManager instance, cuz it's a singleton", 1)
end

function MapDataManager:init()
	-- configs setup
	self.levelConfig1 = require "Resource/profiles/dataProfile/ProfileClientLevel_1_1"
	self.levelConfig2 = require "Resource/profiles/dataProfile/ProfileClientLevel_1_2"
	self.levelConfig3 = require "Resource/profiles/dataProfile/ProfileClientLevel_1_3"
	self.dreamlevelConfig = require "Resource/profiles/dataProfile/ProfileClientLevel_5_1"
	self.worldBossConfig = require "Resource/profiles/dataProfile/ProfileClientLevel_6_1"

	self.heroLevelConfig = require "Resource/profiles/dataProfile/ProfileClientLevel_4_1"
	self.guildBossConfig = require "Resource/profiles/dataProfile/ProfileClientLevel_7_1"
	self.dungeonConfig = require "Resource/profiles/commonProfile/ProfileDungeon"
	self.colorConfig = require "Resource/profiles/dataProfile/ProfileClientColor"
	self.mapAppearanceConfig = require "Resource/profiles/commonProfile/ProfileMapAppearance"
	self.decorationSpawnConfig  = require "Resource/profiles/dataProfile/ProfileClientDecorationSpawn"
	self.decorationConfig = require "Resource/profiles/commonProfile/ProfileDecoration"
	self.chamberConfig = require "Resource/profiles/commonProfile/ProfileChamber"
	self.configMapConfig = require "Resource/profiles/commonProfile/ProfileConfigMap"
	self.terrainConfig = require "Resource/profiles/commonProfile/ProfileTerrain"
	self.storyConfig = require "Resource/profiles/commonProfile/ProfileStory"
	self.suspendedConfig = require "Resource/profiles/dataProfile/ProfileClientSuspendedMatter"
end
function MapDataManager:getStoryConfig(mapId)
	return self.storyConfig[mapId]
end

function MapDataManager:getLevelConfig(level, difficulty)
	if difficulty == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1 then 
		return self.levelConfig1[level]
	elseif difficulty == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2 then 
		return self.levelConfig2[level]
	elseif difficulty == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
		return self.levelConfig3[level]
	end
end
function MapDataManager:getDesertEyesLevelConfig(level,difficulty)
	local str = string.format("Resource/profiles/dataProfile/ProfileClientLevel_8_%d", difficulty)
	local allConfig = require(str)
	if(allConfig) then
		return allConfig[level]
	end

	return nil
end

function MapDataManager:getDistortedSpaceLevelConfig(level,difficulty)
	local str = string.format("Resource/profiles/dataProfile/ProfileClientLevel_9_%d", difficulty)
	local allConfig = require(str)
	if(allConfig) then
		return allConfig[level]
	end
end

function MapDataManager:getGeneralLevelConfig(caveModel, level,difficulty)
	local str = string.format("Resource/profiles/dataProfile/ProfileClientLevel_%d_%d", caveModel, difficulty)
	local allConfig = require(str)
	if(allConfig) then
		return allConfig[level]
	end
end

function MapDataManager:getPetPVPLevelConfig(level)
	local str = "Resource/profiles/dataProfile/ProfileClientLevel_11_1"
	local allConfig = require(str)
	if(allConfig) then
		return allConfig[level]
	end
end

function MapDataManager:getCommondModeLevelConfig(level,difficulty, mode)
	local str = string.format("Resource/profiles/dataProfile/ProfileClientLevel_%d_%d", mode, difficulty)
	local allConfig = require(str)
	if(allConfig) then
		return allConfig[level]
	end
end

function MapDataManager:getGuildBossLevelConfig(level,difficulty)
	return self.guildBossConfig[level]
end

function MapDataManager:getHeroLevelConfig(level, difficulty)
	return self.heroLevelConfig[level]
end

local terrainTypeNameMapping = {
	[MapDefine.TerrainType.Ground] = {"floor"},
	[MapDefine.TerrainType.Wall] = {"wall01", "wall02", "wall03"},
}
function MapDataManager:getTerrainNamesForTerrainType(terrainType)
	return terrainTypeNameMapping[terrainType]
end

local mapTextureNamesCache = {}
function MapDataManager:getTerrainTextureNames(mapName, terrainType)
	-- printfmt("getTerrainTextureNames %s %d", mapName, terrainType)
	local textureNames = {}
	local terrainNames = self:getTerrainNamesForTerrainType(terrainType)
	for _, terrainName in ipairs(terrainNames) do
		local texName = mapName .. "_" .. terrainName
		lume.push(textureNames, texName)
	end
    return textureNames
end

function MapDataManager:parseColors(colors) 
    local colorArray = {}
    for _, color in ipairs(colors) do
        if lume.isarray(color) then
            local colorArr = parseColors(color)
            for _, color in ipairs(colorArr) do
                lume.push(colorArray, color)
            end
        elseif MapHelper.isColor(color) then
            if color.a == nil then
                color.a = 255
            end
            lume.push(colorArray, color)
        elseif type(color) == "number" then
            local col = self:getColorForID(color);
            if col ~= nil then
            	col.a = 255
                lume.push(colorArray, col)
            end
        end
    end 
    return colorArray
end

function MapDataManager:parseAppearanceConfig(config)
	if config.wallColors then
		config.wallColors = self:parseColors(config.wallColors)
	end
	if config.groundColors then
		config.groundColors = self:parseColors(config.groundColors)
	end
	if config.effectColors then
		config.effectColors = self:parseColors(config.effectColors)
	end
end

-- mapTerrainGrids is a 2d array contains integer stands for terrain
-- mapConfig is the map generate config get from server
function MapDataManager:generateMap(mapTerrainGrids, mapConfig, configMapID, mapAppearanceID, dungeonRoomDatas)
	local SceneManager = require("app.game.SceneManager")
	mapTerrainGrids = {}
	assert(type(mapTerrainGrids) == "table", "invalid map terrain grids")
	assert(type(mapConfig) == "table", "invalid map config")
	local sceneType = mapConfig.type
	local level = mapConfig.level
	local difficulty = mapConfig.difficulty or 0
	local caveMode = mapConfig.caveMode or 0
	local stageSeed = mapConfig.stageSeed
	local gameMode = mapConfig.gameMode

	if  caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
		local levelConfig = self:getDesertEyesLevelConfig(level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE then
		local levelConfig = self:getDistortedSpaceLevelConfig(level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_PET then
		local levelConfig = self:getPetPVPLevelConfig(level)
		local configMapConfig = self.configMapConfig[level]
		mapConfig.width = configMapConfig.width
		mapConfig.height = configMapConfig.height
		mapConfig.randSeed = os.time()
		mapConfig.chamberWidth = 0
		mapConfig.chamberHeight = 0
		mapAppearanceID = levelConfig.mapAppearanceID 
		mapTitle = levelConfig.mapName
		configMapID = mapConfig.level
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_GHOST_ABYSS then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_TRIAL_LAND then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_VIKING then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT
	or caveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_TREATURE_HUNT then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_EXP then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
	end

	-- local mapTerrainGrids, configMapID, mapAppearanceID, dungeonRoomDatas = nil, nil, nil, nil
	if mapConfig.type == PublicDefine.SCENE_TYPE.TOWN 
		or mapConfig.type == PublicDefine.SCENE_TYPE.GUILD
		or mapConfig.type == PublicDefine.SCENE_TYPE.TOWN_CAVE 
		or mapConfig.type == PublicDefine.SCENE_TYPE.MANOR 
		or mapConfig.type == PublicDefine.SCENE_TYPE.BIGSAILPORT then
    	if mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_PET then
    		mapTerrainGrids = MapGen.generatePetPVP(mapConfig)
    	else
        	mapTerrainGrids = MapGen.generateTownOrGuild(mapConfig) 
        end
    elseif mapConfig.type == PublicDefine.SCENE_TYPE.CAVE then
        if mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL
            or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_WORLD_BOSS
            or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_GUILD_BOSS
            or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES
            or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE
			or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO
			or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT
			or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_TRIAL_LAND
			or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_VIKING
			or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT
			or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
			or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO
			or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING
			or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_EXP
			or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS
			or mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE
        then
            mapTerrainGrids = MapGen.generatePathWalk(mapConfig)
		elseif mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then
			local dungeonLevel = self:getDungeonLevel(mapConfig)
            mapTerrainGrids, dungeonRoomDatas = MapGen.generateDungeon(self.dungeonConfig[dungeonLevel], mapConfig)
        elseif mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_STORY then
            mapTerrainGrids, configMapID, mapAppearanceID = MapGen.generateStoryMap(mapConfig)
        elseif mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
            mapTerrainGrids = MapGen.generatePathWalk(mapConfig)
        elseif mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_DREAM then
            mapTerrainGrids = MapGen.generatePathWalk(mapConfig)
		elseif caveMode == PublicDefine.CAVE_MODE.MODE_TREATURE_HUNT then
			mapTerrainGrids, configMapID, mapAppearanceID = MapGen.generateConfigMap(mapConfig, configMapID) 
		elseif caveMode == PublicDefine.CAVE_MODE.MODE_EXP then
			--mapTerrainGrids, configMapID, mapAppearanceID = MapGen.generateConfigMap(mapConfig, configMapID) 
		end
	elseif mapConfig.type == PublicDefine.SCENE_TYPE.SCENE_TYPE_ACTIVITY then
		if self:isInActHuluChangeDungeon(mapConfig) then
			local dungeonLevel = self:getDungeonLevel(mapConfig)
			mapTerrainGrids, dungeonRoomDatas = MapGen.generateDungeon(self.dungeonConfig[dungeonLevel], mapConfig)
		else 
			mapTerrainGrids, configMapID, mapAppearanceID = MapGen.generateConfigMap(mapConfig, configMapID) 
		end
    else
        -- local isGuild = mapConfig.type == PublicDefine.SCENE_TYPE.GUILD
        print("is genearting guild? %s", isGuild and "YES" or "NO")
        mapTerrainGrids, configMapID, mapAppearanceID = MapGen.generateConfigMap(mapConfig, configMapID) 
    end

	printfmt("get map appearance for level %d, difficulty %d, caveMode %d", level, difficulty, caveMode)
	configMapID = configMapID or 0
	mapAppearanceID = mapAppearanceID or 0

	MapGenerater.setRandomSeed(mapConfig.randSeed)

	local mapTitle = ""
	if caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
		local levelConfig = self:getLevelConfig(level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_WORLD_BOSS then
		local levelConfig = self.worldBossConfig[level]
		-- dump(levelConfig)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_GHOST_ABYSS then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_DREAM then 
		-- print("level",level)
		local levelConfig = self.dreamlevelConfig[level]
		-- dump(levelConfig)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then
		mapTitle = 1110531
		if mapAppearanceID == 0 then
			level = self:getDungeonLevel(mapConfig)
			local dungeonConfig = self.dungeonConfig[level]
			dungeonConfig = MapGenerater.parseDungeonConfig(dungeonConfig, mapConfig)
			-- local mapAppearanceIDs = dungeonConfig.mapAppearanceIDs
			-- if #mapAppearanceIDs > 0 then
			-- 	mapAppearanceID = mapAppearanceIDs[map_random(1, #mapAppearanceIDs)]
			-- end

			-- load map appearance ID generated by server, sent throught pb message, in field "mapAppearance"
			mapAppearanceID = mapConfig.mapAppearance
			printfmt("generatee map with apperance %d genreated by server", mapAppearanceID)
		end
	-- 剧本模式
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_STORY then
		
		-- local sConfig = self:getStoryConfig(configMapID)
		-- mapTitle = sConfig.mapName
		mapTitle = 1150026
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
		local levelConfig = self:getHeroLevelConfig(level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end

		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_GUILD_BOSS then
		local levelConfig = self:getGuildBossLevelConfig(level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
		local levelConfig = self:getDesertEyesLevelConfig(level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE then
		local levelConfig = self:getDistortedSpaceLevelConfig(level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_ACT then
		if self:isInActHuluChangeDungeon(mapConfig) then
			local levelConfig = self:getCommondModeLevelConfig(level, difficulty, caveMode)
			if levelConfig ~= nil then
				mapTitle = levelConfig.mapName
			end
			if mapAppearanceID == 0 then
				level = MapGenerater.adjustDungeonLevel(level, sceneType)
				local dungeonConfig = self.dungeonConfig[level]
				dungeonConfig = MapGenerater.parseDungeonConfig(dungeonConfig, mapConfig)

				-- load map appearance ID generated by server, sent throught pb message, in field "mapAppearance"
				mapAppearanceID = mapConfig.mapAppearance
				printfmt("generatee map with apperance %d genreated by server", mapAppearanceID)
			end
		else
			-- 处理通用的配置逻辑
			local levelConfig = self:getCommondModeLevelConfig(level, difficulty, caveMode)
			if levelConfig ~= nil then
				mapTitle = levelConfig.mapName
			end
			-- dump(levelConfig)
			if mapAppearanceID == 0 and levelConfig ~= nil then
				mapAppearanceID = levelConfig.mapAppearanceID
			else
				mapAppearanceID = MapDefine.DefaultMapAppearance
			end
		end
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_TRIAL_LAND then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_VIKING then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif  caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_PET then
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_TREATURE_HUNT then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif caveMode == PublicDefine.CAVE_MODE.MODE_EXP then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	elseif SceneManager:checkModeIsNewCave(caveMode) then
		local levelConfig = self:getGeneralLevelConfig(caveMode, level, difficulty)
		if levelConfig ~= nil then
			mapTitle = levelConfig.mapName
		end
		-- dump(levelConfig)
		if mapAppearanceID == 0 and levelConfig ~= nil then
			mapAppearanceID = levelConfig.mapAppearanceID
		else
			mapAppearanceID = MapDefine.DefaultMapAppearance
		end
		if levelConfig ~= nil then
			configMapID = levelConfig.configMapID
		end
		if configMapID == 0 then
			configMapID = mapConfig.level
		end
	end

	if gameMode == PublicDefine.GAME_MODE.MODE_MANOR then
		configMapID = mapConfig.level
	elseif gameMode == PublicDefine.GAME_MODE.MODE_BIGSAILPORT then
		configMapID = mapConfig.level
	end



	
	if mapAppearanceID == 0 then
		mapAppearanceID = 1
		printfmt("use default map appearance ID 1")
	end
	print("PET BATTLE PRINT !!!!!!!!!!!!!!!!!!")
	print("MAP type : " .. sceneType .. " level : " .. level .. " caveMode : " .. caveMode .. " mapAppearanceID : " .. mapAppearanceID)
	local appearanceConfig = self.mapAppearanceConfig[mapAppearanceID]
	if appearanceConfig ~= nil then 
		self:parseAppearanceConfig(appearanceConfig)
	end
	if appearanceConfig == nil then 
		err = string.format("get map appearanceConfig %d failed", mapAppearanceID)
		printError(err)
	end
	local mapData = MapData:create(mapConfig, appearanceConfig, mapTitle)
	if dungeonRoomDatas ~= nil then 
		mapData.dungeonRoomDatas = dungeonRoomDatas;
	end
	-- printfmt("mapdata width %d height %d name %s number %d level %d difficulty %d sceneType %d caveMode %d", mapData.width, mapData.height, mapData.name, mapData.number, mapData.level, mapData.difficulty, mapData.sceneType, mapData.caveMode)

	if(GameManager:getIsInNewScene() and GameManager:getIsInitNewTownTypeFlag()) then 
		return mapData
	end

	local m = {}
	m.maxCountPerGridUnit = 1
	m.gridUnitWidth = 3
	m.gridUnitHeight = 3
	m.canNotBeAdjacent = true
	m.canNotBeCornerAdjacent = true
	self.decorationGenerateRestrictionConfig = m

	self.decorationGridMap = createGenerationRestrictionGridForMap(mapData.width, mapData.height, self.decorationGenerateRestrictionConfig)

	if mapTerrainGrids.countXY then
		mapData:setUsedTileCount(mapTerrainGrids.countXY)
	end
	-- set up all tile datas
	for y = 1, mapData.height do
		for x = 1, mapData.width do
			local terrainID = mapTerrainGrids[y][x]
			if terrainID ~= nil and terrainID ~= -1 then
				local coordX, coordY = x - 1, y - 1
				local tileData = MapTileData:create(coordX, coordY)
				local terrainType = terrainID
				local terrainData = self:createTerrainDataForType(mapData, terrainType, {x = x, y = y})
				tileData:setTerrainData(terrainData)
				mapData:setTileDataAtCoord(coordX, coordY, tileData)
				lume.push(mapData.usedTileDatas, tileData)
			end
		end
	end

	-- random decoration Generate
	local decorationIDConfig = appearanceConfig.decorationID
	local decorationNumConfig = appearanceConfig.decorationNum
	if decorationIDConfig ~= nil and decorationNumConfig ~= nil then
		-- print("随机装饰物")
		local decorationCategoryCount = #decorationIDConfig
		local decorationCategoryCount2 = #decorationNumConfig
		if decorationCategoryCount > 0 and decorationCategoryCount == decorationCategoryCount2 then
			local decorationCategoryIndexes = {}
			for i = 1, decorationCategoryCount do
				lume.push(decorationCategoryIndexes, i)
			end
			for i = 1, decorationCategoryCount do
				local randIndex = map_random(1, #decorationCategoryIndexes)
				local categoryIndex = decorationCategoryIndexes[randIndex]
				decorationCategoryIndexes[randIndex] = decorationCategoryIndexes[#decorationCategoryIndexes]
				table.remove(decorationCategoryIndexes, #decorationCategoryIndexes)
				-- printfmt("decorationCategoryIndexes count %d categoryIndex %d", #decorationCategoryIndexes, categoryIndex)
				local decorationID = decorationIDConfig[categoryIndex]
				if decorationID > 0 then
					-- printfmt("generating decoration ID %d", decorationID)
					local decorationNumStr = decorationNumConfig[categoryIndex]
					if decorationNumStr ~= nil and #decorationNumStr > 0 then 
						local min, max = decorationNumStr:match("([^,]+),([^,]+)")
						if min and max then
							local generateNum = map_random(min, max)
							self:generateRandomDecoration(mapData, generateNum, decorationID)
						end
					end 
				end
			end
		else
			if(DEVELOPMENT_MODE) then
				printError(("decorationIDConfig count %d not equal to decorationNumConfig count %d or is just zero"):format(#decorationIDConfig, #decorationNumConfig))
			else
				print(("decorationIDConfig count %d not equal to decorationNumConfig count %d or is just zero"):format(#decorationIDConfig, #decorationNumConfig))
			end
		end
	else 
		if(DEVELOPMENT_MODE) then
			printError("decorationIDConfig is nil or decorationNumConfig is nil")
		else
			print("decorationIDConfig is nil or decorationNumConfig is nil")
		end
	end


	-- constant decoration generate
	-- print("sceneType",sceneType,PublicDefine.SCENE_TYPE.CAVE,configMapID)
	-- 主场景或者剧情模式
	if sceneType ~= PublicDefine.SCENE_TYPE.CAVE and configMapID > 0 then 		
		local configMapConfig = self.configMapConfig[configMapID]
		if configMapConfig ~= nil then
			mapData:setEnterCoord(configMapConfig.entranceX, configMapConfig.entranceY)
			local decorationsConfigString = configMapConfig["decorations"]
			if decorationsConfigString ~= nil and #decorationsConfigString > 0 then
				self:generateConstantDecoration(mapData, decorationsConfigString)
			end
		end
	else
		if caveMode == PublicDefine.CAVE_MODE.MODE_STORY then
			local sConfig = self:getStoryConfig(configMapID)
			local cfgMapId = sConfig["mapID"]
			local configMapConfig = self.configMapConfig[cfgMapId]
			if configMapConfig ~= nil then
				mapData:setEnterCoord(configMapConfig.entranceX, configMapConfig.entranceY)
				local decorationsConfigString = configMapConfig["decorations"]
				if decorationsConfigString ~= nil and #decorationsConfigString > 0 then
					self:generateConstantDecoration(mapData, decorationsConfigString)
				end
			end
		elseif caveMode ~= PublicDefine.CAVE_MODE.MODE_PET then
			local configMapConfig = self.configMapConfig[configMapID]
			if configMapConfig ~= nil then
				mapData:setEnterCoord(configMapConfig.entranceX, configMapConfig.entranceY)
				local decorationsConfigString = configMapConfig["decorations"]
				if decorationsConfigString ~= nil and #decorationsConfigString > 0 then
					self:generateConstantDecoration(mapData, decorationsConfigString)
				end
			end
		end
	end

	-- generate decoration in dungeon rooms
	if dungeonRoomDatas ~= nil then 
		for _, dungeonRoomData in ipairs(dungeonRoomDatas) do 
			if not dungeonRoomData.isRandom then
				local configMapID = dungeonRoomData.mapID
				local configMapConfig = self.configMapConfig[configMapID]
				if configMapConfig ~= nil then
					mapData:setEnterCoord(configMapConfig.entranceX, configMapConfig.entranceY)
					local decorationsConfigString = configMapConfig["decorations"]
					if decorationsConfigString ~= nil and #decorationsConfigString > 0 then
						self:generateConstantDecoration(mapData, decorationsConfigString, {x = dungeonRoomData.bounds.x, y = dungeonRoomData.bounds.y})
					end
				end
			end
		end
	end

	-- add by zp 添加装饰类的陷阱配置
	mapData.decorationTrapConfig = {}
	local configMapConfig = self.configMapConfig[configMapID]
	if(configMapConfig) then
		mapData:setEnterCoord(configMapConfig.entranceX, configMapConfig.entranceY)
		local decorationTrap = configMapConfig.decorationTrap
		if(decorationTrap and decorationTrap ~= "") then
			local decorationArr = AvalonUtil:splitStr(decorationTrap, ";")
			for _, decoration in ipairs(decorationArr) do 
				local dataArr = AvalonUtil:splitStr(decoration, ",")
				if(dataArr and #dataArr >= 3) then
					local decorationData = {}
					decorationData.trapID = tonumber(dataArr[1])
					decorationData.num = tonumber(dataArr[2])
					decorationData.coordArr = {}
					for i=3,#dataArr,1 do 
						local coord = AvalonUtil:splitStr(dataArr[i], ":")
						table.insert(decorationData.coordArr, {x = tonumber(coord[1]), y = tonumber(coord[2])})
					end
					-- print("decorationData.coordArr ", decorationData.coordArr)
					table.insert(mapData.decorationTrapConfig, decorationData)
				end
			end 
		end
	end

	-- add by zp 处理巡逻NPC 配置
	mapData.patrolNpcConfig = {}
	local configMapConfig = self.configMapConfig[configMapID]
	if(configMapConfig) then
		mapData:setEnterCoord(configMapConfig.entranceX, configMapConfig.entranceY)
		local decorationNPC = configMapConfig.decorationNPC
		if(decorationNPC and decorationNPC ~= "") then
			local decorationArr = AvalonUtil:splitStr(decorationNPC, ";")
			for _, decoration in ipairs(decorationArr) do 
				local dataArr = AvalonUtil:splitStr(decoration, ",")
				if(dataArr and #dataArr >= 2) then
					local decorationData = {}
					decorationData.templateID = tonumber(dataArr[1])
					decorationData.coordArr = {}
					for i=2,#dataArr,1 do 
						local coord = AvalonUtil:splitStr(dataArr[i], ":")
						table.insert(decorationData.coordArr, {x = tonumber(coord[1]), y = tonumber(coord[2])})
					end
					-- print("patrolNpcConfig.coordArr ", decorationData.coordArr)
					table.insert(mapData.patrolNpcConfig, decorationData)
				end
			end 
		end
	end

	mapData.suspendedCfgList = self:parseSuspendedConfig(appearanceConfig.suspendedMatterId)
	return mapData
end

function MapDataManager:generateRandomDecoration(mapData, generateNum, decorationID)
	

	local decorationConfig = self.decorationConfig[decorationID]
	if decorationConfig == nil then
		local errorStr = string.format("deocration %d has no config", decorationID)
		printError(errorStr)
		return 
	end
	local decorationSpawnConfig = self.decorationSpawnConfig[decorationConfig.spawnID]
	if decorationSpawnConfig == nil then 
		local errorStr = string.format("decoration %d has no random generation config %d", decorationID, decorationConfig.spawnID)
		printError(errorStr)
	end

-- function MapDataManager:generateDecoration(mapData, decorationConfig, count)
	local gridMap = self.decorationGridMap
	local checkOccupySize = function (tileData, decorationData)
		local sx, sy = tileData.x, tileData.y
		for x = sx, sx + decorationData:getOccupySize().width - 1 do
			for y = sy, sy + decorationData:getOccupySize().height - 1 do
				local td = mapData:getTileDataAtCoord(x, y)
				if td == nil or td:getTerrainData():getTerrainType() ~= decorationData:getGenerateTerrainType() or td:hasDecoration() then
					return false
				end
			end
		end
		return true
	end

	local hasAdjacentDecoration = function (tileData) 
		-- check if there is a decoration adjacent
		for _, offset in ipairs(MapDefine.AdjacentOffsets) do 
			local td = mapData:getTileDataAtCoord(tileData.x + offset.x, tileData.y + offset.y)
			if td ~= nil and td:hasDecoration() then 
				return true
			end
		end
		return false
	end

	local checkFunc = nil
	if decorationSpawnConfig and decorationSpawnConfig.generateTerrainType == MapDefine.TerrainType.Wall then
		checkFunc = function (tileData, decorationData) 
			-- check if there is a ground in south-west and south-east to the wall, otherwise decoration generate on wall may not be seen
			local count = mapData:getTileCountForTerrainWithOffsets(tileData.x, tileData.y, MapDefine.TerrainType.Ground, {{x = -1, y = 0}, {x = 0, y = -1}})
			local hasBottomAdjacentGround = (count == 2)

			-- print ("check generation on wall ", tileData.x, tileData.y, hasBottomAdjacentGround, not tileData:hasDecoration(), checkOccupySize(tileData))
			return hasBottomAdjacentGround and not tileData:hasDecoration() and not hasAdjacentDecoration(tileData) and checkOccupySize(tileData, decorationData)
		end
	else
		checkFunc = function (tileData, decorationData) 
			-- print ("check generation on ground ", tileData.x, tileData.y, not tileData:hasDecoration(), checkOccupySize(tileData))
			return not tileData:hasDecoration() and not hasAdjacentDecoration(tileData) and checkOccupySize(tileData, decorationData)
		end
	end

	local function setDecorationRandomDirection(decorationData, decorationSpawnConfig) 
		local hasRandomDirection = decorationSpawnConfig.hasRandomDirection == 1
		if hasRandomDirection then
			if map_random(0, 1) == 1 then
				decorationData:setDirection(MapDefine.DirectionType.West)
			else 
				decorationData:setDirection(MapDefine.DirectionType.South)
			end
		end
	end

	if(decorationSpawnConfig) then 
		for i = 1, generateNum do
			local decorationData = MapDecorationData:create(decorationConfig, decorationSpawnConfig)
			if decorationData ~= nil then
				setDecorationRandomDirection(decorationData, decorationSpawnConfig)

				decorationData:setEffectColor(self:getColorForID(decorationData:getEffectColorID()))
				
				local tileData = nil
				if decorationData:isSeparate() then
					local separateCheckFunc = function (tileData) 
						local count = mapData:getAdjacentTerrainCountAtCoordinate(tileData.x, tileData.y, decorationData:getGenerateTerrainType())
						local isSeparate = (count == 0)
						-- if isSeparate then
							-- print ("check generation seperate ", tileData.x, tileData.y, isSeparate, checkFunc(tileData))
						-- end
						return isSeparate and checkFunc(tileData, decorationData)
					end
					tileData = self:getRandomTileForTerrainType(mapData, decorationData:getGenerateTerrainType(), gridMap, separateCheckFunc)	
				else 
					local nonSeparateCheckFunc = function (tileData) 
						local count = mapData:getAdjacentTerrainCountAtCoordinate(tileData.x, tileData.y, decorationData:getGenerateTerrainType())
						local isSeparate = (count == 0)
						return not isSeparate and checkFunc(tileData, decorationData)
					end
					
					tileData = self:getRandomTileForTerrainType(mapData, decorationData:getGenerateTerrainType(), gridMap, nonSeparateCheckFunc)	
					-- if tileData == nil then 
					-- 	printfmt("get random tile for decoration %d", decorationData.ID)
					-- else
					-- 	printfmt("get random tile for decoration %d at %d,%d", decorationData.ID, tileData.x, tileData.y)
					-- end
				end

				if tileData ~= nil then	
					-- try to change tile terrain type
					local finalTerrainType = decorationData:getFinalTerrainType()

					if tileData:getTerrainType() == MapDefine.TerrainType.Ground and finalTerrainType == MapDefine.TerrainType.Wall then
						printError("modify ground to wall is invalid")
					elseif tileData:getTerrainType() == MapDefine.TerrainType.Wall and finalTerrainType == MapDefine.TerrainType.Ground then
						-- turn all decoration occupied wall to ground
						local sx, sy = tileData.x, tileData.y
						for x = sx, sx + decorationData:getOccupySize().width - 1 do
							for y = sy, sy + decorationData:getOccupySize().height - 1 do
								local td = mapData:getTileDataAtCoord(x, y)
								if td ~= nil and td:getTerrainData():getTerrainType() == MapDefine.TerrainType.Wall then
									self:setTerrainDataForType(mapData, td:getTerrainData(), MapDefine.TerrainType.Ground)
									self:generateWallAroundCoord(mapData, td.x, td.y)
								end
							end
						end
					end
											
					local occupySize = decorationData:getOccupySize()
					if occupySize.width > 1 or occupySize.height > 1 then 
						self:generatePlaceholders(mapData, tileData.x, tileData.y, occupySize, "decoration", decorationData.ID, decorationData.reachable, decorationData.nodeOfPath, decorationData.endOfPath, decorationData.destructible)
					end

					lume.push(tileData.decorationDatas, decorationData)

					if gridMap ~= nil then
						gridMap:generate(tileData.x, tileData.y);
					end 

					if decorationData:getEffectColor() ~= nil and decorationData:getRadiationRadius() ~= nil then
						self:generateColorWithRadiationRadiusAtCoord(mapData, decorationData:getEffectColor(), decorationData:getRadiationRadius(), tileData.x, tileData.y)
					end

					-- printfmt ("generate decoration %s at (%d,%d)", decorationData.skin, tileData.x, tileData.y)
					-- printfmt ("generate decoration %s at (%d,%d) seperate:%s hasRandomDirection:%s size:{%d,%d}", decorationData:getSkin(), tileData.x, tileData.y, 
					-- 	decorationData:isSeparate() and "true" or "false", decorationData:GetHasRandomDirection() and "true" or "false",
					-- 	decorationData:getOccupySize().width, decorationData:getOccupySize().height)
				-- else 
				-- 	print ("can not get proper tile anymore")
				end
			end
		end
	end
end

function MapDataManager:generateColorWithRadiationRadiusAtCoord(mapData, color, radiationRadius, x, y)

	local offsets = MapHelper.getCoordOffsetsForRadius(radiationRadius)
	for _, offset in ipairs(offsets) do
		local cx, cy = x + offset.x, y + offset.y
        if mapData:isCoordInBounds(cx, cy) then
        	-- local tileData = mapData:getTileDataAtCoord(cx, cy)
        	-- if tileData ~= nil then
	            -- local radiationLevel = math.max(math.abs(offset.x), math.abs(offset.y))
	            -- local opacity = MapHelper.getOpacityForRadiationLevel(radiationLevel, radiationRadius)
	        --     tileData:addColor(color, opacity)
	        -- end
	        local radiationLevel = math.max(math.abs(offset.x), math.abs(offset.y))
	        local opacity = MapHelper.getOpacityForRadiationLevel(radiationLevel, radiationRadius)
	        local effectColorData = MapEffectColorData:create(color, opacity)
	        if effectColorData ~= nil then
	        	local effectColorDatas = mapData:getEffectColorDatasAtCoord(cx, cy)
		        if effectColorDatas == nil then
		        	effectColorDatas = {}
		        	mapData.effectColorDatasMap[cy + 1][cx + 1] = effectColorDatas
		        end
		        lume.push(effectColorDatas, effectColorData)
	        end
        end 
	end
end

function MapDataManager:removeColorWithRadiationRadiusAtCoord(mapData, color, radiationRadius, x, y)
	print ("removeColorWithRadiationRadiusAtCoord ", radiationRadius, x, y)
	local removedColorCoords = {}
	local offsets = MapHelper.getCoordOffsetsForRadius(radiationRadius)
	for _, offset in ipairs(offsets) do
		local cx, cy = x + offset.x, y + offset.y
        if mapData:isCoordInBounds(cx, cy) then
        	-- local tileData = mapData:getTileDataAtCoord(cx, cy)
        	-- if tileData ~= nil then
	        --     local radiationLevel = math.max(math.abs(offset.x), math.abs(offset.y))
	        --     local opacity = MapHelper.getOpacityForRadiationLevel(radiationLevel, radiationRadius)
	        --     tileData:removeColor(color, opacity) 
	        --     lume.push(removedColorTileDatas, tileData)
	        -- end
	        
	        local effectColorDatas = mapData:getEffectColorDatasAtCoord(cx, cy)
	        if effectColorDatas ~= nil then
	        	local radiationLevel = math.max(math.abs(offset.x), math.abs(offset.y))
	        	local opacity = MapHelper.getOpacityForRadiationLevel(radiationLevel, radiationRadius)
				for _, colorData in ipairs(effectColorDatas) do
					if MapHelper.c4b_equals(color, colorData:getColor()) and opacity == colorData:getOpacity() then
						print ("removeColorWithRadiationRadiusAtCoord did remove color at tile ", cx , cy, MapHelper.c4b_to_string(color), opacity)
						lume.remove(effectColorDatas, colorData)
						lume.push(removedColorCoords, {x = cx, y = cy})
						break
					end
				end
	        end
        end 
	end
	return removedColorCoords
end

function MapDataManager:createTileDataAtCoord(mapData, x, y, terrainType)
	local terrainT = terrainType or MapDefine.TerrainType.Ground
	local tileData = MapTileData:create(x, y)
	mapData:setTileDataAtCoord(x, y, tileData)
	local terrainData = self:createTerrainDataForType(mapData, terrainT)
	tileData:setTerrainData(terrainData)
	return tileData
end

function MapDataManager:getTerrainInfosForType(mapData, terrainType, coord)
	local category = 1
	local colors = {}
	if terrainType == MapDefine.TerrainType.Ground then
		if mapData.appearanceConfig.groundCategoryCount > 0 then
			category = map_random(1, mapData.appearanceConfig.groundCategoryCount)
		end
		colors = mapData.appearanceConfig.groundColors
	elseif terrainType == MapDefine.TerrainType.Wall then
		if mapData.appearanceConfig.wallCategoryCount > 0 then
			category = map_random(1, mapData.appearanceConfig.wallCategoryCount)
		end
		colors = mapData.appearanceConfig.wallColors
	end
	local terrainNames = {}
	-- only generating terrain ground in town and guild scene
	if (mapData.sceneType == PublicDefine.SCENE_TYPE.TOWN 
		or mapData.sceneType == PublicDefine.SCENE_TYPE.GUILD
		or mapData.sceneType == PublicDefine.SCENE_TYPE.TOWN_CAVE 
		or mapData.sceneType == PublicDefine.SCENE_TYPE.MANOR
		or mapData.sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT
		) and mapData.caveMode ~= PublicDefine.CAVE_MODE.MODE_PET then
		terrainNames = self:getTerrainTextureNames(mapData.name, MapDefine.TerrainType.Ground)
	else 
		local mapName = mapData.name
		if mapData.isSplit and mapData.isSplit == 1 and coord and mapData:getUsedTileCount() then
			local height = mapData:getUsedTileCount().y
			if coord.y > math.floor(mapData.height / 2) then
				mapName = mapData.splitName
			end
		end
		if terrainType == MapDefine.TerrainType.Wall then
			if mapData.appearanceConfig.wallCategoryCount > 0 then
				terrainNames = self:getTerrainTextureNames(mapName, terrainType)
			end
		else 
			terrainNames = self:getTerrainTextureNames(mapName, terrainType)
		end
	end 
	-- printfmt("getTerrainInfosForType sceneType %d terrainType %d %s %d", mapData.sceneType, terrainType, tostring(terrainNames), category)
	return terrainType, terrainNames, category, colors
end

function MapDataManager:createTerrainDataForType(mapData, terrainType, coord)
	local terrainData = MapTerrainData:create(self:getTerrainInfosForType(mapData, terrainType, coord))
	return terrainData
end

function MapDataManager:setTerrainDataForType(mapData, terrainData, terrainType)
	local _, terrainNames, category, colors = self:getTerrainInfosForType(mapData, terrainType)
	terrainData:setTerrainType(terrainType)
	terrainData:setTerrainNames(terrainNames)
	terrainData:setCategory(category)
	terrainData:setColors(colors)
end

function MapDataManager:setTileDataDirty(mapData, tileData)
	local k = lume.find(mapData.dirtyTileDatas, tileData)
	if k == nil then
		-- printfmt("make tileData dirty %d,%d", tileData.x, tileData.y)
		lume.push(mapData.dirtyTileDatas, tileData)
	end
end

function MapDataManager:generateConstantTerrainAtRect(mapData, rect, terrainString)
	local terrainRows = AvalonUtil.lines(terrainString)
	local rowCount = math.min(#terrainRows, rect.height)
	for y = 1, rowCount do
		local terrainRow = terrainRows[y]
		local columnCount = math.min (#terrainRow, rect.width)
		for x = 1, columnCount do
			local c = terrainRow:sub(x, x)
			local terrainType = MapDefine.TerrainType.None
			if c == "x" or c == "1" then
				terrainType = MapDefine.TerrainType.Wall
			elseif c == "." or c == "0" then
				terrainType = MapDefine.TerrainType.Ground
			end
			if terrainType ~= MapDefine.TerrainType.None then
				-- print ("generateFromMapConfig c", c, x, y)
				local cx, cy = rect.x + x - 1, rect.y + y - 1
				local tileData = mapData:getTileDataAtCoord(cx, cy)
				if tileData == nil then
					tileData = self:createTileDataAtCoord(mapData, cx, cy, terrainType)
				else
					local terrainData = self:createTerrainDataForType(mapData, terrainType)
					tileData:setTerrainData(terrainData)
				end
				if tileData ~= nil then
					self:setTileDataDirty(mapData, tileData)
				end
			end
		end
	end
end

function MapDataManager:removePlaceholdersForDecoration(mapData, x, y, decorationData)
	for iy = 1, decorationData.occupySize.height do 
		for ix = 1, decorationData.occupySize.width do
			local cx, cy = x + ix - 1, y + iy - 1
			local td = mapData:getTileDataAtCoord(cx, cy)
			if td ~= nil then
				local removePlaceholderDatas = {}
				for _, placeholderData in ipairs(td.placeholderDatas) do
					if placeholderData.associatedID == decorationData.ID and placeholderData.associatedCoord.x == x and placeholderData.associatedCoord.y == y then
						lume.push(removePlaceholderDatas, placeholderData)
					end
				end
				for _, remove in ipairs(removePlaceholderDatas) do 
					lume.remove(td.placeholderDatas, remove)
				end
			end
		end
	end
end

function MapDataManager:generatePlaceholders(mapData, x, y, size, placeholerType, templateID, reachable, nodeOfPath, endOfPath, destructible)
	if type(placeholerType) ~= "string" then
		printError("generatePlaceholders placeholerType must be string")
	end
	-- printfmt("generatePlaceholders tempateID %d size %d,%d at %d,%d", templateID, size.width, size.height, x, y)                                                                                                                           
	for iy = 1, size.height do 
		for ix = 1, size.width do
			if ix == 1 and iy == 1 then
			else 
				local cx, cy = x + ix - 1, y + iy - 1
				local tileData = mapData:getTileDataAtCoord(cx, cy)
				if tileData ~= nil then
					local placeholderData = MapPlaceholderData:create(placeholerType, templateID, {x = x, y = y}, reachable, nodeOfPath, endOfPath, destructible)
					lume.push(tileData.placeholderDatas, placeholderData)
					-- printfmt("generatePlaceholder tempateID %d size %d,%d at %d,%d - %s,%s,%s,%s", templateID, size.width, size.height, cx, cy, tostring(reachable), tostring(nodeOfPath), tostring(endOfPath), tostring(destructible))   
				end
			end
		end
	end
end

function MapDataManager:canReallyShowDecoration(setting, mapData, decorationData, deocorationConfig)
	-- 首先判断是否boss层(深渊boss层除外)，如果是则显示
	local isBossScene = mapData:isBossScene()
	local caveMode = mapData:getCaveMode()
	if isBossScene and caveMode ~= PublicDefine.CAVE_MODE.MODE_DUNGEON then
		return true
	end

	if mapData:getSceneType() == PublicDefine.SCENE_TYPE.CAVE and caveMode == PublicDefine.CAVE_MODE.MODE_TREATURE_HUNT then
		return true
	end

	if mapData:getSceneType() == PublicDefine.SCENE_TYPE.CAVE and caveMode == PublicDefine.CAVE_MODE.MODE_EXP then
		return true
	end

	if mapData:getSceneType() == PublicDefine.SCENE_TYPE.TOWN_CAVE 
	or mapData:getSceneType() == PublicDefine.SCENE_TYPE.MANOR then 
		return true
	end

	if mapData:getSceneType() == PublicDefine.SCENE_TYPE.BIGSAILPORT then 
		return true
	end

	-- local SceneManager = require("app.game.SceneManager")
	if mapData:getLevel() == PublicDefine.CONST_DEFINITION.LOST_REALM_MAP_ID then
		return true
	end

	-- 再看装饰物配置项
	local canShow = setting

	-- 如果是不可达的，需要显示
	-- 如果是地图中的怪有通过PLOTEVENT创建的装饰物，需要显示
	local idx = string.find(deocorationConfig.skin, "effect_role")
	if (not decorationData:isReachable()) or (idx ~= nil) then
		canShow = true
	end

	return canShow
end

function MapDataManager:generateConstantDecoration(mapData, decorationsConfigString, generateOffset)
	assert(decorationsConfigString ~= nil and #decorationsConfigString > 0)
	local setting = GameManager:getCustomHQ(CUSTOM_HQ_TYPE.DECORATE)
	local offset = generateOffset or {x = 0, y = 0}
	local decorationConfigs = MapHelper.parseNumberGroupsString(decorationsConfigString)
	for _, decorationConfig in ipairs(decorationConfigs) do
		local x = decorationConfig[1]
		local y = decorationConfig[2]
		local templateID = decorationConfig[3]
		local cx, cy = x + offset.x, y + offset.y 
		local tileData = mapData:getTileDataAtCoord(cx, cy)
		if tileData ~= nil then
			local deocorationConfig = self.decorationConfig[templateID];
			if deocorationConfig ~= nil then 
				local decorationData = MapDecorationData:create(deocorationConfig)
				if decorationData ~= nil then 
					if self:canReallyShowDecoration(setting, mapData, decorationData, deocorationConfig) then
						lume.push(tileData.decorationDatas, decorationData)
						local occupySize = decorationData:getOccupySize()
						-- if occupySize.width > 1 or occupySize.height > 1 and not decorationData.onGround then 
						if occupySize.width > 1 or occupySize.height > 1 then
							self:generatePlaceholders(mapData, tileData.x, tileData.y, occupySize, "decoration", decorationData.ID, decorationData.reachable, decorationData.nodeOfPath, decorationData.endOfPath, decorationData.destructible)
						end
						-- printfmt("generate constant decoration %d %s %d %d", templateID, deocorationConfig["skin"], x, y)
					end
				end
			end
		end
	end
end

function MapDataManager:generateChamber(mapData, chamberID, entrance, connectPoint, rect)
	mapData:setChamber(entrance, connectPoint, rect)

	local chamberConfig = self.chamberConfig[chamberID]
	if chamberConfig ~= nil then
		local configMapID = chamberConfig.configMapID
		local configMapConfig = self.configMapConfig[configMapID]
		if configMapConfig ~= nil then
			mapData:setEnterCoord(configMapConfig.entranceX, configMapConfig.entranceY)
			local terrainID = configMapConfig["terrainID"]
			if terrainID ~= nil then 
				local terrainString = self.terrainConfig[terrainID]["terrainString"] 
				if terrainString ~= nil and #terrainString > 0 then 
					self:generateConstantTerrainAtRect(mapData, rect, terrainString)
				end
			end
			local decorationsConfigString = configMapConfig["decorations"]
			if decorationsConfigString ~= nil and #decorationsConfigString > 0 then
				self:generateConstantDecoration(mapData, decorationsConfigString, {x = rect.x, y = rect.y})
			end
		end
	end

	self:transformTileToReachableAtCoord(mapData, entrance.x, entrance.y, false, true)
	self:transformTileToReachableAtCoord(mapData, connectPoint.x, connectPoint.y, false, true)
end

function MapDataManager:transformTileToReachableAtCoord(mapData, x, y, generateWallAroundTile, transformReachableDecoration)
	local generateWallAround = true
	if generateWallAroundTile ~= nil and not generateWallAroundTile then 
		generateWallAround = false
	end
	local shouldTransReachableDecoration = true
	if transformReachableDecoration ~= nil and not transformReachableDecoration then 
		shouldTransReachableDecoration = false
	end
	
	local tileData = mapData:getTileDataAtCoord(x, y)
	if tileData == nil then
		-- if no tile used at coordinate, create a new tile data with ground
		tileData = self:createTileDataAtCoord(mapData, x, y)
	end
	
	-- printfmt("transformTileToReachableAtCoord %d,%d generateWallAround %s shouldTransReachableDecoration %s", x, y, tostring(generateWallAround), tostring(shouldTransReachableDecoration))
	-- cuz wall can be transformed to any unreachable decoration
	-- so need to clear unreachable decorations here
	local function removeDecorationDatas(tileData, decorationID) 
		local removedColorCoords = {}
		local removeDecorationDatas = {}
		local decorationDatas = tileData:getDecorationDatas()
		for _, decorationData in ipairs(decorationDatas) do
			if decorationID == nil or (decorationID ~= nil and decorationID == decorationData.ID) then 
				if shouldTransReachableDecoration or not decorationData:isReachable() then
					lume.push(removeDecorationDatas, decorationData)

					self:removePlaceholdersForDecoration(mapData, tileData.x, tileData.y, decorationData)

					if decorationData:getEffectColor() ~= nil and decorationData:getRadiationRadius() ~= nil then
						local removedCoords = self:removeColorWithRadiationRadiusAtCoord(mapData, decorationData:getEffectColor(), decorationData:getRadiationRadius(), x, y)
						lume.concat(removedColorCoords, removedCoords)
					end
				end
			end
		end
		for _, remove in ipairs(removeDecorationDatas) do
			lume.remove(decorationDatas, remove)
			-- printfmt("transformTileToReachableAtCoord %d,%d remove decor %s %d", tileData.x, tileData.y, remove.skin, remove.ID)
		end
		-- lume.clear(decorationDatas)
		-- printfmt("remove decoration data at %d,%d,%s", tileData.x, tileData.y, tostring(decorationDatas))
		return removedColorCoords
	end

	local removedColorCoords = removeDecorationDatas(tileData)
	for _, placeholderData in ipairs(tileData.placeholderDatas) do 
		local relatedTileData = mapData:getTileDataAtCoord(placeholderData.associatedCoord.x, placeholderData.associatedCoord.y)
		-- print("placeholderData has relatedTileData at", placeholderData.associatedCoord.x, placeholderData.associatedCoord.y)
		if relatedTileData then 

			-- check if neccessary to remove multi occupy tile decorations at this tile
			lume.concat(removedColorCoords, removeDecorationDatas(relatedTileData, placeholderData.associatedID))
			self:setTileDataDirty(mapData, relatedTileData)


			-- add by yueyingsong 强行修复了CO-4007 
			-- 与服务器沟通,服务器暂时没有时间完整支持此功能,客户端强行把它处理成最初的状态
			local otype = relatedTileData:getTerrainType()
			
			
			if otype then
				local tileData = mapData:getTileDataAtCoord(relatedTileData.x, relatedTileData.y)
				if tileData ~= nil then
					tileData:setTerrainType(otype)
					self:setTileDataDirty(mapData, tileData)
				end
			-- 	local tileData = self:createTileDataAtCoord(mapData, relatedTileData.x, relatedTileData.y, otype)
			-- 	self:setTileDataDirty(mapData, tileData)	
			end
			
		end
	end

	-- make tile datas dirty which has effect colors removed
	if removedColorCoords ~= nil and #removedColorCoords > 0 then
		for _, coord in ipairs(removedColorCoords) do
			local tileData = mapData:getTileDataAtCoord(coord.x, coord.y)
			if tileData ~= nil then
				self:setTileDataDirty(mapData, tileData)
			end
		end
	end

	local terrainData = tileData:getTerrainData()
	if terrainData == nil then
		local errstr = string.format("tileData has no terrainData at %d,%d", x, y)
		printError(errstr)
		return
	end

	self:setTerrainDataForType(mapData, terrainData, MapDefine.TerrainType.Ground)
	-- print ("update terrain at ", x, y, terrainData:getTerrainType(), tostring(terrainData:getTerrainNames()))
	-- make this tile data dirty 
	self:setTileDataDirty(mapData, tileData)

	if generateWallAround then
		local generatedWallTileDatas = self:generateWallAroundCoord(mapData, x, y)
		for _, tileData in ipairs(generatedWallTileDatas) do
			self:setTileDataDirty(mapData, tileData)
		end
	end 
end

function MapDataManager:generateWallAroundCoord(mapData, x, y)
	local generatedWallTileDatas = {}
	local AroundOffsets = MapDefine.AroundOffsets
	for _, offset in ipairs(AroundOffsets) do
		local aroundCoordX = x + offset.x
   		local aroundCoordY = y + offset.y
   		if mapData:isCoordInBounds(aroundCoordX, aroundCoordY) then
	   		local aroundTileData = mapData:getTileDataAtCoord(aroundCoordX, aroundCoordY)
	   		if aroundTileData ~= nil then
	   			local terrainData = aroundTileData:getTerrainData()
	   			if terrainData ~= nil and terrainData:getTerrainType() == MapDefine.TerrainType.None then
					self:setTerrainDataForType(mapData, terrainData, MapDefine.TerrainType.Wall)
					lume.push(generatedWallTileDatas, aroundTileData)
	   			end
	   		else 
	   			aroundTileData = MapTileData:create(aroundCoordX, aroundCoordY)
	   			if aroundTileData ~= nil then
	   				local terrainData = self:createTerrainDataForType(mapData, MapDefine.TerrainType.Wall)
	   				if terrainData ~= nil then
	   					aroundTileData:setTerrainData(terrainData)
	   					mapData:setTileDataAtCoord(aroundCoordX, aroundCoordY, aroundTileData)
	   					-- print ("create tile data at ", aroundCoordX, aroundCoordY)
						lume.push(generatedWallTileDatas, aroundTileData)
	   				end
	   			end
	   		end
	   	end
	end
	return generatedWallTileDatas
end

function MapDataManager:addRole(mapData, x, y, roleData)
	if(GameManager:getIsInNewScene()) then return end

	if(roleData == nil) then 
		return 
	end

	local tileData = mapData:getTileDataAtCoord(x, y)
	if tileData == nil then
		print("addRole is invalid in map ", x, y)
		return
	end
	
	-- if objectType == RoleType.None then
	-- 	print (("roleData ID %d do not belong to an object type"):format(roleData:getId()))
	-- 	return
	-- end
	for _, theRoleData in ipairs(tileData.roleDatas) do
		if theRoleData:getSpriteID() == roleData:getSpriteID() then
			-- print("addRole is already add ", roleData:getId(), roleData:getSpriteID(), tileData.x, tileData.y)
			return
		end
	end

	-- printfmt(string.format("addRole templateID:%d spriteID:%d category:%d type:%d isReachable:%s at %d,%d", roleData:getId(), roleData:getSpriteID(), roleData:getCategory(), roleData:getType(), tostring(tileData:isReachable()), tileData.x, tileData.y))

	-- -- Cuz roles can only exist on reachable tiles, so forced modify tile status to reachable
	if roleData:getCategory() == Category.TRIGGER_NPC then 
		if roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR or roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOX or roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC then
			self:transformTileToReachableAtCoord(mapData, x, y, true, true)
		elseif roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE or roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE then 
			self:transformTileToReachableAtCoord(mapData, x, y, false, true)
		end
	elseif roleData:getCategory() == Category.ROLE then 
		if roleData:getType() == RoleType.Monster then
			if not tileData:isReachable() then 
				-- if tileData:hasDecoration() then
				-- 	printfmt("---add role at unreachable decoration %d,%d", x, y)
				-- end
				self:transformTileToReachableAtCoord(mapData, x, y, true, false)
			end 

			-- 处理怪物装饰物
			-- local decorationID = tonumber(roleData:getDecorationId())
			-- if(decorationID ~= 0) then
				-- print("MapDataManager:addRole   ", decorationID)
				-- dump(self.decorationConfig)
				-- local decorationData = MapDecorationData:create(self.decorationConfig[decorationID])
				-- if decorationData ~= nil then
					-- tileData:addDecoration(decorationData)
					
					-- 刷新表现, 这里移动到view 里面在处理。
					-- mapData:updateTile(tileData)
					-- setDecorationRandomDirection(decorationData, decorationSpawnConfig)
					-- decorationData:setEffectColor(self:getColorForID(decorationData:getEffectColorID()))
				-- end
			-- end
		end
	end

	self:addPlaceholerData(mapData, x, y, roleData)

	-- 这里只需要处理可以移动的效果，容易导致 Placeholder 被移除
	if((roleData:getCategory() == Category.ROLE and roleData:getType() == RoleType.Hero) or 
		(roleData:getCategory() == Category.TRIGGER_NPC and roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.PATROL_NPC)) then
		-- 统一处理移除前一格数据，并且设置新加地图数据 add by zp
		local preAddCoord = roleData.preAddCoord
		if preAddCoord then
			self:removeRole(mapData,preAddCoord.x,preAddCoord.y,roleData)
		else
			preAddCoord = {}
			roleData.preAddCoord = preAddCoord
		end
		preAddCoord.x = x 
		preAddCoord.y = y 
	end

	tileData:addRole(roleData)
end

function MapDataManager:removeRole(mapData, x, y, roleData)
	if(GameManager:getIsInNewScene()) then return end

	if(not mapData or not x or not y or not roleData) then 
		printError("MapDataManager:removeRole  params have nil.")
		return 
	end

	-- 这里如果有保存的上次的位置就直接使用上次的位置
	if(roleData.preAddCoord and roleData.preAddCoord.x and roleData.preAddCoord.y) then 
		x = roleData.preAddCoord.x
		y = roleData.preAddCoord.y
	end 

	local tileData = mapData:getTileDataAtCoord(x, y)
	if tileData == nil then
		print(("coordinate %d,%d is invalid in map"):format(x, y))
		printError("MapDataManager:removeRole  not found tileData")
		return
	end

	self:removePlaceholderData(mapData, x, y, roleData)

	local objectType = roleData:getType()
	if objectType == RoleType.None then
		print (("roleData ID %d do not belong to an object type"):format(roleData:getId()))
		return
	end

	-- if roleData:getCategory() == Category.ROLE then 
	-- 	if roleData:getType() == RoleType.Monster then
	-- 		-- 处理怪物装饰物移除
	-- 		local decorationID = roleData:getDecorationId()
	-- 		if(decorationID ~= 0 and roleData:isToRemoveDecoration()) then
	-- 			tileData:removeDecorationForID(decorationID)
	-- 		end
	-- 	end
	-- end
	
	tileData:removeRole(roleData)
end

function MapDataManager:addPlaceholerData(mapData, x, y, roleData)
	-- 添加Placeholder 多格数据
	if roleData:getCategory() == Category.TRIGGER_NPC then
		local occupySize = roleData:getOccupySize()
		if(occupySize == nil or #occupySize ~= 2) then
			printError("TRIGGER_NPC occupySize error  templateID, category, type=", roleData:getId(), roleData:getCategory(), roleData:getType())
			return
		end

		local height = occupySize[2]
		local width = occupySize[1]
		
		if(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
			self:_addPlaceholerData(mapData, PlaceholerTypeName.TRIGGER_NPC, roleData:getSpriteID(), width, height, x, y, roleData:isReachable(), roleData:canBeNodeOfPath(), roleData:canBeEndOfPath(), GamePlaceholerType.CENTER)
		else
			self:_addPlaceholerData(mapData, PlaceholerTypeName.TRIGGER_NPC, roleData:getSpriteID(), width, height, x, y, roleData:isReachable(), roleData:canBeNodeOfPath(), roleData:canBeEndOfPath(), GamePlaceholerType.LEFT_BOTTOM)
		end

		-- 添加NPC气泡触发
		if(roleData:getType() ~= PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
			if(roleData:getTalkRange() and roleData:getTalkRange() ~= 0) then
				width = roleData:getTalkRange() * 2 + 1
				height = width
				-- print("MapDataManager:addPlaceholerData ", width, height, roleData:getTalkRange())
				-- dump(roleData)
				self:_addPlaceholerData(mapData, PlaceholerTypeName.NPC_INFOMATION, roleData:getSpriteID(), width, height, x, y, true, true, true, GamePlaceholerType.CENTER)
			end
		end
	elseif roleData:getCategory() == Category.ROLE then
		if(roleData:getType() == RoleType.Monster) then
			if (not roleData:getIsTrigger()) and (roleData:getMonsterSubType() == PublicDefine.MonsterSubType.Trigger or roleData:getMonsterSubType() == PublicDefine.MonsterSubType.Treasure) then
				self:_addPlaceholerData(mapData, PlaceholerTypeName.TRIGGER_MONSTER_TITLE, roleData:getSpriteID(), 1, 1, x, y, true, true, true, GamePlaceholerType.CROSS)
			else
				local occupySize = roleData:getOccupySize()
				if(occupySize == nil or #occupySize ~= 2) then
					printError("Monster occupySize error  templateID, category, type=", roleData:getId(), roleData:getCategory(), roleData:getType())
					return
				end

				local height = occupySize[2]
				local width = occupySize[1]
				self:_addPlaceholerData(mapData, PlaceholerTypeName.MONSTER, roleData:getSpriteID(), width, height, x, y, roleData:isReachable(), roleData:canBeNodeOfPath(), roleData:canBeEndOfPath(), GamePlaceholerType.LEFT_BOTTOM)
			end
		end
	end
end

function MapDataManager:removePlaceholderData(mapData, x, y, roleData)
	-- 移除Placeholder 多格处理
	-- print("MapDataManager:removePlaceholderData  ", roleData:getCategory(), roleData:getType())
	if roleData:getCategory() == Category.TRIGGER_NPC then
		local occupySize = roleData:getOccupySize()
		local height = occupySize[2]
		local width = occupySize[1]
		if(occupySize == nil or #occupySize ~= 2) then
			printError("removePlaceholderData TRIGGER_NPC occupySize error  templateID, category, type=", roleData:getId(), roleData:getCategory(), roleData:getType())
			return
		end

		if(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
			self:_removePlaceholderData(mapData, roleData:getSpriteID(), width, height, x, y, GamePlaceholerType.CENTER)
		else
			self:_removePlaceholderData(mapData, roleData:getSpriteID(), width, height, x, y, GamePlaceholerType.LEFT_BOTTOM)
		end

		if(roleData:getType() ~= PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
			if(roleData:getTalkRange() and roleData:getTalkRange() ~= 0) then
				width = roleData:getTalkRange() * 2 + 1
				height = width
				self:_removePlaceholderData(mapData, roleData:getSpriteID(), width, height, x, y, GamePlaceholerType.CENTER)
			end
		end
	elseif roleData:getCategory() == Category.ROLE then
		if(roleData:getType() == RoleType.Monster) then
			if roleData:getIsTrigger() and (roleData:getMonsterSubType() == MonsterSubType.Trigger or roleData:getMonsterSubType() == MonsterSubType.Treasure) then
				self:_removePlaceholderData(mapData, roleData:getSpriteID(), 1, 1, x, y, GamePlaceholerType.CROSS)
			else
				local occupySize = roleData:getOccupySize()
				if(occupySize == nil or #occupySize ~= 2) then
					printError("removePlaceholderData Monster occupySize error  templateID, category, type=", roleData:getId(), roleData:getCategory(), roleData:getType())
					return
				end

				local height = occupySize[2]
				local width = occupySize[1]
				self:_removePlaceholderData(mapData, roleData:getSpriteID(), width, height, x, y, GamePlaceholerType.LEFT_BOTTOM)
			end
		end
	end
end

function MapDataManager:setPathFindRange(range)
	assert(type(range) == "number")

	-- 寻路范围只能是基数
	if (range % 2 == 0) then range = range + 1 end
	self.pathFindRange = range
end

-- 将XY默认顺序宽高和width, height命名的宽高统一返回为 宽, 高
local getOccupyWidthAndHeight = function (occupySize)
	if lume.isarray(occupySize) and #occupySize >= 2 then 
		return occupySize[1], occupySize[2]
	else 
		return occupySize.width, occupySize.height
	end
end

-- 用一个格子的景物计算占地并记录进数组t, 可有中空
local getTempReachableCoords = function (data, targetx, targety, filterx, filtery, t)
	if data.occupySize == nil or type(t) ~= "table" then 
		return 
	end
	local w, h = getOccupyWidthAndHeight(data.occupySize)
	if w <= 1 and h <= 1 then
		return 
	end

	for y = targety, targety + h - 1 do
		for x = targetx, targetx + w - 1 do
			if not (x == filterx and y == filtery) then
				local coord = {x = x, y = y}
				if lume.find(coord) == nil then
					lume.push(t, coord )
				end
			end
		end
	end
end

-- 根据一格地图格子数据，处理是否可以到达的数据收集
local addOneMapTileDataToReachable = function(mapData, targetTileData, makeReachableCoords, tx,ty)
	local isMonster = false
	local monsterData = nil
	if(targetTileData) then 
		-- print("addOneMapTileDataToReachable", #targetTileData.decorationDatas, #targetTileData.roleDatas, #targetTileData.placeholderDatas)
		if #targetTileData.decorationDatas > 0 then
			for _, decorationData in ipairs(targetTileData.decorationDatas) do
				if not decorationData:isReachable() then
					getTempReachableCoords(decorationData, tx, ty, tx, ty, makeReachableCoords)
				end
			end
		end
		if #targetTileData.roleDatas > 0 then 
			for _, roleData in ipairs(targetTileData.roleDatas) do
				if(roleData:getCategory() == Category.ROLE and roleData:getType() == RoleType.Monster ) then 
					isMonster = true
					monsterData = roleData
				end
				if not roleData:isReachable() then
					getTempReachableCoords(roleData, tx, ty, tx, ty, makeReachableCoords)
				end
			end
		end 
		if #targetTileData.placeholderDatas > 0 then
			for _, placeholderData in ipairs(targetTileData.placeholderDatas) do
				if not placeholderData:isReachable() or placeholderData:canBeEndOfPath() then
					local associatedCoord = placeholderData.associatedCoord
					local associatedTileData = mapData:getTileDataAtCoord(associatedCoord.x, associatedCoord.y)
					if associatedTileData ~= nil then
						if #associatedTileData.roleDatas > 0 then 
							for _, roleData in ipairs(associatedTileData.roleDatas) do
								if(roleData:getCategory() == Category.ROLE and roleData:getType() == RoleType.Monster ) then 
									isMonster = true
									monsterData = roleData
								end
							end
						end

						if not placeholderData:isReachable() then
							if #associatedTileData.decorationDatas > 0 then
								for _, decorationData in ipairs(associatedTileData.decorationDatas) do
									if not decorationData:isReachable() then
										getTempReachableCoords(decorationData, associatedCoord.x, associatedCoord.y, tx, ty, makeReachableCoords)
									end
								end
							end 
							if #associatedTileData.roleDatas > 0 then 
								for _, roleData in ipairs(associatedTileData.roleDatas) do
									if(roleData:getCategory() == Category.ROLE and roleData:getType() == RoleType.Monster ) then 
										isMonster = true
										monsterData = roleData
									end
									if not roleData:isReachable() then
										getTempReachableCoords(roleData, associatedCoord.x, associatedCoord.y, tx, ty, makeReachableCoords)
									end
								end
							end
						end 
					end
				end
				
			end
		end
	end

	return isMonster, monsterData
end

-- 把该tileData 涉及到的角色坐标添加到可寻路列表里面
local addOneMapTitleDataReachableAndBeEndOfPath = function(mapData, targetTileData, makeReachableCoords, tx,ty)
	-- if #targetTileData.decorationDatas > 0 then
	-- 	for _, decorationData in ipairs(targetTileData.decorationDatas) do
	-- 		if not decorationData:isReachable() or decorationData:canBeEndOfPath() then
	-- 			getTempReachableCoords(decorationData, tx, ty, tx, ty, makeReachableCoords)
	-- 		end
	-- 	end
	-- end 
	if #targetTileData.roleDatas > 0 then 
		for _, roleData in ipairs(targetTileData.roleDatas) do
			if not roleData:isReachable() or roleData:canBeEndOfPath() then
				getTempReachableCoords(roleData, tx, ty, tx, ty, makeReachableCoords)
			end
		end
	end 
	if #targetTileData.placeholderDatas > 0 then
		for _, placeholderData in ipairs(targetTileData.placeholderDatas) do
			if not placeholderData:isReachable() or placeholderData:canBeEndOfPath() then
				local associatedCoord = placeholderData.associatedCoord
				local associatedTileData = mapData:getTileDataAtCoord(associatedCoord.x, associatedCoord.y)
				if associatedTileData ~= nil then
					-- if #associatedTileData.decorationDatas > 0 then
					-- 	for _, decorationData in ipairs(associatedTileData.decorationDatas) do
					-- 		if  not decorationData:isReachable() or decorationData:canBeEndOfPath() then
					-- 			getTempReachableCoords(decorationData, associatedCoord.x, associatedCoord.y, tx, ty, makeReachableCoords)
					-- 		end
					-- 	end
					-- end 
					if #associatedTileData.roleDatas > 0 then 
						for _, roleData in ipairs(associatedTileData.roleDatas) do
							if not roleData:isReachable() or roleData:canBeEndOfPath() then
								getTempReachableCoords(roleData, associatedCoord.x, associatedCoord.y, tx, ty, makeReachableCoords)
							end
						end
					end
				end
			end
		end
	end
end

-- 获取最小距离点
local getMinLength = function(sx,sy,tx,ty,coord,w,h)
	local calcuLength = function(sx,sy,ex,ey)
		return math.abs(ex-sx) + math.abs(ey-sy)
	end

	local endX = tx
	local endY = ty
	local minLength = 10000
	for i=coord.x, coord.x + w -1 do 
		local nowLength = calcuLength(sx,sy,i,coord.y)
		if(minLength > nowLength) then
			minLength = nowLength
			endX = i
			endY = coord.y
		end

		local nowLength = calcuLength(sx,sy,i,coord.y + h - 1)
		if(minLength > nowLength) then
			minLength = nowLength
			endX = i
			endY = coord.y + h - 1
		end
	end

	for i=coord.y, coord.y + h -1 do 
		local nowLength = calcuLength(sx,sy,coord.x, i)
		if(minLength > nowLength) then
			minLength = nowLength
			endX = coord.x
			endY = i
		end
		
		local nowLength = calcuLength(sx,sy,coord.x + w -1, i)
		if(minLength > nowLength) then
			minLength = nowLength
			endX = coord.x + w -1
			endY = i
		end
	end

	return endX, endY
end

-- Find Path
function MapDataManager:findPath(mapData, sx, sy, tx, ty, briefPath)
	-- 判断目标点是否为怪物
	local isMonster = false
	local monsterData = nil
	local refreshBeEndNode = false

	-- 用以上方法判断目标地点的占地
	local makeReachableCoords = {}
	local targetTileData = mapData:getTileDataAtCoord(tx, ty)	
	if targetTileData ~= nil then
		isMonster,monsterData = addOneMapTileDataToReachable(mapData, targetTileData, makeReachableCoords, tx,ty)
		-- print("MapDataManager:findPath", isMonster)
		-- 这里对于点击的是怪物所占格子的特殊处理
		if(isMonster) then
			local w, h = getOccupyWidthAndHeight(monsterData.occupySize)
			-- 屏蔽掉只占一格的怪物
			if(w >1 or h > 1) then
				-- 计算怪物所占格子离角色最近的点来寻路
				local coord = monsterData:getCoord()
				
				tx,ty = getMinLength(sx, sy, tx, ty, coord, w, h)

				refreshBeEndNode = true
			end
		end
		
		-- if(refreshBeEndNode) then
		-- 	addOneMapTitleDataReachableAndBeEndOfPath(mapData, targetTileData, makeReachableCoords, tx,ty)
		-- end
	end
	
	-- 用地图数据来创建一个findRange指定大小的假想棋盘
	-- 下面设定的walkable数值为能通过, 其余数值为不能通过
    local brief = briefPath or false
    -- print("  (sx, sy, tx, ty))
    local findRange = self.pathFindRange or 21 -- 只能是奇数
    local findRadius = math.floor(findRange / 2)
    local localMap = grids.make(findRange, findRange, -1)
    for y = sy - findRadius, sy + findRadius do
    	local iy = y - sy + findRadius + 1
    	for x = sx - findRadius, sx + findRadius do
    		local ix = x - sx + findRadius + 1
    		local tileData = mapData:getTileDataAtCoord(x, y)
    		if tileData ~= nil then
    			if x == tx and y == ty then
    				if tileData:isReachable() then 
    					localMap[iy][ix] = 0
    				else 
    					if tileData:canBeEndOfPath() then
	    					localMap[iy][ix] = 0
	    				else 
	    					localMap[iy][ix] = 1
	    				end
    				end
    			else
    				if tileData:isReachable() and tileData:canBeNodeOfPath() then
    					localMap[iy][ix] = 0
    				else 
    					localMap[iy][ix] = 1
    				end
    			end
    		end
    	end
    end

    -- 往假想网格上加入上面的结束点坐标数据
    for _, coord in ipairs(makeReachableCoords) do 
		local iy = coord.y - sy + findRadius + 1    		
		local ix = coord.x - sx + findRadius + 1
		if ix > 0 and iy > 0 and ix <= findRange and iy <= findRange then
	 		localMap[iy][ix] = 0
	 	end
    end

    -- 用上面生成的假想棋盘来寻路, 调用Roland Yonaba的PathFinder
    local grid = Grid(localMap)
    local walkable = 0
	local finder = Pathfinder(grid, 'ASTAR', walkable) 
	finder:setMode("ORTHOGONAL")
    local path, length = finder:getPath(findRadius + 1, findRadius + 1, tx - sx + findRadius + 1, ty - sy + findRadius + 1)
    if path then
        -- print(('Path found! Length: %.2f'):format(length))
        path = self:getKeyPath(path, brief, sx, sy, findRadius) 
        -- for i, node in ipairs(path) do
        --     print(('Step: %d - x: %d - y: %d'):format(i, node.x, node.y))
        -- end
    end
    return path, length
end

function MapDataManager:getKeyPath(path, brief, sx, sy, findRadius)
    local p = {}
    -- print ("path:")
    for node, count in path:iter() do
        lume.push(p, {x = node.x + sx - findRadius - 1, y = node.y + sy - findRadius - 1})
        -- print (node.x, node.y)
    end 

    if not brief then
        return p
    end

    local newpath = {}
    local keynode = p[1]
    local n = p[1]
    local c = #p
    for i = 2, c do
        node = p[i]
        if (keynode.x ~= node.x and keynode.y == node.y) or (keynode.y ~= node.y and keynode.x == node.x) then 
            -- print ("path straight")
        else
            -- print ("path turn push ", keynode.x, keynode.y)
            lume.push(newpath, keynode)
            keynode = n
        end
        n = p[i]
        if i == c then
            -- print ("path push ", keynode.x, keynode.y)
            lume.push(newpath, keynode)
            -- print ("path push ", node.x, node.y)
            lume.push(newpath, node)
        end
    end

    return newpath
end

-- Helper Methods

function MapDataManager:getRandomSeparateTile(mapData, terrainType, gridMap)
	local checkFunc = function (tileData) 
		local count = mapData:getAdjacentTerrainCountAtCoordinate(tileData.x, tileData.y, terrainType)
		return count == 0
	end
	local tileData = self:getRandomTileForTerrainType(mapData, terrainType, gridMap, checkFunc)
	
	return tileData
end

function MapDataManager:getRandomTileForTerrainType(mapData, terrainType, gridMap, checkFunc)
	assert(terrainType ~= nil and terrainType > MapDefine.TerrainType.None and terrainType <= MapDefine.TerrainType.Wall, "terrainType must be non-nil and legal")
	local check = checkFunc or function (tileData) return true end
	assert(type(check) == "function", "invalid check function")
	assert(#mapData.usedTileDatas > 0, "mapData invalid, used tile 0")

	local tileIndexes = {}
	local tileCount = #mapData.usedTileDatas
	for i = 1, tileCount do
		tileIndexes[i] = i
	end
	local randIndex = map_random(1, #tileIndexes)
	local tileIndex = tileIndexes[randIndex]
	local tileData = mapData.usedTileDatas[tileIndex]
	table.remove(tileIndexes, randIndex)

	while (tileData == nil or not gridMap:canGenerate(tileData.x, tileData.y)
	 or tileData:getTerrainType() ~= terrainType
	 or not check(tileData)) and #tileIndexes ~= 0 do
	 	randIndex = map_random(1, #tileIndexes)
		tileIndex = tileIndexes[randIndex]
		tileData = mapData.usedTileDatas[tileIndex]
		table.remove(tileIndexes, randIndex)
	end

	if tileData == nil or tileData:getTerrainType() ~= terrainType or not check(tileData) then
		-- print("get random tile failed", terrainType)
		return nil
	end
	-- print("get random tile succeeded", tileData:getX(), tileData:getY(), tileData:getTerrainType(), terrainType)
	return tileData
end 

-- Configs Helper

function MapDataManager:getColorForID(ID)
	return self.colorConfig[ID]
end

function MapDataManager:getTotalColors()
	local colors = {} 
	for k, color in pairs(self.effectColorConfig) do
		-- lume.push(colors, {r = color.r, g = color.g, b = color.b});
		lume.push(colors, color)
	end
	colors = lume.sort(colors, "ID")
	return colors
end 


-- private 
function MapDataManager:_addPlaceholerData(mapData, typeName, spriteID, width, height, x, y, reachable, nodeOfPath, endOfPath, placeholerType, disbaleChamber)
	if disbaleChamber == nil then 
		disbaleChamber = false
	end

	if ( placeholerType == nil or placeholerType == GamePlaceholerType.LEFT_BOTTOM) then
		for iy = 1, height do 
			for ix = 1, width do
				if ix == 1 and iy == 1 then
				else 
					local cx, cy = x + ix - 1, y + iy - 1
					local tileData = mapData:getTileDataAtCoord(cx, cy)
					if tileData ~= nil then
						if(disbaleChamber) then
							-- print("MapDataManager:_addPlaceholerData  LEFT_BOTTOM spriteID, cx, cy=", spriteID, cx, cy)
							if mapData:isCoordInChamber(tileData.x, tileData.y) == false then
								local placeholderData = MapPlaceholderData:create(typeName, spriteID, {x = x, y = y}, reachable, nodeOfPath, endOfPath)
								lume.push(tileData.placeholderDatas, placeholderData)
							end
						else
							-- print("MapDataManager:_addPlaceholerData  LEFT_BOTTOM spriteID, cx, cy=", spriteID, cx, cy)
							local placeholderData = MapPlaceholderData:create(typeName, spriteID, {x = x, y = y}, reachable, nodeOfPath, endOfPath)
							lume.push(tileData.placeholderDatas, placeholderData)
						end
					end
				end
			end
		end
	elseif(placeholerType == GamePlaceholerType.CENTER) then
		-- print("MapDataManager:_addPlaceholerData  CENTER pre x, y=", x, y)
		local sx = x - (width - 1) / 2
		local sy = y - (height - 1) / 2
		-- print("MapDataManager:_addPlaceholerData  CENTER handle x, y, cx, cy=",x, y, width, height)
		for iy = 1, height do 
			for ix = 1, width do
				local cx, cy = sx + ix - 1, sy + iy - 1
				if cx == x and cy == y then
				else 
					local tileData = mapData:getTileDataAtCoord(cx, cy)
					-- if tileData ~= nil and tileData:isReachable() then
					if(tileData ~= nil) then
						if(disbaleChamber) then
							-- print("MapDataManager:_addPlaceholerData  CENTER spriteID, cx, cy=", spriteID, cx, cy)
							if mapData:isCoordInChamber(tileData.x, tileData.y) == false then
								local placeholderData = MapPlaceholderData:create(typeName, spriteID, {x = x, y = y}, reachable, nodeOfPath, endOfPath)
								lume.push(tileData.placeholderDatas, placeholderData)
							end
						else
							-- print("MapDataManager:_addPlaceholerData  CENTER spriteID, cx, cy=", spriteID, cx, cy)
							local placeholderData = MapPlaceholderData:create(typeName, spriteID, {x = x, y = y}, reachable, nodeOfPath, endOfPath)
							lume.push(tileData.placeholderDatas, placeholderData)
						end
					end
				end
			end
		end
	elseif(placeholerType == GamePlaceholerType.CROSS) then
		local tileData = mapData:getTileDataAtCoord(x + 1, y)
		if tileData ~= nil then
			-- print("MapDataManager:_addPlaceholerData  CROSS spriteID, cx, cy=", spriteID, x + 1, y)
			local placeholderData = MapPlaceholderData:create(typeName, spriteID, {x = x, y = y}, reachable, nodeOfPath, endOfPath)
			lume.push(tileData.placeholderDatas, placeholderData)
		end

		local tileData = mapData:getTileDataAtCoord(x - 1, y)
		if tileData ~= nil then
			-- print("MapDataManager:_addPlaceholerData  CROSS spriteID, cx, cy=", spriteID, x - 1, y)
			local placeholderData = MapPlaceholderData:create(typeName, spriteID, {x = x, y = y}, reachable, nodeOfPath, endOfPath)
			lume.push(tileData.placeholderDatas, placeholderData)
		end

		local tileData = mapData:getTileDataAtCoord(x, y + 1)
		if tileData ~= nil then
			-- print("MapDataManager:_addPlaceholerData  CROSS spriteID, cx, cy=", spriteID, x, y +1)
			local placeholderData = MapPlaceholderData:create(typeName, spriteID, {x = x, y = y}, reachable, nodeOfPath, endOfPath)
			lume.push(tileData.placeholderDatas, placeholderData)
		end

		local tileData = mapData:getTileDataAtCoord(x, y - 1)
		if tileData ~= nil then
			-- print("MapDataManager:_addPlaceholerData  CROSS spriteID, cx, cy=", spriteID, x, y - 1)
			local placeholderData = MapPlaceholderData:create(typeName, spriteID, {x = x, y = y}, reachable, nodeOfPath, endOfPath)
			lume.push(tileData.placeholderDatas, placeholderData)
		end

	else
		assert(false,"_addPlaceholerData placeholerType="..placeholerType)
	end
end

function MapDataManager:_removePlaceholderData(mapData, spriteID, width, height, x, y, placeholerType)
	if ( placeholerType == nil or placeholerType == GamePlaceholerType.LEFT_BOTTOM) then
		for iy = 1, height do 
			for ix = 1, width do
				if ix == 1 and iy == 1 then
				else 
					local cx, cy = x + ix - 1, y + iy - 1
					local tileData = mapData:getTileDataAtCoord(cx, cy)
					if tileData ~= nil then
						for i = 1, #tileData.placeholderDatas do
							local placeholderData = tileData.placeholderDatas[i]
							if(placeholderData and placeholderData:getAssocialtedID() == spriteID) then
								-- print("MapDataManager:_removePlaceholderData  spriteID, cx, cy=", spriteID, cx, cy)
								lume.remove(tileData.placeholderDatas, placeholderData)
								break
							end
						end
					end
				end
			end
		end
	elseif(placeholerType == GamePlaceholerType.CENTER) then
		local sx = x - (width - 1) / 2
		local sy = y - (height - 1) / 2

		for iy = 1, height do 
			for ix = 1, width do
				local cx, cy = sx + ix - 1, sy + iy - 1
				if cx == x and cy == y then
				else 
					local tileData = mapData:getTileDataAtCoord(cx, cy)
					if tileData ~= nil then
						for i = 1, #tileData.placeholderDatas do
							local placeholderData = tileData.placeholderDatas[i]
							if(placeholderData and placeholderData:getAssocialtedID() == spriteID) then
								-- print("MapDataManager:_removePlaceholderData CENTER  spriteID, cx, cy=", spriteID, cx, cy)
								lume.remove(tileData.placeholderDatas, placeholderData)
								break
							end
						end
					end
				end
			end
		end
	elseif (placeholerType == GamePlaceholerType.CROSS) then
		local tileData = mapData:getTileDataAtCoord(x + 1, y)
		if tileData ~= nil and tileData:isReachable() then
			for i = 1, #tileData.placeholderDatas do
				local placeholderData = tileData.placeholderDatas[i]
				if(placeholderData and placeholderData:getAssocialtedID() == spriteID) then
					-- print("MapDataManager:_removePlaceholderData CENTER  spriteID, cx, cy=", spriteID, cx, cy)
					lume.remove(tileData.placeholderDatas, placeholderData)
					break
				end
			end
		end

		local tileData = mapData:getTileDataAtCoord(x - 1, y)
		if tileData ~= nil and tileData:isReachable() then
			for i = 1, #tileData.placeholderDatas do
				local placeholderData = tileData.placeholderDatas[i]
				if(placeholderData and placeholderData:getAssocialtedID() == spriteID) then
					-- print("MapDataManager:_removePlaceholderData CENTER  spriteID, cx, cy=", spriteID, cx, cy)
					lume.remove(tileData.placeholderDatas, placeholderData)
					break
				end
			end
		end

		local tileData = mapData:getTileDataAtCoord(x, y + 1)
		if tileData ~= nil and tileData:isReachable() then
			for i = 1, #tileData.placeholderDatas do
				local placeholderData = tileData.placeholderDatas[i]
				if(placeholderData and placeholderData:getAssocialtedID() == spriteID) then
					-- print("MapDataManager:_removePlaceholderData CENTER  spriteID, cx, cy=", spriteID, cx, cy)
					lume.remove(tileData.placeholderDatas, placeholderData)
					break
				end
			end
		end

		local tileData = mapData:getTileDataAtCoord(x, y - 1)
		if tileData ~= nil and tileData:isReachable() then
			for i = 1, #tileData.placeholderDatas do
				local placeholderData = tileData.placeholderDatas[i]
				if(placeholderData and placeholderData:getAssocialtedID() == spriteID) then
					-- print("MapDataManager:_removePlaceholderData CENTER  spriteID, cx, cy=", spriteID, cx, cy)
					lume.remove(tileData.placeholderDatas, placeholderData)
					break
				end
			end
		end
	else
		assert(false,"_removePlaceholderData  placeholerType="..placeholerType)
	end
end

function MapDataManager:parseSuspendedConfig(suspendedIds)
    -- print("  ----- MapDataManager:parseSuspendedConfig  suspendedIds = ", suspendedIds)
    local ids = string.split(suspendedIds, ",")
    local cfgList = {}
    for k, v in ipairs(ids) do
    	local cfgData = self.suspendedConfig[tonumber(v)]
        if cfgData then
        	table.insert(cfgList, cfgData)
        end
    end
    return cfgList
end

function MapDataManager:isInActHuluChangeDungeon(config)
	local dungeonLevel = config.level
	if config.caveMode == PublicDefine.CAVE_MODE.MODE_ACT then
        if dungeonLevel > PublicDefine.CONST_DEFINITION.HULU_MAP_ID and dungeonLevel < PublicDefine.CONST_DEFINITION.HULU_MAP_ID + PublicDefine.CONST_DEFINITION.HULU_MAP_NUM -1 then
            return true
        end
    end

	return false
end

function MapDataManager:getDungeonLevel(config)
	local dungeonLevel = config.level
	if(self:isInActHuluChangeDungeon(config)) then 
		local levelConfig = self:getCommondModeLevelConfig(config.level, config.difficulty or 0, config.caveMode or 0)
		if(levelConfig) then
			dungeonLevel = levelConfig.configMapID
		end
	else
		dungeonLevel = MapGenerater.adjustDungeonLevel(config.level, config.type)
	end

	return dungeonLevel
end

return MapDataManager