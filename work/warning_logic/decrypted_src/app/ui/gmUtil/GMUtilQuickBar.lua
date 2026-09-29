--[[
    测试工具 洞窟页面 2017/11/22
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.Component"


local GMUtilConfig = require("app.ui.gmUtil.GMUtilConfig")
local helper = require("app.ui.gmUtil.GMUtilHelper")
local executor = require("app.ui.gmUtil.GMUtilExecutor")

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local GMUtilQuickBar = class("GMUtilQuickBar", UI.HWBtnComponent)
UI.GMUtilQuickBar = GMUtilQuickBar

-- 私有变量
local DEBUG_DRAW = false
---------------------------------------
-- eo 模块初始化 --

-- 资源统合 --
---------------------------------------
local resList = {
    {name = GMUtilConfig.SPRITE_CONTROLS_RES, priority = COM_RES_LEVEL.HIGH},
    {name = GMUtilConfig.SPRITE_BTN_RES, priority = COM_RES_LEVEL.HIGH}
}
---------------------------------------
-- eo 资源统合 --

-- 整体布局 --
---------------------------------------
---------------------------------------
-- eo 整体布局 --

-- 程序逻辑 --
---------------------------------------

---------------------------------------
-- eo 程序逻辑 --

-- 数据结构 --
---------------------------------------
---------------------------------------
-- eo 数据结构 --

-- 生命周期 --
---------------------------------------
-- 构造函数
function GMUtilQuickBar:ctor()
    GMUtilQuickBar.super.ctor(self, 0, resList, 0, 0)
    self._contentLayout = nil
end

-- 初始化
function GMUtilQuickBar:init()
    GMUtilQuickBar.super.init(self)
end


-- 析构函数
function GMUtilQuickBar:dtor()
    GMUtilQuickBar.super.dtor(self)
end

-- 初始化视图
function GMUtilQuickBar:onInitView()
    self._contentLayout = helper:getAutoLayout()
    self:addChild(self._contentLayout, 1)

    local newBtnRow = helper:getAutoLayout(200)
    helper:addSectionUp(self._contentLayout, newBtnRow)
    helper:addSectionLeft(newBtnRow, helper:getQuickBarButton("成就", nil, function(label)
        UI.UIManager.mActivityLayer.showAchievementLayer(UI.UIManager.mActivityLayer)
        helper:closeGMUtil()
    end))

    local newBtnRow = helper:getAutoLayout(200)
    helper:addSectionUp(self._contentLayout, newBtnRow, GMUtilConfig.LAYOUT_QUICK_BTN_SPACE)
    helper:addSectionLeft(newBtnRow, helper:getQuickBarButton("兑换", nil, function(label)
        executor:showPageCodeInput()
        helper:closeGMUtil()
    end))

    local newBtnRow = helper:getAutoLayout(200)
    helper:addSectionUp(self._contentLayout, newBtnRow, GMUtilConfig.LAYOUT_QUICK_BTN_SPACE)
    helper:addSectionLeft(newBtnRow, helper:getQuickBarButton("关卡", nil, function(label)
        executor:showPageLevelSelect()
        helper:closeGMUtil()
    end))

    local newBtnRow = helper:getAutoLayout(200)
    helper:addSectionUp(self._contentLayout, newBtnRow, GMUtilConfig.LAYOUT_QUICK_BTN_SPACE)
    helper:addSectionLeft(newBtnRow, helper:getQuickBarButton("老版", nil, function(label)
        executor:showLegacyGMUtil()
        helper:closeGMUtil()
    end))

    local newBtnRow = helper:getAutoLayout(200)
    helper:addSectionUp(self._contentLayout, newBtnRow, GMUtilConfig.LAYOUT_QUICK_BTN_SPACE)
    helper:addSectionLeft(newBtnRow, helper:getQuickBarButton("常用", nil, function(label)
        local layer = helper:getGMUtilLayer(self);
        layer._tabList:restoreAllTabs()
        layer:switchPanelByIndex(layer:getTabData().FREQUENT.index)
    end))

    self:setSize(self._contentLayout:getSize())
end
---------------------------------------
-- eo 生命周期 --












-- 事件处理 --
---------------------------------------
---------------------------------------
-- eo 事件处理 --