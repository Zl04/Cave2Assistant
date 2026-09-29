

UI = UI or {}

require("app.ui.common.WinMgr.BaseWin")

local CenterWin = class("CenterWin", UI.BaseWin)
UI.CenterWin = CenterWin

local DOOR_OUT_ANIMATION_TIME = 0.2
--------------------------生命周期--------------------------
function CenterWin:ctor(...)
    CenterWin.super.ctor(self, ...)
    self.isOpenStatus = false
    self.isOpenComplete = false
    -- self:setTouchEnable(true);
    -- self:setInterceptTouches(true)
    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSizeEvent)
end

function CenterWin:init(...)
    CenterWin.super.init(self, ...)
end

function CenterWin:dtor()
    CenterWin.super.dtor(self)
end
--------------------------eo 生命周期------------------------

-- 准备入场动画，初始化入场动画节点的状态
function CenterWin:prepareOpenEvent()
    self:setScale(0.01)
end

function CenterWin:getOpenAnimation()
    self:setAnchorPoint(0.5, 0.5)
    local scaleAction = cc.ScaleTo:create(0.15, 1, 1)
    local easeScaleAction = cc.EaseOut:create(scaleAction, 4)
    return easeScaleAction
end


