-- UIBlockingLayer.lua
-- Author:CMonk
-- 2018年11月1日
-- Using:全屏触控防止层 

require "utils.IrregularShapeScreenUtil"

UI = UI or {}

local UIBlockingLayer = class("UIBlockingLayer", UI.HWBtnComponent)
UI.UIBlockingLayer = UIBlockingLayer

local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {

}

function UIBlockingLayer:updateEverySecond()
    if (self.lastTouchTS) then
        local timeNow = GameManager:getNormalServerTime()
        local deltaTime = timeNow - self.lastTouchTS
        if (deltaTime > 30 * 60 and not self.isShowingIdleDC) then
            local isOpen = cc.UserDefault:getInstance():getBoolForKey("isAutoDropLine", true)
            if isOpen then

                self.isShowingIdleDC = true
                -- 关闭连接
                Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
                UI.TipsLayer:createIdleDCTips()
            end
        end
    end
end

--构造函数(必备)
function UIBlockingLayer:ctor(spriteID)
    --窗口大小
    UIBlockingLayer.super.ctor(
        self, UIType.FULL_SCREEN,
        COM_RES_LIST,
        winSize.width,    
        winSize.height
    )

    self:init()
    self:registerListener()
    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.updateEverySecond), 1, false)
    self.lastTouchTS = GameManager:getNormalServerTime()
end

--虚构函数,destroy时调用(必备)
function UIBlockingLayer:dtor()
    UIBlockingLayer.super.dtor(self)
    self:unRegisterListener()
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

-- 初始化(必备)
function UIBlockingLayer:init()
    UIBlockingLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function UIBlockingLayer:onInitView()
    -- 异形屏幕触摸阻挡左边
    local leftBlcokerWidth = Avalon.issUtil:getLeftMargin()
    if leftBlcokerWidth > 5 then
        local leftBlocker = UI.Component:create()
        leftBlocker:init()
        leftBlocker:setSize(leftBlcokerWidth, winSize.height)
        leftBlocker:leftBottom(0, 0)
        leftBlocker:setTouchEnable(true)
        leftBlocker:setEnableMinTouchSize(false)
        leftBlocker:setSwallowTouches(true)
        self:addChild(leftBlocker)
    end

    -- 异形屏幕触摸阻挡右边
    local rightBlcokerWidth = Avalon.issUtil:getRightMargin()
    if rightBlcokerWidth > 5 then
        local rightBlocker = UI.Component:create()
        rightBlocker:init()
        rightBlocker:setSize(rightBlcokerWidth, winSize.height)
        rightBlocker:rightBottom(0, 0)
        rightBlocker:setTouchEnable(true)
        rightBlocker:setEnableMinTouchSize(false)
        rightBlocker:setSwallowTouches(true)
        self:addChild(rightBlocker)
    end

    -- 全屏阻挡
    self.fullscreenBlockingLayer = UI.Component:create()
    self.fullscreenBlockingLayer:init()
    self.fullscreenBlockingLayer:setSize(winSize.width, winSize.height)
    self.fullscreenBlockingLayer:leftBottom(0, 0)
    self.fullscreenBlockingLayer:addTouchEvents()
    self.fullscreenBlockingLayer:setEnableMinTouchSize(false)
    self.fullscreenBlockingLayer:setSwallowTouches(true)
    self:addChild(self.fullscreenBlockingLayer)

    -- 点击检测层
    self.touchDetectLayer = UI.Component:create()
    self.touchDetectLayer:init()
    self.touchDetectLayer:setSize(winSize.width, winSize.height)
    self.touchDetectLayer:leftBottom(0, 0)
    self.touchDetectLayer:setTouchEnable(true)
    self.touchDetectLayer:setInterceptTouches(true)
    self.touchDetectLayer:setEnableMinTouchSize(false)
    self.touchDetectLayer:setSwallowTouches(false)
    self.touchDetectLayer:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
        self.lastTouchTS = GameManager:getNormalServerTime()
    end)
    self:addChild(self.touchDetectLayer)
end

-- 模版函数：更新组建的视图
function UIBlockingLayer:onUpdateView()
    
end


function UIBlockingLayer:setFullscreenBlockingTouchEnable(isBlocking, autoRemoveTime)
    self.fullscreenBlockingLayer:setTouchEnable(isBlocking)
    if (autoRemoveTime) then
        performWithDelay(self, function()
            if (not tolua.isnull(self.fullscreenBlockingLayer)) then
                self.fullscreenBlockingLayer:setTouchEnable(false)
            end
        end, autoRemoveTime)
    end
end

-- 注册监听事件(可选)
function UIBlockingLayer:registerListener()
    -- 阻止触摸
    Avalon.MessageCenter:bind(AvalonMessage.MC_SET_BLOCKING_TOUCHES, self, self.setFullscreenBlockingTouchEnable)
end

-- 注销监听事件(可选)
function UIBlockingLayer:unRegisterListener()
    -- 阻止触摸
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SET_BLOCKING_TOUCHES, self, self.setFullscreenBlockingTouchEnable)
end
