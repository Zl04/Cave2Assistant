
--[[
    处理BUFF 数据定义
]]

require "app.datas.GameData"

local EffectData = class("EffectData",GameData.Base)

Data = Data or {}
Data.EffectData = EffectData

-- 构造函数(会自动调用)  
function EffectData:ctor()
    self.super.ctor(self,Category.EFFECT)
end

function EffectData:getId()

    return self.effectId
end

function EffectData:initLocal(data)
    -- print("EffectData:initLocal")
    -- dump(data)
    if self.effectId ~= data.ID then
        self:setLocalConfigData(data)
    end
end

function EffectData:initNet(mesData)
    -- 根据网络数据初始化
    local oldId = self.effectId
    self.spriteID = mesData.spriteID or -1
    self.effectId = mesData.effectId or -1

    if oldId ~= mesData.effectId then
        self:conbinationLocalData()
    end
end

function EffectData:conbinationLocalData()
    if (self.effectId ~= -1) then
        local data = ConfigManager:getEffectConfigById(self.effectId)
        self:setLocalConfigData(data)
    end
end

-- 判断是否为触发技能的 effect
function EffectData:getIsSkillEffect()
    -- print("EffectData:getIsSkillEffect ", self.algorithmType)
    if(self.algorithmType == 31000) then
        return true
    end

    return false
end

-- 获取效果触发的技能
function EffectData:getEffectSkillID()
    if(self:getIsSkillEffect()) then
        return self.value1
    end

    return nil
end

-- 效果是否翻转
function EffectData:getFxFlip()
    if(self.fxFlip == 1) then
        return true
    end

    return false
end