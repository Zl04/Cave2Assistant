--[[
    GM栏标签

    修改基础：
        UI - Tab

    注：模块特殊化为不可变动大小仅供一套资源使用
        如有泛性使用需求，手动调整偏移量或添加自动判断。
    by CMonk 
]]--

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.common.Tab.TabItem"

-- 引用UI命名空间
UI = UI or {}

-- 模块初始化
local GMUtilTabItem = class("GMUtilTabItem", UI.TabItem)
UI.GMUtilTabItem = GMUtilTabItem

-- 私有变量:
local DEBUG = false
local DEBUG_DRAW = true
---------------------------------------
-- eo 模块初始化 --









-- 布局 --
---------------------------------------
-- 引用GMUtil公用设置，为了方便粘贴在这
-- GMUtilConfig.LAYOUT_DESIGN_WIDTH = 1024
-- GMUtilConfig.LAYOUT_DESIGN_HEIGHT = 640
-- GMUtilConfig.LAYOUT_TAB_CONTENT_HEIGHT = 568
--TAB背景位置
local TAB_ICON_LEFT = -11
local TAB_ICON_UP = -6
--TAB文字位置
local TAB_TEXT_LEFT = 45
local TAB_TEXT_UP = 40
--TAB按下偏移量
local TAB_PRESS_OFFSET_LEFT = 0
local TAB_PRESS_OFFSET_UP = -3
--TAB激活偏移量
local TAB_ACTIVE_OFFSET_LEFT = 0
local TAB_ACTIVE_OFFSET_UP = -3


-- 组件z序 --
---------------------
-- 布局根节点
local TAB_ROOT_LAYOUT_ZORDER = 1
-- TAB背景
local TAB_ICON_ZORDER = -3
-- TAB文字
local TAB_TEXT_ZORDER = 1
---------------------------------------
-- eo 整体布局 --














-- 程序逻辑 --
---------------------------------------
-- 构造函数
function GMUtilTabItem:ctor()
    GMUtilTabItem.super.ctor(self, UIType.TAB_ITEM, nil, 0, 0)

    self._bg = nil
    self._icon = nil
    self._tabText = nil

    self._normalIconName = nil
    self._pressIconName = nil
    self._activeIconName = nil
    self._tabString = nil
    self._fontName = nil
    self._clickMove = true
end

-- 析构函数
function GMUtilTabItem:dtor()
    GMUtilTabItem.super.dtor(self)
end

function GMUtilTabItem:closeClickMove()
    self._clickMove = false
end
---------------------------------------
-- 程序逻辑 --












-- 生命周期 --
---------------------------------------
-- 初始化
function GMUtilTabItem:init(normalIconName, pressIconName, activeIconName, tabString, fontnName)
    self._normalIconName = normalIconName
    self._pressIconName = pressIconName
    self._activeIconName = activeIconName
    self._tabString = tabString
    self._fontName = fontnName
    self._clickMove = true
    GMUtilTabItem.super.init(self)
end

-- 初始化视图
function GMUtilTabItem:onInitView(tabString)
    self._contentLayout = UI.Layout:create()
    self._contentLayout:init()
    self._contentLayout:leftUp(0, 0)
    self:addChild(self._contentLayout, TAB_ROOT_LAYOUT_ZORDER)

    self._icon = UI.Image:create()
    self._icon:init(self._normalIconName)
    self._icon:leftUp(TAB_ICON_LEFT, TAB_ICON_UP)
    self._contentLayout:addChild(self._icon, TAB_ICON_ZORDER)

    self._tabText = UI.Text:create()
    self._tabText:init(self._tabString, self._fontName or UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_244_161_88)
    self._tabText:leftUp(TAB_TEXT_LEFT, TAB_TEXT_UP)
    self._contentLayout:addChild(self._tabText, TAB_TEXT_ZORDER)
end

-- 被按下
function GMUtilTabItem:onPress()
    self._icon:setSpriteName(self._pressIconName)
    if(self._clickMove) then
        self._contentLayout:leftUp(TAB_PRESS_OFFSET_LEFT, TAB_PRESS_OFFSET_UP)
    end
end

-- 显示被激活
function GMUtilTabItem:onActive()
    self._icon:setSpriteName(self._activeIconName)
    self._tabText:setFontColor(UI.FONT_COLOR_244_224_114)
    if(self._clickMove) then
        self._contentLayout:leftUp(TAB_ACTIVE_OFFSET_LEFT, TAB_ACTIVE_OFFSET_UP)
    end
    self._tabText:setOutline({r = 0, g = 0, b = 0, a = 0})
end

-- 恢复
function GMUtilTabItem:onRestore()
    self._icon:setSpriteName(self._normalIconName)
    self._tabText:setFontColor(UI.FONT_COLOR_42_31_1)
    if(self._clickMove) then
        self._contentLayout:leftUp(0, 0)
    end
    self._tabText:setOutline(UI.FONT_COLOR_OUTLINE_67_52_20)
end
---------------------------------------
-- 生命周期 --
