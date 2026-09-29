
-- DiscountData.lua
-- Author:zp
-- 2017年12月19日
-- Using:打折信息

require "app.datas.GameData"

local DiscountData = class("DiscountData")

local DEBUG = false

Data = Data or {}
Data.DiscountData = DiscountData

function DiscountData:ctor()
    self.type = 0
    self.discount = 0
    self.limitNum = 0
    self.id = 0             --TYPE为猫饭时生效 填0为猫饭全局生效


end

function DiscountData:init()

end

function DiscountData:initNet(data)
    self.type = data.type
    self.discount = data.discount
    self.limitNum = data.limitNum
    self.id = data.id             --TYPE为猫饭时生效 填0为猫饭全局生效

    self.buyNum = 0
end

function DiscountData:clearCount()
    self.buyNum = 0
end

function DiscountData:updateCount(countData)
    if(DEBUG) then
        print("DiscountData:updateCount",countData)
        print("updateCount  start", self.limitNum, self.buyNum)
    end

    local update = true
    if(self.type == PublicDefine.DiscountType.DiscountType_CatFood) then
        if(self.id ~= countData.id) then 
            update = false
        end
    end

    if(update) then 
        self.buyNum = countData.buyNum
    end

    if(DEBUG) then
        print("updateCount  end", self.limitNum, self.buyNum)
    end
end

function DiscountData:getType()
    return self.type
end

function DiscountData:judgeToEffect()
    -- 判断是否可以使用
    if(self.limitNum > self.buyNum) then
        return true
    else
        return false
    end
end

function DiscountData:getDiscount()
    return self.discount
end

function DiscountData:getLimitNum()
    return self.limitNum
end

-- 获取购买次数
function DiscountData:getBuyNum()
    return self.buyNum
end

function DiscountData:getID()
    return self.id
end

