--[[
    UI管理器
]]

-- UI相关定义
require "app.ui.UIDefine"
require "app.ui.UIDes"
require "app.ui.UIShader"
-- 资源管理
require "utils.res.ResHelper"
-- 公共组件
require "app.ui.common.Button"
require "app.ui.common.ButtonExt"
require "app.ui.common.SwitchButton"
require "app.ui.common.Layout"
require "app.ui.common.TouchLayout"
require "app.ui.common.Text"
require "app.ui.common.NumberText"
require "app.ui.common.Image"
require "app.ui.common.Image9"
require "app.ui.common.Dialog.Tips"
require "app.ui.common.ProgressTimer"
require "app.ui.common.List.ListGrid"
require "app.ui.common.List.ListView"
require "app.ui.common.Tab.TabItem"
require "app.ui.common.Tab.TabList"
require "app.ui.common.Animation"
require "app.ui.common.ClippingNode"
require "app.ui.common.ScrollView"
require "app.ui.common.Slider"
require "app.ui.common.EditBox"
require "app.ui.common.GridList.GridList"
require "app.ui.common.GoodsList.GoodsList"
require "app.ui.common.ImageButton"
require "app.ui.common.RichText"
require "app.ui.common.Dialog.TalkTips"
require "app.ui.common.GoodsCostText"
require "app.ui.common.imitateRichText"
-- tableview相关
require "app.ui.common.TableView.TableView"
require "app.ui.common.TableView.TableViewCell"
require "app.ui.common.GoodsList.GoodsListNew"
require "app.ui.common.PetList.PetList"

require "app.ui.common.Dialog.ScrollBar" 

require "app.ui.shieldingLayer.WaitingLayer"

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")

require("app.ui.shieldingLayer.ShieldingLayer")
require "app.ui.tips.TipsLayer"
require "app.game.GameErrorManager"
require "app.ui.social.chat.ChatMainLayer"
require("app.ui.notice.RunningLamp")

require "utils.WidgetUtil"
require "utils.Queue"
require "app.datas.FunctionUnlockManager"
require("app.ui.RedPointLayer")

local  openReviewTimes = 0
local SCENE_TYPE = PublicDefine.SCENE_TYPE

local TRACKS_INDEX = GameTracksIndex

-- UI管理器对象
local UIManager = {}

-- 初始化标志
local inited = false
-- 管理所有ui组件的表
local componentMap = {}
-- 调试标志
local DEBUG = false
-- 屏幕大小
local winSize = cc.Director:getInstance():getWinSize()

-- 物品掉落框的位置
local ITEM_DROP_POSX = 5 -- 相距屏幕左侧的像素
local ITEM_DROP_POSY = 100 -- 相距屏幕上侧的像素

--冒泡提示语缓存队列  和 队列锁
UI.scrollBarQueue = Avalon.Queue:create()
UI.lockScrollBarQueue = false

-- 这里定义多点触控
-- 触摸ID使用情况
MULTI_TOUCH_ID_ARR = {}
-- 摇杆使用的ID
MULTI_TOUCH_CONTROL_ID = nil


-- 组件的z序
UI_ZORDER = {
    BLIND        = 0,
    FULL_SCREEN  = 1,   
    PERFORMANCE_INFO_AREA = 2,  -- 性能表现层  
    TOUCH_LAYER  = 2,     -- 点击处理层级的
    CONTROLPAD   = 3,     --移动面板
    FUNCTION_NPC = 1000,     -- NPC 功能
    MAIN_UI      = 1001,  --主UI
    MINI_MAP     = 1002,
    MONSTER      = 1003,  -- 只有战斗才有的
    AUTO_BATTLE  = 1004,  -- 自动战斗
    SKILL        = 1004,
    HEROTEAM     = 1005,
    ACTIVITY_DSP = 1009,  -- 活动副本DSP
    QUICKCHAT     = 1010,  --快捷聊天界面
    HERO         = 10110,
    ITEMPANEL    = 1012,  --物品快捷动作条、快捷背包
    CHOICE_HERO  = 1013,  -- 显示英雄
    ITEMDROPINFO = 1014,  -- 物品掉落详情
    BAG          = 1015,
    EQUIPMENTINFO = 2000,  --  装备详情
    MAINCHAT     = 1525,  --主聊天界面
    EXPRESSION   = 1526,  --快捷表情界面
    BIG_MAP      = 2000,
    USE_SPADE_UI = 2000,
    USE_SKILL_UI = 2000,
    CAVE_SHOP    = 2000,
    BLACK_SHOP   = 2000,
    VIEW_ROLE_INFO=2000,
    ACTIVITY_NEW = 1999,
    ACTIVITY     = 2000,
    REWARD       = 8000,
    POPUP_COMP   = 9990,
    NPC_DIALOG   = 9991,
    TIPS         = 9995,
    LEVEL_SELECT_TEAM = 9996, --组队准备界面
    REVIVE       = 10000,
    TOP_ACTIVITY = 10000,
    NOTICE = 10002,--公告
    RUNNING_LAMP = 10003,--公告
    BLACK_DIALOGUE = 10005,
    SCROLLBAR    = 10100,
    TRANSITION   = 11000,  --过度场景
    RECONNECT_TIPS = 11001,
    WAITING      = 12000,
    WEBVIEW      = 13000,  --内置浏览器
    EXIT_GAME    = 14000,  -- 退出游戏
    MAX          = 20000
}

local UI_COMPONENT_VISIBLE_DURATION = 0.2

local function clearClickCounter(self)
    Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():isInLogin()) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RESET_LOGINBUTTON)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR, AvalonMessage.MC_UI_TRANSITION_FADEIN, nil, 0.2)
    else
        Game.Manager:clearScene()
        SceneManager:getInstance():startLoginScene()
    end
    
end

local function showDisconnectTips(self, connid) 
    local tipsName ="disconnecttips"
    local tipsParentLayer = cc.Director:getInstance():getRunningScene()
    local tips = tipsParentLayer:getChildByName(tipsName)
    if(tips == nil) then
        local tips = UI.Tips:createTips(UI.TEXT_111027,UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL,nil,nil,false)
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            self._showDisconnetLayer = false
            if (Avalon.Scheduler:hasScheduledUpdateOnce(self, clearClickCounter) == 0) then
                Avalon.Scheduler:setDelayForUpdateOnce(self, clearClickCounter, 0.1)
            end
        end)
        local cbutton = tips:getConfirmButton()
        if cbutton then
            cbutton:setInterval(1)
        end
        tips.touchDialogOutsizeClose = false;

        -- tips:addColorBG()
        
        tipsParentLayer:addChild(tips)
        tips:setName(tipsName)

        tips:setLocalZOrder(UI_ZORDER.RECONNECT_TIPS)
    end
end

-- 网络断开的处理器
local function onNetDisconnectHandler(self, connid)
    -- self._showDisconnetLayer = true

    -- showDisconnectTips(self, connid)
    require "app.scene.mainscene.ReConnectUtil"
    ReconnectUtil:reconect(failCallback, timeoutCallback)
end

-- 外部接口
function UIManager:init()
  if (not inited) then  
        -- print("UIManager:init")
        -- print(debug.traceback())
        -- ui根节点
        self._uilayer = cc.Layer:create()
        self._uilayer:retain()
        if(mvc and mvc.panelMonitor) then 
            mvc.panelMonitor.setMainLayer(self._uilayer)
        end
        self._tipsList = {} -- 在 _uilayer 上的tips 列表管理， 开关任意功能界面时都得清楚

        -- 记录英雄面板
        self._heroRole = nil
        self._monsterTarget = nil   -- 怪物攻击的对象spriteID
        self._isLoadBattle  = false 
        self._teammeta      = {}

        self._popupComp = nil
        self._touchLayer = nil 

        Avalon.MessageCenter:bind(GameMessage.MC_NET_DISCONNECT, self, onNetDisconnectHandler)
        Avalon.MessageCenter:bind(AvalonMessage.MC_SETTING_CONTROL_CHANGE, self, self.onControlChange)

        inited = true

        self._showDisconnetLayer = false
        self._showMainUI = true

        UI.HWBtnComponent:registerHWKeyEvents()
   end
end

-- 外部接口
function UIManager:destory()
    if (self._uilayer) then
        self._uilayer:removeFromParent()
        self._uilayer:release()
        self._uilayer = nil
    end
    self._heroRole = nil
    self._popupComp = nil
    self._touchLayer = nil 
    self._tipsList = {}

    Avalon.MessageCenter:unbind(GameMessage.MC_NET_DISCONNECT, self, onNetDisconnectHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SETTING_CONTROL_CHANGE, self, self.onControlChange)
end

-- 清理
function UIManager:clear()
    if (self._uilayer) then 
        if(mvc and mvc.panelMonitor) then 
            mvc.panelMonitor:setMainLayer(self._uilayer)
        end
        self._uilayer:removeAllChildren()
        self._uilayer:removeFromParent(false)
        self._tipsList = {}
    else 
        self._uilayer = cc.Layer:create()
        self._uilayer:retain()
        if(mvc and mvc.panelMonitor) then 
            mvc.panelMonitor:setMainLayer(self._uilayer)
        end
    end

    
    self._popupComp = nil
    self._touchLayer = nil
    UI.lockScrollBarQueue = false
    UI.scrollBarQueue:reset()
end

-- 是否是根节点
function UIManager:isRootNode(node)
    return self._uilayer == node
end

-- 获取根节点
function UIManager:getRootNode()
    -- print("UIManager:getRootNode")
    return self._uilayer
end

--[[统一管理直接加在uilayer上 的tips 界面（如装备详情界面）， 
    从而避免在业务层中， 在dtor()函数里移除节点]]
function UIManager:addToRootNode(node, zorder)
    table.insert(self._tipsList, node)
    zorder = zorder or 0
    self._uilayer:addChild(node, zorder)
end

function UIManager:clearTipsNode()
    print("---self._tipsList size = "..#self._tipsList)
    for k, v in ipairs(self._tipsList) do
        if not tolua.isnull(v) then
            v:removeFromParent(true)
        end
    end
    self._tipsList = {}
end

function UIManager:triggerShowDisconnectTips()
    -- body
    if(self._showDisconnetLayer) then 
        showDisconnectTips(self, nil)
    end
end

-- 进度加载界面
function UIManager:loadLoadingUI()
    self:clear()
    require("app.ui.UITransition")
    local pUITransition = UI.UITransition:create()
    pUITransition:center()
    self:addComponent(pUITransition, UI_ZORDER.TRANSITION)

    return self._uilayer
end

-- 登陆界面
function UIManager:loadLoginUI()
    self:clear()

    require("app.ui.UITransition")
    local pUITransition = UI.UITransition:create()
    pUITransition:center()
    self:addComponent(pUITransition, UI_ZORDER.TRANSITION)

    return self._uilayer
end

function UIManager:unloadLoginUI()
    self:clear()
end

-- 城镇
function UIManager:loadTownUI()  
    self:clear()

    require("app.ui.UITransition")
    local pUITransition = UI.UITransition:create()
    pUITransition:center()
    self:addComponent(pUITransition, UI_ZORDER.TRANSITION)

    require("app.ui.fullScreenLayer.FullScreenPanel")
    local screenPanel = UI.FullScreenPanel:create()
    screenPanel:center()
    self:addComponent(screenPanel, UI_ZORDER.FULL_SCREEN)

    require("app.ui.UIBlockingLayer")
    local uiBlocker = UI.UIBlockingLayer:create()
    uiBlocker:center()
    self:addComponent(uiBlocker, UI_ZORDER.MAX)
    
    require("app.ui.ActivityLayer")
    local pActivityLayer = UI.ActivityLayer:create()
    pActivityLayer:center()
    self:addComponent(pActivityLayer,UI_ZORDER.ACTIVITY)
    self.mActivityLayer = pActivityLayer

    require("app.ui.MainUILayer")
    local pMainUILayer = UI.MainUILayer:create(MAIN_UI_TYPE.TOWN)
    pMainUILayer:center()
    self:addComponent(pMainUILayer,UI_ZORDER.MAIN_UI)
    self.mMainUILayer = pMainUILayer
    self.mMainUILayer:setVisible(self:checkIsShowMainUI())
    
    local pTipsLayer = UI.TipsLayer:create()
    pTipsLayer:center()
    pTipsLayer:setName("tipLayer")
    self:addComponent(pTipsLayer,UI_ZORDER.TIPS)
    self.mTipsLayer = pTipsLayer

    require("app.ui.TopActivityLayer")
    local topActivityLayer = UI.TopActivityLayer:create()
    topActivityLayer:center()
    topActivityLayer:setName("topActivityLayer")
    self:addComponent(topActivityLayer, UI_ZORDER.TOP_ACTIVITY)
    self.mTopActivityLayer = topActivityLayer

    require "app.ui.blackDialogue.BlackDialogue"
    local pBlackDialogLayer = UI.BlackDialogue:create()
    pBlackDialogLayer:center()
    pBlackDialogLayer:setName("BlackDiaLogueLayer")
    self:addComponent(pBlackDialogLayer,UI_ZORDER.BLACK_DIALOGUE)
    pBlackDialogLayer:hide()
    self.mBlackDialogLayer = pBlackDialogLayer

    -- 加载点击处理层级
    self._touchLayer = self:createComponent(UIType.TOUCH_LAYER, nil, UI_ZORDER.TOUCH_LAYER)
    self:refreshControlStatus()

    require "app.ui.performance.PerformanceInfoArea"
    -- 显示游戏性能信息
    local performanceInfoArea = UI.PerformanceInfoArea:create()
    performanceInfoArea:init()
    performanceInfoArea:rightUp(90, 0)
    self._uilayer:addChild(performanceInfoArea, UI_ZORDER.PERFORMANCE_INFO_AREA)

    if CONFIG_SHOW_DEBUG_PANEL then
        self:addTest()
    end

    Game.ChatManager:getInstance():beginLampRunning()


--     CO-22121
-- 【关闭网络测试】关闭网络测试了，把功能屏蔽

    -- -- 海外包需要测试新部署服务器的网络环境
    -- if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
    -- --     mvc.networkEnvironmentTestingModel:testNetworkAction()

    --     local action = cc.Sequence:create(cc.DelayTime:create(10), cc.CallFunc:create(function() 
    --         local testIP = mvc.networkEnvironmentTestingModel:getAliyunIPURL()
    --         local testPort = 12001
    --         if testIP ~= "" and not mvc.networkEnvironmentTestingModel._isConnect then
    --             -- print("connect2connect2 ====   ",testIP, testPort)

    --             -- Net.NetInnerSystem:connect2(Net.MAIN_TEXT_SERVER, "192.168.200.140", 10002)
                
    --             Net.NetInnerSystem:connect2(Net.MAIN_TEXT_SERVER, testIP, testPort)
    --             mvc.networkEnvironmentTestingModel:testNetworkAction2()

    --             -- --http 延迟数据收集
    --             -- mvc.networkEnvironmentTestingModel:testNetworkAction()
    --         end

    --         local testIP2 = mvc.networkEnvironmentTestingModel:getawsIPURL()
    --         local testPort2 = 22001
    --         if testIP2 ~= "" and not mvc.networkEnvironmentTestingModel._isConnect then
    --             -- print("connect2connect2 ====   ",testIP2, testPort2)

    --             Net.NetInnerSystem:connect2(Net.MAIN_TEXT_SERVER2, testIP2, testPort2)
    --             mvc.networkEnvironmentTestingModel:testNetworkAction2()

    --             --http 延迟数据收集
    --             mvc.networkEnvironmentTestingModel:testNetworkAction()
    --         end

    --         mvc.networkEnvironmentTestingModel._isConnect = true
    --     end))

    --     self._uilayer:runAction(action)
        
    -- end

    -- 海外包需要测试新部署服务器的网络环境
    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        mvc.networkEnvironmentTestingModel:testNetworkAction()
    end



    return self._uilayer
end

-- 城镇
function UIManager:loadPetPVPUI()
    if UI.ChatQuickLayer and UI.ChatQuickLayer:isInit() then
        UI.ChatQuickLayer:getInstance():removeFromParent(false)
    end
    if UI.ChatMainLayer and UI.ChatMainLayer:isInit() then
        UI.ChatMainLayer:getInstance():removeFromParent(false)
    end

    self:clear()
    require "app.ui.PetPVPUILayer"
    local panel = UI.PetPVPUILayer:create()
     self:addComponent(panel, UI_ZORDER.MAIN_UI)

    require("app.ui.ActivityLayer")
    local pActivityLayer = UI.ActivityLayer:create()
    pActivityLayer:center()
    self:addComponent(pActivityLayer, UI_ZORDER.ACTIVITY)
    self.mActivityLayer = pActivityLayer

    return self._uilayer
end

function UIManager:addTest()
    if not CONFIG_SHOW_DEBUG_PANEL then
        return
    end
    require "app.ui.gmUtil.GMUtilExecutor"
    if (not UI.GMUtilExecutor:getShowTestUI()) then
        return
    end

    -- print("UIManager addTest:")
    local bagButton = UI.Button:create()
    bagButton:init()
    bagButton:centerUp(75)
    bagButton:setSize(100, 30)
    bagButton:setTextFont(UI.SYS_FONT, 25, UI.FONT_COLOR_255_255_255)
    bagButton:setFontSize(25)
    bagButton:setText("GM工具")
    bagButton:setEnableMinTouchSize(false)
    bagButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
         self:addNewTestComponent()
    end)
    self._uilayer:addChild(bagButton, 10)

    self.profileFlag = false
    local profileButton = UI.Button:create()
    profileButton:init()
    profileButton:centerUp(105)
    profileButton:setSize(130, 30)
    profileButton:setTextFont(UI.SYS_FONT, 25, UI.FONT_COLOR_255_255_255)
    profileButton:setFontSize(25)
    profileButton:setText("开始搜集")
    profileButton:setEnableMinTouchSize(false)
    profileButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if(self.profileFlag) then 
            profileButton:setText("开始搜集")
            AvalonUtil:profilerStop()
        else 
            profileButton:setText("暂停搜集")
            AvalonUtil:profilerStart()
        end
        self.profileFlag = not self.profileFlag
    end)
    self._uilayer:addChild(profileButton, 10)

    local ghostabyssButton = UI.Button:create()
    ghostabyssButton:init()
    ghostabyssButton:centerUp(115) 
    ghostabyssButton:setSize(200, 60)
    ghostabyssButton:setFontSize(25)
    ghostabyssButton:setText("幽灵深渊")
    ghostabyssButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        -- mvc.openPanel("Cave", "GhostabyssLevelSelect")
        -- mvc.openPanel("Cave", "GhostabyssShop")
        -- mvc.openPanel("ManorStarMap", "ManorStarMap")
        -- mvc.openPanel("ManorDressUpShelf", "ManorDressUpShelf")

        mvc.openPanel("ActivityModeCaveLeaderboard", "ActivityModeCaveLeaderboard")
        -- mvc.openPanel("PetGemStoneDevelopment", "PetGemStoneDevelopment")
        
    end)
    self._uilayer:addChild(ghostabyssButton, 10)


    -- local newGMButton = UI.Button:create()
    -- newGMButton:init()
    -- newGMButton:centerUp(115) 
    -- newGMButton:setSize(200, 60)
    -- newGMButton:setFontSize(25)
    -- newGMButton:setText("新GM工具")
    -- newGMButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
    --     self:addNewTestComponent()

    --     -- Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_ACTIVITY_PANEL)

    --     -- UI.WaitingLayer:showWaiting(true, nil, 3)
    -- end)
    -- self._uilayer:addChild(newGMButton, 10)

    local btnDebugLogLayer = UI.Button:create()
    btnDebugLogLayer:init()
    btnDebugLogLayer:centerUp(40)
    btnDebugLogLayer:setSize(100, 30)
    btnDebugLogLayer:setTextFont(UI.SYS_FONT, 25, UI.FONT_COLOR_255_255_255)
    btnDebugLogLayer:setFontSize(25)
    btnDebugLogLayer:setText("日志")--(string.format(UI.TEXT_1170214,100))--
    btnDebugLogLayer:setEnableMinTouchSize(false)
    btnDebugLogLayer:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)   
        --local data = {isWin = true, petStatistics = {{spriteid = 13455539, attackHp = 5153, recoverHp = 0}, {spriteid = 13521069, attackHp = 5502, recoverHp = 0}, {spriteid = 13586609, attackHp = 5306, recoverHp = 0}, {spriteid = 13652139, attackHp = 89, recoverHp = 0}, {spriteid = 13717679, attackHp = 83, recoverHp = 0}, {spriteid = 13783219, attackHp = 88, recoverHp = 0}}}
        --Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_PETPVPEND, data)
        --  require "app.ui.PetPVPUILayer"
        --  local panel = UI.PetPVPUILayer:create()
        -- self._uilayer:addChild(panel, 10000)


        -- local SceneManager = require("app.game.SceneManager")

        -- local data = {}
        -- data.transType = "Switch" 
        -- data.transReason = "BeginPetPVP"
        -- local command = Command.ControlCommand:create(true)
        -- command:initForTypeAndData(CommandType.CONTROL_BEGIN_TRANS_SCENE, data)
        -- SceneManager:getInstance():pushCommand(command)

        -- data = {}
        -- data.type = PublicDefine.SCENE_TYPE.TOWN
        -- data.caveMode = PublicDefine.CAVE_MODE.MODE_PET
        -- data.level = 8800

        -- local command = Command.ControlCommand:create(true)
        -- command:initForTypeAndData(CommandType.CONTROL_LOADSCENCE, data)
        -- SceneManager:getInstance():pushCommand(command)

        --  local command = Command.ControlCommand:create(true)
        -- command:initForTypeAndData(CommandType.CONTROL_WAITING_BEGIN_SYNC, data)
        -- SceneManager:getInstance():pushCommand(command)


        -- local list = {{level = 15, power = 23855, status = 1, nickName = "1010002", isVariant = false, curHp = 541, masterSpriteID = 0, exp = 1299, spriteID = 13894859, maxHp = 541, templateID = 1, changeNameTimes = 0, coordX = 3, coordY = 5}, 
        -- {level = 30, power = 22368, status = 1, nickName = "1010064", isVariant = true, curHp = 3406, masterSpriteID = 0, exp = 249999, spriteID = 13829319, maxHp = 3406, templateID = 20, changeNameTimes = 0, coordX = 3, coordY = 3}, 
        -- {level = 30, power = 37242, status = 1, nickName = "1010064", isVariant = true, curHp = 3178, masterSpriteID = 0, exp = 249999, spriteID = 13763789, maxHp = 3178, templateID = 20, changeNameTimes = 0, coordX = 3, coordY = 1}, 
        -- {level = 15, power = 23855, status = 1, nickName = "1010002", isVariant = false, curHp = 541, masterSpriteID = 0, exp = 1299, spriteID = 13698249, maxHp = 541, templateID = 1, changeNameTimes = 0, coordX = 7, coordY = 5}, 
        -- {level = 30, power = 22368, status = 1, nickName = "1010064", isVariant = true, curHp = 3406, masterSpriteID = 0, exp = 249999, spriteID = 13632709, maxHp = 3406, templateID = 20, changeNameTimes = 0, coordX = 7, coordY = 3}, 
        -- {level = 30, power = 37242, status = 1, nickName = "1010064", isVariant = true, curHp = 3178, masterSpriteID = 0, exp = 249999, spriteID = 13567179, maxHp = 3178, templateID = 20, changeNameTimes = 0, coordX = 7, coordY = 1}}
        -- for k, v in ipairs(list) do
        --     local petData = RoleDataManager:handleScreenPetData(v)
        --     if petData then
        --         petData:setIsEnemy(k > 3)
        --     end
        --     local SceneManager = require("app.game.SceneManager")
        --     local command = Command.ControlCommand:create(true)
        --     command:initForTypeAndData(CommandType.CONTROL_SCREENPET, v)
        --     SceneManager:getInstance():pushCommand(command)
        -- end



        -- local petData = RoleDataManager:getScreenFightPetData()
        -- petData.masterSpriteID = nil
        -- petData.level = petData:getLevel()
        -- local SceneManager = require("app.game.SceneManager")
        -- local command = Command.ControlCommand:create(true)
        -- command:initForTypeAndData(CommandType.CONTROL_SCREENPET, petData)
        -- SceneManager:getInstance():pushCommand(command)

   --    local itemId, cost = RoleDataManager:getMaster():getRevivePetCost()
 		 require("app.ui.debugLogLayer.debugLogLayer")
         local pDebugLogLayer = UI.DebugLogLayer:create(100000)
        pDebugLogLayer:center()
        cc.Director:getInstance():getRunningScene():addChild(pDebugLogLayer,100000)


        -- mvc.openPanel("ActivityLottery", "ActivityLottery")

        -- local GameDataManager = require("app.game.GameDataManager")
        -- local sender = {
        --     pk = RoleDataManager:getMaster():getPK(),
        --     userID = RoleDataManager:getMaster():getUserID(),
        --     nickName = RoleDataManager:getMaster():getNickName(),
        --     faceDecodeID = RoleDataManager:getMaster():getFaceDecodeID(),
        --     wearEquipId = GameDataManager:getInstance():getWearTempId(),
        --     sex = RoleDataManager:getMaster():getSex(),
        --     roleLV = RoleDataManager:getMaster():getLevel(),
        -- }


        -- local receiver = {
        --     pk = RoleDataManager:getMaster():getPK(),
        --     userID = RoleDataManager:getMaster():getUserID(),
        --     nickName = RoleDataManager:getMaster():getNickName(),
        --     faceDecodeID = RoleDataManager:getMaster():getFaceDecodeID(),
        --     wearEquipId = GameDataManager:getInstance():getWearTempId(),
        --     sex = RoleDataManager:getMaster():getSex(),
        --     roleLV = RoleDataManager:getMaster():getLevel(),
        -- }
         
    



        -- Game.ChatManager:getInstance():sendGuildInvite({pk = 17828359, roleLV = 41, userID = 4254649, nickName = "\231\138\128\229\136\169\229\164\167\230\145\169\230\160\185", sex = 2, faceDecodeID = 1030402}, 
            -- {pk = 17827076, wearEquipId = {21012044}, roleLV = 35, userID = 4254648, nickName = "\228\188\144\230\156\168\229\183\165\229\175\140\232\130\150\230\129\169", sex = 1, faceDecodeID = 2020401}, {guildID = 5, tk = 624733056, name = "12312"})


        -- Game.ChatManager:getInstance():sendGuildRecruit(sender)
        -- Game.ChatManager:getInstance():getGuildRecruitMessage()
        -- require("app.ui.debugLogLayer.debugLogLayer")
        -- local pDebugLogLayer = UI.DebugLogLayer:create(100000)
        -- pDebugLogLayer:center()
        -- cc.Director:getInstance():getRunningScene():addChild(pDebugLogLayer,100000)
        -- mvc.send("Open_Panel","Expedition", nil, 1)
        -- mvc.openPanel("Guild", "GuildSelectFloor")

        -- local MachineManager = require("app.game.MachineManager")
        -- local machine = MachineManager:getInstance():getMachine()
        -- if(machine) then 
        --     local entterNpc = machine._model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
        --     if(entterNpc[1] and entterNpc[1]:getNpcData()) then 
        --         local triggerData = entterNpc[1]:getNpcData()
        --         if(triggerData) then 
        --             local coord = triggerData:getCoord()
        --             print("coord.x, coord.y=", coord.x, coord.y)
        --             machine:_onTouchMapTileEnded(coord.x, coord.y)
        --         end
        --     end
        -- end

        -- local templateIDArr = {10208382,10208383,10208384,10208385,10208386,10208387,10208388,10208389,10208390}

        -- local data = {guildBossFightNum = 14, data = {buffActTime = 0, logRefreshDay = 7117, log = {{bossID = 10208313, pk = 17828655, extend = 1095, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208313, pk = 17828655, extend = 1, opt = "GuildBossFightLogOpt_Box"}, {bossID = 10208313, pk = 17828655, extend = 2220, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208313, pk = 17828655, extend = 2, opt = "GuildBossFightLogOpt_Box"}, {bossID = 10208313, pk = 17828655, extend = 6683, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208313, pk = 17828655, extend = 1, opt = "GuildBossFightLogOpt_Box"}, {bossID = 10208312, pk = 17828655, extend = 10000, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208312, pk = 17828655, extend = 4, opt = "GuildBossFightLogOpt_Box"}, {bossID = 10208310, pk = 17828655, extend = 10000, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208310, pk = 17828655, extend = 4, opt = "GuildBossFightLogOpt_Box"}, {bossID = 10208314, pk = 17828655, extend = 10000, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208314, pk = 17828655, extend = 4, opt = "GuildBossFightLogOpt_Box"}, {bossID = 10208311, pk = 17828655, extend = 10000, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208311, pk = 17828655, extend = 4, opt = "GuildBossFightLogOpt_Box"}, {bossID = 10208328, pk = 17828655, extend = 4275, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208328, pk = 17828655, extend = 6, opt = "GuildBossFightLogOpt_Box"}, {bossID = 10208328, pk = 17828655, extend = 5724, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208322, pk = 17828655, extend = 5735, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208322, pk = 17828655, extend = 6, opt = "GuildBossFightLogOpt_Box"}, {bossID = 10208322, pk = 17828655, extend = 1356, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208322, pk = 17828655, extend = 2908, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208336, pk = 17828655, extend = 2527, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208336, pk = 17828655, extend = 5, opt = "GuildBossFightLogOpt_Box"}, {bossID = 10208335, pk = 17828655, extend = 3224, opt = "GuildBossFightLogOpt_Fight"}, {bossID = 10208335, pk = 17828655, extend = 6, opt = "GuildBossFightLogOpt_Box"}}, boss = {{bossID = 10208336, buffIDs = {31010180}, isKilled = false, lossHp = 11614485, phaseAward = 5, isFighting = false}, {bossID = 10208322, isKilled = true, lossHp = 45952200, phaseAward = 6, isFighting = false}, {bossID = 10208328, buffIDs = {31010120}, isKilled = true, lossHp = 45952200, phaseAward = 6, isFighting = false}, {bossID = 10208329, isKilled = false, lossHp = 0, phaseAward = 0, isFighting = false}, {bossID = 10208335, buffIDs = {31010150}, isKilled = false, lossHp = 14815595, phaseAward = 6, isFighting = false}}, hardLv = 2, cycle = 1017, seed = 1091}, err = "GuildBossErr_OK"}
        -- data.data.boss[1].bossID = templateIDArr[math.random(1,#templateIDArr)]
        -- if(math.random(1,100) < 50) then
        --     data.data.boss[1].isKilled = true
        -- else 
        --     data.data.boss[1].isKilled = false
        -- end
        -- print("data.data.boss[1].isKilled", data.data.boss[1].bossID, data.data.boss[1].isKilled)
        
        -- mvc.guildModel:initGuildBossData(data)
        -- local SceneManager = require("app.game.SceneManager")
        -- -- 处理NPC的刷新处理
        -- local command = Command.ControlCommand:create(true)
        -- command:initForTypeAndData(CommandType.CONTROL_REFRESH_ALL_GUILD_BOSS, data)
		-- SceneManager:getInstance():pushCommand(command)
        
        -- -- 通知数据信息修改
        -- mvc.send(mvc.events.Guild_SelectFloor_Get_Data_Result, data)
        -- mvc.openPanel("Recast", "RecastRemoveLevel", 0)
        -- mvc.openPanel("Festival", "FestivalReward", nil)
        -- mvc.openPanel("Festival", "FestivalMazeTeam", nil)

        -- Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, 22)
    end)
    self._uilayer:addChild(btnDebugLogLayer,10);

    -- 添加服务器版本信息
    local gameLoginManager = require("app.game.GameLoginManager")
    local monstername = UI.Text:create()
    monstername:init(
        string.format("codeV:%s,resV:%s,SERVER:%s,PORT:%d", 
            GameDataManager:getInstance():getServerCodeVersion(), 
            GameDataManager:getInstance():getServerResVersion(),
            gameLoginManager:getInstance():getServerUrl(),
            gameLoginManager:getInstance():getServerPort()), 
        UI.FONT_ARIAL, 
        UI.FONT_SIZE_14PX)
    -- monstername:init(string.format("codeV:%s,resV:%s,PORT:%d", GameDataManager:getInstance():getServerCodeVersion(), GameDataManager:getInstance():getServerResVersion(),AVALON_LOGIN_PORT), UI.FONT_ARIAL, UI.FONT_SIZE_14PX)
    monstername:centerUp(5)
    self._uilayer:addChild(monstername, 100)

    -- 添加客户端版本号显示
    local LanguageManager = require("app.game.LanguageManager")
    local versionText = UI.Text:create()
    versionText:init(LanguageManager:getInstance():getLocalString(1111202) .. ": " .. Avalon.HotfixManager:getLocalVersion().."."..Avalon.HotfixManager:getLocalBuild().."  ".."Online: "..ToolsUtil:getTime(GameDataManager:getInstance():getOnlineTime()/1000), UI.FONT_ARIAL, UI.FONT_SIZE_14PX)
    versionText:centerUp(10 + monstername:getContentSize().height)
    self._uilayer:addChild(versionText, 100)


    -- local txt = cc.Label:create("pk:"..RoleDataManager:getMasterPK(),UI.FONT_ARIAL, UI.FONT_SIZE_14PX)
    -- txt:setPosition(200, 200)
    -- self._uilayer:addChild(txt)
end

-- 添加了测试城镇怪物的接口
function UIManager:addTestTownMonster()
    local addNum = 100
    if(TotalAddMonsterNum == nil) then 
        TotalAddMonsterNum = 0
    end

    local templateData = {
        spriteID = 1,
        monsterID = 2,
        status = PublicDefine.SPRITE_STATUS.IDLE,
        coordX = 4,
        coordY = 5,
        rare = 6,
        curHp = 7,
        hp = 8,
        targetSpriteID = 110,
        skillID = 111;
        skillState = 1,
        buff = {},
        affix = {},
        isDead = false,
        isTrigger = true,
        isTransform = false,
        functionFlag = 0
    }
    local configAll = ConfigManager:getMonsterListConfig(1, 1)
    local monsterIDArr = {}
    for k,v in pairs(configAll) do 
        if(type(v) == "table") then
            table.insert(monsterIDArr, v)
        else 
            print("k,v =", k, v)
        end
    end

    local masterCoord = RoleDataManager:getMaster():getCoord()
    local startSpriteID = 10000000
    local maxX = 27
    local maxY = 40
    local startX = 17
    local startY = 30
    local maxLong = 10
    local nowX = 17
    local nowY = 30
    for i=1, addNum,1 do 
        TotalAddMonsterNum = TotalAddMonsterNum + 1
        local nowTemplateData = clone(templateData)

        nowTemplateData.spriteID = startSpriteID + TotalAddMonsterNum
        -- templateData.coordX = masterCoord.x + math.floor(math.random()*4)
        -- templateData.coordY = masterCoord.y + math.floor(math.random()*4)
        nowTemplateData.coordX = nowX
        nowTemplateData.coordY = nowY
        local nowIndex = TotalAddMonsterNum % #monsterIDArr + 1
        
        nowTemplateData.monsterID = monsterIDArr[nowIndex].id
        print("wwwwwwwww=", nowIndex, nowTemplateData.monsterID, nowTemplateData.coordX, nowTemplateData.coordY)

        local SceneManager = require("app.game.SceneManager")
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SCREENMONSTER, nowTemplateData)
        SceneManager:getInstance():pushCommand(command)

        nowY = nowY + 1
        if(nowY > maxY) then 
            nowY = startY
            nowX = nowX + 1
        end
    end
    UI.ScrollBar:createByText(string.format("本次添加了%d个怪物，一共添加了%d个怪物", addNum, TotalAddMonsterNum))
end

function UIManager:dumpRepeatLanguage()
    local profileLanguages = require "ProfileLanguage"
    local repeatList = {}
    for k , v in pairs(profileLanguages) do
        if type(v) == "table" then
            print("--------------k ---------- = "..k)
            for k2 , v2 in pairs(profileLanguages) do
                if type(v2) == "table" then
                    if (v.language == v2.language) and (v.id ~= v2.id) then
                        if repeatList[v.language] == nil then
                            repeatList[v.language] = {}
                            table.insert(repeatList[v.language], v.id)
                        end
                        local isHave = false
                        for k3, v3 in ipairs(repeatList[v.language]) do
                            if v3 == v2.id then
                                isHave = true
                                break;
                            end
                        end
                        if not isHave then
                            table.insert(repeatList[v.language], v2.id)
                        end
                    end
                end
            end
        end
    end
    dump(repeatList, "---------repeatList---------")
end

function UIManager:addTestComponent()
    require "app.ui.test.TestUtilLayer"
    local comp = UI.TestUtilLayer:create()
    comp:init()
    comp:center()

    self:addComponent(comp, 10000)
end

function UIManager:addNewTestComponent()
    require "app.ui.gmUtil.GMUtilLayer"
    UI.GMUtilLayer:instanceShow(self, UI_ZORDER.ACTIVITY)
end
function UIManager:getTopActivityLayer()
    return self.mTopActivityLayer
end
-- 加载战斗界面
function UIManager:loadBattleUI()
    
    -- print("UIManager loadBattleUI:")

    self:clear()

    -- by CMonk, 机器人运行优化, 可以直接删除
    if (Auto and Auto.Robot and Auto.Robot:isOp()) then return self._uilayer end
    -- eo CMonk
    
    self:addBattleMessage()

    require("app.ui.UITransition")
    local pUITransition = UI.UITransition:create()
    pUITransition:center()
    self:addComponent(pUITransition, UI_ZORDER.TRANSITION)

    -- 添加全屏层级
    require("app.ui.fullScreenLayer.FullScreenPanel")
    local screenPanel = UI.FullScreenPanel:create()
    screenPanel:center()
    self:addComponent(screenPanel, UI_ZORDER.FULL_SCREEN)

    -- 添加顶层全屏动画
    require("app.ui.fullScreenLayer.TopFullScreenPanel")
    local screenPanel = UI.TopFullScreenPanel:create()
    screenPanel:center()
    self:addComponent(screenPanel, UI_ZORDER.MAX)

    require("app.ui.UIBlockingLayer")
    local uiBlocker = UI.UIBlockingLayer:create()
    uiBlocker:center()
    self:addComponent(uiBlocker, UI_ZORDER.MAX)

    -- 加载点击处理层级
    self._touchLayer = self:createComponent(UIType.TOUCH_LAYER, nil, UI_ZORDER.TOUCH_LAYER)
    self:refreshControlStatus()

    require("app.ui.ActivityLayer")
    local pActivityLayer = UI.ActivityLayer:create()
    pActivityLayer:center()
    self:addComponent(pActivityLayer,UI_ZORDER.ACTIVITY)
    self.mActivityLayer = pActivityLayer

    require("app.ui.MainUILayer")
    local pMainUILayer = UI.MainUILayer:create(MAIN_UI_TYPE.CAVE)
    pMainUILayer:center()
    self:addComponent(pMainUILayer,UI_ZORDER.MAIN_UI)
    self.mMainUILayer = pMainUILayer
    self.mMainUILayer:setVisible(self:checkIsShowMainUI())

    require "app.ui.tips.TipsLayer"
    local pTipsLayer = UI.TipsLayer:create()
    pTipsLayer:center()
    pTipsLayer:setName("tipLayer")
    self:addComponent(pTipsLayer,UI_ZORDER.TIPS)
    self.mTipsLayer = pTipsLayer

    require "app.ui.blackDialogue.BlackDialogue"
    local pBlackDialogLayer = UI.BlackDialogue:create()
    pBlackDialogLayer:center()
    pBlackDialogLayer:setName("BlackDiaLogueLayer")
    self:addComponent(pBlackDialogLayer,UI_ZORDER.BLACK_DIALOGUE)
    pBlackDialogLayer:hide()
    self.mBlackDialogLayer = pBlackDialogLayer

    require("app.ui.TopActivityLayer")
    local topActivityLayer = UI.TopActivityLayer:create()
    topActivityLayer:center()
    topActivityLayer:setName("topActivityLayer")
    self:addComponent(topActivityLayer, UI_ZORDER.TOP_ACTIVITY)
    self.mTopActivityLayer = topActivityLayer

    require "app.ui.performance.PerformanceInfoArea"
    -- 显示游戏性能信息
    local performanceInfoArea = UI.PerformanceInfoArea:create()
    performanceInfoArea:init()
    performanceInfoArea:rightUp(90, 0)
    self._uilayer:addChild(performanceInfoArea, UI_ZORDER.PERFORMANCE_INFO_AREA)

    if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then

    end

    -- 添加致盲效果层级
    require "app.ui.blindLayer.BlindPanel"
    local blind = UI.BlindLayer:create()
    blind:init()
    blind:center()
    self:addComponent(blind, UI_ZORDER.BLIND)

    --  判断是否为小黑屋
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():getSceneType() == SCENE_TYPE.BLACK_HOUSE) then
        if(GameDataManager:getInstance():getMasterIsDead() == false) then
            UI.TipsLayer:onVoteSucceedTipsUI()
        end
    end

    if CONFIG_SHOW_DEBUG_PANEL then
        self:addTest()
    end

    -- 测试存档点
    -- self:onShowAchieveHandler()
    Game.ChatManager:getInstance():beginLampRunning()
    self._isLoadBattle = true 
    return self._uilayer
end




-- 清除战斗UI
function UIManager:unloadBattleUI()
    if UI.ChatQuickLayer and UI.ChatQuickLayer:isInit() then
        UI.ChatQuickLayer:getInstance():removeFromParent(false)
    end
    if UI.ChatMainLayer and UI.ChatMainLayer:isInit() then
        UI.ChatMainLayer:getInstance():removeFromParent(false)
    end

    self:removeBattleMessage()
    -- if (self._uilayer) then 
    --     self._uilayer:removeAllChildren() 
    --     self._uilayer:removeFromParent(false)
    --     self._tipsList = {}
    -- end

    componentMap = {}
    self._isLoadBattle = false


    self:clear()
end

-- 清除城镇UI
function UIManager:unloadTownUI()
    if UI.ChatQuickLayer and UI.ChatQuickLayer:isInit() then
        UI.ChatQuickLayer:getInstance():removeFromParent(false)
    end
    if UI.ChatMainLayer and UI.ChatMainLayer:isInit() then
        UI.ChatMainLayer:getInstance():removeFromParent(false)
    end
    -- -- TODO 卸载城镇UI
    -- if (self._uilayer) then 
    --     self._uilayer:removeAllChildren() 
    --     self._uilayer:removeFromParent(false)
    --     self._tipsList = {}
    -- end

    self:clear()
end


function UIManager:addBattleMessage()

    print("UIManager:message")


end


-- 移除战斗的消息的监听
function UIManager:removeBattleMessage()

end


-- 使用道具
function UIManager:useGoods(goodsData, isQuickBar)
    local role = GameManager:getMasterRole()
    if role == nil then
        return
    end
    local state = role:getState()
    local category = goodsData:getCategory()
    -- 使用技能
    if (category == Category.SKILL) then
        local isAvallable = not GameDataManager:getInstance():checkInDisableSituation(goodsData:getDisableSituation())
        print("---------isAvallable",role:getState(),not role:getIsDead(),isAvallable,category,goodsData:getId())
        if (state ~= FSMState.BATTLE and
            (not role:getIsDead()) and 
            isAvallable) then
            print(string.format("UIManager useGoods: use skill %d.", goodsData:getId()))
            -- self:createComponent(UIType.USE_SKILL_UI, goodsData, UI_ZORDER.USE_SKILL_UI)

            local skillID = goodsData:getId()
            -- 位移技能
            if (skillID == TRANSFER_SKILL_ID) then
                require "app.ui.itemuselayer.UseSkillUI"
                local comp = UI.UseSkillUI:create()
                comp:init(goodsData)
                self:showPopupComponent(comp)
            -- 回血技能
            elseif (skillID == 30000201) then
                local spriteID = role:getSpriteID()
                GameManager:useAssistSkillToRole(goodsData, spriteID)
            else
                -- 这里处理不需要选着目标等直接使用的技能
                GameManager:useAssistSkillForNormal(goodsData, role:getSpriteID())
                -- assert(false, string.format("UIManager useGoods: should deal with skill %d.", skillID))
            end
        end
    -- 使用道具
    elseif (category == Category.GOODS) then
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        if(machine == nil) then
            return
        end
        local role = GameManager:getMasterRole()
        if(role) then
            if(role:getIsDead() == true) then
                return
            end

            local reviveAction = machine._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, role:getId())
            if (reviveAction and (reviveAction:getFSMState() == FSMState.REVIVE or reviveAction:getFSMState() == FSMState.WAITING)) then
                return 
            end
        else 
            return 
        end

        local goodsType = goodsData:getGoodsType()
        -- 道具类型
        if (goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM) then
            -- local currentScene = 0

            -- local SceneManager = require("app.game.SceneManager")
            -- if (SceneManager:getInstance():isInCave()) then currentScene = Game.GoodsUseScene.IN_CAVE
            -- elseif (SceneManager:getInstance():isInTown()) then currentScene = Game.GoodsUseScene.IN_TOWN
            -- elseif (SceneManager:getInstance():isInDungeon()) then currentScene = Game.GoodsUseScene.IN_DUNGEON
            -- elseif (SceneManager:getInstance():isGuild()) then currentScene = Game.GoodsUseScene.IN_TOWN
            -- elseif (SceneManager:getInstance():isInStory()) then currentScene = Game.GoodsUseScene.IN_STORY
            -- else assert(false)
            -- end

            local count = goodsData:getNum()
            local isAvailable = false

            -- 先判断数量
            if (count > 0) then isAvailable = true end
            -- 再判断是否满足使用条件
            if (isAvailable) then
                isAvallable = not GameDataManager:getInstance():checkInDisableSituation(goodsData:getDisableSituation())
            end
            if (isAvailable) then
                print(string.format("UIManager useGoods: to use goods %d.", goodsData:getGoodsID()))

                local itemType = goodsData:getItemType()
                -- 铁锹    Mushroom = 4;         -- 蘑菇
                if (itemType == PublicDefine.ITEM_TYPE.IronPickaxe
                    or itemType == PublicDefine.ITEM_TYPE.ItemFunTrap
                    or itemType == PublicDefine.ITEM_TYPE.ItemFunMark) then 
                    -- self:createComponent(UIType.USE_SPADE_UI, goodsData, UI_ZORDER.USE_SPADE_UI)
                    require "app.ui.itemuselayer.UseSpadeUI"
                    local comp = UI.UseSpadeUI:create()
                    comp:init(goodsData, isQuickBar)
                    self:showPopupComponent(comp)
                elseif (itemType == PublicDefine.ITEM_TYPE.OpenMapShadowScroll) then 
                    GameManager:useItem(goodsData)
                elseif (itemType == PublicDefine.ITEM_TYPE.RunScroll) then 
                    GameManager:useItem(goodsData)
                elseif (itemType == PublicDefine.ITEM_TYPE.TransferScroll) then 
                    GameManager:useItem(goodsData)
                elseif (itemType == PublicDefine.ITEM_TYPE.EscapeScroll) then 
                    GameManager:stopMoveHandler()
            
                    local tips = UI.Tips:createTips(UI.TEXT_DES_BACK_TOWN,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL,UI.TipsButtonType.NO_TEXT_BUTTON)

                    --  确定回城
                    local function onConfirmButtonHandler(self)
                        if(isQuickBar == true) then
                            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_USED_TOTOWN_CONFIRM)
                            GameManager:useTownScroll()
                            
                        else
                            GameManager:useTownScroll(goodsData)
                        end
                        tips:close()
                    end

                    -- 点击取消
                    local function onCancelButtonHandler(self)
                        tips:close()
                        Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)  -- 打开控制面板
                    end
                    -- 打击到tips外面
                    local function onTouchDialogOutsizeHandler(self)
                        Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)  --打开遥杆 
                    end        

                    -- 确定和取消事件监听
                    tips:addEventListener(UIEvent.DIALOG_CONFIRM, self,onConfirmButtonHandler)
                    tips:addEventListener(UIEvent.DIALOG_CANCEL, self,onCancelButtonHandler)
                    tips:addEventListener(UIEvent.DIALOG_OUT_SIDE, self, onTouchDialogOutsizeHandler)

                    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)  -- 关闭控制面板

                -- 法术卷轴，不用判断是否血条以及魔法值满
                elseif (itemType == PublicDefine.ITEM_TYPE.MagicScroll) then 
                    GameManager:useItem(goodsData, isQuickBar)

                -- 恢复药剂
                elseif (itemType == PublicDefine.ITEM_TYPE.RestorePotion) then 
                    local heroData = RoleDataManager:getMaster()
                    if(heroData:getCurMp() < heroData.mp or heroData:getCurHp() < heroData.hp) then 
                        GameManager:useItem(goodsData, isQuickBar)
                    end 
                -- X选Y礼包
                elseif (itemType == PublicDefine.ITEM_TYPE.ChooseBag) then
                    
                    -- require "app.ui.tips.GoodsSelectTips"
                    -- local tips = UI.GoodsSelectTips:create()
                    -- tips:init(goodsData)
                    -- tips:center()
                    -- UI.UIManager:getRootNode():addChild(tips,UI_ZORDER.TIPS)
                -- -- 
                -- elseif (itemType == PublicDefine.ITEM_TYPE.Mushroom) then 
                elseif (itemType == PublicDefine.ITEM_TYPE.AddExp) then
                    local heroData = RoleDataManager:getMaster()
                    if (heroData:getIsMaxLevel()) then
                        UI.ScrollBar:createByText(UI.TEXT_221203)
                    else
                        if (goodsData:getIsLock()) then
                            UI.ScrollBar:createByText(UI.TEXT_1212614)
                        else
                            GameManager:useItem(goodsData, isQuickBar) 
                        end
                    end
                elseif (itemType == PublicDefine.ITEM_TYPE.StarCard or itemType == PublicDefine.ITEM_TYPE.TransCard) then
                    if (goodsData:getIsLock()) then
                        UI.ScrollBar:createByText(UI.TEXT_1212614)
                    else
                        GameManager:useItem(goodsData, isQuickBar) 
                    end

                -- 直接使用
                else
                    GameManager:useItem(goodsData, isQuickBar) 
                end
            else
                print(string.format("UIManager useGoods: fail to use goods %d.", goodsData:getGoodsID()))
            end
        else
            assert(false)
        end
    else
        assert(false)
    end
end



-- 添加组件
function UIManager:createComponent(comType, data, zorder)  

    local comp = nil

    -- 点击处理层级
    if (comType == UIType.TOUCH_LAYER) then
        require "app.ui.touchlayer.TouchLayer"
        comp = UI.TouchLayer:create()
        comp:init()
    -- 使用铁锹的ui
    elseif comType == UIType.USE_SPADE_UI then
        -- print("@@@@@@@@@")
        -- dump(data)
        require "app.ui.itemuselayer.UseSpadeUI"
        comp = UI.UseSpadeUI:create()
        comp:init(data)
    -- 使用辅助技能的ui 
    elseif comType == UIType.USE_SKILL_UI then
        require "app.ui.itemuselayer.UseSkillUI"
        comp = UI.UseSkillUI:create()
        comp:init(data)

    else
       assert(false, "[ERROR] component type is invalid.")
    end

    self:addComponent(comp, zorder)
    return comp
end

-- 根据组建的实例id获取组建对象
-- @compID 获取对象的组件id
function UIManager:getCompById(compID)
    return componentMap[compID]
end

-- 添加组件对象到视图中
-- @comp 被添加的组件对象
-- @zOrder 组建现实的z序
function UIManager:addComponent(comp, zOrder)
    if (comp and comp:getParent() == nil) then
        local id = comp:getId()
        if (not componentMap[id]) then
            componentMap[id] = comp

            if not zOrder then
                zOrder = 10
            end
            self._uilayer:addChild(comp, zOrder)
        else
            assert(false)
        end
    else
        assert(false)
    end
end

-- 从视图中移除组建，并清理相关的管理数据
-- @comp 被移除的组件对象
function UIManager:removeComponent(comp)
    if (not tolua.isnull(comp)) then
        if (comp.getId) then
            componentMap[comp:getId()] = nil
        end

        if (self._popupComp == comp) then self._popupComp = nil end

        -- 在下一帧移除，防止移除之后继续对组建对象进行访问的情况
        comp:runAction(cc.RemoveSelf:create())
    else
        printError("[ERROR] UIManager removeComponent: comp is invalid.")
    end
end

-- 根据组建的实例id移除组建对象
-- @compId 被移除的组件对象的id
function UIManager:removeComponentById(compId)
    local comp = componentMap[compId]
    if (comp) then
       self:removeComponent(comp)
    else
        printError("[ERROR] UIManager removeComponentById: comp id is invalid.")
    end
end



-- 显示功能按钮
function UIManager:showFunctionButton(spriteID, functionDataArr, x, y, informationLocation)
    -- 这里移动层级，用于处理切换相关表现
    if(self.mMainUILayer) then
        self.mMainUILayer:showFunctionButton(spriteID, functionDataArr, x, y, informationLocation)
    end

    -- -- 处理显示功能按钮
    -- require "app.ui.functionLayer.FunctionPanel"
    -- local functionPanel = UI.FunctionPanel:create()
    -- functionPanel:init(spriteID, functionDataArr, x, y, informationLocation, function()
    --     Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD_TRACKING, functionPanel)
    -- end)
    -- functionPanel:center()
    -- self._uilayer:addChild(functionPanel,UI_ZORDER.FUNCTION_NPC);
    
    -- Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD_TRACKING, functionPanel)
end

-- 显示弹出组件
-- @comp 被添加到视图中的弹出组件
function UIManager:showPopupComponent(comp)
    if (comp) then
        if (self._popupComp) then
            self._popupComp:close()
            self._popupComp = nil
        end
        self._popupComp = comp

        self:addComponent(comp, UI_ZORDER.POPUP_COMP)
    else
        assert(false)
    end
end


function UIManager:getCurrentChatLayer()
    if UI.ChatMainLayer:getInstance():isHidingByPosition() then
        require "app.ui.social.chat.ChatQuickLayer"
        return  UI.ChatQuickLayer:getInstance()
    end
    return UI.ChatMainLayer:getInstance()
end

function UIManager:onControlChange()
    self:refreshControlStatus()
end

function UIManager:refreshControlStatus()
    -- body
    if(not tolua.isnull(self._touchLayer)) then
        if GameDataManager:getInstance():canUseControl() then 
            self._touchLayer:disable()
        else 
            self._touchLayer:enable()
        end
    end
end

function UIManager:checkIsShowMainUI(addRestoreButton)
    if (not self._showMainUI) then
        if (addRestoreButton or addRestoreButton == nil) then 
            self:addUIRestoreButton() 
        end
    else
        self:removeUIRestoreButton()
    end
    return self._showMainUI
end

-- 隐藏界面UI
function UIManager:setShowMainUI(isShow)
    self._showMainUI = isShow
    if (self.mMainUILayer and not tolua.isnull(self.mMainUILayer)) then
        if (isShow) then
            self.mMainUILayer:show()
        else
            self.mMainUILayer:hide()
        end
    end
    return self:checkIsShowMainUI()
end

-- 移除UI恢复按钮
function UIManager:removeUIRestoreButton()
    local buttonName = "99998"
    local button = self._uilayer:getChildByName(buttonName)
    if (button) then button:removeFromParent() end 
end
-- UI回复按钮, 结合上面两个使用
function UIManager:addUIRestoreButton()
    local buttonName = "99998"
    local button = self._uilayer:getChildByName(buttonName)
    if (not button) then
        Avalon.ResHelper:loadPlistSync("ui_common_btn.plist")

        local buttonWidth = 100
        local buttonHeight = 120
        button = UI.Component:create()
        button:init()
        button:leftUp(0, 0)
        button:setSize(buttonWidth, buttonHeight)
        button:setTouchEnable(true)
        button:setName(buttonName)
        button:addEventListener(UI.Event.COMPONENT_CLICK, self, function()
            self:setShowMainUI(true)
            if (self._uiRestoreCallback) then self._uiRestoreCallback(self._savedControlType) end
            if (button and not tolua.isnull(button)) then
                button:runAction(cc.RemoveSelf:create())
            end
            if (self._savedControlType) then
                GameManager:setMoveType(self._savedControlType)
                Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)
            end
            button = nil
        end)
        button:runAction(cc.Sequence:create(
            cc.FadeOut:create(0.5),
            cc.CallFunc:create(function() button:setOpacity(255) end),
            cc.FadeOut:create(2.5)
        ))
        self._uilayer:addChild(button, 100000)

        local icon = UI.Image:create()
        icon:init("ui_btn_gem_transformation.png")
        icon:centerUp(0)
        button:addChild(icon)

        local text = UI.Text:create()
        text:init(LanguageManager:getInstance():getLocalString(1112997)--[["点这里重新显示UI"]], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
        text:setSize(buttonWidth, buttonHeight)
        text:setTextAlignment(UI.TextHAlignment.CENTER, UI.TextVAlignment.TOP)
        text:centerUp(icon._height)
        button:addChild(text)
    end
end

function UIManager:setUIRestoreButtonCallback(cb)
    self._uiRestoreCallback = cb
end

function UIManager:setHideScreenSaveControlType(controlType)
    self._savedControlType = controlType
end

UI = UI or {}
UI.UIManager = UIManager
