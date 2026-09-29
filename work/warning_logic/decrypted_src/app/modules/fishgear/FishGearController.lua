--[[--
控制器FishGearController，view已经注入,可以通过mvc.fishGearProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2022/04/13
-- desc	: 
------------------------------------------------------------------------------
local FishGearController = class("FishGearController", mvc.GameController)

-- mvc.events.Fishing_Shop_Buy_Result_Handler 处理函数
function FishGearController:noticeFishingShopBuyResultHandler(notification, data)
    -- local cfg = NewConfig.DreamVault:getDataById(data.id)
    if not data.goodsID then
        print("FishGearShop buy error result data = ", data)
        return
    end
    local num = mvc.fishGearModel:getBuyGoodsNum()
    local itemId = data.goodsID
    local number = num
    local itemData = {}
    local goodData = GoodsDataManager:createLocalGoodsData(itemId)
    if (goodData) then
        goodData:setIsNew(false)
        goodData:setNum(number)
        table.insert(itemData, goodData)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD,itemData)
        -- Avalon.MessageCenter:notice(GameMessage.MC_REFRESH_FISHING_GEAR_SHOP_MONEY)
        -- mvc.fishGearShopView:updateMoneyView()
    end
end



return FishGearController
