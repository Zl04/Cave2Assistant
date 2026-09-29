--[[--
视图ApprenticeshipApprenticeGraduatePanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/08/15
--desc	: 
------------------------------------------------------------------------------

local ApprenticeshipApprenticeGraduatePanel = class("ApprenticeshipApprenticeGraduatePanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ApprenticeshipApprenticeGraduatePanel:init()
	ApprenticeshipApprenticeGraduatePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ApprenticeshipApprenticeGraduatePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ApprenticeshipApprenticeGraduatePanel:onExit()

end

return ApprenticeshipApprenticeGraduatePanel