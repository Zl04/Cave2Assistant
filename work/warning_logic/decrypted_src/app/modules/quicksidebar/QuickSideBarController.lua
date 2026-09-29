--[[--
控制器QuickSideBarController，view已经注入,可以通过mvc.quickSideBarProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: zhiming.luo
-- date	: 2019/09/06
-- desc	: 
------------------------------------------------------------------------------
local QuickSideBarController = class("QuickSideBarController", mvc.GameController)

return QuickSideBarController

