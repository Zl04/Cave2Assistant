--[[
    TouchLayout.lua
    use：ydli
    UI - 触摸事件 拦截 自判断 ======> 优化点击事件
]]--

require "app.ui.common.Layout"

--------自定义 奖励内容  处理触摸事件
local TouchLayout = class("TouchLayout", UI.Layout)
UI.TouchLayout = TouchLayout

function TouchLayout:addTouchEvents(awardLayer)
    local function onTouchBegan(touch, event)
        if self:checkTouch(touch) then
            awardLayer:onTouchBegan(touch, event)
            return true
        end
        return false
    end

    local function onTouchMoved(touch, event)
        if self:checkTouch(touch) and awardLayer.onTouchMoved then
            awardLayer:onTouchMoved(touch, event)
        end
    end

    local function onTouchEnded(touch, event)
        if self:checkTouch(touch) then
            awardLayer:onTouchEnded(touch, event)
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    listener:setSwallowTouches(false)
    self.listener = listener
end

function TouchLayout:setSwallowTouches(isSwallow)
    if self.listener then
        self.listener:setSwallowTouches(isSwallow)
    end
end