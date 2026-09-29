
-- DownstairsPanel.lua
-- Author:zp
-- 2018年2月12日
-- Using:下楼的相关场景

local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local DownstairsPanel = class("DownstairsPanel", UI.HWBtnComponent)
UI.DownstairsPanel = DownstairsPanel

local winSize = cc.Director:getInstance():getWinSize()

-- 资源文件
local COM_RES_LIST = {

}

-- 下楼表现状态
DownstairsType = {
    DownstairsType_Leave = 1;
    DownstairsType_Enter = 2;
}

function DownstairsPanel:refreshTime(dt)
    -- 处理倒计时
    if(self._triggerMove) then 
        --  处理相关的逻辑代码
        SceneManager:getInstance():leaveWaiting()
    end
end

function DownstairsPanel:ctor()
    DownstairsPanel.super.ctor(self, UIType.DOWNSTAIRS, COM_RES_LIST, winSize.width, winSize.height)
    self._triggerMove = false
    Avalon.Scheduler:scheduleUpdate(self, self.refreshTime)
end

function DownstairsPanel:dtor()
    DownstairsPanel.super.dtor(self)

    Avalon.Scheduler:unscheduleUpdate(self, self.refreshTime)
end

-- public:
-- 初始化
function DownstairsPanel:init(downstairsType)
    self:setInterceptTouches(true)
    self:setTouchEnable(true)

    self.downstairsType = downstairsType

    DownstairsPanel.super.init(self)
end

-- 模版函数：初始化组建的视图
function DownstairsPanel:onInitView()
    -- 显示被踢的相关的界面
    local slotAnimation = Avalon.Animation:create("effect_ui_gaming_downstairs.json", "effect_ui_gaming_downstairs.atlas", 1);
    if(self.downstairsType == DownstairsType.DownstairsType_Leave) then 
        slotAnimation:setAnimation(0, "begin", false)
        Avalon.AudioManager:playSound("1057")
    else 
        local rootLayer = cc.LayerColor:create(cc.c4b(0,0,0,255));
        rootLayer:setContentSize(cc.size(winSize.width,winSize.height))
        rootLayer:setPosition(cc.p(0,0))
        self:addChild(rootLayer)
        self._blackLayer = rootLayer

        slotAnimation:setAnimation(0, "end", false)
    end

    slotAnimation:setScale(ToolsUtil:getAdaptationMaxScale())
    slotAnimation:setTimeScale(1.5)

    -- slotAnimation:setScale(2.5)

    self:addChild(slotAnimation)
    slotAnimation:setPosition(cc.p(winSize.width/2, winSize.height /2))
    self._slotAnimation = slotAnimation

    slotAnimation:registerSpineEventHandler(function (event)
        print("sp.EventType.ANIMATION_COMPLETE", AvalonUtil:getCurrentTime())
        if(self.downstairsType == DownstairsType.DownstairsType_Leave) then 
            self._triggerMove = true
        else 
            self:close()
        end
    end, sp.EventType.ANIMATION_COMPLETE)

    slotAnimation:setLoadedSpineSuccessCallBack(function()
        print("sp.EventType.ANIMATION_START", AvalonUtil:getCurrentTime())
        if(not tolua.isnull(self._blackLayer)) then
            -- self._blackLayer:setVisible(false)
            self._blackLayer:runAction(cc.RemoveSelf:create())
        end
    end)
end