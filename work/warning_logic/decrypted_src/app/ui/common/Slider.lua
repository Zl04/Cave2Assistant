--[[
    UI - 滑块控件
]]--

require "app.ui.Component"

UI = UI or {}

local Slider = class("Slider", UI.HWBtnComponent)
UI.Slider = Slider

-- 滚动模式
UI.SliderType = {
    VERTICAL = 1,   -- 垂直滚动
    HORIZONTAL = 2  -- 横向滚动
}

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 更新滑块组件位置
local function updateSliderComPosition(self)
    if (self._sliderCom) then
        local sliderWidth, sliderHeight = self._sliderCom:getSize()

        if (self._sliderType == UI.SliderType.VERTICAL) then
            local up = (self._height - sliderHeight) * self._percent
            self._sliderCom:centerUp(up)
        elseif (self._sliderType == UI.SliderType.HORIZONTAL) then
            local left = (self._width - sliderWidth) * self._percent
            self._sliderCom:centerLeft(left)
        else 
            assert(false)
        end
    end
end

-- 构造函数
function Slider:ctor()
    Slider.super.ctor(self, UIType.SLIDER, nil, 0, 0)

    -- 滑动类型
    self._sliderType = UI.SliderType.VERTICAL
    -- 滑动比例
    self._percent = 0.0

    -- 背景图片
    self._bg = nil
    -- 滑块组件
    self._sliderCom = nil
end

-- 析构函数
function Slider:dtor()
    self._bg = nil
    self._sliderCom = nil

    Slider.super.dtor(self)
end

-- public:
-- 初始化
function Slider:init(sliderCom, bgSpriteName)
    assert(type(sliderCom) == "userdata", "Slider init: slider component is invalid.")
    if (bgSpriteName) then assert(type(bgSpriteName) == "string", "Slider init: bg sprite name is invalid.") end

    Slider.super.init(self, sliderCom, bgSpriteName)
end

-- 初始化视图
function Slider:onInitView(sliderCom, bgSpriteName)
    if (bgSpriteName) then
        self._bg = cc.Sprite:create()
        self._bg:setSpriteFrame(bgSpriteName)
        self:addChild(self._bg, 1)
    end

    self._sliderCom = sliderCom
    self:addChild(self._sliderCom, 2)
end

-- 更新视图
function Slider:onUpdateView()
    if (self._bg) then
        self._bg:setPosition(self._hw, self._hh)
    end

    updateSliderComPosition(self)
end

-- 设置欢动百分比
function Slider:setPercent(percent)
    if not (type(percent) == "number" and percent >= 0.0 and percent <= 1.0)  then
        -- print("Slider:setPercent  percent=", percent)
        if(type(percent) ~= "number") then
            printError("Slider setSliderCom: slider percent must be number.")
        end
    end

    if(percent == nil) then 
        percent = 0.0
    end
    if(percent < 0) then percent = 0 end 
    if(percent > 1.0) then  percent = 1 end

    self._percent = percent
    if (self:getParent()) then
        updateSliderComPosition(self)
    end
end

-- 设置滑块组件尺寸
function Slider:setSliderComSize(width, height)
    assert(type(width) == "number" and width >= 0.0, "Slider setSliderComSize: width is invalid.")
    assert(type(height) == "number" and height >= 0.0, "Slider setSliderComSize: height is invalid.")

    if (self._sliderCom) then 
        self._sliderCom:setSize(width, height)
        self._sliderCom:updateView()
    else 
        assert(false)
    end
end

-- 显示滑块
function Slider:showSliderCom()
    if (self._sliderCom) then self._sliderCom:show()
    else assert(false)
    end
end

-- 隐藏滑块
function Slider:hideSliderCom()
    if (self._sliderCom) then self._sliderCom:hide()
    else assert(false)
    end
end