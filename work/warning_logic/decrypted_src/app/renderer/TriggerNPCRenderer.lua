--TriggerNPCRenderer.lua
--2017-04-27
--Author:zp
--触发类NPC 渲染器

require "app.renderer.Renderer"

local TRIGGER_NPC_TYPE = PublicDefine.TRIGGER_NPC_TYPE

Renderer = Renderer or {}

local TriggerNPCRenderer = class("TriggerNPCRenderer", Renderer.Base)
Renderer.TriggerNPCRenderer = TriggerNPCRenderer

-- private:
local DEBUG = false

-- private:
-- 构造函数
function TriggerNPCRenderer:ctor()
    TriggerNPCRenderer.super.ctor(self)

    -- 宝箱动画
    self._triggerNPCAnimation = nil
    self._isDarkGolden = false
    self._deformationAniamtion = nil

    -- 这里只是用于处理变形后的怪物的表现
    self.nickNameLabel = UI.Text:create()
    self.nickNameLabel:init(name, UI.FONT_ARIAL, UI.FONT_SIZE_20PX, UI.FONT_COLOR_WHITE)
    self.nickNameLabel:centerBottom(140)
    self.nickNameLabel:setVisible(false)
    self._viewNode:addChild(self.nickNameLabel, 100)
end

-- 析构函数
function TriggerNPCRenderer:dtor()
    TriggerNPCRenderer.super.dtor(self)

    self._triggerNPCAnimation = nil
    self._isDarkGolden = false
end

-- public:
-- 初始化
function TriggerNPCRenderer:init(skeleton, atlas, scale, npcType, isLock)
     -- 添加宝箱动画
     -- print(" TriggerNPCRenderer:init ",skeleton, atlas, scale)
    self._triggerNPCAnimation = Avalon.Animation:create(skeleton, atlas, scale)
    self._npcType = npcType
    self._isLock = isLock

    if (self._triggerNPCAnimation) then
        self:addChild(self._triggerNPCAnimation,1)
    else
       assert(false, string.format("[ERROR] TriggerNPCRenderer init: create treasure animation (%s,%s,%f) failed.", skeleton, atlas, scale))
    end

    self._isDarkGolden = false

    self:idle()
    self:showLock()

    self:registerSpineEventHandler()

    -- if(self._npcType == PublicDefine.TRIGGER_NPC_TYPE.DISAPPEAR_OBSTACLE) then
    --     self:addBottomLittle()
    -- end
end
-- 设置皮肤
function TriggerNPCRenderer:setSkin(skinName)
    if (self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setSkin(skinName)
    end
end

-- 设置方向
function TriggerNPCRenderer:setDirection(direction)
    if (direction == DirectionType.EAST or
        direction == DirectionType.SOUTH) then
        self._triggerNPCAnimation:setScaleX(-1)
    else
        self._triggerNPCAnimation:setScaleX(1)
    end

    if DEBUG then
        print(string.format("TriggerNPCRenderer setDirection: set direction %d.", direction))
    end
end

-- 设置待机视图
function TriggerNPCRenderer:idle()
    if (self._triggerNPCAnimation) then
        self._triggerNPCAnimation:setAnimation(0, "idle", true)
    end
end

function TriggerNPCRenderer:addBottomLittle()
    if(self._triggerNPCAnimation) then
        local bottomLittle = Avalon.Animation:create("effect_role_npc_bottom_light.json", "effect_role_npc_bottom_light.atlas", 1)
        bottomLittle:setAnimation(0, "idle", true)
        self._triggerNPCAnimation:addComponent("mount_bottomdown_npc", bottomLittle)
    end
end

-- 触发移除自己
function TriggerNPCRenderer:_triggerRemoveSelf()
    if (DEBUG) then
        print("TriggerNPCRenderer:_triggerRemoveSelf ")
    end

    if(self._removeSelfAfterTrigger) then
        self:remove()
    end
end

-- 显示锁定
function TriggerNPCRenderer:showLock()
    if(self._isLock) then
        if (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.BOX) then
            -- 添加锁定表现
            self:triggerTreasureLock()
        elseif (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE) then
            if (self._triggerNPCAnimation) then
                self._triggerNPCAnimation:setAnimation(0, "idle_lock", true)
            end
        else
            -- assert(false,string.format("TriggerNPCRenderer:showLock  is no handle NPCType = %d",self._npcType))
        end
    end
end


function TriggerNPCRenderer:unlock()
    self._isLock = false
    if (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.BOX) then
        -- 移除锁定表现
        self:removeTreasureLock()
    elseif (self._npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE) then
        self:idle()
    else
        -- assert(false,string.format("TriggerNPCRenderer:showLock  is no handle NPCType = %d",self._npcType))
    end

end

-- 入口高矮处理
function TriggerNPCRenderer:entranceShrink(isHeight)
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

function TriggerNPCRenderer:showTransdoorTrigger()
    -- print("TriggerNPCRenderer:showTransdoorTrigger ")
    if(self._triggerNPCAnimation) then
        -- print("TriggerNPCRenderer:showTransdoorTrigger 1")
        self._triggerNPCAnimation:setAnimation(0, "open1", true)

        self._triggerNPCAnimation:registerSpineEventHandler(function(event)
            -- print("TriggerNPCRenderer:registerSpineEventHandler  name=",event.eventData.name)
           
        end,sp.EventType.ANIMATION_COMPLETE)
        -- Net.NetNPCSystem:openTriggerNpcRequest(spriteID)
    else
        Net.NetNPCSystem:openTriggerNpcRequest(spriteID)
    end
end

-- 设施打开显示
function TriggerNPCRenderer:showOpenIt(recoverOpen, triggerRemoveSelf)
    if (self._triggerNPCAnimation) then
        --TODO 处理触发移除
        -- self:_triggerRemoveSelf()
        if (DEBUG) then
            print("TriggerNPCRenderer:showOpenIt", recoverOpen, triggerRemoveSelf)
        end
        self._removeSelfAfterTrigger = triggerRemoveSelf

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
    end
end


-- 显示获得暗金物品效果
function TriggerNPCRenderer:showGetDarkGoldenGoods(isDarkGolden,callback)
    -- 处理显示获得金色物品效果
    self._isDarkGolden = isDarkGolden

    if self.arrivalTime ~= nil and self.arrivalTime == true then
        callback()
        -- 添加表现
        if self._isDarkGolden then
            -- Avalon.AudioManager:playSound("1067")
            self._triggerNPCAnimation:setAnimation(1, "open2", false)
        end
    else
        self._callback = callback
    end
end

-- 渲染
function TriggerNPCRenderer:onDraw(dt)

end

-- 触发宝箱锁定效果
function TriggerNPCRenderer:triggerTreasureLock()
    self.lockUp = Avalon.Animation:create("effect_role_npc_treasure_seal.json", "effect_role_npc_treasure_seal.atlas", 1.0);
    self.lockDown = Avalon.Animation:create("effect_role_npc_treasure_seal.json", "effect_role_npc_treasure_seal.atlas", 1.0);

    self.lockUp:setAnimation(0,"idle",true)
    self.lockDown:setAnimation(0,"idle_down",true)

    self.lockUp:registerSpineEventHandler(function (event)
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

    self.lockDown:registerSpineEventHandler(function (event)
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

    self:addChild(self.lockDown,0)
    self:addChild(self.lockUp,2)
end

-- 移除宝箱锁定效果
function TriggerNPCRenderer:removeTreasureLock()
    if(self.lockUp) then
        self.lockUp:setAnimation(0,"open1",false)
    end
    if(self.lockDown) then
        self.lockDown:setAnimation(0,"open_down",false)

        self.lockDown:registerSpineEventHandler(function(event)
            -- print("TriggerNPCRenderer:removeTreasureLock end animation=",event.animation)
            if event.animation == "open_down" then
                self.lockUp:runAction(cc.RemoveSelf:create())
                self.lockDown:runAction(cc.RemoveSelf:create())
            end
            
        end, sp.EventType.ANIMATION_END)
    end
end

function TriggerNPCRenderer:registerSpineEventHandler()
    self._triggerNPCAnimation:registerSpineEventHandler(function(event)
        -- print("TriggerNPCRenderer:registerSpineEventHandler ",event.animation)
        if(self._npcType == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE  and self._npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE ) then
            if(event.animation == "open1" or event.animation == "open2") then 
                self:remove()
            end
        else
            -- print("TriggerNPCRenderer:registerSpineEventHandler 2",event.animation.name)
            if(event.animation == "open1" or event.animation == "open2") then 
                self:_triggerRemoveSelf()
            end
        end
    end, sp.EventType.ANIMATION_END)

    self._triggerNPCAnimation:registerSpineEventHandler(function (event)
        -- print("TriggerNPCRenderer:registerSpineEventHandler  name=",event.eventData.name)
        if event.eventData.name == "trigger_get_goods" then
            -- TODO 
            -- print("TriggerNPCRenderer:registerSpineEventHandler  trigger_get_goods")
            if self._callback then
                -- print("TriggerNPCRenderer:registerSpineEventHandler  _callback")
                self._callback()
                if self._isDarkGolden then
                    self._triggerNPCAnimation:setAnimation(1, "open2", false)
                end
                self._callback = nil
            end
            self.arrivalTime = true
        end

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
end

-- 处理更新名字显示
function TriggerNPCRenderer:updateName(name, isShow, isMaster, color)
    if DEBUG then
        print("TriggerNPCRenderer:updateName ",name,isShow,color)
    end
    
    -- if (isShow == nil) then isShow = true end

    if (name) then self.nickNameLabel:setText(name) end
    if (color) then self.nickNameLabel:setFontColor(color) end
    if (isShow ~= nil and self._isShowName ~= isShow) then
        self._isShowName = isShow
        self.nickNameLabel:stopAllActions()
        if (isShow) then
            self.nickNameLabel:setVisible(true)
            self.nickNameLabel:runAction(cc.FadeIn:create(0.5))
        else
            self.nickNameLabel:runAction(cc.Sequence:create(
                cc.FadeOut:create(0.5),
                cc.CallFunc:create(function() self.nickNameLabel:setVisible(false) end)
            ))
        end
        
        self:_refreshNickNamePosition()
    end
end

function TriggerNPCRenderer:_refreshNickNamePosition()
    if(self.nickNameLabel) then 
        local size = nil
        if(self._deformationAniamtion) then
            size = self._deformationAniamtion:getBoundingBox()
        else 
            if(self._triggerNPCAnimation) then
                size = self._triggerNPCAnimation:getBoundingBox()
            end 
        end

        if(size) then
            if (size.height > 200) then size.height = 200 end
            self.nickNameLabel:centerBottom(size.height+10)
        end
    end 
end

function TriggerNPCRenderer:showDeformation(skeletonFile, atlasFile, scale, idleName)
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

    self._deformationAniamtion:setLoadedSpineSuccessCallBack(function ()
        self._deformationAniamtion:runAction(cc.Sequence:create(cc.DelayTime:create(0.02),cc.CallFunc:create(function()
            self:_refreshNickNamePosition()
        end)))
    end)
end

function TriggerNPCRenderer:removeDeformation()
    self._isShowName = nil 
    self.nickNameLabel:setVisible(false)

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

function TriggerNPCRenderer:setVisible( visible )
    TriggerNPCRenderer.super.setVisible(self,visible)

    for i = 1, #self._lightAnimationList do
        local animation = self._lightAnimationList[i]
        if not tolua.isnull(animation) then
            animation:setVisible(visible)
        end
    end
    
    -- print("TriggerNPCRenderer.setVisible",visible)
end

function TriggerNPCRenderer:pause()
    TriggerNPCRenderer.super.pause(self)
    if(not tolua.isnull(self._triggerNPCAnimation)) then
        self._triggerNPCAnimation:pause()
    end
    if(not tolua.isnull(self.lockUp)) then
        self.lockUp:pause()
    end
    if(not tolua.isnull(self.lockDown)) then
        self.lockDown:pause()
    end
    if(not tolua.isnull(self._deformationAniamtion)) then
        self._deformationAniamtion:pause()
    end
end

function TriggerNPCRenderer:resume()
    TriggerNPCRenderer.super.resume(self)
    if(not tolua.isnull(self._triggerNPCAnimation)) then
        self._triggerNPCAnimation:resume()
    end
    if(not tolua.isnull(self.lockUp)) then
        self.lockUp:resume()
    end
    if(not tolua.isnull(self.lockDown)) then
        self.lockDown:resume()
    end
    if(not tolua.isnull(self._deformationAniamtion)) then
        self._deformationAniamtion:resume()
    end
end

function TriggerNPCRenderer:runRoleAnimations(animations)
    if(self._triggerNPCAnimation and animations) then
        for k, v in ipairs(animations) do
            if(k == 1) then 
                self._triggerNPCAnimation:setAnimation(0, v[1], v[2])
            else
                self._triggerNPCAnimation:addAnimation(0, v[1], v[2])
            end
        end
    end
end