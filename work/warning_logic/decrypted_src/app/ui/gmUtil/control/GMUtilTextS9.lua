--[[
    文字加Scale9Sprite背景 2017/11/30
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.common.Text"

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local TextS9 = class("TextS9", UI.Text)
UI.TextS9 = TextS9

---------------------------------------
-- eo 模块初始化 --








-- 资源统合 --
---------------------------------------

---------------------------------------
-- eo 资源统合 --









-- 布局 --
---------------------------------------
-- -- 设计尺寸
-- -- 引用GMUtil公用设置, GMUtilConfig
-- GMUtilConfig.LAYOUT_DESIGN_WIDTH = 1024
-- GMUtilConfig.LAYOUT_DESIGN_HEIGHT = 640
-- GMUtilConfig.LAYOUT_TAB_CONTENT_HEIGHT = 568

-- -- 大大大大行行高
-- GMUtilConfig.LAYOUT_H_XXXLARGE_70 = 70
-- -- 大大大行行高
-- GMUtilConfig.LAYOUT_H_XXLARGE_60 = 60
-- -- 大大行行高
-- GMUtilConfig.LAYOUT_H_XLARGE_50 = 50
-- -- 大行行高
-- GMUtilConfig.LAYOUT_H_LARGE_40 = 40
-- -- 中行行高
-- GMUtilConfig.LAYOUT_H_MEDIUM_30 = 30
-- -- 小行行高
-- GMUtilConfig.LAYOUT_H_SMALL_20 = 20

-- 组件z序 --
---------------------
---------------------------------------
-- eo 整体布局 --











-- 程序逻辑 --
---------------------------------------
-- 设置尺寸
function TextS9:setSize(width, height)
    if (width) then assert(type(width) == "number" and width >= 0, "Text setSize: width is invalid.") end
    if (height) then assert(type(height) == "number" and height >= 0, "Text setSize: height is invalid.") end
    TextS9.super.super.setSize(self, width, height)
    -- 修正setDimensions（） 导致的文字向下偏移， 故使用setContentSize
    self._label:setContentSize(width, height)

    self._autoAdaption = false
end

function TextS9:setPaddings(left, right, top, bottom)
    self._leftPadding = left
    self._rightPadding = right
    self._topPadding = top
    self._bottomPadding = bottom
    self:updateView()
end

function TextS9:updatePaddings()
    local textSize = self._label:getContentSize()
    local paddedHeight = textSize.height + self._topPadding + self._bottomPadding
    local paddedWidth = textSize.width + self._leftPadding + self._rightPadding
    TextS9.super.super.setSize(self, paddedWidth, paddedHeight)
    self._label:setPosition(
        self._leftPadding + textSize.width / 2, self._bottomPadding + textSize.height / 2)
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
function TextS9:ctor()
    TextS9.super.ctor(self)
    self._leftPadding = 0
    self._rightPadding = 0
    self._topPadding = 0
    self._bottomPadding = 0

    self._bg = nil
end

-- 初始化
function TextS9:init(text, fontName, fontSize, fontColor, bgName)
    TextS9.super.init(self, text, fontName, fontSize, fontColor)

    if (bgName) then 
        self._bg = cc.Scale9Sprite:createWithSpriteFrameName(bgName) 
        self:addChild(self._bg, -1)
    end
end


-- 析构函数
function TextS9:dtor()
    TextS9.super.dtor(self)

end

-- 初始化视图
function TextS9:onInitView()
    TextS9.super.onInitView(self)
end

function TextS9:onUpdateView()
    TextS9.super.onUpdateView(self)

    if (self._autoAdaption) then
        self:updatePaddings()
    end

    if (self._bg) then
        self._bg:setPosition(self._hw, self._hh)
        self._bg:setContentSize(self._width, self._height)
    end
end
---------------------------------------
-- eo 生命周期 --












-- 事件处理 --
---------------------------------------

function TextS9:onSizeChange()
end

---------------------------------------
-- eo 事件处理 --