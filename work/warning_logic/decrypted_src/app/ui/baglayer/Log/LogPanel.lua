--[[
    UI - 背包中的日志
]]

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
require("app.ui.baglayer.Log.LogLayer")
require("app.ui.baglayer.Archive.ArchiveLayer")
require("app.ui.baglayer.Log.FunnyRecordLayer")
UI = UI or {}

local LogPanel = class("LogPanel", UI.HWBtnComponent)
UI.LogPanel = LogPanel

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 978
local COM_HEIGHT = 555
-- 背包资源
local COM_RES_LIST = {
}

local TAG_TYPE = {
    PublicDefine.UnlockFunctionType.UnlockFunctionType_Pokedex,  --   图鉴
    PublicDefine.UnlockFunctionType.UnlockFunctionType_FightLog, --   战利品日志
    PublicDefine.UnlockFunctionType.UnlockFunctionType_FunnyRecord, -- 趣味数据
}

-- 图片名字
local LOG_PANEL_SPRITE = {
    BUTTON_NORMAL = "ui_btn_gray2_0.png",
    BUTTON_ACTIVE = "ui_btn_gray2_1.png",
    BUTTON_DISABLE = "ui_btn_gray2_2.png",
}

-- 布局
local LOG_PANEL_LAYOUT = {
    -- 根节点尺寸
    ROOT_LAYOUT_WIDTH = 1024,
    ROOT_LAYOUT_HEIGHT = 640,
    -- 面板内容布局
    LAYOUT_CONTENT_WIDTH = 1024,
    LAYOUT_CONTENT_HEIGHT = 520,
    -- 物品列表
    GOODS_GRID_INIT_COLUMN = 5,
    GOODS_GRID_INIT_ROW = 10,
    GOODS_GRID_WIDTH = 74,
    GOODS_GRID_HEIGHT = 74,
    GOODS_GRID_HORIZONTAL_SPACE = 6,
    GOODS_GRID_VERTICAL_SPACE = 6,
    GOODS_GRID_PADDING_SPACE = 6,
    -- 滚动视图背景
    GOODS_SCROLL_VIEW_BG_LEFT = 420,
    GOODS_SCROLL_VIEW_BG_UP = 118,
    -- 滚动视图
    GOODS_SCROLL_VIEW_LEFT = 430,
    GOODS_SCROLL_VIEW_UP = 135,
    -- 滑块
    GOODS_SCROLL_VIEW_SLIDER_LEFT = 860,
    GOODS_SCROLL_VIEW_SLIDER_UP = 118,
    GOODS_SCROLL_VIEW_SLIDER_WIDTH = 10,
    GOODS_SCROLL_VIEW_SLIDER_HEIGHT = 400,
    -- 战利品按钮
    SBOLIS_BUTTON_LEFT = 0,
    SBOLIS_BUTTON_UP = 0,
    -- 图鉴按钮
    PICTURE_BUTTON_LEFT = 0,
    PICTURE_BUTTON_UP = 0,
    -- 标题
    TITLE_BG_LEFT = 480,
    TITLE_BG_UP = 10,
    TITLE_TEXT_LEFT = 480,
    TITLE_TEXT_UP = 0,
    -- 黄金
    MONEY_BG_LEFT = 570,
    MONEY_BG_UP = 92,
    MONEY_ICON_LEFT = 555,
    MONEY_ICON_UP = 90,
    MONEY_TEXT_LEFT = 570,
    MONEY_TEXT_UP = 92,
    -- tab控件
    TAB_LIST_LEFT = 865,
    TAB_LIST_UP = 50,
    TAB_ITEM_SPACE = 3,
    TAB_ITEM_WIDTH = 114,
    TAB_ITEM_HEIGHT = 64,
    -- 装备详情布局
    EQUIPMENT_INFO_LAYOUT_WIDTH = 288,
    EQUIPMENT_INFO_LAYOUT_HEIGHT = 530,
    EQUIPMENT_INFO_LAYOUT_LEFT = 65,
    EQUIPMENT_INFO_LAYOUT_UP = 0,
    -- 装备详情
    EQUIPMENT_INFO_AREA_LEFT = 0,
    EQUIPMENT_INFO_AREA_UP = 47,
    ITEM_INFO_AREA_UP = 47,
    MATERIAL_INFO_AREA_UP = 47,
    -- 装备详情的图标
    EQUIPMENT_INFO_ICON_LEFT = 68,
    EQUIPMENT_INFO_ICON_UP = 0,
    EQUIPMENT_INFO_ICON_SHADOW_LEFT = 88,
    EQUIPMENT_INFO_ICON_SHADOW_UP = 5
}

-- 激活tab
local function onActiveTabHandler(self, tabIndex, lastTabIndex)
    if (self._activePanel) then
        self._activePanel:removeFromParent()
        self._activePanel = nil
    end
    self:hideShareBtn()
    -- 战利品
    if (tabIndex == PublicDefine.UnlockFunctionType.UnlockFunctionType_FightLog) then
        self._activePanel = UI.LogLayer:create()
        self._activePanel:init(self._logData)
    -- 图鉴
    elseif (tabIndex == PublicDefine.UnlockFunctionType.UnlockFunctionType_Pokedex) then
        self._activePanel = UI.ArchiveLayer:create(self._isPlayTableCellAct[tabIndex])
    -- 趣味数据
    elseif (tabIndex == PublicDefine.UnlockFunctionType.UnlockFunctionType_FunnyRecord) then
        self._activePanel = UI.FunnyRecordLayer:create(self._isPlayTableCellAct[tabIndex])
        self._activePanel:init()
    else
        assert(false)
    end
    self._isPlayTableCellAct[tabIndex] = false
    self._tabList:showTab(tabIndex)
   
    if (self._activePanel) then
        self._activePanel:leftBottom(15, 5)
        self._contentLayout:addChild(self._activePanel)
        self:showShareBtn()
    end
    Game.FunctionUnlockManager:getInstance():removeNewFlag(tabIndex)
end

-- 构造函数
function LogPanel:ctor()
    LogPanel.super.ctor(self, UIType.BAG_LOG_PANEL, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    self._goodsListSlider = nil
    self._equipmentInfoArea = nil
    self._scrollView = nil
    self._selectedBagGrid = nil
    self._isPlayTableCellAct = {}
    -- self:enableDebugDraw(UI.RED)
end

-- 析构函数
function LogPanel:dtor()
    LogPanel.super.dtor(self)
    self:unRegisterListener()
    self._isPlayTableCellAct = {}
end

-- 初始化
function LogPanel:init(logData)
    self._logData = logData

    LogPanel.super.init(self)
    self:registerListener()
end

-- 初始化视图
function LogPanel:onInitView()
    local tagTitles = {}
    tagTitles[PublicDefine.UnlockFunctionType.UnlockFunctionType_Pokedex] = UI.TEXT_DES_PICTURE
    tagTitles[PublicDefine.UnlockFunctionType.UnlockFunctionType_FightLog] = UI.TEXT_DES_SBOLIS
    tagTitles[PublicDefine.UnlockFunctionType.UnlockFunctionType_FunnyRecord] = UI.TEXT_DES_FUNNNY

    -- tab控件
    local tabList = UI.TabList:create()
    tabList:init(
        LOG_PANEL_LAYOUT.TAB_ITEM_SPACE, 
        LOG_PANEL_LAYOUT.TAB_ITEM_WIDTH,
        LOG_PANEL_LAYOUT.TAB_ITEM_HEIGHT
    )
    tabList:leftUp(
        LOG_PANEL_LAYOUT.TAB_LIST_LEFT,
        LOG_PANEL_LAYOUT.TAB_LIST_UP
    )
    tabList:setReverseOrder(true)
    tabList:addEventListener(UIEvent.TAB_ACTIVE, self, onActiveTabHandler)
    tabList:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
    for k, v in ipairs(TAG_TYPE) do
        local textStr = tagTitles[v]
        local tab = UI.FunctionTabItem:create()
        tab:init(LOG_PANEL_SPRITE.BUTTON_NORMAL, LOG_PANEL_SPRITE.BUTTON_ACTIVE, LOG_PANEL_SPRITE.BUTTON_DISABLE, textStr, UI.FONT_BOLD, UI.FONT_SIZE_20PX)
        tabList:addToTab(tab, v)
        tab:setFontColor(UI.FONT_COLOR_48_50_56, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)
        tab.onDisableClick = handler(self, self.tagDisableClick)
        -- tab:enableDebugDraw()
    end
    -- tabList:enableDebugDraw()
    self._tabList = tabList
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    -- contentLayout:enableDebugDraw()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(contentLayout, 5)
    self._contentLayout = contentLayout
    local defalutTag = self:getDefaultTag()
    self._tabList:setDefaultIndex(defalutTag)
    self:addChild(tabList)
    self:refreshTabState()
end

-- 更新视图
function LogPanel:getDefaultTag()
    for k, v in ipairs(TAG_TYPE) do
        if RoleDataManager:isUnlockByFunctionType(v) then
            return v
        end
    end
end

-- 更新视图
function LogPanel:onUpdateView()

end

--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function LogPanel:refreshTabState()
    local unlockType = PublicDefine.UnlockFunctionType 
    local isShowNewActionFunc = handler(Game.FunctionUnlockManager:getInstance(), Game.FunctionUnlockManager:getInstance().isShowNewAction)
    for k, v in pairs(self._tabList._compList) do
        if RoleDataManager:isUnlockByFunctionType(k) then
            v:restore()
            if isShowNewActionFunc(k) then
                local actionNode = v:playNewAction(0.8)
                if actionNode then
                    actionNode:rightUp(20, 15)
                    actionNode:rotate(50)
                end
            end 
        else
            v:disable()
        end
    end
end

-- 注册监听事件(可选)
function LogPanel:registerListener()
    --刷新按钮解锁状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)
end


-- 注销监听事件(可选)
function LogPanel:unRegisterListener()
    --刷新按钮解锁状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)
end

function LogPanel:tagDisableClick(targert)
    -- dump(targert:getIndex(), "---------targert:getIndex()")          
    Game.FunctionUnlockManager:showLockTips(targert:getIndex())
end

function LogPanel:showShareBtn(parentNode)
    if parentNode ~= nil then
        self.parentNode = parentNode
    end
    if self._activePanel and self._activePanel.showShareBtn then
        self._activePanel:showShareBtn(self.parentNode)
    end
end

function LogPanel:hideShareBtn()
    if self.parentNode then
        self.parentNode:hideShareBtn()
    end
end