--[[
    家园通用加速页面
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.HWBtnComponent"

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local HomeBasePanel = class("HomeBasePanel", UI.HWBtnComponent)
UI.HomeBasePanel = HomeBasePanel

---------------------------------------
-- eo 模块初始化 --






-- 资源统合 --
---------------------------------------
---------------------------------------
-- eo 资源统合 --






-- 生命周期 --
---------------------------------------
-- 构造函数
function HomeBasePanel:ctor(...)
    HomeBasePanel.super.ctor(self, ...)
    self._panelActive = false
end

-- 析构函数
function HomeBasePanel:dtor()
    HomeBasePanel.super.dtor(self)
end
---------------------------------------
-- eo 生命周期 --






-- 通用逻辑 --
---------------------------------------
function HomeBasePanel:setPanelActive(b)
    self._panelActive = b
end

function HomeBasePanel:getPanelActive()
	return self._panelActive
end
---------------------------------------
-- eo 通用逻辑 --







-- 事件处理 --
---------------------------------------

---------------------------------------
-- eo 事件处理 --