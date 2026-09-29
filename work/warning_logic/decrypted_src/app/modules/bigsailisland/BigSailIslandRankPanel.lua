--[[--
视图BigSailIslandRankPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/06
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandRankPanel = class("BigSailIslandRankPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigSailIslandRankPanel:init()
	BigSailIslandRankPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailIslandRankPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandRankPanel:onExit()

end

return BigSailIslandRankPanel