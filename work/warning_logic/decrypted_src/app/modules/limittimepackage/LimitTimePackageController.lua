--[[--
控制器LimitTimePackageController，view已经注入,可以通过mvc.limitTimePackageProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: hongjian.yang
-- date	: 2019/05/07
-- desc	: 
------------------------------------------------------------------------------
local LimitTimePackageController = class("LimitTimePackageController", mvc.GameController)
local SdkManager = require "app.game.SdkManager"


--函数说明
--notification
function LimitTimePackageController:noticeLimitTimeGETDO(notification)
    SdkManager:getInstance():getOrder(mvc.limitTimePackageModel:getCurProductionInfo(), 1, nil, mvc.limitTimePackageModel:getCurProductionIndex())
end



return LimitTimePackageController
