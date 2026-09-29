--[[--
视图BigSailPortSupplyPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/07/05
--desc	: 
------------------------------------------------------------------------------

local BigSailPortSupplyPanel = class("BigSailPortSupplyPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigSailPortSupplyPanel:init()
	BigSailPortSupplyPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailPortSupplyPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailPortSupplyPanel:onExit()

end

return BigSailPortSupplyPanel