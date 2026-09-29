
-- CaveActivityData.lua
-- Author:zp
-- 2019年1月7日
-- Using:副本活动

require "app.datas.GameData"
require "app.datas.activity.LuckyWheelData"

local CaveActivityData = class("CaveActivityData")

Data = Data or {}
Data.CaveActivityData = CaveActivityData

function CaveActivityData:ctor()
    self.limitNum = 0   -- 如果没有次数限制设定0 
    self.caveID = 0     -- 副本ID
    self.dropGoods = {}
    self.rankReward = {}

    self.rank = 0           -- 排名
    self.costNum = 0        -- 使用次数

--         message CaveRankReward {
--    required uint32 rankStart = 1;
--    required uint32 randEnd = 2;
--    repeated Goods rewards = 3;
-- }
-- //副本活动内容
-- message CaveActivityData {
--     required uint32 limitNum = 1;  // 如果没有次数限制设定0 
--     required uint32 caveID = 2;   //副本ID
--     repeated Goods probDrop = 3;   //可能掉落
--     repeated CaveRankReward rankReward = 4; //排行奖励
-- }
end

function CaveActivityData:init()

end

function CaveActivityData:initNet(data)
    self.limitNum = data.limitNum    -- 如果没有次数限制设定0 
    self.caveID = data.caveID        -- 副本ID
    self:_handlePropDrop(data.probDrop)
    self:_handleRankReward(data.rankReward)
end

function CaveActivityData:clearCount()
    self.rank = 0               -- 排名
    self.costNum = 0        -- 使用次数
end

function CaveActivityData:updateCount(data)
    print("CaveActivityData:updateCount", data)
    self.rank = data.rank               -- 排名
    self.costNum = data.costNum        -- 使用次数
end

function CaveActivityData:getLimitNum()
    return self.limitNum
end

function CaveActivityData:getCostNum()
    return self.costNum
end

function CaveActivityData:getRankReward()
    return self.rankReward
end

function CaveActivityData:getDropGoods()
    return self.dropGoods
end

function CaveActivityData:_handlePropDrop(propDrop)
    self.dropGoods = {}
    if(probDrop) then 
        for k,v in pairs(propDrop) do 
            local drop = {}
            drop.id = v.id
            drop.num = v.num

            table.insert(self.dropGoods, drop)
        end
    end
end 

function CaveActivityData:_handleRankReward(rewards)
    self.rankReward = {}

    if(rewards) then
        for k,v in pairs(rewards) do 
            local rewardData = {}
            rewardData.rankStart = v.rankStart
            rewardData.randEnd = v.randEnd
            rewardData.rewards = {}
            for k,v in pairs(v.rewards) do 
                local reward = {}
                reward.id = v.id
                reward.num = v.num

                table.insert(rewardData.rewards, reward)
            end 

            table.insert(self.rankReward, rewardData)
        end

        table.sort(self.rankReward, function(a,b)
            if(a.rankStart == b.rankStart) then 
                return true
            end

            if(a.rankStart < b.rankStart) then 
                return true
            end

            return false
        end)
    end
end