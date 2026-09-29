--PatrolNPCRenderer.lua
--2017-04-27
--Author:zp
--触发类NPC 渲染器

require "app.renderer.Renderer"

local TRIGGER_NPC_TYPE = PublicDefine.TRIGGER_NPC_TYPE

Renderer = Renderer or {}

local PatrolNPCRenderer = class("PatrolNPCRenderer", Renderer.Base)
Renderer.PatrolNPCRenderer = PatrolNPCRenderer

-- private:
local DEBUG = false

-- private:
-- 构造函数
function PatrolNPCRenderer:ctor()
    PatrolNPCRenderer.super.ctor(self)

    -- 宝箱动画
    self._triggerNPCAnimation = nil
    self._isDarkGolden = false
    self._deformationAniamtion = nil
end

-- 析构函数
function PatrolNPCRenderer:dtor()
    PatrolNPCRenderer.super.dtor(self)

    self._triggerNPCAnimation = nil
    self._isDarkGolden = false
end

-- public:
-- 初始化
function PatrolNPCRenderer:init(skeleton, atlas, scale, npcType, isLock)
     -- 添加宝箱动画
     -- print(" PatrolNPCRenderer:init ",skeleton, atlas, scale)
    self._triggerNPCAnimation = Avalon.Animation:create(skeleton, atlas, scale)
    self._npcType = npcType

    if (self._triggerNPCAnimation) then
        self:addChild(self._triggerNPCAnimation,1)
    else
       assert(false, string.format("[ERROR] PatrolNPCRenderer init: create treasure animation (%s,%s,%f) failed.", skeleton, atlas, scale))
    end

    self:idle()
    self:registerSpineEventHandler()
end
-- 设置皮肤
function PatrolNPCRenderer:setSkin(skinName)
    if (self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setSkin(skinName)
    end
end

function PatrolNPCRenderer:speedUp(timeScale)
    if(self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setTimeScale(timeScale)
    end 
end

function PatrolNPCRenderer:showMove()
    self._triggerNPCAnimation:setAnimation(0, "move", true)
end

-- 设置方向
function PatrolNPCRenderer:setDirection(direction)
    if (direction == DirectionType.EAST or
        direction == DirectionType.SOUTH) then
        self._triggerNPCAnimation:setScaleX(-1)
    else
        self._triggerNPCAnimation:setScaleX(1)
    end

    if DEBUG then
        print(string.format("PatrolNPCRenderer setDirection: set direction %d.", direction))
    end
end

function PatrolNPCRenderer:showIDLE()
    if (self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setAnimation(0, "idle", true)
    end
end

-- 设置待机视图
function PatrolNPCRenderer:idle()
    if (self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setAnimation(0, "idle", true)
    end
end

function PatrolNPCRenderer:addBottomLittle()
    if(self._triggerNPCAnimation) then
        local bottomLittle = Avalon.Animation:create("effect_role_npc_bottom_light.json", "effect_role_npc_bottom_light.atlas", 1)
        bottomLittle:setAnimation(0, "idle", true)
        self._triggerNPCAnimation:addComponent("mount_bottomdown_npc", bottomLittle)
    end
end

-- 触发移除自己
function PatrolNPCRenderer:_triggerRemoveSelf()
    if (DEBUG) then
        print("PatrolNPCRenderer:_triggerRemoveSelf ")
    end

    if(self._removeSelfAfterTrigger) then
        self:remove()
    end
end

function PatrolNPCRenderer:getSpine()
    -- body
    return self._triggerNPCAnimation
end

-- 渲染
function PatrolNPCRenderer:onDraw(dt)

end

function PatrolNPCRenderer:registerSpineEventHandler()
    self._triggerNPCAnimation:registerSpineEventHandler(function (event)
        if(event.animation == "idle") then
            if self._idleNum == nil then
                self._idleNum = 0
            end
            self._idleNum = self._idleNum + 1
            if(self._idleNum >3) then
                if math.random(1,2) <=1 then
                    -- print("MonsterRenderer:_registerSpineEventHandler ANIMATION_COMPLETE run idle2")
                    self._idleNum = 0
                    self._triggerNPCAnimation:setAnimation(0, string.format("show%d", math.random(1,2)), false)
                    self._triggerNPCAnimation:addAnimation(0, "idle", true)
                end
            end
        end
    
    end, sp.EventType.ANIMATION_COMPLETE)
end

function PatrolNPCRenderer:setVisible( visible )
    PatrolNPCRenderer.super.setVisible(self,visible)

    if self._triggerNPCAnimation then
        self._triggerNPCAnimation:setVisible(visible)
    end
    -- print("PatrolNPCRenderer.setVisible",visible)
end

function PatrolNPCRenderer:pause()
    PatrolNPCRenderer.super.pause(self)
    if(not tolua.isnull(self._triggerNPCAnimation)) then
        self._triggerNPCAnimation:pause()
    end
end

function PatrolNPCRenderer:resume()
    PatrolNPCRenderer.super.resume(self)
    if(not tolua.isnull(self._triggerNPCAnimation)) then
        self._triggerNPCAnimation:resume()
    end
end