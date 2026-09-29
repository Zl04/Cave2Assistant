--[[
    任务界面的滑动组件
    AUTHOR:CZH
]]


require "app.ui.Component"

UI = UI or {}

local TaskScrollView = class("TaskScrollView", UI.ScrollView)
UI.TaskScrollView = TaskScrollView

-- private:
local DEBUG = true
local DEBUG_DRAW = true

-- 尺寸
local COM_WIDTH = 870
local COM_HEIGHT = 500
-- 任务资源
local COM_RES_LIST = nil



-- 构造函数
function TaskScrollView:ctor()
    TaskScrollView.super.ctor(self, COM_RES_LIST, 0, 0)
end

-- 析构函数
function TaskScrollView:dtor()
    TaskScrollView.super.dtor(self)
end


-- 禁止滚动
function TaskScrollView:disableScrolling()
    self._innerNode:setSwallowTouches(true)
end

-- 启用滚动
function TaskScrollView:enableScrolling()
    self._innerNode:setSwallowTouches(false)
end
