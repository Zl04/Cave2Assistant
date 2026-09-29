--[[--
视图ApprenticeshipApprenticePanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/07/30
--desc	: 
------------------------------------------------------------------------------

local ApprenticeshipApprenticePanel = class("ApprenticeshipApprenticePanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ApprenticeshipApprenticePanel:init()
	ApprenticeshipApprenticePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ApprenticeshipApprenticePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ApprenticeshipApprenticePanel:onExit()

end

return ApprenticeshipApprenticePanel