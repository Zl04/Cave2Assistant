--[[--
控制器SFSignController，view已经注入,可以通过mvc.sFSignProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: zhiming.luo
-- date	: 2020/01/08
-- desc	: 
------------------------------------------------------------------------------
local SFSignController = class("SFSignController", mvc.GameController)

return SFSignController

