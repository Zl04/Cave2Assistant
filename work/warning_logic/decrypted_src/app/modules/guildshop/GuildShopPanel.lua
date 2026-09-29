--[[--
视图GuildShopPanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/05/28
--desc	: 
------------------------------------------------------------------------------

local GuildShopPanel = class("GuildShopPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function GuildShopPanel:init()
	GuildShopPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function GuildShopPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function GuildShopPanel:onExit()

end

return GuildShopPanel