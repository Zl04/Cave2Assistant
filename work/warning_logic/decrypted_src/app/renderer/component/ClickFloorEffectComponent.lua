
--[[
    点击地面效果动画
 ]]

Component = Component or {}

local ClickFloorEffectComponent = class("ClickFloorEffectComponent",cc.Node)

Component.ClickFloorEffectComponent = ClickFloorEffectComponent
-- UI.ClickFloorEffect = ClickFloorEffect 

local DEBUG = false

function ClickFloorEffectComponent:ctor()
    self._effect = Avalon.Animation:create("effect_ui_common_map_point.json", "effect_ui_common_map_point.atlas", 1)
    self:addChild(self._effect)

    self._effect:registerSpineEventHandler(function (event)
        if(DEBUG) then
            print(string.format("ClickFloorEffectComponent:showEffect[spine] %d end  animation=",event.trackIndex),event.animation)
        end

        self._effect:setVisible(false)
    end, sp.EventType.ANIMATION_COMPLETE)

    self._isRunningEffect = false
end

function ClickFloorEffectComponent:destroy()
    if(DEBUG) then
        print("ClickFloorEffect:destory")
    end
    Avalon.Scheduler:unscheduleUpdate(self, self.effectCallback)

    if(self._effect) then
        self._effect:destroy()
        self._effect = nil
    end
end

function ClickFloorEffectComponent:runEffect()
    if(DEBUG) then
        print("ClickFloorEffectComponent:runEffect  ")
    end

    self._effect:resume()
    self._isRunningEffect = true

    -- if self._action then
    --     self._effect:stopAction(self._action)
    --     self._action = nil
    -- end
    -- 运行显示效果
    -- self._effect:setTimeScale(1)
end

function ClickFloorEffectComponent:removeEffect()
    self._effect:setVisible(false)
end

function ClickFloorEffectComponent:showHitEffect(viewVisible)
    if viewVisible then
        self:showEffect("point")
    else
        self:showEffect("point2")
    end
end

function ClickFloorEffectComponent:showInvalidEffect(viewVisible)
    if viewVisible then
        self:showEffect("pointdisable1")
    else
        self:showEffect("pointdisable1_2")
    end
end

function ClickFloorEffectComponent:showClickWallEffect(viewVisible)
    if viewVisible then
        self:showEffect("pointdisable2")
    else
        self:showEffect("pointdisable2_2")
    end
end

function ClickFloorEffectComponent:showClickWallLeftRoad(viewVisible)
    self:showEffect("pointdisable4")
end

function ClickFloorEffectComponent:showClickWallRightRoad(viewVisible)
    self:showEffect("pointdisable3")
end

function ClickFloorEffectComponent:showClickWallLeftRightRoad(viewVisible)
    self:showEffect("pointdisable2")
end

function ClickFloorEffectComponent:showEffect(animationName)
    if(DEBUG) then
        print("ClickFloorEffectComponent:showEffect  animationName=",animationName)
    end

    self._effect:setAnimation(0, animationName, false)
    self._effect:setVisible(true)


    self._isRunningEffect = false
    if (self._effect:isPaused()) then
        self._effect:resume()
    end
    Avalon.Scheduler:scheduleUpdateOnce(self, self.effectCallback, 0.1)
end

function ClickFloorEffectComponent:effectCallback()
    if (not self._isRunningEffect and self._effect) then
        if(not tolua.isnull(self._effect)) then
            self._effect:pause()
        end
    end
end
