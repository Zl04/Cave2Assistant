-- ExchangeActivityData.lua
-- Author:zp
-- 2019年2月26日
-- Using:集换活动之数据结构

require "app.datas.GameData"
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
local ExchangeActivityData = class("ExchangeActivityData")

Data = Data or {}
Data.ExchangeActivityData = ExchangeActivityData

function ExchangeActivityData:ctor()
    self.subID = 0;      --子活动ID
    self.costID = 0;     --消耗物品Id
    self.costNum = 0;    --消耗数量
    self.rewards = nil;  --兑换奖励
    self.totalMax = 6;   --总上限

    self._totalNum = 0
end

function ExchangeActivityData:init()

end

function ExchangeActivityData:initNet(data)
    self.subID = data.subID
    self.costID = data.costID
    self.costNum = data.costNum
    self.totalMax = data.totalMax
    self:_handleReward(data.rewards)
end

function ExchangeActivityData:clearCount()
    self._totalNum = 0;
end

function ExchangeActivityData:updateCount(data)
    -- print("ExchangeActivityData:updateCount", data)
    self._totalNum = data.totalNum;
end

function ExchangeActivityData:getKeyList()
    local keyList = {}

   return keyList
end

-- 判断是否没有获取
function ExchangeActivityData:checkNoGet(str)
    if(str == nil or str ~= "") then 
        return true 
    end

    return false
end

function ExchangeActivityData:updateLanguageKeyToStr()
    
end

function ExchangeActivityData:getCostID()
    return self.costID
end

function ExchangeActivityData:getCostNum()
    return self.costNum
end

function ExchangeActivityData:getTotalNum()
    return self._totalNum
end

function ExchangeActivityData:getIsReceiveEnd()
    -- print("ExchangeActivityData:getIsReceiveEnd =", self.totalMax, self._totalNum)
    if(self.totalMax ==0 or self.totalMax > self._totalNum) then 
        return false 
    end

    return true
end

function ExchangeActivityData:getIsComplete()
    return self:getIsReward()
end

function ExchangeActivityData:getIsReceive()
    return self:getIsReceiveEnd()
end

function ExchangeActivityData:getTotalMax()
    return self.totalMax
end

function ExchangeActivityData:getIsReward()
    if(self:getIsReceiveEnd() == false) then 
        local num = GameDataManager:getInstance():getGoodsDataNum(PublicDefine.PACKET_TYPE.PACKET_BAG, self.costID,true)
        if(num >= self.costNum) then 
            return true
        end
    end

    return false
end

function ExchangeActivityData:getID()
    return self.subID
end

function ExchangeActivityData:getRewards()
    return self.rewards
end

function ExchangeActivityData:_handleReward(rewards)
    if(rewards) then
        -- print("ExchangeActivityData:_handleReward =", rewards)
        self.rewards = {}
        for k,v in pairs(rewards) do 
            local rewardData = {}
            rewardData.id = v.id
            rewardData.num = v.num

            table.insert(self.rewards, rewardData)
        end
    end

    -- self:_handleTestReward()
end

function ExchangeActivityData:_handleTestReward()
    -- self.rewards = {}
    for i=1,5 do 
        local rewardData = {}
        rewardData.id = 21020050
        rewardData.num = 10
        rewardData.prop = 1
        rewardData.max = 100

        rewardData.dropNum = 2

        table.insert(self.rewards, rewardData)
    end
end


