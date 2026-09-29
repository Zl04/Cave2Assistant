-- ExtraDropData.lua
-- Author:zp
-- 2017年12月18日
-- Using:额外掉落活动子类数据

require "app.datas.GameData"
local LanguageManager = require("app.game.LanguageManager")

local ExtraDropData = class("ExtraDropData")

Data = Data or {}
Data.ExtraDropData = ExtraDropData

function ExtraDropData:ctor()
    self.id = 0
    self.type = 0
    self.targetID = 0
    self.count = 0
    self.rewards = nil
    self.jumpID = 0

    self.jumpStr = nil

    -- 统计数量
    self._totalNum = 0
    -- 领奖数量
    self._rewardNum = 0
end

function ExtraDropData:init()

end

function ExtraDropData:initNet(data)
    self.id = data.id
    self.type = data.type
    self.targetID = data.targetID
    self.count = data.count
    -- self.rewards = data.rewards
    self:_handleReward(data.rewards)
    self.jumpID = data.jumpID
end

function ExtraDropData:clearCount()
    self._totalNum = 0

    for _,reward in ipairs(self.rewards) do 
        reward.dropNum = 0
    end
end

function ExtraDropData:updateCount(data)
    -- print("ExtraDropData:updateCount", data)
    self._totalNum = data.count
    for k,dropData in ipairs(data.drops) do 
        for _,reward in ipairs(self.rewards) do 
            if(reward.id == dropData.id) then 
                reward.dropNum = dropData.dropNum
                break
            end
        end
    end
end

function ExtraDropData:getKeyList()
    local keyList = {}

    if self.jumpID ~= nil and self.jumpID ~= 0 and self:checkNoGet(self.jumpStr) then
        table.insert(keyList, self.jumpID)
    end

   return keyList
end

-- 判断是否没有获取
function ExtraDropData:checkNoGet(str)
    if(str == nil or str ~= "") then 
        return true 
    end

    return false
end

function ExtraDropData:updateLanguageKeyToStr()
    self.jumpStr = LanguageManager:getInstance():getLanguageWebStrForKey(self.jumpID)
end

function ExtraDropData:getID()
    return self.id
end

function ExtraDropData:getIsComplete()
    return self._isComplete
end

function ExtraDropData:getType()
    return self.type
end

function ExtraDropData:getLittleType()
    return self.targetID
end

function ExtraDropData:getRewards()
    return self.rewards
end

function ExtraDropData:getJumpStr()
    return self.jumpStr
end

function ExtraDropData:_handleReward(rewards)
    if(rewards) then
        -- print("ExtraDropData:_handleReward =", rewards)
        self.rewards = {}
        for k,v in pairs(rewards) do 
            local rewardData = {}
            rewardData.id = v.id
            rewardData.num = v.num
            rewardData.prop = v.prop
            rewardData.max = v.max

            rewardData.dropNum = 0

            table.insert(self.rewards, rewardData)
        end
    end

    -- self:_handleTestReward()
end

function ExtraDropData:_handleTestReward()
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


