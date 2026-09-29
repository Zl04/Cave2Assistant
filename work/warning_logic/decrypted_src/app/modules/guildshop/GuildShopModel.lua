--[[--
数据模型GuildShopModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: CMonk
--date	: 2019/05/28
--desc	: GuildShopModel
------------------------------------------------------------------------------
require "app.config.ConfigManager"
require "app.datas.RoleDataManager"

local GuildShopModel = class("GuildShopModel",mvc.GameModel) 

local function getServerDate(self)
	return os.date("!*t", GameManager:getNowServerTime())
end

-- 内部方法, 获取现在到XX小时后的下一个的时间差
local function getDeltaSecToNextTimeInDayAfterHours(self, targetTime, shiftHours, useServerTime)
	assert(targetTime >= 0 and targetTime < 24)
	if (useServerTime == nil) then useServerTime = true end
	-- 从服务器时区时间获得一天中的时间
	local nowDate = useServerTime and getServerDate(self) or os.date("*t", os.time())
	local nowSecInDay = nowDate.hour * 3600 + nowDate.min * 60 + nowDate.sec

	-- 从一天中的时间获得下一次距离到达目标时间点的时间差
	local deltaToTarget = targetTime / 24 * 86400 --[[seconds one day]] - nowSecInDay
	-- 如果还未到目标时间就选取今天的目标时间, 如果已经过了目标时间就选取明天的目标时间
	local deltaToTargetNext = deltaToTarget > 0 and deltaToTarget or deltaToTarget + 86400 --[[seconds one day]]
	-- 加偏移时间, 返回现在与偏移时间后的第一个目标时间之间的时间差
	return deltaToTargetNext + shiftHours * 3600
end

function GuildShopModel:initData()
    self.allItemsTable = {}
    self.randomShop1 = {}
    self.randomShop2 = {}
    self.lastRefreshTime = {}
    self.needRefreshRandomShop = 0
    self.isChatNotice = false
    self.needRedPoint1 = false
    self.needRedPoint2 = false

    self.checkCounter = 0
end

function GuildShopModel:initConfig()
    self.allItemsTable = clone(NewConfig.GuildShop:getAllDatas())
    for k,itemInfo in pairs(self.allItemsTable) do
        itemInfo.goodsData = self:getDummyItemData(itemInfo.goodsID)
    end
end

-- data = {buyList = {}, result = 2, guildTechLv = 0}
-- buyList Content:
-- required uint32 id = 1; //商品ID
-- required uint32 buyNum = 2; //已经购买数量
-- required uint32 version = 3; //对应版本号
function GuildShopModel:updateBuyInfoFromServer(data)
    -- 重新填充所有数据
    self:initConfig()

    -- 更新商品信息
    for i,buyInfo in ipairs(data.buyList) do
        local itemData = self.allItemsTable[buyInfo.id]
        itemData.buyNum = buyInfo.buyNum
        itemData.serverVersion = buyInfo.version
    end

    if data.shopType == 1 and #data.randomGoodsList > 0 then
        self.randomShop1 = {}
        self.randomShop2 = {}

        -- 更新两个个人随机商店数据
        for i = 1, 3 do
            table.insert(self.randomShop1, self:assembleData(data.randomGoodsList[i]))
            table.insert(self.randomShop2, self:assembleData(data.randomGoodsList[i+3]))
        end

        -- 上一次两个随机商店的自然刷新时间
        self.lastRefreshTime = data.lastRefreshTime
    end

    -- 根据更新后的信息重新刷新数据
    self:refreshItemData()
end

function GuildShopModel:assembleData(svrData)
    local item = {}
    local goodsData = GoodsDataManager:createLocalGoodsData(svrData.goodsID)
    item.idx = svrData.index
    item.name = goodsData:getName()
    item.id = svrData.goodsID
    item.num = svrData.goodsNum
    item.cost = svrData.cost
    item.costType = svrData.costType
    item.discount = svrData.discount
    item.frame = svrData.frameType
    item.soldout = svrData.isSold
    item.extraContribution = svrData.extraContribution

    return item
end

function GuildShopModel:updateLastRefreshTime(data)
    self.lastRefreshTime = data.refreshTimeList
    self.checkCounter = 0
end

function GuildShopModel:getLastRefreshTime()
    return self.lastRefreshTime
end

function GuildShopModel:checkRandomHaveNewGoods()
    if self.isChatNotice then
        return false
    end

    if self.checkCounter > 5 then
        return
    end

    if self.lastRefreshTime == nil then
        Net.NetNPCSystem:requestGuildRandomShopRefreshTime()
        self.checkCounter = self.checkCounter + 1
        return
    end

    if not self.lastRefreshTime[1] or not self.lastRefreshTime[2] then
        return
    end

    local shopData = ConfigManager:getGuildRandomShopData()
    local nowTime = GameManager:getNormalServerTime()
    local refrsh1, refrsh2 = false
    if (self.lastRefreshTime[1] == 0) or
        (nowTime > self.lastRefreshTime[1] + shopData.refreshTime) then
        refrsh1 = true
    end

    if (self.lastRefreshTime[2] == 0) or 
        (nowTime > self.lastRefreshTime[2] + shopData.refreshTime) then
        refrsh2 = true
    end

    self.isChatNotice = refrsh1 or refrsh2
    self.needRedPoint1 = refrsh1
    self.needRedPoint2 = refrsh2

    return refrsh1 or refrsh2
end

function GuildShopModel:getNeedRedPoint(idx)
    if idx == 1 then
        return self.needRedPoint1
    elseif idx == 2 then
        return self.needRedPoint2
    end
end

function GuildShopModel:resetRedPoint(idx)
    if idx == 1 then
        self.needRedPoint1 = false
    elseif idx == 2 then
        self.needRedPoint2 = false
    end
end

function GuildShopModel:updateRandomShopData(data)
    if data.shopType == 2 then
        self.randomShop1 = {}
        for _, v in ipairs(data.goodsList) do
            table.insert(self.randomShop1, self:assembleData(v))
        end
        
        self.lastRefreshTime[1] = data.lastRefreshTime
    elseif data.shopType == 3 then
        self.randomShop2 = {}
        for _, v in ipairs(data.goodsList) do
            table.insert(self.randomShop2, self:assembleData(v))
        end
        self.lastRefreshTime[2] = data.lastRefreshTime
    end
end

-- 更新商品购买状态
function GuildShopModel:refreshItemData()
    for k,itemInfo in pairs(self.allItemsTable) do
        -- 更新剩余数量
        itemInfo.leftNum = itemInfo.goodsNum
        if (itemInfo.buyNum) then
            itemInfo.leftNum = itemInfo.goodsNum - itemInfo.buyNum
        end

        -- 更新可购买状态
        require "app.datas.MasterDataManager"
        local guildData = MasterDataManager:getGuildData()
        itemInfo.buyAble = false
        if (guildData) then
            -- 检查背包格数
            local data = {}
            data.goodsID = itemInfo.goodsData:getId()
            data.num = itemInfo.goodsNum
            data.isGolden = true
            local goodsArr = {data}
            local GameDataManager = require("app.game.GameDataManager")
            if(itemInfo.goodsData and GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)) then 
                local masterData = RoleDataManager:getMaster()
                local contribNum = masterData:getGuildContrib()
                if (masterData and contribNum and contribNum >= itemInfo.consume) then
                    if (guildData:getTotalTechLv() >= itemInfo.techExpRequireList) then
                        if (not itemInfo.goodsNum or itemInfo.goodsNum == 0 or itemInfo.leftNum > 0) then
                            itemInfo.buyAble = true
                            itemInfo.reason = 0
                        else
                            -- 原因为库存不足
                            itemInfo.reason = 2
                        end
                    else
                        -- 原因为公会科技等级不足
                        itemInfo.reason = 1
                    end
                else
                    -- 原因为贡献度不足
                    itemInfo.reason = 4
                end
            else
                -- 原因为背包空间不足
                itemInfo.reason = 5
            end
        end

        -- 更新刷新时间戳
        local timeNow = GameManager:getNormalServerTime()
        itemInfo.timeoutStamp = timeNow + getDeltaSecToNextTimeInDayAfterHours(self, 0, 0, true)
    end
end

-- 获取要展示的商品列表
function GuildShopModel:getDisplayItemArr()
    local guildData = MasterDataManager:getGuildData()
    if (not guildData) then return {} end

    local displayList = {}
    for k,item in pairs(self.allItemsTable) do
        if (guildData:getTotalTechLv() >= item.techExpRequireList) then
            table.insert(displayList, item)
        end
    end
    
    return displayList
end

-- 通过ID获取商品信息
function GuildShopModel:getItemFromID(id)
    return self.allItemsTable[id]
end

-- 获取展示数据
function GuildShopModel:getDummyItemData(id)
    require "app.datas.GoodsDataManager"
    local goodData = GoodsDataManager:createLocalGoodsData(id) --23030001
    if goodData then
        goodData:setNum(0)
        goodData:setIsNew(false)
        goodData.isHaveGet = false
    end
    return goodData
end

function GuildShopModel:getRandomShopData(idx)
    if idx == 1 then
        return self.randomShop1
    elseif idx == 2 then
        return self.randomShop2
    else
        return {}
    end
end

function GuildShopModel:getIsLockGuildShop()
    local guildBossLimit = SECONDS_ONE_DAY
    local guildCreateTime = 0
    local masterData = RoleDataManager:getMaster()
    local guildData = MasterDataManager:getGuildData()
    if(guildData) then 
        guildCreateTime = guildData:getCreateTime()
    end 
    local waitingTime = masterData:getJoinGuildTime() + guildBossLimit - GameManager:getNormalServerTime()
    local guildWaitingTime = guildCreateTime + guildBossLimit - GameManager:getNormalServerTime()
    if(waitingTime > 0 or guildWaitingTime > 0) then 
        return false
    end

    return true
end

return GuildShopModel