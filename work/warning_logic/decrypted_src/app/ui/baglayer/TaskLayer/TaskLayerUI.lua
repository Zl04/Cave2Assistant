--[[
    任务界面
]]

require "app.ui.Component"
require "app.ui.common.Tab.TabList"
require "app.ui.common.Animation"
require "app.ui.common.ScrollView"
require "app.ui.baglayer.Role.RolePanelNew"
require "app.ui.baglayer.Log.LogPanel"
-- require "app.ui.baglayer.Setting.SettingPanel"
require("app.ui.baglayer.SkillLayer.NewSkillLayer")
require "app.ui.baglayer.TaskLayer.TaskLayer"
require "app.ui.baglayer.TaskLayer.TreasureMapLayer.TreasureMapLayer"
require "app.ui.baglayer.TaskLayer.AchievementLayer.AchievementLayer"
local GameDataManager = require("app.game.GameDataManager")
require "app.config.ConfigManager"

UI = UI or {}

local TaskLayerUI = class("TaskLayerUI", UI.HWBtnComponent)
UI.TaskLayerUI = TaskLayerUI

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local Scheduler = Avalon.Scheduler
local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local DEBUG_DRAW = false
-- 尺寸
local COM_WIDTH = 978
local COM_HEIGHT = 555

-- 背包资源
local COM_RES_LIST_BAG = {
}

local COM_RES_LIST_TOWN = {
}

local GameDataManager = require("app.game.GameDataManager")

local BUTTON_NORMAL = "ui_btn_gray2_0.png"
local BUTTON_ACTIVE = "ui_btn_gray2_1.png"
local BUTTON_DISABLE = "ui_btn_gray2_2.png"
---------------------

UI.TaskLayerUIType = {
    TASKLAYER_BAG = 1,  --  背包任务界面
    TASKLAYER_TOWN = 2, --  城镇任务界面
    TASKLAYER_PORT = 3, --  港口任务界面
}
local tasklayerUIType = UI.TaskLayerType

local function onTouchDialogOutsizeHandler(self, tips, touchPosition)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER,function()
        if (not tolua.isnull(self)) and self.close ~= nil then
            self:close()
        end
    end)
end

-- local function onShowRedPointTask(self)
--     if(self._redpointTask) then 
--         self._redpointTask:setVisible(true)
--     end 
-- end

-- 构造函数
function TaskLayerUI:ctor(spriteID, type)
    if type == UI.TaskLayerUIType.TASKLAYER_TOWN then
        TaskLayerUI.super.ctor(self, UIType.TOWN_TASK_LAYER_UI, COM_RES_LIST_TOWN, COM_WIDTH, COM_HEIGHT)
    else
        TaskLayerUI.super.ctor(self, UIType.TASK_LAYER_UI, COM_RES_LIST_BAG, COM_WIDTH, COM_HEIGHT)
    end
    -- add by zp 这里存在几种方式打开页面，没有做正规的触发npc的functionType方式打开，所以这里单独添加相关触发
    RedPointManager:triggerNewRedPointFlag(PublicDefine.FUNCTION_TYPE.TASK)
    Net.NetRoleSystem:reqOpenFuntionTypeUI(PublicDefine.FUNCTION_TYPE.TASK)
    
    -- self:enableDebugDraw()
    self._data = nil
    self._activePanel = nil
    self._activeTabIndex = 0
    self._taskSlider = nil      -- 任务右边的滑块
    self._isScrolling = false   -- 任务列表是否正在滚动
    self._taskscrollView = nil  -- 任务列表的滚动视图
    self._taskUIType = nil      -- 任务界面的类型  城镇类型  背包类型
    self._taskTable = {}        -- 任务表
    self._taskData = nil        -- 任务数据
    self._taskLayer = nil 
    self._taskID = {}
    self._redpointTreasure = nil --藏宝图 红点
    self._redpointTask = nil --任务红点
    self._redpointAchi = nil  --成就红点
    self._bg2 = nil 
    self._activityPanel = nil 
    self._newNum    = 0
    self._oldNum    = -1
    self._views     = {}
    self._spriteID  = spriteID;
    self._taskUIType = type
end

-- 析构函数
function TaskLayerUI:dtor()

    TaskLayerUI.super.dtor(self)
    self:unRegisterListener()
end

-- public:
-- 初始化
function TaskLayerUI:init()
    TaskLayerUI.super.init(self)
    self:registerListener()
end

function TaskLayerUI:choiceTabIndex(tabIndex)
    local panel = nil
    self:hideShareBtn()
    if not self._views[tabIndex] then
        if (tabIndex == PublicDefine.UnlockFunctionType.UnlockFunctionType_Task) then
            -- Avalon.MessageCenter:bind(GameMessage.MC_GOODS_NEW_TASK_UITAG,self,onShowRedPointTask)
            local taskData = GameDataManager:getInstance():getTaskArr()
            
            require "app.ui.baglayer.TaskLayer.TaskLayer"
            panel = UI.TaskLayer:create()
            panel:init(self._taskUIType,taskData)
        -- 成就
        elseif (tabIndex == PublicDefine.UnlockFunctionType.UnlockFunctionType_Achievement) then
            panel = UI.AchievementLayer:create(self._spriteID)
            panel:init(self._taskUIType)

            Avalon.MessageCenter:bind(GameMessage.MC_ACHIEVEMENT_CHECK_NEW,self,self.refreshAchievementRedPoint)
        elseif (tabIndex == PublicDefine.UnlockFunctionType.UnlockFunctionType_TreasureMap) then
            local data = GoodsDataManager:getVirtualGoodsDataList()
            panel = UI.TreasureMapLayer:create()
            panel:init(data,self)
        else
            assert(false)
        end
        if (panel) then 
            self._contentLayout:addChild(panel,100)
        end
        self._views[tabIndex] = panel
    end
    for i, view in pairs( self._views ) do
        if i ==  tabIndex then
            panel = view
            view:show()
        else
            view:hide()
            view:centerBottom(winSize.height * 2)
        end
    end 
    
    if (panel) then 
        panel:leftBottom(15, 6)
        self._activePanel = panel
        self:showShareBtn()
    end

    Game.FunctionUnlockManager:getInstance():removeNewFlag(tabIndex)
end
-- 初始化视图
function TaskLayerUI:onInitView()
    -- local bg3 = UI.Image:create()
    -- bg3:init(BG_1)

    local type = self._taskUIType    
    -- 内容区域
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:centerBottom(0)
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    self:createFunctionTable()
    self:refreshTabState()
    self:refreshTaskRedPoint()
    self:refreshTreasureRedPoint()
end

-- 更新视图
function TaskLayerUI:createFunctionTable()
     -- 城镇
    if(self._taskUIType == tasklayerUIType.TASKLAYER_TOWN) then 
        local functionTabList = UI.TabList:create()
        functionTabList:init(142)
        functionTabList:leftUp(150, -56)
        -- functionTabList:enableDebugDraw(UI.RED)
        functionTabList:setTouchEnable(true)
        functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex)
            self:choiceTabIndex(tabIndex)
        end)
        functionTabList:setLayout(LayoutArrayType.HORIZONTAL, LayoutFloatType.FLOAT_LEFT)
        self._functionTabList = functionTabList


        -- 任务
        local functionTab = UI.SpineTabItem:create()
        functionTab:init("effect_ui_package_sociaty_homepage_bg", "effect_ui_package_title_task_icon", UI.TEXT_DES_TASK, UI.FONT_BOLD)
        functionTab:setSize(220, 45)
        functionTabList:addToTab(functionTab, PublicDefine.UnlockFunctionType.UnlockFunctionType_Task)
        functionTab.onDisableClick = handler(self, self.tagDisableClick)
        self._redpointTask = functionTab:showRedPoint()
        self._redpointTask:setVisible(false)

        -- 成就
        local functionTab = UI.SpineTabItem:create()
        functionTab:init("effect_ui_package_sociaty_supervise_bg", "effect_ui_package_task_achievement", UI.TEXT_111010, UI.FONT_BOLD)
        functionTab:setSize(220, 45)
        functionTab:reverseBg()
        functionTabList:addToTab(functionTab, PublicDefine.UnlockFunctionType.UnlockFunctionType_Achievement)
        functionTab.onDisableClick = handler(self, self.tagDisableClick)
        self._redpointAchi = functionTab:showRedPoint()
        -- 在城镇打开任务面板检查是否有可以领取的成就
        self._redpointAchi:setVisible(MasterDataManager:hasOneAchevementComplete())
        local detaultTag = self:getDefaultTag()
        self._functionTabList:setDefaultIndex(detaultTag)
        self._contentLayout:addChild(functionTabList, 110)
        self:choiceTabIndex(detaultTag)
        self._functionTabList:setReverseOrder(true)
    elseif self._taskUIType == tasklayerUIType.TASKLAYER_BAG then 
        -- TAB控件 任务 成就 藏宝图(去掉成就 岳溁松)
        local functionTabList = UI.TabList:create()
        functionTabList:init(3,114,64)
        functionTabList:leftUp(865, 50)
        functionTabList:setTouchEnable(true)
        functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex)
            self:choiceTabIndex(tabIndex)
        end)
        functionTabList:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
        self._functionTabList = functionTabList
        -- 任务
        local functionTab = UI.FunctionTabItem:create()
        functionTab:init(BUTTON_NORMAL, BUTTON_ACTIVE, BUTTON_DISABLE, UI.TEXT_DES_TASK, UI.FONT_BOLD, UI.FONT_SIZE_20PX)

        self._redpointTask = AvalonUtil.createRedPoint(functionTab, 0, 0, 10)
        self._redpointTask:setVisible(false)
        -- AvalonUtil.utf8tochars(LanguageManager:getInstance():getLocalString(1110553))
        functionTabList:addToTab(functionTab, PublicDefine.UnlockFunctionType.UnlockFunctionType_Task)
        functionTab.onDisableClick = handler(self, self.tagDisableClick)
        functionTab:setFontColor(UI.FONT_COLOR_48_50_56, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)

        --成就
        local functionTab = UI.FunctionTabItem:create()
        functionTab:init(BUTTON_NORMAL, BUTTON_ACTIVE, BUTTON_DISABLE, UI.TEXT_111010, UI.FONT_BOLD, UI.FONT_SIZE_20PX)
        self._redpointAchi = AvalonUtil.createRedPoint(functionTab, 0, 0, 10)
        -- 在城镇打开任务面板检查是否有可以领取的成就
        self._redpointAchi:setVisible(MasterDataManager:hasOneAchevementComplete())
        functionTabList:addToTab(functionTab, PublicDefine.UnlockFunctionType.UnlockFunctionType_Achievement)
        functionTab.onDisableClick = handler(self, self.tagDisableClick)
        functionTab:setFontColor(UI.FONT_COLOR_48_50_56, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)

        -- 藏宝图
        local functionTab = UI.FunctionTabItem:create()
        functionTab:init(BUTTON_NORMAL, BUTTON_ACTIVE, BUTTON_DISABLE, UI.TEXT_111011, UI.FONT_BOLD, UI.FONT_SIZE_20PX)
        functionTab:setFontColor(UI.FONT_COLOR_48_50_56, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)
        
 
        self._redpointTreasure = AvalonUtil.createRedPoint(functionTab, 0, 0, 10)
        self._redpointTreasure:setVisible(false)

        -- AvalonUtil.utf8tochars(LanguageManager:getInstance():getLocalString(1110554))
        functionTabList:addToTab(functionTab, PublicDefine.UnlockFunctionType.UnlockFunctionType_TreasureMap)
        functionTab.onDisableClick = handler(self, self.tagDisableClick)

        -- 添加背景
        local bg =  cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png", CCRectMake(303,136,4,2))
        bg:setContentSize(852, 534)
        bg:setAnchorPoint(0, 0)
        bg:setPosition(15, 5)

        local detaultTag = self:getDefaultTag()
        self._contentLayout:addChild(bg, 10)
        self._functionTabList:setDefaultIndex(detaultTag)
        self._contentLayout:addChild(functionTabList)
        self:choiceTabIndex(detaultTag)
    end
end

-- 更新视图
function TaskLayerUI:onUpdateView()
    
end

function TaskLayerUI:makeVersionText(str)
    local tableStr = AvalonUtil.utf8tochars(str)

    local str = ""
    for k, v in pairs(tableStr) do 
        if(str == "") then
            str = v.char
        else 
            str = str .. "\n".. v.char
        end
    end

    return str
end

-- 注册监听事件(可选)
function TaskLayerUI:registerListener()
    --刷新按钮解锁状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_TASK_POINT_RED_POINT, self, self.refreshTaskRedPoint)

end


-- 注销监听事件(可选)
function TaskLayerUI:unRegisterListener()
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_TASK_POINT_RED_POINT, self, self.refreshTaskRedPoint)
end

function TaskLayerUI:getDefaultTag()
    -- dump(RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Task), "------------getDefaultTag")
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Task) then
        return PublicDefine.UnlockFunctionType.UnlockFunctionType_Task
    elseif RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Achievement) then
        return PublicDefine.UnlockFunctionType.UnlockFunctionType_Achievement
    else
        if self._taskUIType == tasklayerUIType.TASKLAYER_BAG then 
            return PublicDefine.UnlockFunctionType.UnlockFunctionType_TreasureMap
        end
    end
end

--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function TaskLayerUI:refreshTabState()
    if not self._functionTabList then return end
    if(self._taskUIType == tasklayerUIType.TASKLAYER_TOWN) then 
        for k, v in pairs(self._functionTabList._compList) do
            if RoleDataManager:isUnlockByFunctionType(k) then
                self:playTabItemAction(v, k)
            else
                v:disable()
            end
        end
    else
        for k, v in pairs(self._functionTabList._compList) do
            if RoleDataManager:isUnlockByFunctionType(k) then
                self:playTabItemAction(v, k)
            else
                v:disable()
            end
        end
    end 
end

function TaskLayerUI:playTabItemAction(tabItem, functionType)
    if Game.FunctionUnlockManager:getInstance():isShowUnlockAction(functionType) then
        tabItem:disable()
        tabItem:playUnlockAction(function()
            self:playUnlockActionCallback(tabItem, functionType)
        end)
    elseif Game.FunctionUnlockManager:getInstance():isShowNewAction(functionType) then
        tabItem:playNewAction(0.8)
    else
        tabItem:removeNewAction()
    end
end

function TaskLayerUI:playUnlockActionCallback(tabItem, functionType)
    Game.FunctionUnlockManager:getInstance():removeUnlcokActFlag(functionType)
    tabItem:playNewAction(0.8)
    tabItem:removeDisable()
end

function TaskLayerUI:tagDisableClick(targert)
    -- dump(targert:getIndex(), "---------targert:getIndex()")          
    Game.FunctionUnlockManager:showLockTips(targert:getIndex())
end

function TaskLayerUI:refreshTaskRedPoint()
    local isHaveGuidTask = false
    if (self._taskUIType == tasklayerUIType.TASKLAYER_TOWN) then 
        isHaveGuidTask = false
    elseif self._taskUIType == tasklayerUIType.TASKLAYER_BAG then 
        isHaveGuidTask = true
    end

    if TaskDataManager:haveFinishTask(isHaveGuidTask) then
        self._redpointTask:show()
    else
        self._redpointTask:hide()
    end
end

-- 刷新成就红点显示
function TaskLayerUI:refreshAchievementRedPoint()
    if self._redpointAchi then
        self._redpointAchi:setVisible(MasterDataManager:hasOneAchevementComplete())
    end
end

function TaskLayerUI:refreshTreasureRedPoint()
    if self._redpointTreasure then
        local isHaveNew = GoodsDataManager:isHavaNewTreasureFragment()
        self._redpointTreasure:setVisible(isHaveNew)
    end
end 


function TaskLayerUI:showShareBtn(parentNode)
    if parentNode ~= nil then
        self.parentNode = parentNode
    end
    if self._activePanel and self._activePanel.showShareBtn then
        self._activePanel:showShareBtn(self.parentNode)
    end
end

function TaskLayerUI:hideShareBtn()
    if self.parentNode then
        self.parentNode:hideShareBtn()
    end
end
