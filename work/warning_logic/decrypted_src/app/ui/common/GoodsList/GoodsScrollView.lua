--[[
    UI - 背包滑动组件
]]--

require "app.ui.Component"

UI = UI or {}

local GoodsScrollView = class("GoodsScrollView", UI.ScrollView)
UI.GoodsScrollView = GoodsScrollView

-- private:
local DEBUG = true
local DEBUG_DRAW = true

-- 尺寸
local COM_WIDTH = 406
local COM_HEIGHT = 372
-- 背包资源
local COM_RES_LIST = nil

-- 动画名字
local ANIMATION_LOOP_NAME = "animation"

-- 构造函数
function GoodsScrollView:ctor()
    GoodsScrollView.super.ctor(self, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    -- 删除的动画
    self._destroyGoodsAnimation = nil
    -- 选择放回背包的动画
    self._putBackGoodsAnimation = nil
end

-- 析构函数
function GoodsScrollView:dtor()
    GoodsScrollView.super.dtor(self)
end

-- 禁止滚动
function GoodsScrollView:disableScrolling()
    self._innerNode:setSwallowTouches(true)
end

-- 启用滚动
function GoodsScrollView:enableScrolling()
    self._innerNode:setSwallowTouches(false)
end
