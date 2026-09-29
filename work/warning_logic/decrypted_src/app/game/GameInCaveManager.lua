--[[
    洞穴中的游戏管理
]]--

require "app.battle.BattleMachine"
require "app.game.GameLoadManager"


local SceneManager = require("app.game.SceneManager")
local GameLayer = require "app.scene.gamescene.GameLayer"
local GameMapManager = require("app.game.GameMapManager")
local GameDataManager = require("app.game.GameDataManager")
local WeatherManager = require("app.game.WeatherManager")
local MachineManager = require("app.game.MachineManager")


local GameInCaveManager = class("GameInCaveManager", GameLoadManager)

local PACKET_TYPE = PublicDefine.PACKET_TYPE 
local PACKET_SUB_TYPE = PublicDefine.PACKET_SUB_TYPE

g_GameInCaveManager = nil;

function GameInCaveManager:getInstance()
    if g_GameInCaveManager == nil then
        g_GameInCaveManager = GameInCaveManager.new()
    end
    return g_GameInCaveManager;
end

function GameInCaveManager:purgeInstance()
    if g_GameInCaveManager ~= nil then
        g_GameInCaveManager = nil;
    end
end

function GameInCaveManager:ctor()
    GameInCaveManager.super.ctor(self)

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
function GameInCaveManager:pushCommandForInCaveState(command)
    -- 数据加载完成
    if (GameManager._isLoadingData) then
        self:loadDataForInCaveState(command)
    end

    self:_pushCommand(command)
end

-- 加载游戏数据
function GameInCaveManager:loadDataForInCaveState(command)
    local commandType = command.type

    if (commandType == CommandType.CONTROL_LOADSCENCE) then
        self:setLoadingMapDataTime(0.99, 0.5)
    elseif (commandType == CommandType.CONTROL_ENTER_SCENE) then
        self:setLoadingInitSceneTime(1, 0.01)
    -- elseif (commandType == CommandType.CONTROL_SCREENMONSTER) then
    --     local monsterData = Data.MonsterData:create(command.data.monsterID, GameMapManager:getInstance():getModel(), GameMapManager:getInstance():getDifficulty())
    --     local spine = monsterData.spine
    --     if (spine and spine ~= "") then
    --         local skeletonJSON = spine..".json"
    --         local skeletonAtlas = spine..".atlas"
    --         local skeletonScale = Game.MONSTER_ANIMATION_SCALE

    --         self:addOneSpineResource(skeletonJSON, skeletonAtlas, skeletonScale)
    --     else
   
    --     end
    -- elseif (commandType == CommandType.CONTROL_SCREEN_TRIGGERNPC) then
    --     local triggerNPCData = Data.TriggerNpcData:create(command.data.templateID)
    --     local spine = triggerNPCData.spine
        
    --     if(triggerNPCData and not (triggerNPCData:getCategory() == Category.TRIGGER_NPC  and triggerNPCData:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOSS_FLOOR_GATE) ) then
    --         if (spine and spine ~= "") then
    --             local skeletonJSON = spine..".json"
    --             local skeletonAtlas = spine..".atlas"
    --             local skeletonScale = Game.NPC_ANIMATION_SCALE

    --             self:addOneSpineResource(skeletonJSON, skeletonAtlas, skeletonScale)
    --         else

    --         end
    --     end
    else
        -- print(string.format("GameInCaveManager loadDataForInCaveState: 加载了一条数据, command type %d. ", command.type))
    end
end

-- 
function GameInCaveManager:createLayer()
    return GameLayer:create()
end

function GameInCaveManager:createMachine()
    return Battle.Machine:create()
end

function GameInCaveManager:createUIManager()
    return UI.UIManager:loadBattleUI()
end
function GameInCaveManager:createWeatherManager( )
    return nil;
end

-- 玩家进洞
function GameInCaveManager:enterCave()
    print("GameInCaveManager:enterCave")

    local setpause = collectgarbage("setpause", 200)
    local setstepmul = collectgarbage("setstepmul", 100)

    GoodsDataManager:setPacketSubType(PACKET_SUB_TYPE.PACKET_SUB_TYPE_1)
    
    SceneManager:getInstance()._state = GameState.IN_CAVE
    GameManager._isLoadingData = true
    GameManager._isLoadingRes = true

    self:registerClientMessageListenerForInCaveState()
    
    -- 处理加载资源
    self:setLoadingInitUIResTime(0.8, 2)

    self:addInitUIResourceList(GAME_IN_CAVE_UI_RES_PLISTS)
    self:addInitPNGResourceList(nil)
    self:addInitSpineResourceList(GAME_IN_CAVE_SPINE_RES_LIST)
end

-- 玩家出洞
function GameInCaveManager:exitCave()
    print("GameInCaveManager:exitCave")

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

    self:unregisterClientMessageListenerForInCaveState()

    -- add by yys 暂时不调用
    -- display.removeUnusedSpriteFrames()
    collectgarbage("collect")

    -- 清理加载数据
    self:resetLoadData()
end

-- 注册监听函数
function GameInCaveManager:registerClientMessageListenerForInCaveState()
end

-- 取消监听函数
function GameInCaveManager:unregisterClientMessageListenerForInCaveState()
end


return GameInCaveManager;