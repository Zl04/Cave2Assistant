--[[--
视图GhostabyssShopPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2021/10/18
--desc	: 
------------------------------------------------------------------------------

local GhostabyssShopPanel = class("GhostabyssShopPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function GhostabyssShopPanel:init()
	GhostabyssShopPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function GhostabyssShopPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function GhostabyssShopPanel:onExit()

end

return GhostabyssShopPanel