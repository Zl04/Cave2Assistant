--[[--
视图GhostabyssSelectPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2021/10/18
--desc	: 
------------------------------------------------------------------------------

local GhostabyssSelectPanel = class("GhostabyssSelectPanel",mvc.GamePanel)
local COM_WIDTH = 428
local COM_HEIGHT = 544
function GhostabyssSelectPanel:init()
	GhostabyssSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function GhostabyssSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function GhostabyssSelectPanel:onExit()

end

return GhostabyssSelectPanel