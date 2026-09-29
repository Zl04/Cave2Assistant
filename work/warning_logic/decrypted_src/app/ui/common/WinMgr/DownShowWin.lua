-- Component的子类, 用来方便实现应对安卓硬件按钮事件
-- 目前采用模拟TouchOutside的方法来实现

UI = UI or {}

require("app.ui.common.WinMgr.BaseWin")

local DownShowWin = class("DownShowWin", UI.BaseWin)
UI.DownShowWin = DownShowWin

local DOOR_OUT_ANIMATION_TIME = 0.2
--------------------------生命周期--------------------------
function DownShowWin:ctor(...)
    DownShowWin.super.ctor(self, ...)
    self.isOpenStatus = false
    self.isOpenComplete = false
end

function DownShowWin:init(...)
    DownShowWin.super.init(self, ...)
end

function DownShowWin:dtor()
    DownShowWin.super.dtor(self)
end
--------------------------eo 生命周期------------------------

function DownShowWin:getOpenAnimation()
    local func = cc.CallFunc:create(function()
            self.isOpenComplete = true
            if self.openCallBack then
                self.openCallBack()
            end
        end
    )

    local node = self.animationtNode

    local offset = 30
    local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
    local posY = node:getPositionY()
    local startPos = winSize.height
    local move = nil
    node:setPosition(node:getPositionX(), startPos)
    if offset ~= 0 then
        move = cc.MoveTo:create(0.13, cc.p(node:getPositionX(), posY - offset))
        local easeAction = cc.EaseIn:create(move, 1)
        local moveEndAction = cc.MoveTo:create(0.15, cc.p(node:getPositionX(), posY))
        local easeAction2 = cc.EaseOut:create(moveEndAction, 1)
        move = cc.Sequence:create(easeAction, easeAction2)
    else
        move = cc.MoveTo:create(0.05, cc.p(node:getPositionX(), posY))
        move = cc.EaseOut:create(move, 15)
    end
    return move;
end

-- 关门动画
function DownShowWin:getCloseAnimation()
    local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
    local move = cc.MoveTo:create(0.15, cc.p(self.animationtNode:getPositionX(), winSize.height * 2))

    return move
end

