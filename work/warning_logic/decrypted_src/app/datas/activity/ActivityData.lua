-- ActivityData.lua
-- Author:zp
-- 2017年12月18日
-- Using:活动数据

require "app.datas.GameData"
require "app.datas.activity.ExtraDropData"
require "app.datas.activity.QuestConditionData"
require "app.datas.activity.CaveActivityData"
require "app.datas.activity.BlackMarketActivityData"
require "app.datas.activity.LuckyWheelActivityData"
require "app.datas.activity.DiscountData"
require "app.datas.activity.EmailBindData"
require "app.datas.activity.RandomShopActivityData"
require "app.datas.activity.ExchangeActivityData"
require "app.datas.activity.LotteryActivityData"
require "app.datas.activity.FestivalData"
require "app.datas.activity.ShareActivityData"
require "app.datas.activity.AnniversaryLotteryData"


local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

local ActivityData = class("ActivityData")

local ProtobufUtil = require "utils.ProtobufUtil"

local DEBUG = true

Data = Data or {}
Data.ActivityData = ActivityData

function ActivityData:ctor()
    self.id = 0         -- ID
    self.type = 0;      -- 类型
	self.isHot = false;
	self.jumpID = 0;    -- 跳转ID
	self.nameID = 0;    
    self.imgID = 0;
    self.imgType = 0;
    self.decID = 0;     -- 描述ID

    self._nameStr = nil    -- 名称
    self._imgUrl = nil     -- 图片地址
    self._decStr = nil     -- 描述信息

    self.showTime = 0;
    self.startTime = 0;
    self.endTime = 0;
    self.offTime = 0;

    self.status = PublicDefine.ActivityRunningStat.ActivityRunningStat_Waiting

    self.isDayRefresh = false
    self.content = nil
    self.isHideExtraDropDetail = false
    self.isHide = false

    self._questConditionDataList = nil       -- 任务条件活动
    self._extraDropDataList = nil            -- 额外掉落活动
    self._discountDataList = nil             -- 打折活动
    self._luckyWheelActivityData = nil   -- 抽奖活动
    self._blackMarketActivityData = nil  -- 黑市活动
    self._randomShopActivityData = nil  -- 随机商店
    self._guildQuestConditionDataList = nil  -- 公会任务条件活动
    self._caveActivityData = nil    -- 副本活动
    self._EmailBindData = nil                -- 处理邮箱绑定数据
    self._exchangeDataList = nil            -- 集换活动
    self._lotteryData = nil        --通用幸运转盘
    self._festivalData = nil         -- 节日活动
    self._exchangeShopDataArr = nil -- 节日兑换商店
    self._shareActivityData = nil -- 分享活动
    self._anniversaryLotteryData = nil -- 分享活动

    -- 是否已经激活  (TODO 这里现在默认为true)
    self.isEnabled = true
    self._initRes = false

    -- 本地数据
    self._isNew = true 
end

function ActivityData:init()
    self._initRes = false
end

function ActivityData:initNet(data)
    self.id = data.id            -- ID
    self.type = data.type        -- 类型
	self.isHot = data.isHot;
	self.jumpID = data.jumpID    -- 跳转ID
	self.nameID = data.nameID    
    self.imgID = data.imgID
    self.imgType = data.imgType
    self.decID = data.decID      -- 描述ID
    self.showTime = data.showTime
    self.startTime = data.startTime
    self.endTime = data.endTime
    self.offTime = data.offTime
    self.content = data.content
    self.status = data.stat
    self.sortID = data.sortID
    self.isDayRefresh = data.isDayRefresh
    self.isHideExtraDropDetail = data.isHideExtraDropDetail

    if ProtobufUtil:checkFieldIsInit(data, "isHide") then
        self.isHide = data.isHide
    end

    self._initRes = false

    -- 解析对应数据
    -- 任务条件活动
    if(self.type == PublicDefine.ActivityType.ActivityType_QuestCondition) then
        local questData = ProtobufUtil:decode("PublicDefine.QuestConditionActivityData", self.content)
        if(questData) then
            if(DEBUG) then
                print("dddddddddddddddd  questData", self.id)
                dump(questData)
            end
            self._questConditionDataList = {}
            for k,v in pairs(questData.activities) do 
                local questConditionData = Data.QuestConditionData:create()
                questConditionData:initNet(v, self.id)

                table.insert(self._questConditionDataList, questConditionData)
                if v.type == PublicDefine.QuestConditionType.QuestConditionType_LoginOut then
                    if v.targetID == 3 then-- 限时登录活动
                        --print("questConditionData--->: ", questConditionData)
                        MasterDataManager:setLimitTimeLoginTaskOpenStat(true)
                        MasterDataManager:setLimitTimeLoginTaskData(questConditionData, self.id)
                        -- 收到活动消息直接发送一次
                        Net.NetActivitySystem:requestTimeLimitedLoginComplete(questConditionData.activityId)
                    end
                end
            end
        end
    -- 额外掉落活动
    elseif(self.type == PublicDefine.ActivityType.ActivityType_ExtraDrop) then
        local extraData = ProtobufUtil:decode("PublicDefine.ExtraDropActivityData", self.content)
        if(extraData) then
            if(DEBUG) then
                print("dddddddddddddddd  extraData", self.id)
                dump(extraData)
            end
            self._extraDropDataList = {}
            for k,v in pairs(extraData.activities) do 
                local extraDropData = Data.ExtraDropData:create()
                extraDropData:initNet(v)

                table.insert(self._extraDropDataList, extraDropData)
            end
        end
    -- 打折活动
    elseif(self.type == PublicDefine.ActivityType.ActivityType_Discount) then
        local disData = ProtobufUtil:decode("PublicDefine.DiscountActivityData", self.content)
        if(disData) then
            if(DEBUG) then
                print("dddddddddddddddd  disData", self.id)
                dump(disData)
            end
            self._discountDataList = {}

            -- 组装全局的数据，这里采用ID=0 来保存全局的进度等数据，这里会组装一个
            if(disData.catFoodGlobalNum ~= 0) then
                local catData = {}
                catData.type = PublicDefine.DiscountType.DiscountType_CatFood                
                catData.discount = 10000
                catData.limitNum = disData.catFoodGlobalNum
                catData.id = 0

                local discountData = Data.DiscountData:create()
                discountData:initNet(catData)
                table.insert(self._discountDataList, discountData)
            end

            for k,v in pairs(disData.activities) do 
                local discountData = Data.DiscountData:create()
                discountData:initNet(v)

                table.insert(self._discountDataList, discountData)
            end
        end
    -- 抽奖活动
    elseif(self.type == PublicDefine.ActivityType.ActivityType_LuckyWheel) then
        local luckyData = ProtobufUtil:decode("PublicDefine.LuckyWheelActivityData", self.content)
        if(DEBUG) then
            print("dddddddddddddddd  luckyData", self.id)
            dump(luckyData)
        end
        local luckyWheelActivityData = Data.LuckyWheelActivityData:create()
        luckyWheelActivityData:initNet(luckyData)

        self._luckyWheelActivityData = luckyWheelActivityData
    -- 黑市活动
    elseif(self.type == PublicDefine.ActivityType.ActivityType_BlackMarket) then
        local blackData = ProtobufUtil:decode("PublicDefine.BlackMarketActivityData", self.content)
        if(DEBUG) then
            print("dddddddddddddddd  blackData", self.id)
            dump(blackData)
        end
        local blackMarketActivityData = Data.BlackMarketActivityData:create()
        blackMarketActivityData:initNet(blackData)

        self._blackMarketActivityData = blackMarketActivityData
    -- 随机商店活动
    elseif(self.type == PublicDefine.ActivityType.ActivityType_RandomShop) then
        local blackData = ProtobufUtil:decode("PublicDefine.RandomShopActivityData", self.content)
        if(DEBUG) then
            print("dddddddddddddddd  RandomShop", self.id)
            dump(blackData)
        end
        local randomShopData = Data.RandomShopActivityData:create()
        randomShopData:initNet(blackData)

        self._randomShopActivityData = randomShopData
    -- 公会条件活动
    elseif(self.type == PublicDefine.ActivityType.ActivityType_QuestConditionGuild) then
        local questData = ProtobufUtil:decode("PublicDefine.QuestConditionActivityData", self.content)
        if(questData) then
            if(DEBUG) then
                print("dddddddddddddddd GuildQuestCondition", self.id)
                dump(questData)
            end
            self._guildQuestConditionDataList = {}
            for k,v in pairs(questData.activities) do 
                local questConditionData = Data.QuestConditionData:create()
                questConditionData:initNet(v)

                table.insert(self._guildQuestConditionDataList, questConditionData)
            end
        end
    -- 副本活动
    elseif(self.type == PublicDefine.ActivityType.ActivityType_Cave) then
        local questData = ProtobufUtil:decode("PublicDefine.CaveActivityData", self.content)
        if(questData) then
            if(DEBUG) then
                print("dddddddddddddddd CaveActivityData", self.id)
                dump(questData)
            end
            self._caveActivityData = nil
            local caveData = Data.CaveActivityData:create()
            caveData:initNet(questData)
            self._caveActivityData = caveData
        end
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then
        self._initRes = true
        local blackData = ProtobufUtil:decode("PublicDefine.BlackMarketActivityData", self.content)
        if(DEBUG) then
            print("dddddddddddddddd  blackData", self.id)
            dump(blackData)
        end
        local EmailBindData = Data.EmailBindData:create()
        EmailBindData:initNet(blackData)

        self._EmailBindData = EmailBindData
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_Addition) then

    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_Exchange) then
        local extraData = ProtobufUtil:decode("PublicDefine.ExchangeActivityData", self.content)
        if(extraData) then
            if(DEBUG) then
                print("dddddddddddddddd  extraData", self.id)
                dump(extraData)
            end
            self._exchangeDataList = {}
            for k,v in pairs(extraData.exchanges) do 
                local exchangeData = Data.ExchangeActivityData:create()
                exchangeData:initNet(v)

                table.insert(self._exchangeDataList, exchangeData)
            end
        end
    --通用转盘
    elseif(self.type == PublicDefine.ActivityType.ActivityType_LuckyLottery) then
        local luckyData = ProtobufUtil:decode("PublicDefine.LuckyLotteryActivityData", self.content)
        if(DEBUG) then
            print("dddddddddddddddd  luckyData", self.id, luckyData)
        end

        local lotteryData = Data.LotteryActivityData:create()
        lotteryData:initNet(luckyData)
        self._lotteryData = lotteryData
    elseif(self.type == PublicDefine.ActivityType.ActivityType_Festival) then
        local festivalData = ProtobufUtil:decode("PublicDefine.FestivalActData", self.content)
        if(DEBUG) then
            print("dddddddddddddddd  festivalData", self.id, festivalData)
        end

        local festivalObj = Data.FestivalData:create()
        festivalObj:initNet(self.id, festivalData)
        self._festivalData = festivalObj 
    elseif(self.type == PublicDefine.ActivityType.ActivityType_HeroTarget) then
        -- 老玩家回归, 故意留空

    elseif(self.type == PublicDefine.ActivityType.ActivityType_ExchangeShop) then
        if(DEBUG) then
            print("dddddddddddddddd  ActivityType_ExchangeShop", self.content)
        end
        self._exchangeShopDataArr = {}
        local exchangeArr = ConfigManager:getExchangeShop()
        for k, v in pairs(exchangeArr) do 
            local exData = Data.FestivalExchangeShopData:create(v.ID)
            table.insert(self._exchangeShopDataArr, exData)
        end
    elseif (self.type == PublicDefine.ActivityType.ActivityType_Share) then
        local shareActivityData = ProtobufUtil:decode("PublicDefine.ShareActivityData", self.content)
        if(DEBUG) then
            print("dddddddddddddddd  shareActivityData", self.id, shareActivityData)
        end

        local shareObj = Data.ShareActivityData:create()
        shareObj:initNet(self.id, shareActivityData)
        self._shareActivityData = shareObj 
    elseif(self.type == PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw) then
        local anniversaryLotteryStruct = ProtobufUtil:decode("PublicDefine.AnniversaryLuckyDrawData", self.content)
        if(DEBUG) then
            print("dddddddddddddddd  anniversaryLotteryData", self.id, anniversaryLotteryData)
        end
        -- mvc.activityAnnivesaryLotteryModel:setAnniversaryLotteryActivityData(data)
        -- mvc.activityAnnivesaryLotteryModel:setAnniversaryLotteryIsShow(data)
        
        local anniversaryLotteryData = Data.AnniversaryLotteryData:create()
        anniversaryLotteryData:initNet(self.id, anniversaryLotteryStruct)
        self._anniversaryLotteryData = anniversaryLotteryData
        
        -- mvc.activityAnnivesaryLotteryModel:setAnniversaryLotteryData(self._anniversaryLotteryData)
        Net.NetActivitySystem:requestAnnivesaryLotteryData(self.id)
    else 
        printError(string.format("ActivityData not handle type =%d", self.type))
    end

    -- 获取相关的ID
    -- todo 请求文本

    self:refreshIsNew()
end

function ActivityData:updateStatus(status, isEnabled)
    self.status = status
    if(isEnabled == 0 or isEnabled == false) then 
        if self.type == PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw then
            Net.NetActivitySystem:requestAnnivesaryLotteryData(self.id)
            self.isEnabled = mvc.activityAnnivesaryLotteryModel:getAnniversaryLotteryIsShow(self._anniversaryLotteryData.signType)
        else
            self.isEnabled = false
        end
        
    else 
        if self.type == PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw then
            Net.NetActivitySystem:requestAnnivesaryLotteryData(self.id)
        end
        self.isEnabled = true
    end
end

function ActivityData:updateDesData(descUpdateData)
    if(descUpdateData) then 
        if(ProtobufUtil:checkFieldIsInit(descUpdateData, "nameID") and descUpdateData.nameID ~= 0) then 
            self.nameID = descUpdateData.nameID
        end

        if(ProtobufUtil:checkFieldIsInit(descUpdateData, "decID") and descUpdateData.decID ~= 0) then 
            self.decID = descUpdateData.decID
        end
    end
end

function ActivityData:initCount(data)
    self.isEnabled = data.isEnabled

    if(self:getType() == PublicDefine.ActivityType.ActivityType_Discount) then
        local countData = ProtobufUtil:decode("ActivitySystem.DiscountRoleMessage", data.content)
        if(DEBUG) then
            print("ActivityData  ActivityType_Discount",countData)
        end
        if(self._discountDataList) then
            for k, discountRoleData in ipairs(countData.list) do 
                self:handleDiscountRoleData(discountRoleData)
            end
        end
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_BlackMarket) then
        self:handleBlackShop(data.content)
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_RandomShop) then
        self:handleRandomShop(data.content)
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_ExtraDrop) then
        local countData = ProtobufUtil:decode("ActivitySystem.ExtraDropRoleMessage", data.content)
        if(DEBUG) then
            print("ActivityData  ActivityType_ExtraDrop",countData)
        end
        if(self._extraDropDataList) then
            for k, extraData in ipairs(countData.list) do 
                self:handleExtraDropData(extraData)
            end
        end
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_QuestCondition) then
        local countData = ProtobufUtil:decode("ActivitySystem.QuestConditionRoleMessage", data.content)
        if(DEBUG) then
            print("ActivityData  ActivityType_QuestCondition",countData)
        end
        if(self._questConditionDataList) then
            for k, questRoleData in ipairs(countData.list) do 
                self:handleQuestConditionData(questRoleData, true)
            end

            self:sortQuestCondition(self._questConditionDataList)
        end
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_LuckyWheel) then
        self:handleLuckyWheel(data.content)
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_QuestConditionGuild) then
        local countData = ProtobufUtil:decode("ActivitySystem.QuestConditionRoleMessage", data.content)
        if(DEBUG) then
            print("ActivityData  ActivityType_QuestConditionGuild",countData)
        end
        if(self._guildQuestConditionDataList) then
            for k, questRoleData in ipairs(countData.list) do 
                self:handleGuildQuestConditionData(questRoleData, true)
            end

            self:sortQuestCondition(self._guildQuestConditionDataList)
        end

    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_Cave) then
        local countData = ProtobufUtil:decode("ActivitySystem.CaveRoleMessage", data.content)
        if(DEBUG) then
            print("ActivityData  ActivityType_Cave",countData)
        end
        if(self._caveActivityData) then
            self._caveActivityData:updateCount(countData)
        end
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then
        -- self:handleLuckyWheel(data.content)
        self:handleEmailBind(data.content)

    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_Exchange) then
        local countData = ProtobufUtil:decode("ActivitySystem.ExchangeRoleMessage", data.content)
        if(DEBUG) then
            print("ActivityData  ExchangeRoleMessage",countData)
        end
        if(self._exchangeDataList) then
            for k, extraData in ipairs(countData.exchange) do 
                self:handleExchangeData(extraData)
            end
        end
    elseif (self:getType() == PublicDefine.ActivityType.ActivityType_LuckyLottery) then
        local lotteryData = ProtobufUtil:decode("ActivitySystem.LuckyLotteryRoleMessage", data.content)
        if(self._lotteryData) then
            self._lotteryData:updateCount(lotteryData)
        end
    elseif (self:getType() == PublicDefine.ActivityType.ActivityType_Festival) then
        local festivalData = ProtobufUtil:decode("ActivitySystem.FestivalRoleMessage", data.content)
        if(DEBUG) then
            print("dddddddddddddddd  FestivalRoleMessage", self.id, festivalData)
        end

        if self._festivalData then
            self._festivalData:initCount(festivalData)
        end
    elseif (self:getType() == PublicDefine.ActivityType.ActivityType_ExchangeShop) then
        local countData = ProtobufUtil:decode("ActivitySystem.ExchangeShopRoleMessage", data.content)
        if(DEBUG) then
            print("ActivityData  ExchangeShopRoleMessage",countData)
        end
        if(self._exchangeShopDataArr) then
            for k, extraData in ipairs(countData.purchaseData) do 
                self:handleExchangeShopData(extraData)
            end
        end
    elseif (self:getType() == PublicDefine.ActivityType.ActivityType_Share) then
        local shareData = ProtobufUtil:decode("ActivitySystem.ShareRoleMessage", data.content)
        if(DEBUG) then
            print("dddddddddddddddd  ShareRoleMessage", self.id, shareData)
        end

        if self._shareActivityData then
            self._shareActivityData:initCount(shareData)
        end
    elseif (self:getType() == PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw) then
        local anniversaryLotteryData = ProtobufUtil:decode("ActivitySystem.AnniversaryLuckyDrawDataMessage", data.content)
        local timeData = {}
        -- timeData.showTime = self.showTime
        -- timeData.offTime = self.offTime
        -- timeData.endTime = self.endTime
        self.isEnabled = true--mvc.activityAnnivesaryLotteryModel:getAnniversaryLotteryIsShowByData(timeData)
        if(self._anniversaryLotteryData) then
            self._anniversaryLotteryData:initCount(anniversaryLotteryData)
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ACTIVITY_ANNIVERSARY_SHOW_LOTTERY_PREVIEW) 
    else 
        print("ddddddddddddddddd no handle", data)
    end
end

function ActivityData:clearCount()
    if(self._questConditionDataList) then
        for k,v in ipairs(self._questConditionDataList) do
            v:clearCount()
        end
    end

    if(self._extraDropDataList) then
        for k,v in ipairs(self._extraDropDataList) do
            v:clearCount()
        end
    end

    if(self._discountDataList) then
        for k,v in ipairs(self._discountDataList) do
            v:clearCount()
        end
    end

    if(self._luckyWheelActivityData) then
        self._luckyWheelActivityData:clearCount()
    end

    if(self._blackMarketActivityData) then
        self._blackMarketActivityData:clearCount()
    end

    if(self._randomShopActivityData) then
        self._randomShopActivityData:clearCount()
    end

    if(self._caveActivityData) then 
        self._caveActivityData:clearCount()
    end

     if(self._lotteryData) then 
        self._lotteryData:clearCount()
    end

    if(self._festivalData) then 
        self._festivalData:clearCount()
    end

    if(self._shareActivityData) then 
        self._shareActivityData:clearCount()
    end

    if(self._anniversaryLotteryData) then 
        self._anniversaryLotteryData:clearCount()
    end
end

function ActivityData:updateCount(data)
    -- self.isEnabled = data.isEnabled

    if(self:getType() == PublicDefine.ActivityType.ActivityType_Discount) then
        local countData = ProtobufUtil:decode("ActivitySystem.DiscountRoleData", data.content)
        self:handleDiscountRoleData(countData)
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_BlackMarket) then
        self:handleBlackShop(data.content)
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_RandomShop) then
        self:handleRandomShop(data.content)
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_ExtraDrop) then
        local countData = ProtobufUtil:decode("ActivitySystem.ExtraDropRoleData", data.content)

        self:handleExtraDropData(countData)
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_QuestCondition) then
        local countData = ProtobufUtil:decode("ActivitySystem.QuestConditionRoleData", data.content)

        self:handleQuestConditionData(countData)
        self:sortQuestCondition(self._questConditionDataList)
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_QuestConditionGuild) then
        local countData = ProtobufUtil:decode("ActivitySystem.QuestConditionRoleData", data.content)

        self:handleGuildQuestConditionData(countData)
        self:sortQuestCondition(self._guildQuestConditionDataList)
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_Cave) then
        local caveData = ProtobufUtil:decode("ActivitySystem.CaveRoleMessage", data.content)
        if(self._caveActivityData) then
            self._caveActivityData:updateCount(caveData)
        end
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_LuckyWheel) then
        self:handleLuckyWheel(data.content)

    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then
        -- self:handleLuckyWheel(data.content)
        self:handleEmailBind(data.content)
    elseif(self:getType() == PublicDefine.ActivityType.ActivityType_Exchange) then
        local countData = ProtobufUtil:decode("ActivitySystem.ExchangeRoleMessage", data.content)
        if(DEBUG) then
            print("ActivityData:updateCount  ExchangeRoleMessage",countData)
        end
        if(self._exchangeDataList) then
            for k, extraData in ipairs(countData.exchange) do 
                self:handleExchangeData(extraData)
            end
        end

        self:sortQuestCondition(self._exchangeDataList)
    --通用转盘
    elseif(self.type == PublicDefine.ActivityType.ActivityType_LuckyLottery) then
        local lotteryData = ProtobufUtil:decode("ActivitySystem.LuckyLotteryRoleMessage", data.content)
        if(self._lotteryData) then
            self._lotteryData:updateCount(lotteryData)
        end
    elseif (self:getType() == PublicDefine.ActivityType.ActivityType_Festival) then
        local festivalData = ProtobufUtil:decode("ActivitySystem.FestivalRoleMessage", data.content)
        if(DEBUG) then
            print("dddddddddddddddd  FestivalRoleMessage", self.id, festivalData)
        end

        if self._festivalData then
            self._festivalData:updateCount(festivalData)
        end
    elseif (self:getType() == PublicDefine.ActivityType.ActivityType_ExchangeShop) then
        local countData = ProtobufUtil:decode("ActivitySystem.ExchangeShopPurchaseData", data.content)
        if(DEBUG) then
            print("ActivityData:updateCount  ExchangeShopPurchaseData",countData)
        end
        if(self._exchangeShopDataArr ) then
            self:handleExchangeShopData(countData)
        end
    elseif (self:getType() == PublicDefine.ActivityType.ActivityType_Share) then
        local countData = ProtobufUtil:decode("ActivitySystem.ShareRoleMessage", data.content)
        if(DEBUG) then
            print("ActivityData:updateCount  ShareRoleMessage",countData)
        end
        if(self._shareActivityData ) then
            self._shareActivityData:updateCount(countData)
        end
    elseif(self.type == PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw) then   --周年庆抽奖
        local anniversaryLotteryData = ProtobufUtil:decode("ActivitySystem.AnniversaryLuckyDrawDataMessage", data.content)
        if(self._anniversaryLotteryData) then
            self._anniversaryLotteryData:updateCount(anniversaryLotteryData)
        end
    else 

    end
end

function ActivityData:getIsShowExtraDropDetail()
    return not self.isHideExtraDropDetail
end

-- 排序
function ActivityData:sortQuestCondition(questConditionList)
    if(questConditionList == nil or #questConditionList == 0) then 
        return 
    end
    -- 可领奖→未完成→已完成→ID的顺序从上至下排列
    table.sort(questConditionList, function(a,b)
        local aIsComplete = a:getIsComplete()
        local aIsReceive = a:getIsReceive()

        local bIsComplete = b:getIsComplete()
        local bIsReceive = b:getIsReceive()

        if(aIsReceive or bIsReceive) then
            if(aIsReceive == bIsReceive) then
                if(a:getID() < b:getID()) then 
                    return true
                else 
                    return false
                end
            elseif(aIsReceive) then
                return false
            elseif (bIsReceive) then
                return true
            end
        else 
            if(aIsComplete or bIsComplete) then
                if(aIsComplete == bIsComplete) then
                    if(a:getID() < b:getID()) then 
                        return true
                    else 
                        return false
                    end
                elseif(aIsComplete) then
                    return true
                elseif(bIsComplete) then
                    return false
                end
            else 
                if(a:getID() < b:getID()) then 
                    return true
                else 
                    return false
                end
            end
        end
    end)
end

function ActivityData:handleDiscountRoleData(discountRoleData)
    if(self._discountDataList) then
        for k,discountData in ipairs(self._discountDataList) do
            if(discountData:getType() == discountRoleData.type) then
                discountData:updateCount(discountRoleData)
            end
        end
    end 
end

function ActivityData:handleBlackShop(content)
    local countData = ProtobufUtil:decode("ActivitySystem.BlackMarketRoleMessage", content)
    if(DEBUG) then
        print("ActivityData handleBlackShop",countData)
    end
    if(countData and self._blackMarketActivityData) then
        self._blackMarketActivityData:setUseNum(countData.refreshNum)
    end
end

function ActivityData:handleRandomShop(content)
    local countData = ProtobufUtil:decode("ActivitySystem.RandomShopRoleMessage", content)
    if(DEBUG) then
        print("ActivityData handleRandomShop",countData)
    end
    if(countData and self._randomShopActivityData) then
        self._randomShopActivityData:setUseNum(countData.refreshNum)
    end
end

function ActivityData:handleExchangeData(extraDropData)
    if(self._exchangeDataList) then
        for k,extraData in ipairs(self._exchangeDataList) do
            if(extraData:getID() == extraDropData.id) then
                extraData:updateCount(extraDropData)
            end
        end
    end 
end

function ActivityData:handleExchangeShopData(exchangeCountData)
    if(self._exchangeShopDataArr) then
        for k,extraData in ipairs(self._exchangeShopDataArr) do
            if(extraData:getID() == exchangeCountData.templateId) then
                extraData:updateCount(exchangeCountData)
            end
        end
    end 
end



function ActivityData:handleExtraDropData(extraDropData)
    if(self._extraDropDataList) then
        for k,extraData in ipairs(self._extraDropDataList) do
            if(extraData:getID() == extraDropData.id) then
                extraData:updateCount(extraDropData)
            end
        end
    end 
end

function ActivityData:handleQuestConditionData(questData, isInit)
    isInit = isInit or false
    if(self._questConditionDataList) then
        for k,questConditionData in ipairs(self._questConditionDataList) do
            if(questConditionData:getID() == questData.id) then
                local preNum = questConditionData:getTotalNum()
                questConditionData:updateCount(questData)
                if(preNum < questConditionData:getTotalNum() and not isInit) then 
                    -- 触发提示信息
                    local totalNum = questConditionData:getTotalNum()
                    if(totalNum > questConditionData:getMaxNum()) then
                        totalNum = questConditionData:getMaxNum()
                    end
                    local titleStr = AvalonUtil:getQuestConditionTitle(questConditionData)
                    local countStr = ""
                    if(questConditionData:getType() ~= PublicDefine.QuestConditionType.QuestConditionType_Version) then 
                        if questConditionData:getType() == PublicDefine.QuestConditionType.QuestConditionType_CashRecharge then
                            totalNum = totalNum/100
                            local maxNum = questConditionData:getMaxNum()/100
                            countStr = string.format("    "..UI.TEXT_224900, totalNum, maxNum)
                        elseif questConditionData:getType() == PublicDefine.QuestConditionType.QuestConditionType_LoginOut and questConditionData.targetID == 3 then
                            local startTime = questConditionData.startTime --- GameManager:get_timezone_offset()
                            local endTime = questConditionData.endTime --- GameManager:get_timezone_offset()
                            -- startTime = startTime > 0 and startTime or startTime + 86400
                            -- endTime = endTime > 0 and endTime or endTime + 86400
                            -- local startDate = os.date("%H:%M", startTime);
                            -- local endDate = os.date("%H:%M", endTime);
                            local timeStr = self:getDisplayTimeString(startTime, endTime)
                            countStr = timeStr--string.format("    (%s-%s)", startDate, endDate)
                        else
                            countStr = string.format("    (%d/%d)", totalNum, questConditionData:getMaxNum())
                        end
                    end
                    local str = string.format("[%s]%s%s", UI.TEXT_111023, titleStr, countStr)
                    Game.ChatManager:getInstance():sendSystemMsg(str, ChatMessageType.SYSTEM_MESSAGE)
                end
            end
        end
    end 
end

-- 获取服务器到下次
function ActivityData:getOffsetTimeToNextTimeInDay(timeInDayInSeconds)
    local timeNow = GameManager:getNormalServerTime()
    local timeNowInDay = timeNow % SECONDS_ONE_DAY
    -- 从一天中的时间获得下一次距离到达目标时间点的时间差
	local deltaToTarget = timeInDayInSeconds - timeNowInDay
	-- 如果还未到目标时间就选取今天的目标时间, 如果已经过了目标时间就选取明天的目标时间
	local deltaToTargetNext = deltaToTarget > 0 and deltaToTarget or deltaToTarget + SECONDS_ONE_DAY
	return deltaToTargetNext
end

-- 获取显示时间
function ActivityData:getDisplayTimeString(startTime, endTime)
    if (not startTime) then return "" end

    -- 获取本地时间
    local localDate = os.date("*t", os.time())
    local localTime = localDate.hour * 3600 + localDate.min * 60 + localDate.sec

    -- 拼装展示本地时间
    local timeString = ""
    local count = 0
    -- local endTime = self._data.endArr[i]
    if (startTime and endTime) then
        -- 计算开始时间
        local offsetOpenTime = self:getOffsetTimeToNextTimeInDay(startTime)
        local localOpenTime = (localTime + offsetOpenTime) % SECONDS_ONE_DAY
        local openHour = math.floor(localOpenTime / 3600)
        local openMin = math.round(localOpenTime % 3600 / 60)
        if (openMin >= 60) then
            openMin = openMin - 60
            openHour = openHour + 1
        end
        local openString = tostring(openHour) .. ":" .. (math.floor(openMin / 10) == 0 and string.format("0%s", openMin) or tostring(openMin))

        -- 计算结束时间
        local offsetEndTime = self:getOffsetTimeToNextTimeInDay(endTime)
        local localEndTime = (localTime + offsetEndTime) % SECONDS_ONE_DAY
        local endHour = math.floor(localEndTime / 3600)
        local endMin = math.round(localEndTime % 3600 / 60)
        if (endMin >= 60) then
            endMin = endMin - 60
            endHour = endHour + 1
        end
        local endString = tostring(endHour) .. ":" .. (math.floor(endMin / 10) == 0 and string.format("0%s", endMin) or tostring(endMin))
        timeString = timeString .. openString .. "-" .. endString
    end
    
    return timeString
end

function ActivityData:handleGuildQuestConditionData(questData, isInit)
    isInit = isInit or false
    if(self._guildQuestConditionDataList) then
        for k,questConditionData in ipairs(self._guildQuestConditionDataList) do
            if(questConditionData:getID() == questData.id) then
                local preNum = questConditionData:getTotalNum()
                questConditionData:updateCount(questData)
                if(preNum < questConditionData:getTotalNum() and not isInit) then 
                    -- 触发提示信息
                    local totalNum = questConditionData:getTotalNum()
                    local maxNum = questConditionData:getMaxNum()
                    if(totalNum > maxNum) then
                        totalNum = maxNum
                    end
                    local titleStr = LanguageManager:getInstance():getLocalString(1111489)..AvalonUtil:getQuestConditionTitle(questConditionData)
                    local countStr = string.format("    (%d/%d)", totalNum, maxNum)

                    local str = string.format("[%s]%s%s", UI.TEXT_111023, titleStr, countStr)
                    Game.ChatManager:getInstance():sendSystemMsg(str, ChatMessageType.SYSTEM_MESSAGE)
                end
            end
        end
    end 
end

function ActivityData:handleGuildAccountInfo(questData)
    if(self._guildQuestConditionDataList) then
        for k,questConditionData in ipairs(self._guildQuestConditionDataList) do
            if(questConditionData:getID() == questData.subID) then
                questConditionData:updateGuildCount(questData)
            end
        end
    end 
end

function ActivityData:handleClearGuildAccountInfo()
    if(self._guildQuestConditionDataList) then
        for k,questConditionData in ipairs(self._guildQuestConditionDataList) do
            questConditionData:clearGuildCount(questData)
        end
    end 
end

function ActivityData:handleUpdateReward(data)
    if(self._questConditionDataList) then
        local change = false
        for k,questConditionData in ipairs(self._questConditionDataList) do
            if(questConditionData:getID() == data.subId) then
                change = true
                questConditionData:setIsReward(true)
                break
            end
        end

        if(change) then
            self:sortQuestCondition(self._questConditionDataList)
        end
    end 

    if(self._guildQuestConditionDataList) then
        local change = false
        for k,questConditionData in ipairs(self._guildQuestConditionDataList) do
            if(questConditionData:getID() == data.subId) then
                change = true
                questConditionData:setIsReward(true)
                break
            end
        end

        if(change) then
            self:sortQuestCondition(self._guildQuestConditionDataList)
        end 
    end 
end

function ActivityData:handleLuckyWheel(content)
    local countData = ProtobufUtil:decode("ActivitySystem.LuckyWheelRoleMessage", content)
    if(DEBUG) then
        print("ActivityData handleLuckyWheel",countData)
    end
    if(countData and self._luckyWheelActivityData) then
        self._luckyWheelActivityData:updateCount(countData)
    end
end

function ActivityData:handleEmailBind(content)
    local countData = ProtobufUtil:decode("ActivitySystem.MailBindRoleMessage", content)
    if(DEBUG) then
        print("ActivityData handleLuckyWheel",countData)
    end
    if(countData and self._EmailBindData) then
        self._EmailBindData:updateCount(countData)
    end
end

function ActivityData:addGoodsDataTriggerSystemMes(goodsData)
    if(self._exchangeDataList) then
        for k,questConditionData in ipairs(self._exchangeDataList) do
            if(questConditionData:getCostID() == goodsData:getGoodsID() and questConditionData:getIsReceiveEnd() == false) then
                -- 触发提示信息
                local totalNum = GameDataManager:getInstance():getGoodsDataNum(PublicDefine.PACKET_TYPE.PACKET_BAG, questConditionData:getCostID(),true)
                local titleStr = string.format(UI.TEXT_1212229, goodsData:getName())
                local countStr = string.format("    (%d/%d)", totalNum, questConditionData:getCostNum())
                local str = string.format("[%s]%s%s", UI.TEXT_111023, titleStr, countStr)
                Game.ChatManager:getInstance():sendSystemMsg(str, ChatMessageType.SYSTEM_MESSAGE)
            end
        end
    end 
end

function ActivityData:getIsInit()
    return self._initRes
end

function ActivityData:getKeyList()
    local keyList = {}

    if(self:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then 
        return keyList
    end

    if self.jumpID ~= nil and self.jumpID ~= 0 and self:checkNoGet(self.jumpStr) then
        table.insert(keyList, self.jumpID)
    end
    if self.nameID ~= nil and self.nameID ~= 0 and self:checkNoGet(self.nameStr) then
        table.insert(keyList, self.nameID)
    end

    if self.imgID ~= nil and self.imgID ~= 0 and self:checkNoGet(self.imgStr) then
        table.insert(keyList, self.imgID)
    end

    if self.decID ~= nil and self.decID ~= 0 and self:checkNoGet(self.decStr) then
        table.insert(keyList, self.decID)
    end

    -- 获取子类的相关数据
    if(self._questConditionDataList) then
        for k,v in pairs(self._questConditionDataList) do 
            local keys = v:getKeyList()
            if(keys and table.nums(keys) > 0) then
                for k,key in pairs(keys) do 
                    table.insert(keyList, key)
                end
            end
        end
    end

    if(self._extraDropDataList) then
        for k,v in pairs(self._extraDropDataList) do 
            local keys = v:getKeyList()
            if(keys and table.nums(keys) > 0) then
                for k,key in pairs(keys) do 
                    table.insert(keyList, key)
                end
            end
        end
    end

   return keyList
end

-- 判断是否没有获取
function ActivityData:checkNoGet(str)
    if(str == nil or str ~= "") then 
        return true 
    end

    return false
end

function ActivityData:updateLanguageKeyToStr()
    self._initRes = true
    if(self:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then 
        return
    end

    self.jumpStr = LanguageManager:getInstance():getLanguageWebStrForKey(self.jumpID)
    self.nameStr = LanguageManager:getInstance():getLanguageWebStrForKey(self.nameID)
    self.imgStr = LanguageManager:getInstance():getLanguageWebStrForKey(self.imgID)
    self.decStr = LanguageManager:getInstance():getLanguageWebStrForKey(self.decID)

    -- 更新子类处理逻辑
    if(self._questConditionDataList) then
        for k,v in pairs(self._questConditionDataList) do 
            v:updateLanguageKeyToStr()
        end
    end

    if(self._extraDropDataList) then
        for k,v in pairs(self._extraDropDataList) do 
            v:updateLanguageKeyToStr()
        end
    end
    
    -- 加载图片资源
    ImageDownLoadUtil:downLoadImage(self.imgStr)
end

function ActivityData:clearNew()
    self._isNew = false
    local globalData = GameDataManager:getInstance():getSaveGlobalData()
    if(globalData) then
        globalData:addClickActivity(self.id)
    end
    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end

function  ActivityData:getIsEnable()
    return self.isEnabled
end

function ActivityData:getIsShow()
    -- body
    if(self:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then 
        if(self._EmailBindData and self._EmailBindData:getIsBind()) then
            return false
        end

        return true
    elseif (self:getType() == PublicDefine.ActivityType.ActivityType_LuckyLottery) then 
        local master = GameDataManager:getInstance():getMaster()
        if self._lotteryData and master then
            if self._lotteryData:getLevelLimit() > master:getLevel() then
                return false
            end
        end
    elseif (self:getType() == PublicDefine.ActivityType.ActivityType_Festival) then 
        if self:getStatus() >= PublicDefine.ActivityRunningStat.ActivityRunningStat_Ending then
            return false
        end
    end

    if(self.isHide) then 
        return false
    end

    return true
end

-- 是否在作用范围中
function ActivityData:isInEffect()
    if(self.isEnabled == false) then
        return false
    end 

    if self.type == PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw and self.status ~= 5 then
        -- local data = {}
        -- data.showTime = self.showTime
        -- data.offTime = self.offTime
        -- data.endTime = self.endTime
        
        return true--mvc.activityAnnivesaryLotteryModel:getAnniversaryLotteryIsShowByData(data)
    end

    if(self.status == PublicDefine.ActivityRunningStat.ActivityRunningStat_Running) then
        return true
    else 
        return false
    end
end

function ActivityData:getID()
    return self.id
end

function ActivityData:getSortID()
    return self.sortID
end

function ActivityData:getType()
    return self.type
end

function ActivityData:getStatus()
    return self.status
end

function ActivityData:getStartTime()
    return self.startTime
end

function ActivityData:getEndTime()
    return self.endTime
end

function ActivityData:getIsDayRefresh()
    -- body

    return self.isDayRefresh
end

-- 判断是否完成,但没有领奖
function ActivityData:getIsHaveAward()
    if(self:isInEffect()) then 
        if(self._questConditionDataList) then
            for k,questConditionData in ipairs(self._questConditionDataList) do 
                if(questConditionData:getIsComplete() and questConditionData:getIsReceive() == false) then
                    return true
                end
            end
        end

        if(self._guildQuestConditionDataList) then
            for k,questConditionData in ipairs(self._guildQuestConditionDataList) do
                if(questConditionData:getIsComplete() and questConditionData:getIsReceive() == false) then
                    return true
                end
            end
        end

        if(self._exchangeDataList) then
            for k,questConditionData in ipairs(self._exchangeDataList) do
                if(questConditionData:getIsComplete() and questConditionData:getIsReceive() == false) then
                    return true
                end
            end
        end

        if (self._shareActivityData and self._shareActivityData:isHaveAward()) then
            return true
        end
    end

    return false
end

function ActivityData:getIsNew()
    -- 判断是否为NEW
    return self._isNew
end

function ActivityData:getIsHot()
    if(self.isHot == false or self.isHot == 0) then
        return false
    end
    
    return true
end

function ActivityData:getJumpStr()
    return self.jumpStr
end

function ActivityData:getName()
    if(self:getType() ~= PublicDefine.ActivityType.ActivityType_MailBind) then 
        return self.nameStr
    else 
        return LanguageManager:getInstance():getLocalString(self.nameID)
    end
end

function ActivityData:getImageName()
    if(self:getType() ~= PublicDefine.ActivityType.ActivityType_MailBind) then 
        return self.imgStr
    else 
        return string.format("%d.png", self.imgID)
    end
end

function ActivityData:getDecStr()
    if(self:getType() ~= PublicDefine.ActivityType.ActivityType_MailBind) then 
        return self.decStr
    else
        return LanguageManager:getInstance():getLocalString(self.decID)
    end
end

function ActivityData:getQuestCondition()
    return self._questConditionDataList
end

function ActivityData:getExchange()
    return self._exchangeDataList
end

function ActivityData:getGuildQuestCondition()
    return self._guildQuestConditionDataList
end

function ActivityData:getExtraDrop()
    return self._extraDropDataList
end

function ActivityData:getDiscountData()
    return self._discountDataList
end

function ActivityData:getLuckyWheelData()
    return self._luckyWheelActivityData
end

function ActivityData:getBlackData()
    return self._blackMarketActivityData
end

function ActivityData:getRandomShopData()
    return self._randomShopActivityData
end

function ActivityData:getCaveActivityData()
    return self._caveActivityData
end

function ActivityData:getEmailBindData()
    return self._EmailBindData
end

function ActivityData:getLotteryData()
    return self._lotteryData
end

function ActivityData:getFestivalData()
    return self._festivalData
end

function ActivityData:getShareActivityData()
    return self._shareActivityData
end

function ActivityData:getAnniversaryLotteryData()
    return self._anniversaryLotteryData
end

function ActivityData:getFestivalExchangeShopData()
    print("ActivityData:getFestivalExchangeShopData()", #self._exchangeShopDataArr)
    return self._exchangeShopDataArr
end

function ActivityData:refreshIsNew()
    local globalData = GameDataManager:getInstance():getSaveGlobalData()
    if(globalData and globalData:isHaveClickActivityID(self.id)) then
        self._isNew = false
    end
end
