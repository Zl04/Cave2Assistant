--[[--
视图BigSailPortPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/14
--desc	: 
------------------------------------------------------------------------------

local BigSailPortPanel = class("BigSailPortPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigSailPortPanel:init()
	BigSailPortPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailPortPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailPortPanel:onExit()

end

return BigSailPortPanel