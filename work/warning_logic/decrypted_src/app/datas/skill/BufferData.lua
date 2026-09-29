--[[
    buffer数据
]]

require "app.datas.GameData"

local BufferData = class("BufferData",GameData.Base)

Data = Data or {}
Data.BufferData = BufferData

local BUFFER_TYPE = PublicDefine.BUFFER_TYPE

-- privte:

-- 构造函数
function BufferData:ctor(buffID)
    -- print("BufferData:ctor")
    self.super.ctor(self, Category.BUFF)
    
    self.spriteID = 0
    self.buffID = -1
    if buffID then
        self.buffID = buffID
    end

    self.currentTime = 0
    self.totalDuration = 0
    self.serverDuration = 0

    self.mountNameList = {}
    self.mountAnimationPrefixList = {}

    self.isAddNew = true

    self:conbinationLocalData()
end

-- public:
-- 初始化网络数据
function BufferData:initNet(mesData)
    -- 根据网络数据初始化
    local oldId = self.buffID

    self.buffID = mesData.buffID
    self.entityID = mesData.entityID
    self.sourceSpriteID = mesData.sourceSpriteID
    self.curDuration = mesData.curDuration
    self.overlayNum = mesData.overlayNum
    self.targetSpriteID = mesData.targetSpriteID

    self:handleDurationUpdate()
    if oldId ~= mesData.buffID then
        self:conbinationLocalData()
    end
end

-- 网络恢复数据
function BufferData:initNetReback(mesData,targetSpriteID)
    -- 根据网络数据初始化
    local oldId = self.buffID
    self.buffID = mesData.buffID
    self.entityID = mesData.entityID
    self.sourceSpriteID = -1
    self.curDuration = mesData.curDuration
    self.overlayNum = mesData.overlayNum
    self.targetSpriteID = targetSpriteID
    self:handleDurationUpdate()
    if oldId ~= mesData.buffID then
        self:conbinationLocalData()
    end
end

function BufferData:handleDurationUpdate()
    if(self.curDuration > self.duration) then 
        self.serverDuration = self.curDuration
    end
end

-- 初始化本地数据
function BufferData:initLocal(data)
    self:setLocalConfigData(data)

    self.buffID = data.ID
    local effectTimeList = self.effectTimeList
    for i = 1, #effectTimeList do
        local effectTime = effectTimeList[i]
        self.effectTimeList[i] = effectTime / TIME_UNIT
    end

    if (data.buffFxAnimMount) then
        local mountNameList = AvalonUtil:splitStr(data.buffFxAnimMount, ';')
        for i = 1, #mountNameList do
            self.mountNameList[i] = mountNameList[i]
        end
    end
    if (data.buffFxAnimPrefix) then
        local mountAnimationPrefixList = AvalonUtil:splitStr(data.buffFxAnimPrefix, ';')
        if (mountAnimationPrefixList and #mountAnimationPrefixList >= 1) then
            for i = 1, #mountAnimationPrefixList do
                self.mountAnimationPrefixList[i] = mountAnimationPrefixList[i]
            end
        end
    end

    -- self.id = data.Id or -1  --buff id，用来标识buff，以及调用buff
    -- self.iconId = data.iconId or -1  --图标id，buff施加时，产生的图标id
    -- self.fxId = data.fxId or -1  --特效id，调用buff时，产生特效的名字
    -- self.description = data.description or ""  --描述buff的内容
    -- self.type = data.type or -1  --增减益类型，标注buff效果是增益还是减益
    -- self.clearAfterBattle = data.clearAfterBattle or -1  --是否在战斗后清除该buff
    -- self.canStack = data.canStack or false  --该buff是否可以叠加
    -- self.stackType = data.stackType or -1  --叠加类型，用于处理buff叠加刷新时间问题
    -- self.maxStack = data.maxStack or 0  --该buff可以叠加的次数
    -- self.duration = data.duration or 0  --buff存在的时间，9999999表示永久存在
    -- self.interval = data.interval or -1  --执行效果在什么时候触发
    -- self.startEffectId = data.startEffectId or -1  --buff在被添加时触发的效果
    -- self.triggerEffectId = data.triggerEffectId or -1  --buff在执行过程中触发点效果，与interval配合使用
    -- self.endEffectId = data.endEffectId or -1  --buff在结束时触发的效果
end
-- 合并网络数据和本地数据
function BufferData:conbinationLocalData()
    if (self.buffID ~= -1) then
        local data = ConfigManager:getBufferConfigById(self.buffID)
        if(data) then
            self:setLocalConfigData(data)
            self.buffID = data.ID
            local effectTimeList = self.effectTimeList
            for i = 1, #effectTimeList do
                local effectTime = effectTimeList[i]
                self.effectTimeList[i] = effectTime / TIME_UNIT
            end

            if (data.buffFxAnimMount) then
                local mountNameList = AvalonUtil:splitStr(data.buffFxAnimMount, ';')
                for i = 1, #mountNameList do
                    self.mountNameList[i] = mountNameList[i]
                end
            end
            if (data.buffFxAnimPrefix) then
                local mountAnimationPrefixList = AvalonUtil:splitStr(data.buffFxAnimPrefix, ';')
                if (mountAnimationPrefixList and #mountAnimationPrefixList >= 1) then
                    for i = 1, #mountAnimationPrefixList do
                        self.mountAnimationPrefixList[i] = mountAnimationPrefixList[i]
                    end
                end
            end
        end
    end
end

function BufferData:update(dt)
    local duration = self:getDuration() - dt
    if(duration < 0) then
        duration = 0
    end
    self:setDuration(duration)
end

function BufferData:getOverlayNum()

    return self.overlayNum
end

function BufferData:getTargetSpriteID()
    return self.targetSpriteID
end

function BufferData:setServerDuration(serverDuration)
    self.curDuration = serverDuration
    self:handleDurationUpdate()
end

function BufferData:setTargetSpriteID(targetSpriteID)
    if(targetSpriteID) then
        self.targetSpriteID = targetSpriteID
    end
end

-- 刷新buffer ，会重新倒计时
function BufferData:resetBuffer()
    self.curDuration = self.duration
end

-- 获取配置数据id
function BufferData:getID()
    return self.buffID
end

-- 获取buffer类型
function BufferData:getType()
    return self.type
end

-- 是否是增益buff
function BufferData:isGood()
    return self.type == PublicDefine.BUFFER_TYPE.BUFFER_TYPE_BUFF
end

-- 效果是否翻转 --0:第一次根据角色的翻转，而翻转，以后角色在变化则不会继续翻转
--1：角色翻转则跟着翻转
--2：永远朝一个方向，不根据角色调整翻转
function BufferData:getFxFlip()
    return self.fxFlip
end

-- 获取是否有抖动
function BufferData:getHitFeedBack()
    return self.hitFeedBack
end

-- 屏幕抖动
function BufferData:getHitShake()
    return self.hitShake
end

function BufferData:getBuffEffectType()
    return self.buffEffectType
end

-- 定帧时间
function BufferData:getHitFreeze()
    return self.hitFreeze/ TIME_UNIT
end

-- 获取总时间
function BufferData:getTotalDuration()
    if(self.serverDuration < self.duration) then 
        return self.duration / TIME_UNIT
    else 
        return self.serverDuration / TIME_UNIT
    end
end

-- 设置buffer的剩余持续时间
function BufferData:setDuration(duration)
    self.curDuration = duration * TIME_UNIT
end

-- 获取buffer持续时间
function BufferData:getDuration()
    return self.curDuration / TIME_UNIT
end

function BufferData:setAddNew(flag)
    self.isAddNew = flag
end

function BufferData:getIsAddNew()
    return self.isAddNew
end

-- 获取buff 名字
function BufferData:getName()
    return self.name
end

-- 获取buffer的图标
function BufferData:getICON()
    local bufferICON = self.iconID
    return (bufferICON ~= "") and bufferICON or nil
end

-- 获取buffer大图标
function BufferData:getBigICON()
    local bufferICON = self.bigIconID
    return (bufferICON ~= "") and bufferICON or nil
end

-- 获取叠加类型
function BufferData:getOverlayType()
    return self.ownType
end

-- 获取buffer触发的时间列表`
function BufferData:getEffectTimeList()
    return self.effectTimeList
end

-- 获取启动效果id
function BufferData:getStartEffectID()
    return self.startEffectID
end

-- 获取中途触发的效果id
function BufferData:getTriggerEffectID()
    return self.triggerEffectID
end

-- 获取结束时的效果id
function BufferData:getEndEffectID()
    return self.endEffectID
end

-- 获取buff 效果是否不循环
function BufferData:getBuffFxAnimLoop()
    local buffFxAnimNoLoop = self.buffFxAnimNoLoop
    if(tonumber(buffFxAnimNoLoop) == 1) then
        return false
    end

    return true
end

-- 获取效果名字
function BufferData:getAnimationName()
    local buffFxAnimName = self.buffFxAnimName
    return (buffFxAnimName ~= "") and buffFxAnimName or nil
end

-- 获取效果挂载点
function BufferData:getFXMountNameList()
    return self.mountNameList
end

-- 获取效果动画前缀
function BufferData:getFXAnimationPrefixList()
    if (#self.mountAnimationPrefixList > 0) then return self.mountAnimationPrefixList
    else return nil
    end
end

-- 设置当前已经生效的时长
function BufferData:setCurrentTime(currentTime)
    self.currentTime = currentTime
end

-- 返回当前已经生效的时长
function BufferData:getCurrentTime()
    return self.currentTime
end

-- 返回buff的实例id
function BufferData:getEntityID()
    return self.entityID
end
