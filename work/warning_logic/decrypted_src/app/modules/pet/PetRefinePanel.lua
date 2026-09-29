--[[--
视图PetRefinePanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/29
--desc	: 
------------------------------------------------------------------------------

local PetRefinePanel = class("PetRefinePanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function PetRefinePanel:init()
	PetRefinePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetRefinePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetRefinePanel:onExit()

end

return PetRefinePanel