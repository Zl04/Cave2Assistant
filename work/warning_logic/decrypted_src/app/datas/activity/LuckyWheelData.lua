
-- LuckyWheelData.lua
-- Author:zp
-- 2017年12月19日
-- Using:抽奖活动单个奖励物品信息

require "app.datas.GameData"

local LuckyWheelData = class("LuckyWheelData")

Data = Data or {}
Data.LuckyWheelData = LuckyWheelData

function LuckyWheelData:ctor()
    self.id = 0
	self.num = 0
	self.prob = 0             --权重
end

function LuckyWheelData:init()

end

function LuckyWheelData:initNet(data)
    self.id = data.id
	self.num = data.num
	self.prob = data.prob             --权重
end

