-- HorcurxLayer.lua
-- Using:魂器 
require("utils.ObserverVariable")
require("app.config.ConfigManager")
require "app.ui.baglayer.Horcurx.HorcurxLevelLayer"
require "app.ui.baglayer.Horcurx.HorcurxIllusionLayer"
require "app.ui.baglayer.Horcurx.HorcurxEvolutionLayer"

local LanguageManager = require "app.game.LanguageManager"

local winSize = cc.Director:getInstance():getWinSize()
local languageManagerInstance = LanguageManager:getInstance()


local SHARE_MODULE = PublicDefine.SHARE_MODULE
UI = UI or {}

local HorcurxLayer = class("HorcurxLayer", UI.HWBtnComponent)
UI.HorcurxLayer = HorcurxLayer
-- 图片名字
local HORCURX_SPRITE = {
    BUTTON_NORMAL = "ui_btn_gray2_0.png",
    BUTTON_ACTIVE = "ui_btn_gray2_1.png",
    BUTTON_DISABLE = "ui_btn_gray2_2.png",
}
-- 关卡选择资源
local COM_RES_LIST = {
    -- "ui_package_skill.plist",
    "ui_package_horcurx.plist",
    "ui_general_uishare.plist",
    "ui_bg_paper3.plist",
    "ui_town_guild_skill.plist",
}

local COM_WIDTH = 978 
local COM_HEIGHT = 555

local HORCRUX_LAYOUT = {
    
    TAB_LIST_LEFT = 865,
    TAB_LIST_UP = 50,
    TAB_ITEM_SPACE = 3,
    TAB_ITEM_WIDTH = 114,
    TAB_ITEM_HEIGHT = 64,
}

function HorcurxLayer:ctor()
    HorcurxLayer.super.ctor(
    self,UIType.HORCURX_LAYER,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
    )
    self.rootLayer = nil;           --root节点

   
    self:registerListener();

    -- self:enableDebugDraw()
end
local HORCURX_FUNCTION_TYPE = {
    LEVEL=1,HUAN_HUA=2, EVOLUTION=3
}

function HorcurxLayer:dtor()
    HorcurxLayer.super.dtor(self)
    self:unRegisterListener();

    reload_script_file("app.ui.baglayer.Horcurx.HorcurxLayer")
end
-- 注册监听事件(可选)
function HorcurxLayer:registerListener()
    -- 角色状态更新 
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HORCURX_JUMP_VIEW, self, self.jumpToView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HORCURX_INFO_UPDATE, self, self.onLvResultBack)
end


-- 注销监听事件(可选)
function HorcurxLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HORCURX_JUMP_VIEW, self, self.jumpToView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HORCURX_INFO_UPDATE, self, self.onLvResultBack)
end

function HorcurxLayer:onLvResultBack(data)
    -- if data.isUpLv then
        self:checkShowillusion()
    -- end
end

-- 激活tab
local function onActiveTabHandler(self, tabIndex, lastTabIndex)
    if (self._activePanel) then
        self._activePanel:removeFromParent()
        self._activePanel = nil
    end
    -- self:hideShareBtn()
    if (tabIndex == HORCURX_FUNCTION_TYPE.LEVEL) then
        self._activePanel = UI.HorcurxLevelLayer:create()
        self._activePanel:init()
    elseif (tabIndex == HORCURX_FUNCTION_TYPE.HUAN_HUA) then
        self._activePanel = UI.HorcurxIllusionLayer:create()
        self._activePanel:init()
    elseif (tabIndex == HORCURX_FUNCTION_TYPE.EVOLUTION) then
        self._activePanel = UI.HorcurxEvolutionLayer:create()
        self._activePanel:init()
    else
        assert(false)
    end
    self._tabList:showTab(tabIndex)
   
    if (self._activePanel) then
        self._activePanel:leftBottom(15, 5)
        self._contentLayout:addChild(self._activePanel)
        -- self:showShareBtn()
    end
    Game.FunctionUnlockManager:getInstance():removeNewFlag(tabIndex)
end


-- 初始化视图
function HorcurxLayer:onInitView()
      -- tab控件
    local tabList = UI.TabList:create()
    tabList:init(
        HORCRUX_LAYOUT.TAB_ITEM_SPACE, 
        HORCRUX_LAYOUT.TAB_ITEM_WIDTH,
        HORCRUX_LAYOUT.TAB_ITEM_HEIGHT
    )
    tabList:leftUp(
        HORCRUX_LAYOUT.TAB_LIST_LEFT,
        HORCRUX_LAYOUT.TAB_LIST_UP
    )
    tabList:setReverseOrder(true)
    tabList:addEventListener(UIEvent.TAB_ACTIVE, self, onActiveTabHandler)
    tabList:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
    for k, textStr in ipairs({UI.TEXT_1212390, UI.TEXT_1212391, UI.TEXT_1212392}) do
        local tab = UI.FunctionTabItem:create()
        tab:init(HORCURX_SPRITE.BUTTON_NORMAL, HORCURX_SPRITE.BUTTON_ACTIVE, HORCURX_SPRITE.BUTTON_DISABLE, textStr, UI.FONT_BOLD, UI.FONT_SIZE_20PX)
        tabList:addToTab(tab, k)
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

    self:checkShowillusion()
end

function HorcurxLayer:checkShowillusion()
    self._tabList:hideTab(HORCURX_FUNCTION_TYPE.EVOLUTION)
    -- if HorcurxDataManager:isCanEvolutionToNext() then
    --     self._tabList:showTab(HORCURX_FUNCTION_TYPE.EVOLUTION)
    -- end 
end

function HorcurxLayer:jumpToView(tabIndex)
    self._tabList:activeTab(tabIndex)
end
--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function HorcurxLayer:refreshTabState()
    -- local unlockType = PublicDefine.UnlockFunctionType 
    -- local isShowNewActionFunc = handler(Game.FunctionUnlockManager:getInstance(), Game.FunctionUnlockManager:getInstance().isShowNewAction)
    -- for k, v in pairs(self._tabList._compList) do
    --     if RoleDataManager:isUnlockByFunctionType(k) then
    --         v:restore()
    --         if isShowNewActionFunc(k) then
    --             local actionNode = v:playNewAction(0.8)
    --             if actionNode then
    --                 actionNode:rightUp(20, 15)
    --                 actionNode:rotate(50)
    --             end
    --         end 
    --     else
    --         v:disable()
    --     end
    -- end
end

function HorcurxLayer:show()
    HorcurxLayer.super.show(self)
    if (self._activePanel and self._activePanel.showUpdate) then
        self._activePanel:showUpdate()
    end
end



-- 更新视图
function HorcurxLayer:getDefaultTag()
    return 1
end


function HorcurxLayer:tagDisableClick(targert)
    -- dump(targert:getIndex(), "---------targert:getIndex()")          
    Game.FunctionUnlockManager:showLockTips(targert:getIndex())
end

-- 更新视图
function HorcurxLayer:onUpdateView()
end

function HorcurxLayer:showShareBtn(parentNode)
    --分享布局
    -- parentNode:showShareBtn(handler(self, self.createShareInfo), SHARE_MODULE.SHARE_MODULE_SKILL)
end
