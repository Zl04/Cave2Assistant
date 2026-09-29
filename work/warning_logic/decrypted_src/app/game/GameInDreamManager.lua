-- GameInDreamManager.lua
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


local GameInDreamManager = class("GameInDreamManager", GameLoadManager)

local PACKET_TYPE = PublicDefine.PACKET_TYPE 
local PACKET_SUB_TYPE = PublicDefine.PACKET_SUB_TYPE

g_GameInDreamManager = nil;

function GameInDreamManager:getInstance()
    if g_GameInDreamManager == nil then
        g_GameInDreamManager = GameInDreamManager.new()
    end
    return g_GameInDreamManager;
end

function GameInDreamManager:purgeInstance()
    if g_GameInDreamManager ~= nil then
        g_GameInDreamManager = nil;
    end
end

function GameInDreamManager:ctor()
    GameInDreamManager.super.ctor(self)

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
function GameInDreamManager:pushCommandForInDreamState(command)
    -- 数据加载完成
    if (GameManager._isLoadingData) then
        self:loadDataForInDreamState(command)
    end

    self:_pushCommand(command)
end

-- 加载游戏数据
function GameInDreamManager:loadDataForInDreamState(command)
    local commandType = command.type

    if (commandType == CommandType.CONTROL_LOADSCENCE) then
        self:setLoadingMapDataTime(0.99, 0.5)
    elseif (commandType == CommandType.CONTROL_ENTER_SCENE) then
        self:setLoadingInitSceneTime(1, 0.01)
    else
        -- print(string.format("GameInDreamManager loadDataForInCaveState: 加载了一条数据, command type %d. ", command.type))
    end
end

-- 
function GameInDreamManager:createLayer()
    return GameLayer:create()
end

function GameInDreamManager:createMachine()
    return Battle.Machine:create()
end

function GameInDreamManager:createUIManager()
    return UI.UIManager:loadBattleUI()
end
function GameInDreamManager:createWeatherManager( )
    return nil;
end

-- 玩家进洞
function GameInDreamManager:enterDream()
    print("GameInDreamManager:enterDream")
    local setpause = collectgarbage("setpause", 200)
    local setstepmul = collectgarbage("setstepmul", 100)

    GoodsDataManager:setPacketSubType(PACKET_SUB_TYPE.PACKET_SUB_TYPE_1)
    
    SceneManager:getInstance()._state = GameState.IN_DREAM
    GameManager._isLoadingData = true
    GameManager._isLoadingRes = true
    
    -- 处理加载资源
    self:setLoadingInitUIResTime(0.8, 2)

    self:addInitUIResourceList(GAME_IN_CAVE_UI_RES_PLISTS)
    self:addInitPNGResourceList(nil)
    self:addInitSpineResourceList(GAME_IN_CAVE_SPINE_RES_LIST)
end

-- 玩家出洞
function GameInDreamManager:exitDream()
    print("GameInDreamManager:exitDream")
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

    -- add by yys 暂时不调用
    -- display.removeUnusedSpriteFrames()
    collectgarbage("collect")

    -- 清理加载数据
    self:resetLoadData()
end

return GameInDreamManager;