
--[[
    黑商物品信息
]]

require("app.datas.goods.GoodsData")
local GoodsData = Goods.GoodsData

local BlackShopData = class("BlackShopData",GoodsData)  
local LanguageManager = require "app.game.LanguageManager"
require "app.config.ConfigManager"

local GOODS_RARE = PublicDefine.GOODS_RARE
local ITEM_TYPE = PublicDefine.ITEM_TYPE
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE

Goods = Goods or {}

Goods.BlackShopData = BlackShopData

function BlackShopData:ctor(goodsID)
    BlackShopData.super.ctor(self, 0)
    self.goodsID = goodsID

    self.goodsRare = GOODS_RARE.RARE_WHITE_1
    self.isNew = false

    self.strengthenLevel = 0
    self.equipStrengthenMaxLv = 0

    self:equipTypeToIconAndCostType(self.goodsID)
end 

function BlackShopData:setPos(pos)
    self._pos = pos
end

function BlackShopData:setPrice(price)
    self.buyPrice = price
end

function BlackShopData:getPrice()
    return self.buyPrice
end

function BlackShopData:getPos()
    return self._pos
end

function BlackShopData:getIconName()
    return self.icon
end

function BlackShopData:initNetData()
    
end

function BlackShopData:getTypeName()
    return self.typeName
end

function BlackShopData:getStarData()
    local starData = {}

    starData.goldStar = 0
    starData.silverStar = 0

    return starData
end

function BlackShopData:equipTypeToIconAndCostType(type)
    local m = math.modf(type / 100)
    local n = type % 100
    print("BlackShopData:equipTypeToIconAndCostType type, m, n=", type, m, n)

    local iconName = "ui_shop_amulet.png"
    local typeName = ""

    if(n == 1) then
        iconName = "ui_shop_helm.png"
        typeID  = 1050223
    elseif (n == 2) then
        iconName = "ui_shop_armor.png"
        typeID  = 1050224
    elseif (n == 3) then
        iconName = "ui_shop_scapula.png"
        typeID  = 1050225
    elseif (n == 4) then
        iconName = "ui_shop_globe.png"
        typeID  = 1050226
    elseif (n == 5) then
        iconName = "ui_shop_boot.png"
        typeID  = 1050227
    elseif (n == 6) then
        iconName = "ui_shop_amulet.png"
        typeID  = 1050228
    elseif (n == 7) then
        iconName = "ui_shop_ring.png"
        typeID  = 1050229
    elseif (n == 8) then
        iconName = "ui_shop_weapon.png"
        typeID  = 1050230
    end

    self.icon = iconName
    self.typeName = LanguageManager:getInstance():getLocalString(typeID)

    if(m == 1) then
        self.costType = GOODS_COST_TYPE.GOLD
    elseif (m == 2) then
        self.costType = GOODS_COST_TYPE.GEM
    end
end
