--[[
    怪物的战斗行为
]]--

require "app.action.fsm.battle.BattleStateAction"

local DEBUG = false

Action = Action or {}

local BattleStateActionForMonster = class("BattleStateActionForMonster", Action.BattleStateAction)
Action.BattleStateActionForMonster = BattleStateActionForMonster

local BattleStateAction = Action.BattleStateAction

-- public:
-- 创建对象
local BattleStateActionForMonsterPool = nil
function BattleStateActionForMonster:create(reused, ...)
    if DEBUG then
        print("BattleStateActionForMonster create: create battle state action for monster.")
    end

    if (reused) then
        if (not BattleStateActionForMonsterPool) then
            BattleStateActionForMonsterPool = Pool.Pool:create(BattleStateActionForMonster)
        end
        return BattleStateActionForMonsterPool:applyObject()
    else
        return BattleStateActionForMonster.new(...)
    end
end

-- 普通攻击
function BattleStateActionForMonster:attack(attackTarget)
    if (attackTarget) then
        if DEBUG then 
            print(string.format("BattleStateActionForMonster attack: monster %d is attacking role %d.", self._target:getSpriteID(), attackTarget:getSpriteID()))
        end

        BattleStateAction.attack(self, attackTarget, false)

        Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_MONSTER_ATTACK, attackTarget:getSpriteID())
    end
end
-- 普通攻击逻辑更新
function BattleStateActionForMonster:onAttack(dt)
    local isComplete = BattleStateAction.onAttack(self, dt)
    if (isComplete) then self:idle()
    end
end

-- 技能使用的逻辑更新
function BattleStateActionForMonster:onUseSkill(dt)
    local isComplete = BattleStateAction.onUseSkill(self, dt)
    if (isComplete) then self:idle()
    end
    return isComplete
end




