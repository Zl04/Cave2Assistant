-- SceneManager.lua
-- Author:ODEI
-- 2017年3月31日
-- Using:场景管理 
require("utils.reload")
local LoadingLayer = require "app.scene.loadingscene.LoadingLayer"
local GameMapManager = require("app.game.GameMapManager")

local SceneManager = class("SceneManager")
g_SceneManager = nil;

local BeginTransToLoadSceneSpecial = {}

function SceneManager:ctor()
    self.loadingLayer = nil;       --加载界面
    self._state = GameState.NONE    --当前场景
    self._sceneType = nil

    self._waiting = false          -- 是否处于等待状态
    self._waitingCommondList = {}  -- 等待状态缓存的指令
    self._waitingBeginTransLoadScene = {} -- 用于缓存beginTrans到loadscene之间指定的指令

    self._isInLoading = false   -- 判断是否处于LOADING 中

    self.bossScenario = false   -- 判断是否处于BOSS出场动画
    self._isDownstairs = false  -- 判断是否下楼

    self.lastState = Game.State.NONE 

    self.weatherID = 1

    -- 初始化特殊指令
    self:initSpecialData()
end

function SceneManager:setWeatherID(id)
    self.weatherID = id
end

function SceneManager:getWeatherID()
    return self.weatherID
end

function SceneManager:backupLastState()
    self.lastState = self._state
end

function SceneManager:getLastState()
    return self.lastState
end
function SceneManager:getInstance()
    if g_SceneManager == nil then
       g_SceneManager = SceneManager.new()
    end
    return g_SceneManager;
end

function SceneManager:getSceneType()
    return self._sceneType
end

function SceneManager:getIsDownstairs()
    return self._isDownstairs
end

function SceneManager:purgeInstance()
    if g_SceneManager ~= nil then
       g_SceneManager = nil;
    end
end
function SceneManager:startSplashScene()
    print("startSplashScene")
    -- 创建登录场景
    local splashScene = cc.Layer:create()
    -- 创建登录主层
    require "app.scene.mainscene.SplashLayer"
    local splash = UI.SplashLayer:create()
    splash:init()
    splashScene:addChild(splash, 1)
    -- 替换登录场景
    self:replaceScene(splashScene)
end

function SceneManager:startLoginScene()
    local gameLoginManager = require("app.game.GameLoginManager")
    gameLoginManager:getInstance():startLogin()
end

-- 切换场景
function SceneManager:replaceScene(sceneLayer)
    if (sceneLayer) then
        local scene = cc.Scene:create()    
        scene:addChild(sceneLayer)
        cc.Director:getInstance():replaceScene(scene)

        if (self._loadingLayer) then
            self._loadingLayer = nil
        end
        

        -- local listener = cc.EventListenerKeyboard:create();
        -- listener:registerScriptHandler(function(keycode, evt)
        --     print(keycode)
        --     if keycode == 141 then
        --         -- 按o重新加载代码
        --     end

        -- end, cc.Handler.EVENT_KEYBOARD_RELEASED);
     
        -- local eventDispatcher = cc.Director:getInstance():getEventDispatcher();
        -- eventDispatcher:addEventListenerWithSceneGraphPriority(listener, scene);

    else
        assert(false, "[ERROR] [Game Manager] no scene to replace.")
    end
end

-- 进入加载场景
function SceneManager:replaceLoadingScene(loadingType)
    UI.HWBtnComponent:mainSwitchOff()
    if(loadingType == nil) then
        loadingType = LoadingType.LoadingType_Normal
    end

    local loadingLayer = LoadingLayer:create()
    local scene = cc.Scene:create()    
    scene:addChild(loadingLayer, 1)
    loadingLayer:init(loadingType)
    loadingLayer:center()
    cc.Director:getInstance():replaceScene(scene)

    self._loadingLayer = loadingLayer

    Avalon.AudioManager:pauseMusic()

    self._isInLoading = true
end

function SceneManager:removeLodingScene(callBack)
    print("SceneManager:removeLodingScene")
    UI.HWBtnComponent:mainSwitchOn()
    -- self:endLoadingScene()
    -- 移除加载页面
    if(self._loadingLayer and not tolua.isnull(self._loadingLayer)) then
        self._loadingLayer:waitingRemove(callBack)
    else
        callBack()
    end
end

function SceneManager:addSceneLayer(sceneLayer)
    print("SceneManager:addSceneLayer")
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():getRunningScene():addChild(sceneLayer)
    end
end

-- 获取是否处于Loading中
function SceneManager:getIsInLoading()
    return self._isInLoading
end

-- 完成加载页面
function SceneManager:endLoadingScene()
    self._isInLoading = false
end

-- 设置进度
function SceneManager:setLoadingProgressAndTime(progress, time)
    if (self._loadingLayer and not tolua.isnull(self._loadingLayer)) then
        self._loadingLayer:setProgress(progress, time)
    end
end

-- 是否在城镇
function SceneManager:isInTownOrInHome()
    return self._state == Game.State.IN_TOWN
        or self._state == Game.State.IN_HOME
end

-- 是否在城镇4个主城场景
function SceneManager:isInTownRelated()
    return self:isInTown() or self:isHome() or self:isManor() or self:isGuild()
end

-- 是否在洞穴
function SceneManager:isInCave()
    return self._state == Game.State.IN_CAVE
end

-- 是否在城镇
function SceneManager:isInTown()
    return self._state == Game.State.IN_TOWN
end
-- 是否在登陆页面
function SceneManager:isInLogin()
    return self._state == Game.State.LOGIN
end

-- 是否在大秘境
function SceneManager:isInDungeon()
    return self._state == Game.State.IN_DUNGEON
end

-- 在英雄模式
function SceneManager:isInHero()
    return self._state == Game.State.IN_HERO
end

-- 是否在公会
function SceneManager:isGuild()
    return self._state == Game.State.IN_GUILD
end

-- 是否在家园
function SceneManager:isHome()
    return self._state == Game.State.IN_HOME
end

-- 是否在庄园
function SceneManager:isManor()
    return self._state == Game.State.IN_MANOR
end

-- 是否是港口
function SceneManager:isPort()
    return self._state == Game.State.IN_PORT
end

-- 是否在梦境模式
function SceneManager:isInDream()
    return self._state == Game.State.IN_DREAM
end

-- 是否在小黑屋
function SceneManager:isInBlackHouse()
    return self._sceneType == PublicDefine.SCENE_TYPE.BLACK_HOUSE
end
-- 是否在boss层
function SceneManager:isInBossCave()
    return self._sceneType == PublicDefine.SCENE_TYPE.BOSS
end
-- 是否在商店层
function SceneManager:isInShopCave()
    return self._sceneType == PublicDefine.SCENE_TYPE.SHOP
end

-- 是否活动副本
function SceneManager:isActivityCave()
    return self._sceneType == PublicDefine.SCENE_TYPE.SCENE_TYPE_ACTIVITY
end

--是否在庄园
function SceneManager:isInManor()
    return self._sceneType == PublicDefine.SCENE_TYPE.MANOR
end

--是否在港口
function SceneManager:isInPort()
    return self._sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT
end

-- 是否是深红炼狱
function SceneManager:isInInferno()

    return self._state == Game.State.IN_INFERNO
end

-- 是否是虚空秘境
function SceneManager:isInVoidRift()

    return self._state == Game.State.IN_VOID_RAFT
end

-- 是否是维京(双怪)副本
function SceneManager:isInViKing()

    return self._state == Game.State.IN_VIKING
end

-- 是否是试炼之地
function SceneManager:isInTrialLand()

    return self._state == Game.State.IN_TRIAL_LAND
end

-- 是否是永冬裂缝
function SceneManager:isInEverWinter()
    return self._state == Game.State.IN_EVER_WINTER
end

-- 是否是洞窟探险
function SceneManager:isInCaveExploring()

    return self._state == Game.State.IN_TREATURE_HUNT
end

-- 是否是经验副本
function SceneManager:isInExp()

    return self._state == Game.State.IN_EXP
end

function SceneManager:isInMaze()
    if self:isActivityCave() then
        local level = GameMapManager:getInstance():getLevel()
        if level == PublicDefine.CONST_DEFINITION.MAZE_MAP_ID then
            return true
        end
    end
    return false
end


function SceneManager:isInHitRat()
    if self:isActivityCave() then
        local level = GameMapManager:getInstance():getLevel()
        if level == PublicDefine.CONST_DEFINITION.RAT_MAP_ID then
            return true
        end
    end
    return false
end

function SceneManager:isInPuzzle()
    if self:isActivityCave() then
        local level = GameMapManager:getInstance():getLevel()
        if level == PublicDefine.CONST_DEFINITION.PUZZLE_MAP_ID then
            return true
        end
    end
    return false
end

function SceneManager:isInBigCrack()
    if self:isActivityCave() then
        local level = GameMapManager:getInstance():getLevel()
        if level == PublicDefine.CONST_DEFINITION.BIG_CRACK_MAP_ID then
            return true
        end
    end
    return false
end

-- 
function SceneManager:isInEaster()
    if self:isActivityCave() then
        local level = GameMapManager:getInstance():getLevel()
        if level == PublicDefine.CONST_DEFINITION.EASTER_MAP_ID then
            return true
        end
    end
    return false
end

function SceneManager:isInHuLu()
    if self:isActivityCave() then
        local level = GameMapManager:getInstance():getLevel()
        if level >= PublicDefine.CONST_DEFINITION.HULU_MAP_ID and level < PublicDefine.CONST_DEFINITION.HULU_MAP_ID + PublicDefine.CONST_DEFINITION.HULU_MAP_NUM then
            return true
        end
    end
    return false
end

function SceneManager:isInLostRealm()
    if self:isActivityCave() then
        local level = GameMapManager:getInstance():getLevel()
        if level == PublicDefine.CONST_DEFINITION.LOST_REALM_MAP_ID then
            return true
        end
    end
    return false
    -- return true
end

function SceneManager:isInPetPVP()
    return self._state == Game.State.PET_PVP
end

-- 是否沙之眼
function SceneManager:isDesertEyesCave()
    return self._state == Game.State.IN_DESERT_EYES
end

-- 是否扭曲空间
function SceneManager:isDistortedSpaceCave()
    return self._state == Game.State.IN_DISTORTED_SPACE
end

-- 是否为活动
function SceneManager:isActCave()
    return self._state == Game.State.IN_ACT
end

-- 是否活动副本
function SceneManager:isWorldBossCave()
    return self._state == Game.State.IN_WORLDBOSS
end

-- 是否是公会BOSS
function SceneManager:isGuildBoss()
    return self._state == GameState.IN_GUILDBOSS
end

-- 是否是幽林深渊
function SceneManager:isGhostAbyss()
    return self._state == GameState.IN_GHOST_ABYSS
end

-- 是否是永冬裂缝
function SceneManager:isEverWinter()
    return self._state == GameState.IN_EVER_WINTER
end

-- 是否泰坦之路
function SceneManager:isTitanRoad()
    return self._state == Game.State.IN_TITAN_ROAD
end

-- 是否泰坦之路英雄模式
function SceneManager:isInTitanHero()
    return self._state == Game.State.IN_TITAN_HERO
end

-- 是否干涸之泉
function SceneManager:isDriedSpring()
    return self._state == Game.State.IN_DRIED_SPRING
end

-- 是否混沌虫洞
function SceneManager:isChaosWormHole()
    return self._state == Game.State.IN_CHAOS_WORMHOLE
end

-- 是否是虫洞深处
function SceneManager:isInWormhole()
    return self._state == Game.State.IN_WORMHOLE
end

-- 是否在战斗场景
function SceneManager:isInFightScene()
    return self._state == Game.State.IN_CAVE 
        or self._state == Game.State.IN_DUNGEON 
        or self._state == Game.State.IN_STORY
        or self._state == Game.State.IN_HERO
        or self._state == Game.State.IN_DREAM
        or self._state == Game.State.IN_WORLDBOSS
        or self._state == GameState.IN_GUILDBOSS
        or self._state == GameState.IN_DESERT_EYES
        or self._state == GameState.IN_DISTORTED_SPACE
        or self._state == GameState.IN_ACT
        or self._state == GameState.PET_PVP
        or self._state == GameState.IN_INFERNO
        or self._state == GameState.IN_GHOST_ABYSS
        or self._state == GameState.IN_VOID_RAFT
        or self._state == GameState.IN_TRIAL_LAND
        or self._state == GameState.IN_VIKING
        or self._state == GameState.IN_EVER_WINTER
        or self._state == GameState.IN_TITAN_ROAD
        or self._state == GameState.IN_TITAN_HERO
        or self._state == GameState.IN_TREATURE_HUNT
        or self._state == GameState.IN_DRIED_SPRING
        or self._state == GameState.IN_EXP
        or self._state == GameState.IN_CHAOS_WORMHOLE
        or self._state == GameState.IN_WORMHOLE
end

function SceneManager:isNotInFightScene()
    return self._state == Game.State.IN_TOWN
        or self._state == Game.State.IN_GUILD
        or self._state == Game.State.IN_HOME
        or self._state == Game.State.IN_MANOR
        or self._state == Game.State.IN_PORT
end

function SceneManager:isShowFirstPassScene()
    return self._state == Game.State.IN_CAVE 
        or self._state == Game.State.IN_HERO
        or self._state == GameState.IN_DESERT_EYES
        or self._state == GameState.IN_DISTORTED_SPACE
        or self._state == GameState.IN_TITAN_ROAD
        or self._state == GameState.IN_TITAN_HERO
        or self._state == GameState.IN_DRIED_SPRING
        or self._state == GameState.IN_CHAOS_WORMHOLE
end

-- 判断是否为新手引导场景
function SceneManager:isInStory()
    return self._state == Game.State.IN_STORY
end

--是否显示死亡回城丢失装备的提示（已知大秘境不显示）
function SceneManager:isCanShowDeadBackTip()
    return self._state == Game.State.IN_CAVE 
        or self._state == Game.State.IN_STORY
        or self._state == Game.State.IN_HERO
        or self._state == Game.State.IN_DREAM
        or self._state == Game.State.IN_WORLDBOSS
        or self._state == Game.State.IN_GUILDBOSS
        or self._state == GameState.IN_TITAN_HERO
end

-- 是否使用本地快捷栏,注意和getLocalShortcutBarIndex() 里面以前添加
function SceneManager:isUseLocalShortcutBar()
    return self:isInHuLu()
end

-- 使用本地快捷栏后，对应的记录值的index
function SceneManager:getLocalShortcutBarIndex()
    if(self:isInHuLu()) then 
        return "11"
    else 
        return "10"
    end
end

-- 获取当前场景
function SceneManager:getState()
    if(self._state) then 
        return self._state
    end 

    return Game.State.NONE
end

-- 是否刷新装备积分
function SceneManager:isRefreshEquipScore()
    if(self:isInFightScene()) then
        return false
    else
        return true
    end
end

function SceneManager:setBossScenario(flag)
    self.bossScenario = flag
end

function SceneManager:isInBossScenario()
    return self.bossScenario
end

function SceneManager:enterWaiting()
    print("SceneManager:enterWaiting ")
    self._waiting = true          
    self._waitingCommondList = {}  
end

function SceneManager:leaveWaiting()
    print("SceneManager:leaveWaiting ")
    self._waiting = false

    if(self._waitingCommondList) then
        for _,command in ipairs(self._waitingCommondList) do 
            self:_handleCommand(command, true)
        end
    end
    table.clear(self._waitingCommondList)
end

function SceneManager:exitCurrentState()
    local state = self._state
    self._state = GameState.NONE

    if(state) then
        -- 处理资源释放问题
        if state == GameState.IN_CAVE 
            or state == GameState.IN_WORLDBOSS
            or state == GameState.IN_GUILDBOSS
            or state == GameState.IN_DESERT_EYES
            or state == GameState.IN_DISTORTED_SPACE
            or state == GameState.IN_ACT
            or state == GameState.IN_INFERNO
            or state == GameState.IN_GHOST_ABYSS
            or state == GameState.IN_VOID_RAFT
            or state == GameState.IN_TRIAL_LAND
            or state == GameState.IN_VIKING
            or state == GameState.IN_EVER_WINTER
            or state == GameState.IN_TITAN_ROAD
            or state == GameState.IN_TREATURE_HUNT
            or state == GameState.IN_DRIED_SPRING
            or state == GameState.IN_EXP
            or state == GameState.IN_CHAOS_WORMHOLE
            or state == GameState.IN_WORMHOLE
        then
            local GameInCaveManager = require "app.game.GameInCaveManager"
            GameInCaveManager:getInstance():exitCave()
        elseif state == GameState.IN_GUILD then
            local GameInGuildManager = require "app.game.GameInGuildManager"
            GameInGuildManager:getInstance():exitGuild()
        elseif state == GameState.IN_MANOR then
            local GameInManorManager = require "app.game.GameInManorManager"
            GameInManorManager:getInstance():exitManor()
        elseif state == GameState.IN_PORT then
            local GameInPortManager = require "app.game.GameInPortManager"
            GameInPortManager:getInstance():exitPort()
        elseif state== GameState.IN_TOWN
            or state == GameState.IN_HOME then
            local GameInTownManager = require "app.game.GameInTownManager"
            GameInTownManager:getInstance():exitTown()
            
            -- 处理记录当前金币
            RoleDataManager:updateEnterCaveCoin()
            RoleDataManager:updateEnterCaveInscription()
        elseif state== GameState.IN_DUNGEON then
            local GameInDungeonManager = require "app.game.GameInDungeonManager"
            GameInDungeonManager:getInstance():exitDungeon()
        elseif state== GameState.IN_STORY then
            local GameInStoryManager = require "app.game.GameInStoryManager"
            GameInStoryManager:getInstance():exitGuide()
        elseif (state == GameState.IN_HERO
                or state == GameState.IN_TITAN_HERO) then
            local GameInHeroManager = require "app.game.GameInHeroManager"
            GameInHeroManager:getInstance():exitHero()
        elseif (state == GameState.IN_DREAM) then
            local GameInDreamManager = require "app.game.GameInDreamManager"
            GameInDreamManager:getInstance():exitDream()
        end
    end
end

--[[释放TownMachine创建BattleMachie，但不释放TownView和TownModel， 会把TownView和TownModel都嫁接到BattleMachie上（
或者额外创建 batlleModel battleView， 但是不管怎样TownView和TownModel 都不能释放）， 这步没有资源释放]]--
function SceneManager:beginPetPVP()
    local state = self._state 
    self._preState = self._state 
    self._state = GameState.NONE
    if(state) then
        if self._sceneType ~= PublicDefine.SCENE_TYPE.BIGSAILPORT then
            local GameInTownManager = require "app.game.GameInTownManager"
            GameInTownManager:getInstance():beginPetPVP()
        else
            local GameInPortManager = require "app.game.GameInPortManager"
            GameInPortManager:getInstance():beginPetPVP()
        end

        
    end
    Avalon.AudioManager:pauseMusic()
    -- self:replaceLoadingScene(LoadingType.LoadingType_Downstairs)
end

-- push命令
function SceneManager:pushCommand(command)
    -- print("SceneManager:pushCommand ", command.type)
    -- 这里根据状态来做指令的缓存逻辑处理
    if(self._waiting) then
        -- 这里屏蔽内部产生的指令
        if(command.category == CommandCategory.CONTROL) then
            table.insert(self._waitingCommondList, command)
        end
    else
        self:_handleCommand(command)
    end
end

function SceneManager:_handleCommand(command, jumpBackHoseTest)
    local GameInCaveManager = require "app.game.GameInCaveManager"
    local GameInTownManager = require "app.game.GameInTownManager"
    local GameInDungeonManager = require "app.game.GameInDungeonManager"
    local GameInGuildManager = require "app.game.GameInGuildManager"
    local GameInStoryManager = require "app.game.GameInStoryManager"
    local GameInHeroManager = require "app.game.GameInHeroManager"
    local GameInDreamManager = require "app.game.GameInDreamManager"
    local GameInManorManager = require "app.game.GameInManorManager"
    local GameInPortManager = require "app.game.GameInPortManager"

    -- 首先判定切换场景指令
    local commandType = command.type
    local state = self._state
    if (commandType == CommandType.CONTROL_BEGIN_TRANS_SCENE) then
        if(jumpBackHoseTest ~= true) then
            self._isDownstairs = false
        end
        local data = command.data or {}
        -- 处理判断是否进入小黑屋
        if(jumpBackHoseTest == nil or jumpBackHoseTest == false) then
            -- dump(command.data)
            print("commandType == CommandType.CONTROL_BEGIN_TRANS_SCENE ", data.transReason)
            -- if(data and data.transType == "EnterBlackHouse") then
            if(data--[[and (data.transReason == "KickOut" or data.transReason == "GoDownstairs")]]) then
                local enterWaiting = false
                if(self:getIsInLoading() == false and (data.transType == "LeaveCave" or data.transType == "Switch")) then
                    if(data.transReason == "KickOut") then
                        Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SHOW_KICKED, KICK_OUT_TYPE.KICK_OUT_TYPE_KICK)
                        enterWaiting = true
                    elseif data.transReason == "ActivityBossSettleOK" then
                        Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SHOW_KICKED, KICK_OUT_TYPE.KICK_OUT_TYPE_END_CAVE)
                        enterWaiting = true
                    elseif data.transReason == "GuildBoss" then
                        local GameDataManager = require("app.game.GameDataManager")
                        -- print("GameDataManager === ", GameDataManager:getInstance():getGuildBossBackTownTimeOut(), GameDataManager:getInstance():getGuildBossBackTownTimeOut() == nil)
                        if(GameDataManager:getInstance():getGuildBossBackTownTimeOut() == nil) then
                            Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SHOW_KICKED, KICK_OUT_TYPE.KICK_OUT_TYPE_END_GUILD_BOSS)
                            enterWaiting = true
                        end
                        GameDataManager:getInstance():setGuildBossBackTownTimeOut(nil)
                    elseif data.transReason == "DreamEnd" then
                        Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SHOW_DREAM_END)
                        enterWaiting = true
                        MasterDataManager:setAutoShowSelectFlag(true)

                    elseif data.transReason == "WorldBossEnd" then
                        enterWaiting = true
                    elseif data.transType == "Switch" and (data.transReason == "GoDownstairs" or data.transReason == "Greedy") then
                        Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SHOW_DOWNSTAIRS_LEAVE)
                        self._isDownstairs = true
                        enterWaiting = true
                    elseif data.transReason == "MazeEnd" then 
                        if mvc and mvc.festivalModel and mvc.festivalModel:getMazeRewardFlag() then 
                            enterWaiting = true
                        end
                    elseif data.transReason == "RatEnd" then
                        if(mvc and mvc.hitRatModel and mvc.hitRatModel:getBattleResult()) then
                            enterWaiting = true
                        end
                    elseif data.transReason == "PuzzleEnd" then
                        if(mvc and mvc.puzzleModel and mvc.puzzleModel:getCurScoreNum() > 0) then
                            enterWaiting = true
                        end
                    elseif data.transReason == "BigCrackEnd" then
                        if mvc.bigCrackModel and ( mvc.bigCrackModel:getIsSettle()) then
                            enterWaiting = true
                        end
                    elseif data.transReason == "ActivityBossSettleOK" then
                        -- if mvc.bigCrackModel and ( mvc.bigCrackModel:getIsSettle()) then
                            enterWaiting = true
                        -- end
                    elseif data.transReason == "TownCave" then
                    
                    else
                        enterWaiting = true
                        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, UI.UITransitionScenarios.AFTER_GAME_SCENE, self, function() 
                            self:leaveWaiting()
                        end)
                    end
                else
                    if(not (data.transReason == "RatEnd" or data.transReason == "MazeEnd")) then
                        enterWaiting = true
                        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, UI.UITransitionScenarios.AFTER_GAME_SCENE, self, function() 
                            self:leaveWaiting()
                        end)
                    end
                end 

                if(enterWaiting) then
                    self:enterWaiting()
                    table.insert(self._waitingCommondList, command)
                    return 
                end
            end
        end

        if isFromReconnect then
            return
        end
        if data.transType == "Switch" and data.transReason == "BeginPetPVP" then
            self:beginPetPVP()
        else
            self:exitCurrentState()
            if(self._isDownstairs) then 
                self:replaceLoadingScene(LoadingType.LoadingType_Downstairs)
            else 
                self:replaceLoadingScene(LoadingType.LoadingType_Normal)
            end   
        end
        return
    elseif (commandType == CommandType.CONTROL_LOADSCENCE) then
        -- 加载场景
        -- self._preState = self._state
        local data = command.data
        --dump(data)
        local caveMode = data.caveMode
        local sceneType = data.type
        print("sceneType",sceneType,"caveMode",caveMode)
        if caveMode ~= PublicDefine.CAVE_MODE.MODE_PET then
            self._sceneType = sceneType
        end

        if (sceneType == PublicDefine.SCENE_TYPE.TOWN
            or sceneType == PublicDefine.SCENE_TYPE.TOWN_CAVE) then
            if (caveMode == PublicDefine.CAVE_MODE.MODE_PET) then
                GameInTownManager:getInstance():enterPetPVP()
                SceneManager:getInstance()._state = GameState.PET_PVP
            else
                GameInTownManager:getInstance():enterTown()
            end

            if sceneType == PublicDefine.SCENE_TYPE.TOWN_CAVE then 
                SceneManager:getInstance()._state = GameState.IN_HOME
            end
        elseif (sceneType == PublicDefine.SCENE_TYPE.GUILD) then
            GameInGuildManager:getInstance():enterGuild()
        elseif (sceneType == PublicDefine.SCENE_TYPE.MANOR) then
            GameInManorManager:getInstance():enterManor()
        elseif (sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT) then
            if (caveMode == PublicDefine.CAVE_MODE.MODE_PET) then
                local GameInPortManager = require "app.game.GameInPortManager"
                GameInPortManager:getInstance():enterPetPVP()
                SceneManager:getInstance()._state = GameState.PET_PVP
            else
                GameInPortManager:getInstance():enterPort()
            end
        elseif (sceneType == PublicDefine.SCENE_TYPE.CAVE or 
            sceneType == PublicDefine.SCENE_TYPE.BLACK_HOUSE or 
            sceneType == PublicDefine.SCENE_TYPE.SHOP or 
            sceneType == PublicDefine.SCENE_TYPE.BOSS or 
            sceneType == PublicDefine.SCENE_TYPE.SCENE_TYPE_ACTIVITY) then

            if caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL
                or caveMode == PublicDefine.CAVE_MODE.MODE_WORLD_BOSS
                or caveMode == PublicDefine.CAVE_MODE.MODE_GUILD_BOSS
                or caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES
                or caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE
                or caveMode == PublicDefine.CAVE_MODE.MODE_ACT
                or caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO
                or caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT
                or caveMode == PublicDefine.CAVE_MODE.MODE_GHOST_ABYSS
                or caveMode == PublicDefine.CAVE_MODE.MODE_TRIAL_LAND
                or caveMode == PublicDefine.CAVE_MODE.MODE_VIKING
                or caveMode == PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT
                or caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
                or caveMode == PublicDefine.CAVE_MODE.MODE_TREATURE_HUNT
                or caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING
                or caveMode == PublicDefine.CAVE_MODE.MODE_EXP
                or caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS
                or caveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE
            then
                GameInCaveManager:getInstance():enterCave()
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON) then
                local GameInDungeonManager = require "app.game.GameInDungeonManager"
                GameInDungeonManager:getInstance():enterDungeon()
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_STORY) then
                GameInStoryManager:getInstance():enterGuide()
            elseif(caveMode == PublicDefine.CAVE_MODE.MODE_HERO
                    or caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then
                GameInHeroManager:getInstance():enterHero(caveMode)
            elseif(caveMode == PublicDefine.CAVE_MODE.MODE_DREAM) then
                GameInDreamManager:getInstance():enterDream()
            else
            end
            if(caveMode == PublicDefine.CAVE_MODE.MODE_WORLD_BOSS) then
                SceneManager:getInstance()._state = GameState.IN_WORLDBOSS
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_GUILD_BOSS) then
                SceneManager:getInstance()._state = GameState.IN_GUILDBOSS
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES) then
                SceneManager:getInstance()._state = GameState.IN_DESERT_EYES
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE) then
                SceneManager:getInstance()._state = GameState.IN_DISTORTED_SPACE
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_ACT) then
                SceneManager:getInstance()._state = GameState.IN_ACT
                GoodsDataManager:setPacketSubType(PublicDefine.PACKET_SUB_TYPE.PACKET_SUB_TYPE_2)
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO) then
                SceneManager:getInstance()._state = GameState.IN_INFERNO
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_GHOST_ABYSS) then
                SceneManager:getInstance()._state = GameState.IN_GHOST_ABYSS
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT) then
                SceneManager:getInstance()._state = GameState.IN_VOID_RAFT
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_TRIAL_LAND) then
                SceneManager:getInstance()._state = GameState.IN_TRIAL_LAND
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_VIKING) then
                SceneManager:getInstance()._state = GameState.IN_VIKING
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT) then
                SceneManager:getInstance()._state = GameState.IN_EVER_WINTER
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD) then
                SceneManager:getInstance()._state = GameState.IN_TITAN_ROAD
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_TREATURE_HUNT) then
                SceneManager:getInstance()._state = GameState.IN_TREATURE_HUNT
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING) then
                SceneManager:getInstance()._state = GameState.IN_DRIED_SPRING
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_EXP) then
                SceneManager:getInstance()._state = GameState.IN_EXP
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS) then
                SceneManager:getInstance()._state = GameState.IN_CHAOS_WORMHOLE
            elseif (caveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE) then
                SceneManager:getInstance()._state = GameState.IN_WORMHOLE
            end
        else
            assert(false, string.format("[ERROR] [Game Manager] no handle %d scene to replace.",sceneType))
        end
        print("self._state",self._state)
        Game.ChatManager:getInstance():loadLoalFile()
        Game.FunctionUnlockManager:getInstance():loadLocalFile()

        -- 处理恢复在场景转换到加载场景之间指定的指令
        for k,v in ipairs(self._waitingBeginTransLoadScene) do
            self:_handleCommand(v)
        end
        self._waitingBeginTransLoadScene = {}
    end
    
    if (self._state == GameState.IN_TOWN
        or self._state == GameState.IN_HOME) then
        -- 城镇指令
        GameInTownManager:getInstance():pushCommandForInTownState(command)
    elseif (self._state == GameState.IN_GUILD) then
        GameInGuildManager:getInstance():pushCommandForInGuildState(command)
    elseif (self._state == GameState.IN_MANOR) then
        GameInManorManager:getInstance():pushCommandForInManorState(command)
    elseif (self._state == GameState.IN_PORT) then
        GameInPortManager:getInstance():pushCommandForInPortState(command)
    elseif (self._state == GameState.IN_CAVE) 
        or self._state == GameState.IN_WORLDBOSS
        or self._state == GameState.IN_GUILDBOSS
        or self._state == GameState.IN_DESERT_EYES
        or self._state == GameState.IN_DISTORTED_SPACE
        or self._state == GameState.IN_ACT
        or self._state == GameState.IN_INFERNO
        or self._state == GameState.IN_GHOST_ABYSS
        or self._state == GameState.IN_VOID_RAFT
        or self._state == GameState.IN_TRIAL_LAND
        or self._state == GameState.IN_VIKING
        or self._state == GameState.IN_EVER_WINTER
        or self._state == GameState.IN_TITAN_ROAD
        or self._state == GameState.IN_TREATURE_HUNT
        or self._state == GameState.IN_DRIED_SPRING
        or self._state == GameState.IN_EXP
        or self._state == GameState.IN_CHAOS_WORMHOLE
        or self._state == GameState.IN_WORMHOLE
    then
        GameInCaveManager:getInstance():pushCommandForInCaveState(command)
    elseif (self._state == GameState.IN_DUNGEON) then
        GameInDungeonManager:getInstance():pushCommandForInDungeonState(command)
    elseif (self._state == GameState.IN_STORY) then
        GameInStoryManager:getInstance():pushCommandForInGuideState(command)
    elseif(self._state == GameState.IN_HERO
            or self._state == GameState.IN_TITAN_HERO) then
        GameInHeroManager:getInstance():pushCommandForInHeroState(command)
    elseif(self._state == GameState.IN_DREAM) then
        GameInDreamManager:getInstance():pushCommandForInDreamState(command)
    elseif (self._state == GameState.PET_PVP) then
        if self._sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT then
            GameInPortManager:getInstance():pushCommandForInPortState(command)
        else
            GameInTownManager:getInstance():pushCommandForInTownState(command)
        end
        
    else
        -- print("SceneManager no handle=", commandType)
        -- print(debug.traceback())
        if(BeginTransToLoadSceneSpecial[commandType]) then 
            table.insert(self._waitingBeginTransLoadScene, command)
        end
    end
end

-- 这里判断每个功能的打开是否符合条件
function SceneManager:checkFunctionCondition(functionType)
    functionType = functionType or 0
    local FUNCTION_TYPE = PublicDefine.FUNCTION_TYPE
    if SceneManager:getInstance():isInTown() 
        or SceneManager:getInstance():isHome() then
        if  functionType == FUNCTION_TYPE.SPEAKER or
            functionType == FUNCTION_TYPE.GUILD_MANAGER or
            functionType == FUNCTION_TYPE.EXCHANGE_IN_TOWN or
            functionType == FUNCTION_TYPE.BLACK_MARKET or 
            functionType == FUNCTION_TYPE.RANDOMSHOPUNLOCK or 
            functionType == FUNCTION_TYPE.SELL_GOODS or
            functionType == FUNCTION_TYPE.MAILBOX or
            functionType == FUNCTION_TYPE.GENERAL_ENTRANCE or
            functionType == FUNCTION_TYPE.SPECIFIC_ENTRANCE or
            functionType == FUNCTION_TYPE.TASK or
            functionType == FUNCTION_TYPE.ACHIEVEMENT or
            functionType == FUNCTION_TYPE.LEADERBOARD or
            functionType == FUNCTION_TYPE.WAREHOUSE or
            functionType == FUNCTION_TYPE.GUILD_ENTRANCE or
            functionType == FUNCTION_TYPE.EQUIPMENT_STRENGTHEN or
            functionType == FUNCTION_TYPE.PET_EQUIPMENT_STRENGTHEN or
            functionType == FUNCTION_TYPE.EQUIPMENT_REMODEL or
            functionType == FUNCTION_TYPE.CAT_FOOD or
            functionType == FUNCTION_TYPE.EQUIPMENT_DECOMPOSE or
            functionType == FUNCTION_TYPE.EQUIPMENT_FORGE or
            functionType == FUNCTION_TYPE.FACELIFT or
            functionType == FUNCTION_TYPE.LUCKYWHEEL_TURN or
            functionType == FUNCTION_TYPE.DUNGEON_SEASON_REWARD or
            functionType == FUNCTION_TYPE.ACTIVITY or
            functionType == FUNCTION_TYPE.GEMSTONE_INLAID or
            functionType == FUNCTION_TYPE.GEMSTONE_COMPOSE or
            functionType == FUNCTION_TYPE.GEMSTONE_TRANSFORM or
            functionType == FUNCTION_TYPE.ENCHANT or
            functionType == FUNCTION_TYPE.GEMSTONE_BUY or 
            functionType == FUNCTION_TYPE.HOME_SYSTEM_MINE or
            functionType == FUNCTION_TYPE.HOME_SYSTEM_GEM or
            functionType == FUNCTION_TYPE.SKILL_ADVANCED or
            functionType == FUNCTION_TYPE.EQUIPMENT_ILLUSION or
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_DREAM or 
            functionType == FUNCTION_TYPE.EQUIP_CONVERT or 
            functionType == FUNCTION_TYPE.EQUIP_RECAST or 
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_STARPRAY_GET or 
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_STARPRAY_EQUIP or 
            functionType == FUNCTION_TYPE.EQUIP_REFINE or 
            functionType == FUNCTION_TYPE.EQUIP_SET_CHANGE or 
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_EXPEDITION or
            functionType == FUNCTION_TYPE.DESERT_EYE or
            functionType == FUNCTION_TYPE.DISTORTED_SPACE or
            functionType == FUNCTION_TYPE.EQUIP_LEVEL_REMOVE or
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_FESTIVAL or
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_PETTREASURE or 
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_PETRECYCLINGSHOP or 
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_FESTIVAL_EXCHANGE_SHOP or
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_PETDEVELOP or
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_HOME or
            functionType == FUNCTION_TYPE.WAREHOUSE or
            functionType == FUNCTION_TYPE.HOME_SYSTEM_MINE or
            functionType == FUNCTION_TYPE.HOME_SYSTEM_GEM or 
            functionType == FUNCTION_TYPE.SKILL_ADVANCED or
            functionType == FUNCTION_TYPE.EQUIPMENT_ILLUSION or
            functionType == FUNCTION_TYPE.FUNCITON_TYPE_DREAM_TASK or
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_PETTREASURE or
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_EXPEDITION or
            functionType == FUNCTION_TYPE.FUNCTION_GHOST_SHOP or
            functionType == FUNCTION_TYPE.FUNCTION_GHOST_LEVELSELECT or
            functionType == FUNCTION_TYPE.FUNCTION_PET_ADVENTURE or
            functionType == FUNCTION_TYPE.FUNCTION_MANOR_PORTAL or
            functionType == FUNCTION_TYPE.FUNCTION_INFERNO or
            functionType == FUNCTION_TYPE.FUNCTION_VOID_RIFT or
            functionType == FUNCTION_TYPE.FUNCTION_VIKING or
            functionType == FUNCTION_TYPE.FUNCTION_PET_STONE or
            functionType == FUNCTION_TYPE.FUNCTION_TREASURE_IDENTIFY or
            functionType == FUNCTION_TYPE.FUNCTION_EVER_WINTER or 
            functionType == FUNCTION_TYPE.FUNCTION_REINCARNATION or 
            functionType == FUNCTION_TYPE.FUNCTION_MOLDFORING or 
            functionType == FUNCTION_TYPE.FUNCTION_MOLDUSE or
            functionType == FUNCTION_TYPE.FUNCTION_CHAOS or
            functionType == FUNCTION_TYPE.FUNCTION_GLYPH or 
            functionType == FUNCTION_TYPE.FUNCTION_WORMHOLE or 
            functionType == FUNCTION_TYPE.FUNCTION_CHANGEPURPLE or 
            functionType == FUNCTION_TYPE.FUNCTION_GEMCONNECT or 
            functionType == FUNCTION_TYPE.FUNCTION_GEMDECOMPOSE then
            return true
        else
            print(string.format("checkFunctionCondition not add functionType=%d in town/home scene", tonumber(functionType)))
        end
    elseif SceneManager:getInstance():isGuild() then 
        if  functionType == FUNCTION_TYPE.GUILD_MARKET or
            functionType == FUNCTION_TYPE.SPEAKER or
            functionType == FUNCTION_TYPE.GUILD_MANAGER or
            functionType == FUNCTION_TYPE.GUILD_TASK or 
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_GUILDBOSS or 
            functionType == FUNCTION_TYPE.GUILD_TECH or
            functionType == FUNCTION_TYPE.GUILD_WRIT or
            functionType == FUNCTION_TYPE.GUILD_AUCTION_STOCK or
            functionType == FUNCTION_TYPE.GUILD_AUCTION_MAIN or
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_PETTREASURE or 
            functionType == FUNCTION_TYPE.FUNCTION_TYPE_WISHPOOL or
            functionType == FUNCTION_TYPE.LUCKYWHEEL_TURN then
            return true
        else
            print(string.format("checkFunctionCondition not add functionType=%d in guild scene", tonumber(functionType)))
        end
    elseif SceneManager:getInstance():isInFightScene() then 
        if  functionType == FUNCTION_TYPE.SPEAKER or
            functionType == FUNCTION_TYPE.GUILD_MANAGER or
            functionType == FUNCTION_TYPE.GOLD_TOUCH or 
            functionType == FUNCTION_TYPE.ENCHANT or
            functionType == FUNCTION_TYPE.FUNCTION_GHOST_ABYSS_TOTEM or
            functionType == FUNCTION_TYPE.FUNCTION_GHOST_ABYSS_ACTIVATED_TOTEM or
            functionType == FUNCTION_TYPE.EXCHANGE_IN_CAVE or
            functionType == FUNCTION_TYPE.FUNCTION_BOSS_PORTAL or
            functionType == FUNCTION_TYPE.FUNCTION_BARTER then
            
            return true
        else
            print(string.format("checkFunctionCondition not add functionType=%d in battle scene", tonumber(functionType)))
        end

        if(SceneManager:getInstance():isInDream()) then 
            if functionType == FUNCTION_TYPE.FUNCITON_TYPE_DREAM_TASK then 
                return true
            end
        end
    elseif SceneManager:getInstance():isInManor() then 
        if  functionType == FUNCTION_TYPE.FUNCTION_MANOR_PORTAL or
            functionType == FUNCTION_TYPE.FUNCTION_FISH_SHOP or 
            functionType == FUNCTION_TYPE.FUNCTION_SUIT_TRANSFORMATION or 
            functionType == FUNCTION_TYPE.FUNCTION_MANOR_HOUSEKEEPER or 
            functionType == FUNCTION_TYPE.FUNCTION_MANOR_DESK or 
            functionType == FUNCTION_TYPE.FUNCTION_MANOR_DRESS_UP_SHELF or 
            functionType == FUNCTION_TYPE.FUNCTION_MANOR_BOAT or 
            functionType == FUNCTION_TYPE.FUNCTION_TRAVELING_BUSINESSMAN or
            functionType == FUNCTION_TYPE.FUNCTION_MANOR_DININGTABLE then

                local GameInManorManager = require "app.game.GameInManorManager"
                local pk = RoleDataManager:getMaster():getPK()
                local ownerPk = GameInManorManager:getInstance():getOwnerPk()
                if pk ~= ownerPk then
                    if functionType ~= FUNCTION_TYPE.FUNCTION_MANOR_PORTAL and 
                    functionType ~= FUNCTION_TYPE.FUNCTION_TRAVELING_BUSINESSMAN and 
                    functionType ~= FUNCTION_TYPE.FUNCTION_FISH_SHOP then
                        return false
                    end
                end
                
            return true
        else
            print(string.format("checkFunctionCondition not add functionType=%d in battle scene", tonumber(functionType)))
        end
    elseif SceneManager:getInstance():isInPort() then
        if  functionType == FUNCTION_TYPE.FUNCTION_NAVIGATION_STORE or
            functionType == FUNCTION_TYPE.FUNCTION_NAVIGATION_TASK or 
            functionType == FUNCTION_TYPE.FUNCTION_NAVIGATION_SUPPLY or 
            functionType == FUNCTION_TYPE.FUNCTION_BET or
            functionType == FUNCTION_TYPE.FUNCTION_RALLYGAME then
                print("isInPort functionType--->: ", functionType)
                -- local GameInPortManager = require "app.game.GameInPortManager"
                -- local pk = RoleDataManager:getMaster():getPK()
                -- local ownerPk = GameInPortManager:getInstance():getOwnerPk()
                -- if pk ~= ownerPk then
                --     if functionType ~= FUNCTION_TYPE.FUNCTION_MANOR_PORTAL and 
                --     functionType ~= FUNCTION_TYPE.FUNCTION_TRAVELING_BUSINESSMAN and 
                --     functionType ~= FUNCTION_TYPE.FUNCTION_FISH_SHOP then
                --         return false
                --     end
                -- end
                
            return true
        else
            print(string.format("checkFunctionCondition not add functionType=%d in battle scene", tonumber(functionType)))
        end
    else 
        return false
    end

    return false
end

function SceneManager:initSpecialData()
    BeginTransToLoadSceneSpecial[CommandType.CONTROL_ROLE_ATTR_CHANGE] = true;
end

function SceneManager:canVisitManor()
    local can = SceneManager:getInstance():isInManor() or 
    SceneManager:getInstance():isGuild() or 
    SceneManager:getInstance():isInTown() or 
    SceneManager:getInstance():isHome()

    return can
end

function SceneManager:checkModeIsNewCave(caveMode)
    local can = false
    if caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE
    or caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO
    or caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT
    or caveMode == PublicDefine.CAVE_MODE.MODE_VIKING
    or caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
    or caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO
    or caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING
    or caveMode == PublicDefine.CAVE_MODE.MODE_EXP
    or caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS
    or caveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE then
        can = true
    end

    return can
end

function SceneManager:checkModeIsNewLimitCave(caveMode)
    local can = false
    if caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
    or caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING
    or caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS
    or caveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE then
        can = true
    end

    return can
end

return SceneManager;