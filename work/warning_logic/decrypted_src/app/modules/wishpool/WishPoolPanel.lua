--[[--
视图WishPoolPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/09/24
--desc	: 
------------------------------------------------------------------------------

local WishPoolPanel = class("WishPoolPanel",mvc.GamePanel)
local COM_WIDTH = 716
local COM_HEIGHT = 533
function WishPoolPanel:init()
	WishPoolPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function WishPoolPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function WishPoolPanel:onExit()

end

return WishPoolPanel