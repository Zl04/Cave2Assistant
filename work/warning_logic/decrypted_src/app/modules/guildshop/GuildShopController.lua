--[[--
控制器GuildShopController，view已经注入,可以通过mvc.guildShopProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: CMonk
-- date	: 2019/05/28
-- desc	: 
------------------------------------------------------------------------------
require "app.datas.RoleDataManager"
local ProtobufUtil = require("utils.ProtobufUtil")

local GuildShopController = class("GuildShopController", mvc.GameController)

function GuildShopController:onContribChange(oldContrib, newContrib)
    self:refreshView()
end

-- mvc.events.GuildShop_Npc_Response_Guild_Shop_Buy 处理函数
function GuildShopController:noticeGuildShopNpcResponseGuildShopBuy(notification)
    -- 更新数据
    local data = notification.params[1]
    mvc.guildShopModel:updateBuyInfoFromServer(data)

    -- 更新公会科技等级数据
    require "app.datas.MasterDataManager"
    local guildData = MasterDataManager:getGuildData()
    if (guildData) then 
        guildData:changeTotalTechLv(data.guildTechLv)
    end

    -- 处理成功失败数据
    self:processBuyResult(data.result)

    self.guildShopView:initAllRandomData()

    -- 更新展现
    self:refreshView()
end

-- 刷新展现
function GuildShopController:refreshView()
    -- 更新展现
    mvc.guildShopModel:refreshItemData()
    if (self.guildShopView) then
        -- 更新列表数据
        local dataToDisplay = mvc.guildShopModel:getDisplayItemArr()
        self.guildShopView:updateItemData(dataToDisplay)

        -- 更新贡献
        local masterData = RoleDataManager:getMaster()
        local contribNum = masterData:getGuildContrib()
        self.guildShopView:updateContrib(contribNum)
    end
end

-- 处理成功或者失败
function GuildShopController:processBuyResult(result)
    if (result == ProtobufUtil:enum_id("NPCSystem.BuyGuildGoodsResultType", "BuyGuildGoodsResultType_Suc")) then 
        if (self.ignoreSuccessOnce) then 
            self.ignoreSuccessOnce = false
            return 
        end
        UI.ScrollBar:createByTextID(1110688)
    elseif (result == ProtobufUtil:enum_id("NPCSystem.BuyGuildGoodsResultType", "BuyGuildGoodsResultType_RefreshSuc")) then 
        -- 商店2、3自动刷新时无需额外处理
    else
        GameErrorManager:showError(result)
        -- UI.ScrollBar:createByTextID(1111118)
    end
end

-- 请求刷新数据
function GuildShopController:requestNewInfo(npcID, _shopType)
    self.ignoreSuccessOnce = true
    local shopType = _shopType and _shopType or 1
    Net.NetNPCSystem:requestGuildShopBuy(0, 0, 0, shopType, npcID)
end



-- 请求购买道具
function GuildShopController:requestBuyItem(id, shopType, npcID)
    -- 检查道具信息
    mvc.guildShopModel:refreshItemData()
    local itemInfo = mvc.guildShopModel:getItemFromID(id)
    if (not itemInfo) then return end

    -- 检查库存
    if (itemInfo.leftNum == nil or itemInfo.leftNum <= 0) then return end

    -- 检查消耗数据
    local masterData = RoleDataManager:getMaster()
    local contribNum = masterData:getGuildContrib()
    if (not masterData or not contribNum or itemInfo.consume == nil or itemInfo.consume > contribNum) then return end

    -- 检查是否弹出数量框
    if (math.floor(contribNum / itemInfo.consume) == 1 or itemInfo.leftNum <= 1) then
        Net.NetNPCSystem:requestGuildShopBuy(id, 1, 0, shopType, npcID)
    else
        local maxAmount = math.min(math.floor(contribNum / itemInfo.consume), itemInfo.leftNum)
        UI.TipsLayer:onBuyAmount(function(number)   -- 确认回调
            Net.NetNPCSystem:requestGuildShopBuy(id, number, 0, shopType, npcID)
        end, nil, itemInfo.consume, PublicDefine.GOODS_COST_TYPE.GUILD_CONTRIB, maxAmount, false)
    end
end

-- mvc.events.GuildShop_Npc_Response_Guild_Random_Shop_Buy 处理函数
function GuildShopController:noticeGuildShopNpcResponseGuildRandomShopBuy(notification)
    local data = notification.params[1]
    mvc.guildShopModel:updateRandomShopData(data)
    if(data and data.result ~= 1 and data.result ~= 3) then 
        GameErrorManager:showError(data.result)
    end

    if self.guildShopView then
        self.guildShopView:beginStock(data.shopType)
    end
    -- 更新展现
    self:refreshView()
end



return GuildShopController