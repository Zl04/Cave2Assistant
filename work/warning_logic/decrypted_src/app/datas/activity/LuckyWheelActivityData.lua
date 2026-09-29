
-- LuckyWheelActivityData.lua
-- Author:zp
-- 2017年12月19日
-- Using:抽奖活动内容

require "app.datas.GameData"
require "app.datas.activity.LuckyWheelData"

local LuckyWheelActivityData = class("LuckyWheelActivityData")

Data = Data or {}
Data.LuckyWheelActivityData = LuckyWheelActivityData

function LuckyWheelActivityData:ctor()
    self.refreshNum = 0
    self.costDiamond = 0
    self.drops = {}

    -- 买了多少次
    self._buyNum = 0
    -- 剩余使用次数
    self._leftTurnNum = 0
end

function LuckyWheelActivityData:init()

end

function LuckyWheelActivityData:initNet(data)
    self.refreshNum = data.refreshNum
    self.costDiamond = data.costDiamond

    -- 处理初始化该数据
    self.drops = {}
    for k,v in pairs(data.drops) do 
        local luckyWheelData = Data.LuckyWheelData:create()
        luckyWheelData:initNet(v)

        table.insert(self.drops, luckyWheelData)
    end
end

function LuckyWheelActivityData:clearCount()
    self._buyNum = 0
    self._leftTurnNum = 0
end

function LuckyWheelActivityData:updateCount(data)
    print("LuckyWheelActivityData:updateCount", data)

    self._buyNum = data.buyNum
    self._leftTurnNum = data.turnNum
end

function LuckyWheelActivityData:judgeToUse()
    if(self._buyNum - self._leftTurnNum > 0) then
        return true
    else 
        return false
    end
end

function LuckyWheelActivityData:getRefreshNum()
    return self.refreshNum
end

function LuckyWheelActivityData:getCostDiamond()
    return self.costDiamond
end

function LuckyWheelActivityData:getLuckWheelDataArr()
    return self.drops
end

function LuckyWheelActivityData:getBuyNum()
    return  self._buyNum
end

function LuckyWheelActivityData:getLeftTurnNum()
    return  self._leftTurnNum
end