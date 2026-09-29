--[[
    效果行为
]]--

require "app.action.Action"
require "app.object.effect.Effect"
local MachineManager = require("app.game.MachineManager")
Action = Action or {}

local EffectAction = class("EffectAction", Action.Base)
Action.EffectAction = EffectAction

-- private:
local DEBUG = false

-- public:
-- 创建对象
local EffectActionPool = nil
function EffectAction:create(reused, ...)
    if (reused) then
        if (not EffectActionPool) then
            EffectActionPool = Pool.Pool:create(EffectAction)
        end
        return EffectActionPool:applyObject()
    else
        return EffectAction.new(...)
    end
end

-- 构造函数
function EffectAction:ctor()
    EffectAction.super.ctor(self, ActionType.EFFECT)

    self._effectTarget = nil
end

-- 模版函数：销毁
function EffectAction:dtor()
    EffectAction.super.dtor(self)

    self._effectTarget = nil
end

-- 初始化
function EffectAction:init(effect, effectTarget)
    EffectAction.super.init(self, effect)

    self._effectTarget = effectTarget
end
function EffectAction:initByID(effectID, effectTarget)
    local effect = Model.Effect:create(true)
    effect:initByID(effectID)

    self:init(effect, effectTarget)
end

-- 清理
function EffectAction:clear()
    EffectAction.super.clear(self)

    self._effectTarget = nil
end

-- 模版函数：action开始
function EffectAction:onStart()
    if (DEBUG) then
        local effect = self._target
        if (effect:isBuffer()) then
            local buffID = effect:getBufferID()
            local bufferData = SkillDataManager:createBufferData(buffID)
            if(bufferData) then
                local buffer = Model.Buffer:create(true)
                -- buffer:initByID(buffID)
                buffer:init(bufferData)
                
                local bufferAction = Action.BufferAction:create(true)
                bufferAction:init(buffer, self._effectTarget)

                MachineManager:getInstance():addAction(bufferAction)
            end 
        end
    end

    -- 处理触发技能的效果
    if(self._target:getIsSkillEffect() and self._effectTarget and self._effectTarget:isMaster()) then
        local skillID = self._target:getEffectSkillID()
        if(skillID) then
            local skillData = SkillDataManager:createSkillForSkillId(skillID)
            if(skillData) then
                local useSkill = {}
                useSkill.skillData = skillData

                local battleCMD = Command.BattleCommand:create(true)
                battleCMD:initForTypeAndData(CommandType.BATTLE_USE_SKILL, useSkill)
                MachineManager:getInstance():executeCommand(battleCMD)
            end
        end
    end

    MachineManager:getInstance():pushAddEffectRendererCommand(self._effectTarget, self._target)
    
    Avalon.AudioManager:playSoundByConfig("22", self._target:getEffectID(), nil, self._effectTarget and self._effectTarget:getCoord() or nil)

    return true
end

-- 模版函数：action更新
function EffectAction:onUpdate(dt)
    return true
end

-- 模版函数：action结束
function EffectAction:onEnd()

end

