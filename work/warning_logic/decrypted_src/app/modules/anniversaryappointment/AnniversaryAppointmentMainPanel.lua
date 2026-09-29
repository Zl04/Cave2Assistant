--[[--
视图AnniversaryAppointmentMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/10/17
--desc	: 
------------------------------------------------------------------------------

local AnniversaryAppointmentMainPanel = class("AnniversaryAppointmentMainPanel",mvc.GamePanel)
local COM_WIDTH = 982
local COM_HEIGHT = 614
function AnniversaryAppointmentMainPanel:init()
	AnniversaryAppointmentMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function AnniversaryAppointmentMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function AnniversaryAppointmentMainPanel:onExit()

end

return AnniversaryAppointmentMainPanel