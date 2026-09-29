--[[--
视图ApprenticeshipMentorPanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/07/30
--desc	: 
------------------------------------------------------------------------------

local ApprenticeshipMentorPanel = class("ApprenticeshipMentorPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ApprenticeshipMentorPanel:init()
	ApprenticeshipMentorPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ApprenticeshipMentorPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ApprenticeshipMentorPanel:onExit()

end

return ApprenticeshipMentorPanel