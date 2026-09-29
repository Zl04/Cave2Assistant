--[[
    UI - 文本
]]--

local LanguageManager = require("app.game.LanguageManager")

require "app.ui.Component"

UI = UI or {}

local Text = class("Text", UI.HWBtnComponent)
UI.Text = Text

-- 文本对齐
UI.TextHAlignment ={
    LEFT = 0,
    CENTER = 1,
    RIGHT = 2
}
UI.TextVAlignment = {
    TOP = 0,
    CENTER = 1,
    BOTTOM = 2
}

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
function Text:ctor(text, fontName, fontSize, fontColor)
    Text.super.ctor(self, UIType.TEXT, nil)

    -- 文本对齐方式
    self._hAlignment = UI.TextHAlignment.LEFT
    self._vAlignment = UI.TextVAlignment.TOP
    -- 文本控件
    self._label = nil
    -- 尺寸是否自动适应文本大小
    self._autoAdaption = true
    self.showUnderLine = false

    self._text = ""
    self._languageId = -1
    self._fontName = UI.FONT_STANDARD
    self._fontSize = UI.FONT_SIZE_16PX
    self._fontColor = {r = 255, g = 255, b = 255}
    self._outlineColor = {r = 0, g = 0, b = 0}
    self._outlineSize = 0
    self._reflectDimensions = cc.p(0, 0)
    self._fixLineWidth = 0
    self._labelWidth = 0
    self._lineSpacing = 0
    self._fontNameReflect = "UI.FONT_STANDARD"

end

-- 析构函数
function Text:dtor()
    Text.super.dtor(self)
end

-- public:
-- 初始化
function Text:init(text, fontName, fontSize, fontColor)
    if (text) then assert(type(text) == "string", "Text init: text is invalid.") end
    if (fontName) then assert(type(fontName) == "string", "Text init: font name is invalid.") end
    if (fontSize) then assert(type(fontSize) == "number", "Text init: font size is invalid.") end
    if (fontColor) then assert(type(fontColor) == "table", "Text init: font color is invalid") end

    self._text = text or ""
    self._fontName = fontName or UI.FONT_STANDARD
    if(self._fontName == UI.FONT_BOLD) then 
        self._isBold = true
        self._fontName = UI.FONT_STANDARD
    else 
        self._isBold = false
    end

    self._fontSize = fontSize or UI.FONT_SIZE_16PX
    self._fontColor = fontColor or {r = 255, g = 255, b = 255}

    Text.super.init(self)
end

function Text:initWithLanguageId(id, fontName, fontSize, fontColor)
    local text = LanguageManager:getInstance():getLocalString(id)
    self:init(text, fontName, fontSize, fontColor)
end

-- 设置字体名字
function Text:setFontName(fontName)
    assert(type(fontName) == "string", "Button setFontName: font name is invalid.")

    self._fontName = fontName
    if(self._fontName == UI.FONT_BOLD) then 
        self._isBold = true
        self._fontName = UI.FONT_STANDARD
    else 
        self._isBold = false
        if(self._shadowLabel) then 
            self._shadowLabel:removeFromParent()
            self._shadowLabel = nil
        end
    end
    if (self:isTTFFont()) then
        local ttfConfig = self:getTTFConfig()
        self._label:setTTFConfig(ttfConfig)
    else 
        self._label:setSystemFontName(fontName)
    end
    
    if(self._isBold) then 
        self._label:enableBold()
    end
end

-- 设置字体大小
function Text:setFontSize(fontSize)
    assert(type(fontSize) == "number", "Button setFontSize: font size is invalid.")

    self._fontSize = fontSize
    if (self:isTTFFont()) then
        local ttfConfig = self:getTTFConfig()
        self._label:setTTFConfig(ttfConfig)
    else
        self._label:setSystemFontSize(fontSize)
    end
end

function Text:getFontSize()
    return self._fontSize
end

-- 设置label的宽度大小
function Text:setWidth(widthSize)
    assert(type(widthSize) == "number", "Button setFontSize: font size is invalid.")
    self._labelWidth = widthSize
    self._label:setWidth(widthSize)
    if(self._shadowLabel) then 
        self._shadowLabel:setWidth(widthSize)
    end
end

-- 设置字体颜色
function Text:setFontColor(...)
    -- assert(type(fontColor) == "table", "Text init: font color is invalid")

    local t = {...}
    if (#t == 1 and type(t[1]) == "table") then
        self._fontColor = t[1]
    elseif (#t == 4) then
        self._fontColor = {
            r = r, 
            g = g, 
            b = b,
            a = a or 255
        }
    else 
        assert(false, "Text setFontColor: params are invalid.")
    end
    self._label:setTextColor(self._fontColor)
end

-- 设置字体描边
function Text:setOutline(outlineColor, outlineSize)
    self._outlineColor = outlineColor or {r = 0, g = 0, b = 0}
    self._outlineSize = outlineSize or 2

    if (self._label and self._outlineSize >= 1) then
        self._label:enableOutline(self._outlineColor, self._outlineSize)
    end
end

-- 设置字体下划线
function Text:setUnderline(enable)
    enable = enable or true
    self.showUnderLine = enable
    if self._label and enable then
        self._label:enableUnderline()
    end
end

-- 设置字体内容
function Text:setText(text)
    if not (type(text) == "string" or type(text) == "number") then
        printError("Text setText: text is invalid.")
        text = "..."
    end
    
    if type(text) == "number" then
        text = string.format("%s", text)
    end
    self._text = text    
    self._label:setString(text)
    if(self._shadowLabel) then 
        self._shadowLabel:setString(text)
    end

    if (self._autoAdaption) then
        local size = self._label:getContentSize()
        Text.super.setSize(self, size.width, size.height)
    end
    self:setFixLineWidth(self._fixLineWidth);
end

-- 设置字体内容
function Text:setTextById(id)
    if id ~= nil then
        local text = LanguageManager:getInstance():getLocalString(id)
        self:setText(text);
    end
end


function Text:getText()
    if self._label then
        return self._label:getString()
    end
end

-- 检测是ttf字体还是系统字体
function Text:isTTFFont()
    if (self._fontName) then
        local startPos = string.find(self._fontName, "%.ttf")
        if (startPos ~= nil) then return true end
    end
    return false
end

-- 初始化视图
function Text:onInitView()
    if (self._fontName) then
        local isTTFFont = self:isTTFFont()
        if (isTTFFont) then 
            self._label = cc.Label:create()
            self._label:initWithTTF(self:getTTFConfig(), self._text)
        else
            self._label = cc.Label:createWithSystemFont(self._text, self._fontName, self._fontSize)
        end
        if(self._isBold == true) then 
            self._label:enableBold()
        end

        self._label:setTextColor(self._fontColor)
        if (self._outlineSize >= 1) then
            self._label:enableOutline(self._outlineColor, self._outlineSize)
        end
        if self.showUnderLine then
            self._label:enableUnderline()
        end
        self:addChild(self._label)

        if (self._autoAdaption) then
            local size = self._label:getContentSize()
            Text.super.setSize(self, size.width, size.height)
        end
    end
end

-- 自动调节尺寸
function Text:autoAdapt()
    self._autoAdaption = true
    if (self._label) then
        local size = self._label:getContentSize()
        Text.super.setSize(self, size.width, size.height)
    end
end

-- 更新视图
function Text:onUpdateView()
    -- if (self._autoAdaption) then
    --     local size = self._label:getContentSize()
    --     Text.super.setSize(self, size.width, size.height)
    -- end

    -- local posX, posY = self._width / 2, self._height/ 2
    -- self._label:setPosition(posX, posY)
    -- self:setTextAlignment(self._hAlignment, self._vAlignment)
end

-- 获取字体的配置
function Text:getTTFConfig()
    local ttfConfig = {
        fontFilePath = self._fontName,
        fontSize = self._fontSize,
        bold = false,
        outlineSize = self._outlineSize,
        glyphs = 1,
        customGlyphs = "",
        distanceFieldEnabled = false
    }

    return ttfConfig
end

function Text:getContentSize() 
    if(self._label) then
        return self._label:getContentSize()
    end

    return {width = 0, height = 0}
end

-- 设置尺寸
function Text:setSize(width, height, needDemision)
    if (width) then assert(type(width) == "number" and width >= 0, "Text setSize: width is invalid.") end
    if (height) then assert(type(height) == "number" and height >= 0, "Text setSize: height is invalid.") end

    Text.super.setSize(self, width, height)
    if needDemision == nil then
        needDemision = true
    end
    if needDemision then
        self._label:setDimensions(width, height)
    end

    self._autoAdaption = false
end

-- 设置尺寸
function Text:setDimensions(width, height)
    if (width) then assert(type(width) == "number" and width >= 0, "Text setSize: width is invalid.") end
    if (height) then assert(type(height) == "number" and height >= 0, "Text setSize: height is invalid.") end

    self._label:setDimensions(width, height)
    self:autoAdapt()
end

-- 返回带逗号的数值
function Text:numformat(text)
    -- body
    assert(type(text) == "string", "Text setText: text is invalid.")
    
    local strLen = string.len(text)  
    local strtable = {}  

    -- add by zp 修复 CO-7953
    local isminus = false
    if(tonumber(text) ~= nil) then 
        if tonumber(text) < 0 then 
            text = tostring(-tonumber(text))
            isminus = true
            text = string.sub(text, 1, strLen)
            strLen = string.len(text)
        end
    end

     while strLen >= 3 do

       table.insert(strtable,1,string.sub(text,strLen-2,strLen))
       strLen = strLen-3
       
     end

     if strLen ~= 0 then 

         table.insert(strtable,1,string.sub(text,1,strLen))
     end

    if(isminus) then 
        return  "-"..table.concat(strtable,",")
    else
        return  table.concat(strtable,",")
    end
end

-- 文本横向居中
function Text:setTextHorizontalCenter()
    self._hAlignment = UI.TextHAlignment.CENTER
    self:setTextAlignment(self._hAlignment, self._vAlignment)
end

-- 文本横向居中
function Text:setTextHorizontalCenterAndBottom()
    self._hAlignment = UI.TextHAlignment.CENTER
    self._vAlignment = UI.TextVAlignment.BOTTOM
    self:setTextAlignment(self._hAlignment, self._vAlignment)
end

-- 文本纵向居中
function Text:setTextVerticalCenter()
    self._vAlignment = UI.TextVAlignment.CENTER
    self:setTextAlignment(self._hAlignment, self._vAlignment)
end

function Text:setTextVerticalCenterAndHLeft()
    self._vAlignment = UI.TextVAlignment.CENTER
    self._hAlignment = cc.TEXT_ALIGNMENT_LEFT
    self:setTextAlignment(self._hAlignment, self._vAlignment)
end

-- function Text:setLineHeight(lingHeight)
--     if(self._label) then
--         self._label:setLineHeight(lingHeight)
--     end
-- end

-- 文本整体居中
function Text:setTextCenter()
    self._hAlignment = UI.TextHAlignment.CENTER
    self._vAlignment = UI.TextVAlignment.CENTER
    self:setTextAlignment(self._hAlignment, self._vAlignment)
end

-- 文本左对齐
function Text:setTextLeft()
    self._hAlignment = UI.TextHAlignment.LEFT
    self._vAlignment = UI.TextVAlignment.CENTER
    self:setTextAlignment(self._hAlignment, self._vAlignment)
end
-- 文本右对齐
function Text:setTextRight()
    self._hAlignment = UI.TextHAlignment.RIGHT
    self._vAlignment = UI.TextVAlignment.CENTER
    self:setTextAlignment(self._hAlignment, self._vAlignment)
end

-- 文本右对齐
function Text:setTextRightUp()
    self._hAlignment = UI.TextHAlignment.RIGHT
    self._vAlignment = UI.TextVAlignment.TOP
    self:setTextAlignment(self._hAlignment, self._vAlignment)
end

function Text:setTextLeftUp()
    self._hAlignment = UI.TextHAlignment.LEFT
    self._vAlignment = UI.TextVAlignment.TOP
    self:setTextAlignment(self._hAlignment, self._vAlignment)
end

function Text:setTextLeftBottom()
    self._hAlignment = UI.TextHAlignment.LEFT
    self._vAlignment = UI.TextVAlignment.BOTTOM
    self:setTextAlignment(self._hAlignment, self._vAlignment)
end

function Text:onSizeChanged(originalWidth, originalHeight)
    -- local posX, posY = self._width / 2, self._height/ 2
    self._label:setPosition(self._hw, self._hh)
    if(self._shadowLabel) then 
        self._shadowLabel:setPosition(self._hw + self._shadowSize.width, self._hh + self._shadowSize.height)
    end 
end

function Text:setLineSpacing(space)
    self._lineSpacing = space
    self._label:setLineSpacing(space)
    if(self._shadowLabel) then 
        self._shadowLabel:setLineSpacing(space)
    end
end

function Text:getLineSpacing()
    return self._label:getLineSpacing()
end

function Text:setLineBreakWithoutSpace(b)
    self._label:setLineBreakWithoutSpace(b)
end

function Text:setTextAlignment(h, v)
    self._hAlignment = h
    self._vAlignment = v
    self._label:setAlignment(self._hAlignment, self._vAlignment)
    if(self._shadowLabel) then 
        self._shadowLabel:setAlignment(self._hAlignment, self._vAlignment)
    end
end

function Text:enableShadow(color, offset)
    self._shadowSize = offset
    if (self._isBold) then 
        local isTTFFont = self:isTTFFont()
        if (isTTFFont) then 
            self._shadowLabel = cc.Label:create()
            self._shadowLabel:initWithTTF(self:getTTFConfig(), self._text)
        else
            self._shadowLabel = cc.Label:createWithSystemFont(self._text, self._fontName, self._fontSize)
        end
        
        self:addChild(self._shadowLabel,-1)
        if(self._isBold == true) then 
            self._shadowLabel:enableBold()
        end
        if(self._fixLineWidth ~= 0) then 
            self._shadowLabel:setFixLineWidth(self._fixLineWidth)
        end
        if(self._labelWidth ~= 0) then 
            self._shadowLabel:setWidth(self._labelWidth)
        end
        if(self._shadowLabel) then 
            self._shadowLabel:setAlignment(self._hAlignment, self._vAlignment)
        end
        if(self._lineSpacing ~= 0) then 
            self._shadowLabel:setLineSpacing(self._lineSpacing)
        end

        self._shadowLabel:setTextColor(color)
        self._shadowLabel:setPosition(self._hw + self._shadowSize.width, self._hh + self._shadowSize.height)
    else
        self._label:enableShadow(color, offset)
    end
end

-- 阴影+描边
function Text:useDefaultOutLineShadowStyle(color)
    local shadowColor = color or cc.c4b(0, 0, 0, 255)
    if self._fontSize >= 20 then
        self:enableShadow(shadowColor, cc.size(0, -2))
        self:setOutline(shadowColor, 2)
    else
        self:enableShadow(shadowColor, cc.size(0, -1))
        self:setOutline(shadowColor, 1)
    end
end

-- 只有阴影
function Text:useDefaultShadowOnlyStype(color)
    local shadowColor = color or cc.c4b(0, 0, 0, 255)
    if self._fontSize >= 20 then
        self:enableShadow(shadowColor, cc.size(0, -2))
    else
        self:enableShadow(shadowColor, cc.size(0, -1))
    end
end

-- 设置自动换行
function Text:enableWrap(b)
    if (self._label) then
        self._label:enableWrap(b)
    end
end

function Text:setFixLineWidth(width)
    self._fixLineWidth = width
    if (self._label and self._fixLineWidth > 0) then
        self._label:setFixLineWidth(width)
        if(self._shadowLabel) then 
            self._shadowLabel:setFixLineWidth(width)
        end

        local size = self._label:getContentSize()
        local scale = self._label:getScale()
        size.width = size.width * scale
        size.height = size.height * scale
        Text.super.setSize(self, size.width, size.height)
    end
end

-- 设置字间距
function Text:setAdditionalKerning(num)
    if (self._label) then
        self._label:setAdditionalKerning(num)
    end
end

function Text:disableOutline()
    self._label:disableEffect(1)
end

-- 设置固定大小
function cc.Label:setFixLineWidth(width)
    self._fixLineWidth = width
    local scale = 1
    if self._fixLineWidth ~= 0 then
        local autoScale = self._fixLineWidth / self:getContentSize().width
        if autoScale < scale then
            scale = autoScale
        end
    end
    self:setScale(scale)
end

-- 设置最大行大小
function Text:setMaxLineWidth(width)
    if(self._label) then
        self._label:setMaxLineWidth(width)
    end
end