--[[--
视图GuildAuctionStockPanel
]]

------------------------------------------------------------------------------
--author: yudong.li
--date	: 2020/03/05
--desc	: 
------------------------------------------------------------------------------

local GuildAuctionStockPanel = class("GuildAuctionStockPanel",mvc.GamePanel)
local COM_WIDTH = 931
local COM_HEIGHT = 575
function GuildAuctionStockPanel:init()
	GuildAuctionStockPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.PANEL)
end

function GuildAuctionStockPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function GuildAuctionStockPanel:onExit()

end

return GuildAuctionStockPanel