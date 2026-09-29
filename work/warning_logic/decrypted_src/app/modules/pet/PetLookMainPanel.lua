--[[--
视图PetLookMainPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/11/15
--desc	: 
------------------------------------------------------------------------------

local PetLookMainPanel = class("PetLookMainPanel",mvc.GamePanel)
local COM_WIDTH = 920
local COM_HEIGHT = 580
function PetLookMainPanel:init()
	PetLookMainPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function PetLookMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetLookMainPanel:onExit()

end

return PetLookMainPanel