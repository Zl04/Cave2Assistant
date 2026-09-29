--[[--
控制器MercenaryController，view已经注入,可以通过mvc.mercenaryProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: ping.zhengping.zhengping.zheng
-- date	: 2021/04/07
-- desc	: 
------------------------------------------------------------------------------
local MercenaryController = class("MercenaryController", mvc.GameController)

return MercenaryController

