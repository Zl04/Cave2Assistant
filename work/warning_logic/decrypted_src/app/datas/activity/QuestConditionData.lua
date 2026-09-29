-- QuestConditionData.lua
-- Author:zp
-- 2017年12月18日
-- Using:任务条件活动子类数据

require "app.datas.GameData"

local LanguageManager = require("app.game.LanguageManager")
local QuestConditionData = class("QuestConditionData")
local ProtobufUtil = require "utils.ProtobufUtil"

Data = Data or {}
Data.QuestConditionData = QuestConditionData

function QuestConditionData:ctor()
    self.id = 0
    self.type = 0
    self.targetID = 0
    self.count = 0
    self.rewards = nil
    self.jumpID = 0
    self.targetExt = ""  -- 额外目标字段
    self.guildCount = 0  -- 公会目标数量

    self.jumpStr = nil
    self._totalNum = 0     -- 完成进度
    self.isReward = false   -- 是否已经领取，是否完成通过进度
    self.guildTotalNum = 0 -- 公会完成进度

    -- 限时登录任务生效时间
    self.startTime = 0
    -- 限时登录任务失效时间
    self.endTime = 0
    self.activityId = 0
end

function QuestConditionData:init()

end

function QuestConditionData:initNet(data, activityId)
    self.id = data.id
    self.type = data.type
    self.targetID = data.targetID
    self.count = data.count
    -- self.rewards = data.rewards
    self:_handleReward(data.rewards)
    self.jumpID = data.jumpID
    if ProtobufUtil:checkFieldIsInit(data, "targetExt") then
        self.targetExt = data.targetExt
    end
    -- 公会目标数量
    if ProtobufUtil:checkFieldIsInit(data, "guildCount") then
        self.guildCount = data.guildCount
    end 

    -- 任务生效时间
    if ProtobufUtil:checkFieldIsInit(data, "startTime") then
        self.startTime = data.startTime
    end 

    -- 任务失效时间
    if ProtobufUtil:checkFieldIsInit(data, "endTime") then
        self.endTime = data.endTime
    end 
    self.activityId = activityId
end

function QuestConditionData:clearCount()
    self._totalNum = 0
    self.isReward = false
end

function QuestConditionData:updateCount(data)
    self._totalNum = data.count
    self.isReward = data.isReward
end

function QuestConditionData:updateGuildCount(data)
    self.guildTotalNum = data.count
end

function QuestConditionData:clearGuildCount()
    self.guildTotalNum = 0
end

function QuestConditionData:getKeyList()
    local keyList = {}

    if self.jumpID ~= nil and self.jumpID ~= 0 and self:checkNoGet(self.jumpStr) then
        table.insert(keyList, self.jumpID)
    end

   return keyList
end

-- 判断是否没有获取
function QuestConditionData:checkNoGet(str)
    if(str == nil or str ~= "") then 
        return true 
    end

    return false
end

function QuestConditionData:updateLanguageKeyToStr()
    self.jumpStr = LanguageManager:getInstance():getLanguageWebStrForKey(self.jumpID)
end

function QuestConditionData:getID()
    return self.id
end

function QuestConditionData:getTargetVersion()
    return self.targetExt
end

function QuestConditionData:getTotalNum()
    return self._totalNum 
end

function QuestConditionData:getMaxNum()
    return self.count
end

function QuestConditionData:getGuildTotalNum()
    return self.guildTotalNum 
end

function QuestConditionData:getGuildMaxNum()
    return self.guildCount
end

function QuestConditionData:getIsReceive()
    return self.isReward
end

function QuestConditionData:setIsReward(isReward)
    self.isReward = isReward
end

function QuestConditionData:getIsComplete()
    if (self:getType() == PublicDefine.QuestConditionType.QuestConditionType_Version) then 
        if(self.targetExt == "") then
            -- 这里为容错处理
            return false
        else 
            return AvalonUtil.isClientPackageVersionEqualOrGreaterThan(self.targetExt)
        end
    end
    
    if(self._totalNum >= self.count and self.guildTotalNum >= self.guildCount) then
        return true 
    end

    return false
end

function QuestConditionData:getType()
    return self.type
end

function QuestConditionData:getLittleType()
    return self.targetID
end

function QuestConditionData:getRewards()
    return self.rewards
end

function QuestConditionData:getJumpStr()
    return self.jumpStr
end

function QuestConditionData:_handleReward(rewards)
    if(rewards) then
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

function QuestConditionData:_handleTestReward()
    -- self.rewards = {}
    for i=1,5 do 
        local rewardData = {}
        rewardData.id = 21020050
        rewardData.num = 1

        table.insert(self.rewards, rewardData)
    end
end

