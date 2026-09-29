--[[--
控制器MainCityController，view已经注入,可以通过mvc.mainCityProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: hongyi.yan
-- date	: 2020/10/16
-- desc	: 
------------------------------------------------------------------------------
local MainCityController = class("MainCityController", mvc.GameController)

return MainCityController

