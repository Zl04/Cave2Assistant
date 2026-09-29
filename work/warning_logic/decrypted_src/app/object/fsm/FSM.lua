--[[
    有限状态机
]]--

FSM = FSM or {}

local Base = class("FSMBase")
FSM.Base = Base

-- public:
-- 构造函数
function Base:ctor(dataModel)
    self._state = 0
    self._lastState = 0
    self._dataModel = dataModel
end

-- 销毁
function Base:destroy()
    -- TODO
    self._dataModel = nil
end

-- 初始化
function Base:init()
    -- TODO

end

-- 清理
function Base:clear()
    self._state = 0
    self._lastState = 0
    self._dataModel = nil
end

-- 获取当前状态
function Base:getState()
    return self._state
end

-- 检查状态是否改变
function Base:isChanged()
    local changed = self._state ~= self._lastState
    self._lastState = self._state

    return changed
end

-- 切换状态
function Base:canSwitch(newState)
    assert(false, "[ERROR] FSM canSwitch: this method should be override by sub class.")
    return false
end

-- 切换到某个状态
function Base:switch(newState)
    if (self._state == newState) then 
        -- print(string.format("[WARNING] FSM: could not switch the same state %d.", self._state))
        return false 
    end

    if (self:canSwitch(newState)) then
        -- print(string.format("FSM: successful to switch state from %d to %d.", self._state, newState))
        self._state = newState
        if self._dataModel then
            self._dataModel:setState(newState)
        end
        return true
    else
        -- print(string.format("[WARNING] FSM: fail to switch state from %d to %d.", self._state, newState))
        return false
    end
end