--[[--
视图BigSailPortSpeedUpPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/27
--desc	: 
------------------------------------------------------------------------------

local BigSailPortSpeedUpPanel = class("BigSailPortSpeedUpPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigSailPortSpeedUpPanel:init()
	BigSailPortSpeedUpPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailPortSpeedUpPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailPortSpeedUpPanel:onExit()

end

return BigSailPortSpeedUpPanel