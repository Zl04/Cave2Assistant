--[[--
控制器DungeonExpFightController，view已经注入,可以通过mvc.dungeonExpFightProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: siyu.lin
-- date	: 2023/08/07
-- desc	: 
------------------------------------------------------------------------------
local DungeonExpFightController = class("DungeonExpFightController", mvc.GameController)

return DungeonExpFightController

