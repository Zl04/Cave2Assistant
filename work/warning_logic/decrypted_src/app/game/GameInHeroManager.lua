-- GameInHeroManager.lua
-- Author:zp
-- 2018年7月16日
-- Using:英雄模式中的游戏管理

require "app.battle.BattleMachine"
require "app.game.GameLoadManager"


local SceneManager = require("app.game.SceneManager")
local GameLayer = require "app.scene.gamescene.GameLayer"
local GameMapManager = require("app.game.GameMapManager")
local GameDataManager = require("app.game.GameDataManager")
local WeatherManager = require("app.game.WeatherManager")
local MachineManager = require("app.game.MachineManager")


local GameInHeroManager = class("GameInHeroManager", GameLoadManager)

local PACKET_TYPE = PublicDefine.PACKET_TYPE 
local PACKET_SUB_TYPE = PublicDefine.PACKET_SUB_TYPE

g_GameInHeroManager = nil;

function GameInHeroManager:getInstance()
    if g_GameInHeroManager == nil then
        g_GameInHeroManager = GameInHeroManager.new()
    end
    return g_GameInHeroManager;
end

function GameInHeroManager:purgeInstance()
    if g_GameInHeroManager ~= nil then
        g_GameInHeroManager = nil;
    end
end

function GameInHeroManager:ctor()
    GameInHeroManager.super.ctor(self)

end

-- private:
local LOADED_STEPS = 5
local NEXT_STEP_INTERVAL = 0.05

-- 加载的动画资源列表
local GAME_IN_CAVE_SPINE_RES_LIST = {

}

-- 加载的plist列表
local GAME_IN_CAVE_UI_RES_PLISTS = {

}

-- 添加命令
function GameInHeroManager:pushCommandForInHeroState(command)
    -- 数据加载完成
    if (GameManager._isLoadingData) then
        self:loadDataForInHeroState(command)
    end

    self:_pushCommand(command)
end

-- 加载游戏数据
function GameInHeroManager:loadDataForInHeroState(command)
    local commandType = command.type

    if (commandType == CommandType.CONTROL_LOADSCENCE) then
        self:setLoadingMapDataTime(0.99, 0.5)
    elseif (commandType == CommandType.CONTROL_ENTER_SCENE) then
        self:setLoadingInitSceneTime(1, 0.01)
    else
        -- print(string.format("GameInHeroManager loadDataForInCaveState: 加载了一条数据, command type %d. ", command.type))
    end
end

-- 
function GameInHeroManager:createLayer()
    return GameLayer:create()
end

function GameInHeroManager:createMachine()
    return Battle.Machine:create()
end

function GameInHeroManager:createUIManager()
    return UI.UIManager:loadBattleUI()
end
function GameInHeroManager:createWeatherManager( )
    return nil;
end

-- 玩家进洞
function GameInHeroManager:enterHero(caveMode)
    print("GameInHeroManager:enterHero")
    local setpause = collectgarbage("setpause", 200)
    local setstepmul = collectgarbage("setstepmul", 100)

    GoodsDataManager:setPacketSubType(PACKET_SUB_TYPE.PACKET_SUB_TYPE_1)
    
    if caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
        SceneManager:getInstance()._state = GameState.IN_HERO
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        SceneManager:getInstance()._state = GameState.IN_TITAN_HERO
    end
    
    GameManager._isLoadingData = true
    GameManager._isLoadingRes = true

    self:registerClientMessageListenerForInHeroState()
    
    -- 处理加载资源
    self:setLoadingInitUIResTime(0.8, 2)

    self:addInitUIResourceList(GAME_IN_CAVE_UI_RES_PLISTS)
    self:addInitPNGResourceList(nil)
    self:addInitSpineResourceList(GAME_IN_CAVE_SPINE_RES_LIST)
end

-- 玩家出洞
function GameInHeroManager:exitHero()
    print("GameInHeroManager:exitHero")
    if (MachineManager:getInstance():getMachine()) then
        MachineManager:getInstance():getMachine():destroy()
        MachineManager:getInstance():setMachine(nil);
    end

    RoleDataManager:nextFloorClear()
    GoodsDataManager:nextFloorClear()
    SkillDataManager:nextFloorClear()
    TaskDataManager:nextFloorClear()
    MasterDataManager:nextFloorClear()

    UI.UIManager:unloadBattleUI()
    
    WeatherManager:getInstance():unloadWeaterSystem();
    GameMapManager:getInstance():unloadMapResForState()
    self:unloadUIRes()
    self:unloadPNGRes()
    self:unloadSpineRes()

    self:unregisterClientMessageListenerForInHeroState()

    -- add by yys 暂时不调用
    -- display.removeUnusedSpriteFrames()
    collectgarbage("collect")

    -- 清理加载数据
    self:resetLoadData()
end

-- 注册监听函数
function GameInHeroManager:registerClientMessageListenerForInHeroState()
end

-- 取消监听函数
function GameInHeroManager:unregisterClientMessageListenerForInHeroState()
end


return GameInHeroManager;