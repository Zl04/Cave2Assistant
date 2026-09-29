--[[
    状态机行为：战斗移动状态
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


local BattleMoveStateActionForMe = class("BattleMoveStateActionForMe", Action.BattleMoveStateAction)
Action.BattleMoveStateActionForMe = BattleMoveStateActionForMe

local BattleMoveType = Action.BattleMoveType

-- private:
-- 对象池
local BattleMoveStateActionForMePool = nil

-- public:
-- 创建对象
function BattleMoveStateActionForMe:create(reused, ...)
    if (reused) then
        if (not BattleMoveStateActionForMePool) then
            BattleMoveStateActionForMePool = Pool.Pool:create(BattleMoveStateActionForMe)
        end
        return BattleMoveStateActionForMePool:applyObject()
    else
        return BattleMoveStateActionForMe.new(...)
    end
end

-- 构造函数
function BattleMoveStateActionForMe:ctor()
    BattleMoveStateActionForMe.super.ctor(self, ActionType.FSM_BATTLE_MOVE)

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

    self._stop = false
    self._reset = false

    self._accumulationPosition = {x=0,y=0}

    self._accelerateTime = 0  -- 加速时间
    -- print("BattleMoveStateActionForMe:ctor _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)

    self._endIdle = true

    self._moveNum = 0
end

-- 模版函数：销毁
function BattleMoveStateActionForMe:dtor()
    BattleMoveStateActionForMe.super.dtor(self)
    -- print("BattleMoveStateActionForMe  onDestroy")
    self._normalMoveSpeed = 0
    -- print("BattleMoveStateActionForMe:dtor", self._callBack)
    -- print(debug.traceback())
    if(self._callBack) then
        self._callBack()
    end
    self._callBack = nil
    self._data = nil
    self._direction = nil
    self._oldDirection = DirectionType.NONE 
    self._currentCoord = nil

    self._stop = false
    self._reset = false
    -- print("teActionForMe:dtor", self._battleMachine ~= nil, self._accumulationPosition.x, self._accumulationPosition.x)
    if(self._battleMachine and (math.abs(self._accumulationPosition.x) + math.abs(self._accumulationPosition.y) > 0.5)) then
        self._battleMachine:moveOneStepTrigger()
    end

    self._accumulationPosition = {x=0,y=0}
    self._accelerateTime = 0
    self._endIdle = true
    self._startCoord = nil
    self._nextCoord = nil
    -- print("BattleMoveStateActionForMe:onDestroy _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)
end

-- 初始化
function BattleMoveStateActionForMe:init(target, battleMachine, battleModel)
    -- print("BattleMoveStateActionForMe:init   ------")
    BattleMoveStateActionForMe.super.init(self, target, battleMachine, battleModel)

    self._data = target:getData()
    self._oldDirection = DirectionType.NONE

    self._stop = false
    self._reset = false

    self._accelerateTime = 0
    -- print("BattleMoveStateActionForMe:init _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)
end

-- 初始化方向移动
function BattleMoveStateActionForMe:setDirectionMove(direction,actionStartTime,coord)
    self._battleMoveType = BattleMoveType.DIRECTION_MOVE

    self._direction = direction

    self._stop = false
    self._reset = true
    self._actionStartTime = actionStartTime
    self._accelerateTime = 0

    self._moveStartTrigger = true

    if coord then
        -- 这里用于临时同步位置
        local target = self._target
        local battleMachine = self._battleMachine
        local battleModel = self._battleModel

        self._target:setCoord(coord.x, coord.y)
        -- MachineManager:getInstance():pushPositionRendererCommand(self._target,coord,self._target:isMaster())
        self:pushPositionRendererCommand(self._target,coord,self._target:isMaster())

        if (self._target) then 
            self._target:idle()
        end
        self:clear()
        self:init(target, battleMachine,battleModel)
        self:setDirectionMove(direction, actionStartTime)
    end
end

-- 初始化点击移动方向
function BattleMoveStateActionForMe:setClickMove(moveCoordList,actionStartTime, moveStartTrigger, moveEndCallBack)
    self._battleMoveType = BattleMoveType.CLICK_MOVE

    self._moveCoordList = moveCoordList
    self._moveIndex = 1

    self._stop = false
    self._reset = true

    self._actionStartTime = actionStartTime
    self._accelerateTime = 0

    if(moveStartTrigger == nil) then
        self._moveStartTrigger = true
    else
        self._moveStartTrigger = moveStartTrigger
    end
    self._moveEndCallBack = moveEndCallBack

    if DEBUG then
        print("BattleMoveStateActionForMe:setClickMove  now, x,y",k,self._target:getCoord().x,self._target:getCoord().y)
        for k,v in pairs(self._moveCoordList) do
            print("BattleMoveStateActionForMe:setClickMove  k, x,y",k,v.x,v.y)
        end
    end
end

-- 设置目标点的移动
function BattleMoveStateActionForMe:setEndCoordMove(endCoord,actionStartTime)
    if self._battleMoveType == BattleMoveType.END_COORD_MOVE then
        if self._endCoord.x == endCoord.x and self._endCoord.y == endCoord.y then
            if DEBUG then
                print("BattleMoveStateActionForMe:setEndCoordMove  endCoord is equal x,y",endCoord.x,endCoord.y)
            end
            return 
        end 
    end
    self._battleMoveType = BattleMoveType.END_COORD_MOVE

    self._stop = false
    self._reset = true

    self._endCoord = endCoord
    self._actionStartTime = actionStartTime
    self._accelerateTime = 0

    if DEBUG then
        print("BattleMoveStateActionForMe:setEndCoordMove  endCoord x,y",endCoord.x,endCoord.y)
    end
end

-- 清理
function BattleMoveStateActionForMe:clear()
    BattleMoveStateActionForMe.super.clear(self)
    -- print("BattleMoveStateActionForMe:clear", self._callBack)
    -- print(debug.traceback())
    if(self._callBack) then
        self._callBack()
    end
    self._callBack = nil
    self._target = nil
    self._data = nil
    self._direction = nil
    self._oldDirection = DirectionType.NONE 
    -- print("teActionForMe:clear", self._battleMachine ~= nil, self._accumulationPosition.x, self._accumulationPosition.y)
    if(self._battleMachine and (math.abs(self._accumulationPosition.x) + math.abs(self._accumulationPosition.y) > 0.5)) then
        self._battleMachine:moveOneStepTrigger()
    end
    self._battleMachine = nil

    self._currentCoord = nil
    self._endTime = 0
    self._speedX = 0
    self._speedY = 0

    self._stop = false

    self._accumulationPosition = {x=0,y=0}

    self._accelerateTime = 0
    self._endIdle = true
    self._startCoord = nil
    self._nextCoord = nil
    -- print("BattleMoveStateActionForMe:clear _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)
end

-- 模版函数：action开始
function BattleMoveStateActionForMe:onStart()
    local coord = self._target:getCoord()
    local speed = self:getSpeed()
    self._currentCoord = coord

    if(self._target) then
        -- 这里处理在指令的异步情况容错处理
        if(self._target:getIsDead()) then
            return false
        end
    end

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
    self:pushPositionRendererCommand(self._target, localCoord, self._target:isMaster())

    if not self:judageWasMaster() then
        -- 计算延迟时间
        self._accelerateTime = (GameManager:getNowServerTimestamp() - self._actionStartTime)/1000
        if DEBUG then
            print("BattleMoveStateActionForMe:onStart  _accelerateTime,actionStartTime,nowServerTime=",self._accelerateTime,self._actionStartTime,GameManager:getNowServerTimestamp())
        end
    end

    if DEBUG then
        print("BattleMoveStateActionForMe:onStart  x,y,localtime=%d",self._currentCoord.x,self._currentCoord.y,AvalonUtil.getCurrentTime())
    end 

    if self:calculationDirection() == false then

        return false
    end

    if(self._moveStartTrigger) then
        -- 判断下一格问题
        if self:handlePreMoveNext(TRIGGER_TYPE.TRIGGER_NOBENODEPATH, false) == false then
            self:handleChangeDirection(true,false)
            return false
        end
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

    self:newTriggerCenterCoordinate(self._startCoord,self._nextCoord,self._startCoord)

    -- if(self._target:isMaster()) then
    --     Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_MOVE_HALF)
    -- end
    -- 处理方向改变
    self:handleChangeDirection(true,true)

    if(self._moveStartTrigger) then
        if(DEBUG) then
            print("BattleMoveStateActionForMe onStart", self._moveStartTrigger)
        end
        -- 触发打开
        self:handlePreMoveNext(TRIGGER_TYPE.TRIGGER_BENODEPATH, true)
    end

    -- 刷新层级
    local battleCMD = Command.GenerationCommand:create(true)
    battleCMD:initForRoleZorder(self._target:getSpriteID(),false,self._target:getSpriteID())
    self._battleMachine:executeCommand(battleCMD)

    if(self._target and self._target:isMaster()) then
        if(self._moveNum > 1) then
            self._moveNum = 0
        end
        if self._moveNum == 0 then
            Avalon.AudioManager:playSound("501")
        else
            Avalon.AudioManager:playSound("507")
        end
    end

    return true
end

-- 模版函数：action更新
function BattleMoveStateActionForMe:onUpdate(dt)
    dtTotal = dtTotal + dt

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

    local animationCommand = Command.RendererCommand:create(true)
    animationCommand:initUpdateSpineTimeScale(self._target:getId(), speed/(self._normalMoveSpeed/PublicDefine.CONST_DEFINITION.MAP_COORD_COVERT_DISTANCE))
    self._battleMachine:pushCommand(animationCommand)
    
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

        -- if(self._target:isMaster()) then
        --     -- 判断是否已经走过了一半边了
        --     -- print("half trigger ",self._accumulationPosition.x, self._accumulationPosition.y)
        --     -- print("half trigger ",preAccumulationX, preAccumulationY)
        --     if( (Avalon.MathUtil:getInt(self._accumulationPosition.x) ~= Avalon.MathUtil:getInt(preAccumulationX))
        --         or (Avalon.MathUtil:getInt(self._accumulationPosition.y) ~= Avalon.MathUtil:getInt(preAccumulationY)) ) then
        --         local nextCoord = {x= Avalon.MathUtil:getInt(localCoord.x), y = Avalon.MathUtil:getInt(localCoord.y), z=0}
        --         if(DEBUG) then
        --             print("BattleMoveStateActionForMe:onUpdate  trigger half= ", nextCoord.x ,nextCoord.y)
        --         end
                -- if(self._target:isMaster()) then
        --         Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_MOVE_HALF)
                -- end
        --         self._battleMachine:handleMapTrigger(TRIGGER_TYPE.TRIGGER_ALL, nextCoord, self._target:isMaster(), false, true, GameTriggerTimeType.TRIGGER_TIME_HALF)
        --     end
        -- end

        -- print("------------- 1 ", skipOneMap)
        -- print("------------- 3 ", addX, addY, self._accumulationPosition.x, self._accumulationPosition.y)

        if skipOneMap then
            localCoord.x = Avalon.MathUtil:getInt(localCoord.x)
            localCoord.y = Avalon.MathUtil:getInt(localCoord.y)
            totalDt = totalDt + backTime
            self._accumulationPosition.x = 0
            self._accumulationPosition.y = 0
        end

        -- 判断是否已经开始走动
        if self._currentCoord.x == Avalon.MathUtil:getInt(localCoord.x) and
            self._currentCoord.y == Avalon.MathUtil:getInt(localCoord.y) then
            if DEBUG then
                print("BattleMoveStateActionForMe:onUpdate  triggerCenterCoordinate=",self._currentCoord.x,self._currentCoord.y,localCoord.x,localCoord.y,AvalonUtil:getCurrentTime())
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
        target:setCoord(localCoord.x, localCoord.y)
        local lastCoord = target:getLastCoord()

        -- by CMonk, 机器人运行优化, 可以直接删除, 为了方便批量删除就不做前置空格了
        if (Auto and Auto.Robot and Auto.Robot:isOp()) then
        else
        -- eo CMonk
        self:newTriggerCenterCoordinate(self._startCoord,self._nextCoord,nil)
        -- by CMonk, 机器人运行优化, 可以直接删除
        end
        -- eo CMonk

        -- if skipOneMap then
        --     -- 修改位置后添加到地图上面
        --     MapDataManager:getInstance():addRole(self._battleMachine._model._mapData,Avalon.MathUtil:getInt(self._currentCoord.x),Avalon.MathUtil:getInt(self._currentCoord.y),self._target:getData())
        -- end
        
        -- MachineManager:getInstance():pushPositionRendererCommand(self._target, localCoord, self._target:isMaster())
        -- by CMonk, 机器人运行优化, 可以直接删除, 为了方便批量删除就不做前置空格了
        if (Auto and Auto.Robot and Auto.Robot:isOp()) then
        else
        -- eo CMonk
        self:pushPositionRendererCommand(self._target, localCoord, self._target:isMaster(), self._startCoord, self._nextCoord)

        -- by CMonk, 机器人运行优化, 可以直接删除
        end
        -- eo CMonk
        

        if (not self._skipOneMapBeforeStep) then
            self._skipOneMapBeforeStep = true
            local enterCenterCoordCommand = Command.RendererCommand:create(true)
            enterCenterCoordCommand:initEnterCenterCoordCommand(self._target:getId(), self._nextCoord, false)
            self._battleMachine:pushCommand(enterCenterCoordCommand)            
        end
        
        if skipOneMap then
            self._skipOneMapBeforeStep = false
            -- local starttime = os.clock();
            -- 触发到达某个点触发的逻辑
            -- if(self._target:isMaster()) then
                -- Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_MOVE_HALF)
            -- end
            self._battleMachine:handleMapTrigger(TRIGGER_TYPE.TRIGGER_ALL, self._target:getCoord(), self._target:isMaster(), false, true, GameTriggerTimeType.TRIGGER_TIME_NOW)
            self._battleMachine:moveOneStepTrigger()

            local lastCoordX = self._startCoord.x
            local lastCoordY = self._startCoord.y
            local newCoord = self._target:getCoord()
            local roleData = self._target:getData()

            -- local enterCenterCoordCommand = Command.RendererCommand:create(true)
            -- enterCenterCoordCommand:initEnterCenterCoordCommand(self._target:getId(), newCoord, false)
            -- self._battleMachine:pushCommand(enterCenterCoordCommand)
            
            -- roleData:setCoord(newCoord.x, newCoord.y)
            -- 设置起点
            self._startCoord:setCoord(self._target:getCoord())
            -- 修改位置后添加到地图上面
            MapDataManager:getInstance():addRole(
                self._battleMachine._model._mapData,
                Avalon.MathUtil:getInt(newCoord.x),Avalon.MathUtil:getInt(newCoord.y),
                roleData
            )
            -- 发送移动消息
            Avalon.MessageCenter:notice(
                GameMessage.MC_ROLE_UPDATE_COORD, 
                newCoord, 
                self._target:isMaster(), 
                self._target:getSpriteID(), 
                self._target:getDirection())

            local pet = self._target.getFightPet ~= nil and self._target:getFightPet() or nil
            local lastPet = nil
            if pet and next(pet) then
                for k, v in pairs(pet) do
                    if v and not v:getIsDead() then
                        -- print("move k ", k)
                        local list = {}
                        table.insert(list, {x = Avalon.MathUtil:getInt(v:getCoord().x), y = Avalon.MathUtil:getInt(v:getCoord().y)})
                        if lastPet then
                            table.insert(list, {x = Avalon.MathUtil:getInt(lastPet:getCoord().x), y = Avalon.MathUtil:getInt(lastPet:getCoord().y)})
                        else
                            table.insert(list, {x = Avalon.MathUtil:getInt(lastCoord.x), y = Avalon.MathUtil:getInt(lastCoord.y)})
                        end
                        --赋值完成再指向上一个宠物
                        lastPet = v

                        if list[1].x ~= list[2].x and list[1].y ~= list[2].y then
                            -- print("-----LLLL-----")
                            self._battleMachine:_triggerMove(v, list[2].x, list[2].y, false)
                            
                        else
                            -- print("-----IIII-----")
                            self._battleMachine:_fsmClickMove(v, list, 0, false)
                        end
                    end
                end
            end
            
            
            

            if DEBUG then
                print("BattleMoveStateActionForMe:onUpdate  x,y,localtime,speed,speedX,speedY,地图速度,dtTotal=",self._currentCoord.x,self._currentCoord.y,AvalonUtil.getCurrentTime(),self._data.speed,self._speedX,self._speedY,speed,dtTotal)
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
                    if self:clickJudgeMoveEnd(localCoord) then
                        if(self._moveEndCallBack) then 
                            self._moveEndCallBack()
                        end
                        return true
                    end

                    if self:judgeChangeDirection(localCoord) then
                        self._moveIndex = self._moveIndex + 1

                        if self:culcuationStatus() ==  false then

                            return true
                        end
                    end
                end
            end

            if (self._stop) then
                self._stop = false
                return true
            end

            if self:handlePreMoveNext(TRIGGER_TYPE.TRIGGER_ALL, false) == false then
                self:handleChangeDirection(true,false)

                return true
            else
                -- if(self._target:isMaster()) then
                --     Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_MOVE_HALF)
                -- end
            end

            self:handlePreMoveNext(TRIGGER_TYPE.TRIGGER_ALL, true)

            -- 处理转向指令
            self:handleChangeDirection(true,true)

            self:newTriggerCenterCoordinate(self._startCoord,self._nextCoord,self._startCoord)

            if(self._target and self._target:isMaster()) then
                self._moveNum = self._moveNum + 1
                if(self._moveNum > 1) then
                    self._moveNum = 0
                end
                if self._moveNum == 0 then
                    Avalon.AudioManager:playSound("501")
                else
                    Avalon.AudioManager:playSound("507")
                end
            end
            -- local endtime = os.clock();  
            -- print(string.format("cost time  : %.4f", endtime - starttime));
        end
        
    until totalDt <= 0
    
    return false
end

-- 模板函数：停止action
function BattleMoveStateActionForMe:stop(callBack)
    -- 处理走完这一格
    self._stop = true
    if(callBack) then
        self._callBack = callBack
    end
end

-- 模版函数：action结束
function BattleMoveStateActionForMe:onEnd()
    -- 判断是否为玩家 ，发送开始移动指令
    if DEBUG then
        print("BattleMoveStateActionForMe:onEnd")
    end
    self:_stopActionHandle()
end

function BattleMoveStateActionForMe:onFail()
    -- 处理执行失败的处理
    if DEBUG then
        print("BattleMoveStateActionForMe:onFail")
    end
    self:_stopActionHandle()
end

function BattleMoveStateActionForMe:onStop()
    -- 处理执行失败的处理
    if DEBUG then
        print("BattleMoveStateActionForMe:onStop")
    end
    self:_stopActionHandle()
end

function BattleMoveStateActionForMe:_stopActionHandle()
    local dstCoord = self._target:getCoord()
    if self:judageWasMaster() then        
        -- 这里采用指令方式，外层可以根据当前状态处理相关的逻辑。
        local battleCmd = Command.BattleCommand:create()
        battleCmd:initMasterStopMove(Avalon.MathUtil:getInt(dstCoord.x), Avalon.MathUtil:getInt(dstCoord.y))
        self._battleMachine:executeCommand(battleCmd)
        
    end
    if self._target:getType() == RoleType.Pet then
        local direction = computeDirection(dstCoord, self._target:getMaster():getCoord())
        MachineManager:getInstance():pushDirectionRendererCommand(self._target, direction)
    end
    -- 这里回调移动完成
    if(self._callBack) then
        self._callBack()
        self._callBack = nil
    end
end

-- 计算英雄方向等状态
function BattleMoveStateActionForMe:culcuationStatus()
    if self:calculationDirection() == false then
        return false
    end
    if DEBUG then
        print("BattleMoveStateActionForMe:culcuationStatus _oldDirection,_direction,NONE,moveIndex",self._oldDirection,self._direction,DirectionType.NONE,self._moveIndex)
    end

    -- self:handleChangeDirection()

    -- 计算一个量化方向
    local nextCoord = self:getNextCoord()
    self.normal = computeNormal(self._currentCoord,nextCoord)
    
    self._nextCoord:setCoord(nextCoord)

    return true
end

function BattleMoveStateActionForMe:handleChangeDirection(renderChange,startMove)
    if self._oldDirection ~= self._direction then
        self._oldDirection = self._direction

        if startMove == nil then
            startMove = false
        end
        if renderChange == nil then
            renderChange = false
        end

        if startMove then
            -- 判断是否为玩家 ，发送开始移动指令
            if self:judageWasMaster() then
                Net.NetRoleSystem:heroStartMoveRequest(self._currentCoord.x,self._currentCoord.y,self._direction)
                -- local battleCmd = Command.BattleCommand:create()
                -- battleCmd:initSendStartMove(self._currentCoord.x,self._currentCoord.y,self._direction)
                -- SceneManager:getInstance():pushCommand(battleCmd)
            end
        end

        if renderChange then
            -- 处理转向操作
            MachineManager:getInstance():pushDirectionRendererCommand(self._target, self._direction)
        end
    end
end

function BattleMoveStateActionForMe:calculationDirection()
    local coord = {}
    coord.x = Avalon.MathUtil:getInt(self._currentCoord.x)
    coord.y = Avalon.MathUtil:getInt(self._currentCoord.y)

    if self._battleMoveType == BattleMoveType.CLICK_MOVE then
        endCoord = self._moveCoordList[self._moveIndex]
        
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
            print("BattleMoveStateActionForMe:culcuationStatus endCoord.x,endCoord.y,coord.x,coord.y",endCoord.x,endCoord.y,coord.x,coord.y)
        end

        -- 处理容错，这里判断起点和终点是否在同一轴线上面
        if endCoord.x ~= coord.x and endCoord.y ~= coord.y then
            -- 瞬移到起点
            -- MachineManager:getInstance():pushIDLECommand(self._target, coord, true)
            self._battleMachine:_fsmIdle(self._target, coord, true)

            return false
        end

        self._direction = computeDirection(coord,endCoord)

        -- if endCoord.x - coord.x >0.5 then
        --     self._direction = DirectionType.EAST
        -- elseif endCoord.x - coord.x <-0.5 then
        --     self._direction = DirectionType.WEAST
        -- elseif endCoord.y - coord.y >0.5 then
        --     self._direction = DirectionType.NORTH
        -- elseif endCoord.y - coord.y <-0.5 then
        --     self._direction = DirectionType.SOUTH
        -- end
    end

    return true
end

--[[
    处理走下一格之前的逻辑处理
    triggerType: 0 所有都打开 1 触发可以直接寻路的角色， 2 触发不能直接寻路的角色
    moving: 是否处于移动中
    response: false 需要停止运行了，true 可以继续运行
]] 
function BattleMoveStateActionForMe:handlePreMoveNext(triggerType, moving)
    local nextCoord = self:getNextCoord()
    self._nextCoord:setCoord(nextCoord)
    if(moving == nil) then
        moving = true
    end

    self._battleMachine:moveOneStepTrigger()
    
    return self._battleMachine:handleMapTrigger(triggerType, nextCoord, self._target:isMaster(), self._stop, moving, GameTriggerTimeType.TRIGGER_TIME_PRE)
end

function BattleMoveStateActionForMe:handleFindPath()
    -- if self._battleMoveType == BattleMoveType.END_COORD_MOVE then
    --     if self._reset then
    --         self._reset = false
    --         -- 寻路
    --         local cx = Avalon.MathUtil:getInt(self._currentCoord.x)
    --         local cy = Avalon.MathUtil:getInt(self._currentCoord.y)

    --         if cx == self.endCoord.x and cy == self.endCoord.y then

    --             return false
    --         end

    --         local moveCoordList = MapDataManager:getInstance():findPath(self._battleMachine._model:getMapData(), cx, cy, self.endCoord.x, self.endCoord.y, true)
    --         if(moveCoordList and #moveCoordList > 1) then 
    --             self._moveCoordList = moveCoordList
    --             self._moveIndex = 1
    --         else
    --             -- 直接瞬移到目标点
    --             self.target:setDirection(self._direction);
    --             self.target:setCoord(self.endCoord.x, self.endCoord.y)

    --             -- MachineManager:getInstance():pushPositionRendererCommand(self._target, self.endCoord, self._target:isMaster())
    --             self:pushPositionRendererCommand(self._target, self.endCoord, self._target:isMaster())
                
    --             return false
    --         end
    --     end
    -- end

    return true
end

-- 判断某格子是否可通行
function BattleMoveStateActionForMe:judgeReachable(coord)
    -- local tileData = self._battleMachine._model:getMapData():getTileDataAtCoord(coord.x, coord.y)

    local reachable = self._battleMachine._model:getMapData():isCoordReachable(coord.x, coord.y)
    if DEBUG then
        print("BattleMoveStateActionForMe:judgeReachable coord.x,coord.y,reachable=",coord.x,coord.y,reachable)
    end

    return  reachable
end

-- 判断是否移动到了最后一格
function BattleMoveStateActionForMe:clickJudgeMoveEnd(coord)
    local nextCoord = self._moveCoordList[#self._moveCoordList]
    if nextCoord.x == coord.x and nextCoord.y == coord.y then
        return true
    end

    return false
end

-- 判断是否需要转向了
function BattleMoveStateActionForMe:judgeChangeDirection(coord)
    coord.x = Avalon.MathUtil:getInt(coord.x)
    coord.y = Avalon.MathUtil:getInt(coord.y)
    if DEBUG then
        print("BattleMoveStateActionForMe:judgeChangeDirection x,y",coord.x,coord.y)
    end
    if self._moveIndex <= #self._moveCoordList then
        local nextCoord = self._moveCoordList[self._moveIndex]
        if DEBUG then
            print("BattleMoveStateActionForMe:judgeChangeDirection nextCoord.x,nextCoord.y",nextCoord.x,nextCoord.y)
        end
        if nextCoord.x == coord.x and nextCoord.y == coord.y then

            return true
        end
    end

    return false
end

function BattleMoveStateActionForMe:getNextCoord()
    local nextCoord = {}
    nextCoord.x = Avalon.MathUtil:getInt(self._currentCoord.x)
    nextCoord.y = Avalon.MathUtil:getInt(self._currentCoord.y)
    if DEBUG then
        print("BattleMoveStateActionForMe:getNextCoord now coord.x,coord.y=",nextCoord.x,nextCoord.y)
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
        print("BattleMoveStateActionForMe:getNextCoord next coord.x,coord.y=",nextCoord.x,nextCoord.y)
    end

    return nextCoord
end

-- 判断是否为玩家
function BattleMoveStateActionForMe:judageWasMaster()
    if(self._target) then
        return self._target:isMaster()
    else 
        return false
    end
end

-- 获取移动速度
function BattleMoveStateActionForMe:getSpeed()
    local speed = 1000
    if self._data and self._target:getMoveSpeed() then
        speed = self._target:getMoveSpeed()
    end

    -- speed = 400
    speed = speed/PublicDefine.CONST_DEFINITION.MAP_COORD_COVERT_DISTANCE

    return speed
end

--[[
    触发地图中心点坐标
    startCoord:开始坐标
    endCoord:终点坐标  nil 标识和startCoord 相同
    nowCoord:当前坐标  nil 标识使用当前坐标减去 startCoord
]]
function BattleMoveStateActionForMe:newTriggerCenterCoordinate(startCoord,endCoord,nowCoord)
    if DEBUG then
        print("BattleMoveStateActionForMe:newTriggerCenterCoordinate 1 ",startCoord,endCoord,nowCoord)
    end
    if self:judageWasMaster() == false then
        return
    end
    if startCoord then
        if endCoord == nil then
            endCoord = startCoord
        end
        if nowCoord == nil then
            nowCoord = self._target:getCoord()
        end
        if DEBUG then
            -- print("BattleMoveStateActionForMe:newTriggerCenterCoordinate 2 ",startCoord,endCoord,nowCoord)
        end
        -- 调用
        if self._battleMachine then
            if DEBUG then
                -- print("BattleMoveStateActionForMe:newTriggerCenterCoordinate 3 ",startCoord.x,startCoord.y,endCoord.x,endCoord.y,nowCoord.x,nowCoord.y)
            end
            self._battleMachine:setNewCenterCoordinate(startCoord,endCoord,nowCoord)
        end
    end
end
