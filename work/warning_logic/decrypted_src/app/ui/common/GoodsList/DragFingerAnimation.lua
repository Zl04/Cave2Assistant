
-- DragFingerAnimation.lua
-- Author:zp
-- 2018年10月20日
-- Using:开关按钮

require "app.ui.Component"
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local DragFingerAnimation = class("DragFingerAnimation", UI.HWBtnComponent)
UI.DragFingerAnimation = DragFingerAnimation
local scheduler = cc.Director:getInstance():getScheduler()

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 按钮的状态
UI.ButtonState = {
    NORMAL = 1,   -- 正常
    ACTIVE = 2,   -- 点击
    RELEASE = 3,  -- 释放
    DISABLE = 4   -- 不可用状态
}
ButtonState = UI.ButtonState

-- 背包资源
local COM_RES_LIST = nil
-- 按钮中的子对象z序
local BUTTON_SPRITE_ZORDER = 1
local BUTTON_TITLE_ZORDER = 2

-- 构造函数
function DragFingerAnimation:ctor()
    DragFingerAnimation.super.ctor(self, UIType.SWITCH_BUTTON, COM_RES_LIST, 0, 0)

    self._dragAnimation = nil
    self._waitingTime = 0
    self._showAnimation = false

    Avalon.Scheduler:scheduleUpdate(self, self.refreshUpdate)
end

-- 析构函数
function DragFingerAnimation:dtor()
    Avalon.Scheduler:unscheduleUpdate(self, self.refreshUpdate)
    DragFingerAnimation.super.dtor(self)
end

-- public:
-- 初始化
function DragFingerAnimation:init()
    DragFingerAnimation.super.init(self)
end

function DragFingerAnimation:onInitView()
    local dragAnimation = UI.Animation:create()
    dragAnimation:init("effect_ui_common_drag_finger.json", "effect_ui_common_drag_finger.atlas")
    dragAnimation:centerUp(-5)
    self:addChild(dragAnimation)
    self._dragAnimation = dragAnimation
    self._dragAnimation:hide()
    self._showAnimation = false

    dragAnimation._spine:registerSpineEventHandler(function (event)
        self._dragAnimation:hide()
        self._waitingTime = 0
        self._showAnimation = false
    end, sp.EventType.ANIMATION_COMPLETE)
end

-- 更新视图
function DragFingerAnimation:onUpdateView()
    
end

function DragFingerAnimation:changeInSideStatus(inSide)
    if(not tolua.isnull(self._dragAnimation)) then
        if(self._preSide ~= inSide) then
            self._preSide = inSide
            if(inSide) then 
                if(self._showAnimation == false) then
                    self._showAnimation = true
                    self._dragAnimation:show()
                    self._dragAnimation:setAnimation("trigger", false)
                end
            else
                self._showAnimation = false
                self._dragAnimation:hide()
            end
        end
    end
end

function DragFingerAnimation:refreshUpdate(dt)
    if(self._preSide and self._showAnimation == false) then
        self._waitingTime = self._waitingTime + dt
        if(self._waitingTime > 1) then 
            self._waitingTime = 0
            self._showAnimation = true
            self._dragAnimation:show()
            self._dragAnimation:setToSetupPose()
            self._dragAnimation:setAnimation("trigger", false)
        end
    end
end