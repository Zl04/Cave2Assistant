--TriggerNpcFSM.lua
--2017-04-27
--Author:zp
--触发NPC 状态机


require "app.object.fsm.FSM"

FSM = FSM or {}

local TriggerNpcFSM = class("TriggerNpcFSM", FSM.Base)
FSM.TriggerNpcFSM = TriggerNpcFSM

-- public:
-- 切换状态
function TriggerNpcFSM:canSwitch(newState)
    local state = self._state

    if (state == TriggerNPCState.IDLE) then 
        return true
    elseif (state == TriggerNPCState.OPEN) then
        if (newState == TriggerNPCState.IDLE or newState == TriggerNPCState.OPEN) then 
            return false
        else 
            return true 
        end
    elseif (state == TriggerNPCState.DISAPPEAR) then 
        return false
    else
        return true
    end
end