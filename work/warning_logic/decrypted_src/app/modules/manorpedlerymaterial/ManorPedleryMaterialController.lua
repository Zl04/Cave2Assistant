--[[--
控制器ManorPedleryMaterialController，view已经注入,可以通过mvc.manorPedleryMaterialProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2023/01/31
-- desc	: 
------------------------------------------------------------------------------
local ManorPedleryMaterialController = class("ManorPedleryMaterialController", mvc.GameController)

function ManorPedleryMaterialController:reloadChoosePedleryMaterial(materialId)
    if self.manorPedleryMaterialView then
        self.manorPedleryMaterialView:reloadChoosePedleryMaterial(materialId)
    end
end

return ManorPedleryMaterialController

