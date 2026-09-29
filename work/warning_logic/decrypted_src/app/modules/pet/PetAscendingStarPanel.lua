--[[--
视图PetAscendingStarPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/02/02
--desc	: 
------------------------------------------------------------------------------

local PetAscendingStarPanel = class("PetAscendingStarPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function PetAscendingStarPanel:init()
	PetAscendingStarPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetAscendingStarPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetAscendingStarPanel:onExit()

end

return PetAscendingStarPanel