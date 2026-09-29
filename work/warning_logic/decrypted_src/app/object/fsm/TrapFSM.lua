--[[
    陷阱的状态机
]]--

require "app.object.fsm.FSM"

FSM = FSM or {}

local TrapFSM = class("TrapFSM", FSM.Base)
FSM.TrapFSM = TrapFSM

-- public:
-- 切换状态
function TrapFSM:canSwitch(newState)
    local state = self._state

    if (state == TrapState.IDLE) then 
        return true
    elseif (state == TrapState.OPEN) then
        if (newState == TrapState.IDLE or newState == TrapState.OPEN) then 
            return false
        else 
            return true 
        end
    elseif (state == TrapState.DISAPPEAR) then 
        return false
    else
        return true
    end
end