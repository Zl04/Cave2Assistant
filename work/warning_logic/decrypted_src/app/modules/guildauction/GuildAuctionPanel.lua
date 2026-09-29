--[[--
视图GuildAuctionPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2020/03/02
--desc	: 
------------------------------------------------------------------------------

local GuildAuctionPanel = class("GuildAuctionPanel",mvc.GamePanel)
local COM_WIDTH = 918
local COM_HEIGHT = 590
function GuildAuctionPanel:init()
	GuildAuctionPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function GuildAuctionPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function GuildAuctionPanel:onExit()

end

return GuildAuctionPanel