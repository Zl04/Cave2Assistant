--[[--
视图RallyGamePanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2024/01/08
--desc	: 
------------------------------------------------------------------------------

local RallyGamePanel = class("RallyGamePanel",mvc.GamePanel)
local COM_WIDTH = 1100
local COM_HEIGHT = 609
function RallyGamePanel:init()
	RallyGamePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function RallyGamePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function RallyGamePanel:onExit()

end

return RallyGamePanel