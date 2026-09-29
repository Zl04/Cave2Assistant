--[[
    行为基类：用于控制某个对象的行为
]]--

require "app.pool.PoolObject"

Action = Action or {}

local Base = class("ActionBase", Pool.PoolObject)
Action.Base = Base

-- 生成唯一id
Action.InstanceCount = 0 

-- action的执行状态
Action.State = {
    NONE = 0,       -- 初始化状态
    IDLE = 1,       -- 可执行状态
    EXECUTING = 2,  -- 正在执行状态
    COMPLETE = 3,   -- 执行完成状态
    FAILURE = 4,    -- 执行失败
    INTERRUPT = 5   -- 执行中断
}
ActionState = Action.State

-- private:
local DEBUG = false

-- 构造函数
function Base:ctor(type)
    if (DEBUG) then
        print(string.format("Action constructor type %d.", type))
    end

    Action.InstanceCount = Action.InstanceCount + 1
    -- 唯一id和类型
    self._id = Action.InstanceCount
    self._type = type

    -- action控制的目标对象
    self._target = nil
    
    -- action的的执行时间
    self._currentTime = 0
    self._startTime = 0
    self._endTime = 0

    -- action是否是持续性的，如果是持续性的就调用update
    self._persistent = false
    -- action的完成是由update控制，不由时间控制
    self._completeByUpdate = false
    -- action的执行速度
    self._timeScale = 1.0
    -- action的执行状态
    self._actionState = ActionState.NONE
    -- 是否强制完成
    self._isForceComplete = false
end

-- 析构函数
function Base:dtor()
    if (DEBUG) then
        print(string.format("Action destructor type %d.", self._type))
    end

    if (self:isExecuting()) then
        interrupt(self)
    end
    self._target = nil
end

-- 完成action的执行，完成的前提条件是action初始化完成或者正在执行
local function complete(self)
    if (self._actionState == ActionState.IDLE or
        self._actionState == ActionState.EXECUTING) then
        self._actionState = ActionState.COMPLETE
        self:onEnd()

        if(DEBUG) then
            self:print("Action complete: action is complete.")
        end
    else
        if(DEBUG) then
            self:print(string.format("[ERROR] Action complete: state %d is invalid. type=%d", self._actionState,self._type))
        end
        -- assert(false, "")
    end
end

-- 执行失败
local function fail(self)
    self._actionState = ActionState.FAILURE

    self:onFail()
end

-- 执行打断
local function interrupt(self)
    self._actionState = ActionState.INTERRUPT

    self:onStop()
end

-- public:
-- 初始化
function Base:init(target, startTime, endTime)
    self._target = target
    self._startTime = startTime or 0
    self._endTime = endTime or 0
    -- 如果结束时间大于开始时间，说明是持续性的action，否则是瞬间完成的action
    self._persistent = self._endTime > self._startTime
    self._actionState = ActionState.IDLE
end

-- 设置战斗引擎对象
function Base:setBattleMachine(battleMachine)
    if battleMachine then
        self._battleMachine = battleMachine
        self._battleModel = battleMachine:getModel()
    end
end

-- 清理
function Base:clear()
    if (self:isExecuting()) then
        interrupt(self)
    end

    self._target = nil
    self._currentTime = 0
    self._startTime = 0
    self._endTime = 0
    self._persistent = false
    self._completeByUpdate = false
    self._timeScale = 1.0
    self._actionState = ActionState.NONE
    self._isForceComplete = false
end

-- 获取id
function Base:getId()
    return self._id
end

-- 获取action控制的对象
function Base:getTarget()
    return self._target
end

-- 获取action的类型
function Base:getType()
    return self._type
end

-- 获取action的执行状态
function Base:getActionState()
    return self._actionState
end

-- 获取开始执行的时间
function Base:getStartTime()
    return self._startTime
end

-- 获取当前时间
function Base:getCurrentTime()
    return self._currentTime
end

-- 设置结束执行的时间
function Base:setEndTime(endTime)
    self._endTime = endTime
    self._persistent = self._endTime > self._startTime
end

-- 获取结束时间
function Base:getEndTime()
    return self._endTime
end

-- 调整action执行速度
function Base:setTimeScale(timeScale)
    self._timeScale = timeScale
end

-- 是否刚被创建
function Base:isCreated()
    return self._actionState == ActionState.NONE
end

-- 是否可以执行
function Base:isExecutable()
    return self._actionState == ActionState.IDLE
end

-- 是否正在执行
function Base:isExecuting()
    return self._actionState == ActionState.EXECUTING
end

-- 是否完成
function Base:isComplete()
    return self._actionState == ActionState.COMPLETE
end

-- 是否失败
function Base:isFailure()
    return self._actionState == ActionState.FAILURE
end

-- 是否被终止
function Base:isInterrupted()
    return self._actionState == ActionState.INTERRUPT
end

-- 强制调用action的update，不管action是否是持续性的，此标志位优先级最高，由用户控制完成时机
function Base:forceUpdate()
    self._completeByUpdate = true
end

-- 重新执行action
function Base:restart()
    if (self._actionState ~= ActionState.NONE) then
        self._actionState = ActionState.IDLE
        
        self:execute()
    end
end

-- 执行action，执行的前提条件是action初始化完成
-- 返回值表示执行成功或失败
function Base:execute()
    local success = false

    if (self._actionState == ActionState.IDLE) then
        success = self:onStart()
    else
        if(DEBUG) then
            self:print("[ERROR] Action execute: state %d is invalid.", self._actionState)
        end
        assert(false, "")
    end
    if (success) then
        if (self._completeByUpdate or self._persistent) then
            self._actionState = ActionState.EXECUTING
            self._currentTime = self._startTime
        else
            complete(self)
        end
    else
        if(DEBUG) then
            self:print("[WARNING] Action execute: fail to execute the action.")
        end 
            
        fail(self)
    end
    return success
end

-- 执行中断
function Base:stop()
    interrupt(self)
end

-- 强制action执行完成
function Base:complete()
    self._isForceComplete = true
end

-- 模版方法：在action开始的时候执行一次，根据情况在子类中重写
-- 返回值表示是否执行成功
function Base:onStart()
    assert(false, string.format("[ERROR] Action onStart: this method should be overrided by sub class  type=%d,actionState=%d.",self._type, self._actionState))
    return true
end

-- 模版方法：在action更新的时候执行多次，根据情况在子类中重写
-- 返回值表示是否执行完成
function Base:onUpdate(dt)
    assert(false, string.format("[ERROR] Action onUpdate: this method should be overrided by sub class  type=%d,actionState=%d.",self._type, self._actionState))
    return true
end

-- 模版方法：在action结束的时候执行一次，根据情况在子类中重写
function Base:onEnd()
    assert(false, string.format("[ERROR] Action onEnd: this method should be overrided by sub class  type=%d,actionState=%d.",self._type, self._actionState))
end

-- 模版方法：在action被中断的时候执行一次，根据情况在子类中重写
function Base:onStop()
    --assert(false, string.format("[ERROR] Action onStop: this method should be overrided by sub class  type=%d,actionState=%d.",self._type, self._actionState))
end

-- 模版方法：在action执行失败时候执行一次，根据情况在子类重写
function Base:onFail()
    --assert(false, string.format("[ERROR] Action onFail: this method should be overrided by sub class  type=%d,actionState=%d.",self._type, self._actionState))
end

-- action的更新，通过时间间隔控制action的更新
function Base:update(dt)
    if (self._actionState == ActionState.EXECUTING) then
        dt = dt * self._timeScale
        self._currentTime = self._currentTime + dt

        local isComplete = false
        if (not self._isForceComplete) then
            -- 如果是强制更新，只检测update的返回值
            if (self._completeByUpdate) then
                isComplete = self:onUpdate(dt)
            else
                self:onUpdate(dt)
                isComplete = self._currentTime >= self._endTime
            end
        else
            isComplete = self._isForceComplete
        end
        if (isComplete) then
            complete(self)
        end
    elseif (self._actionState == ActionState.IDLE) then
        self:execute()
    elseif (self._actionState == ActionState.INTERRUPT) then
        if(DEBUG) then
            self:print("action is interrupted.")
        end
    else
        if(DEBUG) then
            self:print("[WARNING] action state is invalid when updating.")
        end
    end
end

-- 打印信息
function Base:print(info, ...)
    print("----------------------")
    print("Action Info:")
    print(string.format("Action: %s type:%d state:%d.", self, self._type, self._actionState))
    if (info) then
        print(string.format(info, ...))
    end
    print("----------------------")
end

-- 输出错误信息
function Base:error(info, ...)
    print("Action Error Info:")
    print(string.format("[ERROR] Action: %s type:%d state:%d.", self, self._type, self._actionState))
    if (info) then
       assert(false, string.format(info, ...))
    end
end
