-- QuickEmojiLayer.lua
-- Author:gt
-- 2019年12月11日
-- Using:快捷emoji界面
local GameDataManager = require("app.game.GameDataManager")
require "app.config.ConfigManager"

UI = UI or {}
local QuickEmojiLayer = class("QuickEmojiLayer", UI.HWBtnComponent)
UI.QuickEmojiLayer = QuickEmojiLayer

local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(280, 145)

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_expression.plist",
    "ui_general_chat.plist",
}

--构造函数(必备)
function QuickEmojiLayer:ctor(spriteID)

    QuickEmojiLayer.super.ctor(self,UIType.QUICK_EMOJI_LAYER, COM_RES_LIST, layerSize.width, layerSize.height)

    self.expressionNodes = self.expressionNodes or {}
    self.selectIndex = 0
    self.lockClick = false

    self:init()
    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_DRAG_ENDED, self, function(self, com, touchPosition) 
        if not AvalonUtil:isRectContainsPoint(self, touchPosition) then
            self:reset()
            return
        end
    end)
end

--虚构函数,destroy时调用(必备)
function QuickEmojiLayer:dtor()
    QuickEmojiLayer.super.dtor(self)
end

-- 初始化(必备)
function QuickEmojiLayer:init()
    QuickEmojiLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function QuickEmojiLayer:onInitView()

    local bg = UI.Image:create()
    bg:init("ui_chat_emoji_bg_1.png")
    bg:center(0, 0)
    self:addChild(bg)
    self.bg = bg

    local arrow = UI.Image:create()
    arrow:init("ui_chat_emoji_bg_2.png")
    arrow:leftBottom(12, 1)
    self:addChild(arrow)

    local list = ConfigManager:getAllExpressionData()
    local cellsize = {width = 88, height = 58}
    local modeHeight = math.ceil(#list / 3)

    local cellLayout = UI.TouchLayout:create()
    cellLayout:init(0, 0, 0, 0)
    cellLayout:setSize(layerSize.width - 10, cellsize.height * modeHeight)
    self.bg:addChild(cellLayout)

    for k, value in ipairs(list) do
        local expression = UI.Image:create()
        expression:init(value.icon)
        local kHeight = math.ceil(k / 3) - 1      
        local kWidth = k % 3
        kWidth = kWidth == 0 and 3 or kWidth
        expression:leftUp((kWidth - 1) * cellsize.width + 5, kHeight * cellsize.height + 3)
        cellLayout:addChild(expression)
        expression:setScale(0.8)
        expression:setTag(value.ID)
        expression:setImageScaleX(-1)
        table.insert(self.expressionNodes, expression)
    end
    cellLayout:addTouchEvents(self)
    self.cellLayout = cellLayout

    self:leftBottom(1, -winSize.height)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        performWithDelay(self, function() 
            self:isShowEmojiLayer(false)
        end, 0.1)
    end)
    self:setForceListenBackKey(false)
end

function QuickEmojiLayer:onSelectedExpression(sender)

    sender:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.0), cc.ScaleTo:create(0.1, 0.8)))
    if self.lockClick then
        UI.ScrollBar:createByText(UI.TEXT_1170109)
        self:isShowEmojiLayer(false)
        return
    end

    local id = sender:getTag()
    local list = ConfigManager:getAllExpressionData()
    for k, value in ipairs(list) do
        if id == value.ID then
            local framentbgSpine = UI.Animation:create()
            framentbgSpine:init(value.spine..".json", value.spine..".atlas")
            framentbgSpine:setAnimation("idle",false)
            framentbgSpine:center()
            local spriteId = GameDataManager:getInstance():getMaster():getSpriteID()
            GameManager:addExpressionCommand(framentbgSpine, spriteId)
            self.lockClick = true
            framentbgSpine:addEventListener(UIEvent.ANIMATION_END,self,function()
                framentbgSpine:destroy()
                self.lockClick = false
            end)
            GameManager:sendExpression(id)
            Avalon.AudioManager:playSoundByConfig("26", value.ID)
            break
        end
    end
    self:isShowEmojiLayer(false)
end

function QuickEmojiLayer:isShowEmojiLayer(isShow)

    if isShow then
        AvalonUtil.runTipsShowAnimationAndSetAnchorPoint(self, 0.1, 0)
    else
        self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 0, 0)))
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_QUICK_EMOJI_CLOSE)
    end

end

-- 模版函数：更新组建的视图(必备)
function QuickEmojiLayer:onUpdateView()
end

function QuickEmojiLayer:reset()
    for k, value in ipairs(self.expressionNodes) do
        value:setScale(0.8)
    end
end

function QuickEmojiLayer:onTouchBegan(touch, event)
    local location = touch:getLocation()
    self.selectIndex = 0
    self.beginTouchPosition = location
    for k, value in ipairs(self.expressionNodes) do
        if AvalonUtil:isRectContainsPoint(value, location) then
            self.selectIndex = k
            value:setScale(1)
            return
        end
    end
end

function QuickEmojiLayer:onTouchMoved(touch, event)
end

function QuickEmojiLayer:onTouchEnded(touch, event)
    self:reset()
    local location = touch:getLocation()
    for k, value in ipairs(self.expressionNodes) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k then
            self:onSelectedExpression(value)
            return
        end
    end
    self.beginTouchPosition = nil
end
