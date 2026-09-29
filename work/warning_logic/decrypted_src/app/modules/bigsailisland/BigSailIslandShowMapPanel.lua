--[[--
视图BigSailIslandShowMapPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/12
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandShowMapPanel = class("BigSailIslandShowMapPanel",mvc.GamePanel)
local COM_WIDTH = 1100
local COM_HEIGHT = 609
function BigSailIslandShowMapPanel:init()
	BigSailIslandShowMapPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailIslandShowMapPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandShowMapPanel:onExit()

end

return BigSailIslandShowMapPanel