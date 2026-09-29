--[[
    UI - 输入框
]]--

require "app.ui.Component"

UI = UI or {}

local EditBox = class("EditBox", UI.HWBtnComponent)
UI.EditBox = EditBox

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 将归一化的颜色转换成字节表示
local function covertColor(color)
    local bcolor = {}
    bcolor.r = color.r * 255
    bcolor.g = color.g * 255
    bcolor.b = color.b * 255
    bcolor.a = color.a * 255

    return bcolor
end

-- 构造函数
function EditBox:ctor(width, height)
    if (width) then assert(type(width) == "number" and width >= 0, "EditBox constructor: width is invalid.") end
    if (height) then assert(type(height) == "number" and width >= 0, "EditBox constructor: height is invalid.") end

    EditBox.super.ctor(self, UIType.EDITBOX, nil, width, height)

    self._widthOffset = 0
    self._heightOffset = 0

    self._editBox = nil
    self._bg = nil

    self._returnCallback = nil
end

-- 析构函数
function EditBox:dtor()
    self._editBox = nil
    self._bg = nil

    EditBox.super.dtor(self)
end

-- public:
-- 初始化
function EditBox:init(placeHolder, inputModel, bgSpriteName, widthOffset, heightOffset)
    if (placeHolder) then assert(type(placeHolder) == "string", "EditBox init: placeHolder is invalid.") end
    if (inputModel) then assert(type(inputModel) == "number", "EditBox init: inputModel is invalid.") end
    if (bgSpriteName) then assert(type(bgSpriteName) == "string", "EditBox init: bgSpriteName is invalid.") end

    self._placeHolder = placeHolder or nil
    self._inputModel = inputModel or cc.EDITBOX_INPUT_MODE_ANY
    self._bgSpriteName = bgSpriteName or nil
    self._widthOffset = widthOffset or 0
    self._heightOffset = heightOffset or 0

    EditBox.super.init(self)
end

-- 初始化视图
function EditBox:onInitView()
    -- 背景
    if (self._bgSpriteName) then
        self._bg = cc.Scale9Sprite:createWithSpriteFrameName(self._bgSpriteName)
        self:addChild(self._bg, 1)
    end

    -- 文字
    self:replaceEditBoxWithRecalculated()
end

-- 更新视图
function EditBox:onUpdateView()
    -- 设置输入框位置大小， 或者根据输入框大小改变容器大小
    self:replaceEditBoxWithRecalculated()

    -- 设置背景位置大小
    if (self._bg) then
        self._bg:setPosition(self._hw, self._hh)
        self._bg:setContentSize(self._width, self._height)
    end
end

-- 设置尺寸
function EditBox:setSize(width, height)
    if (width) then assert(type(width) == "number" and width >= 0, "EditBox setSize: width is invalid.") end
    if (height) then assert(type(height) == "number" and height >= 0, "EditBox setSize: height is invalid.") end

    EditBox.super.setSize(self, width, height)
end

-- 设置内部编辑栏不能阻止显示出框， 用替换才行， FIXME： EditBox BUG？
function EditBox:replaceEditBoxWithRecalculated()
    -- 计算参数
    local oldSize = self._editBox and self._editBox:getSize() or {width = 0, height = 0}
    local newWidth = self._width - self._widthOffset
    local newHeight = self._height - self._heightOffset
    if (newWidth == oldSize.width and newHeight == oldSize.height) then return end

    -- 更新编辑栏
    if (self._editBox) then self:removeChild(self._editBox) end
    self._editBox = cc.EditBox:create(cc.size(newWidth, newHeight), "IntentiallyInvalidFileName")
    if(self._placeHolder) then self._editBox:setPlaceHolder(self._placeHolder) end
    self._editBox:setInputMode(self._inputModel)
    self._editBox:setAnchorPoint(0.5, 0.5)
    self._editBox:setPosition(self._hw, self._hh)
    self._editBox:registerScriptEditBoxHandler(handler(self, self.eventListener))
    self:addChild(self._editBox, 2)

    if (self._maxLength) then
        self._editBox:setMaxLength(self._maxLength)
    end
end

-- 设置输入框宽度间距
function EditBox:setWidthOffset(wo)
    self._widthOffset = wo
end

-- 设置输入框高度间距
function EditBox:setHeightOffset(ho)
    self._heightOffset = ho
end

-- 获取输入数字
function EditBox:getText()
    return self._editBox:getText()
end

-- 设置文本内容
function EditBox:setText(textStr)
    self._editBox:setText(textStr)
end

-- 获取占位信息
function EditBox:getPlaceHolder()
    return self._placeHolder
end

-- 回车回调
function EditBox:setReturnCallback(func)
    self._returnCallback = func
end

-- 文字改变处理
function EditBox:setChangeCallback(func)
    self._changeCallback = func
end

-- 设置回调
function EditBox:eventListener(eventType)
    if eventType == "began" then
        if (self._editBeganCallback) then self._editBeganCallback() end
    elseif eventType == "ended" then
        if (self._editEndedCallback) then self._editEndedCallback() end
    elseif eventType == "changed" then
        if (self._changeCallback) then self._changeCallback(self:getText()) end
    elseif eventType == "return" then
        if (self._returnCallback) then self._returnCallback(self:getText()) end
    end
end

function EditBox:setFontColor(color)
    if(self._editBox) then
        self._editBox:setFontColor(color)
    end
end

function EditBox:setFontSize(fontSize)
    if(self._editBox) then
        self._editBox:setFontSize(fontSize)
    end
end

function EditBox:setPlaceholderFontSize(fontSize)
    if(self._editBox) then
        self._editBox:setPlaceholderFontSize(fontSize)
    end
end

function EditBox:setPlaceHolder(str)
    if(self._editBox) then
        self._editBox:setPlaceHolder(str)
    end
end

function EditBox:setPlaceholderFontColor(color)
    if(self._editBox) then
        self._editBox:setPlaceholderFontColor(color)
    end
end

function EditBox:openKeyboard()
    if (self._editBox) then
        self._editBox:openKeyboard()
    end
end

function EditBox:closeKeyboard()
    if (self._editBox) then
        self._editBox:closeKeyboard()
    end
end

function EditBox:setVerticalAlignment(a)
    if (self._editBox) then
        self._editBox:setVerticalAlignment(a)
    end
end

function EditBox:setEditBeganCallback(cb)
    self._editBeganCallback = cb
end

function EditBox:setEditEndedCallback(cb)
    self._editEndedCallback = cb
end

function EditBox:setMaxLength(l)
    self._maxLength = l
    if (self._editBox) then
        self._editBox:setMaxLength(l)
    end
end