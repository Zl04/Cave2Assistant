--[[--
控制器WishPoolController，view已经注入,可以通过mvc.wishPoolProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: zhiming.luo
-- date	: 2019/09/24
-- desc	: 
------------------------------------------------------------------------------
local WishPoolController = class("WishPoolController", mvc.GameController)

return WishPoolController

