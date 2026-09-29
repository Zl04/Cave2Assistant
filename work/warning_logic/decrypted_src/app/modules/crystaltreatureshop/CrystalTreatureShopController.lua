--[[--
控制器CrystalTreatureShopController，view已经注入,可以通过mvc.crystalTreatureShopProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: siyu.lin
-- date	: 2023/04/23
-- desc	: 
------------------------------------------------------------------------------
local CrystalTreatureShopController = class("CrystalTreatureShopController", mvc.GameController)

-- 请求购买道具
function CrystalTreatureShopController:requestBuyItem(id, storeType)
    -- -- 检查道具信息
    -- mvc.guildShopModel:refreshItemData()
    -- local itemInfo = mvc.guildShopModel:getItemFromID(id)
    -- if (not itemInfo) then return end

    -- -- 检查库存
    -- if (itemInfo.leftNum == nil or itemInfo.leftNum <= 0) then return end

    -- -- 检查消耗数据
    -- local masterData = RoleDataManager:getMaster()
    -- local contribNum = masterData:getGuildContrib()
    -- if (not masterData or not contribNum or itemInfo.consume == nil or itemInfo.consume > contribNum) then return end

    -- -- 检查是否弹出数量框
    -- if (math.floor(contribNum / itemInfo.consume) == 1 or itemInfo.leftNum <= 1) then
    --     Net.NetNPCSystem:requestGuildShopBuy(id, 1, 0, shopType, npcID)
    -- else
    --     local maxAmount = math.min(math.floor(contribNum / itemInfo.consume), itemInfo.leftNum)
    --     UI.TipsLayer:onBuyAmount(function(number)   -- 确认回调
    --         Net.NetNPCSystem:requestGuildShopBuy(id, number, 0, shopType, npcID)
    --     end, nil, itemInfo.consume, PublicDefine.GOODS_COST_TYPE.GUILD_CONTRIB, maxAmount, false)
    -- end

    Net.NetRoleSystem:sendStoreBuyGoodsMessage(PublicDefine.StoreType.StoreType_CrystalTreature, id)
end

return CrystalTreatureShopController

