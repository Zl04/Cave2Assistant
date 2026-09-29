--[[--
控制器SuitTransformationController，view已经注入,可以通过mvc.suitTransformationProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2022/05/30
-- desc	: 
------------------------------------------------------------------------------
local SuitTransformationController = class("SuitTransformationController", mvc.GameController)

function SuitTransformationController:resetRetrofitDataUpdateLayer()
    self.suitTransformationView:resetRetrofitDataUpdate()
end

function SuitTransformationController:closeSelectLayer()
    mvc.closePanel("SuitTransformation", "SuitTransformationSelectRetrofit")
end

return SuitTransformationController

