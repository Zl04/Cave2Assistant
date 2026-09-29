--[[
    测试工具 洞窟页面 2017/11/22
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.Component"
require "app.ui.gmUtil.GMUtilHelper"

local gmConfig = require("app.ui.gmUtil.GMUtilConfig")
local helper = UI.GMUtilHelper

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local GMUtilPanelBase = class("GMUtilPanelBase", UI.HWBtnComponent)
UI.GMUtilPanelBase = GMUtilPanelBase

-- 私有变量
local DEBUG_DRAW = false
---------------------------------------
-- eo 模块初始化 --








-- 资源统合 --
---------------------------------------
local COM_RES_LIST = {
    {name = gmConfig.SPRITE_CONTROLS_RES, priority = COM_RES_LEVEL.HIGH},
    {name = gmConfig.SPRITE_BTN_RES, priority = COM_RES_LEVEL.HIGH}
}
---------------------------------------
-- eo 资源统合 --









-- 布局 --
---------------------------------------
---------------------------------------
-- eo 整体布局 --











-- 程序逻辑 --
---------------------------------------
function GMUtilPanelBase:addRow(comp, z)
    z = z or gmConfig.LAYOUT_SECTION_Z
    helper:addSectionUp(self._scrollContent, comp, nil, z)
end

function GMUtilPanelBase:modifyRowLayout(idx, layout)
end

function GMUtilPanelBase:getRowsFuncs()
    assert(false, "Please implement this method")
end

function GMUtilPanelBase:fillContent()
    local rowFuncs = self:getRowsFuncs()
    for i,v in ipairs(rowFuncs) do
        local row, z = v(self)
        self:modifyRowLayout(i, row)
        z = z or gmConfig.LAYOUT_SECTION_Z - i
        self:addRow(row, z)
    end
end
---------------------------------------
-- eo 程序逻辑 --










-- 数据结构 --
---------------------------------------
---------------------------------------
-- eo 数据结构 --










-- 生命周期 --
---------------------------------------
-- 构造函数
function GMUtilPanelBase:ctor(resList)
    -- 添加资源
    resList = resList or {}
    for i,v in ipairs(COM_RES_LIST) do table.insert(resList, v) end

    GMUtilPanelBase.super.ctor(
        self, 
        0, 
        resList, 
        gmConfig.LAYOUT_DESIGN_WIDTH, 
        gmConfig.LAYOUT_TAB_CONTENT_HEIGHT)

    -- 行列表
    self._rows = {}

    -- 子组件
    self._contentLayout = nil
    self._scrollContent = nil
    self._scrollView = nil

    if (DEBUG_DRAW) then self:enableDebugDraw(UI.RED) end
end

-- 初始化
function GMUtilPanelBase:init()
    GMUtilPanelBase.super.init(self)
end


-- 析构函数
function GMUtilPanelBase:dtor()
    GMUtilPanelBase.super.dtor(self)

    self._contentLayout = nil
    self._scrollContent = nil
    self._scrollView = nil
end

-- 初始化视图
function GMUtilPanelBase:onInitView()
    -- 内容层， 独立于本控件外貌好来做效果和控件排放
    self._contentLayout = UI.Layout:create()
    self._contentLayout:init()
    self._contentLayout:setSize(
        gmConfig.LAYOUT_TAB_CONTENT_GRAPHIC_WIDTH, 
        gmConfig.LAYOUT_TAB_CONTENT_GRAPHIC_HEIGHT)
    self._contentLayout:centerBottom(gmConfig.LAYOUT_TAB_CONTENT_GRAPHIC_BOTTOM)
    if (DEBUG_DRAW) then self._contentLayout:enableDebugDraw() end
    self:addChild(self._contentLayout)

    -- 滚动层
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(
        gmConfig.LAYOUT_TAB_CONTENT_GRAPHIC_WIDTH, 
        gmConfig.LAYOUT_TAB_CONTENT_GRAPHIC_HEIGHT)
    scrollView:init(0,0,0,0)
    scrollView:leftUp(0,0)
    scrollView._scrollView:setBounceEnabled(true)
    self._contentLayout:addComponent(scrollView, LAYOUT_SCROLL_Z_ORDER)
    if (DEBUG_DRAW) then scrollView:enableDebugDraw() end
    self._scrollView = scrollView

    -- 滚动内容层
    local scrollContent = helper:getAutoHeightLayout()
    if (DEBUG_DRAW) then scrollContent:enableDebugDraw() end
    self._scrollView:addInnerNode(scrollContent)
    self._scrollContent = scrollContent

    -- 添加内容
    self:fillContent()
end
---------------------------------------
-- eo 生命周期 --












-- 事件处理 --
---------------------------------------
---------------------------------------
-- eo 事件处理 --