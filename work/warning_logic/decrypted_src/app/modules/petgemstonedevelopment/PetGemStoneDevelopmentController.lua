--[[--
控制器PetGemStoneDevelopmentController，view已经注入,可以通过mvc.petGemStoneDevelopmentProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2023/02/09
-- desc	: 
------------------------------------------------------------------------------
local PetGemStoneDevelopmentController = class("PetGemStoneDevelopmentController", mvc.GameController)

-- showAnimationType = 0 不显示动画,直接刷新, 1 开孔动画 , 2镶嵌宝石动画
function PetGemStoneDevelopmentController:refreshLeftView(showAnimationType, equipmentData,slotIndex)
    if self.petGemStoneDevelopmentView then
        self.petGemStoneDevelopmentView:updateGoodsData(equipmentData)
        self.petGemStoneDevelopmentView:refreshHole(showAnimationType,slotIndex)
    end
end

function PetGemStoneDevelopmentController:refreshLeftViewTwo(goodsData)
    if self.petGemStoneDevelopmentView then
        --self.petGemStoneDevelopmentView:updateGoodsData(goodsData)
        self.petGemStoneDevelopmentView:refreshDevourModule(true)
        self.petGemStoneDevelopmentView:updateGoodsData(goodsData)
        self.petGemStoneDevelopmentView:cancelDevour()
    end
end

function PetGemStoneDevelopmentController:refreshStoneTriggerAnimation(goodsData)
    if self.petGemStoneDevelopmentView then
        self.petGemStoneDevelopmentView:updateGoodsData(goodsData)
        self.petGemStoneDevelopmentView:refreshStoneTriggerAnimation()
        self.petGemStoneDevelopmentView:cancelDevour()
    end
end

function PetGemStoneDevelopmentController:refreshConvertTriggerAnimation(goodsDataArr)
    if self.petGemStoneDevelopmentView then
        self.petGemStoneDevelopmentView:updateGoodsData()
        self.petGemStoneDevelopmentView:refreshConvertTriggerAnimation(goodsDataArr)
        --self.petGemStoneDevelopmentView:cancelDevour()
    end
end

function PetGemStoneDevelopmentController:refreshConvertTriggerEndAnimation(goodsData)
    if self.petGemStoneDevelopmentView then
        --self.petGemStoneDevelopmentView:updateGoodsData(goodsData)
        self.petGemStoneDevelopmentView:choseConvertEndRefresh(goodsData)
    end
end

function PetGemStoneDevelopmentController:refreshConvertTriggerEndAnimation2(goodsData)
    if self.petGemStoneDevelopmentView then
        --self.petGemStoneDevelopmentView:updateGoodsData(goodsData)
        self.petGemStoneDevelopmentView:choseConvertEndRefresh2(goodsData)
    end
end

function PetGemStoneDevelopmentController:saveConvertChoseData(Data)
    if self.petGemStoneDevelopmentView then
        self.petGemStoneDevelopmentView:saveConvertChoseData(Data)
    end
end

return PetGemStoneDevelopmentController

