--[[
    技能效果
]]--

require "app.object.GameModel"

Model = Model or {}

local Buffer = class("Buffer", Model.Base)
Model.Buffer = Buffer

-- public:
-- 创建对象
local BufferPool = nil
function Buffer:create(reused, ...)
    if (reused) then
        if (not BufferPool) then
            BufferPool = Pool.Pool:create(Buffer)
        end
        return BufferPool:applyObject()
    else
        return Buffer.new(...)
    end
end

-- 构造函数
function Buffer:ctor()
    Buffer.super.ctor(self, Category.BUFFER, 0)

    -- 配置id
    self._bufferID = 0
    -- 实例id
    self._entityID = 0
    -- 配置数据
    self._bufferData = nil
end

-- 析构函数
function Buffer:dtor()
    self._bufferData = nil
end

-- 初始化
function Buffer:init(bufferData)
    assert(type(bufferData) == "table", "[ERROR] Buffer init: buffer data is invalid.")

    Buffer.super.init(self)

    self._bufferID = bufferData:getID()
    self._entityID = bufferData:getEntityID()
    self._bufferData = bufferData
end
function Buffer:initByID(bufferID, entityID)
    assert(type(bufferID) == "number" and bufferID > 0, "[ERROR] Effect initByID: buffer id is invalid.")

    local bufferData = SkillDataManager:createBufferData(bufferID)
    if(bufferData) then
        bufferData:initLocal(bufferConfig)
        self:init(bufferData)
    end 

    if (not entityID) then self._entityID = self:getId()
    else self._entityID = entityID end
end

-- 清理
function Buffer:clear()
    self._bufferID = 0
    self._entityID = 0
    self._bufferData = nil
end

-- 获取id
function Buffer:getBufferID()
    return self._bufferData:getID()
end

-- 获取实例id
function Buffer:getEntityID()
    return self._entityID
end

-- 获取data
function Buffer:getBufferData()
    return self._bufferData
end

-- 获取buffer持续时间
function Buffer:getDuration()
    return self._bufferData:getDuration()
end

-- 获取buffer的图标
function Buffer:getICON()
    return self._bufferData:getICON()
end

-- 获取叠加类型
function Buffer:getOverlayType()
    return self._bufferData:getOverlayType()
end

-- 获取buffer触发的时间列表
function Buffer:getEffectTimeList()
    return self._bufferData:getEffectTimeList()
end

-- 获取启动效果id
function Buffer:getStartEffectID()
    return self._bufferData:getStartEffectID()
end

-- 获取中途触发的效果id
function Buffer:getTriggerEffectID()
    return self._bufferData:getTriggerEffectID()
end

-- 获取结束时的效果id
function Buffer:getEndEffectID()
    return self._bufferData:getEndEffectID()
end

-- 获取效果是否需要循环播放
function Buffer:getBuffFxAnimLoop()
    return self._bufferData:getBuffFxAnimLoop()
end

-- 获取效果名字
function Buffer:getAnimationName()
    return self._bufferData:getAnimationName()
end

-- 获取效果挂载点
function Buffer:getFxMountName()
    return self._bufferData:getMountName()
end