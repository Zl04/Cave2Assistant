--[[--
视图PetInheritPanel
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/14
--desc	:
------------------------------------------------------------------------------

local PetInheritPanel = class("PetInheritPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function PetInheritPanel:init()
	PetInheritPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetInheritPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetInheritPanel:onExit()

end

return PetInheritPanel