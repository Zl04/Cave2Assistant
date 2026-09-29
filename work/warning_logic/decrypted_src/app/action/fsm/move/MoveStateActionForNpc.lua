--[[
    状态机行为：NPC 移动
    这里最终统一按照方向来计算
]]--

require "utils.MathUtil"
require "app.action.Action"
require "app.pool.Pool"
require "app.object.geometric.GeometricModel"
require "app.action.fsm.move.BattleMoveStateAction"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local MapDefine = require "app.mapkit.MapDefine"
local MachineManager = require("app.game.MachineManager")
local SceneManager = require("app.game.SceneManager")
local computeNormal = Geome.computeNormal
local computeDirection = Geome.computeDirection
local reverseDirection = Geome.reverseDirection

Action = Action or {}


local TRIGGER_TYPE = GameTriggerType

local DEBUG = false
local dtTotal = 0


local MoveStateActionForNpc = class("MoveStateActionForNpc", Action.BattleMoveStateAction)
Action.MoveStateActionForNpc = MoveStateActionForNpc

local BattleMoveType = Action.BattleMoveType

-- private:
-- 对象池
local MoveStateActionForNpcPool = nil

-- public:
-- 创建对象
function MoveStateActionForNpc:create(reused, ...)
    if (reused) then
        if (not MoveStateActionForNpcPool) then
            MoveStateActionForNpcPool = Pool.Pool:create(MoveStateActionForNpc)
        end
        return MoveStateActionForNpcPool:applyObject()
    else
        return MoveStateActionForNpc.new(...)
    end
end

-- 构造函数
function MoveStateActionForNpc:ctor()
    MoveStateActionForNpc.super.ctor(self, ActionType.FSM_BATTLE_MOVE)

    self._normalMoveSpeed = ConfigManager:getMoveSpeed()

    self._target = nil
    self._direction = nil
    self._oldDirection = DirectionType.NONE 
    self._battleMachine = nil

    self._battleMoveType = BattleMoveType.DIRECTION_MOVE

    self._currentCoord = nil
    self._endTime = 0
    self._speedX = 0
    self._speedY = 0

    self._data = nil
    self._reset = false

    self._moveWaitingStep = self:getNewWaitingStep()
    self._waiting = false
    self._waitingTime = 0

    self._accumulationPosition = {x=0,y=0}

    self._accelerateTime = 0  -- 加速时间
    -- print("MoveStateActionForNpc:ctor _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)

    self._endIdle = true

    self._moveNum = 0
end

-- 模版函数：销毁
function MoveStateActionForNpc:dtor()
    MoveStateActionForNpc.super.dtor(self)
    -- print("MoveStateActionForNpc  onDestroy")
    self._normalMoveSpeed = 0
    -- print("MoveStateActionForNpc:dtor", self._callBack)
    -- print(debug.traceback())
    if(self._callBack) then
        self._callBack()
    end
    self._callBack = nil
    self._data = nil
    self._direction = nil
    self._oldDirection = DirectionType.NONE 
    self._currentCoord = nil

    self._reset = false

    self._accumulationPosition = {x=0,y=0}
    self._accelerateTime = 0
    self._endIdle = true
    self._startCoord = nil
    self._nextCoord = nil
    -- print("MoveStateActionForNpc:onDestroy _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)
end

-- 初始化
function MoveStateActionForNpc:init(target, battleMachine, battleModel)
    -- print("MoveStateActionForNpc:init   ------")
    MoveStateActionForNpc.super.init(self, target, battleMachine, battleModel)

    self._data = target:getData()
    self._oldDirection = DirectionType.NONE
    self._reset = false

    self._accelerateTime = 0
    -- print("MoveStateActionForNpc:init _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)
end

-- 初始化点击移动方向
function MoveStateActionForNpc:setClickMove(moveCoordList,actionStartTime, moveStartTrigger)
    self._battleMoveType = BattleMoveType.CLICK_MOVE

    self._moveCoordList = moveCoordList
    self._moveIndex = 1
    self._reset = true

    self._actionStartTime = actionStartTime
    self._accelerateTime = 0

    if(moveStartTrigger == nil) then
        self._moveStartTrigger = true
    else
        self._moveStartTrigger = moveStartTrigger
    end

    if DEBUG then
        print("MoveStateActionForNpc:setClickMove  now, x,y",k,self._target:getCoord().x,self._target:getCoord().y)
        for k,v in pairs(self._moveCoordList) do
            print("MoveStateActionForNpc:setClickMove  k, x,y",k,v.x,v.y)
        end
    end
end

-- 设置目标点的移动
function MoveStateActionForNpc:setEndCoordMove(endCoord,actionStartTime)
    if self._battleMoveType == BattleMoveType.END_COORD_MOVE then
        if self._endCoord.x == endCoord.x and self._endCoord.y == endCoord.y then
            if DEBUG then
                print("MoveStateActionForNpc:setEndCoordMove  endCoord is equal x,y",endCoord.x,endCoord.y)
            end
            return 
        end 
    end
    self._battleMoveType = BattleMoveType.END_COORD_MOVE
    self._reset = true

    self._endCoord = endCoord
    self._actionStartTime = actionStartTime
    self._accelerateTime = 0

    if DEBUG then
        print("MoveStateActionForNpc:setEndCoordMove  endCoord x,y",endCoord.x,endCoord.y)
    end
end

-- 清理
function MoveStateActionForNpc:clear()
    MoveStateActionForNpc.super.clear(self)
    if(self._callBack) then
        self._callBack()
    end
    self._callBack = nil
    self._target = nil
    self._data = nil
    self._direction = nil
    self._oldDirection = DirectionType.NONE 
    self._battleMachine = nil

    self._currentCoord = nil
    self._endTime = 0
    self._speedX = 0
    self._speedY = 0

    self._accumulationPosition = {x=0,y=0}

    self._accelerateTime = 0
    self._endIdle = true
    self._startCoord = nil
    self._nextCoord = nil
    -- print("MoveStateActionForNpc:clear _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)
end

-- 模版函数：action开始
function MoveStateActionForNpc:onStart()
    local coord = self._target:getCoord()
    local speed = self:getSpeed()
    self._currentCoord = coord

    -- 处理结束点寻路
    if not self:handleFindPath() then
        return false
    end
    self._reset =false

    -- 这里强制把初始点设定为地图中心点
    local localCoord = {x = 0,y=0}
    localCoord.x = Avalon.MathUtil:getInt(self._currentCoord.x)
    localCoord.y = Avalon.MathUtil:getInt(self._currentCoord.y)
    self._target:setCoord(localCoord.x, localCoord.y)

    self._startCoord = Geome.Coord:create()
    self._startCoord:setCoord(self._target:getCoord())

    self._nextCoord = Geome.Coord:create()
    self._nextCoord:setCoord(self._startCoord)

    -- MachineManager:getInstance():pushPositionRendererCommand(self._target, localCoord, self._target:isMaster())
    self:pushPositionRendererCommand(self._target, localCoord, false)

    if DEBUG then
        print("MoveStateActionForNpc:onStart  x,y,localtime=%d",self._currentCoord.x,self._currentCoord.y,AvalonUtil.getCurrentTime())
    end 

    if self:calculationDirection() == false then

        return false
    end

    self:forceUpdate()

    if self:culcuationStatus() == false then
        return false
    end 

    self._speedX = speed * self.normal.x
    self._speedY = speed * self.normal.y

    if (self._direction ~= DirectionType.NONE) then
        local directionCommand = Command.RendererCommand:create(true)
        directionCommand:initUpdateDirectionCommand(self._target:getId(), self._direction)
        self._battleMachine:pushCommand(directionCommand)
    end

    local animationCommand = Command.RendererCommand:create(true)
    animationCommand:initUpdateAnimationCommand(self._target:getId(), CommandAnimationType.MOVE)
    self._battleMachine:pushCommand(animationCommand)

    dtTotal = 0

    -- 切换移动
    if(self._target:getState() ~= FSMState.MOVE) then
        if (not self._target:switchState(FSMState.MOVE)) then

            return false
        end
    end
    GameManager:notifyRoleFSMChange(self._target:getData())
    -- 处理方向改变
    self:handleChangeDirection(true,true)

    -- 刷新层级
    local battleCMD = Command.GenerationCommand:create(true)
    battleCMD:initForRoleZorder(self._target:getSpriteID(),false,self._target:getSpriteID())
    self._battleMachine:executeCommand(battleCMD)

    -- if(self._target and self._target:isMaster()) then
    --     if(self._moveNum > 1) then
    --         self._moveNum = 0
    --     end
    --     if self._moveNum == 0 then
    --         Avalon.AudioManager:playSound("501")
    --     else
    --         Avalon.AudioManager:playSound("507")
    --     end
    -- end

    return true
end

-- 模版函数：action更新
function MoveStateActionForNpc:onUpdate(dt)
    if(self._waiting ) then 
        self._waitingTime = self._waitingTime - dt
        if(self._waitingTime <=0) then
            self._waiting = false

            local animationCommand = Command.RendererCommand:create(true)
            animationCommand:initUpdateAnimationCommand(self._target:getId(), CommandAnimationType.MOVE)
            self._battleMachine:pushCommand(animationCommand)
        end
        return
    end
    
    dtTotal = dtTotal + dt
    -- print("MoveStateActionForNpc:onUpdate dt,nowTime",dt,dtTotal, (nowTime-localTotal))

    -- 计算加速处理
    local accelerate = 0
    if self._battleMoveType == BattleMoveType.END_COORD_MOVE then
        accelerate = dt*2
    else
        if self._accelerateTime >0 then
            accelerate = dt*2
            if accelerate > self._accelerateTime then
                accelerate = self._accelerateTime
            end

            self._accelerateTime = self._accelerateTime - accelerate
        end
    end

    local totalDt = dt
    
    local target = self._target
    local speed = self:getSpeed()

    -- local animationCommand = Command.RendererCommand:create(true)
    -- animationCommand:initUpdateSpineTimeScale(self._target:getId(), speed/(self._normalMoveSpeed/PublicDefine.CONST_DEFINITION.MAP_COORD_COVERT_DISTANCE))
    -- self._battleMachine:pushCommand(animationCommand)
    
    repeat
        -- 速度变动,这里需要考虑性能
        self._speedX = speed * self.normal.x
        self._speedY = speed * self.normal.y

        -- 对于每帧时间做拆分计算，避免出现跳格BUG
        local oneDt = totalDt
        if totalDt > 0.1 then
            oneDt = 0.1
        end
        totalDt = totalDt - oneDt

        local localCoord = {x = 0,y=0}
        localCoord.x = self._currentCoord.x
        localCoord.y = self._currentCoord.y

        local addX = self._speedX * oneDt
        local addY = self._speedY * oneDt

        localCoord.x = self._currentCoord.x + addX;
        localCoord.y = self._currentCoord.y + addY;

        local preAccumulationX = self._accumulationPosition.x
        local preAccumulationY = self._accumulationPosition.y

        self._accumulationPosition.x = self._accumulationPosition.x + addX
        self._accumulationPosition.y = self._accumulationPosition.y + addY

        -- 判断是否跨过了一格
        local skipOneMap = false
        local backTime = 0
        -- 这里尽可能的不浪费时间
        if self._accumulationPosition.x >=1  then
            skipOneMap = true
            self._accumulationPosition.x = self._accumulationPosition.x - 1
            backTime = self._accumulationPosition.x / self._speedX
        elseif self._accumulationPosition.x <= -1 then
            skipOneMap = true
            self._accumulationPosition.x = self._accumulationPosition.x + 1
            backTime = self._accumulationPosition.x / self._speedX
        elseif self._accumulationPosition.y >= 1  then
            skipOneMap = true
            self._accumulationPosition.y = self._accumulationPosition.y - 1
            backTime = self._accumulationPosition.y / self._speedY
        elseif self._accumulationPosition.y <= -1 then
            skipOneMap = true
            self._accumulationPosition.y = self._accumulationPosition.y + 1
            backTime = self._accumulationPosition.y / self._speedY
        end

        if skipOneMap then
            localCoord.x = Avalon.MathUtil:getInt(localCoord.x)
            localCoord.y = Avalon.MathUtil:getInt(localCoord.y)

            totalDt = totalDt + backTime

            self._accumulationPosition.x = 0
            self._accumulationPosition.y = 0

            target:setCoord(localCoord.x, localCoord.y)
        end

        -- 判断是否已经开始走动
        if self._currentCoord.x == Avalon.MathUtil:getInt(localCoord.x) and
            self._currentCoord.y == Avalon.MathUtil:getInt(localCoord.y) then
            if DEBUG then
                print("MoveStateActionForNpc:onUpdate  triggerCenterCoordinate=",self._currentCoord.x,self._currentCoord.y,localCoord.x,localCoord.y,AvalonUtil:getCurrentTime())
            end
            local nextCoord = {x=self._currentCoord.x,y=self._currentCoord.y}
            if self._currentCoord.x == localCoord.x then
                if self._currentCoord.y < localCoord.y then
                    nextCoord.y = self._currentCoord.y + 1
                else
                    nextCoord.y = self._currentCoord.y - 1
                end
            else
                if self._currentCoord.x < localCoord.x then
                    nextCoord.x = self._currentCoord.x + 1
                else
                    nextCoord.x = self._currentCoord.x - 1
                end
            end
        end

        target:setDirection(self._direction);
        -- target:setCoord(localCoord.x, localCoord.y)
        self._currentCoord.x = localCoord.x 
        self._currentCoord.y = localCoord.y
        -- print("MoveStateActionForNpc  =", localCoord.x, localCoord.y, self._currentCoord.x, self._currentCoord.y)

        self:pushPositionRendererCommand(self._target, localCoord, false, self._startCoord, self._nextCoord)
        
        if skipOneMap then
            local lastCoordX = self._startCoord.x
            local lastCoordY = self._startCoord.y
            local newCoord = self._target:getCoord()
            local roleData = self._target:getData()
            
            -- 设置起点
            self._startCoord:setCoord(self._target:getCoord())

            local enterCenterCoordCommand = Command.RendererCommand:create(true)
            enterCenterCoordCommand:initNPCChangeCoordCommand(self._target:getId(), newCoord)
            self._battleMachine:pushCommand(enterCenterCoordCommand)

            -- 修改位置后添加到地图上面
            MapDataManager:getInstance():addRole(
                self._battleMachine._model._mapData,
                Avalon.MathUtil:getInt(newCoord.x),Avalon.MathUtil:getInt(newCoord.y),
                roleData
            )

            if DEBUG then
                print("MoveStateActionForNpc:onUpdate  x,y,localtime,speed,speedX,speedY,地图速度,dtTotal=",self._currentCoord.x,self._currentCoord.y,AvalonUtil.getCurrentTime(),self._data.speed,self._speedX,self._speedY,speed,dtTotal)
            end 

            if not self:handleFindPath() then
                return true
            end
            if self._reset then
                self._reset =false
                if self:culcuationStatus() == false then

                    return true
                end
                
            else
                if self._battleMoveType == BattleMoveType.CLICK_MOVE or self._battleMoveType == BattleMoveType.END_COORD_MOVE then
                    -- if self:clickJudgeMoveEnd(localCoord) then
                    --     return true
                    -- end

                    if self:judgeChangeDirection(localCoord) then
                        self._moveIndex = self._moveIndex + 1

                        if self:culcuationStatus() ==  false then

                            return true
                        end
                    end
                end
            end

            -- 处理转向指令
            self:handleChangeDirection(true,true)

            -- if(self._target) then
            --     self._moveNum = self._moveNum + 1
            --     if(self._moveNum > 1) then
            --         self._moveNum = 0
            --     end
            --     if self._moveNum == 0 then
            --         Avalon.AudioManager:playSound("501")
            --     else
            --         Avalon.AudioManager:playSound("507")
            --     end
            -- end

            -- 处理随机停止，同时计算停多久
            self._moveWaitingStep = self._moveWaitingStep - 1
            if(self._moveWaitingStep <= 0) then
                self._moveWaitingStep = self:getNewWaitingStep()
                self._waiting = true
                self._waitingTime = self:getNewWaitingTime()
                local animationCommand = Command.RendererCommand:create(true)
                animationCommand:initUpdateAnimationCommand(self._target:getId(), CommandAnimationType.IDLE)
                self._battleMachine:pushCommand(animationCommand)
            end 
        end
        
    until totalDt <= 0
    
    return false
end

function MoveStateActionForNpc:getNewWaitingStep()
    return math.random(4, 15)
end

function MoveStateActionForNpc:getNewWaitingTime()
    return math.random(4, 7)
end

-- 模板函数：停止action
function MoveStateActionForNpc:stop(callBack)
    -- 处理走完这一格
    self._stop = true
end

-- 模版函数：action结束
function MoveStateActionForNpc:onEnd()
    -- 判断是否为玩家 ，发送开始移动指令
    if DEBUG then
        print("MoveStateActionForNpc:onEnd")
        print(debug.traceback())
    end
end

function MoveStateActionForNpc:onFail()
    -- 处理执行失败的处理
    if DEBUG then
        print("MoveStateActionForNpc:onFail")
    end
end

function MoveStateActionForNpc:onStop()
    -- 处理执行失败的处理
    if DEBUG then
        print("MoveStateActionForNpc:onStop")
        print(debug.traceback())
    end
end

-- 计算英雄方向等状态
function MoveStateActionForNpc:culcuationStatus()
    if self:calculationDirection() == false then
        return false
    end
    if DEBUG then
        print("MoveStateActionForNpc:culcuationStatus _oldDirection,_direction,NONE,moveIndex",self._oldDirection,self._direction,DirectionType.NONE,self._moveIndex)
    end

    -- self:handleChangeDirection()

    -- 计算一个量化方向
    local nextCoord = self:getNextCoord()
    self.normal = computeNormal(self._currentCoord,nextCoord)
    
    self._nextCoord:setCoord(nextCoord)

    return true
end

function MoveStateActionForNpc:handleChangeDirection(renderChange,startMove)
    if self._oldDirection ~= self._direction then
        self._oldDirection = self._direction

        if startMove == nil then
            startMove = false
        end
        if renderChange == nil then
            renderChange = false
        end

        if renderChange then
            -- 处理转向操作
            MachineManager:getInstance():pushDirectionRendererCommand(self._target, self._direction)
        end
    end
end

function MoveStateActionForNpc:calculationDirection()
    local coord = {}
    coord.x = Avalon.MathUtil:getInt(self._currentCoord.x)
    coord.y = Avalon.MathUtil:getInt(self._currentCoord.y)

    if self._battleMoveType == BattleMoveType.CLICK_MOVE then
        endCoord = self._moveCoordList[self._moveIndex]

        -- 这里循环走该路
        if(self._moveIndex >= #self._moveCoordList) then
            self._moveIndex = 1
        end
        
        local endBreak = false
        repeat
            endCoord = self._moveCoordList[self._moveIndex]
            if not endCoord then

                return false
            end
            if(endCoord.x == coord.x and endCoord.y == coord.y) then
                self._moveIndex = self._moveIndex + 1
                -- endCoord = self._moveCoordList[self._moveIndex]
            else
                endBreak = true
            end

        until endBreak

        if DEBUG then
            print("MoveStateActionForNpc:culcuationStatus endCoord.x,endCoord.y,coord.x,coord.y",endCoord.x,endCoord.y,coord.x,coord.y)
        end

        -- 处理容错，这里判断起点和终点是否在同一轴线上面
        if endCoord.x ~= coord.x and endCoord.y ~= coord.y then
            -- 瞬移到起点
            -- MachineManager:getInstance():pushIDLECommand(self._target, coord, true)
            self._battleMachine:_fsmIdle(self._target, coord, true)

            return false
        end

        self._direction = computeDirection(coord,endCoord)
    end

    return true
end

function MoveStateActionForNpc:handleFindPath()

    return true
end

-- 判断某格子是否可通行
function MoveStateActionForNpc:judgeReachable(coord)
    -- local tileData = self._battleMachine._model:getMapData():getTileDataAtCoord(coord.x, coord.y)

    local reachable = self._battleMachine._model:getMapData():isCoordReachable(coord.x, coord.y)
    if DEBUG then
        print("MoveStateActionForNpc:judgeReachable coord.x,coord.y,reachable=",coord.x,coord.y,reachable)
    end

    return  reachable
end

-- 判断是否移动到了最后一格
function MoveStateActionForNpc:clickJudgeMoveEnd(coord)
    local nextCoord = self._moveCoordList[#self._moveCoordList]
    if nextCoord.x == coord.x and nextCoord.y == coord.y then
        return true
    end

    return false
end

-- 判断是否需要转向了
function MoveStateActionForNpc:judgeChangeDirection(coord)
    coord.x = Avalon.MathUtil:getInt(coord.x)
    coord.y = Avalon.MathUtil:getInt(coord.y)
    if DEBUG then
        print("MoveStateActionForNpc:judgeChangeDirection x,y",coord.x,coord.y)
    end
    if self._moveIndex <= #self._moveCoordList then
        local nextCoord = self._moveCoordList[self._moveIndex]
        if DEBUG then
            print("MoveStateActionForNpc:judgeChangeDirection nextCoord.x,nextCoord.y",nextCoord.x,nextCoord.y)
        end
        if nextCoord.x == coord.x and nextCoord.y == coord.y then

            return true
        end
    end

    return false
end

function MoveStateActionForNpc:getNextCoord()
    local nextCoord = {}
    nextCoord.x = Avalon.MathUtil:getInt(self._currentCoord.x)
    nextCoord.y = Avalon.MathUtil:getInt(self._currentCoord.y)
    if DEBUG then
        print("MoveStateActionForNpc:getNextCoord now coord.x,coord.y=",nextCoord.x,nextCoord.y)
    end
    if self._direction == DirectionType.NORTH then
        nextCoord.y = nextCoord.y + 1
    elseif self._direction == DirectionType.EAST then
        nextCoord.x = nextCoord.x + 1
    elseif self._direction == DirectionType.SOUTH then
        nextCoord.y = nextCoord.y - 1
    elseif self._direction == DirectionType.WEAST then
        nextCoord.x = nextCoord.x - 1
    end
    
    -- 用于保证客户端计算完整
    if nextCoord.z == nil then
        nextCoord.z = 0
    end

    if DEBUG then
        print("MoveStateActionForNpc:getNextCoord next coord.x,coord.y=",nextCoord.x,nextCoord.y)
    end

    return nextCoord
end

-- 获取移动速度
function MoveStateActionForNpc:getSpeed()
    local speed = 1000
    if self._data and self._data.moveSpeed then
        speed = self._data.moveSpeed
    end
    -- speed = 400
    speed = speed/PublicDefine.CONST_DEFINITION.MAP_COORD_COVERT_DISTANCE

    return speed
end
