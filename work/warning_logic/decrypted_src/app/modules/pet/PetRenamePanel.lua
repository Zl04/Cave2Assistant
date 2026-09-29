--[[--
视图PetRenamePanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/31
--desc	: 
------------------------------------------------------------------------------

local PetRenamePanel = class("PetRenamePanel",mvc.GamePanel)
local COM_WIDTH = 430
local COM_HEIGHT = 290
function PetRenamePanel:init()
	PetRenamePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function PetRenamePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setNoticeShowMainUI(false)
	-- self.ui:enableDebugDraw()
end


function PetRenamePanel:onExit()

end

return PetRenamePanel