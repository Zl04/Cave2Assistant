--[[--
视图PetHandbookPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 
------------------------------------------------------------------------------

local PetHandbookPanel = class("PetHandbookPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function PetHandbookPanel:init()
	PetHandbookPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetHandbookPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetHandbookPanel:onExit()

end

return PetHandbookPanel