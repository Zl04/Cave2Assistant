--[[
    UI - Tab 
]]--

require "app.ui.common.Tab.TabItem"

UI = UI or {}

local SpineTabItem = class("SpineTabItem", UI.TabItem)
UI.SpineTabItem = SpineTabItem


-- 构造函数
function SpineTabItem:ctor(type, bottomSpace)
    local _type = type or UIType.TAB_ITEM
    SpineTabItem.super.ctor(self, _type, nil, 0, 0)
    self.isInPressing = false
    self.isSingleBtn = false
    self.bottomSpace = bottomSpace or 0
    -- self:enableDebugDraw()
end

-- 析构函数
function SpineTabItem:dtor()
    SpineTabItem.super.dtor(self)
end

-- public:
-- 初始化
function SpineTabItem:init(bgSpineName, iconSpineName, tabText, textFont,textSize)
    SpineTabItem.super.init(self)
    self._bgSpine = UI.Animation:create()
    self._bgSpine:init(string.format("%s.json", bgSpineName), string.format("%s.atlas", bgSpineName))
    self._bgSpine:setAnimation("idle03", false)
    self:addChild(self._bgSpine, 1)
    -- self._bgSpine:enableDebugDraw(UI.RED)
    local size = self._bgSpine:getBoundingBox()
    self._bgSpine:setSize(size.width, size.height)
    self._bgSpine:centerBottom(self.bottomSpace)

    self._iconSpine = UI.Animation:create()
    self._iconSpine:init(string.format("%s.json", iconSpineName), string.format("%s.atlas", iconSpineName))
    self._iconSpine:setAnimation("idle03", false)
    self._iconSpine:centerLeft(10)
    self:addChild(self._iconSpine, 2)
    -- self._iconSpine:enableDebugDraw(UI.RED)
    local size = self._iconSpine:getBoundingBox()
    self._iconSpine:setSize(size.width, size.height)
    self.space = 0
    if tabText then
        self._tabText = UI.Text:create()
        self._tabText:init(tabText, textFont, UI.FONT_SIZE_26PX, UI.FONT_COLOR_77_80_97)
        self:addChild(self._tabText, 3)
        self._tabText:centerLeft(50)
        self.scale = 1
        local size = self._tabText:getContentSize()
        if textSize then
            if size.width > textSize.width then
                self.scale = textSize.width/size.width
                self._tabText:setScale(self.scale)
            end
        end

        self.space = (34 - size.height) / 2
        self.space = self.space < 0 and 0 or self.space
        self.space = self.space + self.bottomSpace
    end
end

-- 初始化视图
function SpineTabItem:onInitView(tabString)
    
end

function SpineTabItem:getTabTextContentSizeWidth()
    return self._tabText:getContentSize().width * self.scale
end

-- 更新视图
function SpineTabItem:onUpdateView()
    if self._tabText then
        local left = (self:getContentSize().width - self:getTabTextContentSizeWidth() - self._iconSpine:getContentSize().width - 8) / 2
        self._iconSpine:leftBottom(left, self:getContentSize().height / 2 - self._iconSpine:getContentSize().height / 2 - 10 + self.bottomSpace / 2)
        self._tabText:rightBottom(left, self.space - 2)
    else
        self._iconSpine:centerBottom(10 + self.bottomSpace)
    end
    self._bgSpine._spine:setPosition(self._bgSpine:getContentSize().width / 2, 0)
end


-- 被按下
function SpineTabItem:onPress()
    if self.isInPressing then
        return
    end
    self.isInPressing = true
    self._bgSpine:setAnimation("begin", false)
    self._iconSpine:setAnimation("begin", false)
    if  self._tabText then
        self._tabText:setFontColor(UI.FONT_COLOR_219_35_45)
        self._tabText:rightBottom(self._tabText:getRight(), self.space)
    end
end

-- 显示被激活
function SpineTabItem:onActive()
    self.isInPressing = false
    self._bgSpine:setAnimation("idle02", true)
    self._iconSpine:setAnimation("idle02", true)
    if self._tabText then
       self._tabText:setFontColor(UI.FONT_COLOR_219_35_45)
       self._tabText:rightBottom(self._tabText:getRight(), self.space)
    end
end

-- 是否
function SpineTabItem:onDisable()
    self.isInPressing = false
    self._bgSpine:setAnimation("idle03", false)
    self._iconSpine:setAnimation("idle03", false)
    if self._tabText then
       self._tabText:setFontColor(UI.FONT_COLOR_77_80_97)
       self._tabText:rightBottom(self._tabText:getRight(), self.space - 2)
    end
end

-- 恢复
function SpineTabItem:onRestore()
    self.isInPressing = false
    self._bgSpine:setAnimation("idle03", false)
    self._iconSpine:setAnimation("idle03", false)
    if  self._tabText then
        self._tabText:setFontColor(UI.FONT_COLOR_77_80_97)
        self._tabText:rightBottom(self._tabText:getRight(), self.space - 2)
    end
    if self._lockAction ~= nil then
        self._lockAction:removeFromParent()
        self._lockAction = nil
    end
end

function SpineTabItem:release()
    self.isInPressing = false
    if self.isSingleBtn then
        self._bgSpine:setAnimation("idle02", true)
        self._iconSpine:setAnimation("idle02", true)
    else
        self._bgSpine:setAnimation("idle03", false)
        self._iconSpine:setAnimation("idle03", false)
    end
    if self._tabText then
        self._tabText:setFontColor(UI.FONT_COLOR_77_80_97)
        self._tabText:rightBottom(self._tabText:getRight(), self.space - 2)
    end
end

function SpineTabItem:playUnlockAction(callback, right, up, zorder, scale)
    if self._lockAction ~= nil then
        self._lockAction:removeFromParent()
        self._lockAction = nil
    end
    self._lockAction = ToolsUtil:playUnlockAction(self, function()
        self._lockAction = nil
        if callback then
            callback()
        end
    end, false, 20, 18)
end


function SpineTabItem:playNewAction(scale)
    if self._newAction ~= nil then
        self._newAction:removeFromParent()
        self._newAction = nil
    end
    self._newAction = ToolsUtil:playNewAction(self, scale, 20, 18)
    return self._newAction
end

function SpineTabItem:removeNewAction()
    if self._newAction then
        self._newAction:destroy()
        self._newAction = nil
    end
end

function SpineTabItem:autoAdaptSize()

end

function SpineTabItem:showRedPoint()
    local redPoint = nil
    if (self._tabText) then
        redPoint = self._tabText:getChildByName("REDPOINT")
    else
        redPoint = self:getChildByName("REDPOINT")
    end
    if redPoint == nil then
        redPoint = UI.Image:create()
        redPoint:init("ui_information_newitem.png")
        redPoint:setName("REDPOINT")
        -- self._tabText:enableDebugDraw()
        if  self._tabText then
            self._tabText:addChild(redPoint, 20)
            redPoint:rightUp(- redPoint:getContentSize().width / 2 - 3, - redPoint:getContentSize().height / 2)
        else
            self:addChild(redPoint, 20)
            redPoint:center()
        end
    end
    return redPoint
end

function SpineTabItem:removeRedPoint()
    if (self._tabText) then
        redPoint = self._tabText:removeChildByName("REDPOINT")
    else
        self:removeChildByName("REDPOINT")
    end
end

function SpineTabItem:reverseBg()
    self._bgSpine:setScaleX(-1)
end

function SpineTabItem:disable()
    SpineTabItem.super.disable(self)
    if self._lockAction ~= nil then
        self._lockAction:removeFromParent()
        self._lockAction = nil
    end
    self._lockAction = ToolsUtil:playUnlockAction(self, nil, true, 20, 18)
end

function SpineTabItem:setSingle(single)
    self.isSingleBtn = single
end
