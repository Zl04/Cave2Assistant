--[[--
视图BigSailIslandDispatchPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/13
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandDispatchPanel = class("BigSailIslandDispatchPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigSailIslandDispatchPanel:init()
	BigSailIslandDispatchPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailIslandDispatchPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandDispatchPanel:onExit()

end

return BigSailIslandDispatchPanel