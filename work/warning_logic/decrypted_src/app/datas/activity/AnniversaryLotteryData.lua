
-- AnniversaryLotteryData.lua
-- Author:djh
-- 2022年3月5日
-- Using:周年庆抽奖

require "app.datas.GameData"
local ProtobufUtil = require "utils.ProtobufUtil"

local AnniversaryLotteryData = class("AnniversaryLotteryData")

Data = Data or {}
Data.AnniversaryLotteryData = AnniversaryLotteryData

function AnniversaryLotteryData:ctor()
    self.ID = nil
    self.signEndTime = nil -- 报名结束时间
    self.signType = nil -- 报名方式
    self.chatContent = nil -- 聊天内容
    self.giftID = nil -- 购买礼物id
    self.actId = nil -- 关联活动id
    self.successRwds = {}  -- 抽中奖励
    self.failRwds = {}  -- 未抽中奖励
    self.drawNum = 0  -- 抽中人数

    --进度数据
    self.rewardState = 0    --抽奖状态
    self.isGetReward = false    --是否已领奖
    self.isReadRewardResult = false  --刷新次数
    self.isSign = false    --是否已报名
end

function AnniversaryLotteryData:init()

end

function AnniversaryLotteryData:initNet(actID, data)
    self.ID = actID
    self.signEndTime = data.signEndTime -- 报名结束时间
    self.signType = data.signType -- 报名方式
    self.chatContent = data.chatContent -- 聊天内容
    self.giftID = data.giftID -- 购买礼物id
    self.actId = data.actId -- 关联活动id
    self.successRwds = data.successRwds  -- 抽中奖励
    self.failRwds = data.failRwds -- 未抽中奖励
    self.drawNum = data.drawNum  -- 抽中人数
end

function AnniversaryLotteryData:clearCount()
    self.rewardState = 0    --抽奖状态
    self.isGetReward = false    --是否已领奖
    self.isReadRewardResult = false  --是否已阅读抽奖结果
    self.isSign = false    --是否已报名
end

function AnniversaryLotteryData:initCount(data)
    self.rewardState = data.rewardState  --抽奖状态
    self.isGetReward = data.isGetReward    --是否已领奖
    self.isReadRewardResult = data.isReadRewardResult  --是否已阅读抽奖结果
    self.isSign = data.isSign    --是否已报名
end

function AnniversaryLotteryData:updateCount(data)
    local oldRewardState = clone(self.rewardState)
    local oldIsSign = clone(self.isSign)
    self.rewardState = data.rewardState or self.rewardState
    self.isGetReward = data.isGetReward or self.isGetReward
    self.isReadRewardResult = data.isReadRewardResult or self.isReadRewardResult
    self.isSign = data.isSign or self.isSign

    if oldIsSign ~= data.isSign and data.isSign == true then
        UI.ScrollBar:createByText(UI.TEXT_223612) 
    end

    if oldRewardState ~= data.rewardState and oldRewardState == 0 and data.isSign then
        data.ID = self.ID
        data.signType = self.signType
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ACTIVITY_ANNIVERSARY_SHOW_LOTTERY_REWARD, data) 
    end

    mvc.send("ActivityAnnivesary_refresh_Lottery_View")
end
