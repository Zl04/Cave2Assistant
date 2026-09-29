
-- FestivalExchangeShopData.lua
-- Author:zp
-- 2020年5月11日
-- Using:节日活动兑换数据

require "app.datas.GameData"

local FestivalExchangeShopData = class("FestivalExchangeShopData", GameData.Base)

Data = Data or {}
Data.FestivalExchangeShopData = FestivalExchangeShopData

function FestivalExchangeShopData:ctor(exchangeID)
    self.exchangeID = exchangeID
    self.exchangeNum = 0 -- 已经兑换次数
    self.exchangeVersion = 0 -- 兑换次数的版本
    self:conbinationLocalData()
end

function FestivalExchangeShopData:init()

end

function FestivalExchangeShopData:initNet(data)
    self.exchangeNum = data.num
end

function FestivalExchangeShopData:updateCount(data) 
    self.exchangeNum = data.purchasedCount
    self.exchangeVersion = data.version
end

function FestivalExchangeShopData:getID()
    return self.exchangeID
end

function FestivalExchangeShopData:getGoodsID()
    return self.goodsID
end

function FestivalExchangeShopData:getGoodsData()
    if(self.goodsData == nil) then 
        self.goodsData = GoodsDataManager:createLocalGoodsData(self:getGoodsID())
        self.goodsData:setIsNew(false)
        self.goodsData:setNum(self.goodsNum)
    end
    return self.goodsData
end

function FestivalExchangeShopData:getGoodsNum()
    return self.goodsNum
end

function FestivalExchangeShopData:getMaterialID()
    return self.materialID
end

function FestivalExchangeShopData:getMaterialData()
    if(self.materialData == nil) then 
        self.materialData = GoodsDataManager:createLocalGoodsData(self:getMaterialID())
        self.materialData:setIsNew(false)
    end
    return self.materialData
end

function FestivalExchangeShopData:getMaterialNum()
    return self.materialNum
end

function FestivalExchangeShopData:getExchangeLimit()
    return self.exchangeLimit
end

-- 获取是否可以兑换的状态
function FestivalExchangeShopData:getIsExchangeStatus()
    if(self.exchangeLimit > 0) then 
        if(self.exchangeNum >= self.exchangeLimit) then 
            return false
        end
    end

    return true
end

-- 获取剩余次数
function FestivalExchangeShopData:getHaveExchangeNum()
    -- print("getHaveExchangeNum=", self.exchangeLimit, self.exchangeNum)
    if(self.exchangeLimit > 0) then 
        if(self.exchangeVersion < self.version) then 
            return self.exchangeLimit
        else
            return self.exchangeLimit - self.exchangeNum
        end
    end

    return 99999
end

function FestivalExchangeShopData:conbinationLocalData()
    if (self.exchangeID ~= nil) then
        local localData = ConfigManager:getExchangeShopByID(self.exchangeID)
        if localData then
            self:initLocalData(localData)
        else
            printError(string.format("FestivalExchangeShopData:conbinationLocalData  %d no found local data ",self.exchangeID))
        end
    end
end

function FestivalExchangeShopData:initLocalData(data)
    self:setLocalConfigData(data)
end
-- data[6] = { ID = 6,  goodsID = 23120010,  goodsNum = 20,  materialID = 22040430,  materialNum = 200,  exchangeLimit = 1,  version = 1