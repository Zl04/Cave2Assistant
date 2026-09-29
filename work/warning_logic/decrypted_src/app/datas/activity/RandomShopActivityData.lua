-- RandomShopActivityData.lua
-- Author:zp
-- 2018年10月18日
-- Using:随机商店数据结构

require "app.datas.GameData"

local RandomShopActivityData = class("RandomShopActivityData")

Data = Data or {}
Data.RandomShopActivityData = RandomShopActivityData

function RandomShopActivityData:ctor()
    self.refreshNum = 0
    self.costDiamond = 0
    -- 已经刷新次数
    self.useNum = 0
end

function RandomShopActivityData:init()

end

function RandomShopActivityData:initNet(data)
    self.refreshNum = data.refreshNum
    self.costDiamond = data.costDiamond
end

function RandomShopActivityData:clearCount()
    self.useNum = 0
end

function RandomShopActivityData:judgeToEffect()
    -- 判断是否可以使用
    if(self.refreshNum > self.useNum) then
        return true
    else
        return false
    end
end

function RandomShopActivityData:getRefreshNum()
    return self.refreshNum
end

function RandomShopActivityData:getCostDiamond()
    return self.costDiamond
end

function RandomShopActivityData:setUseNum(useNum)
    self.useNum = useNum
end

function RandomShopActivityData:getUseNum()
    return self.useNum
end
