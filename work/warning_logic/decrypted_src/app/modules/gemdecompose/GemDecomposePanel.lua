--[[--
视图GemDecomposePanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/04/26
--desc	: 
------------------------------------------------------------------------------

local GemDecomposePanel = class("GemDecomposePanel",mvc.GamePanel)
local COM_WIDTH = 0
local COM_HEIGHT = 0
function GemDecomposePanel:init()
	GemDecomposePanel.super.init(self, ViewStyle.ViewStyle_DoorWin, mvc.VIEW_TYPE.PANEL)
end

function GemDecomposePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:centerLeft(0)
	self.ui:enableDebugDraw()
	-- self.ui:enableDebugDraw()
end


function GemDecomposePanel:onExit()

end

return GemDecomposePanel