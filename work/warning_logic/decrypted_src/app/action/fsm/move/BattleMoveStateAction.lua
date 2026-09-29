--[[
    状态机行为：战斗移动状态
    这里最终统一按照方向来计算
]]--

require "utils.MathUtil"
require "app.action.Action"
require "app.pool.Pool"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local MapDefine = require "app.mapkit.MapDefine"
local MachineManager = require("app.game.MachineManager")

Action = Action or {}

local BattleMoveStateAction = class("BattleMoveStateAction", Action.Base)
Action.BattleMoveStateAction = BattleMoveStateAction

Action.BattleMoveType = {
    CLICK_MOVE = 2,             -- 点击移动
    DIRECTION_MOVE = 3,         -- 方向移动
    END_COORD_MOVE = 4,         -- 按照最终点移动
}
local BattleMoveType = Action.BattleMoveType

-- private:
local DEBUG = true
local DEBUG_POSITION_Z = false
local dtTotal = 0
local localTotal = 0

-- 移动过程中z坐标的渐变
local Z_GRADIENT_MOVE_DISTANCE = 0.125
local HALF_MAP_TILE_SIZE = 0.5

-- 计算移动过程中的z坐标
local function computeCoordZWhenMoving(self, startCoordX, startCoordY, currentCoordX, currentCoordY, startCoordZ, nextCoordZ)
    local needToUpdatePositionZ = false
    local percent = 1.0
    local coordZ = 0.0

    -- 如果存在下一个格子的z坐标数据，用于计算移动过程中的z坐标插值
    local offsetX, offsetY = math.abs(currentCoordX - startCoordX), math.abs(currentCoordY - startCoordY)
    local offsetZ = nextCoordZ - startCoordZ
    local offset = offsetX + offsetY
    if (offsetZ >= 0) then
        if (offset >= (HALF_MAP_TILE_SIZE - Z_GRADIENT_MOVE_DISTANCE)) then
            if (offset > HALF_MAP_TILE_SIZE) then 
                offset = HALF_MAP_TILE_SIZE
            end
            offset = offset - (HALF_MAP_TILE_SIZE - Z_GRADIENT_MOVE_DISTANCE)

            needToUpdatePositionZ = true
        end
    else
        if (offset >= HALF_MAP_TILE_SIZE) then
            offset = offset - HALF_MAP_TILE_SIZE
            if (offset > Z_GRADIENT_MOVE_DISTANCE) then
                offset = Z_GRADIENT_MOVE_DISTANCE
            end

            needToUpdatePositionZ = true
        end
    end

    if (DEBUG_POSITION_Z) then
        print(string.format("BattleMoveStateAction computeCoordZWhenMoving: start   coord: (%f,%f)", startCoordX, startCoordY))
        print(string.format("BattleMoveStateAction computeCoordZWhenMoving: current coord: (%f,%f)", currentCoordX, currentCoordY))
        print(string.format("BattleMoveStateAction computeCoordZWhenMoving: start coord z: %f, next coord z: %f", startCoordZ, nextCoordZ))
        print(string.format("BattleMoveStateAction computeCoordZWhenMoving: move offset: %f, current move offset: %f ", Z_GRADIENT_MOVE_DISTANCE, offset))
    end

    if (needToUpdatePositionZ) then
        if (Z_GRADIENT_MOVE_DISTANCE ~= 0.0) then
            percent = offset / Z_GRADIENT_MOVE_DISTANCE
        else
            percent = 1.0
        end
        coordZ = startCoordZ + offsetZ * math.abs(percent)

        if (DEBUG_POSITION_Z) then
            print(string.format("BattleMoveStateAction computeCoordZWhenMoving: percent:%f coordZ:%f", percent, coordZ))
        end

        return coordZ
    else
        coordZ = startCoordZ

        return coordZ
    end
end

-- 构造函数
function BattleMoveStateAction:ctor()
    BattleMoveStateAction.super.ctor(self, ActionType.FSM_BATTLE_MOVE)

    self._target = nil
    self._direction = nil
    self._oldDirection = DirectionType.NONE 
    self._battleMachine = nil

    self._battleMoveType = Action.BattleMoveType.DIRECTION_MOVE

    self._currentCoord = nil
    self._endTime = 0
    self._speedX = 0
    self._speedY = 0

    self._data = nil

    self._stop = false
    self._reset = false

    self._moveStartTrigger = true

    self._accumulationPosition = {x=0,y=0}

    self._accelerateTime = 0  -- 加速时间
    -- print("BattleMoveStateAction:ctor _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)

    self._endIdle = true

    self._coordForZOrder = {x = 0, y = 0}
end

-- 模版函数：销毁
function BattleMoveStateAction:dtor()
    BattleMoveStateAction.super.dtor(self)

    self._data = nil
    self._direction = nil
    self._oldDirection = DirectionType.NONE 
    self._currentCoord = nil
    self._battleMachine = nil
    self._battleModel = nil

    self._stop = false
    self._reset = false

    self._accumulationPosition = {x=0,y=0}
    self._accelerateTime = 0
    self._endIdle = true

    self._moveStartTrigger = true
end

-- 初始化
function BattleMoveStateAction:init(target, battleMachine, battleModel)
    BattleMoveStateAction.super.init(self, target, 0, 0)

    self._data = target:getData()
    self._oldDirection = DirectionType.NONE 
    self._battleMachine = battleMachine
    self._battleModel = battleModel

    self._stop = false
    self._reset = false

    self._accelerateTime = 0
end

-- 初始化方向移动
function BattleMoveStateAction:setDirectionMove(direction,actionStartTime)
    assert(false, "[ERROR] BattleMoveStateAction setDirectionMove: this method should be overrided by sub class.")
end

-- 初始化点击移动方向
function BattleMoveStateAction:setClickMove(moveCoordList,actionStartTime)
    assert(false, "[ERROR] BattleMoveStateAction setClickMove: this method should be overrided by sub class.")
end

-- 设置目标点的移动
function BattleMoveStateAction:setEndCoordMove(endCoord,actionStartTime)
    assert(false, "[ERROR] BattleMoveStateAction setEndCoordMove: this method should be overrided by sub class.")
end

-- 清理
function BattleMoveStateAction:clear()
    BattleMoveStateAction.super.clear(self)

    self._target = nil
    self._data = nil
    self._direction = nil
    self._oldDirection = DirectionType.NONE 
    self._battleMachine = nil
    self._battleModel = nil

    self._currentCoord = nil
    self._endTime = 0
    self._speedX = 0
    self._speedY = 0

    self._stop = false

    self._accumulationPosition = {x=0,y=0}

    self._accelerateTime = 0
    self._endIdle = true
    -- print("BattleMoveStateAction:clear _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)
end

-- 模版函数：action开始
function BattleMoveStateAction:onStart()
    assert(false, "[ERROR] BattleMoveStateAction onStart: this method should be overrided by sub class.")

    return true
end

-- 模版函数：action更新
function BattleMoveStateAction:onUpdate(dt)
    assert(false, "[ERROR] BattleMoveStateAction onUpdate: this method should be overrided by sub class.")
end

-- 模板函数：停止action
function BattleMoveStateAction:stop()
    assert(false, "[ERROR] BattleMoveStateAction stop: this method should be overrided by sub class.")
end

-- 模版函数：action结束
function BattleMoveStateAction:onEnd()
    assert(false, "[ERROR] BattleMoveStateAction onEnd: this method should be overrided by sub class.")
end

function BattleMoveStateAction:onFail()
    assert(false, "[ERROR] BattleMoveStateAction onFail: this method should be overrided by sub class.")
end

function BattleMoveStateAction:judageWasMaster()
    assert(false, "[ERROR] BattleMoveStateAction judageWasMaster: this method should be overrided by sub class.")
end

-- 获取状态
function BattleMoveStateAction:getFSMState()
    return FSMState.MOVE
end

-- 发送更新坐标的渲染命令
function BattleMoveStateAction:pushPositionRendererCommand(target, coord, moveMap, startCoord, nextCoord)
    local coordZ = 0.0
    -- 计算移动过程中的z坐标变化
    if (startCoord and nextCoord) then
        local startCoordZ = self._battleModel:getMapTileCoordZ(startCoord.x, startCoord.y)
        local nextCoordZ = self._battleModel:getMapTileCoordZ(nextCoord.x, nextCoord.y)

        coordZ = computeCoordZWhenMoving(self, startCoord.x, startCoord.y, coord.x, coord.y, startCoordZ, nextCoordZ)
        coord.z = coordZ

        if (DEBUG_POSITION_Z) then
            print(string.format("BattleMoveStateAction pushPositionRendererCommand: coord z is %f when moving.", coordZ))
        end
    -- 非移动过程，获取地块的z坐标
    else
        coordZ = self._battleModel:getMapTileCoordZ(coord.x, coord.y)
        coord.z = coordZ

        if (DEBUG_POSITION_Z) then
            print(string.format("BattleMoveStateAction pushPositionRendererCommand: coord z is %f when standing.", coordZ))
        end
    end
    target:setCoordZ(coordZ)

    MachineManager:getInstance():pushPositionRendererCommand(target, coord, moveMap)
    -- 解决移动过程中不正常的遮挡问题（临时的解决方案）
    -- self._coordForZOrder.x = math.floor(coord.x)
    -- self._coordForZOrder.y = math.floor(coord.y)
    -- MachineManager:getInstance():pushZOrderRendererCommand(target, self._coordForZOrder)
end

