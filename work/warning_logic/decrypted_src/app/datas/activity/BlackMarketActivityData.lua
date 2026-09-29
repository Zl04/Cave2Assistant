-- BlackMarketActivityData.lua
-- Author:zp
-- 2017年12月19日
-- Using:黑商活动数据结构

require "app.datas.GameData"

local BlackMarketActivityData = class("BlackMarketActivityData")

Data = Data or {}
Data.BlackMarketActivityData = BlackMarketActivityData

function BlackMarketActivityData:ctor()
    self.refreshNum = 0
    self.costDiamond = 0
    -- 已经刷新次数
    self.useNum = 0
end

function BlackMarketActivityData:init()

end

function BlackMarketActivityData:initNet(data)
    self.refreshNum = data.refreshNum
    self.costDiamond = data.costDiamond

    -- print("BlackMarketActivityData:initNet", data)
end

function BlackMarketActivityData:clearCount()
    self.useNum = 0
end

function BlackMarketActivityData:judgeToEffect()
    -- 判断是否可以使用
    if(self.refreshNum > self.useNum) then
        return true
    else
        return false
    end
end

function BlackMarketActivityData:getRefreshNum()
    return self.refreshNum
end

function BlackMarketActivityData:getCostDiamond()
    return self.costDiamond
end

function BlackMarketActivityData:setUseNum(useNum)
    self.useNum = useNum
end

function BlackMarketActivityData:getUseNum()
    return self.useNum
end
