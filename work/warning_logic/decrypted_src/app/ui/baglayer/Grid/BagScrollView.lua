--[[
    UI - 背包滑动组件
]]--

require "app.ui.Component"

UI = UI or {}

local BagScrollView = class("BagScrollView", UI.ScrollView)
UI.BagScrollView = BagScrollView

-- private:
local DEBUG = true
local DEBUG_DRAW = true

-- 尺寸
local COM_WIDTH = 412
local COM_HEIGHT = 372
-- 背包资源
local COM_RES_LIST = nil

-- 动画名字
local ANIMATION_LOOP_NAME = "animation"

-- 构造函数
function BagScrollView:ctor(width, height)
	width = width or COM_WIDTH
	height = height or COM_HEIGHT
    BagScrollView.super.ctor(self, COM_RES_LIST, width, height)

    -- 删除的动画
    self._destroyGoodsAnimation = nil
    -- 选择放回背包的动画
    self._putBackGoodsAnimation = nil
end

-- 析构函数
function BagScrollView:dtor()
    BagScrollView.super.dtor(self)
end

-- 禁止滚动
function BagScrollView:disableScrolling()
    self._innerNode:setSwallowTouches(true)
end

-- 启用滚动
function BagScrollView:enableScrolling()
    self._innerNode:setSwallowTouches(false)
end
