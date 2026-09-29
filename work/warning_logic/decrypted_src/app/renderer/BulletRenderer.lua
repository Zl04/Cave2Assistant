--[[
    子弹的渲染器
]]--

require "app.renderer.Renderer"

Renderer = Renderer or {}

local BulletRenderer = class("BulletRenderer", Renderer.Base)
Renderer.BulletRenderer = BulletRenderer

-- private:
local DEBUG = false

-- 构造函数
function BulletRenderer:ctor()
    -- print(string.format("BulletRenderer constructor: create the BulletRenderer %s.", self)) 

    BulletRenderer.super.ctor(self)

    -- 子弹动画
    self._bulletAnimation = nil
end

-- 析构函数
function BulletRenderer:dtor()
    -- print(string.format("BulletRenderer destructor: destroy the BulletRenderer %s.", self)) 
    
    BulletRenderer.super.dtor(self)

    self._bulletAnimation = nil
end

-- 初始化
function BulletRenderer:init(skeletonFile, atlasFile, scale)
    -- 添加宝箱动画
    self._bulletAnimation = Avalon.Animation:create(skeletonFile, atlasFile, scale)
    if (self._bulletAnimation) then
        self._bulletAnimation:setUnloadResFlag(false)
        self:addChild(self._bulletAnimation)

        self._bulletAnimation:registerSpineEventHandler(function (event)
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    -- TODO 播放音效文件
                    local soundFilename = string.sub(event.eventData.name,7,-1)
                    Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
                end

                local shakePos = string.find(event.eventData.name, "hitshake_")
                if(shakePos ~= nil) then
                    -- 播放抖动
                    local shake = string.sub(event.eventData.name,10,-1)
                    if(shake) then 
                        Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
                    end
                end
            end
        end, sp.EventType.ANIMATION_EVENT)
    else
       assert(false, string.format("[ERROR] BulletRenderer init: create bullet animation (%s,%s,%f) failed.", skeletonFile, atlasFile, scale))
    end

    self._fromAnimation = nil
    self._toAnimation = nil
    self._fromMount = nil
    self._toMount = nil
    self._flyTime = 0
    self._restFlyTime = 0

    self._startPosX = 0
    self._startPosY = 0
    self._startToFly = false
    self._endPosX = 0
    self._endPosY = 0
end

-- 设置待机视图
function BulletRenderer:idle()
    if (self._bulletAnimation) then
        self._bulletAnimation:setAnimation(0, "idle1", true)
    end
end

-- 设置子弹的状态
function BulletRenderer:setState(fromAnimation, fromMount, toAnimation, toMount, flyTime)
    self._fromAnimation = fromAnimation
    self._toAnimation = toAnimation
    self._fromMount = fromMount
    self._toMount = toMount
    self._flyTime = flyTime
    self._restFlyTime = flyTime

    local startPosX, startPosY = fromAnimation:getPositionOfSlot(fromMount)
    self._startPosX = startPosX
    self._startPosY = startPosY
    self:setPosition(startPosX, startPosY)

    self._startToFly = true
    self:showFly()
end

-- 显示飞行动画
function BulletRenderer:showFly()
    if (self._bulletAnimation) then
        self._bulletAnimation:setAnimation(0, "begin", false)
        self._bulletAnimation:addAnimation(0, "idle", true)
        self._bulletAnimation:registerSpineEventHandler(function(event)
            if event.animation == "end" then
                -- Avalon.Scheduler:scheduleUpdateOnce(self, function(self)
                --     self:remove()
                -- end, 0.0)
                self:remove()
            end
        end, sp.EventType.ANIMATION_END)
    end

    if (DEBUG) then
        print("BulletRenderer showFly: show fly animation.")
    end
end

-- 显示爆炸动画
function BulletRenderer:showBoom()
    if (self._bulletAnimation) then
        self._bulletAnimation:setToSetupPose()
        self._bulletAnimation:setAnimation(0, "trigger", false)
        self._bulletAnimation:addAnimation(0, "end", false)
    end

    if (DEBUG) then
        print("BulletRenderer showBoom: show boom animation.")
    end
end

-- 渲染
function BulletRenderer:onDraw(dt)
    if (self._startToFly) then
        if (self._restFlyTime <= 0) then
            self._startToFly = false
            self._bulletAnimation:setRotation(0)

            self:showBoom()
        else
            local startPosX, startPosY = self._startPosX, self._startPosY
            local endPosX, endPosY = 0.0, 0.0
            if (self._toAnimation) then endPosX, endPosY = self._toAnimation:getPositionOfSlot(self._toMount)
            else endPosX, endPosY = self._endPosX, self._endPosY
            end
            local restFlyTime = self._restFlyTime

            local disX = endPosX - startPosX
            local disY = endPosY - startPosY
            local offsetX = dt / restFlyTime * disX
            local offsetY = dt / restFlyTime * disY
            startPosX = startPosX + offsetX
            startPosY = startPosY + offsetY
            self:setPosition(startPosX, startPosY)

            local offsetX, offsetY = endPosX - startPosX, endPosY - startPosY
            local angle = (-1 * math.atan2(offsetY, offsetX) * 180.0 / 3.1415926) - 180.0
            self._bulletAnimation:setRotation(angle)

            self._startPosX = startPosX
            self._startPosY = startPosY
            self._restFlyTime = restFlyTime - dt
            self._endPosX = endPosX
            self._endPosY = endPosY
        end
    end
end
function BulletRenderer:setVisible( visible )
    BulletRenderer.super.setVisible(self,visible)

    if self._bulletAnimation then
        self._bulletAnimation:setVisible(visible)
    end
    
    -- print("BulletRenderer.setVisible",visible)
end