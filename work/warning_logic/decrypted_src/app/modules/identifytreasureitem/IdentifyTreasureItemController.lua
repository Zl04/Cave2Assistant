--[[--
控制器IdentifyTreasureItemController，view已经注入,可以通过mvc.identifyTreasureItemProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2023/02/23
-- desc	: 
------------------------------------------------------------------------------
local IdentifyTreasureItemController = class("IdentifyTreasureItemController", mvc.GameController)

function IdentifyTreasureItemController:refreshLeftView()
    if self.identifyTreasureItemView then
        --self.identifyTreasureItemView:updateGoodsData(nil)
        self.identifyTreasureItemView:refreshAll(true)
    end
end

function IdentifyTreasureItemController:addGoodsData(equipmentData, isIdentifySuccess)
    if self.identifyTreasureItemView then
        self.identifyTreasureItemView:updateGoodsData(equipmentData)
        self.identifyTreasureItemView:nowTimeIdentifyResult(isIdentifySuccess)
    end
end

function IdentifyTreasureItemController:refreshTriggerAnimation()
    if self.identifyTreasureItemView then
        self.identifyTreasureItemView:refreshTriggerAnimation()
    end
end

return IdentifyTreasureItemController

