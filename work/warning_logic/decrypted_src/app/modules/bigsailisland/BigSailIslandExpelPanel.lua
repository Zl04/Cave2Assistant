--[[--
视图BigSailIslandExpelPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/04
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandExpelPanel = class("BigSailIslandExpelPanel",mvc.GamePanel)
local COM_WIDTH = 620
local COM_HEIGHT = 534
function BigSailIslandExpelPanel:init()
	BigSailIslandExpelPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TIP)
end

function BigSailIslandExpelPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandExpelPanel:onExit()

end

return BigSailIslandExpelPanel