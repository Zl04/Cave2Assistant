--[[--
视图BigSailIslandPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/28
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandPanel = class("BigSailIslandPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigSailIslandPanel:init()
	BigSailIslandPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailIslandPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandPanel:onExit()

end

return BigSailIslandPanel