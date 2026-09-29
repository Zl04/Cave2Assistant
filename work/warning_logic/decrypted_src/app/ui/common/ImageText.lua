--[[
    UI - 属性  值
]]--

require "app.ui.Component"
-- require "app.ui.common.Image"
UI = UI or {}

local ImageText = class("ImageText", UI.HWBtnComponent)
UI.ImageText = ImageText

-- private:
local DEBUG = false

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0
local TEXE_WIDTH = 100
local TEXE_HEIGHT = 22 

-- 构造函数
function ImageText:ctor()

    ImageText.super.ctor(self, UIType.IMAGETEXT, PROGRESS_TIMER_RES_LIST, COM_WIDTH ,COM_HEIGHT)

    self._sprite   = nil 
    self._value    = nil  
    
    self._spriteName = nil
    self._text = nil
    self._fontName = nil
    self._fontSize = nil
    
    --与父类中的命名分开，一改，本身组建变化，组件里面的组件也发生变化
    self._leftSpace = 0
    self._textSpace = 0

end

-- 析构函数
function ImageText:dtor()

    self._sprite   = nil 
    self._value    = nil  

    self._spriteName = nil
    self._text = nil
    self._fontName = nil
    self._fontSize = nil

    ImageText.super.dtor(self)
end

-- public:
-- 初始化
function ImageText:init(spriteName, text, fontName, fontSize)

    if (spriteName) then assert(type(spriteName) == "string", "ImageText init: spriteName is invalid.") end
    if (text) then assert(type(text) == "string", "Text init: ImageText is invalid.") end
    if (fontName) then assert(type(fontName) == "string", "ImageText init: font name is invalid.") end
    if (fontSize) then assert(type(fontSize) == "number", "ImageText init: font size is invalid.") end
    
    self._spriteName = spriteName
    self._text = text or ""
    self._fontName = fontName or UI.FONT_STANDARD
    self._fontSize = fontSize or UI.FONT_SIZE_18PX

    ImageText.super.init(self)

end

-- 初始化视图
function ImageText:onInitView()
    
    self._sprite = UI.Image:create()
    self._sprite:init(self._spriteName)
    self._sprite:centerLeft(self._leftSpace)
    self:addChild(self._sprite)

    self._value = UI.Text:create()
    self._value:init(self._text,self._fontName,self._fontSize, UI.FONT_COLOR_41_41_45)
    -- self._value:setSize(TEXE_WIDTH,TEXE_HEIGHT)
    self._textSpace =  self._sprite._width + 2 

    self._value:centerLeft(self._textSpace)
    self:addChild(self._value)
    -- self._textSpace = self._sprite._width + 5 

end

-- 设置图片名字
function ImageText:setSpriteName(spriteName)
    assert(type(spriteName) == "string", "ImageText setSpriteName: sprite name is invalid.")

    self._spriteName = spriteName
    if (self._sprite) then
        self._sprite:setSpriteFrame(spriteName)
    end
end

-- 更新视图
function ImageText:onUpdateView()

    self._sprite:centerLeft(self._leftSpace)
    self._value:centerLeft(self._textSpace)

end

-- 设置value 文本
function ImageText:setText(value)

   self._value:setText(value)
   self._value:updateView()
end

function ImageText:setTextFixLineWidth(fixWidth)
   self._value:setFixLineWidth(fixWidth)
   self._value:updateView()
end

-- 设置value  颜色值
function ImageText:setFontColor(fontColor)

    -- assert(type(fontColor) == "table", "ImageText setFontColor: font color is invalid")
    self._value:setFontColor(fontColor)
    
end

-- 设置 第一居左，  第二个居左
function ImageText:setFrameSpace(value1,value2)

   assert(type(value1) == "number", "[ERROR] ImageText setTextSpace: value is invalid.")
   if (value2) then assert(type(value2) == "number", "Text init: font size is invalid.") self._textSpace = value2 else self._textSpace = value1 end
   self._leftSpace =  value1
 
end

-- 将字符串，每三个用逗号隔开
function ImageText:numformat(text)
    -- body
    return self._value:numformat(text)
end

function ImageText:getSpriteWidth()
    if(self._sprite) then 
        return self._sprite._width
    end

    return 0
end














