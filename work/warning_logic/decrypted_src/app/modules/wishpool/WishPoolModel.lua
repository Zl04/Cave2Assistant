--[[--
数据模型WishPoolModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/09/24
--desc	: WishPoolModel
------------------------------------------------------------------------------

local WishPoolModel = class("WishPoolModel",mvc.GameModel)

local typeStr = {"GuildWish_CopperCoin", "GuildWish_SilverCoin"}

require "app.config.ConfigManager"
local ProtobufUtil = require "utils.ProtobufUtil"
local GameDataManager = require("app.game.GameDataManager")

function WishPoolModel:initData()
    self.wishData = {}
    self.wishData.totalTime = 0
    self.wishData.listMaxCount = 0
    self.wishData.list = {}
    self.wishData.reward = {}

    self.cfg = nil
end

function WishPoolModel:resetData(type)
    self.wishData[type] = {}
    self.wishData[type].count = 0
end

-- 一次成功许愿后更新数据
function WishPoolModel:updateWishData(data)
    if self.wishData[data.type] == nil then
        self:resetData(data.type)
    end

    -- if(ProtobufUtil:checkFieldIsInit(data, "gmedal")) then
    -- end

    if(ProtobufUtil:checkFieldIsInit(data, "goods")) then
        for _, v in ipairs(data.goods) do
            table.insert(self.wishData.reward, v)
        end
    end
end

function WishPoolModel:getWishReward()
    return self.wishData.reward
end

function WishPoolModel:clearWishReward()
    self.wishData.reward = {}
end

-- 次数同步，每次登陆和许愿后，都会同步一次
function WishPoolModel:updateWishCount(data)
    if self.wishData[data.type] == nil then
        self:resetData(data.type)
    end

    self.wishData[data.type].count = data.dailytimes
end

function WishPoolModel:getWishCount(innerType)
    local type = typeStr[innerType]
    if not type then
        print("type err: ", innerType)
        return 0
    end

    if self.wishData[type] == nil then
        self:resetData(type)
    end

    return self.wishData[type].count
end

function WishPoolModel:updateWishList(data)
    self.wishData.listMaxCount = data.total
    for _, v in ipairs(data.wishlist) do
        table.insert(self.wishData.list, v)
    end
end

function WishPoolModel:clearWishList()
    self.wishData.listCurIdx = 0
    self.wishData.listMaxCount = 0
    self.wishData.list = {}
end

function WishPoolModel:getWishList()
    return {list = self.wishData.list, max = self.wishData.listMaxCount}
end

function WishPoolModel:checkCurCostEnough(innerType)
    local curType = 0
    if innerType == 1 then
        curType = self.cfg.copperCoinWishCostType
    elseif innerType == 2 then
        curType = self.cfg.silverCoinWishCostType
    end

    local need = self:getCurCost(innerType)
    if curType == 1 then
        -- 检查金币
        local cur = GameDataManager:getInstance():getCurCoin()
        return cur >= tonumber(need), curType
    elseif curType == 2 then
        -- 检查钻石
        local ret = Avalon.MathUtil:checkDiamonEnough(tonumber(need), GameDataManager:getInstance():getDiamond())
        return ret, curType
    end

    return false, curType
end

-- 获取当前类型的当前费用
function WishPoolModel:getCurCost(innerType)
    local type = typeStr[innerType]
    if not type then
        print("type err: ", innerType)
        return 0
    end

    local data = self.wishData[type]
    local maxCount = self:geWishMaxTime(innerType)
    local countIdx = math.min(data.count+1, maxCount)
    local costList = self:geWishtCost(innerType)
    local finalCost = costList[countIdx]
    if finalCost == nil then
        finalCost = costList[#costList]
    end

    return finalCost
end

function WishPoolModel:getCostTypeIcon(innerType)
    local picName = {"symbol_gaming_money.png", "symbol_gaming_diamond.png"}
    self.cfg = ConfigManager:getGuildWishData()
    local curType = 0
    if innerType == 1 then
        curType = self.cfg.copperCoinWishCostType
    elseif innerType == 2 then
        curType = self.cfg.silverCoinWishCostType
    end

    return picName[curType]
end

function WishPoolModel:getTotalMaxTime()
    self.cfg = ConfigManager:getGuildWishData()
    return self.cfg.guildWishTimesMax
end

function WishPoolModel:geWishMaxTime(innerType)
    self.cfg = ConfigManager:getGuildWishData()
    if innerType == 1 then
        return self.cfg.copperCoinWishDailyTimes
    elseif innerType == 2 then
        return self.cfg.silverCoinWishDailyTimes
    end
end

function WishPoolModel:geWishtCost(innerType)
    self.cfg = ConfigManager:getGuildWishData()
    local costStr = ""
    if innerType == 1 then
        costStr = self.cfg.copperCoinWishCost
    elseif innerType == 2 then
        costStr = self.cfg.silverCoinWishCost
    end

    local costList = string.split(costStr, ",")
    return costList
end

function WishPoolModel:geWishTipList()
    self.cfg = ConfigManager:getGuildWishData()
    return self.cfg.Coinwishtips
end

function WishPoolModel:updateWishTotalTime(time)
    self.wishData.totalTime = time
end

function WishPoolModel:getWishTotalTime()
    return self.wishData.totalTime
end

function WishPoolModel:getRandTip()
    self.cfg = ConfigManager:getGuildWishData()
    local tips = self.cfg.Coinwishtips
    local tipArr = string.split(tips, ",")
    local rand = math.random(1, #tipArr)
    return tipArr[rand]
end

function WishPoolModel:getGuildBoxID()
    self.cfg = ConfigManager:getGuildWishData()
    return self.cfg.guildWishReward
end

return WishPoolModel