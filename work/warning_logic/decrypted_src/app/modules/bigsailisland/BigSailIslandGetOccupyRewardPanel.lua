--[[--
视图BigSailIslandGetOccupyRewardPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/21
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandGetOccupyRewardPanel = class("BigSailIslandGetOccupyRewardPanel",mvc.GamePanel)
local COM_WIDTH = 558
local COM_HEIGHT = 393
function BigSailIslandGetOccupyRewardPanel:init()
	BigSailIslandGetOccupyRewardPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailIslandGetOccupyRewardPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandGetOccupyRewardPanel:onExit()

end

return BigSailIslandGetOccupyRewardPanel