--[[--
视图GemConnectPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/03/19
--desc	: 
------------------------------------------------------------------------------

local GemConnectPanel = class("GemConnectPanel",mvc.GamePanel)
local COM_WIDTH = 0
local COM_HEIGHT = 0
function GemConnectPanel:init()
	GemConnectPanel.super.init(self, ViewStyle.ViewStyle_DoorWin, mvc.VIEW_TYPE.PANEL)
end

function GemConnectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:centerLeft(0)
	self.ui:enableDebugDraw()
end


function GemConnectPanel:onExit()

end

return GemConnectPanel