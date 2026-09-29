
-- LuckyWheelActivityData.lua
-- Author:zp
-- 2017年12月19日
-- Using:抽奖活动内容

require "app.datas.GameData"

local LotteryActivityData = class("LotteryActivityData")

Data = Data or {}
Data.LotteryActivityData = LotteryActivityData

function LotteryActivityData:ctor()
    --配置表数据
    self.refreshCost = {};  --刷新的消耗
    self.rewardLucky = 0;   --领奖的幸运值
    self.gachaCost = 0;     --单抽消耗
    self.replaceItem = 0;   --代卷物品ID
    self.lotteryPool = {};   --抽奖池 --[[ LuckyLotteryItemData { id = 1; itemID = 2; itemNum = 3; weight = 4;   //权重 lotteryType = 5; //类型}  ]]
    self.luckyPool = {};   --幸运池
    self.maxGachaNum = 0;   --抽奖上限
    self.levelLimit = 0; --活动开启的人物等级条件

    --进度数据
    self.curLucky = 0    --当前幸运
    self.freeTime = 0    --下次免费时间
    self.refreshNum = 0  --刷新次数
    self.gachaNum = 1    --抽取个数
    self.wheelList = {}  --奖池 --[[uint32 id = 1; //奖品ID, bool isDraw = 2;  //是否被抽 ]]
end

function LotteryActivityData:init()
end

function LotteryActivityData:initNet(data)
    print("------------LotteryActivityData:initNet----------")
    self.refreshCost = data.refreshCost  --刷新的消耗
    self.rewardLucky = data.rewardLucky   --领奖的幸运值
    self.gachaCost = data.gachaCost     --单抽消耗
    self.replaceItem = data.replaceItem;   --代卷物品ID
    self.lotteryPool = data.lotteryPool   --抽奖池 --[[ LuckyLotteryItemData { id = 1; itemID = 2; itemNum = 3; weight = 4;   //权重 lotteryType = 5; //类型}  ]]
    self.luckyPool = data.luckyPool;   --幸运池
    self.maxGachaNum = data.maxGachaNum
    self.levelLimit = data.levelLimit
end

function LotteryActivityData:clearCount()
    self.curLucky = 0    --当前幸运
    self.freeTime = 0    --下次免费时间
    self.refreshNum = 0  --刷新次数
    self.gachaNum = 1    --抽取个数
    self.wheelList = {}  --奖池 
end

function LotteryActivityData:updateCount(data)
    print("------------LotteryActivityData:updateCount----------")
    Avalon.MessageCenter:notice(AvalonMessage.MC_ACTIVITY_LUCKY_LOTTERY_REFRESH)
    self.curLucky = data.curLucky or self.curLucky
    self.freeTime = data.freeTime or self.freeTime
    self.refreshNum = data.refreshNum or self.refreshNum
    self.gachaNum = data.gachaNum or self.gachaNum
    self.wheelList = data.wheelList or self.wheelList
    for k, v in ipairs(self.wheelList) do
        for k2, v2 in ipairs(self.lotteryPool) do
            if v.id == v2.id then
                v.itemID = v2.itemID
                v.itemNum = v2.itemNum
                v.lotteryType = v2.lotteryType
            end
        end
    end
end

function LotteryActivityData:getDropList()
    -- print("-----getDropList-self.wheelList-----", self.wheelList)
    return self.wheelList
end

function LotteryActivityData:getTurnTimes()
    local count = self.maxGachaNum - self.gachaNum 
    count = count < 0 and 0 or count
    return count
end

function LotteryActivityData:getTurnCost()
    return self.gachaCost, self.replaceItem
end

function LotteryActivityData:getRefreshCountAndCost()
    local cost = self.refreshCost[self.refreshNum + 1] or self.refreshCost[#self.refreshCost]
    return self.refreshNum, cost
end
function LotteryActivityData:getRemianRefreshTime()
    if self.freeTime == 0 then
        return self.freeTime
    end
    return self.freeTime - (GameManager:getNowServerTime() - GameManager:getEPOCHTime())
end

function LotteryActivityData:getLuckNum()
    return self.curLucky, self.rewardLucky
end

function LotteryActivityData:getRewardFromLuckBox(rollIds)
    local list = {}
    for k, v in ipairs(rollIds) do
        for k2, v2 in ipairs(self.luckyPool) do
            if v == v2.id then
                local goodsData = GoodsDataManager:createLocalGoodsData(v2.itemID)
                if(goodsData) then
                    goodsData:setNum(v2.itemNum)
                    goodsData:setIsNew(false)
                    table.insert(list, goodsData)
                end 
            end
        end
    end
    return list
end

function LotteryActivityData:getTurnReward(indexs)
    local list = {}
    for k, index in ipairs(indexs) do
        for k2, v2 in ipairs(self.wheelList) do
            if index + 1 == k2 then
                local goodsData = GoodsDataManager:createLocalGoodsData(v2.itemID)
                if(goodsData) then
                    goodsData:setNum(v2.itemNum)
                    goodsData:setIsNew(false)
                    table.insert(list, goodsData)
                end 
            end
        end
    end
    return list
end

function LotteryActivityData:getLevelLimit()
    return self.levelLimit
end