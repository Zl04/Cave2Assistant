--[[
    UI - 属性  值
]]--

require "app.ui.Component"

UI = UI or {}

local TextValue = class("TextValue", UI.HWBtnComponent)
UI.TextValue = TextValue

-- private:
local DEBUG = false

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0

-- 构造函数
function TextValue:ctor()

    TextValue.super.ctor(self, UIType.TEXTVALUE, PROGRESS_TIMER_RES_LIST, COM_WIDTH, COM_HEIGHT)

    self._value1   = nil 
    self._value2   = nil  

    self._text = nil
    self._fontName = nil
    self._fontSize = nil

    self._vtext = nil
    self._vfontName = nil
    self._vfontSize = nil

    -- self._left = 0
    -- self._right = 0
    self._leftSpace = 0
    self._rightSpace = 0

end

-- 析构函数
function TextValue:dtor()

    self._text = nil
    self._fontName = nil
    self._fontSize = nil

    self._vtext = nil
    self._vfontName = nil
    self._vfontSize = nil

    self._value1   = nil 
    self._value2   = nil 

    TextValue.super.dtor(self)
end

-- public:
-- 初始化
function TextValue:init(text, fontName, fontSize,vtext, vfontName, vfontSize)

    if (text) then assert(type(text) == "string", "Text init: text is invalid.") end
    if (fontName) then assert(type(fontName) == "string", "Text init: font name is invalid.") end
    if (fontSize) then assert(type(fontSize) == "number", "Text init: font size is invalid.") end
    
    if (vtext) then assert(type(vtext) == "string", "Text init: text is invalid.") end
    if (vfontName) then assert(type(vfontName) == "string", "Text init: font name is invalid.") end
    if (vfontSize) then assert(type(vfontSize) == "number", "Text init: font size is invalid.") end

    self._text = text or ""
    self._fontName = fontName or UI.FONT_BOLD
    self._fontSize = fontSize or UI.FONT_SIZE_16PX
    
    self._vtext = vtext or ""
    self._vfontName = vfontName or UI.FONT_STANDARD
    self._vfontSize = vfontSize or UI.FONT_SIZE_16PX

    TextValue.super.init(self)

end

function TextValue:alignmentBothEnds()
    self._alignmentBothEnds = true
end

-- 初始化视图
function TextValue:onInitView()
    self._value1 = UI.Text:create()
    self._value1:init(self._text,self._fontName,self._fontSize, UI.FONT_COLOR_91_47_7)
    self:addChild(self._value1)

    self._value2   = UI.Text:create()
    self._value2:init(self._vtext,self._vfontName,self._vfontSize, UI.FONT_COLOR_41_41_45)
    -- self._value2:setTextLeft()
    self:addChild(self._value2)

end

-- 更新视图
function TextValue:onUpdateView()
    if self._alignmentBothEnds then
        self._value1:centerLeft(self._leftSpace)
        self._value2:centerRight(self._rightSpace)
    else
        self._value1:centerLeft(self._leftSpace)
        self._value2:center(self._rightSpace)
    end
end

-- 设置value 文本
function TextValue:setText(value)
    if self._alignmentBothEnds then
        self._value2:setText(value)
        self._value2:onUpdateView()
    else
        self._value2:setText(value)
        self._value2:setSize(140,22)
        self._value2:setTextLeft()
        self._value2:onUpdateView()
    end
end

-- 设置value  颜色值
function TextValue:setTextFontColor(fontColor)

   self._value1:setFontColor(fontColor)

end

-- 设置value  颜色值
function TextValue:setFontColor(fontColor)

   self._value2:setFontColor(fontColor)

end

-- 设置 两个text的间距
function TextValue:setTextSpace(value)

    assert(type(value) == "number", "[ERROR] TextValue setTextSpace: value is invalid.")
    self._value1:centerRight(value/2+self._hw)
    self._value2:centerLeft(value/2+self._hw)

end

-- 设置 第一text居左，  第二个居右
function TextValue:setFrameSpace(value1,value2)

   assert(type(value1) == "number", "[ERROR] TextValue setTextSpace: value is invalid.")
   if (value2) then assert(type(value2) == "number", "Text init: font size is invalid.") self._rightSpace = value2 else self._rightSpace = value1 end
   self._leftSpace =  value1
 
end

function TextValue:numformat(text)
    -- body
    -- assert(type(text) == "string", "Text setText: text is invalid.")
    
   return self._value2:numformat(text)
end















