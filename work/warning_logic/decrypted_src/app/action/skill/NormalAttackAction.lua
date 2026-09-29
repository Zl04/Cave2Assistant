--[[
    技能行为－普通攻击
]]--

require "app.action.Action"
require "app.object.geometric.GeometricModel"

local MachineManager = require("app.game.MachineManager")
local SceneManager = require("app.game.SceneManager")
Action = Action or {}

local NormalAttackAction = class("NormalAttackAction", Action.Base)
Action.NormalAttackAction = NormalAttackAction

local DEBUG = false

-- 调整攻击方向
local function computeAttackDirection(self, srcTarget, dstTarget)
    local srcCoord = srcTarget:getCoord()
    local dstCoord = dstTarget:getCoord()

    local srcSize = srcTarget:getOccupySize()
    local dstSize = dstTarget:getOccupySize()

    local srcWidth = srcSize[1] or 1
    local srcHeight = srcSize[1] or 1
    local dstWidth = dstSize[1] or 1
    local dstHeight = dstSize[2] or 1

    if (dstWidth == 1 and dstHeight == 1) then
        local offsetX = dstCoord.x - srcCoord.x
        local offsetY = dstCoord.y - srcCoord.y
        if (offsetX <= -1) then
            return DirectionType.WEAST
        elseif (offsetX >= srcWidth) then
            return DirectionType.EAST
        else
            if (offsetY >= srcHeight) then
                return DirectionType.NORTH
            else
                if (offsetX >= srcWidth) then
                    return DirectionType.EAST
                else
                    return DirectionType.SOUTH
                end
            end
        end
    else
        if (srcCoord.x < dstCoord.x) then
            return DirectionType.EAST
        else 
            if (srcCoord.y < dstCoord.y) then
                return DirectionType.NORTH
            else
                local offsetX = srcCoord.x - dstCoord.x 
                local offsetY = srcCoord.y - dstCoord.y
                if (offsetX == dstWidth) then
                    return DirectionType.WEAST
                elseif (offsetY == dstHeight) then
                    return DirectionType.SOUTH
                else
                    print("[ERROR] computeAttackDirection ", srcCoord.x, srcCoord.y, dstCoord.x, dstCoord.y)
                    -- assert(false, string.format("MapView moveRole: invalid srcCoord (%f,%f)  dstCoord (%f, %f).", srcCoord.x, srcCoord.y, dstCoord.x, dstCoord.y))
                end
            end
        end
    end
    return DirectionType.NONE
end

-- private:
local function onAttack(self)
    -- 检测是否已经死亡
    local isDead = false
    if (self._attackTargetSpriteID) then 
        local battleModel = MachineManager:getInstance():getMachine():getModel()
        local attackTarget = battleModel:getRoleBySpriteID(self._attackTargetSpriteID)
        if (attackTarget) then
            isDead = attackTarget:getIsDead()
        else
            isDead = true
        end
    else
        return 
    end
    if (isDead) then  
        print(string.format("NormalAttackAction onAttack: the target %d is dead.", self._attackTargetSpriteID))
        return
    end

    local direction = DirectionType.NONE
    if (self._attackTarget) then
        -- 改变方向
        -- direction = self._target:setDirectionByTargetCoord(self._attackTarget:getCoord())
        direction = computeAttackDirection(self, self._target, self._attackTarget)
        -- 如果方向计算失败（出现了异常情况），就用以前的方向。
        if(direction == DirectionType.NONE) then
            direction = self._target:getDirection()
        else
            self._target:setDirection(direction)
        end
    else
        direction = self._target:getDirection()
    end

    MachineManager:getInstance():pushDirectionRendererCommand(self._target, direction)
    if(self._target) then
        MachineManager:getInstance():pushAttackRendererCommand(self._target:getId(), self._skill, self._animationSpeedUp)
    end

    self:triggerReleaseActEffect()
end

-- 生成飞行道具
local function createAircraft(self, flyTime)
    -- print(string.format("NormalAttackAction createAircraft: create an aircraft for skill %d.", self._skill:getSkillID()))
    
    if (self._attackTarget) then
        local skill = self._skill

        local flyTrajectory = skill:getFlyTrajectory()
        -- 0 自己飞向敌人
        -- 1 自己身上出现
        -- 2 敌人身上出现
        -- 3 敌人飞向自己
        if(flyTrajectory == 0 ) then
            -- 添加子弹到游戏场景中
            local bullet = Model.Bullet:create(true)
            bullet:init(flyTime, skill:getFlyAnimName())
            MachineManager:getInstance():addModel(bullet)

            -- 添加子弹的行为
            local fromMount = skill:getAircraftStartMount()
            local toMount = skill:getAircraftEndMount()
            local bulletAction = Action.BulletAction:create(true)
            bulletAction:init(bullet, self._target, fromMount, self._attackTarget, toMount)
            MachineManager:getInstance():setAction(bulletAction)
        elseif (flyTrajectory == 1) then
            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initAddEffectView(self._target:getId(), skill:getFlyAnimName(), skill:getAircraftEndMount(), false)
            SceneManager:getInstance():pushCommand(renderCommand)
        elseif (flyTrajectory == 2) then
            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initAddEffectView(self._attackTarget:getId(), skill:getFlyAnimName(), skill:getAircraftEndMount(), false)
            SceneManager:getInstance():pushCommand(renderCommand)
        elseif (flyTrajectory == 3) then
            -- 添加子弹到游戏场景中
            local bullet = Model.Bullet:create(true)
            bullet:init(flyTime, skill:getFlyAnimName())
            MachineManager:getInstance():addModel(bullet)

            -- 添加子弹的行为
            local fromMount = skill:getAircraftStartMount()
            local toMount = skill:getAircraftEndMount()
            local bulletAction = Action.BulletAction:create(true)
            bulletAction:init(bullet, self._attackTarget, fromMount, self._target, toMount)
            MachineManager:getInstance():setAction(bulletAction)
        end
    else
        assert(false,string.format("[ERROR] SkillAction createAircraft: no skill target found for skill %d.", self._skill:getSkillID()))
    end
end

local function triggerHit(self)
    if(self._attackTarget and self._skill) then
        local skillData = self._skill:getSkillData()
        if(skillData) then
            local effectTimeList = self._skill:getEffectTriggerTimeList()
            if(effectTimeList and #effectTimeList >= self._hitIndex) then
                if(self._interval >= effectTimeList[self._hitIndex]) then
                    self._hitIndex = self._hitIndex + 1
                    
                    if(skillData:getHitFeedBack() ~= 0) then
                        -- 抖动和闪红
                        local animationCommand = Command.RendererCommand:create(true)
                        animationCommand:initRoleHitShack(self._attackTarget:getId())
                        SceneManager:getInstance():pushCommand(animationCommand)
                    end

                    if(skillData:getHitShake() ~= 0) then
                        -- 屏幕抖动
                        Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, skillData:getHitShake(), 2)
                    end

                    if(skillData:getHitFreeze() > 0) then
                        -- 定帧
                        ToolsUtil:cardFrame(skillData:getHitFreeze())
                    end
                end
            end
        end 
    end
end

-- public:
-- 设置攻击目标
function NormalAttackAction:setAttackTarget(attackTarget)
    if (self._attackTarget ~= attackTarget) then
        self:attack(attackTarget)
    else
        print("NormalAttackAction setAttackTarget: the same attack target.")
    end
end

-- 创建对象
local NormalAttackActionPool = nil
function NormalAttackAction:create(reused, ...)
    if (reused) then
        if (not NormalAttackActionPool) then
            NormalAttackActionPool = Pool.Pool:create(NormalAttackAction)
        end
        return NormalAttackActionPool:applyObject()
    else
        return NormalAttackAction.new(...)
    end
end

-- 构造函数
function NormalAttackAction:ctor()
    NormalAttackAction.super.ctor(self, ActionType.NORMAL_ATTACK)

    -- 攻击目标
    self._attackTarget = nil
    self._attackTargetSpriteID = nil
    -- 使用的技能
    self._skill = nil
    -- 从技能开始使用，经历的时间
    self._interval = 0
    -- 打击感要触发坐标
    self._hitIndex = 1
    -- 技能的释放时常
    self._castDurationForAnimation = 0
    -- 是否普攻一次
    self._loop = true
    -- 加速
    self._speedUp = 1.0
    self._animationSpeedUp = 1.0
    -- 用于客户端表现和服务器伤害同步处理，每一个攻击动作只计算一次
    self._syncTime = 0
    self._syncSpeed = 1.0

    self._hasShowAircraft = true
end

-- 模版函数：销毁
function NormalAttackAction:dtor()
    NormalAttackAction.super.dtor(self)

    self._attackTarget = nil
    self._skill = nil
end

-- 初始化
function NormalAttackAction:init(target, attackTarget, loop)
    NormalAttackAction.super.init(self, target)
    
    self._attackTarget = attackTarget
    self._loop = (loop == nil) and true or loop
    self._interval = 0
    self._hitIndex = 1

    if (attackTarget) then
        self._attackTargetSpriteID = attackTarget:getSpriteID()
        assert(self._attackTargetSpriteID ~= nil)
    end

    local normalAttackSkill = target:getNormalAttackSkill()
    if (normalAttackSkill) then
        local castDuration = normalAttackSkill:getCastDurationForAnimation()

        local speedUp = 1.0
        local attackSpeed = 0.0
        if (target:getType() == RoleType.Hero or target:getType() == RoleType.Pet or
            target:getType() == RoleType.Monster) then
            local roleData = target:getRoleData()
            attackSpeed = roleData:getAttackDuration()

            speedUp = castDuration / attackSpeed
            self._speedUp = speedUp
            self._animationSpeedUp = (speedUp > 1.0) and speedUp or 1.0
        else
            self._speedUp = 1.0
            self._animationSpeedUp = 1.0
        end

        self._castDurationForAnimation = normalAttackSkill:getCastDurationForAnimation() / self._speedUp
    end
    self._skill = normalAttackSkill
end

-- 清理
function NormalAttackAction:clear()
    NormalAttackAction.super.clear(self)

    self._attackTarget = nil
    self._skill = nil
    self._interval = 0
    self._hitIndex = 1
    self._castDurationForAnimation = 0
    self._loop = true
    self._syncTime = 0
    self._syncSpeed = 1.0
end

-- 模版函数：action开始
function NormalAttackAction:onStart()
    -- print("NormalAttackAction onStart ", self._attackTargetSpriteID)

    self:forceUpdate()
    self._interval = 0
    self._hitIndex = 1
    self._syncSpeed = 1.0
    onAttack(self)

    return true
end

-- 模版函数：action更新
function NormalAttackAction:onUpdate(dt)
    if(self._restartFlag == true) then 
        self._restartFlag = false
        self:restart()
        return 
    end

    self._interval = self._interval + dt

    -- 触发飞行道具
    local releaseTime = self._interval
    -- 创建飞行道具
    if (not self._hasShowAircraft and releaseTime * self._animationSpeedUp >= self._skill:getAircraftShowTime()) then

        if (self._skill:hasAircraft()) then
            local flyTime = self._skill:getFlyTime() - releaseTime
            createAircraft(self, flyTime)
        end
        self._hasShowAircraft = true
    end

    triggerHit(self)

    self:refreshSpeed()
    if (self._interval >= self._castDurationForAnimation) then
        if (not self._loop) then
            return true
        else
            -- print("NormalAttackAction:onUpdate=", AvalonUtil.getCurrentTime(), self._castDurationForAnimation, self._speedUp)
            self._interval = 0
            self._hitIndex = 1
            self._syncSpeed = 1.0
            self._hasShowAircraft = false

            -- 触发补偿时间
            self:triggerSync()

            -- 获取触发打击感数据
            self._effectTriggerTimeList = self._skill:getEffectTriggerTimeList()

            MachineManager:getInstance():pushAttackRendererCommand(self._target:getId(), self._skill, self._animationSpeedUp)

            self:triggerReleaseActEffect()
        end
    end

    return false
end

-- 模版函数：action结束
function NormalAttackAction:onEnd()
    -- print("NormalAttackAction onEnd ", self._attackTargetSpriteID)
end

-- 改变攻击目标
function NormalAttackAction:attack(attackTarget)
    self._interval = 0
    self._hitIndex = 1

    if (attackTarget and attackTarget ~= self._target) then
        self._attackTarget = attackTarget

        self._attackTargetSpriteID = self._attackTarget:getSpriteID()
        assert(self._attackTargetSpriteID ~= nil)
    end

    self:restart()
end

function NormalAttackAction:getSkillIntervalTime()
    return self._interval * self._speedUp
end

function NormalAttackAction:setSkillSyncTime(syncTime)
    -- print("NormalAttackAction:setSkillSyncTime", syncTime)
    self._syncTime = syncTime
    self:triggerSync()
end

function NormalAttackAction:triggerSync()
    if(self._syncSpeed == 1.0) then 
        local normalAttackSkill = self._target:getNormalAttackSkill()
        local castDuration = 0
        if (normalAttackSkill) then
            castDuration = normalAttackSkill:getCastDurationForAnimation()
        end

        if(self._syncTime >0) then 
            if(self:getSkillIntervalTime() < self._castDurationForAnimation * self._speedUp * 0.2) then 
                if(self._syncTime < castDuration * 0.2) then 
                    self._syncSpeed = 1.0 - self._syncTime / (self._castDurationForAnimation - self:getSkillIntervalTime())
                    if(self._syncSpeed < 0.9) then 
                        self._syncSpeed = 0.9
                    end
                    -- print("NormalAttackAction:triggerSync 减慢 1 =", self._syncSpeed, self._syncTime, self._castDurationForAnimation, self:getSkillIntervalTime())
                    self:refreshSpeed()
                    self._syncTime = 0
                else
                -- elseif (self._syncTime > castDuration * 0.9) then
                    self._syncSpeed = 1.0 + (self._castDurationForAnimation *self._speedUp - self._syncTime) / (self._castDurationForAnimation - self:getSkillIntervalTime())
                    if(self._syncSpeed <0.9) then 
                        self._syncSpeed = 0.9
                    end
                    -- print("NormalAttackAction:triggerSync 加快 1 =", self._syncSpeed, self._syncTime, self._castDurationForAnimation, self:getSkillIntervalTime())
                    self:refreshSpeed()
                    self._syncTime = 0
                end 
            else 
                -- print("NormalAttackAction:triggerSync 无处理 =")
            end 
        end
    end
end

function NormalAttackAction:refreshSpeed()
    local target = self._target
    if(self._skill == nil) then 
        self._skill = target:getNormalAttackSkill()
    end

    if (self._skill) then
        local castDuration = self._skill:getCastDurationForAnimation()

        local speedUp = 1.0
        local attackSpeed = 0.0
        -- 处理攻击速率变化
        local oldSpeed = self._animationSpeedUp
        if (target:getType() == RoleType.Hero or target:getType() == RoleType.Pet or
            target:getType() == RoleType.Monster) then
            local roleData = target:getRoleData()
            attackSpeed = roleData:getAttackDuration()

            speedUp = castDuration / attackSpeed
            self._speedUp = speedUp * self._syncSpeed
            self._animationSpeedUp = ((speedUp > 1.0) and speedUp or 1.0) * self._syncSpeed
        else
            self._speedUp = 1.0 * self._syncSpeed
            self._animationSpeedUp = 1.0 * self._syncSpeed
        end

        if(oldSpeed ~= self._animationSpeedUp) then
            local animationCommand = Command.RendererCommand:create(true)
            animationCommand:initUpdateSpineTimeScale(self._target:getId(), self._animationSpeedUp)
            SceneManager:getInstance():pushCommand(animationCommand)
        end

        self._castDurationForAnimation = self._skill:getCastDurationForAnimation() / self._speedUp
    end
end

function NormalAttackAction:triggerReleaseActEffect()

    local skillActTargetType,actAnimMount,actAnimName,actAnimTiming = self._skill:getReleaseActAnimation()
    self._hasShowAircraft = false

    -- print("NormalAttackAction  onAttack wwwwwwwwwww", self._target:getSpriteID(), self._skill:hasAircraft())
    if(skillActTargetType and actAnimMount and actAnimName and actAnimTiming) then 
        -- print("NormalAttackAction  onAttack eeeeeeee", self._target:getSpriteID(), #skillActTargetType, #actAnimMount, #actAnimName,  #actAnimTiming)
        if(#skillActTargetType ==  #actAnimMount and #actAnimMount == #actAnimName and #actAnimName == #actAnimTiming) then
            for i=1,#skillActTargetType do 
                local isSelf = true
                local target = self._target
                if(skillActTargetType[i] == 2 and self._attackTarget) then 
                    target = self._attackTarget
                    isSelf = false
                end

                if(actAnimMount[i] == "mount_screen") then
                    -- 触发事件id
                    local PlotManager = require("app.game.PlotManager")
                    PlotManager:getInstance():runPlotByID(actAnimName[i])
                else 
                    -- print("NormalAttackAction  onAttack ", self._target:getSpriteID(), actAnimName[i], actAnimMount[i], actAnimTiming[i], 1)
                    local command = Command.RendererCommand:create(true)
                    command:initReleaseActAnimationCommand(target:getId(), self._target:getSpriteID(), actAnimName[i], actAnimMount[i], actAnimTiming[i], 1, self._target:getDirection(), isSelf)
                    SceneManager:getInstance():pushCommand(command)
                end
            end
        end
    end
end

-- 中断
function NormalAttackAction:interrupt()
    if DEBUG then
        if(self._skill) then
            print(string.format("NormalAttackAction interrupt: interrupt the skill %d.", self._skill:getSkillID()))
        else 
            print("NormalAttackAction interrupt: interrupt the skill")
        end
    end
    
    if(self._target) then
        if DEBUG then
            print("NormalAttackAction:interrupt ", self._target:getSpriteID())
        end
        local command = Command.RendererCommand:create(true)
        command:initReleaseActAnimationRemoveCommand(self._target:getId(), self._target:getSpriteID())
        SceneManager:getInstance():pushCommand(command)
    end

    if(self._attackTarget and self._target) then 
        if DEBUG then
            print("NormalAttackAction:interrupt ", self._attackTarget:getSpriteID())
        end
        local command = Command.RendererCommand:create(true)
        command:initReleaseActAnimationRemoveCommand(self._attackTarget:getId(), self._target:getSpriteID())
        SceneManager:getInstance():pushCommand(command)
    end

    -- 清理技能特效
    if(self._target) then
        local command = Command.RendererCommand:create(true)
        command:initClearSkillFXCommmand(self._target:getId())
        SceneManager:getInstance():pushCommand(command)
    end

    if (self._skill) then
        local skillData = self._skill:getSkillData()
        if(skillData) then
            local isMaster = false
            if(self._target) then 
                isMaster = self._target:isMaster()
            end
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_SKILL_BREAK, skillData:getId(), Game.UseSkillState.RELEASE, isMaster)
        end
    end

    if(self._target and self._target:getIsDead() == false) then 
        -- 这里直接重启，会导致触发普通攻击的逻辑问题，这里想利用状态会屏蔽update来控制重复攻击的控制
        self._restartFlag = true
        -- -- 回归数据
        -- self:restart()
    end
end

