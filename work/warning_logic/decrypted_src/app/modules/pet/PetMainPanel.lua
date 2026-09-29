--[[--
视图PetMainPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/23
--desc	: 
------------------------------------------------------------------------------

local PetMainPanel = class("PetMainPanel",mvc.GamePanel)
local COM_WIDTH = 920
local COM_HEIGHT = 580
function PetMainPanel:init()
	PetMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetMainPanel:onExit()

end

return PetMainPanel