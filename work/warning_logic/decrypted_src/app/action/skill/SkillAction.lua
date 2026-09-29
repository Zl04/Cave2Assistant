--[[
    技能行为基础类
]]--

require "app.action.Action"
local MachineManager = require("app.game.MachineManager")
local SceneManager = require("app.game.SceneManager")
Action = Action or {}

local SkillAction = class("SkillAction", Action.Base)
Action.SkillAction = SkillAction

local UseSkillState = Game.UseSkillState 

-- private:
local DEBUG = false

-- 调整攻击方向
local computeDirection = Geome.computeDirection
local function computeAttackDirection(self, srcTarget, dstTarget)
    if (srcTarget == dstTarget) then
        return DirectionType.NONE
    end
    if (srcTarget:getType() == RoleType.Hero) then
        return DirectionType.NONE
    end

    local srcCoord = srcTarget:getCoord()
    local dstCoord = dstTarget:getCoord()

    local srcSize = srcTarget:getOccupySize()
    local dstSize = dstTarget:getOccupySize()

    local srcWidth = srcSize[1] or 1
    local srcHeight = srcSize[1] or 1
    local dstWidth = dstSize[1] or 1
    local dstHeight = dstSize[2] or 1

    if (srcWidth == 1 and srcHeight == 1 and dstWidth == 1 and dstHeight == 1) then
        return computeDirection(srcCoord, dstCoord)
    end

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

-- 生成飞行道具
local function createAircraft(self, flyTime)
    if(DEBUG) then
        print(string.format("SkillAction createAircraft: create an aircraft for skill %d.", self._skill:getSkillID()))
    end
    
    if (self._skillTarget) then
        local skill = self._skill
        if(skill) then
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
                bulletAction:init(bullet, self._target, fromMount, self._skillTarget, toMount)
                MachineManager:getInstance():setAction(bulletAction)
            elseif (flyTrajectory == 1) then
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initAddEffectView(self._target:getId(), skill:getFlyAnimName(), skill:getAircraftEndMount(), false)
                SceneManager:getInstance():pushCommand(renderCommand)
            elseif (flyTrajectory == 2) then
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initAddEffectView(self._skillTarget:getId(), skill:getFlyAnimName(), skill:getAircraftEndMount(), false)
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
                bulletAction:init(bullet, self._skillTarget, fromMount, self._target, toMount)
                MachineManager:getInstance():setAction(bulletAction)
            end
        end
    else
        assert(false, string.format("[ERROR] SkillAction createAircraft: no skill target found for skill %d.", self._skill:getSkillID()))
    end
end

-- 技能准备 
local function prepareSkill(self)
    if(DEBUG) then
        print(string.format("SkillAction prepareSkill: prepare skill %d.", self._skill:getSkillID()))
    end

    if (self._skill:hasPrepareAction()) then
        if DEBUG then
            print(string.format("SkillAction prepareSkill: render preparing skill %d.", self._skill:getSkillID()))
        end

        if(self._target and self._target:getCategory() == Category.ROLE 
            and (self._target:getType() == RoleType.Pet or (self._target:getType() ==  RoleType.Hero and self._target:isMaster()))) then
            -- 发送吟唱表现指令
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_SKILL_ACCUMULATE, {
                skillID = self._skill:getSkillID(),
                duration = self._skill:getPrepareTime()*1000,
                timeStamp = GameManager:getNowServerTimestamp()
            }, (self._target:getType() ==  RoleType.Hero and self._target:isMaster()))
        end

        -- 如果有技能目标，转向
        if (self._skillTarget) then
            -- local direction = self._target:setDirectionByTargetCoord(self._skillTarget:getCoord())
            local direction = computeAttackDirection(self, self._target, self._skillTarget)
            MachineManager:getInstance():pushDirectionRendererCommand(self._target, direction)
        end

        -- 渲染技能呤唱的动画
        if(self._target) then
            local command = Command.RendererCommand:create(true)
            command:initPrepareSkillCommand(self._target:getId(), self._skill)
            SceneManager:getInstance():pushCommand(command)

            -- 玩家自己才播放音效
            if(self._target:getCategory() == Category.ROLE and (self._target:getType() ==  RoleType.Pet or 
                (self._target:getType() ==  RoleType.Hero and self._target:isMaster()))) then
                self.prepareSound = Avalon.AudioManager:playSound("558", true)
            end
        end
    else
        self:release()
    end
end

-- 技能释放
local function releaseSkill(self)
    if(DEBUG) then
        print(string.format("SkillAction releaseSkill: release skill %d.", self._skill:getSkillID()))
    end

    if (self._skill:hasReleaseAction()) then
        if DEBUG then
            print(string.format("SkillAction releaseSkill: render releasing skill %d.", self._skill:getSkillID()))
        end

        -- 如果有技能目标，转向
        if (self._skillTarget) then
            -- local direction = self._target:setDirectionByTargetCoord(self._skillTarget:getCoord())
            local direction = computeAttackDirection(self, self._target, self._skillTarget)
            MachineManager:getInstance():pushDirectionRendererCommand(self._target, direction)
        end
        -- 渲染技能释放的动画
        if(self._target) then
            local command = Command.RendererCommand:create(true)
            command:initReleaseSkillCommand(self._target:getId(), self._skill)
            SceneManager:getInstance():pushCommand(command)
        end

        local skillActTargetType,actAnimMount,actAnimName,actAnimTiming = self._skill:getReleaseActAnimation()

        -- print("SkillAction  releaseSkill wwwwwwwwwww", self._target:getSpriteID())
        if(skillActTargetType and actAnimMount and actAnimName and actAnimTiming) then 
            -- print("SkillAction  releaseSkill eeeeeeee", self._target:getSpriteID(), #skillActTargetType, #actAnimMount, #actAnimName,  #actAnimTiming)
            if(#skillActTargetType ==  #actAnimMount and #actAnimMount == #actAnimName and #actAnimName == #actAnimTiming) then
                for i=1,#skillActTargetType do 
                    local isSelf = true
                    local target = self._target
                    if(skillActTargetType[i] == 2) then 
                        target = self._skillTarget
                        isSelf = false
                    end

                    if(actAnimMount[i] == "mount_screen") then
                        -- 触发事件id
                        local PlotManager = require("app.game.PlotManager")
                        PlotManager:getInstance():runPlotByID(actAnimName[i])
                    else 
                        -- print("SkillAction  releaseSkill nnnnn", self._target:getSpriteID(), actAnimName[i], actAnimMount[i], actAnimTiming[i], 1)
                        if(target and self._target) then
                            local command = Command.RendererCommand:create(true)
                            command:initReleaseActAnimationCommand(target:getId(), self._target:getSpriteID(), actAnimName[i], actAnimMount[i], actAnimTiming[i], 1, self._target:getDirection(), isSelf)
                            SceneManager:getInstance():pushCommand(command)
                        end
                    end
                end
            end
        end
    end
end

-- 完成技能
local function finishSkill(self)
    if(DEBUG) then
        print(string.format("SkillAction finishSkill: finish skill %d.", self._skill:getSkillID()))
    end

    if (self._skill:hasFinishAction()) then
        if DEBUG then
            print(string.format("SkillAction finishSkill: render finishing skill %d.", self._skill:getSkillID()))
        end

        if(self._target) then
            local command = Command.RendererCommand:create(true)
            command:initFinishSkillCommand(self._target:getId(), self._skill)
            SceneManager:getInstance():pushCommand(command)
        end
    end
end

-- 生成技能准备特效
local function createPrepareFX(self)
    if (self._skill:hasPrepareFX()) then
        if DEBUG then
            print(string.format("SkillAction createPrepareFX: create a preparing skill %d fx.", self._skill:getSkillID()))
        end

        if(self._target) then
            local command = Command.RendererCommand:create(true)
            command:initPrepareSkillFXCommand(self._target:getId(), self._skill)
            SceneManager:getInstance():pushCommand(command)
        end
    else
        if DEBUG then
            print(string.format("SkillAction createPrepareFX: no preparing skill %d fx found.", self._skill:getSkillID()))
        end
    end
end

-- 结束技能准备的特效
local function finishPrepareFX(self)
    if DEBUG then
        print(string.format("SkillAction finishPrepareFX: finish the preparing skill %d fx.", self._skill:getSkillID()))
    end

    if(self._target) then
        local command = Command.RendererCommand:create(true)
        command:initFinishPrepareSkillFXCommand(self._target:getId(), self._skill)
        SceneManager:getInstance():pushCommand(command)

        if(self.prepareSound) then
            Avalon.AudioManager:stopSound(self.prepareSound)
            self.prepareSound = nil
        end
    end
end

-- 生成技能释放特效
local function createReleaseFX(self)
    if (self._skill:hasReleaseFX()) then
        if DEBUG then
            print(string.format("SkillAction createReleaseFX: create a releasing skill %d fx.", self._skill:getSkillID()))
        end

        if(self._target) then
            local command = Command.RendererCommand:create(true)
            command:initReleaseSkillFXCommand(self._target:getId(), self._skill)
            SceneManager:getInstance():pushCommand(command)
        end
    else
        if DEBUG then
            print(string.format("SkillAction finishPrepareFX: no releasing skill %d fx found.", self._skill:getSkillID()))
        end
    end
end

local function triggerHit(self)
    if(self._skillTarget and self._skill) then
        local skillData = self._skill:getSkillData()
        if(skillData) then
            --  print("SkillAction   triggerHit  0")
            local effectTimeList = self._skill:getEffectTriggerTimeList()
            if(effectTimeList and #effectTimeList >= self._hitIndex) then
                if(self._releaseTime >= effectTimeList[self._hitIndex]) then
                    self._hitIndex = self._hitIndex + 1
                    
                    if(skillData:getHitFeedBack() ~= 0) then
                        -- print("SkillAction   triggerHit  1", self._skillTarget:getSpriteID())
                        -- 抖动和闪红
                        local animationCommand = Command.RendererCommand:create(true)
                        animationCommand:initRoleHitShack(self._skillTarget:getId())
                        SceneManager:getInstance():pushCommand(animationCommand)
                    end

                    if(skillData:getHitShake() ~= 0) then
                        -- 屏幕抖动
                        -- print("SkillAction   triggerHit  2")
                        Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, skillData:getHitShake(), 2)
                    end

                    if(skillData:getHitFreeze() > 0) then
                        -- 定帧
                        -- print("SkillAction   triggerHit  3")
                        ToolsUtil:cardFrame(skillData:getHitFreeze())
                    end
                end
            end
        end 
    end
end

-- public:
-- 蓄力或者呤唱
function SkillAction:prepare()
    if(DEBUG) then
        print(string.format("SkillAction prepare: prepare to use skill %d.", self._skill:getSkillID()))
    end

    self._state = UseSkillState.PREPARE
    self._prepareTime = 0

    -- 准备技能（蓄力或者呤唱）
    prepareSkill(self)
    -- 技能准备的特效
     if (self._prepareFXTime == 0) then
        createPrepareFX(self)
        self._hasPreparedFX = true
    end
end
function SkillAction:onPrepare(dt)
    self._prepareTime = self._prepareTime + dt
    local prepareTime = self._prepareTime
    self._interrupt = false
    
    -- 技能准备的特效
     if (not self._hasPreparedFX and prepareTime >= self._prepareFXTime) then
        createPrepareFX(self)
        self._hasPreparedFX = true
    end
    -- 是否由外层通知技能释放
    if (not self._waitToRelease) then
        if (prepareTime >= self._skillPrepareTime) then
            self:release()
        end
    end

    return false
end

-- 释放
function SkillAction:release()
    if(DEBUG) then
        print(string.format("SkillAction release: release the skill %d.", self._skill:getSkillID()))
    end

    if(self.prepareSound) then
        Avalon.AudioManager:stopSound(self.prepareSound)
        self.prepareSound = nil
    end

    self._state = UseSkillState.RELEASE
    self._releaseTime = 0
    self._hitIndex = 1
    self._interrupt = false

    -- 释放技能
    releaseSkill(self)
    -- 结束呤唱动作的特效
    if (self._hasPreparedFX) then
        finishPrepareFX(self)
    end
    -- 技能释放的特效
    if (self._releaseFXTime == 0) then
        createReleaseFX(self)
        self._hasReleaseFX = true
    end

    if (self._target and (self._target:isMaster() or self._target:getType() == RoleType.Pet)) then
        local skillData = self._skill:getSkillData()
        if(skillData) then
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_SKILL_RELEASE, skillData, self._target:isMaster())
        end
    end
end
function SkillAction:onRelease(dt)
    self._releaseTime = self._releaseTime + dt
    local releaseTime = self._releaseTime

    triggerHit(self)

    -- 技能释放的特效
    if (not self._hasReleaseFX and releaseTime >= self._releaseFXTime) then
        createReleaseFX(self)
        self._hasReleaseFX = true
    end
    -- 创建飞行道具
    if (not self._hasShowAircraft and releaseTime >= self._aircraftShowTime) then
        if (self._skill:hasAircraft()) then
            local flyTime = self._skill:getFlyTime() - releaseTime
            createAircraft(self, flyTime)
        end
        self._hasShowAircraft = true
    end
    -- 技能释放是否完成
    if (releaseTime >= self._skillReleaseTime) then
        self:finish()
    end

    return false
end

-- 准备就绪
function SkillAction:finish()
    if(DEBUG) then
        if(self._skill) then
            print(string.format("SkillAction finish: finish the skill %d.", self._skill:getSkillID()))
        end
    end 

    if(self.prepareSound) then
        Avalon.AudioManager:stopSound(self.prepareSound)
        self.prepareSound = nil
    end

    self._state = UseSkillState.DONE

    -- 完成技能
    finishSkill(self)
end

-- 中断
function SkillAction:interrupt()
    if(DEBUG) then
        if(self._skill) then
            print(string.format("SkillAction interrupt: interrupt the skill %d.", self._skill:getSkillID()))
        else 
            print("SkillAction interrupt: interrupt the skill")
        end
    end

    if(self.prepareSound) then
        Avalon.AudioManager:stopSound(self.prepareSound)
        self.prepareSound = nil
    end

    if(self._interrupt) then
        return 
    end
    self._interrupt = true

    local oldState = self._state

    -- 清理技能状态
    self:clearState()

    if(self._target) then
        if(DEBUG) then
            print("SkillAction:interrupt ", self._target:getSpriteID())
        end
        local command = Command.RendererCommand:create(true)
        command:initReleaseActAnimationRemoveCommand(self._target:getId(), self._target:getSpriteID())
        SceneManager:getInstance():pushCommand(command)
    end

    if(self._skillTarget and self._target) then 
        if(DEBUG) then
            print("SkillAction:interrupt ", self._skillTarget:getSpriteID())
        end
        local command = Command.RendererCommand:create(true)
        command:initReleaseActAnimationRemoveCommand(self._skillTarget:getId(), self._target:getSpriteID())
        SceneManager:getInstance():pushCommand(command)
    end

    -- 清理技能特效
    if(self._target) then
        local command = Command.RendererCommand:create(true)
        command:initClearSkillFXCommmand(self._target:getId())
        SceneManager:getInstance():pushCommand(command)
    end

    if (self._target and (self._target:isMaster() or self._target:getType() == RoleType.Pet) and self._skill) then
        local skillData = self._skill:getSkillData()
        if(skillData) then
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_SKILL_BREAK, skillData:getId(), oldState, self._target:isMaster())
        end
    end
end

-- 设置技能目标
function SkillAction:setSkillTarget(skillTarget)
    if (self._skillTarget ~= skillTarget) then
        self._skillTarget = skillTarget
    else
        if(DEBUG) then
            print("SkillAction setSkillTarget: the same skill target.")
        end
    end
end

-- 创建对象
local SkillActionPool = nil
function SkillAction:create(reused, ...)
    if (reused) then
        if (not SkillActionPool) then
            SkillActionPool = Pool.Pool:create(SkillAction)
        end
        return SkillActionPool:applyObject()
    else
        return SkillAction.new(...)
    end
end

-- 构造函数
function SkillAction:ctor()
    SkillAction.super.ctor(self, ActionType.SKILL)

    self._waitToRelease = true
    self._skill = nil
    self._skillTarget = nil
    self._interrupt = false
    self._state = UseSkillState.NONE

    self.prepareSound = nil

    self._prepareTime = 0
    self._skillPrepareTime = 0
    self._releaseTime = 0
    self._hitIndex = 1
    self._skillReleaseTime = 0
    self._aircraftShowTime = 0

    -- 呤唱产生特效的时间
    self._hasPreparedFX = false
    self._prepareFXTime = 0
    -- 释放产生特效的时间
    self._hasReleaseFX = false
    self._releaseFXTime = 0
    -- 是否已经产生了飞行道具
    self._hasShowAircraft = false

    if (DEBUG) then
        self._effectTimeList = {}
    end
end

-- 模版函数：销毁
function SkillAction:dtor()
    SkillAction.super.dtor(self)
    if(DEBUG) then
        print("SkillAction:dtor")
    end
    self._skill = nil
    self._skillTarget = nil

    if (DEBUG) then
        self._effectTimeList = nil
    end
end

-- 初始化
function SkillAction:init(target, skillID, skillTarget, skillState)
    SkillAction.super.init(self, target)

    self._skill = self._target:getSkillById(skillID)
    if (not skillState) then 
        self._state = UseSkillState.IDLE
    else 
        self._state = skillState
    end
    if(self._skill) then 
        self._skillPrepareTime = self._skill:getPrepareTime()
        self._skillReleaseTime = self._skill:getReleaseTime()
        self._prepareFXTime = self._skill:getPrepareFXTime()
        self._releaseFXTime = self._skill:getReleaseFXTime()
        self._aircraftShowTime = self._skill:getAircraftShowTime()
    end

    self._skillTarget = skillTarget

    if (DEBUG) then
        self._effectTimeList = self._skill:getEffectTriggerTimeList()
    end
end

-- 清理技能状态
function SkillAction:clearState()
    self._state = UseSkillState.NONE
end

-- 清理
function SkillAction:clear()
    if(DEBUG) then
        print("SkillAction:clear")
    end
    SkillAction.super.clear(self)

    if(self.prepareSound) then
        Avalon.AudioManager:stopSound(self.prepareSound)
        self.prepareSound = nil
    end

    self._waitToRelease = true

    self._skill = nil
    self._skillTarget = nil
    self._interrupt = false
    self._state = UseSkillState.NONE

    self._prepareTime = 0
    self._skillPrepareTime = 0
    self._releaseTime = 0
    self._hitIndex = 1
    self._skillReleaseTime = 0
    self._aircraftShowTime = 0

    self._hasPreparedFX = false
    self._prepareFXTime = 0
    self._hasReleaseFX = false
    self._releaseFXTime = 0
    self._hasShowAircraft = false

    if (DEBUG) then
        self._effectTimeList = nil
    end
end

-- 获取技能id
function SkillAction:getSkillID()
    if (self._skill) then
        return self._skill:getSkillID()
    end
    return 0
end

-- 获取技能数据
function SkillAction:getSkillData()
    if(self._skill) then
        return self._skill:getSkillData()
    end

    return nil
end

-- 是否正在呤唱或者蓄力
function SkillAction:isPreparing()
    return self._state == UseSkillState.PREPARE
end

-- 是否正在释放技能
function SkillAction:isReleasing()
    return self._state == UseSkillState.RELEASE
end

-- 是否已经完成释放技能
function SkillAction:isDone()
    return self._state == UseSkillState.DONE
end

-- 模版函数：action开始
function SkillAction:onStart()
    if(DEBUG) then
        print("SkillAction:onStart")
    end
    local skillState = self._state
    if (skillState == UseSkillState.IDLE or 
        skillState == UseSkillState.PREPARE) then
        self:prepare()
    elseif (skillState == UseSkillState.RELEASE) then
        self:release()
    else
        return false
    end
    self:forceUpdate()
    return true
end

-- 模版函数：action更新
function SkillAction:onUpdate(dt)
    if (self._interrupt) then
        return true
    else
        local complete = false
        local state = self._state

        if (state == UseSkillState.PREPARE) then
            complete = self:onPrepare(dt)
        elseif (state == UseSkillState.RELEASE) then
            complete = self:onRelease(dt)
        elseif (state == UseSkillState.DONE) then
            complete = true
        elseif (state == UseSkillState.IDLE) then
            -- NOTHING
        else
            assert(false,string.format("[ERROR] SkillAction onUpdate: state is invalid.", state))
        end
        return complete
    end
end

-- 模版函数：action结束
function SkillAction:onEnd()
    if(DEBUG) then
        print("SkillAction:onEnd")
    end
end

