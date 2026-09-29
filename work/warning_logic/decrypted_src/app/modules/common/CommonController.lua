--[[--
控制器CommonController，view已经注入,可以通过mvc.commonProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: hongjian.yang
-- date	: 2019/11/11
-- desc	: 
------------------------------------------------------------------------------
local CommonController = class("CommonController", mvc.GameController)

return CommonController

