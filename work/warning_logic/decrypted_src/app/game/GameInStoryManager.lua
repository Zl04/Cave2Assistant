-- GameInStoryManager.lua
-- Author:zp
-- 2017年12月07日
-- Using:引导场景


require "app.battle.BattleMachine"
require "app.game.GameLoadManager"

local SceneManager = require("app.game.SceneManager")
local GameLayer = require "app.scene.gamescene.GameLayer"
local GameMapManager = require("app.game.GameMapManager")
local GameDataManager = require("app.game.GameDataManager")
local WeatherManager = require("app.game.WeatherManager")
local MachineManager = require("app.game.MachineManager")

local GameInStoryManager = class("GameInStoryManager", GameLoadManager)

local PACKET_TYPE = PublicDefine.PACKET_TYPE 
local PACKET_SUB_TYPE = PublicDefine.PACKET_SUB_TYPE
local ProtobufUtil = require "utils.ProtobufUtil"

g_GameInStoryManager = nil;

function GameInStoryManager:getInstance()
    if g_GameInStoryManager == nil then
        g_GameInStoryManager = GameInStoryManager.new()
    end
    return g_GameInStoryManager;
end

function GameInStoryManager:purgeInstance()
    if g_GameInStoryManager ~= nil then
        g_GameInStoryManager = nil;
    end
end

function GameInStoryManager:ctor()
    GameInStoryManager.super.ctor(self)

end

-- private:
local LOADED_STEPS = 5
local NEXT_STEP_INTERVAL = 0.05

-- 加载的动画资源列表
local GAME_IN_STORY_SPINE_RES_LIST = {

}

-- 加载的plist列表
local GAME_IN_STORY_UI_RES_PLISTS = {

}

-- 添加命令
function GameInStoryManager:pushCommandForInGuideState(command)
    if (GameManager._isLoadingData) then
        self:loadDataForInCaveState(command)
    end

    self:_pushCommand(command)
end

-- 加载游戏数据
function GameInStoryManager:loadDataForInCaveState(command)
    local commandType = command.type

    if (commandType == CommandType.CONTROL_LOADSCENCE) then
        self:setLoadingMapDataTime(0.99, 0.5)
    elseif (commandType == CommandType.CONTROL_ENTER_SCENE) then
        self:setLoadingInitSceneTime(1, 0.01)
    elseif (commandType == CommandType.CONTROL_SCREENMONSTER) then
        local monsterData = RoleDataManager:createLocalMonsterDataForModeAndDiff(command.data.monsterID, GameMapManager:getInstance():getModel(), GameMapManager:getInstance():getDifficulty())
        if(monsterData) then 
            local spine = monsterData.spine
            if (spine and spine ~= "") then
                local skeletonJSON = spine..".json"
                local skeletonAtlas = spine..".atlas"
                local skeletonScale = Game.MONSTER_ANIMATION_SCALE

                self:addOneSpineResource(skeletonJSON, skeletonAtlas, skeletonScale)
            end
        end
    elseif (commandType == CommandType.CONTROL_SCREEN_TRIGGERNPC) then
        local triggerNPCData = Data.TriggerNpcData:create(command.data.templateID)
        local spine = triggerNPCData.spine
        if(triggerNPCData and not (triggerNPCData:getCategory() == Category.TRIGGER_NPC  and triggerNPCData:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOSS_FLOOR_GATE) ) then
            if (spine and spine ~= "") then
                local skeletonJSON = spine..".json"
                local skeletonAtlas = spine..".atlas"
                local skeletonScale = Game.NPC_ANIMATION_SCALE

                self:addOneSpineResource(skeletonJSON, skeletonAtlas, skeletonScale)
            else
            end
        end
    else
        -- print(string.format("GameInCaveManager loadDataForInCaveState: 加载了一条数据, command type %d. ", command.type))
    end
end

-- 
function GameInStoryManager:createLayer()
    return GameLayer:create()
end

function GameInStoryManager:createMachine()
    return Battle.Machine:create()
end

function GameInStoryManager:createUIManager()
    return UI.UIManager:loadBattleUI()
end
function GameInStoryManager:createWeatherManager( )
    return nil;
end
-- 玩家进洞
function GameInStoryManager:enterGuide()
    print("GameInStoryManager:enterGuide")
    local setpause = collectgarbage("setpause", 200)
    local setstepmul = collectgarbage("setstepmul", 100)
    
    SceneManager:getInstance()._state = GameState.IN_STORY

    GoodsDataManager:setPacketSubType(PACKET_SUB_TYPE.PACKET_SUB_TYPE_1)

    GameManager._isLoadingData = true
    GameManager._isLoadingRes = true

    -- 处理加载资源
    self:setLoadingInitUIResTime(0.6, 1)

    self:addInitUIResourceList(GAME_IN_STORY_UI_RES_PLISTS)
    self:addInitPNGResourceList(nil)
    self:addInitSpineResourceList(GAME_IN_STORY_SPINE_RES_LIST)
end

-- 玩家出洞
function GameInStoryManager:exitGuide()
    print("GameInStoryManager:exitGuide")

    if (MachineManager:getInstance():getMachine()) then
        MachineManager:getInstance():getMachine():destroy()
        MachineManager:getInstance():setMachine(nil);
    end

    RoleDataManager:nextFloorClear()
    GoodsDataManager:nextFloorClear()
    SkillDataManager:nextFloorClear()
    TaskDataManager:nextFloorClear()
    MasterDataManager:nextFloorClear()

    self._battleUI = nil
    UI.UIManager:unloadBattleUI()
    
    WeatherManager:getInstance():unloadWeaterSystem();
    GameMapManager:getInstance():unloadMapResForState()
    self:unloadUIRes()
    self:unloadPNGRes()
    self:unloadSpineRes()

    self._battleMapData = nil

    -- add by yys 暂时不调用
    -- display.removeUnusedSpriteFrames()
    collectgarbage("collect")

    -- 清理加载数据
    self:resetLoadData()
end


return GameInStoryManager