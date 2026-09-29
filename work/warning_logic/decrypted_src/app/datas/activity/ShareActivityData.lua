
-- ShareActivityData.lua
-- Author:llf
-- 2021年3月5日
-- Using:分享活动

require "app.datas.GameData"
local ProtobufUtil = require "utils.ProtobufUtil"

local ShareActivityData = class("ShareActivityData")

Data = Data or {}
Data.ShareActivityData = ShareActivityData

function ShareActivityData:ctor()
    self.pictureLink = nil -- 分享链接
    self.shareRewards = nil -- 分享奖励
    self.shareTime = nil -- 上次分享时间
    self.claimTime = nil -- 上次领取奖励时间

end

function ShareActivityData:init()

end

function ShareActivityData:initNet(actID, data)
    self.pictureLink = data.pictureLink
    self.shareRewards = data.rewards
end

function ShareActivityData:getRewards()
    return self.shareRewards
end

function ShareActivityData:getPictureLink()
    return self.pictureLink
end

function ShareActivityData:initCount(data)
    self.shareTime = data.shareTime
    self.claimTime = data.claimTime
end

function ShareActivityData:updateCount(data)
    self.shareTime = data.shareTime
    self.claimTime = data.claimTime
end

--是否有奖励可领
function ShareActivityData:isHaveAward()
    local serverTime = GameManager:getNormalServerTime()
    local serverDay = math.floor(serverTime / 86400)
    local shareDay = math.floor(self.shareTime / 86400)
    local claimDay = math.floor(self.claimTime / 86400)
    local isR = false

    -- print("@@@@@@CAOCAO  ==== " ,serverTime,serverDay,shareDay,claimDay)

    if (serverDay == shareDay and shareDay > claimDay) then
        isR = true
    end

    return isR
end

--是否可以领取奖励,并且已经领取
function ShareActivityData:getIsReceiveEnd()
    local serverTime = GameManager:getNormalServerTime()
    local serverDay = math.floor(serverTime / 86400)
    local shareDay = math.floor(self.shareTime / 86400)
    local claimDay = math.floor(self.claimTime / 86400)
    local isR = false

    if (serverDay == shareDay and shareDay == claimDay) then
        isR = true
    end

    return isR
end

function ShareActivityData:clearCount()
    -- self.gotReward = false
    -- self.pictureLink = nil -- 分享链接
    -- self.shareRewards = nil -- 分享奖励
    -- self.shareTime = nil -- 上次分享时间
    -- self.claimTime = nil -- 上次领取奖励时间
end
