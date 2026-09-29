--[[--
控制器RelicController，view已经注入,可以通过mvc.relicProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2023/05/19
-- desc	: 
------------------------------------------------------------------------------
local RelicController = class("RelicController", mvc.GameController)

return RelicController

