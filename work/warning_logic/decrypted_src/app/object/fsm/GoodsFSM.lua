--[[
    物品的状态机
]]--

require "app.object.fsm.FSM"

FSM = FSM or {}

local GoodsFSM = class("GoodsFSM", FSM.Base)
FSM.GoodsFSM = GoodsFSM

-- public:
function GoodsFSM:init()
    self._state = GoodsState.AVAILABLE
end

-- 切换状态
function GoodsFSM:canSwitch(newState)
    local state = self._state

    if (state == GoodsState.AVAILABLE) then
        return true
    elseif (state == GoodsState.DISABLE) then
        if (newState == GoodsState.AVAILABLE) then
            return true
        else
            return false
        end
    elseif (state == GoodsState.BE_USED) then
        return false
    else
        assert(false, string.format("[ERROR] goods state %d is invalid.", state))
        return false
    end
end