--[[
    宝藏道具属性定义
]]

require("app.datas.goods.GoodsData")
local GoodsData = Goods.GoodsData

local GoodsTreasureData = class("GoodsTreasureData",GoodsData)  
local LanguageManager = require "app.game.LanguageManager"
require "app.config.ConfigManager"

local MATERIAL_TYPE = PublicDefine.MATERIAL_TYPE

Goods = Goods or {}

Goods.GoodsTreasureData = GoodsTreasureData

local GOODS_RARE = PublicDefine.GOODS_RARE

function GoodsTreasureData:ctor(goodsID)
    GoodsTreasureData.super.ctor(self,PublicDefine.GOODS_TYPE.GOODS_TREASURE)

    self.goodsID = goodsID
    self.num = 0
    self.isGolden = false
    self.materialType = 0
    self:conbinationLocalData()
    self:_refreshMaterialType()

end 

-- 获取物品名字
function GoodsTreasureData:getName()

    return LanguageManager:getInstance():getLocalString(self.name)
end

function GoodsTreasureData:getDescription()
    return LanguageManager:getInstance():getLocalString(self.description)
end

function GoodsTreasureData:getIconName()
    if self.icon == nil or self.icon == "" then
        self.icon = self:_getIconName()
    end

    return self.icon
end

function GoodsTreasureData:getNum()
    if self.num == nil then
        return 0
    end
    return self.num;
end

-- 获取材料类型
function GoodsTreasureData:getMaterialType()
    return self.materialType
end

-- 获取堆叠数量
function GoodsTreasureData:getStackNum()
    return self.stackNum
end


function GoodsTreasureData:initLocalData(data)
    self:setLocalConfigData(data)
end

function GoodsTreasureData:initNetData(num,isGolden,isLock)
    local oldGoodsID = self.goodsID
    self.goodsRare = nil
    self.num = num
    self.isGolden = isGolden
    self.isLock = isLock

    -- 处理装备的初始化处理
    if oldGoodsID ~= self.goodsID then
        self:conbinationLocalData()
    end

    if self.isGolden == true and self.goodsRare < GOODS_RARE.RARE_GOLDEN_3 then
        self.goodsRare = GOODS_RARE.RARE_GOLDEN_3
    end
end

function GoodsTreasureData:conbinationLocalData()
    if (self.goodsID ~= -1) then
        local localData = ConfigManager:getGoodsTreasureConfigByID(self.goodsID)
        if localData then
            self:initLocalData(localData)
        else
            assert(false, string.format("GoodsTreasureData:conbinationLocalData  goodsID=%d no found local data ",self.goodsID))
        end
    end
end

-- 获取详细描述信息
function GoodsTreasureData:getDetailDescription()
    -- enchantingAttributeType = {21,22},  enchantingAttributeLV = {2,1},  enchantingSuccessProb = {10,5},  enchantingAttributeDescription = {1101001,1101002},
    local desArr = {}
    if(self.enchantingAttributeDescription) then
        local str = LanguageManager:getInstance():getLocalString(self.enchantingAttributeDescription)
        table.insert(desArr,str)
    else
        table.insert(desArr, "")
        print(string.format("ID=%d GoodsTreasureData enchantingAttributeDescription not found ID", self.goodsID))
    end

    return desArr
end

function GoodsTreasureData:_refreshMaterialType()
    -- 计算材料类型
    if self.goodsID then
        self.materialType = self:calculateMaterialType(self.goodsID)
        return
    end

    assert(false, "MaterialData:_refreshMaterialType self.goodsID is nil.")
end

function GoodsTreasureData:calculateMaterialType(goodsID)
    local equipType = math.modf(goodsID / 10000)
    if equipType >= 5001 or equipType < 5009 then
        return MATERIAL_TYPE.MaterialTreasure
    else
        assert(false, string.format("MaterialData:_refreshMaterialType  error goodsID=%d",self.goodsID))
    end
end