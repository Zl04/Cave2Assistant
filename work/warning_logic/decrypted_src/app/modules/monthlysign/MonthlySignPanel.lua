--[[--
视图MonthlySignPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/06/17
--desc	: 
------------------------------------------------------------------------------

local MonthlySignPanel = class("MonthlySignPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function MonthlySignPanel:init()
	MonthlySignPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function MonthlySignPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function MonthlySignPanel:onExit()

end

return MonthlySignPanel