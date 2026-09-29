--[[--
视图WishPoolListPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/10
--desc	: 
------------------------------------------------------------------------------

local WishPoolListPanel = class("WishPoolListPanel",mvc.GamePanel)
local COM_WIDTH = 920
local COM_HEIGHT = 590
function WishPoolListPanel:init()
	WishPoolListPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function WishPoolListPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setNoticeShowMainUI(false)
	-- self.ui:enableDebugDraw()
end


function WishPoolListPanel:onExit()

end

return WishPoolListPanel