--[[--
视图ApprenticeshipReceivePanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/07/31
--desc	: 
------------------------------------------------------------------------------

local ApprenticeshipReceivePanel = class("ApprenticeshipReceivePanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ApprenticeshipReceivePanel:init()
	ApprenticeshipReceivePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ApprenticeshipReceivePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ApprenticeshipReceivePanel:onExit()

end

return ApprenticeshipReceivePanel