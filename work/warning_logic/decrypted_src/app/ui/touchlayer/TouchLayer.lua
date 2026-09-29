--[[
    touch事件的处理的层级，在所有ui下方
]]--

require "app.ui.Component"
local MachineManager = require("app.game.MachineManager")
UI = UI or {}

local TouchLayer = class("TouchLayer", UI.HWBtnComponent)
UI.TouchLayer = TouchLayer

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local Scheduler = Avalon.Scheduler

-- 构造函数
function TouchLayer:ctor()
    TouchLayer.super.ctor(self, UIType.TOUCH_LAYER,{}, winSize.width, winSize.height)

    self._enable = true
    self._isTouchLongTime = false
    self._isTouchClick = false
    self._beginTouchPosition = nil

    Avalon.MessageCenter:bind(GameMessage.MC_UI_CONTROL_HALF_BLACKLAYER, self, self.controlHalfBlack)
end

-- public:
-- 初始化
function TouchLayer:init()
    print("====TouchLayer:init====")

    TouchLayer.super.init(self)

    self:addTouchEvents()
end

function TouchLayer:dtor()
    TouchLayer.super.dtor(self)

    Avalon.MessageCenter:unbind(GameMessage.MC_UI_CONTROL_HALF_BLACKLAYER, self, self.controlHalfBlack)
end

-- 开始长按处理器
function TouchLayer:onTouchLongTimeBeganHandler(touchPosition)
    self._isTouchLongTime = true

    MachineManager:getInstance():pushTouchLongTimeBeganCommand(touchPosition[1])
end

-- 结束长按的处理器
function TouchLayer:onTouchLongTimeEndedHandler(touchPosition)
    self._isTouchLongTime = false

    MachineManager:getInstance():pushTouchLongTimeEndedCommand(touchPosition)
end

-- 取消点击事件
function TouchLayer:onTouchRemoveClickHandler(touchPosition)
    self._isTouchClick = false
end

-- 初始化组件视图
function TouchLayer:initView(data)

end

-- 更新组件视图
function TouchLayer:updateView(data)

end

-- 添加点击事件
function TouchLayer:addTouchEvents()
    -- 点击开始
    local function onTouchBegan(touch, event)
        if(not GameManager:getIsInNewScene()) then
            if(GameManager:getMoveType() == MoveType.ALL) then 
                return false
            end 
        end
        -- print(string.format("TouchLayer onTouchBegan: touch position."))
        if (self._enable) then
            local touchPosition = touch:getLocation()
            self._isTouchClick = true
            self._beginTouchPosition = touchPosition
            -- print(string.format("TouchLayer onTouchBegan: touch position %f %f.", touchPosition.x, touchPosition.y))

            MachineManager:getInstance():pushTouchBeganCommand(touchPosition)
            Scheduler:scheduleUpdateOnce(self, TouchLayer.onTouchLongTimeBeganHandler, 0.5, touchPosition)
            Scheduler:scheduleUpdateOnce(self, TouchLayer.onTouchRemoveClickHandler, 0.2, touchPosition)
            Avalon.MessageCenter:notice(GameMessage.MC_COMMENT_END, COMMENT_END_NOTICE_TYPE.TOUCH_SCREEN)
            return true
        end
        return false
    end
    -- 点击移动
    local function onTouchMoved(touch, event)
        local touchPosition = touch:getLocation()
        MachineManager:getInstance():pushTouchMovedCommand(touchPosition)
    end
    -- 点击结束
    local function onTouchEnded(touch, event)
        local touchPosition = touch:getLocation()
        MachineManager:getInstance():pushTouchEndedCommand(touchPosition)
        
        if(self._isTouchClick) then
            -- print("ddddddddddddd", self._beginTouchPosition, touchPosition)
            local offsetX = self._beginTouchPosition.x - touchPosition.x 
            local offsetY = self._beginTouchPosition.y - touchPosition.y
            if(offsetX * offsetX + offsetY * offsetY < 100) then
                -- 触发点击事件
                MachineManager:getInstance():pushTouchClickCommand(touchPosition)
            end
        end

        if (self._isTouchLongTime) then
            self:onTouchLongTimeEndedHandler(touchPosition)
        else
            Scheduler:unscheduleUpdateOnce(self, TouchLayer.onTouchLongTimeBeganHandler)
        end
    end

    -- 注册点击监听事件
    -- local listener = cc.EventListenerTouchOneByOne:create()
    -- listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    -- listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    -- listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    -- listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_CANCELLED)

    -- listener:setSwallowTouches(true)
    -- local eventDispatcher = self:getEventDispatcher()
    -- eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

    ToolsUtil:registerMultiTouch(onTouchBegan, onTouchMoved, onTouchEnded, self)
end

-- 启用点击事件
function TouchLayer:enable()
    -- self._enable = true
end

-- 禁用点击事件
function TouchLayer:disable()
    -- self._enable = false
end

function TouchLayer:controlHalfBlack(isShow)
    if(isShow) then 
        self:showHalfBlack()
    else
        self:hideHalfBlack()
    end
end

function TouchLayer:showHalfBlack()
    if(self.halfBlackLayer) then
        self.halfBlackLayer:show()
    else
        local winSize = cc.Director:getInstance():getWinSize()
        local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,128))
        colorLayer:setPosition(0,0)
        colorLayer:setContentSize(winSize.width, winSize.height)
        self:addChild(colorLayer)
        self.halfBlackLayer = colorLayer 
    end
end

function TouchLayer:hideHalfBlack()
    if(self.halfBlackLayer) then
        self.halfBlackLayer:hide()
    end
end