--[[
    UI - 格子数文本
]]--

local LanguageManager = require("app.game.LanguageManager")

require "app.ui.Component"

UI = UI or {}

local GridText = class("GridText", UI.HWBtnComponent)
UI.GridText = GridText

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
function GridText:ctor(text, fontName, fontSize, fontColor)
    GridText.super.ctor(self, UIType.TEXT, nil)

    -- 文本控件
    self._label = nil
    self._centeLabel = nil
    self._maxLabel = nil
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

    self._fontNameReflect = "UI.FONT_STANDARD"

end

-- 析构函数
function GridText:dtor()
   GridText.super.dtor(self)
end

-- public:
-- 初始化
function GridText:init(text, fontName, fontSize, fontColor)
    if (text) then assert(type(text) == "string", "Text init: text is invalid.") end
    if (fontName) then assert(type(fontName) == "string", "Text init: font name is invalid.") end
    if (fontSize) then assert(type(fontSize) == "number", "Text init: font size is invalid.") end
    if (fontColor) then assert(type(fontColor) == "table", "Text init: font color is invalid") end

    self._text = text or ""
    self._fontName = fontName or UI.FONT_STANDARD
    self._fontSize = fontSize or UI.FONT_SIZE_16PX
    self._fontColor = fontColor or {r = 255, g = 255, b = 255}

   GridText.super.init(self)
end

function GridText:initWithLanguageId(id, fontName, fontSize, fontColor)
    local text = LanguageManager:getInstance():getLocalString(id)
    self:init(text, fontName, fontSize, fontColor)
end

-- 设置字体名字
function GridText:setFontName(fontName)
    assert(type(fontName) == "string", "Button setFontName: font name is invalid.")

    self._fontName = fontName
    if (self:isTTFFont()) then
        local ttfConfig = {
            fontFilePath = self._fontName,
            fontSize = self._fontSize,
            bold = false,
            outlineSize = self._outlineSize,
            glyphs = 1,
            customGlyphs = "",
            distanceFieldEnabled = false
        }
        self._label:setTTFConfig(ttfConfig)
        self._centeLabel:setTTFConfig(ttfConfig)
        self._maxLabel:setTTFConfig(ttfConfig)
    else 
        self._label:setSystemFontName(fontName)
        self._centeLabel:setSystemFontName(fontName)
        self._maxLabel:setSystemFontName(fontName)
    end
end

-- 设置字体大小
function GridText:setFontSize(fontSize)
    assert(type(fontSize) == "number", "Button setFontSize: font size is invalid.")

    self._fontSize = fontSize
    if (self:isTTFFont()) then
        local ttfConfig = {
            fontFilePath = self._fontName,
            fontSize = self._fontSize,
            bold = false,
            outlineSize = self._outlineSize,
            glyphs = 1,
            customGlyphs = "",
            distanceFieldEnabled = false
        }
        self._label:setTTFConfig(ttfConfig)
        self._centeLabel:setTTFConfig(ttfConfig)
        self._maxLabel:setTTFConfig(ttfConfig)
    else
        self._label:setSystemFontSize(fontSize)
        self._centeLabel:setSystemFontSize(fontSize)
        self._maxLabel:setSystemFontSize(fontSize)
    end
end

function GridText:getFontSize()
    return self._fontSize
end

-- -- 设置label的宽度大小
-- function GridText:setWidth(widthSize)
--     assert(type(widthSize) == "number", "Button setFontSize: font size is invalid.")
--     -- self._label:setWidth(widthSize)
-- end

-- 设置字体颜色
function GridText:setFontColor(...)
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
    self._centeLabel:setTextColor(self._fontColor)
    self._maxLabel:setTextColor(self._fontColor)
end

-- 设置字体描边
function GridText:setOutline(outlineColor, outlineSize)
    self._outlineColor = outlineColor or {r = 0, g = 0, b = 0}
    self._outlineSize = outlineSize or 2

    if (self._label and self._outlineSize >= 1) then
        self._label:enableOutline(self._outlineColor, self._outlineSize)
        self._centeLabel:enableOutline(self._outlineColor, self._outlineSize)
        self._maxLabel:enableOutline(self._outlineColor, self._outlineSize)
    end
end

-- 设置字体下划线
function GridText:setUnderline(enable)
    enable = enable or true
    self.showUnderLine = enable
    if self._label and enable then
        self._label:enableUnderline()
        self._centeLabel:enableUnderline()
        self._maxLabel:enableUnderline()
    end
end

-- 设置字体内容
function GridText:setText(text, maxText)
    if not (type(text) == "string" or type(text) == "number") then
        printError("Text setGridText: text is invalid.")
        text = "..."
    end
    
    if type(text) == "number" then
        text = string.format("%s", text)
    end
    self._text = text  
    self._maxText = maxText  
    self._label:setString(text)
    self._centeLabel:setString("/")
    self._maxLabel:setString(maxText)

    local size = self:getContentSize()
    self._label:setPosition(cc.p(self._label:getContentSize().width/2, 3))
    self._centeLabel:setPosition(cc.p(self._label:getContentSize().width + self._centeLabel:getContentSize().width/2, 0))
    self._maxLabel:setPosition(cc.p(size.width - self._maxLabel:getContentSize().width/2, -3))

    if (self._autoAdaption) then
        
        GridText.super.setSize(self, size.width, size.height)
    end
end

-- 检测是ttf字体还是系统字体
function GridText:isTTFFont()
    if (self._fontName) then
        local startPos = string.find(self._fontName, "%.ttf")
        if (startPos ~= nil) then return true end
    end
    return false
end

-- 初始化视图
function GridText:onInitView()
    if (self._fontName) then
        local isTTFFont = self:isTTFFont()
        if (isTTFFont) then 
            local ttfConfig = {
                fontFilePath = self._fontName,
                fontSize = self._fontSize,
                bold = false,
                outlineSize = 0,
                glyphs = 1,
                customGlyphs = "",
                distanceFieldEnabled = false
            }

            self._label = cc.Label:create()
            self._centeLabel = cc.Label:create()
            self._maxLabel = cc.Label:create()

            self._label:initWithTTF(ttfConfig, self._text)
            self._centeLabel:initWithTTF(ttfConfig, "/")
            self._maxLabel:initWithTTF(ttfConfig, self._maxText)
        else
            self._label = cc.Label:createWithSystemFont(self._text, self._fontName, self._fontSize)
            self._centeLabel = cc.Label:createWithSystemFont("/", self._fontName, self._fontSize)
            self._maxLabel = cc.Label:createWithSystemFont(self._maxText, self._fontName, self._fontSize)
        end

        self._label:setTextColor(self._fontColor)
        self._centeLabel:setTextColor(self._fontColor)
        self._maxLabel:setTextColor(self._fontColor)

        if (self._outlineSize >= 1) then
            self._label:enableOutline(self._outlineColor, self._outlineSize)
            self._centeLabel:enableOutline(self._outlineColor, self._outlineSize)
            self._maxLabel:enableOutline(self._outlineColor, self._outlineSize)
        end
        if self.showUnderLine then
            self._label:enableUnderline()
            self._centeLabel:enableUnderline()
            self._maxLabel:enableUnderline()
        end
        self:addChild(self._label)
        self:addChild(self._centeLabel)
        self:addChild(self._maxLabel)

        if (self._autoAdaption) then
            self:_autoAdapt()
        end
    end
end

-- 自动调节尺寸
function GridText:autoAdapt()
    self._autoAdaption = true
    self:_autoAdapt()
end

function GridText:_autoAdapt()
    local size = self:getContentSize()
   GridText.super.setSize(self, size.width, size.height)
end

-- 更新视图
function GridText:onUpdateView()

end

function GridText:getContentSize() 
    local width = 0
    local height = 0
    if(self._label) then
        local contenSize = self._label:getContentSize()
        width = width + contenSize.width
        height = height + contenSize.height
    end

    if(self._centeLabel) then
        local contenSize = self._centeLabel:getContentSize()
        width = width + contenSize.width
        height = height + contenSize.height
    end

    if(self._maxLabel) then
        local contenSize = self._maxLabel:getContentSize()
        width = width + contenSize.width
        height = height + contenSize.height
    end

    return {width = width, height = height}
end

-- 设置尺寸
function GridText:setSize(width, height)
    if (width) then assert(type(width) == "number" and width >= 0, "Text setSize: width is invalid.") end
    if (height) then assert(type(height) == "number" and height >= 0, "Text setSize: height is invalid.") end

    GridText.super.setSize(self, width, height)
    self._autoAdaption = false
end