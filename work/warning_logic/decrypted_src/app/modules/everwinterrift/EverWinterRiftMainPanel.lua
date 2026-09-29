--[[--
视图EverWinterRiftMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/02/16
--desc	: 
------------------------------------------------------------------------------

local EverWinterRiftMainPanel = class("EverWinterRiftMainPanel",mvc.GamePanel)
local COM_WIDTH = 1040
local COM_HEIGHT = 610
function EverWinterRiftMainPanel:init()
	EverWinterRiftMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function EverWinterRiftMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function EverWinterRiftMainPanel:onExit()

end

return EverWinterRiftMainPanel