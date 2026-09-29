--[[
    UI - 富文本
]]--
require "app.ui.Component"

UI = UI or {}

local RichText = class("RichText",  UI.HWBtnComponent)
UI.RichText = RichText

-- 构造函数
function RichText:ctor(verticalSpace)
    RichText.super.ctor(self, UIType.RICH_TEXT, nil, 0, 0)
    self._richText = nil
    self._verticalSpace = verticalSpace
    self._underLineVisible = nil
end

-- 析构函数
function RichText:dtor()
    self._compList = nil
    self._richText = nil
    RichText.super.dtor(self)
end

-- public:
-- 初始化
--[[根据网络XML格式文本数据初始化显示文本
    width：限制文本宽度
    height： 限制文本高度 （已废弃）
    ingore：是否忽略 文本宽度的限制 
]]
function RichText:init(richText, width, height, ingore)
    ingore = ingore or false
    RichText.super.init(self)
    self._richText = ccui.RichText:createWithXML(richText)
    if self._richText == nil then
        return false
    end
    if self._verticalSpace ~= nil then
        self._richText:setVerticalSpace(self._verticalSpace)
    end
    self._richText:ignoreContentAdaptWithSize(ingore)
    if not ingore then
        self._richText:setContentSize(width, height)
    end
    -- self._richText:setPosition(width / 2, 0)
    self:addChild(self._richText)
    self._richText:formatText()
    self._richText:setPosition(self._richText:getContentSize().width / 2, self._richText:getContentSize().height / 2) 
    self._richText:setAnchorPoint(0.5, 0.5)
    self:setSize(self._richText:getContentSize().width, self._richText:getContentSize().height)
    -- self:enableDebugDraw()
    return true
end

--[[根据网络JSON数据初始化显示文本
    jsonContent: 需要显示的文本 json 格式
    width：限制文本宽度
    height： 限制文本高度 （已废弃）
    ingore：是否忽略 文本宽度的限制 
    strMaxLen：文本太长会卡顿，根据长度打断文本
]]
function RichText:initForNetJson(jsonContent, width, height, ingore, strMaxLen)
    -- print("RichText:initForNetJson=", jsonContent)
    if(jsonContent and jsonContent ~= "") then
        local textList = json.decode(jsonContent)
        local showText = ""
        for k, v in ipairs(textList) do
            -- 处理了链接地址
            local curShowWidth = 0
            if type(v) == "table" and #v >= 1 then
                for k2, v2 in ipairs(v) do
                    showText = showText..self:getXmlTextByData(v2, strMaxLen)
                end
            else
                showText = showText..self:getXmlTextByData(v, strMaxLen)
            end
        end 

        return self:init(showText, width, height, ingore)
    else 
        return self:init("", width, height, ingore)
    end

    return false
end 

--[[根据网络JSON数据初始化显示文本
    jsonContent: 需要显示的文本 json 格式
    width：限制文本宽度
    height： 限制文本高度 （已废弃）
    ingore：是否忽略 文本宽度的限制 
    strMaxLen：文本太长会卡顿，根据长度打断文本
    showWidth: 显示文本长度
]]
function RichText:initForNetJsonWithSWidth(jsonContent, width, height, ingore, strMaxLen, showWidth)
    -- print("RichText:initForNetJson=", jsonContent)
    if(jsonContent and jsonContent ~= "") then
        local textList = json.decode(jsonContent)
        local showText = ""
        local curShowWidth = 0
        for k, v in ipairs(textList) do
            if type(v) == "table" and #v >= 1 then
                for k2, v2 in ipairs(v) do
                    local size = cc.Label:CalculateStringSize(v2.text, UI.FONT_ARIAL, v2.fontSize)
                    curShowWidth = curShowWidth + size.width
                    if curShowWidth > showWidth then
                        local message = AvalonUtil:getSubNameStrByLabel(v2.text, showWidth - (curShowWidth - size.width), v2.fontSize)
                        v2.text = message.."..."
                        showText = showText..self:getXmlTextByData(v2, strMaxLen)
                        break
                    end
                    showText = showText..self:getXmlTextByData(v2, strMaxLen)
                end
            else
                local size = cc.Label:CalculateStringSize(v.text, UI.FONT_ARIAL, v.fontSize)
                curShowWidth = curShowWidth + size.width
                if curShowWidth > showWidth then
                    local message = AvalonUtil:getSubNameStrByLabel(v.text, showWidth - (curShowWidth - size.width), v.fontSize)
                    v.text = message.."..."
                    showText = showText..self:getXmlTextByData(v, strMaxLen)
                    break
                end
                showText = showText..self:getXmlTextByData(v, strMaxLen)
            end
        end 
        local pannel = self:init(showText, width, height, ingore)
        return pannel
    else 
        return self:init("", width, height, ingore)
    end

    return false
end 

--（现在文本没超长所以暂未处理）如果web服务器 下发的富文本过长 导致的卡顿， 需要截断处理，参考web下发的系统消息
function RichText:getXmlTextByData(v, strMaxLen)
    if strMaxLen ~= nil and string.len(v.text) > strMaxLen then 
        local list = AvalonUtil:splitByLength(v.text, strMaxLen)
        local text = ""
        for k2, v2 in ipairs(list) do
            v.text = v2
            text = text..self:getXmlTextByData(v)
        end 
        return text    
    else
        local fontName = self._fontName or UI.SYS_FONT
        if(v.href and v.href ~= "") then 
            return AvalonUtil:serializeInnerHref(v.text, v.href, v.color, v.fontSize, fontName)
        else 
            return AvalonUtil:serializeText(v.text, v.color, v.fontSize, fontName)
        end
    end
end

function RichText:ignoreContentAdaptWithSize(ingore)
    self._richText:ignoreContentAdaptWithSize(ingore)
end

-- 初始化视图
function RichText:onInitView()

end

-- 更新视图
function RichText:onUpdateView()

end

function RichText:setFontName(fontName)
    self._fontName = fontName
end

function RichText:onSizeChanged(width, height)
    self:updateView()
end

function RichText:getRichTextHeight()
    local width, height = self:getSize()
    return height
end

function RichText:setUnderLineVisible(isVisible)
    if self._richText == nil then
        return
    end
    if self._underLineVisible == nil then
        self._underLineVisible = isVisible
        self._richText:setUnderLineVisible(isVisible)
        self._richText:setHerfEnable(isVisible)
    elseif isVisible ~= self._underLineVisible then
        self._underLineVisible = isVisible
        self._richText:setUnderLineVisible(isVisible)
        self._richText:setHerfEnable(isVisible)
    end
end