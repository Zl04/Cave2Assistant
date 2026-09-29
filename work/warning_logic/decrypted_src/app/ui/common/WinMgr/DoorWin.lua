-- Component的子类, 用来方便实现应对安卓硬件按钮事件
-- 目前采用模拟TouchOutside的方法来实现

UI = UI or {}

require("app.ui.common.WinMgr.BaseWin")

local DoorWin = class("DoorWin", UI.BaseWin)
UI.DoorWin = DoorWin

local DOOR_OUT_ANIMATION_TIME = 0.2
--------------------------生命周期--------------------------
function DoorWin:ctor(...)
    DoorWin.super.ctor(self, ...)
    self.isOpenStatus = false
    self.isOpenComplete = false
    self:setTouchEnable(true);
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSizeEvent)
end

function DoorWin:init(...)
    DoorWin.super.init(self, ...)
end

function DoorWin:dtor()
    DoorWin.super.dtor(self)
end
--------------------------eo 生命周期------------------------

-- 设置左右节点
function DoorWin:setDoorNode(leftNode, rightNode, autoOpen)
    self.leftDoor = leftNode
    self.rightDoor = rightNode
    self:centerLeft(0)
    if autoOpen == nil or autoOpen == true then
        self:open()
    end
end

-- 准备入场动画，初始化入场动画节点的状态 
function DoorWin:prepareOpenEvent()
    local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
    if self.leftDoor then
        self.leftDoor._enableAutoUpdatePos = false
        local yPos = (winSize.height - self.leftDoor._height) / 2
        local xPos = Avalon.issUtil:getLeftEdgeXForNode(self.leftDoor, false) - self.leftDoor._width
        self.leftDoor:setPosition(xPos, yPos)
    end

    if self.rightDoor then
        self.rightDoor._enableAutoUpdatePos = false
        local yPos = (winSize.height - self.rightDoor._height) / 2
        local xPos = Avalon.issUtil:getRightEdgeXForNode(self.rightDoor, false) + self.rightDoor._width
        self.rightDoor:setPosition(xPos, yPos)
    end
end

function DoorWin:getOpenAnimation()
    local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

    local rate = 1
    local xOffset = 15
    local DOOR_IN_ANIMATION_TIME = 0.1
    local time2 = 0.1
    if self.leftDoor then
        local yPos = (winSize.height - self.leftDoor._height) / 2
        local xPos = Avalon.issUtil:getLeftEdgeXForNode(self.leftDoor)
        local leftMoveAction = cc.MoveTo:create(DOOR_IN_ANIMATION_TIME, cc.p(xPos + xOffset, yPos))
        local easeAction = cc.EaseIn:create(leftMoveAction, rate)
        local moveEndAction = cc.MoveTo:create(time2, cc.p(xPos, yPos))
        self.leftDoor:runAction(cc.Sequence:create(easeAction, moveEndAction))
    end

    if self.rightDoor then
        local yPos = (winSize.height -  self.rightDoor._height) / 2
        local xPos = Avalon.issUtil:getRightEdgeXForNode(self.rightDoor) - self.rightDoor._width
        local rightMoveAction = cc.MoveTo:create(DOOR_IN_ANIMATION_TIME, cc.p(xPos - xOffset, yPos))
        local easeAction = cc.EaseIn:create(rightMoveAction, rate)
        local moveEndAction = cc.MoveTo:create(time2, cc.p(xPos, yPos))
        self.rightDoor:runAction(cc.Sequence:create(easeAction, moveEndAction))
    end

    local delayAction = cc.DelayTime:create(DOOR_IN_ANIMATION_TIME + time2)
    return delayAction
end

-- 关门动画
function DoorWin:getCloseAnimation()

    local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

    if self.leftDoor then
        local move = cc.MoveTo:create(DOOR_OUT_ANIMATION_TIME, cc.p(-winSize.width, self.leftDoor:getPositionY()))
        --local easeAction = cc.EaseBackIn:create(move)
        self.leftDoor:runAction(move)
    end

    if self.rightDoor then
        local move = cc.MoveTo:create(DOOR_OUT_ANIMATION_TIME, cc.p(winSize.width + self.rightDoor._width, self.rightDoor:getPositionY()))
        --local easeAction = cc.EaseBackIn:create(move)
        self.rightDoor:runAction(move)
    end

    local delayAction = cc.DelayTime:create(DOOR_OUT_ANIMATION_TIME)
    return delayAction
end


