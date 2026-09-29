--[[--
控制器GuildAuctionController，view已经注入,可以通过mvc.guildAuctionProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: zhiming.luo
-- date	: 2020/03/02
-- desc	: 
------------------------------------------------------------------------------
local GuildAuctionController = class("GuildAuctionController", mvc.GameController)

return GuildAuctionController

