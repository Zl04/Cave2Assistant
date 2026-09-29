
--[[
    点击地面效果动画
 ]]

Component = Component or {}

local ClickFloorHitRatEffectComponent = class("ClickFloorHitRatEffectComponent",cc.Node)

Component.ClickFloorHitRatEffectComponent = ClickFloorHitRatEffectComponent
local MachineManager = require("app.game.MachineManager")

local DEBUG = false

function ClickFloorHitRatEffectComponent:ctor(pos)
    
    -- local master = MachineManager:getInstance():getMachine():getView():getMap():screenCenterToCoord(10, 3)
    -- coord.x = 20
    -- coord.y = 21
    -- self._map:screenCenterToCoord(coordX, coordY)

    -- MachineManager:getInstance():pushPositionRendererCommand(master, coord, true)
    local offsetX = (pos[5][1] - pos[1][1])*1.5
    local offsetY = (pos[5][2] - pos[1][2])*1.5
    self.effects = {}
    for i = 1, 9 do
        local effect = Avalon.Animation:create("effect_ui_common_map_point.json", "effect_ui_common_map_point.atlas", 1)
        effect:setPosition(cc.p(pos[i][1] - offsetX, pos[i][2] - offsetY))
        self:addChild(effect)
        table.insert(self.effects, effect)

        effect:registerSpineEventHandler(function (event)
            if(DEBUG) then
                print(string.format("ClickFloorHitRatEffectComponent:showEffect[spine] %d end  animation=",event.trackIndex),event.animation)
            end
    
            effect:setVisible(false)
        end, sp.EventType.ANIMATION_END)
    end

    self._isRunningEffect = false
end

function ClickFloorHitRatEffectComponent:setShowIdx(area)
    for key, effect in pairs(self.effects) do
        effect.isShow = false
        effect:setVisible(false)
    end

    for _, idx in ipairs(area) do
        local effect = self.effects[idx]
        effect.isShow = true
        effect:setVisible(true)
    end
end

function ClickFloorHitRatEffectComponent:destroy()
    if(DEBUG) then
        print("ClickFloorEffect:destory")
    end
    Avalon.Scheduler:unscheduleUpdate(self, self.effectCallback)
    for _, effect in pairs(self.effects) do
        if(effect) then
            effect:destroy()
        end
    end
    self.effects = {}
end

function ClickFloorHitRatEffectComponent:runEffect()
    if(DEBUG) then
        print("ClickFloorHitRatEffectComponent:runEffect  ")
    end

    for _, effect in pairs(self.effects) do
        if(effect and effect.isShow) then
            effect:resume()
        end
    end
    self._isRunningEffect = true

    -- if self._action then
    --     self._effect:stopAction(self._action)
    --     self._action = nil
    -- end
    -- 运行显示效果
    -- self._effect:setTimeScale(1)
end

function ClickFloorHitRatEffectComponent:removeEffect()
    for _, effect in pairs(self.effects) do
        if(effect) then
            effect:setVisible(false)
        end
    end
end

function ClickFloorHitRatEffectComponent:showHitEffect(viewVisible)
    if viewVisible then
        self:showEffect("point")
    else
        self:showEffect("point2")
    end
end

function ClickFloorHitRatEffectComponent:showInvalidEffect(viewVisible)
    if viewVisible then
        self:showEffect("pointdisable1")
    else
        self:showEffect("pointdisable1_2")
    end
end

function ClickFloorHitRatEffectComponent:showClickWallEffect(viewVisible)
    if viewVisible then
        self:showEffect("pointdisable2")
    else
        self:showEffect("pointdisable2_2")
    end
end

function ClickFloorHitRatEffectComponent:showClickWallLeftRoad(viewVisible)
    self:showEffect("pointdisable4")
end

function ClickFloorHitRatEffectComponent:showClickWallRightRoad(viewVisible)
    self:showEffect("pointdisable3")
end

function ClickFloorHitRatEffectComponent:showClickWallLeftRightRoad(viewVisible)
    self:showEffect("pointdisable2")
end

function ClickFloorHitRatEffectComponent:showEffect(animationName)
    if(DEBUG) then
        print("ClickFloorHitRatEffectComponent:showEffect  animationName=",animationName)
    end

    for _, effect in pairs(self.effects) do
        if(effect and effect.isShow) then
            effect:setAnimation(0, animationName, false)
            effect:setVisible(true)
            if (effect:isPaused()) then
                effect:resume()
            end
        end
    end

    self._isRunningEffect = false
    Avalon.Scheduler:scheduleUpdateOnce(self, self.effectCallback, 0.1)
end

function ClickFloorHitRatEffectComponent:effectCallback()
    if (not self._isRunningEffect and self.effects) then
        for _, effect in pairs(self.effects) do
            if(not tolua.isnull(effect)) then
                effect:pause()
            end
        end
    end
end
