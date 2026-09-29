--[[--
视图DockMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/06
--desc	: 
------------------------------------------------------------------------------

local DockMainPanel = class("DockMainPanel",mvc.GamePanel)
local COM_WIDTH = 1024
local COM_HEIGHT = 560
function DockMainPanel:init()
	DockMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function DockMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function DockMainPanel:onExit()

end

return DockMainPanel