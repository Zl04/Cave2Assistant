--[[--
视图PetLookAttrPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/11/15
--desc	: 
------------------------------------------------------------------------------

local PetLookAttrPanel = class("PetLookAttrPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function PetLookAttrPanel:init()
	PetLookAttrPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetLookAttrPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetLookAttrPanel:onExit()

end

return PetLookAttrPanel