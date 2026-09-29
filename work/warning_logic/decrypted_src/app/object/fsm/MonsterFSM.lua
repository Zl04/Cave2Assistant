--[[
    怪物的状态机
]]--

require "app.object.fsm.FSM"

FSM = FSM or {}

local MonsterFSM = class("MonsterFSM", FSM.Base)
FSM.MonsterFSM = MonsterFSM

-- public:
-- 切换状态
function MonsterFSM:canSwitch(newState)
    local state = self._state
    if (state == FSMState.BATTLE) then
        if (newState == FSMState.MOVE) then
            return false
        end
    -- elseif (state == FSMState.DIE) then
    --     return false
    else
        return true
    end

    return true
end