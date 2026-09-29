--[[--
视图PetComposePanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 
------------------------------------------------------------------------------

local PetComposePanel = class("PetComposePanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function PetComposePanel:init()
	PetComposePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetComposePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetComposePanel:onExit()

end

return PetComposePanel