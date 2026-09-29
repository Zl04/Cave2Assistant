--TransPointNpcRender.lua
--2017-04-27
--Author:zp
--触发类NPC 传送点

require "app.renderer.Renderer"

local TRIGGER_NPC_TYPE = PublicDefine.TRIGGER_NPC_TYPE

Renderer = Renderer or {}

local TransPointNpcRender = class("TransPointNpcRender", Renderer.Base)
Renderer.TransPointNpcRender = TransPointNpcRender

-- private:
local DEBUG = false

-- private:
-- 构造函数
function TransPointNpcRender:ctor()
    TransPointNpcRender.super.ctor(self)
    self._showTransdoorNum = 0
    self._testPointNpc = true
    self._triggerNPCAnimation = nil
    self._isDarkGolden = false
    self._deformationAniamtion = nil
    self._transdoorUpAnimation = nil
end

-- 析构函数
function TransPointNpcRender:dtor()
    TransPointNpcRender.super.dtor(self)
    self._showTransdoorNum = 0
    self._triggerNPCAnimation = nil
    self._isDarkGolden = false
    if(not tolua.isnull(self._transdoorUpAnimation)) then
        self._transdoorUpAnimation:removeFromParent()
        self._transdoorUpAnimation = nil
    end
end

-- public:
-- 初始化
function TransPointNpcRender:init(skeleton, atlas, scale, npcType, isLock)
     -- 添加宝箱动画
    self._skeleton = skeleton
    self._atlas = atlas
    self._scale = scale
    self._triggerNPCAnimation = Avalon.Animation:create(skeleton.."_down.json", atlas, scale)
    self._triggerNPCAnimation:registerSpineEventHandler(function (event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- 播放音效文件
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

    Avalon.Scheduler:scheduleUpdateOnce(self, self.waitingLoadingUp, 0.01)

    self._npcType = npcType
    self._isLock = isLock

    if (self._triggerNPCAnimation) then
        self:addChild(self._triggerNPCAnimation,1)
    else
       assert(false, string.format("[ERROR] TransPointNpcRender init: create treasure animation (%s,%s,%f) failed.", skeleton, atlas, scale))
    end

    self._isDarkGolden = false
    self.lockUp = nil
    self.lockDown = nil

    self:idle()
    self:showLock()
    self:setVisible(false)
    self:setDefaultVisible(false)
end

-- 设置方向
function TransPointNpcRender:setDirection(direction)
    if (direction == DirectionType.EAST or
        direction == DirectionType.SOUTH) then
        self._triggerNPCAnimation:setScaleX(-1)
    else
        self._triggerNPCAnimation:setScaleX(1)
    end

    if DEBUG then
        print(string.format("TransPointNpcRender setDirection: set direction %d.", direction))
    end
end

-- 设置待机视图
function TransPointNpcRender:idle()
    if (self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setAnimation(0, "idle1", true)
    end
    if (self._transdoorUpAnimation) then
        self._transdoorUpAnimation:setAnimation(0, "idle1", true)
    end
end

-- 触发移除自己
function TransPointNpcRender:_triggerRemoveSelf()
    if (DEBUG) then
        print("TransPointNpcRender:_triggerRemoveSelf ")
    end

    self:remove()
end

-- 显示锁定
function TransPointNpcRender:showLock()
    if(self._isLock) then
        if (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.BOX or self._npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
            -- 添加锁定表现
            self:triggerTreasureLock()
        elseif (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE) then
            if (self._triggerNPCAnimation) then
                self._triggerNPCAnimation:setAnimation(0, "idle_lock", true)
            end
        else
            -- assert(false,string.format("TransPointNpcRender:showLock  is no handle NPCType = %d",self._npcType))
        end
    end
end


function TransPointNpcRender:unlock()
    self._isLock = false
    if (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.BOX or self._npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
        -- 移除锁定表现
        self:removeTreasureLock()
    elseif (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE) then
        self:idle()
    else
        -- assert(false,string.format("TransPointNpcRender:showLock  is no handle NPCType = %d",self._npcType))
    end

end

-- 入口高矮处理
function TransPointNpcRender:entranceShrink(isHeight)
    if(self._npcType == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE or self._npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE) then
        if(self._isHeight ~= isHeight) then
            self._isHeight = isHeight

            if(self._npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE) then
                if(self._isLock) then
                    if(self._isHeight == true) then
                        self._triggerNPCAnimation:setAnimation(0,"change2_2",false)
                        self._triggerNPCAnimation:addAnimation(0, "idle_lock1", true)
                    else
                        self._triggerNPCAnimation:setAnimation(0,"change2_1",false)
                        self._triggerNPCAnimation:addAnimation(0, "idle_lock2", true)
                    end
                else
                    if(self._isHeight == true) then
                        self._triggerNPCAnimation:setAnimation(0,"change1_2",false)
                        self._triggerNPCAnimation:addAnimation(0, "idle", true)
                    else
                        self._triggerNPCAnimation:setAnimation(0,"change1_1",false)
                        self._triggerNPCAnimation:addAnimation(0, "idle2", true)
                    end
                end
            else
                if(self._isHeight == true) then
                    self._triggerNPCAnimation:setAnimation(0,"change1_2",false)
                    self._triggerNPCAnimation:addAnimation(0, "idle", true)
                else
                    self._triggerNPCAnimation:setAnimation(0,"change1_1",false)
                    self._triggerNPCAnimation:addAnimation(0, "idle2", true)
                end
            end
        end
    end
end

function TransPointNpcRender:showTransdoorTrigger()
    print("TransPointNpcRender:showTransdoorTrigger")
    self._showTransdoorNum = self._showTransdoorNum + 1
    if(self._showTransdoorNum < 1) then 
        self._showTransdoorNum = 1
    end
    if(self._triggerNPCAnimation) then
        if(self._transdoorUpAnimation == nil) then
            local transdoorUpAnimation = Avalon.Animation:create(self._skeleton.."_up.json", self._skeleton..".atlas", self._scale)
            transdoorUpAnimation:setPosition(self._viewNode:getPosition())
            self._viewNode:getParent():addChild(transdoorUpAnimation, self._viewNode:getLocalZOrder() + 8000)

            transdoorUpAnimation:registerSpineEventHandler(function (event)
                if(event and event.eventData and event.eventData.name) then
                    local startPos = string.find(event.eventData.name, "sound_")
                    if(startPos ~= nil) then
                        -- 播放音效文件
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

            self._transdoorUpAnimation = transdoorUpAnimation
        end
        if(self._transdoorUpAnimation) then
            self._transdoorUpAnimation:setAnimation(0, "open1", true)
        end
        self._triggerNPCAnimation:setAnimation(0, "open1", true)
    else
        Net.NetNPCSystem:openTriggerNpcRequest(spriteID)
    end
end

-- 隐藏传送门显示
function TransPointNpcRender:hideTransdoorTrigger()
    -- print("TransPointNpcRender:hideTransdoorTrigger")
    if(self._transdoorUpAnimation) then
        -- print("TransPointNpcRender:hideTransdoorTrigger  2")
        self._transdoorUpAnimation:removeFromParent()
        -- self._transdoorUpAnimation:runAction(cc.RemoveSelf:create())
        self._transdoorUpAnimation = nil
    end
    local handle = false
    if(self._showTransdoorNum > 0) then
        handle = true
        self._showTransdoorNum = self._showTransdoorNum - 1
    end
    if(not self.transPointVisible and self._triggerNPCAnimation) then 
        if(self._showTransdoorNum <= 0 and handle) then 
            self._triggerNPCAnimation:setVisible(false)
        end
    end
    self:idle()
    self:showLock()
end

function TransPointNpcRender:showEnter()
    if(self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setVisible(true)
        self._triggerNPCAnimation:setAnimation(0, "enter", false)
        self._triggerNPCAnimation:addAnimation(0, "idle1", false)
    end
end

function TransPointNpcRender:showTransPointTrigger(callback)
    if(self._tansPointTriggerCallBack) then 
        self._tansPointTriggerCallBack()
        self._tansPointTriggerCallBack = nil
    end
    self._showTransdoorNum = self._showTransdoorNum + 1
    if(self._showTransdoorNum < 1) then 
        self._showTransdoorNum = 1
    end
    self._tansPointTriggerCallBack = callback
    if(self._triggerNPCAnimation) then
        self._triggerNPCAnimation:registerSpineEventHandler(function(event)
            local startPos = string.find(event.animation, "trigger")
            if (startPos ~= nil) then
                if(self._tansPointTriggerCallBack) then 
                    self._tansPointTriggerCallBack()
                    self._tansPointTriggerCallBack = nil
                end 
            end
        end, sp.EventType.ANIMATION_END)
        self._triggerNPCAnimation:setToSetupPose()
        self._triggerNPCAnimation:setVisible(true)
        self._triggerNPCAnimation:setAnimation(0, "trigger", false)
        self._triggerNPCAnimation:addAnimation(0, "idle1", false)
        if(self._openItCallBack) then 
            self._openItCallBack()
            self._openItCallBack = nil
        end
    else
        if(self._tansPointTriggerCallBack) then 
            self._tansPointTriggerCallBack()
            self._tansPointTriggerCallBack = nil
        end  
    end
end

-- 设施打开显示
function TransPointNpcRender:showOpenIt(recoverOpen, callback, isMaster)
    -- print("TransPointNpcRender:showOpenIt 1", recoverOpen, callback ~= nil, self._triggerNPCAnimation~= nil, self._startRunOpen ~= true)
    -- print(debug.traceback())
    if (self._triggerNPCAnimation and self._startRunOpen ~= true) then
        if(self._openItCallBack) then 
            self._openItCallBack()
            self._openItCallBack = nil
        end
        self._openItCallBack = callback
        if(isMaster) then
            self._startRunOpen = true
        end
        -- 处理触发移除
        self:_triggerRemoveSelf()
        -- print("TransPointNpcRender:showOpenIt 2", recoverOpen,  AvalonUtil.getCurrentTime())
        self._triggerNPCAnimation:setToSetupPose()
        self._triggerNPCAnimation:setVisible(true)
        self:removeDeformation()

        self.arrivalTime = false
        
        if recoverOpen then
            self._isDarkGolden = false
            self._triggerNPCAnimation:setAnimation(0, "idle1", false)
        else
            self._triggerNPCAnimation:setAnimation(0, "open1", false)
            self._triggerNPCAnimation:addAnimation(0,"idle1",false)
            if (self._transdoorUpAnimation) then
                self._transdoorUpAnimation:setAnimation(0, "open1", false)
            end
        end
        self._triggerNPCAnimation:setVisible(true)
        self._triggerNPCAnimation:registerSpineEventHandler(function(event)
            local startPos = string.find(event.animation, "open1")
            if (startPos ~= nil) then
                -- print("TransPointNpcRender:showOpenIt  4", self._visible, self.transPointVisible)
                if(not self.transPointVisible) then 
                    -- print("TransPointNpcRender:showOpenIt  5", self._visible, self.transPointVisible)
                    self._triggerNPCAnimation:setVisible(false)
                end
                if isMaster then
                    self._startRunOpen = nil
                end
                if(self._openItCallBack) then  
                    self._openItCallBack()
                    self._openItCallBack = nil
                end
            else 
                if isMaster then
                    self._startRunOpen = nil
                end
                -- if(self._openItCallBack) then  
                --     self._openItCallBack()
                --     self._openItCallBack = nil
                -- end
            end
        end, sp.EventType.ANIMATION_END)
    else 
        if(callback) then  
            callback()
            callback = nil
        end
    end
end


-- 显示获得暗金物品效果
function TransPointNpcRender:showGetDarkGoldenGoods(isDarkGolden,callback)
    -- 处理显示获得金色物品效果
    self._isDarkGolden = isDarkGolden

    if self.arrivalTime ~= nil and self.arrivalTime == true then
        callback()
        -- 添加表现
        if self._isDarkGolden then
            self._triggerNPCAnimation:setAnimation(1, "open2", false)
        end
    else
        self._callback = callback
    end
end

-- 渲染
function TransPointNpcRender:onDraw(dt)

end

-- 触发宝箱锁定效果
function TransPointNpcRender:triggerTreasureLock()
    if(self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setAnimation(0, "lock", true)
    end
end

-- 移除宝箱锁定效果
function TransPointNpcRender:removeTreasureLock()
    if(self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setAnimation(0, "idle", true)
    end
end

function TransPointNpcRender:showDeformation(skeletonFile, atlasFile, scale, idleName)
    if(self._deformationAniamtion) then
        self._deformationAniamtion:runAction(cc.RemoveSelf:create())
        self._deformationAniamtion = nil
    end

    -- 添加变身特效
    local deformationAnimation = Avalon.Animation:create("effect_role_hero_deformation.json", "effect_role_hero_deformation.atlas", 1)
    deformationAnimation:setAnimation(0, "deformation", false)
    deformationAnimation:registerSpineEventHandler(function (event)
        deformationAnimation:runAction(cc.RemoveSelf:create())
    end, sp.EventType.ANIMATION_END)

    deformationAnimation:registerSpineEventHandler(function (event)
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

    self:addChild(deformationAnimation, 6)
    
    -- 
    self._triggerNPCAnimation:setVisible(false)
    self._deformationAniamtion = Avalon.Animation:create(skeletonFile, atlasFile, 1)
    self._deformationAniamtion:setAnimation(0, idleName, true)

    self._deformationAniamtion:registerSpineEventHandler(function (event)
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

    self:addChild(self._deformationAniamtion, 5)
end

function TransPointNpcRender:waitingLoadingUp()
    if(self._transdoorUpAnimation == nil and not tolua.isnull(self._viewNode)) then
        local transdoorUpAnimation = Avalon.Animation:create(self._skeleton.."_up.json", self._skeleton..".atlas", self._scale)
        transdoorUpAnimation:setPosition(self._viewNode:getPosition())
        self._viewNode:getParent():addChild(transdoorUpAnimation, self._viewNode:getLocalZOrder() + 8000)

        transdoorUpAnimation:registerSpineEventHandler(function (event)
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    -- 播放音效文件
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

        self._transdoorUpAnimation = transdoorUpAnimation

        if (self._transdoorUpAnimation) then
            self._transdoorUpAnimation:setAnimation(0, "idle1", true)
        end
    end
end

function TransPointNpcRender:removeDeformation()
    if(self._deformationAniamtion) then
        self._deformationAniamtion:runAction(cc.RemoveSelf:create())
        self._deformationAniamtion = nil

        -- 添加变身特效
        local deformationAnimation = Avalon.Animation:create("effect_role_hero_deformation.json", "effect_role_hero_deformation.atlas", 1)
        deformationAnimation:setAnimation(0, "deformation", false)
        deformationAnimation:registerSpineEventHandler(function (event)
            deformationAnimation:runAction(cc.RemoveSelf:create())
        end, sp.EventType.ANIMATION_END)

        deformationAnimation:registerSpineEventHandler(function (event)
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    -- 播放音效文件
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

        self:addChild(deformationAnimation, 6)
    end

    self._triggerNPCAnimation:setVisible(true)
end

function TransPointNpcRender:setDefaultVisible( visible )
    self.transPointVisible = visible
end

function TransPointNpcRender:setVisible( visible )
    -- TransPointNpcRender.super.setVisible(self,visible)

    if self._triggerNPCAnimation then
        self._triggerNPCAnimation:setVisible(visible)
    end
    if self._npcAnimationRight then
        self._npcAnimationRight:setVisible(visible)
    end
end

function TransPointNpcRender:pause()
    TransPointNpcRender.super.pause(self)
    if(not tolua.isnull(self._triggerNPCAnimation)) then 
        self._triggerNPCAnimation:pause()
    end
    if(not tolua.isnull(self._npcAnimationRight)) then 
        self._npcAnimationRight:pause()
    end
end

function TransPointNpcRender:resume()
    TransPointNpcRender.super.resume(self)
    if(not tolua.isnull(self._triggerNPCAnimation)) then
        self._triggerNPCAnimation:resume()
    end
    if(not tolua.isnull(self._npcAnimationRight)) then 
        self._npcAnimationRight:resume()
    end
end