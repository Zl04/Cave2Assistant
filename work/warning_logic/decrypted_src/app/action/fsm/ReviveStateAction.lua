--[[
    状态机行为：复活状态
]]--

require "app.action.BattleAction"
require "app.action.Action"
require "app.pool.Pool"

local MachineManager = require("app.game.MachineManager")
local MapDataManager = require "app.mapkit.model.MapDataManager"
local GameMapManager = require("app.game.GameMapManager")
local SceneManager = require("app.game.SceneManager")

Action = Action or {}

local ReviveStateAction = class("ReviveStateAction", Action.BattleAction)
Action.ReviveStateAction = ReviveStateAction

-- private:
-- 对象池
local ReviveStateActionPool = nil

local DEBUG = false

-- 在战斗中移动位置
function ReviveStateAction:moveHero(srcCoord, dstCoord)
    if (srcCoord and dstCoord) then
        dstCoord.x = Avalon.MathUtil:getInt(dstCoord.x)
        dstCoord.y = Avalon.MathUtil:getInt(dstCoord.y)

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
        
        self._moveDuration = Geome.computeMoveDuration(self._moveCoord, self._standCoord, speed)
        -- add by zp 这里是修改进出战斗表现卡顿问题。
        if(self._moveDuration < 0.33) then
            speed = speed * (self._moveDuration/0.33)
            self._moveDuration = Geome.computeMoveDuration(self._moveCoord, self._standCoord, speed)
        end
        self._speedX, self._speedY, self._speedZ = Geome.computeSpeedComp(self._moveCoord, self._standCoord, speed)
    else
        self._moveComplete = true
        self._toMove = false
    end
end

-- public:
-- 创建对象
function ReviveStateAction:create(reused, ...)
    if (reused) then
        if (not ReviveStateActionPool) then
            ReviveStateActionPool = Pool.Pool:create(ReviveStateAction)
        end
        return ReviveStateActionPool:applyObject()
    else
        return ReviveStateAction.new(...)
    end
end


-- 构造函数
function ReviveStateAction:ctor()
    ReviveStateAction.super.ctor(self, ActionType.FSM_REVIVE)
    
    self._coord = Geome.Coord:create(0, 0, 0)
    self._toMove = false
    self._moveComplete = true

    -- 移动开始时间
    self._moveTime = 0
    -- 移动到站位时间
    self._moveDuration = 0
    -- 移动速度
    self._speedX = 0
    self._speedY = 0
    self._speedZ = 0

    self._standCoord = Geome.Coord:create()
    self._moveCoord = Geome.Coord:create()
end

-- 模版函数：销毁
function ReviveStateAction:dtor()
    ReviveStateAction.super.dtor(self)
    self._toMove = false
    self._moveCoord = nil
    self._standCoord = nil
    self._moveTime = 0
end

-- 初始化
function ReviveStateAction:init(target)
    ReviveStateAction.super.init(self, target)

    self._target = target
end

-- 清理
function ReviveStateAction:clear()
    ReviveStateAction.super.clear(self)
    self._toMove = false
    self._moveTime = 0
    self._standCoord:setValue(0, 0, 0)
    self._moveCoord:setValue(0, 0, 0)
end

-- 移动到逻辑更新
function ReviveStateAction:onMoveToCoord(dt)
    if (not self._moveComplete) then
        self._moveTime = self._moveTime + dt
        if (self._moveTime >= self._moveDuration) then
            MachineManager:getInstance():pushPositionRendererCommand(self._target, self._standCoord, self._target:isMaster())

            self._moveComplete = true
            self._toMove = false

            if (self._moveCallback) then
                self._moveCallback()
            end

            return true
        else
            local disX, disY, disZ = self._speedX * dt, self._speedY * dt, self._speedZ * dt
            local coord = self._moveCoord
            coord:addValue(disX, disY, disZ)
            
            MachineManager:getInstance():pushPositionRendererCommand(self._target, coord, self._target:isMaster())

            return false
        end
    else
        return true
    end
end

-- 战斗中移动的逻辑
function ReviveStateAction:onMove(dt)
    if (self:onMoveToCoord(dt)) then
        self._interrupt = true
        if(self._target) then
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

function ReviveStateAction:update(dt)
    ReviveStateAction.super.update(self, dt)
end

function ReviveStateAction:moveEnd(callback)
    if(SceneManager:getInstance():isInDungeon() 
        or SceneManager:getInstance():isInDream()
        or SceneManager:getInstance():isGhostAbyss()
        or SceneManager:getInstance():isGuildBoss()) then
        -- 发送失败回城
        if( RoleBehaviorManager:autoBackTownCheck("[ReviveStateAction in Dungeon to back town]") ) then 
            GameManager:giveUpBackTown()
        end 
    else
        -- 从战斗过程中的逻辑移动到最后
        if(self._target) then
            self._moveCallback = function()
                self._toMove = false
                self:complete()
                if(callback) then
                    callback()
                end
            end

            local updateAnimationCommand = Command.RendererCommand:create(true)
            updateAnimationCommand:initUpdateAnimationCommand(self._target:getId(), CommandAnimationType.IDLE)
            self._battleMachine:pushCommand(updateAnimationCommand)

            local startCoord = self._target:getBattleCoord()
            if(startCoord ) then
                if(DEBUG) then
                    print("ReviveStateAction:moveEnd ", startCoord.x, startCoord.y, self._target:getCoord())
                end
                -- dump(self._target:getCoord())
                if( startCoord.x == 0 and startCoord.y == 0) then
                    if(DEBUG) then
                        print("ReviveStateAction:moveEnd 1", startCoord.x, startCoord.y, self._target:getCoord())
                    end
                    self:moveHero(self._target:getCoord(), self._target:getCoord())
                else
                    if(DEBUG) then
                        print("ReviveStateAction:moveEnd 2", startCoord.x, startCoord.y, self._target:getCoord())
                    end
                    self:moveHero(startCoord, self._target:getCoord())
                end
            else
                self._moveCallback()
            end
        else 
            if(callback) then
                callback()
            end
        end
    end
end

-- 模版函数：action开始
function ReviveStateAction:onStart()
    -- 切换状态
    if (not self._target:switchState(FSMState.REVIVE)) then

        return false
    end
    self:forceUpdate()

    local renderCommand = Command.RendererCommand:create(true)
    
    local coord = Geome.Coord:create()
    coord:setCoord(self._target:getCoord())
    renderCommand:initRoleRevive(self._target:getId(), coord)
    self:pushRendererCommand(renderCommand)

    return true
end

-- 模版函数：action结束
function ReviveStateAction:onEnd()
    if self._target:getType() == RoleType.Pet then
        local master = self._target:getMaster()
        local TRACKS_INDEX = GameTracksIndex
        local battleStateAction = nil
        if master then
            battleStateAction = self._battleMachine._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
        end
        if (battleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE 
            and battleStateAction._attackTarget ~= nil ) then
            local data = {}
            data.spriteID = self._target:getSpriteID()
            data.targetSpriteID = battleStateAction._attackTarget:getSpriteID()
            -- local command = Command.ControlCommand:create(true)
            -- 之前CONTROL_SCREEN_HERO_START_BATTLE命令是在下一帧执行，现在需要把下面的操作提前。
            -- CONTROL_SCREEN_HERO_START_BATTLE执行后self._target可能会被释放
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE_END, self._target:getData())
            self._target:getData():setIsDead(false)
            GameManager:notifyRoleFSMChange(self._target:getData())

            local battleCMD = Command.BattleCommand:create(true)
            battleCMD:initForTypeAndData(CommandType.CONTROL_SCREEN_HERO_START_BATTLE, data)
            MachineManager:getInstance():executeCommand(battleCMD)
        else
            local data = {}
            data.spriteID = self._target:getSpriteID()
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_REVIVE_COMPLETE, data)
            SceneManager:getInstance():pushCommand(command)
            UI.WaitingLayer:hideWaiting()
            GameManager:notifyRoleFSMChange(self._target:getData())
        end
        -- GameManager:notifyRoleFSMChange(self._target:getData())
    else
        self._target:getData():setIsDead(false)
    end
end

function ReviveStateAction:onFail()
    print("ReviveStateAction:onFail")
end

function ReviveStateAction:onStop()
    print("ReviveStateAction:onStop")
end

-- 获取状态
function ReviveStateAction:getFSMState()
    return FSMState.REVIVE
end

-- 更新
function ReviveStateAction:onUpdate(dt)
    if (self._toMove) then
        self:onMove(dt)
    end
    if self._target and self:cehckTargetType()then
        return true
    end
end

-- 检查目标类型
function ReviveStateAction:cehckTargetType()
    local b = false
    if self._target:getType() == RoleType.Pet or
    self._target:getType() == RoleType.Monster then
        b = true
    end

    return b
end


