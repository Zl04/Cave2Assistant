--[[--
控制器NetworkEnvironmentTestingController，view已经注入,可以通过mvc.networkEnvironmentTestingProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2024/04/02
-- desc	: 
------------------------------------------------------------------------------
local NetworkEnvironmentTestingController = class("NetworkEnvironmentTestingController", mvc.GameController)

return NetworkEnvironmentTestingController

