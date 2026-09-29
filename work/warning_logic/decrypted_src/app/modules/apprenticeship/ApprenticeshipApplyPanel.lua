--[[--
视图ApprenticeshipApplyPanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/07/31
--desc	: 
------------------------------------------------------------------------------

local ApprenticeshipApplyPanel = class("ApprenticeshipApplyPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ApprenticeshipApplyPanel:init()
	ApprenticeshipApplyPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ApprenticeshipApplyPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ApprenticeshipApplyPanel:onExit()

end

return ApprenticeshipApplyPanel