-- GameInDungeonManager.lua
-- 作者：zp
-- 2017年09月06日
-- Using:大秘境游戏管理


require "app.battle.BattleMachine"
require "app.game.GameLoadManager"

local SceneManager = require("app.game.SceneManager")
local GameLayer = require "app.scene.gamescene.GameLayer"
local GameMapManager = require("app.game.GameMapManager")
local WeatherManager = require("app.game.WeatherManager")
local GameDataManager = require("app.game.GameDataManager")
local MachineManager = require("app.game.MachineManager")

local GameInDungeonManager = class("GameInDungeonManager", GameLoadManager)

local PACKET_TYPE = PublicDefine.PACKET_TYPE 
local PACKET_SUB_TYPE = PublicDefine.PACKET_SUB_TYPE
local ProtobufUtil = require "utils.ProtobufUtil"

g_GameInDungeonManager = nil;

function GameInDungeonManager:getInstance()
    if g_GameInDungeonManager == nil then
        g_GameInDungeonManager = GameInDungeonManager.new()
    end
    return g_GameInDungeonManager;
end

function GameInDungeonManager:purgeInstance()
    if g_GameInDungeonManager ~= nil then
        g_GameInDungeonManager = nil;
    end
end

function GameInDungeonManager:ctor()
    GameInDungeonManager.super.ctor(self)

end

-- 私有：
local LOADED_STEPS = 5
local NEXT_STEP_INTERVAL = 0.05

-- 加载的动画资源列表
local GAME_IN_CAVE_SPINE_RES_LIST = {

}

-- 加载的plist列表
local GAME_IN_CAVE_UI_RES_PLISTS = {
}

-- 添加命令
function GameInDungeonManager:pushCommandForInDungeonState(command)
    -- print("###GameInTownManager:pushCommandForInDungeonState")
    if (GameManager._isLoadingData) then
        self:loadDataForInCaveState(command)
    end

    self:_pushCommand(command)
end

-- 加载游戏数据
function GameInDungeonManager:loadDataForInCaveState(command)
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
function GameInDungeonManager:createLayer()
    return GameLayer:create()
end

function GameInDungeonManager:createMachine()
    return Battle.Machine:create()
end

function GameInDungeonManager:createUIManager()
    return UI.UIManager:loadBattleUI()
end
function GameInDungeonManager:createWeatherManager( )
    return nil;
end
-- 玩家进洞
function GameInDungeonManager:enterDungeon()
    print("GameInDungeonManager:enterDungeon")
    local setpause = collectgarbage("setpause", 200)
    local setstepmul = collectgarbage("setstepmul", 100)
    
    SceneManager:getInstance()._state = GameState.IN_DUNGEON

    GoodsDataManager:setPacketSubType(PACKET_SUB_TYPE.PACKET_SUB_TYPE_2)

    GameManager._isLoadingData = true
    GameManager._isLoadingRes = true

    -- 处理加载资源
    self:setLoadingInitUIResTime(0.6, 2)

    self:addInitUIResourceList(GAME_IN_CAVE_UI_RES_PLISTS)
    self:addInitPNGResourceList(nil)
    self:addInitSpineResourceList(GAME_IN_CAVE_SPINE_RES_LIST)
end

-- 玩家出洞
function GameInDungeonManager:exitDungeon()
    print("GameInDungeonManager:exitDungeon")

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
    GameManager:clearCommandList(self._battleCommandList, true)
    self._battleCommandList = {}

    -- yys 添加，暂时不调用
    -- display.removeUnusedSpriteFrames()
    collectgarbage("collect")

    -- 清理加载数据
    self:resetLoadData()
end

--领取赛季奖励 
function GameInDungeonManager:reciveSeasonReward(data)
    if data.result == "ReceiveDungeonRewardResult_Succeed" then
        local curRank = data.rank
        local rewardGoodsArr = self:getSeasonRewardByGoodsId(data.goodsID)
        local rankText = ""
        if curRank > PublicDefine.RankAmbit.RankAmbit_Enter then
            rankText = PublicDefine.RankAmbit.RankAmbit_Enter.."+"
        else
            rankText = curRank..""
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, rewardGoodsArr, function( ... )
            local SdkManager = require"app.game.SdkManager"
            SdkManager:checkCommentEvent(COMMENT_TYPE.DUNGEON_SEASON_REWARD)
        end, string.format(UI.TEXT_1170214, rankText).."\n"..UI.TEXT_111030, nil)  
        RoleDataManager:getMaster():setHasReceivedDungeonSeasonReward(true)
    else
        GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.ReceiveDungeonRewardResult", data.result))
    end
end

function GameInDungeonManager:getSeasonRewardByGoodsId(goodsID)
    local rewards = {}
    if goodsID == nil then
        return rewards
    end
    for k, v in pairs(goodsID) do
        local goodData = GoodsDataManager:createLocalGoodsData(v.templateID)
        if(goodData) then
            goodData:setNum(v.num)
            table.insert(rewards, goodData)
        end
    end
    print("rewards   size  = "..#rewards)
    return rewards
end

function GameInDungeonManager:getSeasonRewardFromConfig(curRank)
    local rewards = {}
    if curRank <= 0 then
        return rewards
    end
    local seasonData = MasterDataManager:getCurrentSeasonData()
    if seasonData == nil then
        return rewards
    end
    local rewardCfg = ConfigManager:getDungeonSeasonRewardById(seasonData.seasonID)
    if not rewardCfg then
        print("----error  seasonData.seasonID------"..seasonData.seasonID)
        return rewards
    end
    local rankList = string.split(rewardCfg.rankRange, ";")
    for k, v in pairs(rankList) do
        local rankLimite = string.split(v, ",")
        if curRank >= tonumber(rankLimite[1]) and curRank <= tonumber(rankLimite[2]) then
            local rewardGoodsList = string.split(rewardCfg.rewardGoods, ";")
            local goodsIds = string.split(rewardGoodsList[k], ",")

            local goodsNumberList = string.split(rewardCfg.rewardGoodsNum, ";")
            local goodsNumbers = string.split(goodsNumberList[k], ",")

            for index, id in ipairs(goodsIds) do 
                local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(id))
                if (goodsData) then
                    goodsData:setNum(tonumber(goodsNumbers[index] or 0))
                    goodsData:setIsGolden(true)
                    table.insert(rewards, goodsData)
                    local dataText = {}
                    dataText.id = id
                    dataText.number = goodsNumbers[index]
                    -- dump(dataText, "------------easonReward")
                end
            end
            break
        end
    end
    return rewards
end

--是否能领取大秘境奖励
function GameInDungeonManager:isCanReciveSeasonReward()
    local seasonData = MasterDataManager:getCurrentSeasonData()
    if seasonData == nil then
        print(" --- current  seasonData is  null")
        return false
    end
    local maxDungeonLevel = RoleDataManager:getMaster():getMaxDungeonLevelAndMinTimeForSeason()
    local hasReceive = RoleDataManager:getMaster():isHasReceivedDungeonSeasonReward()
    -- dump(hasReceive, "------hasReceive")
    -- dump(seasonData.open, "------seasonData.open")
    if not seasonData.open and not hasReceive and maxDungeonLevel > 0 then --open == false  表示赛季结束  == true表示赛季进行中
       return true
    end
    return false
    -- return true
end

function GameInDungeonManager:checkAndRefreshNpcFuncArray(functions)
    local isShowDungeonSeasonBtn = false
    local isTriger = false
    funcArray = clone(functions)
    for k, v in pairs(funcArray) do
        if v == PublicDefine.FUNCTION_TYPE.DUNGEON_SEASON_REWARD then
            isTriger = true
            if not self:isCanReciveSeasonReward() then
                table.remove(funcArray, k)
            else
                isShowDungeonSeasonBtn = true
            end
            break
        end
    end
    return funcArray, isShowDungeonSeasonBtn, isTriger
end

function GameInDungeonManager:getSeasonShowTime()
    local currentSeason = MasterDataManager:getCurrentSeasonData()
    if currentSeason ~= nil and currentSeason.open then
        return currentSeason.startTime, currentSeason.endTime
    else
        local nextSeason = MasterDataManager:getNextSeasonData()
        if nextSeason ~= nil and nextSeason.seasonID ~= 0 then
            return nextSeason.startTime, nextSeason.endTime
        elseif currentSeason ~= nil and currentSeason.seasonID ~= 0 then
           return currentSeason.startTime, currentSeason.endTime
        end
    end
    return
end

return GameInDungeonManager
