--[[
    子弹的状态机
]]--

require "app.object.fsm.FSM"

FSM = FSM or {}

local BulletFSM = class("BulletFSM", FSM.Base)
FSM.BulletFSM = BulletFSM

-- public:
-- 初始化
function BulletFSM:init()
    self._state = AircraftFSM.NONE
end

-- 切换状态
function BulletFSM:canSwitch(newState)
    return true
end