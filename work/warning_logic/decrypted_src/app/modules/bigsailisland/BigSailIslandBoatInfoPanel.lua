--[[--
视图BigSailIslandBoatInfoPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/04
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandBoatInfoPanel = class("BigSailIslandBoatInfoPanel",mvc.GamePanel)
local COM_WIDTH = 400
local COM_HEIGHT = 500
function BigSailIslandBoatInfoPanel:init()
	BigSailIslandBoatInfoPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function BigSailIslandBoatInfoPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandBoatInfoPanel:onExit()

end

return BigSailIslandBoatInfoPanel