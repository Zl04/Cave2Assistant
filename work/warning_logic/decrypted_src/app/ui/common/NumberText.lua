--[[
    UI - 数字文本：会显示数字简写
]]--

UI = UI or {}

local NumberText = class("NumberText", UI.Text)
UI.NumberText = NumberText
local DEFAULT_SHOW_SIZE = 5

-- 构造函数--showSize：小数点前后需要保留的数字
function NumberText:ctor(text, fontName, fontSize, fontColor, showSize)
    NumberText.super.ctor(self, "", fontName, fontSize, fontColor)
    self:init("", fontName, fontSize, fontColor)
    self._showSize = showSize or DEFAULT_SHOW_SIZE
    self._fullText = text
    self:setText(text)
end

-- 设置字体内容
function NumberText:setText(text)
    self._fullText = text
    if tonumber(text) ~= nil then
        text = tonumber(text)
        local numberSize = AvalonUtil:getNumberSize(text)
        if numberSize > self._showSize and self._showSize ~= 0 then
            text = AvalonUtil:getSimpleNumber(text, self._showSize)
        else
            text = AvalonUtil:getCommaNumber(text)
        end
    end 
    NumberText.super.setText(self, text)
end

--size：小数点前后需要保留的数字
function NumberText:setShowSize(showSize)
    if showSize < 0 then
        return
    end 
    if self._showSize ~= showSize then
        self._showSize = showSize
    end
    if self._fullText ~= nil and tonumber(self._fullText) ~= nil then
        local text = tonumber(self._fullText)
        local numberSize = AvalonUtil:getNumberSize(text)
        if numberSize > self._showSize and self._showSize ~= 0 then
            text = AvalonUtil:getSimpleNumber(text, self._showSize)
        else
            text = AvalonUtil:getCommaNumber(text)
        end
        NumberText.super.setText(self, text)
    end
end

function NumberText:getText()
    return self._fullText
end

