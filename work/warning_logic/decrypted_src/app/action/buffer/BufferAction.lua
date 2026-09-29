--[[
    buffer行为
]]--

require "app.action.Action"
require "app.object.buffer.Buffer"
local MachineManager = require("app.game.MachineManager")
local SceneManager = require("app.game.SceneManager")
Action = Action or {}

local BufferAction = class("BufferAction", Action.Base)
Action.BufferAction = BufferAction

-- private:
local DEBUG_ADD_EFFECT = false

local function executeEffect(self, effectID)
    if (effectID > 0) then
        local effect = Model.Effect:create(true)
        effect:initByID(effectID)

        local effectAction = Action.EffectAction:create(true)
        effectAction:init(effect, self._bufferTarget)
        MachineManager:getInstance():addAction(effectAction)
    end
end

local function removeBuffToUI(buffer, bufferTarget)

    local bufferData = buffer:getBufferData()
    local entityID = buffer:getEntityID()
    -- 发送buffer移除的消息
    Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REMOVE_BUFFER, {
        bufferData = buffer:getBufferData(),
        bufferEntityID = entityID,
        bufferTargetID = bufferTarget:getSpriteID()
    })
    -- 显示buffer的特效
    local state = bufferTarget:getState()
    -- if (state ~= Game.FSMState.DIE) then
    -- add by zp 在添加了循环buff 效果的时候一直没有移除，处理该问题把判断是否死亡给注释掉
    -- if (bufferTarget:getIsDead() == false) then
        local buffData = buffer:getBufferData()
        if(buffData) then
            local rendererCommand = Command.RendererCommand:create(true)
            rendererCommand:initRemoveBufferCommand(
                bufferTarget:getId(), 
                entityID,
                buffData:getFXAnimationPrefixList()
            )
            SceneManager:getInstance():pushCommand(rendererCommand)
        end
    -- end
end

local function triggerHit(self)
    if(self._bufferTarget and self._buffData) then
        local effectTimeList = self._buffData:getEffectTimeList()
        if(effectTimeList and #effectTimeList >= self._hitIndex) then
            if(self._preRunTime >= effectTimeList[self._hitIndex]) then
                self._hitIndex = self._hitIndex + 1
                
                if(self._buffData:getHitFeedBack() ~= 0) then
                    -- 抖动和闪红
                    local animationCommand = Command.RendererCommand:create(true)
                    animationCommand:initRoleHitShack(self._bufferTarget:getId())
                    SceneManager:getInstance():pushCommand(animationCommand)
                end

                if(self._buffData:getHitShake() ~= 0) then
                    -- 屏幕抖动
                    Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, self._buffData:getHitShake(), 2)
                end

                if(self._buffData:getHitFreeze() > 0) then
                    -- 定帧
                    ToolsUtil:cardFrame(skillData:getHitFreeze())
                end
            end
        end
    end
end

-- public:
-- 创建对象
local BufferActionPool = nil
function BufferAction:create(reused, ...)
    if (reused) then
        if (not BufferActionPool) then
            BufferActionPool = Pool.Pool:create(BufferAction)
        end
        return BufferActionPool:applyObject()
    else
        return BufferAction.new(...)
    end
end

-- 构造函数
function BufferAction:ctor()
    BufferAction.super.ctor(self, ActionType.BUFFER)

    self._bufferID = 0
    self._entityID = 0
    self._bufferCaster = nil
    self._bufferTarget = nil
    -- self._duration = 0
    -- self._overlayNum = 0
    self._effectTimeList = nil
    self._entityIDList = {}

    self._buffData = nil

    self._preRunTime = 0
    self._hitIndex = 1
end

-- 模版函数：销毁
function BufferAction:dtor()
    BufferAction.super.dtor(self)

    self._bufferCaster = nil
    self._bufferTarget = nil
    self._effectTimeList = nil
    self._entityIDList = nil

    self._buffData = nil
    self._preRunTime = 0
    self._hitIndex = 1
end

-- 初始化
function BufferAction:init(buffer, bufferCaster, bufferTarget)
    BufferAction.super.init(self, buffer)
    self._buffData = buffer:getBufferData()

    self._bufferCaster = bufferCaster
    self._bufferTarget = bufferTarget
    self._effectTimeList = buffer:getEffectTimeList()
    -- -- 添加buff 到列表
    -- self._bufferTarget:addBuffer(buffer)
    -- table.insert(self._entityIDList, buffer:getEntityID())
end
function BufferAction:initByData(bufferData, bufferCaster, bufferTarget, isRecover)
    local buffer = Model.Buffer:create(true)
    buffer:init(bufferData)
    self:init(buffer, bufferCaster, bufferTarget)

    self._bufferID = bufferData.buffID
    self._entityID = bufferData.entityID
    self._isRecover = isRecover
    -- self._duration = bufferData.curDuration / TIME_UNIT
    -- self._overlayNum = bufferData.overlayNum
end
-- function BufferAction:initByID(bufferID, entityID, bufferCaster, bufferTarget, duration, overlayNum)
--     local buffer = Model.Buffer:create(true)
--     buffer:initByID(bufferID, entityID)
--     self:init(buffer, bufferCaster, bufferTarget)

--     self._bufferID = bufferID
--     self._entityID = entityID
--     self._duration = duration / TIME_UNIT
--     self._overlayNum = overlayNum
-- end

-- 清理
function BufferAction:clear()
    BufferAction.super.clear(self)

    self._bufferID = 0
    self._entityID = 0
    self._bufferCaster = nil
    self._bufferTarget = nil
    -- self._duration = 0
    -- self._overlayNum = 0
    self._effectTimeList = nil
    for i = 1, #self._entityIDList do
        self._entityIDList[i] = nil
    end
    self._preRunTime = 0
    self._hitIndex = 1
end

-- 是否是相同的释放这的相同的buffer
function BufferAction:isSameBuffer(bufferID, bufferCasterID, bufferTargetID)
    return bufferID == self._bufferID and
           bufferCasterID == self._bufferCaster:getSpriteID() and
           bufferTargetID == self._bufferTarget:getSpriteID()
end

-- 是否包含某个buffer
function BufferAction:hasBuffer(targetSpriteID, entityID)
    if(self._bufferTarget == nil or self._bufferTarget:getSpriteID() ~= targetSpriteID) then
        return false
    end

    if(self._entityID == entityID) then
        return true
    end

    for i = 1, #self._entityIDList do
        local _entityID = self._entityIDList[i]
        if (_entityID == entityID) then
            
            return true
        end
    end
    return false
end

-- 添加相同buffer
function BufferAction:addBuffer(entityID)
    local bufferData = SkillDataManager:createBufferData(self._bufferID)
    local buffer = nil
    if(bufferData) then
        buffer = Model.Buffer:create(true)
        buffer:init(bufferData)
        -- 添加buffer到目标对象上
        self._bufferTarget:addBuffer(buffer)

        table.insert(self._entityIDList, entityID)
    end

    return buffer
end

-- 移除buffer
function BufferAction:removeBuffer(entityID)
    -- print(string.format("BufferAction removeBuffer: remove one buffer (bufferID:%d entityID:%d) from target %d.", self._bufferID, entityID, self._bufferTarget:getSpriteID()))
    local found = false
    -- 防止还没有执行的情况
    if(self._entityID == entityID) then        
        found = true
    end

    for i = 1, #self._entityIDList do
        local _entityID = self._entityIDList[i]
        if (_entityID == entityID) then
            table.remove(self._entityIDList, i)

            found = true
            break
        end
    end

    -- 从目标对象上移除buffer
    if (not self._bufferTarget:removeBufferByEntityID(entityID)) then
        -- assert(false, string.format("[ERROR] BufferAction removeBuffer: no buffer found for entity id %d.", entityID))
    end

    if (found) then
        if (#self._entityIDList == 0) then
            self:complete()
        end
    else
        assert(false, string.format("[ERROR] BufferAction removeBuffer: no buffer found for entity id %d.", entityID))
    end
end

-- 移除所有buffer
function BufferAction:removeAllBuffer()
    -- print(string.format("BufferAction removeAllBuffer: remove all buffer from target %d.", self._bufferTarget:getSpriteID()))

    -- add change by zp 用于有些效果已经被移除了，这里再次移除的时候已经没有效果
    -- -- 从目标对象上移除buffer
    -- if (not self._bufferTarget:removeAllBuffer()) then
    --    assert(false, string.format("[ERROR] BufferAction removeAllBuffer: no buffer found for target %d.", self._bufferTarget:getSpriteID()))
    -- end

    self._bufferTarget:removeAllBuffer()

    local found = false
    for i = 1, #self._entityIDList do
        local entityID = self._entityIDList[i]
        -- print(string.format("BufferAction removeAllBuffer: remove buffer %d.", entityID))
        self._entityIDList[i] = nil

        found = true
    end
    -- if (not found) then
    --     assert(false, string.format("[ERROR] BufferAction removeBuffer: no buffer found for target %d.", self._bufferTarget:getSpriteID()))
    -- end

    self:complete()
end

-- 模版函数：action开始
function BufferAction:onStart()
    local buffer = self._target
    local bufferTarget = self._bufferTarget
    local entityID = buffer:getEntityID()
    local bufferID = buffer:getBufferID()

    if (buffer and bufferTarget) then
        self:forceUpdate()
        local bufferData = buffer:getBufferData()

        -- 添加buffer到目标对象上
        local buffer = self:addBuffer(self._entityID)
        if (DEBUG_ADD_EFFECT) then
            executeEffect(self, self._target:getStartEffectID())
        end
        -- 显示buffer特效
        if (bufferData:getAnimationName()) then
            -- 这里处理是否为恢复buff,如果为恢复buff 就不播放单词播放效果
            if(bufferData:getBuffFxAnimLoop() == true or (bufferData:getBuffFxAnimLoop() == false and self._isRecover == false)) then
                local rendererCommand = Command.RendererCommand:create(true)
                rendererCommand:initAddBufferCommand(
                    bufferTarget:getId(), 
                    entityID, 
                    bufferData:getBuffFxAnimLoop(),
                    bufferData:getAnimationName(), 
                    bufferData:getFXMountNameList(), 
                    bufferData:getFXAnimationPrefixList(),
                    bufferData:getFxFlip()
                )
                SceneManager:getInstance():pushCommand(rendererCommand)
            end
        end
        -- 发送添加buffer的消息
        Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_ADD_BUFFER, {
            bufferData = bufferData,
            bufferEntityID = entityID,
            bufferTargetID = bufferTarget:getSpriteID()
        })

        return true
    else

        return false
    end
end

-- 模版函数：action更新
function BufferAction:onUpdate(dt)
    -- 执行buffer效果
    if (DEBUG_ADD_EFFECT) then
        local currentTime = self._currentTime
        local effectTimeList = self._effectTimeList
        local count = #effectTimeList
        if (count > 0) then
            local buffer = self._target

            local i = 1
            repeat
                local effectTime = effectTimeList[i]
                if (effectTime >= 0 and effectTime >= currentTime) then
                    -- print(string.format("BufferAction onUpdate: trigger once effect %d at time %f.", buffer:getTriggerEffectID(), effectTime))

                    executeEffect(self, buffer:getTriggerEffectID())

                    effectTimeList[i] = -1
                end
                i = i + 1
            until (i > count)
        end
    end
    -- 刷新剩余时间
    if(self._buffData:getTotalDuration() - self._buffData:getDuration() < self._preRunTime) then
        self._preRunTime = self._buffData:getTotalDuration() - self._buffData:getDuration()
        self._hitIndex = 1
    end
    
    -- local duration = self._buffData:getDuration() - dt
    -- if(duration < 0) then
    --     duration = 0
    -- end
    -- self._buffData:setDuration(duration)

    self._preRunTime = self._buffData:getTotalDuration() - self._buffData:getDuration()

    triggerHit(self)

    if (DEBUG_ADD_EFFECT) then
        -- if ( self._currentTime >= self._duration) then
        --     return true
        -- end
        if(self._buffData:getDuration() <= 0) then
            return true
        end
    end
    return false
end

-- 模版函数：action结束
function BufferAction:onEnd()
    local buffer = self._target
    local bufferTarget = self._bufferTarget
    local entityID = buffer:getEntityID()
    local bufferID = buffer:getBufferID()

    -- 执行buff效果
    if (DEBUG_ADD_EFFECT) then
        executeEffect(self, self._target:getEndEffectID())
    end

    removeBuffToUI(buffer, bufferTarget)

    -- 移除buffer
    buffer:destroy()
end

-- 停止
function BufferAction:onStop()
    local buffer = self._target
    -- local bufferData = buffer:getBufferData()
    -- local duration = bufferData:getDuration()
    -- bufferData:setDuration(duration - self._currentTime)
    -- bufferData:setCurrentTime(self._currentTime)

    local entityID = buffer:getEntityID()
    local bufferID = buffer:getBufferID()
    -- print(string.format("BufferAction onStop: buffer (bufferID:%d entityID:%d, current time:%d) is ended.", bufferID, entityID, self._currentTime))

    -- self:removeAllBuffer()

    self._bufferTarget:removeBufferByEntityID(entityID)

    removeBuffToUI(buffer, self._bufferTarget)
end

-- 获取buffer
function BufferAction:getBuffer()
    return self._target
end

-- 获取buffer对象
function BufferAction:getBufferTarget()
    return self._bufferTarget
end

-- 获取buffer释放者
function BufferAction:getBufferCaster()
    return self._bufferCaster
end

function BufferAction:refreshBuffer()
    -- body
    local buffer = self._target
    local bufferTarget = self._bufferTarget
    if (buffer and bufferTarget) then
        local bufferData = buffer:getBufferData()
        if (bufferData:getAnimationName()) then
            -- 这里处理是否为恢复buff,如果为恢复buff 就不播放单词播放效果
            if(bufferData:getBuffFxAnimLoop() == false) then
                local rendererCommand = Command.RendererCommand:create(true)
                rendererCommand:initAddBufferCommand(
                    bufferTarget:getId(), 
                    buffer:getEntityID(), 
                    bufferData:getBuffFxAnimLoop(),
                    bufferData:getAnimationName(), 
                    bufferData:getFXMountNameList(), 
                    bufferData:getFXAnimationPrefixList(),
                    bufferData:getFxFlip()
                )
                SceneManager:getInstance():pushCommand(rendererCommand)
            end
        end
    end 
end

-- -- buffer叠加
-- function BufferAction:overlay(overlayNum)
--     local buffer = self._target
--     local entityID = buffer:getEntityID()
--     local bufferID = buffer:getBufferID()

--     -- print(string.format("BufferAction overlay: buffer (bufferID:%d entityID:%d) is updated, overlay %d.", bufferID, entityID, overlayNum))

--     self._overlayNum = overlayNum

--     -- 发送更新buffer状态的消息
--     Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_UPDATE_BUFFER, {
--         bufferData = buffer:getBufferData(),
--         bufferEntityID = buffer:getEntityID(),
--         bufferTargetID = self._bufferTarget:getSpriteID(),
--         overlay = self._overlayNum,
--         leftTime = self._duration
--     })
-- end

-- -- buffer叠加并刷新时间
-- function BufferAction:overlayAndRefresh(overlayNum, duration)
--     local buffer = self._target
--     local entityID = buffer:getEntityID()
--     local bufferID = buffer:getBufferID()

--     -- print(string.format("BufferAction overlayAndRefresh: buffer (bufferID:%d entityID:%d) is updated, overlay %d, duration %d.", bufferID, entityID, overlayNum, duration))

--     self._overlayNum = overlayNum
--     self._duration = duration

--     -- 发送更新buffer状态的消息
--     Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_UPDATE_BUFFER, {
--         bufferData = buffer:getBufferData(),
--         bufferEntityID = buffer:getEntityID(),
--         bufferTargetID = self._bufferTarget:getSpriteID(),
--         overlay = self._overlayNum,
--         leftTime = self._duration
--     })
-- end

-- -- buffer刷新时间
-- function BufferAction:refresh(duration)
--     local buffer = self._target
--     local entityID = buffer:getEntityID()
--     local bufferID = buffer:getBufferID()

--     -- print(string.format("BufferAction refresh: buffer (bufferID:%d entityID:%d) is updated, duration %d.", bufferID, entityID, duration))

--     self._duration = duration

--     -- 发送更新buffer状态的消息
--     Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_UPDATE_BUFFER, {
--         bufferData = buffer:getBufferData(),
--         bufferEntityID = buffer:getEntityID(),
--         bufferTargetID = self._bufferTarget:getSpriteID(),
--         overlay = self._overlayNum,
--         leftTime = self._duration
--     })
-- end
