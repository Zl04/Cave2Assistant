--[[--
视图FestivalWeaponSelectPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2020/05/08
--desc	: 
------------------------------------------------------------------------------

local FestivalWeaponSelectPanel = class("FestivalWeaponSelectPanel",mvc.GamePanel)
local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")

local COM_WIDTH = 852
local COM_HEIGHT = 534
function FestivalWeaponSelectPanel:init()
	FestivalWeaponSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function FestivalWeaponSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()

	self.ui:setTouchEnable(true)
	self.ui:setSwallowTouches(true)
	self.ui:setInterceptTouches(true)
	Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)  -- 关闭控制面板
end


function FestivalWeaponSelectPanel:onExit()
	local command = Command.ControlCommand:create(true)
	command:initForTypeAndData(CommandType.CONTROL_MASTER_IDLE,{})
	SceneManager:getInstance():pushCommand(command)
	Avalon.MessageCenter:notice( AvalonMessage.MC_UI_OPEN_CONTROL_PAD)

	if (MachineManager:getInstance():getMachine()) then
        MachineManager:getInstance():getMachine():enableRoleMoving()
    end
end

return FestivalWeaponSelectPanel