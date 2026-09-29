--[[--
视图PetResultShowPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/11/07
--desc	: 
------------------------------------------------------------------------------

local PetResultShowPanel = class("PetResultShowPanel",mvc.GamePanel)
local COM_WIDTH = 920
local COM_HEIGHT = 580
function PetResultShowPanel:init()
	PetResultShowPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.TOP_PANEL)
end

function PetResultShowPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetResultShowPanel:onExit()

end

return PetResultShowPanel