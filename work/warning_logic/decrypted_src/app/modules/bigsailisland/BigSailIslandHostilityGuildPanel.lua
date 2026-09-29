--[[--
视图BigSailIslandHostilityGuildPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/13
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandHostilityGuildPanel = class("BigSailIslandHostilityGuildPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigSailIslandHostilityGuildPanel:init()
	BigSailIslandHostilityGuildPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailIslandHostilityGuildPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandHostilityGuildPanel:onExit()

end

return BigSailIslandHostilityGuildPanel