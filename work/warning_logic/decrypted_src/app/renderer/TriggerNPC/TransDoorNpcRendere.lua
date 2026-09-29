--TransDoorNpcRendere.lua
--2017-04-27
--Author:zp
--触发类NPC 传送门

require "app.renderer.Renderer"

local TRIGGER_NPC_TYPE = PublicDefine.TRIGGER_NPC_TYPE

Renderer = Renderer or {}

local TransDoorNpcRendere = class("TransDoorNpcRendere", Renderer.Base)
Renderer.TransDoorNpcRendere = TransDoorNpcRendere

-- private:
local DEBUG = false

-- private:
-- 构造函数
function TransDoorNpcRendere:ctor()
    TransDoorNpcRendere.super.ctor(self)

    self._triggerNPCAnimation = nil
    self._isDarkGolden = false
    self._deformationAniamtion = nil
    self._transdoorUpAnimation = nil
end

-- 析构函数
function TransDoorNpcRendere:dtor()
    TransDoorNpcRendere.super.dtor(self)

    self._triggerNPCAnimation = nil
    self._isDarkGolden = false
    if(not tolua.isnull(self._transdoorUpAnimation)) then
        self._transdoorUpAnimation:removeFromParent()
        self._transdoorUpAnimation = nil
    end
end

-- public:
-- 初始化
function TransDoorNpcRendere:init(skeleton, atlas, scale, npcType, isLock)
     -- 添加宝箱动画
    self._skeleton = skeleton
    self._atlas = atlas
    self._scale = scale
    self._triggerNPCAnimation = Avalon.Animation:create(skeleton.."_down.json", atlas, scale)
    self._triggerNPCAnimation:registerSpineEventHandler(function (event)
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

    self._npcType = npcType
    self._isLock = isLock

    if (self._triggerNPCAnimation) then
        self:addChild(self._triggerNPCAnimation,1)
    else
       assert(false, string.format("[ERROR] TransDoorNpcRendere init: create treasure animation (%s,%s,%f) failed.", skeleton, atlas, scale))
    end

    self._isDarkGolden = false
    self.lockUp = nil
    self.lockDown = nil

    self:idle()
    self:showLock()
end

-- 设置方向
function TransDoorNpcRendere:setDirection(direction)
    if (direction == DirectionType.EAST or
        direction == DirectionType.SOUTH) then
        self._triggerNPCAnimation:setScaleX(-1)
    else
        self._triggerNPCAnimation:setScaleX(1)
    end

    if DEBUG then
        print(string.format("TransDoorNpcRendere setDirection: set direction %d.", direction))
    end
end

-- 设置待机视图
function TransDoorNpcRendere:idle()
    if (self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setAnimation(0, "idle", true)
    end
end

-- 触发移除自己
function TransDoorNpcRendere:_triggerRemoveSelf()
    if (DEBUG) then
        print("TransDoorNpcRendere:_triggerRemoveSelf ")
    end

    self:remove()
end

-- 显示锁定
function TransDoorNpcRendere:showLock()
    if(self._isLock) then
        if (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.BOX or self._npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
            -- 添加锁定表现
            self:triggerTreasureLock()
        elseif (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE) then
            if (self._triggerNPCAnimation) then
                self._triggerNPCAnimation:setAnimation(0, "idle_lock", true)
            end
        else
            -- assert(false,string.format("TransDoorNpcRendere:showLock  is no handle NPCType = %d",self._npcType))
        end
    end
end


function TransDoorNpcRendere:unlock()
    self._isLock = false
    if (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.BOX or self._npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
        -- 移除锁定表现
        self:removeTreasureLock()
    elseif (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE) then
        self:idle()
    else
        -- assert(false,string.format("TransDoorNpcRendere:showLock  is no handle NPCType = %d",self._npcType))
    end

end

-- 入口高矮处理
function TransDoorNpcRendere:entranceShrink(isHeight)
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

function TransDoorNpcRendere:showTransdoorTrigger()
    if(self._triggerNPCAnimation) then
        if(self._transdoorUpAnimation == nil) then
            local transdoorUpAnimation = Avalon.Animation:create(self._skeleton.."_up.json", self._skeleton..".atlas", self._scale)
            transdoorUpAnimation:setAnimation(0, "open1", true)
            transdoorUpAnimation:setPosition(self._viewNode:getPosition())
            self._viewNode:getParent():addChild(transdoorUpAnimation, self._viewNode:getLocalZOrder() + 8000)

            transdoorUpAnimation:registerSpineEventHandler(function (event)
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

            self._transdoorUpAnimation = transdoorUpAnimation

            self._triggerNPCAnimation:setAnimation(0, "open1", true)
        end
    else
        Net.NetNPCSystem:openTriggerNpcRequest(spriteID)
    end
end

-- 隐藏传送门显示
function TransDoorNpcRendere:hideTransdoorTrigger()
    -- print("TransDoorNpcRendere:hideTransdoorTrigger")
    if(self._transdoorUpAnimation) then
        -- print("TransDoorNpcRendere:hideTransdoorTrigger  2")
        self._transdoorUpAnimation:removeFromParent()
        -- self._transdoorUpAnimation:runAction(cc.RemoveSelf:create())
        self._transdoorUpAnimation = nil
    end

    self:idle()
    self:showLock()
end

-- 设施打开显示
function TransDoorNpcRendere:showOpenIt(recoverOpen)
    if (self._triggerNPCAnimation) then
        --TODO 处理触发移除
        self:_triggerRemoveSelf()

        self._triggerNPCAnimation:setToSetupPose()
        self._triggerNPCAnimation:setVisible(true)
        self:removeDeformation()

        self.arrivalTime = false
        self._triggerNPCAnimation:setVisible(true)
        if recoverOpen then
            self._isDarkGolden = false
            self._triggerNPCAnimation:setAnimation(0, "end", true)
        else
            if((self._npcType == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE or self._npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE ) and self._isHeight == false) then
                self._triggerNPCAnimation:setAnimation(0, "open2", false)
                self._triggerNPCAnimation:addAnimation(0,"end",true)
            else
                self._triggerNPCAnimation:setAnimation(0, "open1", false)
                self._triggerNPCAnimation:addAnimation(0,"end",true)
            end
        end
        
        self._triggerNPCAnimation:registerSpineEventHandler(function(event)
            print("TransDoorNpcRendere:registerSpineEventHandler  name=",event.eventData.name)
           
        end,sp.EventType.ANIMATION_EVENT)

        self._triggerNPCAnimation:registerSpineEventHandler(function(event)
            print("TransDoorNpcRendere:registerSpineEventHandler  name=",event.eventData.name)
            if event.eventData.name == "trigger_get_goods" then
                -- TODO 
                print("TransDoorNpcRendere:registerSpineEventHandler  trigger_get_goods")
                if self._callback then
                    print("TransDoorNpcRendere:registerSpineEventHandler  _callback")
                    self._callback()
                    if self._isDarkGolden then
                        self._triggerNPCAnimation:setAnimation(1, "open2", false)
                    end
                    self._callback = nil
                end
                self.arrivalTime = true
            end
        end,sp.EventType.ANIMATION_EVENT)
    end
end


-- 显示获得暗金物品效果
function TransDoorNpcRendere:showGetDarkGoldenGoods(isDarkGolden,callback)
    -- TODO 处理显示获得金色物品效果
    print("TransDoorNpcRendere:showGetDarkGoldenGoods  ")
    self._isDarkGolden = isDarkGolden

    if self.arrivalTime ~= nil and self.arrivalTime == true then
        print("TransDoorNpcRendere:showGetDarkGoldenGoods  _callback")
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
function TransDoorNpcRendere:onDraw(dt)

end

-- 触发宝箱锁定效果
function TransDoorNpcRendere:triggerTreasureLock()
    if(self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setAnimation(0, "lock", true)
    end
end

-- 移除宝箱锁定效果
function TransDoorNpcRendere:removeTreasureLock()
    if(self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setAnimation(0, "idle", true)
    end
end

function TransDoorNpcRendere:showDeformation(skeletonFile, atlasFile, scale, idleName)
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

function TransDoorNpcRendere:removeDeformation()
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
    end

    self._triggerNPCAnimation:setVisible(true)
end
function TransDoorNpcRendere:setVisible( visible )
    TransDoorNpcRendere.super.setVisible(self,visible)

    if self._triggerNPCAnimation then
        self._triggerNPCAnimation:setVisible(visible)
    end
    if self._npcAnimationRight then
        self._npcAnimationRight:setVisible(visible)
    end
    
    -- print("TransDoorNpcRendere.setVisible",visible)
end


function TransDoorNpcRendere:pause()
    TransDoorNpcRendere.super.pause(self)
    if(not tolua.isnull(self._triggerNPCAnimation)) then 
        self._triggerNPCAnimation:pause()
    end
    if(not tolua.isnull(self._npcAnimationRight)) then 
        self._npcAnimationRight:pause()
    end
end

function TransDoorNpcRendere:resume()
    TransDoorNpcRendere.super.resume(self)
    if(not tolua.isnull(self._triggerNPCAnimation)) then  
        self._triggerNPCAnimation:resume()
    end
    if(not tolua.isnull(self._npcAnimationRight)) then 
        self._npcAnimationRight:resume()
    end
end