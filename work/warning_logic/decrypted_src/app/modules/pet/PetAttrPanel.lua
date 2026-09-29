--[[--
视图PetAttrPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 
------------------------------------------------------------------------------

local PetAttrPanel = class("PetAttrPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function PetAttrPanel:init()
	PetAttrPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetAttrPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetAttrPanel:onExit()

end

return PetAttrPanel