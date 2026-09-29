--[[
    战斗状态行为
]]--

require "app.action.Action"

local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")
local MachineManager = require("app.game.MachineManager")

Action = Action or {}

local FunctionFlag = PublicDefine.FunctionFlag

local BattleStateAction = class("BattleStateAction", Action.Base)
Action.BattleStateAction = BattleStateAction

-- 战斗的状态
Action.BattleState = {
    NONE = 0,
    PREPARE = 1,                -- 准备战斗
    ATTACK = 2,                 -- 普通攻击
    USE_SKILL = 3,              -- 使用技能
    RUN_AWAY = 4,               -- 逃跑
    IDLE = 5,                   -- 待机
    MOVE = 6,                   -- 移动
    DIE = 7,                    -- 死亡
    PARRYING = 8,               -- 招架
    FROZEN = 9,                 -- 冻结
    STUN = 10,                  -- 眩晕
    CONSTRAINT = 11,            -- 束缚 
    CHARM = 12,                 -- 魅惑
}
BattleState = Action.BattleState

-- 战斗类型
Action.BattleType = {
    NONE = 0,       
    HERO = 1,       -- 英雄
    MONSTER = 3     -- 怪物
}
BattleType = Action.BattleType

-- private:
local DEBUG = false

-- public:
-- 准备战斗
function BattleStateAction:prepare()
    self._battleState = BattleState.PREPARE
    self._prepareTime = 0
end
-- 准备战斗的逻辑更新
function BattleStateAction:onPrepare(dt)
    self._prepareTime = self._prepareTime + dt
    return true
end

-- 普通攻击
function BattleStateAction:attack(attackTarget, loop)
    loop = (loop == nil) and true or loop
    if(DEBUG) then 
        print(string.format("BattleStateAction attack: role %d is attacking role, loop %s.", self._target:getSpriteID(), loop))
    end

    self._battleState = BattleState.ATTACK
    if (attackTarget and attackedTarget ~= self._target) then
        self._attackTarget = attackTarget
    end
    self._attackTime = 0

    -- 普通攻击行为
    if (self._attackAction:isCreated()) then
        self._attackAction:init(self._target, attackTarget, loop);
        self._attackAction:execute()
    else
        self._attackAction:attack(attackTarget)
    end
    self._attackDirection = self._target:getDirection()

    -- 这里处理每次同步方向
    -- 渲染
    MachineManager:getInstance():pushDirectionRendererCommand(self._target, self._attackDirection)
end
-- 普通攻击逻辑更新
function BattleStateAction:onAttack(dt)
    self._attackTime = self._attackTime + dt

    self._attackAction:update(dt)
    return self._attackAction:isComplete()
end

-- 使用技能
function BattleStateAction:useSkill(skillID, attackTarget, skillState)
    -- 做强制屏蔽
    if(self._battleState == BattleState.FROZEN 
        or self._battleState == BattleState.CONSTRAINT
        or self._battleState == BattleState.CHARM) then
        return
    end

    if(self._target:getIsDead() == true ) then
        return 
    end

    local skill = self._target:getSkillById(skillID)
    if (skill) then
        local skillType = skill:getSkillType()

        if(DEBUG) then 
            print("BattleStateAction:useSkill",skillID,  self._target:getSpriteID())
            print(debug.traceback())
        end
        -- yueyingsong 这里为什么要播放一次音效？RoleRenderer中已经注册过动画音效事件回调，在回调中播放了一次音效。
        -- 这里打开很多怪物攻击的时候就会播放两次
        Avalon.AudioManager:playSoundByConfig("21",skillID,nil,attackTarget and attackTarget:getCoord() or nil)

        -- 普通攻击
        if (skillType == SkillType.NORMAL_ATTACK) then
            if (skillState == SkillState.RELEASE) then
                if(DEBUG) then 
                    print(string.format("BattleStateAction useSkill: role %d is using normal attack %d.", self._target:getSpriteID(), skillID))
                end
                self:attack(attackTarget)
            else
                if(DEBUG) then 
                    print(string.format("BattleStateAction useSkill: role %d idle after using normal attack %d.", self._target:getSpriteID(), skillID))
                end
                self:idle()
            end
        -- 使用技能
        else

            if self._skillID and self._skillID ~= 0 then
                local skillData = self._skillAction:getSkillData()
                if skillData and skillData.interruptible == 1 then
                    if self._skillAction:getSkillID() ~= skillID then
                        self._skillAction:interrupt()
                    end
                else
                    if self._skillAction:isReleasing() and self._skillAction:getSkillID() ~= skillID then
                        self._skillAction:interrupt()
                    end
                end
            end

            self._battleState = BattleState.USE_SKILL
            -- self._attackTarget = attackTarget
            self._skillID = skillID

            skillState = skillState or SkillState.PREPARE
            -- 是否是重新使用技能
            local isNewSkill = false
            if (skillState == SkillState.PREPARE) then
                isNewSkill = true
            elseif (skillState == SkillState.RELEASE) then
                if (self._skillAction:isPreparing() and self._skillAction:getSkillID() == skillID) then
                    isNewSkill = false
                else
                    isNewSkill = true
                end
            else
                isNewSkill = false
            end

            if(DEBUG) then 
                print(string.format("BattleStateAction useSkill: role %d is using skill %d and skill state is %d.", self._target:getSpriteID(), skillID, skillState))
            end
            
            if (isNewSkill) then
                if(DEBUG) then 
                    print("BattleStateAction useSkill: reuse the skill.")
                end

                self._skillAction:clear()
                self._skillAction:init(self._target, skillID, attackTarget, skillState)
                self._skillAction:execute()
            else
                if (skillState == SkillState.PREPARE) then
                    if(DEBUG) then 
                        print("BattleStateAction useSkill: prepare the skill.")
                    end
                    self._skillAction:prepare()
                elseif (skillState == SkillState.RELEASE) then
                    if(DEBUG) then 
                        print("BattleStateAction useSkill: release the skill.")
                    end
                    self._skillAction:release()
                else
                    assert(false, string.format("[ERROR] BattleStateAction useSkill: the skill state %d is invalid.", skillState))
                end
            end
        end
    else
        assert(false, string.format("[ERROR] BattleStateAction useSkill: no skill %d found.", skillID))
    end
end
-- 技能使用的逻辑更新
function BattleStateAction:onUseSkill(dt)
    self._skillAction:update(dt)
    local isComplete = self._skillAction:isComplete()
    -- if (isComplete) then
    --     self:attack(self._attackTarget)
    -- end
    return isComplete
end

-- 离开战斗
function BattleStateAction:runAway()
    assert(false, "[ERROR] BattleStateAction runAway: this method should be overrided by sub class.")
end
-- 离开战斗的的逻辑更新
function BattleStateAction:onRunAway(dt)
    assert(false, "[ERROR] BattleStateAction onRunAway: this method should be overrided by sub class.")
    return true
end

-- 设置新目标
function BattleStateAction:setAttackTarget(attackTarget)
    local state = self._battleState
    if (state == BattleState.ATTACK) then
        if (attackTarget and self._attackTarget ~= attackTarget) then
            self._attackTarget = attackTarget
            self._attackAction:setAttackTarget(attackTarget)
        else
            if(DEBUG) then 
                print("BattleStateAction setAttackTarget: the same attack target.")
            end
        end
    elseif (state == BattleState.USE_SKILL) then
        self._skillAction:setSkillTarget(attackTarget)
    else
        -- TODO
    end
end

-- 待机
function BattleStateAction:idle()
    if(DEBUG) then 
        print("BattleStateAction idle ", self._target:getSpriteID())
    end

    self._battleState = BattleState.IDLE

    if(self._target) then
        local rendererCommand = Command.RendererCommand:create(true)
        rendererCommand:initUpdateAnimationCommand(self._target:getId(), CommandAnimationType.ATTACK_IDLE, 1.0)
        SceneManager:getInstance():pushCommand(rendererCommand)
    end
end
-- 待机的逻辑更新
function BattleStateAction:onIDLE(dt)
    return true
end

-- 战斗中的移动
function BattleStateAction:move(dstCoord)
    self._battleState = BattleState.MOVE
end
-- 战斗中移动的逻辑
function BattleStateAction:onMove(dt)
    return true
end

-- 战斗中的死亡
function BattleStateAction:die()
    if(DEBUG) then 
        print("BattleStateAction die ", self._target:getSpriteID())
    end

    self._battleState = BattleState.DIE

    self:interruptSkill(false)
end

-- 胜利
function BattleStateAction:win()
    self._endBattle = true
end

-- 返回原点
function BattleStateAction:lose()
    self._endBattle = true
end

-- 结束战斗
function BattleStateAction:stopBattle()
    self._endBattle = true
    self._interrupt = true
end

-- 判断是否结束的战斗
function BattleStateAction:isEndBattle()
    return self._endBattle
end

-- 构造函数
function BattleStateAction:ctor()
    BattleStateAction.super.ctor(self, ActionType.FSM_BATTLE)

    -- 战斗中的状态
    self._battleType = BattleType.NONE
    -- 准备战斗的更新时间
    self._prepareTime = 0
    -- 普通攻击的更新时间
    self._attackTime = 0
    -- 逃离战斗的更新时间
    self._runAwayTime = 0
    -- 战斗是否被中断
    self._interrupt = false

    -- 普通攻击行为
    self._attackAction = Action.NormalAttackAction:create(true)
    -- 技能行为
    self._skillAction = Action.SkillAction:create(true)
    -- 攻击目标
    self._attackTarget = nil
    -- 当前正在使用的技能id（不包括普通攻击）
    self._skillID = 0

    -- 战斗中站立的位置
    self._standCoord = Geome.Coord:create()
    -- 移动到站位时间
    self._moveDuration = 0
    -- 移动速度
    self._speedX = 0
    self._speedY = 0
    self._speedZ = 0
    -- 攻击方向
    self._attackDirection = 0

    self._endBattle = false
end

-- 析构函数
function BattleStateAction:dtor()
    BattleStateAction.super.dtor(self)

    self._attackTarget = nil
    self._standCoord = nil
    self._attackAction:destroy()
    self._attackAction = nil
    self._skillAction:destroy()
    self._skillAction = nil

    self._endBattle = false
    self._recoverEscape = false
end

-- 初始化
function BattleStateAction:init(target, battleType)
    BattleStateAction.super.init(self, target)

    target:setBattleCoord(target:getCoord())

    self._battleType = battleType
    self._battleState = BattleState.NONE

    self._endBattle = false
    self._recoverEscape = false
end

-- 清理
function BattleStateAction:clear()
    BattleStateAction.super.clear(self)
    
    self._battleType = BattleType.NONE
    self._prepareTime = 0
    self._attackTime = 0
    self._runAwayTime = 0
    self._interrupt = false

    self._attackAction:clear()
    self._skillAction:clear()
    self._attackTarget = nil
    self._skillID = 0

    self._standCoord:setValue(0, 0, 0)
    self._moveDuration = 0
    self._speedX = 0
    self._speedY = 0
    self._speedZ = 0

    self._recoverEscape = false
end

-- 模版方法：在action开始的时候执行一次，根据情况在子类中重写
-- 返回值表示是否执行成功
function BattleStateAction:onStart()
    local role = self._target
    if(role) then 
        -- 这里处理在指令的异步情况容错处理
        if(role:getIsDead()) then
            return false
        end
    end
    if(self._endBattle) then 
        return false
    end

    if (role and role:switchState(FSMState.BATTLE)) then
        self:forceUpdate()

        local spriteID = role:getSpriteID()
        local type = role:getType()

        if(DEBUG) then 
            print(string.format("BattleStateAction onStart: role (id:%d type:%d) is ready to fight.", spriteID, type))
        end

        -- 先将自己的当前坐标设置为战斗的位置
        role:setBattleCoord(role:getCoord())
        -- 发送战斗开始的消息
        GameManager:notifyRoleFSMChange(role:getData())
        -- 先进入战斗中的待机状态
        if (self._battleState == BattleState.NONE) then
            self:idle()
        end

        if SceneManager:getInstance():isInPetPVP() then
            local nameCommand = Command.RendererCommand:create(true)
            nameCommand:initRoleName(role:getId(), role:getName(), false, false)
            self._battleMachine:pushCommand(nameCommand)
        else
            local type = role:getType()
            if (type == RoleType.Hero) then
                -- 添加对于角色名字显示控制
                local nameCommand = Command.RendererCommand:create(true)
                nameCommand:initRoleName(role:getId(),role:getName(),true,role:isMaster())
                self._battleMachine:pushCommand(nameCommand)
            end
        end

        local roleData = role:getData()
        if(roleData) then 
            local functionArr = roleData:getFunctionFlagArr()
            if(functionArr) then 
                for k, v in pairs(functionArr) do 
                    self:statusChange(v, true)
                end
            end
        end

        -- 判断是否处于逃跑阶段，用于状态恢复
        print("BattleStateAction onStart: role could not fight.", self._recoverEscape)
        if(self._recoverEscape) then
            self._recoverEscape = false
            self:runAway(true)
        end

        return true
    else
        print("BattleStateAction onStart: role could not fight.")

        return false
    end
end

function BattleStateAction:onStop()
    -- print("BattleStateAction:onStop", self._target:getSpriteID())
    self:interruptSkill(false)
end

-- 模版方法：在action更新的时候执行多次，根据情况在子类中重写
-- 返回值表示是否执行完成
function BattleStateAction:onUpdate(dt)
    if (self._interrupt) then
        return true
    else
        local complete = false
        local battleState = self._battleState

        if (battleState == BattleState.PREPARE) then
            complete = self:onPrepare(dt)
        elseif (battleState == BattleState.ATTACK) then
            complete = self:onAttack(dt)
        elseif (battleState == BattleState.USE_SKILL) then
            complete = self:onUseSkill(dt)
        elseif (battleState == BattleState.RUN_AWAY) then
            complete = self:onRunAway(dt)
        elseif (battleState == BattleState.IDLE) then
            complete = self:onIDLE(dt)
        elseif (battleState == BattleState.MOVE) then
            complete = self:onMove(dt)
        elseif (battleState == BattleState.PARRYING) then

        elseif (battleState == BattleState.FROZEN) then
        elseif (battleState == BattleState.STUN) then
        elseif (battleState == BattleState.CHARM) then
        else
            -- assert(false, "[ERROR] BattleStateAction onUpdate: no state found.")
        end
        return false
    end
end

-- 模版方法：在action结束的时候执行一次，根据情况在子类中重写
function BattleStateAction:onEnd()
    local role = self._target
    local spriteID = role:getSpriteID()
    local type = role:getType()

    if(DEBUG) then 
        print(string.format("BattleStateAction onEnd: role (id:%d type:%d) fight complete.", spriteID, type))
    end
end

-- 获取状态
function BattleStateAction:getFSMState()
    return FSMState.BATTLE
end

function BattleStateAction:recoverEscape()
    print(" BattleStateAction:recoverEscape is run")
    self._recoverEscape = true
end

-- 蓄力或者呤唱技能
function BattleStateAction:prepareSkill(skillID, attackTarget)
    if(DEBUG) then 
        print("BattleStateAction:prepareSkill", self._target:getSpriteID())
        print(string.format("BattleStateAction prepareSkill: current battle state: %d, current skill id: %d.", self._battleState, self._skillID))
    end

    if (self._battleState == BattleState.USE_SKILL and self._skillID == skillID) then
        self._skillAction:prepare()
    else
        local isMe = self._target:isMaster()
        if (isMe) then
            if(DEBUG) then 
                print(string.format("BattleStateAction prepareSkill: could not prepare skill %d for role %d.", skillID, self._target:getSpriteID()))
            end
        else
            self:useSkill(skillID, attackTarget)
        end
    end
end

-- 蓄力或呤唱技能开始倒计时
function BattleStateAction:tickPrepareSkill(skillID, duration, timeStamp)
    if(DEBUG) then 
        print("BattleStateAction:tickPrepareSkill", self._target:getSpriteID())
        print(string.format("BattleStateAction tickPrepareSkill: current battle state: %d, current skill id: %d.", self._battleState, duration, self._skillID))
    end

    -- if (self._battleState == BattleState.USE_SKILL and self._skillID == skillID) then

    --     -- Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_SKILL_ACCUMULATE, {
    --     --     skillID = skillID,
    --     --     duration = duration,
    --     --     timeStamp = timeStamp
    --     -- })
    -- else 
    --     -- assert(false)
    -- end
end

-- 释放技能
function BattleStateAction:releaseSkill(skillID, attackTarget)
    if(DEBUG) then 
        print("BattleStateAction:releaseSkill", self._target:getSpriteID())
        print(string.format("BattleStateAction releaseSkill: current battle state: %d, current skill id: %d.", self._battleState, self._skillID))
    end

    if (self._battleState == BattleState.USE_SKILL and self._skillID == skillID) then
        self._skillAction:release()
    else
        self:useSkill(skillID, attackTarget)
    end
end

--[[
    中止技能
    skillID：技能ID
    ignorForRelease:如果判断技能处理释放阶段就不中断
]] 
function BattleStateAction:breakSkill(skillID, ignorForRelease)
    if(DEBUG) then 
        print(string.format("BattleStateAction breakSkill: current battle state: %d, current skill id: %d.", self._battleState, self._skillID))
    end
    ignorForRelease = ignorForRelease or false

    if (self._battleState == BattleState.USE_SKILL and self._skillID == skillID) then
        if(ignorForRelease) then 
            if(not self._skillAction:isReleasing()) then 
                self._skillAction:interrupt()
            end
        else
            self._skillAction:interrupt()
        end
    else
        -- print(string.format("BattleStateAction breakSkill: could not break skill %d for role %d.", skillID, self._target:getSpriteID()))
    end
end

-- 中断当前技能
function BattleStateAction:interruptSkill(onlySkill)
    if(onlySkill == nil) then
        onlySkill = false
    end 

    -- TODO 目前这里中断技能只能涉及到怪物，如果是玩家就不会停止普通攻击，后期会根据需求文档来实现相关功能
    local isHero = false
    if(self._target) then
        if(self._target:getCategory() == Category.ROLE and self._target:getType() == RoleType.Hero) then 
            isHero = true
        end
    end

    -- if(isHero == false or onlySkill == false) then
    if( onlySkill == false) then
        if(self._attackAction) then
            self._attackAction:interrupt()
        end
    end

    if(self._skillAction) then
        self._skillAction:interrupt()
    end

    -- if(isHero == false or onlySkill == false) then
    if(onlySkill == false and self._target:getIsDead() == false) then
        -- print("BattleStateAction:interruptSkill", self._target:getIsDead())
        if(self._actionState ~= ActionState.COMPLETE) then
            self:idle()
        end
    end
end

-- 处理状态的逻辑处理
function BattleStateAction:statusChange(attrType, value)
    -- if(DEBUG) then
        print("BattleStateAction:statusChange ", self._battleState, attrType, value, AvalonUtil.getCurrentTime())
    -- end
    
    local roleType = 0
    local roleData = nil
    if(self._target) then
        roleData = self._target:getData()
        if(roleData) then
            if(roleData:getCategory() == Category.ROLE) then
                if(roleData:getType() == RoleType.Hero) then
                    roleType = GameDataManager:getInstance():getHeroTypeForSpriteID(roleData:getSpriteID()) 
                elseif(roleData:getType() == RoleType.Monster) then
                    roleType = 4
                end
            end
        end
    end

    -- 处理格挡
    if(attrType == FunctionFlag.FunctionFlag_Parrying) then
        -- add by zp 在有其它优先级高的状态，这里就不处理这里的状态
        local filterFlag = {
            PublicDefine.FunctionFlag.FunctionFlag_Frozen,
            PublicDefine.FunctionFlag.FunctionFlag_Stun,
            PublicDefine.FunctionFlag.FunctionFlag_Constraint
        }
        local roleData = self._target:getData()
        local handle = true
        if(roleData and roleData.getFunctionFlagArr) then
            for k,v in pairs(roleData:getFunctionFlagArr()) do 
                for k1, v1 in ipairs(filterFlag) do 
                    if(v1 == v) then 
                        handle = false
                        break
                    end
                end
                if(handle == false) then 
                    break
                end
            end
        end
        if(handle) then
            if(value) then
                self._battleState = BattleState.PARRYING

                local statusConfig = ConfigManager:getRoleStatusForStatusTypeOrRoleType(1, roleType)
                if(statusConfig ) then
                    if(DEBUG) then
                        print("BattleStateAction:statusChange  run parrying")
                    end
                    if(self._target) then
                        -- 开始格挡
                        if(statusConfig.animName ~= "") then 
                            local renderCommand = Command.RendererCommand:create(true)
                            renderCommand:initBattleStatusAnimation(self._target:getId(), statusConfig.animName, false)
                            SceneManager:getInstance():pushCommand(renderCommand)
                        end

                        if(statusConfig.fxAnimName ~= "") then
                            local renderCommand = Command.RendererCommand:create(true)
                            local fxFlip = false 
                            if(statusConfig.fxFlip == 1) then
                                fxFlip = true
                            end

                            renderCommand:initAddEffectView(self._target:getId(), statusConfig.fxAnimName, statusConfig.fxMountPoint, fxFlip)
                            SceneManager:getInstance():pushCommand(renderCommand)
                        end
                    end
                end
            else
                if(self._battleState ~= BattleState.PARRYING) then
                    -- TODO 格挡结束，根据需求恢复相关的状态

                else
                    self._battleState = BattleState.ATTACK
                    -- -- 重新开始普通攻击
                    if(self._attackAction) then
                        self._attackAction:interrupt()
                    end
                end
            end
        end
    -- 沉默标志
    elseif (attrType == FunctionFlag.FunctionFlag_Silence) then
        print("_battleState111: ", self._battleState)
        if(value) then
            -- 中断技能
            if(DEBUG) then 
                print("attrType == FunctionFlag.FunctionFlag_Silence", value)
            end
            self:interruptSkill(true)
            if(self._battleState ~= BattleState.RUN_AWAY and self._battleState ~= BattleState.MOVE) then
                if(roleData == nil or (roleData and roleData:getIsStartAttack())) then
                    self._battleState = BattleState.ATTACK
                end
            end
        else
            if(roleData == nil or (roleData and roleData:getIsStartAttack())) then
                self._battleState = BattleState.ATTACK
            end

            -- 渲染
            MachineManager:getInstance():pushDirectionRendererCommand(self._target, self._target:getDirection())
        end
    -- 封印标志
    elseif (attrType == FunctionFlag.FunctionFlag_Seal) then
        -- TODO 封印效果

    -- 眩晕
    elseif (attrType == FunctionFlag.FunctionFlag_Stun) then
        -- 处理中断技能
        if(value) then
            -- 中断技能
            -- if(DEBUG) then 
                print("attrType == FunctionFlag.FunctionFlag_Stun", value)
            -- end
            self:interruptSkill(false)
            self._battleState = BattleState.STUN
        else 
            if(roleData == nil or (roleData and roleData:getIsStartAttack())) then
                self._battleState = BattleState.ATTACK
            end
            -- 渲染
            MachineManager:getInstance():pushDirectionRendererCommand(self._target, self._target:getDirection())
        end
    -- 无法添加debuff
    elseif (attrType == FunctionFlag.FunctionFlag_NoneDebuff) then
        local scale = 1.0
        if(value) then
            scale = 1.3
        end

        if self._target and self._target:getCategory() == Category.ROLE and self._target:getType() == RoleType.Hero then
            local animationCommand = Command.RendererCommand:create(true)
            animationCommand:initRoleScale(self._target:getId(), scale)
            SceneManager:getInstance():pushCommand(animationCommand)
        end
    -- 冻结
    elseif (attrType == FunctionFlag.FunctionFlag_Frozen) then
        if(DEBUG) then 
            print("BattleStateAction:statusChange   FunctionFlag_Frozen", value, AvalonUtil.getCurrentTime())
        end
        if(value) then
            if(self._battleState ~= BattleState.FROZEN) then
                self._preBattleState = self._battleState
                self._battleState = BattleState.FROZEN

                -- 添加冻结效果
                if(self._target) then
                    local animationCommand = Command.RendererCommand:create(true)
                    animationCommand:initRoleFrozen(self._target:getId())
                    SceneManager:getInstance():pushCommand(animationCommand)
                end

                -- 处理中断技能
                self:interruptSkill(false)
            end
        else
            if(roleData == nil or (roleData and roleData:getIsStartAttack())) then
                self._battleState = BattleState.ATTACK
            end

            -- 取消冻结效果
            if(self._target) then
                local animationCommand = Command.RendererCommand:create(true)
                animationCommand:initRoleFrozenRecover(self._target:getId())
                SceneManager:getInstance():pushCommand(animationCommand)
            end

            -- 渲染
            MachineManager:getInstance():pushDirectionRendererCommand(self._target, self._target:getDirection())
        end
    elseif (attrType == FunctionFlag.FunctionFlag_Constraint) then
        if(value) then
            if(self._battleState ~= BattleState.CONSTRAINT) then
                self._preBattleState = self._battleState
                self._battleState = BattleState.CONSTRAINT

                -- 添加冻结效果
                if(self._target) then
                    local animationCommand = Command.RendererCommand:create(true)
                    animationCommand:initRoleConstraint(self._target:getId())
                    SceneManager:getInstance():pushCommand(animationCommand)
                end
                -- 处理中断技能
                self:interruptSkill(false)
            end
        else
            if(roleData == nil or (roleData and roleData:getIsStartAttack())) then
                self._battleState = BattleState.ATTACK
            end

            -- 取消冻结效果
            if(self._target) then
                local animationCommand = Command.RendererCommand:create(true)
                animationCommand:initRoleConstraintRecover(self._target:getId())
                SceneManager:getInstance():pushCommand(animationCommand)
            end
            -- 渲染
            MachineManager:getInstance():pushDirectionRendererCommand(self._target, self._target:getDirection())
        end
    elseif (attrType == FunctionFlag.FunctionFlag_Charm) then
        if(value) then
            if(self._battleState ~= BattleState.CHARM) then
                self._preBattleState = self._battleState
                self._battleState = BattleState.CHARM

                if(self._target) then
                    -- 添加idle 动画
                    MachineManager:getInstance():pushIDLERendererCommand(self._target:getId())
                end
                
                -- 处理中断技能
                self:interruptSkill(false)
            end
        else
            if(roleData == nil or (roleData and roleData:getIsStartAttack())) then
                self._battleState = BattleState.ATTACK
            end
            -- 渲染
            MachineManager:getInstance():pushDirectionRendererCommand(self._target, self._target:getDirection())
        end
    else

    end
end

-- 获取攻击对象
function BattleStateAction:getAttackTarget()
    return self._attackTarget
end

-- 是否正在攻击某个目标
function BattleStateAction:isAttackingTarget(attackedTarget)
    if (self._battleState == BattleState.ATTACK and self._attackTarget == attackedTarget) then
        return true
    end
    return false
end

-- 发送更新z序的命令
function BattleStateAction:pushUpdateZOrderCommand(coord, offset)
    if(self._target) then
        local rendererCommand = Command.RendererCommand:create(true)
        rendererCommand:initUpdateZOrderCommand(self._target:getId(), coord, offset or 0)
        self._battleMachine:pushCommand(rendererCommand)
    end
end

-- 检测是否处于逃跑中
function BattleStateAction:checkIsRunAway()
    if(self._battleState == BattleState.PARRYING) then
        return true
    end

    return false
end

