--[[
    英雄的状态机
]]--

require "app.object.fsm.FSM"

FSM = FSM or {}

local HeroFSM = class("HeroFSM", FSM.Base)
FSM.HeroFSM = HeroFSM

-- public:
-- 切换状态
function HeroFSM:canSwitch(newState)
    local state = self._state
    if (state == FSMState.BATTLE) then
        if (newState == FSMState.MOVE) then
            return false
        end
    elseif (state == FSMState.DIE) then
        if (newState == FSMState.REVIVE) then
            return true
        else
            return false
        end
    elseif (state == FSMState.WAITING) then
        if (newState == FSMState.MOVE) then
            return false
        end
    else
        return true
    end

    return true
end