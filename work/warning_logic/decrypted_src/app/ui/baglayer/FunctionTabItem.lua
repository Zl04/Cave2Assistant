--[[
    UI - Tab 
]]--

require "app.ui.common.Tab.TabItem"

UI = UI or {}

local FunctionTabItem = class("FunctionTabItem", UI.TabItem)
UI.FunctionTabItem = FunctionTabItem

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 构造函数
function FunctionTabItem:ctor(type)
    local _type = type or UIType.TAB_ITEM
    print("FunctionTabItem",_type)
    FunctionTabItem.super.ctor(self, _type, nil, 0, 0)

    self._bg = nil
    self._icon = nil
    self._tabText = nil

    self._normalIconName = nil
    self._activeIconName = nil
    self._disableIconName = nil
    self._tabString = nil
    self._fontName = nil
    self._newAction = nil
    -- self:enableDebugDraw()
end

-- 析构函数
function FunctionTabItem:dtor()
    FunctionTabItem.super.dtor(self)
    self._clickMove = true
    self._newAction = nil
end

-- public:
-- 初始化
function FunctionTabItem:init(normalIconName, activeIconName, disableIconName, tabString, fontnName, fontSize)
    self._normalIconName = normalIconName
    self._activeIconName = activeIconName
    self._disableIconName = disableIconName
    self._tabString = tabString
    self._fontName = fontnName
    self._fontSize = fontSize
    self._isPlayUnlock = isPlayUnlock
    self._isNew = isNew
    FunctionTabItem.super.init(self)
    -- self:enableDebugDraw()
end

-- 初始化视图
function FunctionTabItem:onInitView(tabString)
    self._icon = UI.Image:create()
    self._icon:init(self._normalIconName)
    self._icon:center(0, 0)
    self:addChild(self._icon)
-- self._icon:enableDebugDraw()
    self._tabText = UI.Text:create()
    self._tabText:init(self._tabString, self._fontName or UI.FONT_STANDARD, self._fontSize or UI.FONT_SIZE_10PX)
    self._tabText:center()
    self._icon:addChild(self._tabText)
end

-- 更新视图
function FunctionTabItem:onUpdateView()
    self:autoAdaptSize()
end

-- 设置颜色值
function FunctionTabItem:setFontColor(normalColor, activeColor, disableColor)
    self._normalColor = normalColor
    self._disableColor = disableColor
    self._activeColor = activeColor
    if self._tabText then
        self._tabText:setFontColor(normalColor)
    end
end

function FunctionTabItem:closeClickMove()
    self._clickMove = false
end

-- 被按下
function FunctionTabItem:onPress()
    self._icon:setSpriteName(self._activeIconName)
    if self._activeColor then
        self._tabText:setFontColor(self._activeColor)
    end
    self:autoAdaptSize()
end

-- 显示被激活
function FunctionTabItem:onActive()
    self._icon:setSpriteName(self._activeIconName)
    if self._activeColor then
        self._tabText:setFontColor(self._activeColor)
    end
    self:autoAdaptSize()
end

-- 是否
function FunctionTabItem:onDisable()
    self._icon:setSpriteName(self._disableIconName)
    if self._disableColor then
        self._tabText:setFontColor(self._disableColor)
    end
    self:autoAdaptSize()
end

-- 恢复
function FunctionTabItem:onRestore()
    self._icon:setSpriteName(self._normalIconName)
    if self._normalColor then
        self._tabText:setFontColor(self._normalColor)
    end
    self:autoAdaptSize()
    if self._lockAction ~= nil then
        self._lockAction:removeFromParent()
        self._lockAction = nil
    end
end


function FunctionTabItem:playUnlockAction(callback, right, up, zorder, scale)
    if self._lockAction ~= nil then
        self._lockAction:removeFromParent()
        self._lockAction = nil
    end
    self._lockAction = ToolsUtil:playUnlockAction(self, function()
        self._lockAction = nil
        if callback then
            callback()
        end
    end, false, 10, 12)
end

function FunctionTabItem:playNewAction(scale)
    if self._newAction ~= nil then
        self._newAction:removeFromParent()
        self._newAction = nil
    end
    self._newAction = ToolsUtil:playNewAction(self, scale, 12, 10)
    return self._newAction
end

function FunctionTabItem:getTextLabel()
    return self._tabText
end

function FunctionTabItem:removeNewAction()
    if self._newAction then
        self._newAction:destroy()
        self._newAction = nil
    end
end

function FunctionTabItem:autoAdaptSize()
    -- print("--------FunctionTabItem:autoAdaptSize--------")
    self:setSize(self._icon:getContentSize().width, self._icon:getContentSize().height)
end

function FunctionTabItem:disable()
    FunctionTabItem.super.disable(self)
    if self._lockAction ~= nil then
        self._lockAction:removeFromParent()
        self._lockAction = nil
    end
    self._lockAction = ToolsUtil:playUnlockAction(self, nil, true, 10, 12)
end