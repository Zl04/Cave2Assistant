--[[--
视图BigSailPortSetPetCellPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/19
--desc	: 
------------------------------------------------------------------------------

local BigSailPortSetPetCellPanel = class("BigSailPortSetPetCellPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigSailPortSetPetCellPanel:init()
	BigSailPortSetPetCellPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailPortSetPetCellPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailPortSetPetCellPanel:onExit()

end

return BigSailPortSetPetCellPanel