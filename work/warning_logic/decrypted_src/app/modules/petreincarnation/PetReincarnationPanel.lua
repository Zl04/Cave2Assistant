--[[--
视图PetReincarnationPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/03/17
--desc	: 
------------------------------------------------------------------------------

local PetReincarnationPanel = class("PetReincarnationPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function PetReincarnationPanel:init()
	PetReincarnationPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function PetReincarnationPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetReincarnationPanel:onExit()

end

return PetReincarnationPanel