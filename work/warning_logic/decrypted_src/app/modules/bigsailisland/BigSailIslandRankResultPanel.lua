--[[--
视图BigSailIslandRankResultPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/10
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandRankResultPanel = class("BigSailIslandRankResultPanel",mvc.GamePanel)
local COM_WIDTH = 500
local COM_HEIGHT = 534
function BigSailIslandRankResultPanel:init()
	BigSailIslandRankResultPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TIP)
end

function BigSailIslandRankResultPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandRankResultPanel:onExit()

end

return BigSailIslandRankResultPanel