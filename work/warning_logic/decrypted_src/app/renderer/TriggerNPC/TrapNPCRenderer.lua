--[[
    陷阱npc的渲染器
]]

require "app.renderer.Renderer"

Renderer = Renderer or {}
local TrapNPCRenderer = class("TrapNPCRenderer", Renderer.Base)
Renderer.TrapNPCRenderer = TrapNPCRenderer

-- private:
local DEBUG = false

-- 遍历次视图列表
local function traverseAnimationList(animationList, callback)
    if (animationList and callback) then
        for i, animation in pairs(animationList) do
            callback(animation)
        end
    end
end

-- private:
-- 构造函数
function TrapNPCRenderer:ctor()
    TrapNPCRenderer.super.ctor(self)

    -- npc动画列表
    self._npcAnimationList = {}
    -- npc出发效果动画
    self._effectAnimationList = {}
    -- 类型
    self._npcType = PublicDefine.TRIGGER_NPC_TYPE.TRAP
    -- 是否锁定
    self._configData = nil

    self._playSound = false
end

-- 析构函数
function TrapNPCRenderer:dtor()
    TrapNPCRenderer.super.dtor(self)

    -- 移除所有表现
    self:removeAllAnimation()

    self._effectAnimationList = nil

    self._configData = nil
    self._playSound = false
end

function TrapNPCRenderer:removeAllAnimation()
    for i = 1, #self._npcAnimationList do
        local npcAnimation = self._npcAnimationList[i]
        if (npcAnimation:getParent()) then
            npcAnimation:runAction(cc.RemoveSelf:create())
        else
            npcAnimation:destroy()
        end
        npcAnimation:release()
    end
    self._npcAnimationList = {}

    for i = 1, #self._effectAnimationList do 
        local effectAnimation = self._effectAnimationList[i]
        if (effectAnimation) then
            effectAnimation:runAction(cc.RemoveSelf:create())
        end
        effectAnimation:release()
    end

    self._effectAnimationList = {}
end

-- public:
-- 初始化
-- @npcID 陷阱的类型（通过id判断）
-- @spine 陷阱的动画名字
-- @size 陷阱的尺寸（只能是奇数）
-- @isDown 陷阱在角色下方还是上方
function TrapNPCRenderer:init(configData)
    self._configData = configData

    local skeleton = configData.skeleton
    local atlas = configData.atlas
    local size = self._configData.size
    for i = 1, size[1] * size[2] do
        local npcAnimation = Avalon.Animation:create(skeleton, atlas, 1.0)
        npcAnimation:retain()
        table.insert(self._npcAnimationList, npcAnimation)

        npcAnimation:registerSpineEventHandler(function (event)
            if(event.eventData.name == "voice") then
                if(self._playSound) then
                    Avalon.AudioManager:playSoundByConfig("25", self._configData.trapID, nil, self:getCoord())
                    self._playSound = false
                end
            end

            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    local soundFilename = string.sub(event.eventData.name,7,-1)
                    Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
                    self._playSound = false
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

    self:idle()
end

-- 设置待机视图
function TrapNPCRenderer:idle()
    local isDown = self._configData.isDown
    local animationTypeCount = self._configData.idleCount
    
    traverseAnimationList(self._npcAnimationList, function(animation)
        local idleType = math.random(1, animationTypeCount)
        local idleAnimationName = "idle_"..idleType

        animation:setAnimation(0, idleAnimationName, true)
    end)
end

-- 设施打开显示
function TrapNPCRenderer:showOpenIt(recoverOpen)
    if(DEBUG) then
        print("TrapNPCRenderer:showOpenIt ================== ", recoverOpen)
    end
    traverseAnimationList(self._npcAnimationList, function(animation)
        animation:setAnimation(0, "end_1", true)
        animation:registerSpineEventHandler(function (event)
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    local soundFilename = string.sub(event.eventData.name,7,-1)
                    Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
                    self._playSound = false
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
    end)
end

-- 显示背触发的动画
-- @size 效果范围
-- @loop 是否循环
function TrapNPCRenderer:trigger(isOpen)
    local isFirstTrigger = false
    local this = self

    self._playSound = true
    if(DEBUG) then
        print("TrapNPCRenderer:trigger  start wwwwww=", self._configData.hitShake, self._configData.triggerCount)
    end
    -- 陷阱本身的触发效果
    local triggerTypeCount = self._configData.triggerCount
    local idleTypeCount = self._configData.idleCount

    self._triggerHitFlag = true

    if(triggerTypeCount > 0) then
        local npcAnimationCount = #self._npcAnimationList
        if(DEBUG) then
            print("TrapNPCRenderer:trigger  2 wwwwww=", npcAnimationCount)
        end
        for i = 1, npcAnimationCount do
            local triggerType = math.random(1, triggerTypeCount)
            local triggerAnimationName = "trigger_"..triggerType
            local idleType = math.random(1, idleTypeCount)
            local idleAnimationName = "idle_"..idleType

            if(isOpen) then
                idleAnimationName = "end_1"
            end

            if(self._triggerHitFlag) then
                self:_triggerHit()
            end
            -- doEffectTiming
            -- hitFeedBack = trapData:getHitFeedBack(),
            -- hitShake = trapData:getHitShake(),
            -- hitFreeze = trapData:getHitFreeze()

            -- print("TrapNPCRenderer trigger  ", i, triggerAnimationName, idleAnimationName)

            local npcAnimation = self._npcAnimationList[i]
            npcAnimation:setAnimation(0, triggerAnimationName, false)
            npcAnimation:addAnimation(0, idleAnimationName, true)

            -- if(i == 1) then
            --     print("TrapNPCRenderer:trigger  2222",self._configData.trapID)
            --     npcAnimation:registerSpineEventHandler(function(event)
            --         local startPos = string.find(event.animation, "trigger")
            --         if (startPos ~= nil) then
            --             print("TrapNPCRenderer:trigger  2222333",self._configData.trapID)
            --             self:_triggerRemoveSelf()
            --         end
            --     end, sp.EventType.ANIMATION_END)
            -- end 

            if(i == 1) then
                npcAnimation:registerSpineEventHandler(function(event)
                    if(self._configData.removeAfterTrigger) then
                        local startPos = string.find(event.animation, triggerAnimationName)
                        if (startPos ~= nil) then
                            self:_triggerRemoveSelf()
                        end
                    end
                end, sp.EventType.ANIMATION_END)
            end
        end
    end

    -- 陷阱触发的效果
    local count = #self._effectAnimationList
    local size = self._configData.effectSize
    if (count == 0 and size[1] >= 1) then
        local skeleton = self._configData.skeleton
        local atlas = self._configData.atlas
        for i = 1, size[1] * size[2] do 
            local effectAnimation = Avalon.Animation:create(skeleton, atlas, 1.0)
            effectAnimation:registerSpineEventHandler(function(event)
                effectAnimation:setVisible(false)   
                -- 根据陷阱特性做了调整
                -- this:remove()
                -- print("TrapNPCRenderer setvisible ")
            end, sp.EventType.ANIMATION_END)
            effectAnimation:retain()

            if(self._triggerHitFlag) then
                self:_triggerHit()
            end

            effectAnimation:registerSpineEventHandler(function (event)
                -- print("TrapNPCRenderer ANIMATION_EVENT ", event.eventData.name, self._playSound)
                if(event.eventData.name == "voice") then
                    if(self._playSound) then
                        -- print("TrapNPCRenderer ANIMATION_EVENT 2")
                        Avalon.AudioManager:playSoundByConfig("25", self._configData.trapID, nil, self:getCoord())
                        self._playSound = false
                    end
                end

                if(event and event.eventData and event.eventData.name) then
                    local startPos = string.find(event.eventData.name, "sound_")
                    if(startPos ~= nil) then
                        local soundFilename = string.sub(event.eventData.name,7,-1)
                        Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
                        self._playSound = false
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

            -- print("TrapNPCRenderer trigger ", i)
            table.insert(self._effectAnimationList, effectAnimation)
        end

        isFirstTrigger = true
    end

    local effectTypeCount = self._configData.effectCount
    for i = 1, #self._effectAnimationList do
        local effectType = math.random(1, effectTypeCount)
        local effectAnimationName = "trigger_effect_"..effectType

        local effectAnimation = self._effectAnimationList[i]
        local isFind = effectAnimation:setAnimation(0, effectAnimationName, false)
        if isFind then
            effectAnimation:setVisible(true)
        else
            effectAnimation:setVisible(false)
        end
    end

    if (isFirstTrigger) then
        return self._effectAnimationList, self._configData.effectIsDown
    else
        return nil
    end
end

-- 获取陷阱的动画列表
function TrapNPCRenderer:getViewList()
    return self._npcAnimationList, self._configData.isDown
end

-- 获取陷阱的效果范围
function TrapNPCRenderer:getEffectSize()
    return self._configData.effectSize
end

function TrapNPCRenderer:onDraw(dt)
end

function TrapNPCRenderer:_triggerHit()
    -- 处理陷阱的震动效果
    -- if(DEBUG) then
    --     print("TrapNPCRenderer:trigger wwwwww=", self._configData.hitShake)
    -- end
    if(self._triggerHitFlag) then
        self._triggerHitFlag = false
        if(self._configData.hitShake > 0) then
            local effectTimeList = AvalonUtil:splitStr(self._configData.doEffectTiming, ",")
            if(effectTimeList and #effectTimeList ==1) then
                Avalon.Scheduler:scheduleUpdateOnce(self, function()
                    if(self and self._configData) then
                        Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, self._configData.hitShake, 2)
                    end
                end, tonumber(effectTimeList[1]) / 1000)
            end
        end 
    end
end

function TrapNPCRenderer:_triggerRemoveSelf()
    local removeSelf = self._configData.removeAfterTrigger
    -- 根据数值判断是否移除自己
    if (DEBUG) then
        print("TrapNPCRenderer:_triggerRemoveSelf ",removeSelf)
    end

    if removeSelf then
        self:remove()
        -- self:removeAllAnimation()
    else 
       
    end
end
function TrapNPCRenderer:setVisible( visible )
    TrapNPCRenderer.super.setVisible(self,visible)

    for i = 1, #self._npcAnimationList do
        local npcAnimation = self._npcAnimationList[i]
        if not tolua.isnull(npcAnimation) then
            npcAnimation:setVisible(visible)
        end
    end
    

    for i = 1, #self._effectAnimationList do 
        local effectAnimation = self._effectAnimationList[i]
        if not tolua.isnull(effectAnimation) then
            effectAnimation:setVisible(visible)
        end
    end
    
    -- print("TrapNPCRenderer.setVisible",visible)
end

function TrapNPCRenderer:pause()
    TrapNPCRenderer.super.pause(self)
    if(self._npcAnimationList) then 
        for k, v in pairs(self._npcAnimationList) do 
            if(not tolua.isnull(v)) then 
                v:pause()
            end
        end
    end
end

function TrapNPCRenderer:resume()
    TrapNPCRenderer.super.resume(self)
    if(self._npcAnimationList) then 
        for k, v in pairs(self._npcAnimationList) do 
            if(not tolua.isnull(v)) then 
                v:resume()
            end
        end
    end
end