--[[--
视图PetBreakLevelLimitPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/03/24
--desc	: 
------------------------------------------------------------------------------

local PetBreakLevelLimitPanel = class("PetBreakLevelLimitPanel",mvc.GamePanel)
local COM_WIDTH = 482
local COM_HEIGHT = 380
function PetBreakLevelLimitPanel:init()
	PetBreakLevelLimitPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function PetBreakLevelLimitPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setNoticeShowMainUI(false)
	-- self.ui:enableDebugDraw()
end


function PetBreakLevelLimitPanel:onExit()

end

return PetBreakLevelLimitPanel