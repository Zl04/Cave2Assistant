--[[--
控制器ChaosWormholeController，view已经注入,可以通过mvc.ChaosWormholeProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2023/08/08
-- desc	: 
------------------------------------------------------------------------------
local ChaosWormholeController = class("ChaosWormholeController", mvc.GameController)

return ChaosWormholeController

