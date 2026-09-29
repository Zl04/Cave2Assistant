--[[--
视图PetRefineSelectPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/30
--desc	: 
------------------------------------------------------------------------------

local PetRefineSelectPanel = class("PetRefineSelectPanel",mvc.GamePanel)
local COM_WIDTH = 430
local COM_HEIGHT = 290
function PetRefineSelectPanel:init()
	PetRefineSelectPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function PetRefineSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetRefineSelectPanel:onExit()

end

return PetRefineSelectPanel