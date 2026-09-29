
--[[
    物品属性定义
]]

require("app.config.ConfigManager")
require "app.datas.GameData"
require "app.game.GameDefine"

local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE
local GOODS_RARE = PublicDefine.GOODS_RARE

local GoodsData = class("GoodsData",GameData.Base)  

Goods = Goods or {}

Goods.GoodsData = GoodsData

function GoodsData:ctor(type)
    GoodsData.super.ctor(self,Category.GOODS,type)
    -- --名称 （本地）
    -- self.name = ""
    --物品编号 
    self.goodsID = -1
    --物品类型
    self.goodType = type
    -- 是否新装备
    self.isNew = true
    -- 是否洞穴新获得
    self.isInCaveNewGet = false
    -- 是否锁定
    self.isLock = false
    -- 是否船
    self.isBoat = false

    -- 买进价格
    self.buyPrice = 0
    -- 话费类型
    self.costType = GOODS_COST_TYPE.GOLD
    -- 默认初始化0个
    self.num = 0

    --显示使用,背包中道具变化数量，主要用于模拟拖动后的表现效果
    self._changeNum = 0
    -- 使用的数据，只能为正数
    self._useNum = 0
    --服务器下发的数据结构
    self.BytesData = nil

    --是否为大秘境获得
    self.isInDungeon = false

    --自己所在背包类型
    self._bagType = nil
end

-- 初始化洞穴商店
function GoodsData:initInCaveShop( goodsNo, goodsNum, goodsCostType, goodsCost)
    self.goodsNo = goodsNo
    self:setNum(goodsNum)
    self.buyPrice = goodsCost
    self.costType = goodsCostType

    self:conbinationLocalData()
end

-- 模版函数：
function GoodsData:getId()

	return self.goodsID
end
-- 获取物品ID
function GoodsData:getGoodsID()

    return self.goodsID
end

-- 获取物品类型
function GoodsData:getGoodsType()
    return self.goodType
end

-- 获取物品数量
function GoodsData:getNum()
    return self.num or 0
end

-- 设置物品数量
function GoodsData:setNum(num)

    self.num = num
end

-- 设置使用数量
function GoodsData:setUseNum(useNum)
    self._useNum = useNum
end

-- 获取使用数量
function GoodsData:getUseNum()
    return self._useNum or 0
end 

-- 获取改变数量
function GoodsData:getChangeNum()
    return self._changeNum or 0
end

-- 设置改变数量
function GoodsData:setChangeNum(changeNum)
    self._changeNum = changeNum
end

-- 获取改变数量
function GoodsData:getBagType()
    return self._bagType or 0
end

-- 设置改变数量
function GoodsData:setBagType(bagType)
    self._bagType = bagType
end
-- 获取物品稀有度
function GoodsData:getGoodsRare()
    if(self.goodsRare == 0) then
        assert(false, string.format("GoodsData:getGoodsRare  goodsID=%d, goodsRare=%d", self.goodsID, self.goodsRare))
        return 1
    end

    if(self.goodsRare == nil) then 
        return PublicDefine.GOODS_RARE.RARE_GOLDEN_3
    end

    local goodsRare = self.goodsRare
    if self.createLevel and self.createLevel > 0 then
        goodsRare = self.randomGoodsRare
    end
    return goodsRare
end 

-- 获取是否可以查看详情
function GoodsData:getCanBeView()
    -- body

    return true
end

-- 获取是否获得
function GoodsData:getWasGet()
    -- body

    return true
end

-- 物品类型
Game.GoodsType = {
    NONE = 0,
    EQUIPMENT = 1,   -- 装备
    ITEM = 2,       -- 道具
    MATERIAL = 3,   -- 材料
    VIRTUALITEM = 4,   -- 虚拟材料
}

-- 获取物品配置稀有度
function GoodsData:getGoodsConfigRare()
    local goodsType = self:getGoodsType()
    local config = nil
    if (goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM) then
        config = ConfigManager:getPropConfigByID(self:getId())
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then
        config = ConfigManager:getMaterialConfigByID(self:getId())
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then
        config = ConfigManager:getVirtualItemConfigByID(self:getId())
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
        config = ConfigManager:getEquipmentConfigByID(self:getId())
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
        config = ConfigManager:getGemStoneConfigByID(self:getId())
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then
        config = ConfigManager:getStarPrayConfigByID(self:getId())
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
        config = ConfigManager:getRelicConfigByID(self:getId())
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
        config = ConfigManager:getPetEquipmentConfigByID(self:getId())
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then
        config = ConfigManager:getPetGemstoneConfigByID(self:getId())
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then 
        config = ConfigManager:getGoodsTreasureConfigByID(self:getId())
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then 
        config = ConfigManager:getGlyphByID(self:getId())
    end

    if (config == nil) then 
        printError("=============GoodsData:getGoodsConfigRare, 获取配置稀有度信息错误!!!!!!!!", self:getId())
        return 0 
    end

    local goodsRare = config.goodsRare
    if self.createLevel and self.createLevel > 0 then
        goodsRare = self.randomGoodsRare
    end
    return goodsRare
end

function GoodsData:getGoodsGroupType()
    return self.equipGroupType or 0
end

-- 获取物品名字
function GoodsData:getName()
    return self.name
end
-- 获取物品描述
function GoodsData:getDescription()
    return self.description
end

-- 是否点金
function GoodsData:getIsGolden()
    return self.isGolden
end

-- 设置是否点金
function GoodsData:setIsGolden(isGolden)
    self.isGolden = isGolden
    if(self.isGolden and self.goodsRare < GOODS_RARE.RARE_GOLDEN_3) then
        self.goodsRare = GOODS_RARE.RARE_GOLDEN_3
    end

    if(self.isGolden and self.randomGoodsRare and self.randomGoodsRare < GOODS_RARE.RARE_GOLDEN_3) then
        self.randomGoodsRare = GOODS_RARE.RARE_GOLDEN_3
    end
end

-- 获取是否锁定
function GoodsData:getIsLock()
    return self.isLock
end

-- 设置是否解锁
function GoodsData:setIsLock(isLock)
    self.isLock = isLock
end

-- 获取是否是船
function GoodsData:getIsBoat()
    return self.isBoat
end

-- 设置是否是船
function GoodsData:setIsBoat(isBoat)
    self.isBoat = isBoat
end

-- 获取是否为新
function GoodsData:getIsNew()
    -- 处理是否为物品
    return self.isNew 
end

-- 判断是否可以卖或者销毁
function GoodsData:getIsSellOrDestory()
    return true
end

function GoodsData:setIsNew(flag)
    if flag ~= nil then
        self.isNew = flag
    end
end

-- 获取卖出价格
function GoodsData:getSellPrice()
    return self.sellPrice
end

-- 获取买的价格
function GoodsData:getBuyPrice()
    return self.buyPrice
end

-- 获取花费类型
function GoodsData:getCostType()
    return self.costType
end

function GoodsData:getGoodsNo()
    return self.goodsNo
end

-- 设置是否为在洞穴新获得
function GoodsData:setIsInCaveNewGet(flag)
    if flag ~= nil then
        self.isInCaveNewGet = flag
    end
end

-- 获取是否在洞穴新获得物品
function GoodsData:getIsInCaveNewGet()
    return self.isInCaveNewGet
end

-- 获取icon 名字
function GoodsData:getIconName()
    assert(false, "[ERROR] GoodsData:getIconName this method should be overrided by sub class.")
    return self.icon
end

-- 获取物品icon 小图标
function GoodsData:getSmallIconName()
    if self.miniIcon == nil or self.miniIcon == "" then
        if self.icon == "" or self.icon == nil then
            return self:_getIconName()
        end
        return self.icon
    end
    return self.miniIcon
end


--[[
    这里根据本地数据初始化，需要子类实现该方法
]]
function GoodsData:initLocalData(data)
    assert(false, "[ERROR] GoodsData:initLocalData this method should be overrided by sub class.")
end

--[[
    这里根据网络数据初始化数据，需要子类实现该方法
]]
function GoodsData:initNetData(netData,index)
    assert(false, "[ERROR] GoodsData:initNetData this method should be overrided by sub class.")
end

function GoodsData:print()
    print("goodsID,num,isGolden,isLock,isNew,isInCaveNewGet=",self.goodsID,self.num, self.isGolden,self.isLock,self.isNew,self.isInCaveNewGet)
end

function GoodsData:_getIconName()
    local id = (self.goodsID)/10
    local iconName = string.format("icon_%s.png",string.sub(string.format("%d", id), 2))
    return AvalonUtil.getHeXieSpriteFrameName(iconName)
end

function GoodsData:_getChaosIconName(equipId)
    local id = (equipId)/10
    local iconName = string.format("icon_%s.png",string.sub(string.format("%d", id), 2))
    return AvalonUtil.getHeXieSpriteFrameName(iconName)
end

function GoodsData:getUseArea()
    return self.useArea
end

function GoodsData:setBytesData(netData)
    self.BytesData =  netData
end

function GoodsData:getBytesData()
    return self.BytesData
end

function GoodsData:clearBytesData()
    self.BytesData = nil
end

function GoodsData:isInDungeon()
    return self.isInDungeon
end

function GoodsData:isUseInMaze()
    return false
end

function GoodsData:isMazeMark()
    return false
end
