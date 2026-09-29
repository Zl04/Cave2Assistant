--[[
    其它玩家的战斗行为
]]--

require "app.action.fsm.battle.BattleStateAction"

local DEBUG = false

Action = Action or {}

local BattleStateActionForOtherHero = class("BattleStateActionForOtherHero", Action.BattleStateActionForHero)
Action.BattleStateActionForOtherHero = BattleStateActionForOtherHero

local BattleStateAction = Action.BattleStateAction

-- public:
-- 创建对象
local BattleStateActionForOtherHeroPool = nil
function BattleStateActionForOtherHero:create(reused, ...)
    if(DEBUG) then
        print("BattleStateActionForOtherHero create: create battle state action for other hero.")
    end

    if (reused) then
        if (not BattleStateActionForOtherHeroPool) then
            BattleStateActionForOtherHeroPool = Pool.Pool:create(BattleStateActionForOtherHero)
        end
        return BattleStateActionForOtherHeroPool:applyObject()
    else
        return BattleStateActionForOtherHero.new(...)
    end
end

-- 普通攻击
function BattleStateActionForOtherHero:attack(attackTarget)
    if (attackTarget) then
        if DEBUG then 
            print(string.format("BattleStateActionForOtherHero attack: monster %d is attacking role %d.", self._target:getSpriteID(), attackTarget:getSpriteID()))
        end

        BattleStateAction.attack(self, attackTarget, false)

        if attackTarget then
            local roleData = attackTarget:getData()
            if (roleData:getType() == RoleType.Monster) then
                if (roleData:isSmallBoss()) then
                    self._moveFowardAfterWin = false
                end
            end
            if DEBUG then 
                print("BattleStateActionForOtherHero attack ", roleData:getCategory(), roleData:getType(), roleData:isSmallBoss())
            end
        end
    end
end
-- 普通攻击逻辑更新
function BattleStateActionForOtherHero:onAttack(dt)
    local isComplete = BattleStateAction.onAttack(self, dt)
    if (isComplete) then self:idle()
    end
end

-- 技能使用的逻辑更新
function BattleStateActionForOtherHero:onUseSkill(dt)
    local isComplete = BattleStateAction.onUseSkill(self, dt)
    if (isComplete) then self:idle()
    end
    return isComplete
end


