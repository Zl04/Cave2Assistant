--[[--
视图BigSailPortSupplyItemPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/19
--desc	: 
------------------------------------------------------------------------------

local BigSailPortSupplyItemPanel = class("BigSailPortSupplyItemPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigSailPortSupplyItemPanel:init()
	BigSailPortSupplyItemPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailPortSupplyItemPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailPortSupplyItemPanel:onExit()

end

return BigSailPortSupplyItemPanel