-- SuperLenText.lua
-- Author:ydli
-- 2018年7月3日
-- Using:跑马灯


UI = UI or {}
local SuperLenText = class("SuperLenText", UI.Layout)
UI.SuperLenText = SuperLenText


-- 构造函数
function SuperLenText:ctor(text)
    SuperLenText.super.ctor(self, 0, {}, 0, 0)    
end

-- 析构函数
function SuperLenText:dtor()
    SuperLenText.super.dtor(self)
end

-- 初始化
function SuperLenText:init(text)
    SuperLenText.super.init(self)
    self._text = text
    self:setText(self._text)
end

-- 初始化视图
function SuperLenText:onInitView()
end

-- 更新视图
function SuperLenText:onUpdateView()

end

function SuperLenText:getText()
    return self._text 
end

function SuperLenText:setText(text)
    self._text = text
    if text == nil or text == "" then
        return
    end
    self:removeChildren()
    local richText = UI.RichText:create()
    local success = richText:initForNetJson(text, nil, nil, true)
    if success then
        --富文本
        self:setSize(richText:getContentSize().width, richText:getContentSize().height)
        richText:center()
        self:addChild(richText)
    end
    self.richText = richText
    return success
end

function SuperLenText:getTextWidth()
    if self.richText then
        return self.richText:getContentSize().width
    else
        return 500
    end
end
