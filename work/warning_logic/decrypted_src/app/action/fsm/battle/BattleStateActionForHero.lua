--[[
    玩家自己的战斗行为
]]--

require "app.action.fsm.battle.BattleStateAction"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
Action = Action or {}

local BattleStateActionForHero = class("BattleStateActionForHero", Action.BattleStateAction)
Action.BattleStateActionForHero = BattleStateActionForHero

local BattleStateAction = Action.BattleStateAction
local computeSpeedComp = Geome.computeSpeedComp
local computeMoveDuration = Geome.computeMoveDuration
local computeDirection = Geome.computeDirection
local TRIGGER_TYPE = GameTriggerType

local DEBUG = false

-- private:
-- 在战斗中移动位置
function moveHero(self, srcCoord, dstCoord)
    if (srcCoord and dstCoord) then
        if (self._moveComplete) then
            self._moveComplete = false
            self._toMove = true
            self._moveTime = 0

            self._moveCoord:setCoord(srcCoord)
            self._standCoord:setCoord(dstCoord)
        else
            self._moveTime = 0
            
            self._standCoord:setCoord(dstCoord)
        end

        local speed = self._target:getSpeed()

        self._moveDuration = computeMoveDuration(self._moveCoord, self._standCoord, speed)
        -- add by zp 这里是修改进出战斗表现卡顿问题。
        if(self._moveDuration < 0.33) then
            speed = speed * (self._moveDuration/0.33)
            self._moveDuration = computeMoveDuration(self._moveCoord, self._standCoord, speed)
        elseif(self._moveDuration > 1) then
            print("moveHero=", srcCoord, dstCoord)
            -- printError("self._moveDuration=", self._moveDuration)
            self._moveCoord:setCoord(self._originCoord)
            self._moveDuration = computeMoveDuration(self._moveCoord, self._standCoord, speed)
        end
        self._speedX, self._speedY, self._speedZ = computeSpeedComp(self._moveCoord, self._standCoord, speed)        
    else
        self._moveComplete = true
        self._toMove = false
    end
end

-- public:
-- 在战斗中移动到指定位置
function BattleStateActionForHero:moveToCoord(dstCoord)
    if (dstCoord) then
        --没有赋过值
        if(self._standCoord.x == 0 and self._standCoord.y == 0) then
            moveHero(self, self._target:getCoord(), dstCoord)
        end
    end
end
-- 移动到逻辑更新
function BattleStateActionForHero:onMoveToCoord(dt)
    if (not self._moveComplete) then
        self._moveTime = self._moveTime + dt
        if (self._moveTime >= self._moveDuration) then
            MachineManager:getInstance():pushPositionRendererCommand(self._target, self._standCoord, self._target:isMaster())
            -- self:pushUpdateZOrderCommand(self._originCoord, 0)

            self._moveComplete = true
            self._toMove = false
            
            self._target:setBattleCoord(self._standCoord)

            if (self._moveCallback) then
                self._moveCallback()
            end
            --战斗开始时 宠物每次移动完后都要调整一次朝向
            if self._target:getType() == RoleType.Pet then
                if(self._attackTarget) then
                    local coord = self._attackTarget:getCoord()
                    if(coord) then 
                        local direction = computeDirection(self._standCoord, coord)
                        self._target:setCoord(self._standCoord.x, self._standCoord.y, self._standCoord.z)
                        self._target:setDirection(direction)
                        MachineManager:getInstance():pushDirectionRendererCommand(self._target, direction)
                    end
                end
            end
            return true
        else
            local disX, disY, disZ = self._speedX * dt, self._speedY * dt, self._speedZ * dt
            local coord = self._moveCoord
            coord:addValue(disX, disY, disZ)
            
            MachineManager:getInstance():pushPositionRendererCommand(self._target, coord, self._target:isMaster())
            -- self:pushUpdateZOrderCommand(self._originCoord, 0)

            self._target:setBattleCoord(coord)

            return false
        end
    else
        return true
    end
end

function BattleStateActionForHero:getDotMoveFowardAfterWin(roleData)
    if (roleData:getType() == RoleType.Monster) then
        if(not roleData:getIsMoveFowardAfterWin()) then 
            return true
        end
    end
        
    return false
end

-- 普通攻击
function BattleStateActionForHero:attack(attackTarget)
    if (self._battleState == BattleState.RUN_AWAY) then
        if(DEBUG) then
            print(string.format("BattleStateActionForHero attack: role is running away, could not attack.", self._target:getSpriteID()))
        end
    else
        BattleStateAction.attack(self, attackTarget)
        if attackTarget then
            self._dstCoord:setCoord(attackTarget:getCoord())

            local roleData = attackTarget:getData()
            if (self:getDotMoveFowardAfterWin(roleData)) then
                self._moveFowardAfterWin = false
            end
            if(DEBUG) then
                print("BattleStateActionForHero init ", roleData:getCategory(), roleData:getType(), roleData:isSmallBoss())
            end
        end
    end
end

-- 使用技能
function BattleStateActionForHero:useSkill(skillID, attackTarget, skillState)
    if (self._battleState == BattleState.RUN_AWAY) then
        if(DEBUG) then
            print(string.format("BattleStateActionForHero useSkill: role is running away, could not attack.", self._target:getSpriteID()))
        end
    else
        BattleStateAction.useSkill(self, skillID, attackTarget, skillState)
        -- if attackTarget then
        --     self._dstCoord:setCoord(attackTarget:getCoord())
        -- end
    end
end
-- 技能使用的逻辑更新
function BattleStateActionForHero:onUseSkill(dt)
    local isComplete = BattleStateAction.onUseSkill(self, dt)
    if (isComplete) then self:attack()
    end
    return isComplete
end

-- 离开战斗
function BattleStateActionForHero:runAway(recover)
    if (self._battleState == BattleState.RUN_AWAY) then return end

    if(DEBUG) then
        print(string.format("BattleStateActionForHero runAway: role %d is running away.", self._target:getSpriteID()))
    end

    self._battleState = BattleState.RUN_AWAY
    self._runAwayTime = 0.0

    if(self._skillAction) then
        self._skillAction:interrupt()
    end 

    -- 反向
    local direction = self._target:reverseDirection()
    -- 渲染
    MachineManager:getInstance():pushDirectionRendererCommand(self._target, direction)
    MachineManager:getInstance():pushMoveRendererCommmand(self._target)

    -- 发送逃跑消息
    if (self._target:isMaster()) then
        if (RoleBehaviorManager:escapeCheck()) then 
            self._target:setIsEscape(true)
            if(recover) then 
            else 
                Net.NetRoleSystem:heroEscapeRequest()
            end
        end 
    end
end

function BattleStateActionForHero:runAwayCancel()
    if (self._preBattleState == BattleState.RUN_AWAY) then 
        self._preBattleState = BattleState.ATTACK
    end

    if (self._battleState == BattleState.RUN_AWAY) then 
        self._battleState = BattleState.ATTACK
    end

    -- 
    if(self._target) then
        self._target:setIsEscape(false)
        -- 反向
        local direction = self._target:reverseDirection()
    end
end

-- 逃跑失败
function BattleStateActionForHero:runAwayFailed()
    if (self._battleState == BattleState.RUN_AWAY) then 
        self._battleState = BattleState.ATTACK
        if(self._target) then
            self._target:setIsEscape(false)
            -- 反向
            local direction = self._target:reverseDirection()
            -- 渲染
            MachineManager:getInstance():pushDirectionRendererCommand(self._target, direction)
        end
    end
end

-- 离开战斗的逻辑
function BattleStateActionForHero:onRunAway(dt)
    self._runAwayTime = self._runAwayTime + dt

    return false
end

-- 战斗中的移动
function BattleStateActionForHero:move(dstCoord, callback)
    if(DEBUG) then
        print(string.format("BattleStateActionForHero move: role %d is moving to (%f,%f).", self._target:getSpriteID(), dstCoord.x, dstCoord.y))
    end

    self._battleState = BattleState.MOVE
    self._moveCallback = callback

    moveHero(self, self._standCoord, dstCoord)
    self._toMove = false

    MachineManager:getInstance():pushMoveRendererCommmand(self._target)
end
-- 战斗中移动的逻辑
function BattleStateActionForHero:onMove(dt)
    if (self:onMoveToCoord(dt)) then
        self:idle()
        self._interrupt = true
        if (self._isWin) then
            self._target:getCoord():setCoord(self._standCoord)

            -- 修改位置后添加到地图上面
            MapDataManager:getInstance():addRole(
                GameMapManager:getInstance():getMapData(),
                Avalon.MathUtil:getInt(self._standCoord.x),
                Avalon.MathUtil:getInt(self._standCoord.y),
                self._target:getData()
            )
            -- 发送移动消息
            Avalon.MessageCenter:notice(
                GameMessage.MC_ROLE_UPDATE_COORD, 
                self._standCoord, 
                self._target:isMaster(), 
                self._target:getSpriteID(), 
                self._target:getDirection())

            local enterCenterCoordCommand = Command.RendererCommand:create(true)
            enterCenterCoordCommand:initEnterCenterCoordCommand(self._target:getId(), self._standCoord, false)
            self._battleMachine:pushCommand(enterCenterCoordCommand)
        end

        return true
    end
    return false
end

-- 胜利
function BattleStateActionForHero:win()
    if(DEBUG) then
        print(string.format("BattleStateActionForHero win: role %d win.", self._target:getSpriteID()))
    end

    self._endBattle = true

    self._isWin = true

    if(self._skillAction) then
        self._skillAction:interrupt()
    end 
    if self._target:getType() == RoleType.Pet then
        self:complete()
    else
        if (self._moveFowardAfterWin) then
            local dstCoord = self._originCoord:copy()
            local direction = self._attackDirection
            if (direction == DirectionType.EAST) then
                dstCoord.x = dstCoord.x + 1
            elseif (direction == DirectionType.WEAST) then
                dstCoord.x = dstCoord.x - 1
            elseif (direction == DirectionType.NORTH) then
                dstCoord.y = dstCoord.y + 1
            elseif (direction == DirectionType.SOUTH) then
                dstCoord.y = dstCoord.y - 1
            else 
            end

            self._target:setDirection(direction)
            MachineManager:getInstance():pushDirectionRendererCommand(self._target, direction)

            -- 这里判断要进入的点是否可以到达，如果不能到达就退回到当前点，
            if(self._battleMachine and self._battleMachine._model) then 
                local mapData = self._battleMachine._model:getMapData()
                if(mapData) then 
                    local printFlag = false
                    local tileData = mapData:getTileDataAtCoord(dstCoord.x, dstCoord.y)
                    if(tileData == nil or tileData:canBeEndOfPath() == false) then
                        -- print("attackTarget dstCoord coord=", dstCoord.x, dstCoord.y)
                        -- add by zp 这里如果状态已经出错，这里还可以根据位置信息来做相关的逻辑处理
                        local handle = flase
                        if(self._attackTarget) then
                            -- 这里可以容错占一格的怪物以及和多格怪物 坐标相差一格的情况
                            local coord = self._attackTarget:getCoord()
                            if(coord) then 
                                if (math.abs(coord.x - self._originCoord.x) + math.abs(coord.y - self._originCoord.y) == 1) then 
                                    handle = true
                                    dstCoord.x = coord.x
                                    dstCoord.y = coord.y
                                end
                            end 
                        end
                        if(handle == false) then 
                            dstCoord.x = self._originCoord.x
                            dstCoord.y = self._originCoord.y
                        end 
                        printFlag = true
                    end

                    if(self._attackTarget) then 
                        local coord = self._attackTarget:getCoord()
                        if(coord) then 
                            if (math.abs(coord.x - self._originCoord.x) ~= 1 and math.abs(coord.y - self._originCoord.y) ~= 1) then 
                                printFlag = true
                            end
                            -- if(printFlag) then 
                            --     print("attackTarget coordx,coordy=", coord.x, coord.y)
                            -- end
                        end
                    end

                    -- if(printFlag) then 
                    --     print("target coordx,coordy=", self._originCoord.x, self._originCoord.y, dstCoord.x, dstCoord.y)
                    --     printError("Master coord is error.")
                    -- end 
                end
            end
            self:move(dstCoord, function()
                self:complete()
            end)
        else
            local dstCoord = self._originCoord:copy()
            self:move(dstCoord, function()
                self:complete()
            end)
        end
    end
end

-- 返回原点
function BattleStateActionForHero:lose()
    if(DEBUG) then
        print(string.format("BattleStateActionForHero lose: role %d lose", self._target:getSpriteID()))
    end
    self._endBattle = true
    self._isWin = false
    self._target:setIsEscape(false)
    if self._target:getType() == RoleType.Pet then
        self:complete()
    else
        local dstCoord = self._originCoord
        self:move(dstCoord, function()
            self:complete()
        end)
    end
end

-- 触发了免死技能推理战斗
function BattleStateActionForHero:userSkillLose()
    self._endBattle = true
    self._isWin = false
    self._target:setIsEscape(false)

    local dstCoord = self._originCoord
    -- 立即回到开始战斗的点
    MachineManager:getInstance():pushPositionRendererCommand(self._target, dstCoord, self._target:isMaster())
    self._target:setBattleCoord(dstCoord)
    
    -- 完成动画
    self:complete()
end

-- 结束战斗
function BattleStateActionForHero:stopBattle()
    -- BattleStateAction.stopBattle(self)
    self._endBattle = true
    if(self._target) then
        self._target:setIsEscape(false)
    end

    if(self._skillAction) then
        self._skillAction:interrupt()
    end 

    local dstCoord = nil
    if self._target:getType() == RoleType.Pet then
        self:complete()
    else
        if (self._battleState ~= BattleState.RUN_AWAY) then
            -- dstCoord = self._attackTarget:getCoord()
            dstCoord = self._originCoord:copy()
            self._isWin = true

            local direction = self._target:getDirection()
            if (direction == DirectionType.EAST) then
                dstCoord.x = dstCoord.x + 1
            elseif (direction == DirectionType.WEAST) then
                dstCoord.x = dstCoord.x - 1
            elseif (direction == DirectionType.NORTH) then
                dstCoord.y = dstCoord.y + 1
            elseif (direction == DirectionType.SOUTH) then
                dstCoord.y = dstCoord.y - 1
            else 
                assert(false)
            end
        else
            dstCoord = self._originCoord
            self._isWin = false
        end
        self:move(dstCoord)
    end
end

-- 更新
function BattleStateActionForHero:onUpdate(dt)
    if (self._toMove) then
        self:onMoveToCoord(dt)
    end

    local complete = BattleStateAction.onUpdate(self, dt)
    return complete
end

-- public:
-- 创建对象
local BattleStateActionForHeroPool = nil
function BattleStateActionForHero:create(reused, ...)
    if(DEBUG) then
        print("BattleStateActionForHero create: create battle state action for hero.")
    end

    if (reused) then
        if (not BattleStateActionForHeroPool) then
            BattleStateActionForHeroPool = Pool.Pool:create(BattleStateActionForHero)
        end
        return BattleStateActionForHeroPool:applyObject()
    else
        return BattleStateActionForHero.new(...)
    end
end

-- 构造函数
function BattleStateActionForHero:ctor()
    BattleStateActionForHero.super.ctor(self)

    -- 战斗中站立的位置
    self._originCoord = Geome.Coord:create()
    self._dstCoord = Geome.Coord:create()
    self._standCoord = Geome.Coord:create()
    self._moveCoord = Geome.Coord:create()
    -- 移动开始时间
    self._moveTime = 0
    -- 移动到站位时间
    self._moveDuration = 0
    -- 移动速度
    self._speedX = 0
    self._speedY = 0
    self._speedZ = 0
    -- 移动完成
    self._moveComplete = true
    self._toMove = false

    -- 战斗胜利
    self._isWin = false
    -- 战斗胜利是否移动到目标位置
    self._moveFowardAfterWin = true
end

-- 析构函数
function BattleStateActionForHero:dtor()
    if(self._target) then
        self._target:setIsEscape(false)
    end
    BattleStateActionForHero.super.dtor(self)

    self._originCoord = nil
    self._dstCoord = nil
    self._standCoord = nil
    self._moveCoord = nil
end

-- 初始化
function BattleStateActionForHero:init(target, attackTarget)
    BattleStateActionForHero.super.init(self, target, BattleType.HERO)

    -- 重置状态
    if(self._target) then
        self._target:setIsEscape(false)
        if(self._target:isMaster()) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_BAG_BUTTON)
        end
    end

    -- 这里处理坐标非整数的异常情况
    local coord = target:getCoord()
    coord.x = Avalon.MathUtil:getInt(coord.x)
    coord.y = Avalon.MathUtil:getInt(coord.y)

    self._originCoord:setCoord(coord)
    self._attackTarget = attackTarget

    self._moveFowardAfterWin = true
    if attackTarget then
        self._dstCoord:setCoord(attackTarget:getCoord())
        
        local roleData = attackTarget:getData()
        if (roleData:getType() == RoleType.Monster) then
            if (roleData:isSmallBoss()) then
                self._moveFowardAfterWin = false
            end
        end

        if(DEBUG) then
            print("BattleStateActionForHero init ", roleData:getCategory(), roleData:getType(), roleData:isSmallBoss())
        end
    end

end

-- 清理
function BattleStateActionForHero:clear()
    -- 重置状态
    if(self._target) then
        self._target:setIsEscape(false)
        if(self._target:isMaster()) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_OPEN_BAG_BUTTON)
        end
    end
    BattleStateActionForHero.super.clear(self)
    
    self._originCoord:setValue(0, 0, 0)
    self._dstCoord:setValue(0,0,0)
    self._standCoord:setValue(0, 0, 0)
    self._moveCoord:setValue(0, 0, 0)
    self._moveTime = 0
    self._moveDuration = 0
    self._speedX = 0
    self._speedY = 0
    self._speedZ = 0
    self._moveComplete = true
    self._toMove = false
    self._isWin = false
    self._moveCallback = nil
    self._moveFowardAfterWin = true
end

function BattleStateActionForHero:serverNotifyStartSkill(skillID, serverTimestamp)
    --  这里根据技能ID以及服务器的时间来计算需要表现同步的处理逻辑
    -- 如果当前都为普攻技能，需要处理同步
    -- 如果为不同类型的技能，本次不做同步处理
    local waitingTime = 0
    local nowServerTimeStamp = GameManager:getNowServerTimestamp()
    -- print("BattleStateActionForHero:serverNotifyStartSkill", skillID, serverTimestamp, nowServerTimeStamp)
    local battleState = self._battleState
    if (battleState == BattleState.ATTACK) then
        local skillData = SkillDataManager:getSkillDataForSkillID(skillID, self._target:getType() == RoleType.Pet)
        if(skillData and self._attackAction) then 
            if(skillData:getSkillType() == SkillType.NORMAL_ATTACK) then
                -- local chaTime = self._attackAction:getSkillIntervalTime() * TIME_UNIT + (nowServerTimeStamp - serverTimestamp)
                local chaTime = self._attackAction:getSkillIntervalTime() * TIME_UNIT
                chaTime = math.fmod(chaTime, skillData:getCastDuration() * TIME_UNIT)

                -- chaTime = chaTime - 300
                if(chaTime > SKILL_SYNC_MIN_TIME or chaTime < -SKILL_SYNC_MIN_TIME) then 
                    waitingTime = chaTime /TIME_UNIT
                else 
                    waitingTime = 0
                end
                -- print("BattleStateActionForHero:serverNotifyStartSkill  2=", chaTime, waitingTime)
                if(waitingTime < 0) then 
                    waitingTime = skillData:getCastDuration() + waitingTime
                end
                -- print("BattleStateActionForHero:serverNotifyStartSkill  3=", waitingTime)
                if(self._attackAction) then 
                    self._attackAction:setSkillSyncTime(waitingTime)
                end
            end
        end
    end
end

function BattleStateActionForHero:onEnd()
    BattleStateActionForHero.super.onEnd(self)
    if(self._target) then
        local coord = Geome.Coord:create()
        coord:setValue(0,0,0)
        self._target:setBattleCoord(coord)

        self._target:setIsEscape(false)
    end

    -- 触发陷阱效果
    if(self._target and self._target:isMaster() and self._target:getIsDead() == false) then
        self._battleMachine:handleMapTrigger(TRIGGER_TYPE.TRIGGER_ALL, self._target:getCoord(), self._target:isMaster(), false, true, GameTriggerTimeType.TRIGGER_TIME_NORMAL)
        self._battleMachine:moveOneStepTrigger()
    end
end
