--[[--
控制器PetController，view已经注入,可以通过mvc.petProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: zhiming.luo
-- date	: 2019/10/23
-- desc	: 
------------------------------------------------------------------------------
local PetController = class("PetController", mvc.GameController)

return PetController

