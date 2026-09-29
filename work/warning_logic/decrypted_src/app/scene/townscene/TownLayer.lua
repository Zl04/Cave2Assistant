--[[
    游戏城镇场景
]]--

require "app.ui.UIManager"
require("app.game.BlackDialogManager")

local AudioUtil = require ("app.utils.AudioUtil")
local GameDataManager = require("app.game.GameDataManager")

local CONST_DEFINITION = PublicDefine.CONST_DEFINITION

local IS_SHOW = false
-- 游戏场景中的层级
local TOWN_LAYER_ZORDER = {
    TOWN_LAYER = 1,
    WEATHER_LAYER = 2,
    UI_LAYER = 3
}

local TownLayer = class("TownLayer", function ()
    return cc.Layer:create()
end)

function TownLayer:createScene()
    print("TownLayer:createScene")
    local scene = cc.Scene:create()    
    local townLayer = TownLayer:create()
    scene:addChild(townLayer)

    return scene
end

function TownLayer:ctor()
    self._townLayer = nil
    self._weatherLayer = nil;
    self._uiLayer = nil

    self.m_enterTownLabel = nil

    if(LANGUAGE_CHANGE) then
        LANGUAGE_CHANGE = nil
        -- 释放没有使用的字库文件
        AvalonUtil:fontPurgeCachedData()
    end

    self:init()
    
    local SceneManager = require("app.game.SceneManager")
    -- print("state=", SceneManager:getInstance():isGuild(), SceneManager:getInstance()._state)
    if(SceneManager:getInstance():isGuild()) then
        Net.NetGuildSystem:reqGuildBossGetData()
    end
    if(SceneManager:getInstance():isNotInFightScene()) then
        MasterDataManager:triggerRefreshData()
    end
end

function TownLayer:init()
    -- 城镇视图
    self._townLayer = cc.Layer:create()
    self:addChild(self._townLayer, TOWN_LAYER_ZORDER.TOWN_LAYER)
    -- 天气效果层
    self._weatherLayer = cc.Layer:create()
    self:addChild(self._weatherLayer, TOWN_LAYER_ZORDER.TOWN_LAYER)
    -- 战斗的ui
    self._uiLayer = cc.Layer:create()
    self:addChild(self._uiLayer, TOWN_LAYER_ZORDER.UI_LAYER)

    -- 注册node事件
    function onNodeEventHandler(nodeEvent)
        if (nodeEvent == "enter") then
            self:onEnter()
        elseif (nodeEvent == "exit") then
            self:onExit()
        else end
    end
    self:registerScriptHandler(onNodeEventHandler)
    --回城清理 宠物复活计数
    -- MasterDataManager:setPetReviveTimes(0)
    MasterDataManager:clearPetReviveTimes()
    -- 请求新公会随机商店刷新时间
    Net.NetNPCSystem:requestGuildRandomShopRefreshTime()
end
-- 检测是否需要弹出绑定账号提示
function TownLayer:checkGuestAccountBind()
    local gameLoginManager = require("app.game.GameLoginManager")
    local versionAccount = gameLoginManager:getInstance():getVersionAccount()
    versionAccount = checkint(versionAccount)
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    -- dump(globalUserData,"globalUserData")
    local lastTime = 0
    local ignorelBindToast = false
    if(globalUserData) then
        lastTime = globalUserData:getLastBindToastTime()
        ignorelBindToast = globalUserData:isIgnoreBindToast()
        -- 第一次不弹
        if lastTime <= 0 then
            globalUserData:markBindToastTime()
            return
        end
    end
    
    -- print("versionAccount",versionAccount)
    -- 是游客账号并且没有忽略
    if versionAccount == PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_GUEST  then
        if not ignorelBindToast then
            local interval = ConfigManager:getBindAccountInterval()
            interval = interval * 24 * 60 * 60
            
            -- 测试代码
            -- interval = 120
            if os.time() - lastTime > interval then
                if globalUserData then
                    globalUserData:markBindToastTime()
                end

                UI.TipsLayer:createBindAccountTips(function()
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SETTING_SHOW_ACCOUNT_BIND)
                end,nil, function()
                    if globalUserData then
                        globalUserData:ignoreBindToast()
                    end
                    Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL);
                end)

                -- local tips = UI.Tips:createTips(UI.TEXT_111155,UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.BIND_ACCOUNT_TIPS,UI.TipsButtonType.TEXT_BUTTON,nil,true)
                -- -- 确定跳往设置界面 打开背包的设置界面。这样写死5很不好。应该声明在外部
                -- tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                --     Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG,5)
                -- end)
                -- -- 不再提醒关闭对话框
                -- tips:addEventListener(UIEvent.DIALOG_CENTER, self, function()
                --     if globalUserData then
                --         globalUserData:ignoreBindToast()
                --     end
                --     Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL);
                -- end)
                -- tips.touchDialogOutsizeClose = false;
                Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL);
            end
            
        end
    end
end
function TownLayer:onEnter()
    Game.BlackDialogManager:getInstance():update(0)
    
end

function TownLayer:onExit()
    local StoryManager = require("app.story.StoryManager")
    StoryManager:getInstance():leaveScene()
    self:unregisterScriptHandler()
    -- 关闭帧率检测
    Avalon.Scheduler:unscheduleUpdate(self,self.detectFps)
    Avalon.Scheduler:unscheduleUpdate(self,self.setDefaultCustomHQ)
end

function TownLayer:getSceneLayer()
    return self._townLayer
end
function TownLayer:getWeatherLayer()
    return self._weatherLayer
end

function TownLayer:getUILayer()
    return self._uiLayer
end

function TownLayer:triggerReward()
    Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
        if not tolua.isnull(self) then
            self:_triggerReward() 
        end
    end, 0.5)
end

function TownLayer:_triggerReward()
    -- 处理检测是否显示结算页面
    local isShowNotice = true
    local isShowReward = GameDataManager:getInstance():getIsShowReward()
    if (isShowNotice and isShowReward) then
        AudioUtil:playVictorySound()
        self:_triggerShowReward()
        isShowNotice = false
    else
        TaskDataManager:clearUpdateExpeditionData()
        -- local mode,checkPoint = TaskDataManager:getUpdateExpeditionData()
        -- if(mode and checkPoint) then 
        --     print("checkPoint wwwww=", mode, checkPoint)
        --     self:_triggerShowUpdateExpedition(mode, checkPoint)
        --     isShowNotice = false
        -- end
    end

    local isCompleted = TaskDataManager:checkTaskIsCompleteByID(20040)
    local isReincarntion = RoleDataManager:getIsReincarntion()
    if(isShowNotice and isCompleted and not isReincarntion) then 
        AudioUtil:playVictorySound()
        self:_triggerShowReincarnation()
        isShowNotice = false
    end

    local guildRewardData = GameDataManager:getInstance():getGuildBossRewardData()
    if(isShowNotice and guildRewardData) then 
        AudioUtil:playVictorySound()
        self:_triggerShowGuildBossReward()
        isShowNotice = false
    end

    local ghostRewardData = mvc.caveModel:getGhostAbyssRewardData()
    if(isShowNotice and ghostRewardData) then 
        AudioUtil:playVictorySound()
        self:_triggerGhostAbyssReward()
        isShowNotice = false
    end

    if mvc.activityModeCaveModel:getIsShowTrialLandRewardLayer() then
        local trialLandRewardData = mvc.activityModeCaveModel:getTrialLandSettleData()
        if(isShowNotice and trialLandRewardData and trialLandRewardData.isSuccess) then 
            AudioUtil:playVictorySound()
            self:_triggerTrialLandReward(trialLandRewardData)
            mvc.activityModeCaveModel:setIsShowTrialLandRewardLayer(false)
            isShowNotice = false
        end
    end

    -- local loftLevel = RoleDataManager:getMaster():getDungeonLoftLevel()
    local FightResultUtil = require("app.ui.cave.fightResult.FightResultUtil")
    local battleReward = FightResultUtil:getInstance():getDungeonBattleReward()
    -- print("-------------loftLevel = "..loftLevel)
    if isShowNotice and battleReward then
        AudioUtil:playVictorySound()
        self:_triggerShowDungeonReward()
        isShowNotice = false
    end

    -- 成长基金达到对应等级弹窗
    if( isShowNotice
        and mvc.tradeActivityModel:getGrowFundTipsShow() > 0
        and not mvc.tradeActivityModel:getGrowFundIsBuy() )then 
            local roleLevel = RoleDataManager:getMaster():getLevel()
            local lv = mvc.tradeActivityModel:getGrowFundTipsShow()
            mvc.tradeActivityModel:setGrowFundTipsShow(0)
            if lv ~= 0 and roleLevel >= lv then
                isShowNotice = false
                require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                local agTips = UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityGrowFund)
                agTips.cancelCallback = function()
                    if mvc.tradeActivityModel:getNewGrowFundTipsShow() > 0
                    and not mvc.tradeActivityModel:getNewGrowFundIsBuy()then

                        Avalon.Scheduler:setDelayForUpdateOnce(self, function()
                            local roleLevel = RoleDataManager:getMaster():getLevel()
                            local lv = mvc.tradeActivityModel:getNewGrowFundTipsShow()
                            mvc.tradeActivityModel:setNewGrowFundTipsShow(0)
                            if lv ~= 0 and roleLevel >= lv then
                                isShowNotice = false
                                require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                                UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund)
                            end
                        end, 1)

                    elseif mvc.tradeActivityModel:getNewGrowFundTwoTipsShow() > 0
                    and mvc.tradeActivityModel:newGrowFundTwoCanBeOpened()then
                        Avalon.Scheduler:setDelayForUpdateOnce(self, function()
                            local roleLevel = RoleDataManager:getMaster():getLevel()
                            local lv = mvc.tradeActivityModel:getNewGrowFundTwoTipsShow()
                            mvc.tradeActivityModel:setNewGrowFundTwoTipsShow(0)
                            if lv ~= 0 and roleLevel >= lv then
                                isShowNotice = false
                                require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                                UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo)
                            end
                        end, 1)
                    end
                end
            end
    elseif (isShowNotice
    and mvc.tradeActivityModel:getNewGrowFundTipsShow() > 0
    and not mvc.tradeActivityModel:getNewGrowFundIsBuy())then

            local roleLevel = RoleDataManager:getMaster():getLevel()
            local lv = mvc.tradeActivityModel:getNewGrowFundTipsShow()
            mvc.tradeActivityModel:setNewGrowFundTipsShow(0)
            if lv ~= 0 and roleLevel >= lv then
                isShowNotice = false
                require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund)
            end
    elseif (isShowNotice and
        mvc.tradeActivityModel:getGrowFundIITipsShow() > 0 and
        mvc.tradeActivityModel:getGrowFundIsBuy() and
        not mvc.tradeActivityModel:getGrowFundIIIsBuy() )then

            local roleLevel = RoleDataManager:getMaster():getLevel()
            local lv = mvc.tradeActivityModel:getGrowFundIITipsShow()
            mvc.tradeActivityModel:setNewGrowFundTipsShow(0)
            if lv ~= 0 and roleLevel >= lv then
                isShowNotice = false
                require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityGrowFundII)
            end
    elseif (isShowNotice and
        mvc.tradeActivityModel:getGrowFund3TipsShow() > 0 and
        mvc.tradeActivityModel:getGrowFundIIIsBuy() and
        not mvc.tradeActivityModel:getGrowFund3IsBuy())then

            local roleLevel = RoleDataManager:getMaster():getLevel()
            local lv = mvc.tradeActivityModel:getGrowFund3TipsShow()
            mvc.tradeActivityModel:setNewGrowFundTipsShow(0)
            if lv ~= 0 and roleLevel >= lv then
                isShowNotice = false
                require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityGrowFund3)
            end
    elseif (isShowNotice
    and mvc.tradeActivityModel:getNewGrowFundTwoTipsShow() > 0
    and mvc.tradeActivityModel:newGrowFundTwoCanBeOpened())then

            local roleLevel = RoleDataManager:getMaster():getLevel()
            local lv = mvc.tradeActivityModel:getNewGrowFundTwoTipsShow()
            mvc.tradeActivityModel:setNewGrowFundTwoTipsShow(0)
            if lv ~= 0 and roleLevel >= lv then
                isShowNotice = false
                require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo)
            end
    end

    if MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw) then
        local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)
        local annivesaryLotteryData = activityData:getAnniversaryLotteryData()
        local isOpening = mvc.activityAnnivesaryLotteryModel:getAnniversaryLotteryIsShowByData(activityData)
        local isShow = cc.UserDefault:getInstance():getBoolForKey("annivesaryLotteryShow", false)
        if isShow and not cc.UserDefault:getInstance():getBoolForKey("annivesaryLotteryAdvancedShow", false)  then
            local advancedactivityData = mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryActivityData(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_Gift)
            if advancedactivityData then
                local advancedLotteryData = advancedactivityData:getAnniversaryLotteryData()
                if advancedLotteryData then
                    isShow = not mvc.activityAnnivesaryLotteryModel:isCanSign(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_Gift)
                end
            end
        end
        if(annivesaryLotteryData and isOpening and not isShow) then 
            self:_triggerAnniversaryShowPreview(annivesaryLotteryData)
            isShowNotice = false
        end
    end

    if mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryRewardStateData() then
        local annivesaryLotteryData = mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryRewardStateData()
        local isShow = annivesaryLotteryData.isReadRewardResult
        if(annivesaryLotteryData and annivesaryLotteryData.isSign and annivesaryLotteryData.rewardState ~= 0 and not isShow) then 
            self:_triggerAnniversaryShowRewardView(annivesaryLotteryData)
            isShowNotice = false
        end
    end

    -- 七日签到
    local StoryManager = require "app.story.StoryManager"
    if( isShowNotice
        and not StoryManager:getInstance():isInRun()
        and mvc.sevenDaysModel:getSignFinishStateForGoal(SEVEN_DAY_SIGN) 
        and mvc.sevenDaysModel:isOpenGoal(SEVEN_DAY_TASK)
        and MasterDataManager:getShowSevenStatus()) then 
        MasterDataManager:setShowSevenStatus(false)
        mvc.openPanel("SevenDays", "SevenDays", {planType = SEVEN_DAY_TASK, signInType = SEVEN_DAY_SIGN, callBack =  handler(self, self.triggerReward)})
        isShowNotice = false
    end

    self:checkGuestAccountBind()

    if isShowNotice then
        local SdkBox = require("utils.sdkbox.SdkBox")
        local isDeepLink, data = SdkBox:getInstance():getDeepLinkParams()
        -- print("isDeepLink, data=", isDeepLink, data)
        if isDeepLink then
            Net.NetRoleSystem:sendClaimDeepLinkAward()
            GameManager:openDeepLink(data, false)
            SdkBox:getInstance():clearDeepLinkParams()
        else
            self:showTownNotice()
        end
    end

end

function TownLayer:_triggerShowUpdateExpedition()
    local mode,checkPoint = TaskDataManager:getUpdateExpeditionData()
    TaskDataManager:clearUpdateExpeditionData()
    if(mode and checkPoint and RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Expedition)) then
        local master = RoleDataManager:getMaster()
        if GoodsDataManager:getHaveGoodsForPK(master:getPK(), PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) 
            or mvc.expeditionModel:getNormalCoin() > 0 
            or mvc.expeditionModel:getNormalExp() > 0 
        then
            -- UI.ScrollBar:createByText(UI.TEXT_1213410)
            -- self:showTownNotice()

            local cardTips =
                UI.ConfirmDialog.show(
                UI.TEXT_1213407,
                function()
                    -- ok
                    if(mvc.expeditionModel:getRemainTime() <= 0) then 
                        local LanguageManager = require("app.game.LanguageManager")
                        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170225))
                    else
                        Net.NetNPCSystem:reqUpdateExpeditionLV(mode, checkPoint)
                    end
                    self:showTownNotice()
                end,
                function()
                    -- cancel
                    self:showTownNotice()
                end
            )
            
        else 
            local cardTips =
                UI.ConfirmDialog.show(
                UI.TEXT_1213407,
                function()
                    -- ok
                    if(mvc.expeditionModel:getRemainTime() <= 0) then 
                        local LanguageManager = require("app.game.LanguageManager")
                        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170225))
                    else
                        Net.NetNPCSystem:reqUpdateExpeditionLV(mode, checkPoint)
                    end
                    self:showTownNotice()
                end,
                function()
                    -- cancel
                    self:showTownNotice()
                end
            )
        end
    end
end

function TownLayer:_triggerShowReincarnationTips()
    -- 完成转生任务解锁转生功能弹出指引窗口
    local tips = UI.Tips:createTips(
        UI.TEXT_224314,
        UI.TipsType.CONFIRM_AND_CANCEL,
        UI.TipsUiType.NORMAL
    )

    tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_FUNCTION_PANEL)
    end)
end

function TownLayer:_triggerShowReward(dt)
    Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REWARD, handler(self, self._triggerShowUpdateExpedition), UI.RewardType.REWARD_NORMAL)
end

function TownLayer:_triggerShowDungeonReward(dt)
    Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REWARD, handler(self, self.showTownNotice), UI.RewardType.REWARD_DUNGEON)
end

function TownLayer:_triggerShowGuildBossReward(dt)
    Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REWARD, handler(self, self.showTownNotice), UI.RewardType.REWARD_GUILD_BOSS)
end

function TownLayer:_triggerGhostAbyssReward(dt)
    Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REWARD, handler(self, self.showTownNotice), UI.RewardType.REWARD_GHOSTABYSS)
end

function TownLayer:_triggerTrialLandReward(data)
    -- Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REWARD, handler(self, self.showTownNotice), UI.RewardType.REWARD_TRIALLAND)
    mvc.send("ActivityModeCave_Show_Entry_Reward_View", data)
end

function TownLayer:_triggerAnniversaryShowPreview(data)
    mvc.send("ActivityAnnivesary_Show_PreView", data)
    -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ACTIVITY_ANNIVERSARY_SHOW_LOTTERY_PREVIEW) 
end

function TownLayer:_triggerAnniversaryShowRewardView(data)
    mvc.send("ActivityAnnivesary_Show_Reward_View", data)
end

function TownLayer:_triggerShowReincarnation(dt)
    -- Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REWARD, handler(self, self._triggerShowReincarnationTips), UI.RewardType.REWARD_NORMAL, true)
    self:_triggerShowReincarnationTips()
end



function TownLayer:showRewardLayer()
    local blackDialog = GameDataManager:getInstance():getTownBlackDialog()
    print("TownLayer 1 run")
    if(blackDialog) then
        -- print("TownLayer 2 run", blackDialog.type, blackDialog.caveMode, blackDialog.caveDifficulty, blackDialog.level)
        local level = blackDialog.level
        -- if (level >= CONST_DEFINITION.BOSS_LEVEL_MIN and level <= CONST_DEFINITION.BOSS_LEVEL_MAX) then

        -- else 
        --     level = nil
        -- end
        print("TownLayer 3 run =", blackDialog.type, blackDialog.caveMode, blackDialog.caveDifficulty, level)
        if (blackDialog.type == 2) then AudioUtil:playDeathSound() end
        Game.BlackDialogManager:getInstance():addEevnt(blackDialog.type, blackDialog.caveMode, blackDialog.caveDifficulty, level, function()
            if not tolua.isnull(self) then
                self:triggerReward()
            end
            Game.FunctionUnlockManager:getInstance():noticeShowAction()
        end)
        GameDataManager:getInstance():clearTownBlackDialog()        
    else
        self:triggerReward()
        Game.FunctionUnlockManager:getInstance():noticeShowAction()
    end

end

function TownLayer:showTownNotice()
    local StoryManager = require("app.story.StoryManager")
    require "app.utils.ImageDownLoadUtil"
    local tNoticeList = ImageDownLoadUtil:getTNoticeInfo()
    if #tNoticeList > 0 then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_TOEWN_NOTICE, tNoticeList, function()
            StoryManager:getInstance():onBlackTown()
            self:showMentorSuggestion()
        end) 
        return true
    end
    StoryManager:getInstance():onBlackTown()
    self:showMentorSuggestion()
    return false
end

function TownLayer:showMentorSuggestion()
    mvc.send(mvc.events.Mentor_Back_Town)
end

function TownLayer:beginShow()
    local AntiAddictionUtil = require("app.utils.AntiAddictionUtil")
    AntiAddictionUtil:doLoginActions()

    local GoalUtil = require("app.utils.GoalUtil")
    GoalUtil:scheduleGoalCloseNotifications()

    local PushUtil = require("app.utils.PushUtil")
    PushUtil:showInAppPushMessage("EnterTown")

    local StoryManager = require("app.story.StoryManager")
    local SceneManager = require("app.game.SceneManager")
    local isShowingExpression = StoryManager:getInstance():enterSceneAndStartStory()
    if not isShowingExpression then
        local SceneManager = require("app.game.SceneManager")
        local lastState = SceneManager:getInstance():getLastState()
        if not (lastState == Game.State.IN_WORLDBOSS) then
            self:showRewardLayer()
        end
    end    

    -- 城镇加入特效
    if SceneManager:getInstance():isInTown() then
        -- self:addWeatherEffect()
    end

    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        UI.UIManager:triggerShowDisconnectTips()
        UI.TipsLayer:createLoginOutGameTips()
    end, 0.1)
    -- 设置帧率
    local curFps = GameManager:getFps()
    GameManager:setFps(curFps)
    -- 检测当前FPS
    if not IS_SHOW and  not GameManager:isFpsModeNoticed() and GameManager:getFps() == 60 then
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            if self.detectFps and type(self.detectFps) == "function" then
                Avalon.Scheduler:scheduleUpdate(self,self.detectFps)   
            end
        end, 5)    
    end
    IS_SHOW = true;

    -- 画质自定义
    if not GameManager:getCustomDefultSetting() then
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            if self.setDefaultCustomHQ and type(self.setDefaultCustomHQ) == "function" then
                Avalon.Scheduler:scheduleUpdate(self,self.setDefaultCustomHQ)   
            end
        end, 1)
    end

    -- 弹出免责协议
    if CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE and not GameManager:isShowDisclaimer() then
        local userProDialog = UI.UserProtocolDialog:create(UI.UserProtocolDialog.UIType.Disclaimer);   
        UI.UIManager:getRootNode():addChild(userProDialog, 100000)
        userProDialog:showUserProtocolDialog();
        GameManager:markShowDisclaimer()
    end
    require("app.utils.PushUtil")
    PushUtil:requestNotiPremission()
    local SdkManager = require"app.game.SdkManager"
    SdkManager:getInstance():firstReqIapDatas()

    -- 返回城镇时，检查一下worldboss是否可报名
    mvc.worldBossModel:checkNeedTownNotify()

    -- 断线重连后，检查一下洞窟迷阵是否需要重新显示房间界面
    mvc.festivalModel:checkNeedReOpenRoomView()

    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        AvalonUtil:testPayDelayTime()
        AvalonUtil:testCNPayDelayTime()
    end, 1)
end
-- 侦测帧率
local times = 0;
local counts = 0;
local detectTime = 5
local maxFps = 0;
function TownLayer:detectFps(dt)
    times = times + dt
    counts = counts + 1;
    local curFps = 1/dt
    maxFps = maxFps + curFps
    
    if times >= detectTime then
        -- 
        local averageFps = maxFps / counts
        
        print("平均帧率  ",averageFps)
        Avalon.Scheduler:unscheduleUpdate(self,self.detectFps)
        if averageFps < 45 then
            local tips = UI.Tips:createTips(UI.TEXT_111161,UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL,UI.TipsButtonType.NO_TEXT_BUTTON,nil,true)
            -- 确定跳往设置界面 打开背包的设置界面。
            tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                UI.ScrollBar:createByText(UI.TEXT_111160)
                GameManager:setFps(45)
                -- local SdkManager = require"app.game.SdkManager"
                -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
                --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_FPS,
                --     60,
                --     45
                -- )
                Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_HighFrameRate, 0)
            end)
            tips.touchDialogOutsizeClose = true;
            GameManager:setFpsModeNoticed()
        end
    end
end

function TownLayer:setDefaultCustomHQ(dt)
    Avalon.Scheduler:unscheduleUpdate(self,self.setDefaultCustomHQ)
    GameManager:setCustomDefultSetting()

    local curFps = 1/dt

    -- 画质自定义静默设置一次
    local customMode = 0
    if curFps >= 50 then
        customMode = 3
    elseif curFps < 50 and curFps >= 30 then
        customMode = 2
    else
        customMode = 1
    end

    print("setDefaultCustomHQ mode: " .. customMode)

    local details = CUSTOM_HQ_SET_MAP[customMode]
    for k, v in ipairs(details) do
        GameManager:setCustomHQ(k, v)
    end

    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if not globalUserData then
        return
    end

    globalUserData:setSettingCustomHQMode(customMode)

    Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL)

    print("saveDataToLocal success")
end

-- 添加天气效果
function TownLayer:addWeatherEffect()

    -- local weather = Config.Weather:random()
    -- local winSize = cc.Director:getInstance():getWinSize()
    -- local effect = Avalon.Animation:create(string.format( "%s.json",weather.spine), string.format( "%s.atlas",weather.spine), 1.0);
    -- effect:setAnimation(0,"idle",true)
    -- effect:setPosition(cc.p(winSize.width/2,winSize.height/2))
    -- self._weatherLayer:addChild(effect)
    -- Avalon.AudioManager:playSound(weather.sound, true)
end

return TownLayer