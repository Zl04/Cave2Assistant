--[[
    处理地图
]]

local MapDataManager = require "app.mapkit.model.MapDataManager"
local MapGen = require "app.mapkit.MapGenerater"
local grids = require "app.mapkit.grids"
local MapHelper = require "app.mapkit.MapHelper"
local TextureAtlasOverlayer = require "app.mapkit.TextureAtlasOverlayer"
local MapDefine = require "app.mapkit.MapDefine"
local lume = require "thirdparty.lume"
local TextureAtlasOverlayConfig = require "app.mapkit.TextureAtlasOverlayConfig"

local SCENE_TYPE = PublicDefine.SCENE_TYPE
local CAVE_DIFFICULTY = PublicDefine.CAVE_DIFFICULTY
local CAVE_MODE = PublicDefine.CAVE_MODE

local GameMapManager = class("GameMapManager")

function GameMapManager:getInstance()
    if g_GameMapManager == nil then
        g_GameMapManager = GameMapManager.new();
    end
    return g_GameMapManager;
end

function GameMapManager:purgeInstance()
    if g_GameMapManager ~= nil then
        g_GameMapManager = nil;
    end
end

function GameMapManager:ctor()
    self._mapData = nil;            --存放地图数据
    self._subMapData = nil;         --二级地图数据
end

-- 获取地图数据
function GameMapManager:getMapData()
    local SceneManager = require("app.game.SceneManager")
    if SceneManager:getInstance():isInPetPVP() then
        return self._subMapData
    else
        return self._mapData
    end
end

-- 获取场景类型
function GameMapManager:getSceneType()
    local mapData = self:getMapData()
    if(mapData) then
        return mapData.sceneType
    end

    return SCENE_TYPE.INVALID
end

-- 获取层数
function GameMapManager:getLevel()
    local mapData = self:getMapData()
    if(mapData) then
        return mapData.level
    end

    return 0
end


function GameMapManager:getModel()
    local mapData = self:getMapData()
    if(mapData) then
        return mapData:getCaveMode()
    end

    return CAVE_MODE.MODE_NORMAL
end

-- 获取当前难度
function GameMapManager:getDifficulty()
    local mapData = self:getMapData()
    if(mapData) then
        return mapData:getDifficulty()
    end

    return CAVE_DIFFICULTY.INVALID_DIFFICULTY
end

-- 获取是否从组队拷贝的副本
function GameMapManager:getIsCopyFromTeam()
    local mapData = self:getMapData()
    if(mapData) then
        return mapData:getIsCopyFromTeam()
    end

    return false
end 

-- 获取梦境当前等级
function GameMapManager:getDreamLV()
    local mapData = self:getMapData()
    if(mapData) then
        return mapData:getDreamLV()
    end

    return false
end 

-- 获取梦境当前BOSS
function GameMapManager:getDreamCurBossIndex()
    local mapData = self:getMapData()
    if(mapData) then
        return mapData:getDreamCurBossIndex()
    end

    return false
end 

-- 获取是否可以更新存档点
function GameMapManager:getUpdateCheckPT()
    local mapData = self:getMapData()
    if(mapData) then
        return mapData:getUpdateCheckPT()
    end

    return true
end

-- 获取是否可以快速下楼
function GameMapManager:getCanQuickDown()
    local mapData = self:getMapData()
    if(mapData) then
        return mapData:getCanQuickDown()
    end

    return false
    -- return true
end

-- 设置是否可以快速下楼
function GameMapManager:setCanQuickDown(canQuickDown)
    local mapData = self:getMapData()
    if(mapData) then
        mapData:setCanQuickDown(canQuickDown)
    end
end

-- 加载地图数据
function GameMapManager:loadMapDataForState(mapConfig)
    -- printfmt("mapConfig" .. tostring(mapConfig))

    if mapConfig.randSeed ~= nil and mapConfig.randSeed ~= 0 then
        MapGen.setRandomSeed(mapConfig.randSeed)
        print("set map generation random seed ", mapConfig.randSeed)
    else 
        MapGen.setRandomSeed(math.random())
    end
    
    local mapTerrainGrids, configMapID, mapAppearanceID, dungeonRoomDatas = nil, nil, nil, nil
    local mapData = MapDataManager:getInstance():generateMap(mapTerrainGrids, mapConfig, configMapID, mapAppearanceID, dungeonRoomDatas)
    if mapData == nil then
        assert(false, "generate map data failed")
    end
    
    if mapConfig.caveMode == PublicDefine.CAVE_MODE.MODE_PET then
        self._subMapData = mapData
    else
        self._mapData = mapData
    end
    return mapData
end



function GameMapManager:loadMapResForState(callback)
    local mapData = self:getMapData()
    assert(mapData, "[ERROR] [Resource Manager] map data is nil.")
    local isTownOrGuild = mapData.sceneType == PublicDefine.SCENE_TYPE.TOWN 
        or mapData.sceneType == PublicDefine.SCENE_TYPE.GUILD
        or mapData.sceneType == PublicDefine.SCENE_TYPE.TOWN_CAVE
        or mapData.sceneType == PublicDefine.SCENE_TYPE.MANOR
        or mapData.sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT
    -- only cave maps need to generate texture atlas overlayed of tile
    if not isTownOrGuild or mapData.caveMode == PublicDefine.CAVE_MODE.MODE_PET then
        -- 洞内重叠图片生成信息
        TextureAtlasOverlayer.loadOverlaysFromMapAppearance(mapData.appearanceConfig, function()
            if (callback) then
                callback()
            end
        end)
    else
        -- 直接返回
        if (callback) then
            callback()
        end
    end
end

-- 卸载地图资源
function GameMapManager:unloadMapResForState()
    local mapData = self:getMapData()
    if(mapData) then
        local config = mapData.appearanceConfig
        local name = config.name
        local framePageInfos = TextureAtlasOverlayer.getFramePageInfos(name)
        if framePageInfos ~= nil then
            TextureAtlasOverlayer.removeSpriteFramesForFramePageInfos(framePageInfos)
        end
        local wallName = name.."_wall"
        local framePageInfos = TextureAtlasOverlayer.getFramePageInfos(wallName)
        if framePageInfos ~= nil then
            TextureAtlasOverlayer.removeSpriteFramesForFramePageInfos(framePageInfos)
        end
        TextureAtlasOverlayer.setFramePageInfos(wallName, nil)
        local groundName = name.."_ground"
        local framePageInfos = TextureAtlasOverlayer.getFramePageInfos(groundName)
        if framePageInfos ~= nil then
            TextureAtlasOverlayer.removeSpriteFramesForFramePageInfos(framePageInfos)
        end
        TextureAtlasOverlayer.setFramePageInfos(groundName, nil)
    end
end

return GameMapManager;