--[[
    简装一个Scale9的按键 2017/11/29
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.Component"

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local ButtonS9 = class("ButtonS9", UI.HWBtnComponent)
UI.ButtonS9 = ButtonS9

-- 私有变量
-- local DEBUG_DRAW = true
---------------------------------------
-- eo 模块初始化 --











-- 程序逻辑 --
---------------------------------------

function ButtonS9:setTitleText(string)
    local checkString = string or ""

    self._ccButton:setTitleText(checkString)
end

function ButtonS9:setTitleFontSize(num)
    assert(type(num) == "number")
    self._ccButton:setTitleFontSize(num)
end

function ButtonS9:setTitleColor(color)
    self._ccButton:setTitleColor(cc.c3b(color))
end

function ButtonS9:setTitleFontName(string)
    assert(type(string) == "string")
    self._ccButton:setTitleFontName(string)
end

function ButtonS9:setOnClicked(func)
    self._onClickedCallback = func
end
---------------------------------------
-- eo 程序逻辑 --








-- 生命周期 --
---------------------------------------
-- 构造函数
function ButtonS9:ctor(width, height, resList)
    ButtonS9.super.ctor(self, 0, resList, width, height)
    self._onClickedCallback = nil

    self._ccButton = nil
end

-- 初始化
function ButtonS9:init(text, normal, active, disabled)
    local normalChecked = normal or ""
    local activeChecked = active or ""
    local disabledChecked = disabled or ""

    self._ccButton = ccui.Button:create(normalChecked, activeChecked, disabledChecked, 1)
    self._ccButton:setTitleText(text)

    ButtonS9.super.init(self)
end


-- 析构函数
function ButtonS9:dtor()
    ButtonS9.super.dtor(self)

end

-- 初始化视图
function ButtonS9:onInitView()
    ButtonS9.super.onInitView(self)
    -- 默认按钮属性
    self._ccButton:setScale9Enabled(true)
    self._ccButton:setAnchorPoint(cc.size(0, 0))
    self._ccButton:setPosition(0, 0)
    self._ccButton:addTouchEventListener(function(sender, event)
        if event == 0 then --begin
        elseif event == 2 then --end
            if  (self._onClickedCallback) then self._onClickedCallback(self) end
        end
    end)
    self:setTitleFontSize(self._height)
    self:setTitleColor(UI.FONT_COLOR_42_31_1)
    self:setTitleFontName(UI.FONT_ARIAL)
    self:addChild(self._ccButton);
end

-- 更新视图
function ButtonS9:onUpdateView()
    ButtonS9.super.onUpdateView(self)
    self._ccButton:setSize(self._width, self._height)
end
---------------------------------------
-- eo 生命周期 --