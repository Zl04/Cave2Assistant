--[[--
视图PetSharePanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/11/02
--desc	: 
------------------------------------------------------------------------------

local PetSharePanel = class("PetSharePanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function PetSharePanel:init()
	PetSharePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetSharePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetSharePanel:onExit()

end

return PetSharePanel