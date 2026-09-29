--[[
    公会中的游戏管理
]]--

require "app.town.TownMachine"
require "app.battle.BattleMachine"
require "app.game.GameLoadManager"

local SceneManager = require("app.game.SceneManager")
local TownLayer = require "app.scene.townscene.TownLayer"
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
local MapDataManager = require "app.mapkit.model.MapDataManager"
local WeatherManager = require("app.game.WeatherManager")
local MapDefine = require "app.mapkit.MapDefine"

local PACKET_SUB_TYPE = PublicDefine.PACKET_SUB_TYPE

local GameInGuildManager = class("GameInGuildManager", GameLoadManager)
g_GameInGuildManager = nil;

-- 主城压力测试
local TOWN_PRESSURE_TEST_HERO_COUNT = 40
function GameInGuildManager:startTownPressureTest()
    local mapData = GameMapManager:getInstance():getMapData()
    local mapWidth, mapHeight = mapData:getSize()

    print(string.format("GameInGuildManager startTownPressureTest: map data size %f %f.", mapWidth, mapHeight))

    -- math.randomseed(os.time())
    for i = 1, TOWN_PRESSURE_TEST_HERO_COUNT do
        local coordX = 31
        local coordY = 22
        local tileData = nil
        -- repeat
        --     coordX = math.random(0, mapWidth-1)
        --     coordY = math.random(0, mapHeight-1)
        --     tileData = mapData:getTileDataAtCoord(coordX, coordY)
        -- until (tileData and tileData:getTerrainType() == MapDefine.TerrainType.Ground)

        print(string.format("GameInGuildManager startTownPressureTest: i %d  role coord %f %f.", i, coordX, coordY))

        local heroDataMessage = {
            pk = 10000 + i,
            spriteID = 10000 + i,
            nickName = "猜猜我是谁",
            occupation = 1,
            coordX = coordX,
            coordY = coordY,
        }
        local heroData = Data.HeroData:create()
        heroData:changeInit(heroDataMessage)
        heroData:handleAttr(heroDataMessage.attr)

        -- 生成创建测试角色的命令
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SCREENHERO, heroData)
        self:_pushCommand(command)
    end
end

function GameInGuildManager:getInstance()
    if g_GameInGuildManager == nil then
        g_GameInGuildManager = GameInGuildManager.new()
    end
    return g_GameInGuildManager;
end


function GameInGuildManager:purgeInstance()
    if g_GameInGuildManager ~= nil then
        g_GameInGuildManager = nil;
    end
end

function GameInGuildManager:ctor()
    GameInGuildManager.super.ctor(self)
    
    self._townMapData = nil

    -- 统计加载资源次数
    self._countLoadUIRes = 0
    self._countLoadSpineRes = 0
end


local LOADED_STEPS = 4
local NEXT_STEP_INTERVAL = 0.05

-- 加载的动画资源列表
local GAME_IN_GUILD_SPINE_RES_LIST = {

}

local GAME_IN_GUILD_UI_RES_PLISTS = {

}

-- 初始化,目前没用
function GameInGuildManager:initForInTownState()

end

-- 添加命令
function GameInGuildManager:pushCommandForInGuildState(command)
    -- print("###GameInGuildManager:pushCommandForInGuildState")
    -- 数据加载完成
    if (GameManager._isLoadingData) then
        self:loadDataForInTownState(command)
    end

    self:_pushCommand(command)
end

-- 加载游戏数据
function GameInGuildManager:loadDataForInTownState(command)
    -- print("GameInGuildManager:loadDataForInTownState")
    local commandType = command.type
    -- print("GameInGuildManager:loadDataForInTownState  commandType=",commandType)
    if (commandType == CommandType.CONTROL_LOADSCENCE) then
        self:setLoadingMapDataTime(0.8, 0.5)
    elseif (commandType == CommandType.CONTROL_ENTER_SCENE) then
        self:setLoadingInitSceneTime(1, 0.5)
    else
        -- assert(false, string.format("[ERROR] command type %d is invalid when loading scene.", commandType))
    end
end

-- 
function GameInGuildManager:createLayer()
    return TownLayer:create()
end

function GameInGuildManager:createMachine()
    return Town.Machine:create()
end

function GameInGuildManager:createUIManager()
    return UI.UIManager:loadTownUI()
end
function GameInGuildManager:createWeatherManager( )
    return nil;
end

-- 获取城镇中的游戏模型
function GameInGuildManager:getTownModel()
    if (MachineManager:getInstance():getMachine()) then
        return MachineManager:getInstance():getMachine():getModel()
    end
    return nil
end

function GameInGuildManager:loginEnterTown()
    self:enterGuild()
    -- 进入加载场景
    SceneManager:getInstance():replaceLoadingScene()
end

-- 玩家进入城镇
function GameInGuildManager:enterGuild()
    printfmt("GameInGuildManager:enterGuild")

    local setpause = collectgarbage("setpause", 200)
    local setstepmul = collectgarbage("setstepmul", 100)

    GoodsDataManager:setPacketSubType(PACKET_SUB_TYPE.PACKET_SUB_TYPE_1)
    SceneManager:getInstance()._state = GameState.IN_GUILD
    GameManager._isLoadingData = true
    GameManager._isLoadingRes = true
    
    -- 处理加载资源
    self:setLoadingInitUIResTime(0.6, 1)

    self:addInitUIResourceList(GAME_IN_GUILD_UI_RES_PLISTS)
    self:addInitPNGResourceList(nil)
    self:addInitSpineResourceList(GAME_IN_GUILD_SPINE_RES_LIST)
end

-- 退出城镇
function GameInGuildManager:exitGuild()
    if (MachineManager:getInstance():getMachine()) then
        MachineManager:getInstance():getMachine():destroy()
        MachineManager:getInstance():setMachine(nil);
    end
    GameInGuildManager:getInstance()._battleUI = nil
    -- 清理其余角色数据
    if(RoleDataManager) then
        RoleDataManager:clearOtherData()
    end
    UI.UIManager:unloadTownUI()

    
    WeatherManager:getInstance():unloadWeaterSystem();

    GameMapManager:getInstance():unloadMapResForState()
    self:unloadUIRes()
    self:unloadPNGRes()
    self:unloadSpineRes()

    -- add by yys 暂时不调用
    -- display.removeUnusedSpriteFrames()
    collectgarbage("collect")

    -- 清理加载数据
    self:resetLoadData()
    local GameDataManager = require("app.game.GameDataManager")
end

return GameInGuildManager;

