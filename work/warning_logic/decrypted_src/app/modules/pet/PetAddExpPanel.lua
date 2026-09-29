--[[--
视图PetAddExpPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/29
--desc	: 
------------------------------------------------------------------------------

local PetAddExpPanel = class("PetAddExpPanel",mvc.GamePanel)
local COM_WIDTH = 482
local COM_HEIGHT = 380
function PetAddExpPanel:init()
	PetAddExpPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function PetAddExpPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setNoticeShowMainUI(false)
	-- self.ui:enableDebugDraw()
end


function PetAddExpPanel:onExit()

end

return PetAddExpPanel