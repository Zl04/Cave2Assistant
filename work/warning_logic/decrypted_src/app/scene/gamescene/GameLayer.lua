--[[
    游戏战斗场景
]]--

require "app.ui.UIManager"

local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
local SceneManager = require("app.game.SceneManager")

local GameLayer = class("GameLayer", function ()
    return cc.Layer:create()
end)

function GameLayer:createScene()
    print("GameLayer:createScene")
    local scene = cc.Scene:create()    
    local mainLayer = GameLayer:create()
    scene:addChild(mainLayer)

    return scene
end

function GameLayer:ctor()
    self._gameLayer = nil
    self._uiLayer = nil
    self._weatherLayer = nil;
    self:init()
    
    if(LANGUAGE_CHANGE) then
        LANGUAGE_CHANGE = nil
        -- 释放没有使用的字库文件
        AvalonUtil:fontPurgeCachedData()
    end

    -- local skillTest = require "app.tests.SkillTest"
    -- -- skillTest:testBuff()
    -- -- skillTest:testEffect()

    -- local battleTest = require "app.tests.BattleTest"
    -- -- battleTest:testAttrChange(self._uiLayer)

    -- -- TODO 测试物品数据
    -- local goodsTest = require "app.tests.GoodsSystemTest"
    -- -- goodsTest:testGoods()

    local SceneManager = require("app.game.SceneManager")
    if(SceneManager:getInstance():isGuildBoss()) then
        Net.NetGuildSystem:reqGuildBossGetData()
        -- add by zp 如果是世界boss 就修改为每帧把所有指令执行完
        Net.Helper:enableParallel()
    end
end

function GameLayer:init()
    -- 战斗视图
    self._gameLayer = cc.Layer:create()
    self:addChild(self._gameLayer, 1)
 
    self._weatherLayer = cc.Layer:create()
    self:addChild(self._weatherLayer, 2)
    -- 战斗的ui
    self._uiLayer = cc.Layer:create()
    self:addChild(self._uiLayer, 3)

    -- 注册node事件
    function onNodeEventHandler(nodeEvent)
        if (nodeEvent == "enter") then
            self:onEnter()
        elseif (nodeEvent == "exit") then
            self:onExit()
        else end
    end
    self:registerScriptHandler(onNodeEventHandler)
end

function GameLayer:onEnter()
    
end

function GameLayer:onExit()
    local StoryManager = require("app.story.StoryManager")
    StoryManager:getInstance():leaveScene()
    self:unregisterScriptHandler()

    local SceneManager = require("app.game.SceneManager")
    if(SceneManager:getInstance():isGuildBoss()) then
        -- add by zp 如果是世界boss 就修改为每帧把所有指令执行完
        Net.Helper:disableParallel()
    end
end

function GameLayer:getSceneLayer()
    return self._gameLayer
end
function GameLayer:getWeatherLayer()
    return self._weatherLayer
end
function GameLayer:getUILayer()
    return self._uiLayer
end

function GameLayer:beginShow()
    -- 刷新变形等操作
    local masterData = RoleDataManager:getMaster()
    if(masterData) then
        masterData:handleDelusion(0)
    end

    -- add by zp CO-6405 在离开队伍以后，进入单人模式，需要添加一个提示语言
    -- print("GameMapManager:getInstance():getIsCopyFromTeam()", GameMapManager:getInstance():getIsCopyFromTeam())
    if(GameMapManager:getInstance():getIsCopyFromTeam()) then 
        UI.ConfirmDialog.showConfrimOnly(UI.TEXT_1212221, nil, nil, nil, nil)
    end

    local AntiAddictionUtil = require("app.utils.AntiAddictionUtil")
    AntiAddictionUtil:doLoginActions()

    local GoalUtil = require("app.utils.GoalUtil")
    GoalUtil:scheduleGoalCloseNotifications()

    local PushUtil = require("app.utils.PushUtil")
    PushUtil:showInAppPushMessage("EnterCave")

    local function checkStoryAndNotice()
        local StoryManager = require("app.story.StoryManager")
        local isShowingExpression = StoryManager:getInstance():enterSceneAndStartStory()
        print("====================beginShow(), storyShowExpression", isShowingExpression)
        if not isShowingExpression then
            self:showTownNotice()
        end
    end

    local isFisrt = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.fisrt_play_game, false)
    if isFisrt then
        cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.fisrt_play_game, false)
        require("app.game.BlackDialogManager")
        Game.BlackDialogManager:getInstance():addEevntSyncIfFree(BlackDialogEventType.FIRST_PLAY_GAME, 0, 0, 0, function()
            checkStoryAndNotice()
        end)
    else
        checkStoryAndNotice()
    end

    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        UI.TipsLayer:createLoginOutGameTips()
        UI.UIManager:triggerShowDisconnectTips()
    end, 0.1)

    -- 设置帧率
    local curFps = GameManager:getFps()
    GameManager:setFps(curFps)


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
    -- UI.TipsLayer:createLoginOutGameTips()

    -- $$$$$$ 剥离声网sdk
    -- require "utils.VoiceChatManager"
    -- Avalon.VoiceChatManager:joinOrLeaveChannelWithCurrentInfo(false)

    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        AvalonUtil:testPayDelayTime()
        AvalonUtil:testCNPayDelayTime()
    end, 1)
end

function GameLayer:showTownNotice()
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():isInStory()) then
        return
    end
    local SdkBox = require("utils.sdkbox.SdkBox")
    local isDeepLink, data = SdkBox:getInstance():getDeepLinkParams()
    if isDeepLink then
        Net.NetRoleSystem:sendClaimDeepLinkAward()
        GameManager:openDeepLink(data, true)
        SdkBox:getInstance():clearDeepLinkParams()
        return true
    else
        require "app.utils.ImageDownLoadUtil"
        local tNoticeList = ImageDownLoadUtil:getTNoticeInfo()
        if #tNoticeList > 0 then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_TOEWN_NOTICE, tNoticeList) 
            return true
        end
    end
    return false
end


return GameLayer