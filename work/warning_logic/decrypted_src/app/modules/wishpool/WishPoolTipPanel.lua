--[[--
视图WishPoolTipPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/10
--desc	: 
------------------------------------------------------------------------------

local WishPoolTipPanel = class("WishPoolTipPanel",mvc.GamePanel)
local COM_WIDTH = 430
local COM_HEIGHT = 290
function WishPoolTipPanel:init()
	WishPoolTipPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function WishPoolTipPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setNoticeShowMainUI(false)
	-- self.ui:enableDebugDraw()
end


function WishPoolTipPanel:onExit()

end

return WishPoolTipPanel