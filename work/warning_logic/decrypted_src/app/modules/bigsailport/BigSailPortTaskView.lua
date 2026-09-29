------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/14
--desc	: 
------------------------------------------------------------------------------
-- 任务
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailPortTaskView = class("BigSailPortTaskView", UI.HWBtnComponent)

require "app.ui.common.Tab.SpineTabItem"
require "app.ui.baglayer.TaskLayer.PortTaskLayerUI"
require "app.ui.common.Tab.TabList"

UI = UI or {}

UI.BigSailPortTaskView = BigSailPortTaskView

-- 资源
local COM_RES_LIST = {
}

-- 功能模块对应的tab索引 --
---------------------
local TAB_INDEX = {
    TASK_DAILY = 1,    -- 日常任务
    TASK_WEEK = 2,     -- 周任务
    TASK_LIMIT = 3,    -- 限时任务
}
---------------------

local LAYOUT_TAB_LIST_SPACE = 0
local LAYOUT_TAB_LIST_WIDTH = 157
local LAYOUT_TAB_LIST_HEIGHT = 65

-- 图片名字 --
---------------------------------------
-- 关闭按钮
local MENU_CLOSE_SPINE_BG_NAME = "effect_ui_package_title_back_bg"
local MENU_CLOSE_SPINE_ICON_NAME = "effect_ui_package_title_back_icon"
-- 任务
local MENU_TASK_SPINE_BG_NAME = "effect_ui_package_title_task_bg"
local MENU_TASK_SPINE_ICON_NAME = "effect_ui_package_title_task_icon"
-- 日志
local MENU_LOG_SPINE_BG_NAME = "effect_ui_package_title_set_bg"
local MENU_LOG_SPINE_ICON_NAME = "effect_ui_package_title_log_icon"
--画册
local MENU_PICTURE_ALBUM_BG_NAME = "effect_ui_package_title_set_bg"
local MENU_PICTURE_ALBUM_ICON_NAME = "effect_ui_pets_picturealbum_icon"

---------------------------------------

local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = 1136
local COM_HEIGHT = 640
-- 设计尺寸
local LAYOUT_DESIGN_WIDTH = 1136
local LAYOUT_DESIGN_HEIGHT = 640

-- 根据选择的功能标签显示不同的功能面板
-- 创建一个表现书签效果的tab控件
-- 创建一个功能索引对于的功能面板
local function showPanelByTabIndex(self, tabIndex)
    if (self._tabIndex == tabIndex) then return end
    local lastTabIndex = self._activeTabIndex
    self._activeTabIndex = tabIndex

    self._functionTabList._compList[tabIndex]:active()
    
    local panel = self.PanelList[tabIndex]
    if (tabIndex == TAB_INDEX.TASK_WEEK) then
        -- 周任务
        if panel ~= nil then
            self._activePanel = panel
        else
            self._activePanel = UI.PortTaskLayerUI:create(self._spriteID, UI.TaskLayerType.TASKLAYER_PORT, tabIndex)
            self._activePanel:init()
        end
        self._activePanel:setName("WEEK")
        self._contentLayout:getChildByName("BOARD"):show()
    elseif (tabIndex == TAB_INDEX.TASK_DAILY) then
        -- 日常任务
        if panel ~= nil then
            self._activePanel = panel
        else
            self._activePanel = UI.PortTaskLayerUI:create(self._spriteID, UI.TaskLayerType.TASKLAYER_PORT, tabIndex)
            self._activePanel:init()
        end
        self._activePanel:setName("DAILY")
        self._contentLayout:getChildByName("BOARD"):show()
    elseif (tabIndex == TAB_INDEX.TASK_LIMIT) then
        -- 限时任务
        if panel ~= nil then
            self._activePanel = panel
        else
            self._activePanel = UI.PortTaskLayerUI:create(self._spriteID, UI.TaskLayerType.TASKLAYER_PORT, tabIndex)
            self._activePanel:init()
        end
        self._activePanel:setName("LIMIT")
        self._contentLayout:getChildByName("BOARD"):show()
    else
        assert(false)
    end

    if (self._activePanel) then
        self._activePanel:leftBottom(79, 18)
        -- 这里必须调用 show() 函数来显示，在子页面重载该接口实现业务逻辑
        self._activePanel:show()
        if panel == nil then
            self._contentLayout:addChild(self._activePanel, 5)
        end
        self._activePanel:showShareBtn(self)
    end

    -- if (self._activePanel2) then
    --     self._activePanel2:leftBottom(79, 18)
    --     -- 这里必须调用 show() 函数来显示，在子页面重载该接口实现业务逻辑
    --     self._activePanel2:show()
    --     if panel == nil then
    --         self._contentLayout:addChild(self._activePanel2, 5)
    --     end
    --     self._activePanel2:showShareBtn(self)
    -- end

    self.PanelList[tabIndex] = self._activePanel
    for k, v in pairs(self.PanelList) do
        if k ~= tabIndex then
            -- 这里必须调用 show() 函数来显示，在子页面重载该接口实现业务逻辑
            v:hide()
            v:leftBottom(-winSize.width, -winSize.height)
        end
    end
    --self:refreshTabState()
end

function BigSailPortTaskView:ctor(idx)
    BigSailPortTaskView.super.ctor(
    	self,
    	UI.Type.BIGSAIL_TASK,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._curIdx = idx or TAB_INDEX.TASK_DAILY
    self._activeTabIndex = 0
    self.PanelList = {}
end

function BigSailPortTaskView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailport", "BigSailPort", false)
    BigSailPortTaskView.super.init(self, ... )
end

function BigSailPortTaskView:dtor()
    BigSailPortTaskView.super.dtor(self)
    self:unbindModel()
    self.PanelList = {}
    reload_script_file_mvc("app.modules.bigsailport.BigSailPortTaskView")
end


function BigSailPortTaskView:onInitView()
    -- 创建大背景（根据分辨率适配）
    self._contentLayout = self:createBg()
    -- local scaleX = winSize.width / LAYOUT_DESIGN_WIDTH
    -- local scaleY = winSize.height / (LAYOUT_DESIGN_HEIGHT + 45)
    -- local scale = scaleX > scaleY and scaleY or scaleX
    -- if (scale > 1.0) then scale = 1.0 end
    -- self._contentLayout:setScale(scale)
 
    -- -- 创建关闭按钮
    -- local closeButton = UI.SpineTabItem:create()
    -- closeButton:init(
    --     MENU_CLOSE_SPINE_BG_NAME, 
    --     MENU_CLOSE_SPINE_ICON_NAME,
    --     nil,
    --     nil
    -- )
    -- closeButton:setSize(120, 52)
    -- closeButton:addEventListener(UIEvent.TAB_CLICK, self, function(self)
    --     local parent = self:getParent()
    --     parent:removeChildByName("bigSailPortTaskView")
    -- end)
    -- self._contentLayout:addChild(closeButton, 15)
    -- closeButton:rightUp(95, -8)
    -- closeButton:onActive()
    -- closeButton:setSingle(true)

    -- 创建功能便签
    local functionTabList = UI.TabList:create()
    functionTabList:init(
        LAYOUT_TAB_LIST_SPACE
    )
    functionTabList:leftUp(110, -7)
    -- functionTabList:enableDebugDraw()
    functionTabList:setTouchEnable(true)
    functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex)
        -- print(string.format("FunctionsPanel onInitView: select function tab %d.", tabIndex))
        showPanelByTabIndex(self, tabIndex)
    end)
    functionTabList:setDefaultIndex(nil)
    self._contentLayout:addChild(functionTabList, 15)
    self._functionTabList = functionTabList
    -- -- 日常任务
    local functionTab = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ITEM_TASK, SPINE_TAB_ITEM_BTM_SPACE)
    functionTab.onDisableClick = handler(self, self.tagDisableClick)
    functionTab:init(
        MENU_TASK_SPINE_BG_NAME, 
        MENU_TASK_SPINE_ICON_NAME,
        UI.TEXT_226158,
        UI.FONT_BOLD
    )
    functionTabList:addToTab(functionTab, TAB_INDEX.TASK_DAILY)
    functionTab:setSize(LAYOUT_TAB_LIST_WIDTH + 3, LAYOUT_TAB_LIST_HEIGHT)


    -- -- 周任务
    local functionTab2 = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ITEM_TASK, SPINE_TAB_ITEM_BTM_SPACE)
    functionTab2.onDisableClick = handler(self, self.tagDisableClick)
    functionTab2:init(
        MENU_TASK_SPINE_BG_NAME, 
        MENU_TASK_SPINE_ICON_NAME,
        UI.TEXT_226159,
        UI.FONT_BOLD
    )
    functionTabList:addToTab(functionTab2, TAB_INDEX.TASK_WEEK)
    functionTab2:setSize(LAYOUT_TAB_LIST_WIDTH + 3, LAYOUT_TAB_LIST_HEIGHT)

    -- -- 限时任务
    local functionTab3 = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ITEM_TASK, SPINE_TAB_ITEM_BTM_SPACE)
    functionTab3.onDisableClick = handler(self, self.tagDisableClick)
    functionTab3:init(
        MENU_TASK_SPINE_BG_NAME, 
        MENU_TASK_SPINE_ICON_NAME,
        UI.TEXT_226703,
        UI.FONT_BOLD
    )
    local openMonster = mvc.bigSailPortModel:getIslandMonsterIsOpen()
    if openMonster then
        functionTabList:addToTab(functionTab3, TAB_INDEX.TASK_LIMIT)
    end
    --functionTabList:addToTab(functionTab3, TAB_INDEX.TASK_LIMIT)
    functionTab3:setSize(LAYOUT_TAB_LIST_WIDTH + 3, LAYOUT_TAB_LIST_HEIGHT)
end

function BigSailPortTaskView:onUpdateView()
    showPanelByTabIndex(self, self._curIdx)
end

function BigSailPortTaskView:createBg()
    -- self:addChild(_backgroudImage,99999)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(LAYOUT_DESIGN_WIDTH, LAYOUT_DESIGN_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)

    local board = UI.Image:create()
    board:init("ui_4package_box_board.png")
    board:leftBottom(77, 16)
    contentLayout:addChild(board, 1)
    board:setName("BOARD")

    local upLine = UI.Image:create()
    upLine:init("ui_4package_box_up.png")
    upLine:centerUp(-42)
    contentLayout:addChild(upLine, 12)

    local bottomLine = UI.Image:create()
    bottomLine:init("ui_4package_box_down.png")
    bottomLine:leftBottom(15, 0)
    contentLayout:addChild(bottomLine, 12)

    local leftLine = UI.Image:create()
    leftLine:init("ui_4package_box_left.png")
    leftLine:leftBottom(14, 18)
    contentLayout:addChild(leftLine, 11)

    local rightLine = UI.Image:create()
    rightLine:init("ui_4package_box_right.png")
    rightLine:rightBottom(10, 18)
    contentLayout:addChild(rightLine, 4)
    -- contentLayout:enableDebugDraw()
    return contentLayout
end

function BigSailPortTaskView:getTaskAward(taskData)
    if taskData:getId() then
        local messageData = {
            id = taskData:getId(),
        }
        Net.NetBigSailSystem:reqGetTaskReward(messageData)
    end
end

function BigSailPortTaskView:refreshTabIndex(data)
    local taskMask = ConfigManager:getNavigationTaskByID(data.id)
    local tabIndex = taskMask.type

    self._functionTabList._compList[tabIndex]:active()

    self.PanelList[tabIndex] = nil
    if (tabIndex == TAB_INDEX.TASK_WEEK) then
        -- 周任务
        self._contentLayout:removeChildByName("LIMIT")
        self._contentLayout:removeChildByName("DAILY")
        self._activePanel = UI.PortTaskLayerUI:create(self._spriteID, UI.TaskLayerType.TASKLAYER_PORT, tabIndex)
        self._activePanel:init()
        self._activePanel:setName("WEEK")
        self._contentLayout:getChildByName("BOARD"):show()
    elseif (tabIndex == TAB_INDEX.TASK_DAILY) then
        -- 日常任务
        self._contentLayout:removeChildByName("WEEK")
        self._contentLayout:removeChildByName("LIMIT")
        self._activePanel = UI.PortTaskLayerUI:create(self._spriteID, UI.TaskLayerType.TASKLAYER_PORT, tabIndex)
        self._activePanel:init()
        self._activePanel:setName("DAILY")
        self._contentLayout:getChildByName("BOARD"):show()
    elseif (tabIndex == TAB_INDEX.TASK_LIMIT) then
        -- 限时任务
        self._contentLayout:removeChildByName("DAILY")
        self._contentLayout:removeChildByName("WEEK")
        self._activePanel = UI.PortTaskLayerUI:create(self._spriteID, UI.TaskLayerType.TASKLAYER_PORT, tabIndex)
        self._activePanel:init()
        self._activePanel:setName("LIMIT")
        self._contentLayout:getChildByName("BOARD"):show()
    else
        assert(false)
    end

    if (self._activePanel) then
        self._activePanel:leftBottom(79, 18)
        -- 这里必须调用 show() 函数来显示，在子页面重载该接口实现业务逻辑
        self._activePanel:show()
        if panel == nil then
            self._contentLayout:addChild(self._activePanel, 5)
        end
        self._activePanel:showShareBtn(self)
    end

    self.PanelList[tabIndex] = self._activePanel
    for k, v in pairs(self.PanelList) do
        if k ~= tabIndex then
            self.PanelList[k] = nil
            -- 这里必须调用 show() 函数来显示，在子页面重载该接口实现业务逻辑
            -- v:hide()
            -- v:leftBottom(-winSize.width, -winSize.height)
        end
    end
end

function BigSailPortTaskView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PORT_TASK_RECEIVED, self, self.getTaskAward)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PORT_REFRESH_TASK_SHOW, self, self.refreshTabIndex)
end


function BigSailPortTaskView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PORT_TASK_RECEIVED, self, self.getTaskAward)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PORT_REFRESH_TASK_SHOW, self, self.refreshTabIndex)
end





return BigSailPortTaskView












