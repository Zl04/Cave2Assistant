--[[
    技能效果
]]--

require "app.object.GameModel"

Model = Model or {}

local Effect = class("Effect", Model.Base)
Model.Effect = Effect

-- public:
-- 创建对象
local EffectPool = nil
function Effect:create(reused, ...)
    if (reused) then
        if (not EffectPool) then
            EffectPool = Pool.Pool:create(Effect)
        end
        return EffectPool:applyObject()
    else
        return Effect.new(...)
    end
end

-- 构造函数
function Effect:ctor()
    Effect.super.ctor(self, Category.EFFECT, 0)

    -- 配置id
    self._effectID = 0
    -- 效果结果类型
    self._effectResultType = EffectResultType.NONE
    -- 配置数据
    self._effectData = nil
end

-- 析构函数
function Effect:dtor()
    self._effectData = nil
end

-- 初始化
function Effect:init(effectData)
    assert(type(effectData) == "table", "[ERROR] Effect init: effect data is invalid.")

    Effect.super.init(self)

    self._effectID = effectData.ID
    self._effectResultType = effectData.algorithmType
    self._effectData = effectData
end
function Effect:initByID(effectID)
    assert(type(effectID) == "number" and effectID > 0, "[ERROR] Effect initByID: effect id is invalid.")

    local effectConfig = ConfigManager:getEffectConfigById(effectID)
    local effectData = Data.EffectData:create()
    effectData:initLocal(effectConfig)

    self:init(effectData)
end

-- 清理
function Effect:clear()
    self._effectID = 0
    self._effectResultType = EffectResultType.NONE
    self._effectData = nil
end

-- 获取id
function Effect:getEffectID()
    return self._effectID
end

-- 获取效果产生的结果类型
function Effect:getEffectResultType()
    return self._effectResultType
end

-- 获取data
function Effect:getEffectData()
    return self._effectData
end

-- 是否是buffer效果
function Effect:isBuffer()
    return self._effectData.algorithmType == EffectResultType.ADD_BUFFER
end

-- 获取buffer的id
function Effect:getBufferID()
    if (self:isBuffer()) then
        return self._effectData.value1
    else
        return nil
    end
end

-- 获取效果名字
function Effect:getFxAnimName()
    local fxAnimName = self._effectData.effectFxAnimName
    if (fxAnimName ~= "") then
        return fxAnimName
    end
    return nil
end

-- 获取效果挂载点
function Effect:getFxMountName()
    local fxMountName = self._effectData.effectFxAnimMount
    if (fxMountName ~= "") then
        return fxMountName
    end
    return nil
end

-- 判断是否为触发技能的效果
function Effect:getIsSkillEffect()
    -- print("Effect:getIsSkillEffect")
    if(self._effectData) then
        -- print("Effect:getIsSkillEffect is not null",self._effectData:getIsSkillEffect())
        -- dump(self._effectData)
        return self._effectData:getIsSkillEffect()
    end

    return false
end

-- 获取效果技能
function Effect:getEffectSkillID()
    if(self._effectData) then
        return self._effectData:getEffectSkillID()
    end

    return nil
end

-- 效果是否翻转
function Effect:getFxFlip()
    if(self._effectData) then
        return self._effectData:getFxFlip()
    end

    return false
end