--[[--
数据模型TradeActivityModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/09/15
--desc	: TradeActivityModel
------------------------------------------------------------------------------
local SdkManager = require "app.game.SdkManager"
local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require("utils.ProtobufUtil")
local TradeActivityModel = class("TradeActivityModel",mvc.GameModel)
local SceneManager = require("app.game.SceneManager")

-- 这里ID在列表里面，但是不会新添加显示，和 1000003//每日超值礼包 共用一个现实
local SPECIAL_TRADE_ACTIVITY_ID = 1000012
-- 水晶夺宝活动结束后，发送一次兑换多余兑换券消息标识
local sendOnceCrystalCapture = false

function TradeActivityModel:initData()
    -- 活动id对应的活动视图
    self.activityIdNameList = {
        [PublicDefine.TradeActivityIDList.TradeActivityFirstPay] = "TradeActivityFirstPay",
        [PublicDefine.TradeActivityIDList.TradeActivityGrowFund] = "TradeActivityGrowFund",
        [PublicDefine.TradeActivityIDList.TradeActivityDailyGiftBag] = "TradeActivityDailyGiftBag",
        [PublicDefine.TradeActivityIDList.TradeActivityDailyPay] = "TradeActivityDailyPay",
        [PublicDefine.TradeActivityIDList.TradeActivityLimitGiftCompetition] = "TradeActivityLimitGiftCompetition",
        -- 战力达人系列活动，因配置表删除，此处暂时注释
        -- [PublicDefine.TradeActivityIDList.TradeActivityPetGiftCompetition] = "TradeActivityLimitGiftCompetition",
        -- [PublicDefine.TradeActivityIDList.TradeActivityfashionGiftCompetition] = "TradeActivityLimitGiftCompetition",
        -- [PublicDefine.TradeActivityIDList.TradeActivityachieveGiftCompetition] = "TradeActivityLimitGiftCompetition",
        [PublicDefine.TradeActivityIDList.TradeActivityLottery] = "TradeActivityLottery",
        [PublicDefine.TradeActivityIDList.TradeActivityPrivilegeCard] = "TradeActivityPrivilegeCard",
        [PublicDefine.TradeActivityIDList.TradeActivityGroupPay] = "TradeActivityGroupPay",
        [PublicDefine.TradeActivityIDList.TradeActivityFightBack] = "TradeActivityFightBack",
        [PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund] = "TradeActivityNewGrowFund",
        [PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo] = "TradeActivityNewGrowFundTwo",
        [PublicDefine.TradeActivityIDList.TradeActivityEquipmentStarFund] = "TradeActivityEquipmentStarFund",
        [PublicDefine.TradeActivityIDList.TradeActivityGrowFundII] = "TradeActivityGrowFundII",
        [PublicDefine.TradeActivityIDList.TradeActivityGrowFund3] = "TradeActivityGrowFund3",

        [PublicDefine.TradeActivityIDList.TradeActivityTimeLimitedFightBack] = "TradeActivityTimeLimitedFightBack",
        
    }

    -- 活动目标列表
    self._targetList = {}
    -- 当前显示的活动ID
    self.curActivityID = nil
    -- 特惠礼包（首充）当前是否开启
    self.firstActivityIsOpenState = false
    -- 特惠礼包当先显示档次
    self.firstGiftGrade = 1
    -- 礼包购买记录
    self.giftBoughtList = {}
    -- 成长基金奖励
    self.growFundGotAwardsList = {}
    -- 成长基金是否购买
    self.growFundIsBuy = false
    -- 成长基金自动弹窗标识
    self.growFundAutoShowLv = 0
    -- 每日超值礼包数据
    self.dailyGiftData = {}

    -- 新成长基金奖励
    self.newGrowFundGotAwardsList = {}
    -- 新成长基金是否购买
    self.newGrowFundIsBuy = false
    -- 成长基金自动弹窗标识
    self.newGrowFundAutoShowLv = 0

    -- 2阶新成长基金奖励
    self.newGrowFundTwoGotAwardsList = {}
    -- 2阶新成长基金是否购买
    self.newGrowFundTwoIsBuy = false
    -- 2阶成长基金自动弹窗标识
    self.newGrowFundTwoAutoShowLv = 0

    -- 进阶成长基金奖励
    self.growFundIIGotAwardsList = {}
    -- 进阶成长基金是否购买
    self.growFundIIIsBuy = false
    -- 进阶成长基金自动弹窗标识
    self.growFundIIAutoShowLv = 0

    -- 三阶成长基金奖励
    self.growFund3GotAwardsList = {}
    -- 三阶成长基金是否购买
    self.growFund3IsBuy = false
    -- 三阶成长基金自动弹窗标识
    self.growFund3AutoShowLv = 0

    -- 领悟之书基金奖励
    self.graspBookFundGotAwardsList = {}
    self.graspBookFundIsBuy = false
end

-- 设置当前显示活动的ID
function TradeActivityModel:setCurActivityID(ID)
    self.curActivityID = ID
end

-- 获取当前显示活动的ID
function TradeActivityModel:getCurActivityID()
    return self.curActivityID
end

-- 获取缤纷活动按钮红点是否显示
function TradeActivityModel:getTradeActivityBtnRedPointIsShow()
    local tradeActivityList = self:getOpenActivityIdList()
    if table.nums(tradeActivityList) <= 0 then
        return false
    end

    for k, v in ipairs(tradeActivityList) do
        if self:getTabRedPointIsShow(v) then
            return true
        end
    end

    return false
end

-- 获取页签上红点是否显示
function TradeActivityModel:getTabRedPointIsShow(ID)
    local configData = ConfigManager:getTradeActivityDataByID(ID)

    if ID == PublicDefine.TradeActivityIDList.TradeActivityGrowFund then
        local gotList = self:getGrowFundGotAwardsList()
        if self:getGrowFundIsBuy() then
            for index = 1, #configData.exchange do
                if not gotList[configData.exchange[index]] 
                    and RoleDataManager:getMaster():getLevel() >= configData.exchange[index] then
                        return true
                end
            end
        end
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund then
        local gotList = self:getNewGrowFundGotAwardsList()
        if self:getNewGrowFundIsBuy() then
            for index = 1, #configData.exchange do
                if not gotList[configData.exchange[index]] 
                    and RoleDataManager:getMaster():getLevel() >= configData.exchange[index] then
                        return true
                end
            end
        end
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo then
        local gotList = self:getNewGrowFundTwoGotAwardsList()
        if self:getNewGrowFundTwoIsBuy() then
            for index = 1, #configData.exchange do
                if not gotList[configData.exchange[index]] 
                    and RoleDataManager:getMaster():getLevel() >= configData.exchange[index] then
                        return true
                end
            end
        end
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityDailyPay then
        local groupInfo = self:getActivityTargetByID(ID)
        if groupInfo and groupInfo[1] and groupInfo[1].stat == 2 then
            return true
        end
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityLimitGiftCompetition
        -- or ID == PublicDefine.TradeActivityIDList.TradeActivityPetGiftCompetition
        -- or ID == PublicDefine.TradeActivityIDList.TradeActivityfashionGiftCompetition
        -- or ID == PublicDefine.TradeActivityIDList.TradeActivityachieveGiftCompetition 
        then
        local group = self:getActivityTargetByID(ID)
        for k, v in ipairs(group) do
            if v.stat == 2 then
                return true
            end
        end
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityLottery then
        local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
        if activityData == nil then
            return false
        end
        local lotteryData = activityData:getLotteryData()
        if lotteryData == nil then
            return false
        end
        local endTime = activityData:getEndTime() + GameManager:getEPOCHTime() - GameManager:getNowServerTime()
        local time = lotteryData:getRemianRefreshTime()
        if endTime > 0 and time <= 0 then
            return true
        end
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityPrivilegeCard then
        -- 如果可以领取, 显示领取, 有月卡剩余天数, 显示剩余天数
		local monthCardRestDay = self:getMonthCardRestDay()
		local freeDiamondReward = tonumber(ConfigManager:getMonthCardDaily())

		-- 有月卡/订阅或者有免费还没领
		if (monthCardRestDay > 0 or (freeDiamondReward > 0 and not self:AlreayGotSupply()))then 
			-- 更新领取按钮显示
			if (not self:AlreayGotSupply()) then
				return true
			end
        end

        local heroData = GameDataManager:getInstance():getMaster()
		if (heroData and heroData:getIsLifeTimeMember()) then
			if (mvc.tradeActivityModel:haveLifeTimeMembershipReward()) then
				return true
			end
		end
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityDailyGiftBag then
        if(self:getSpecialFreeDailyGiftData()) then 
            return true
        end
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityGrowFundII then
        local gotList = self:getGrowFundIIGotAwardsList()
        if self:getGrowFundIIIsBuy() then
            for index = 1, #configData.exchange do
                if not gotList[configData.exchange[index]] 
                    and RoleDataManager:getMaster():getLevel() >= configData.exchange[index] then
                        return true
                end
            end
        end
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityGrowFund3 then
        local gotList = self:getGrowFund3GotAwardsList()
        if self:getGrowFund3IsBuy() then
            for index = 1, #configData.exchange do
                if not gotList[configData.exchange[index]] 
                    and RoleDataManager:getMaster():getLevel() >= configData.exchange[index] then
                        return true
                end
            end
        end
    end

    return false
end

-- 获取开启活动的名称列表
function TradeActivityModel:getOpenActivityIdList()
    local openActivityId = {}

    -- 遍历配置表，查询是否符合开启条件且在开启时间内
    local tradeActivityConfig = ConfigManager:getTradeActivityData()
    for k, v in pairs(tradeActivityConfig) do
        if self:getActivityIsOpeningByID(v.ID) then
            table.insert(openActivityId, v.ID)
        end
    end

    table.sort(openActivityId, function(a, b)
        local aPos = ConfigManager:getTradeActivityDataByID(a).sortID
        local bPos = ConfigManager:getTradeActivityDataByID(b).sortID
        return aPos < bPos
    end)

    return openActivityId
end

-- 获取缤纷活动中活动开关列表
function TradeActivityModel:getOpenTradeActivityIdList()
    local openActivityList = {}
    -- 遍历配置表，查询是否符合开启条件且在开启时间内
    local tradeActivityConfig = ConfigManager:getTradeActivityData()
    for k, v in pairs(tradeActivityConfig) do
        -- if(v.ID ~= SPECIAL_TRADE_ACTIVITY_ID) then 
        if self:isAddToOpenActivityList(v.ID) then
            if v.sortID ~= 0 and self:getActivityIsOpeningByID(v.ID) then
                table.insert(openActivityList, v.ID)
            end
        end
    end

    table.sort(openActivityList, function(a, b)
        local aPos = ConfigManager:getTradeActivityDataByID(a).sortID
        local bPos = ConfigManager:getTradeActivityDataByID(b).sortID
        return aPos < bPos
    end)

    return openActivityList
end

-- 根据活动ID获取活动视图名
function TradeActivityModel:getActivityViewNameByID(ID)
    return self.activityIdNameList[ID]
end

-- 根据活动ID获取活动是否达到开启条件--
function TradeActivityModel:getActivityCanOpenByID(ID)
    local unlockID = ConfigManager:getTradeActivityDataByID(ID).unlockId
    -- 为0默认无限制
    if unlockID == 0 or RoleDataManager:isUnlockByFunctionType(unlockID) then
        return true
    else
        return false
    end
end

-- 获取活动ID剩余时间 (天时)
function TradeActivityModel:getActivityRemainTimeByID(ID)
    local tradeActivityConfig = ConfigManager:getTradeActivityDataByID(ID)
    -- local nowTime = nowTime or GameManager:getNormalServerTime()
    if tradeActivityConfig.timeType == 0 then
        local endTime = GameManager:getUnixTimeByConfigTimeStr(tradeActivityConfig.endTime)
        return AvalonUtil:getNewFullFormatTime(endTime,Game.TIME_LEVEL.TIME_LEVEL_HOUR)
    end

    return ""
end

-- 根据活动ID获取活动是否在开启时间内
function TradeActivityModel:getActivityIsOpeningTimeByID(ID, nowTime)
    local tradeActivityConfig = ConfigManager:getTradeActivityDataByID(ID)
    local nowTime = nowTime or GameManager:getNormalServerTime()
    -- 永久开启
    if tradeActivityConfig.timeType == -1 then
        return true
    -- 根据配置决定开启和关闭时间
    elseif tradeActivityConfig.timeType == 0 then
        local startTime = GameManager:getUnixTimeByConfigTimeStr(tradeActivityConfig.startTime)
        local endTime = GameManager:getUnixTimeByConfigTimeStr(tradeActivityConfig.endTime)
        -- 比较时间为标准时间
        if nowTime >= startTime and nowTime <= endTime then
            return true
        else
            if (ID == PublicDefine.TradeActivityIDList.TradeActivityCrystalTreature) and (not sendOnceCrystalCapture) and SceneManager:getInstance():isNotInFightScene() then
                -- 登录时同步水晶夺宝活动是否已经结束，来判断背包里是否还有多余的没有使用的兑换券，
                -- 需要替换成水晶奖励。
                -- CS 水晶夺宝请求重置
                sendOnceCrystalCapture = true
                local messageData = {}
                messageData.version = 0
                Net.Helper:sendMessage(NetMessageType.PLAY_RESPONSE_Crystal_Capture_HuntWhenEnd,messageData)
            end

            return false
        end
    -- 以玩家在服建号时间为准的开启时间
    elseif tradeActivityConfig.timeType == 1 then
        local createTime = RoleDataManager:getMaster():getHeroCreateTime()
        -- 配置表玩家建号时间初始基准为当日服务器0时
        createTime = math.floor(createTime/86400) * 86400
        local startTime = (tonumber(tradeActivityConfig.startTime) -1) * 86400 + createTime
        local endTime = tonumber(tradeActivityConfig.endTime) * 86400 + createTime

        if (nowTime >= startTime or tonumber(tradeActivityConfig.startTime) == 0) 
            and (nowTime <= endTime or tonumber(tradeActivityConfig.endTime) == 0) then
                return true
        else
            return false
        end
    end
end

-- 根据活动ID获取活动是否达到独自特殊开启条件
function TradeActivityModel:getActivityOpenWithSpecialCondition(ID)
    local tradeActivityConfig = ConfigManager:getTradeActivityDataByID(ID)

    -- 首充活动：领取完毕关闭
    if ID == PublicDefine.TradeActivityIDList.TradeActivityFirstPay then
        return (not self:getFirstPayIsOver())
    -- 成长基金：领取完毕关闭,后台无礼包关闭
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityGrowFund then
        if not self:getGrowFundGiftData(PublicDefine.TradeActivityIDList.TradeActivityGrowFund) or table.nums(self.growFundGotAwardsList) >= #tradeActivityConfig.exchange then
            return false
        end
    -- 新成长基金：领取完毕关闭,后台无礼包关闭
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund then
        if not self:getGrowFundGiftData(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund) or table.nums(self.newGrowFundGotAwardsList) >= #tradeActivityConfig.exchange then
            return false
        end
    -- 2阶新成长基金：领取完毕关闭,后台无礼包关闭
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo then

        return self:newGrowFundTwoCanBeOpened()

    -- 进阶成长基金：领取完毕关闭,后台无礼包关闭
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityGrowFundII then
        if not self:getGrowFundGiftData(PublicDefine.TradeActivityIDList.TradeActivityGrowFundII) or table.nums(self.growFundIIGotAwardsList) >= #tradeActivityConfig.exchange then
            return false
        end
        if RoleDataManager:getMaster():getLevel() < 50 or not self.growFundIsBuy  then
            return false
        end
    -- 三阶成长基金：领取完毕关闭,后台无礼包关闭
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityGrowFund3 then
        if not self:getGrowFundGiftData(PublicDefine.TradeActivityIDList.TradeActivityGrowFund3) or table.nums(self.growFund3GotAwardsList) >= #tradeActivityConfig.exchange then
            return false
        end
        if RoleDataManager:getMaster():getLevel() < 80 or not self.growFundIIIsBuy  then
            return false
        end
    -- 进阶成长基金：领取完毕关闭,后台无礼包关闭
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityEquipmentStarFund then
        if not self:getGrowFundGiftData(PublicDefine.TradeActivityIDList.TradeActivityEquipmentStarFund) or table.nums(self.graspBookFundGotAwardsList) >= #tradeActivityConfig.exchange then
            return false
        end
    -- 超值礼包：后台没有配置礼包的话关闭
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityDailyGiftBag then
        return table.nums(mvc.limitTimePackageModel.iapProducts) > 0 or self:getSpecialFreeDailyGiftData() ~= nil
    -- 每日充值：没有服务器下发的任务数据则关闭
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityDailyPay then
        local group = self:getActivityTargetByID(ID)
        if not group or table.nums(group) <= 0 then
            return false
        end
    -- 战力达人系列：没有服务器下发的任务数据则关闭
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityLimitGiftCompetition
        -- or ID == PublicDefine.TradeActivityIDList.TradeActivityPetGiftCompetition
        -- or ID == PublicDefine.TradeActivityIDList.TradeActivityfashionGiftCompetition
        -- or ID == PublicDefine.TradeActivityIDList.TradeActivityachieveGiftCompetition 
        then
        local group = self:getActivityTargetByID(ID)
        if not group or table.nums(group) <= 0 then
            return false
        end
    -- 幸运冒险
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityLottery then
        local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
        if not activityData or activityData:getLotteryData():getLevelLimit() > RoleDataManager:getMaster():getLevel() then
            return false
        end
    -- 特权礼包
    elseif ID == PublicDefine.TradeActivityIDList.TradeActivityPrivilegeCard then
        local datas = SdkManager:getInstance():getShowIapDatas()
        local isShow = false
        if datas then
            for i, v in ipairs(datas) do
                if (v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_MONTH_CARD or
                    v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.LifeTimeMembership or 
                    v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.MonthlySubscription) 
                    and not ServerConfigUtil:isInReview() 
                then
                    isShow = true
                    break
                end
            end
        end
        if not isShow then
            return false
        end
    end

    return true
end

-- 根据活动ID获取活动是否达到开启条件
function TradeActivityModel:getActivityIsOpeningByID(ID)
    if not self:getActivityCanOpenByID(ID) then
        return false
    end

    if not self:getActivityIsOpeningTimeByID(ID) then
        return false
    end

    if not self:getActivityOpenWithSpecialCondition(ID) then
        return false
    end

    return true
end

-- 根据活动ID获取活动时间范围
function TradeActivityModel:getActivityOpeningStrByID(ID)
    local tradeActivityConfig = ConfigManager:getTradeActivityDataByID(ID)
    -- 永久开启
    if tradeActivityConfig.timeType == -1 then
        return nil
    -- 根据配置决定开启和关闭时间
    elseif tradeActivityConfig.timeType == 0 then
        local startDate = GameManager:getClientDateByConfigTimeStr(tradeActivityConfig.startTime, "%m.%d")
        local endDate = GameManager:getClientDateByConfigTimeStr(tradeActivityConfig.endTime, "%m.%d")

        return string.format(UI.TEXT_1324530, startDate , endDate)
    -- 以玩家在服建号时间为准的开启时间
    elseif tradeActivityConfig.timeType == 1 then
        local createTime = RoleDataManager:getMaster():getHeroCreateTime()
        -- 配置表玩家建号时间初始基准为当日服务器0时
        createTime = math.floor(createTime/86400) * 86400
        local startTime = (tonumber(tradeActivityConfig.startTime) -1) * 86400 + createTime
        if tonumber(tradeActivityConfig.startTime) == 0 then
            startTime = createTime
        end
        -- 显示是当天结束，所以这里需要减去一天
        local endTime = tonumber(tradeActivityConfig.endTime - 1) * 86400 + createTime

        local startDate = os.date("%m.%d", startTime  + GameManager:getEPOCHTime() - GameManager:getServerDifferArea())
        local endDate = os.date("%m.%d", endTime  + GameManager:getEPOCHTime() - GameManager:getServerDifferArea())

        if tonumber(tradeActivityConfig.endTime) == 0 then
            return string.format(UI.TEXT_1324530, startDate , "")
        end

        return string.format(UI.TEXT_1324530, startDate , endDate)
    end
end

-- 礼包校对失败
function TradeActivityModel:onGetOrderError(data)
    -- 再请求一次商品数据
    local SdkBox = require("utils.sdkbox.SdkBox")
    local myChannel = SdkBox:getInstance():getVersionChannel()
    Net.NetPurchaseSystem:reqProducts(nil,nil,myChannel)
end

-- 支付失败
function TradeActivityModel:onSdkPayFail(params)
    -- 再请求一次商品数据
    local SdkBox = require("utils.sdkbox.SdkBox")
    local myChannel = SdkBox:getInstance():getVersionChannel()
    -- CO-15674  【商城】客户端请求商品列表异常处理(SDK异常回调)
    -- Net.NetPurchaseSystem:reqProducts(nil,nil,myChannel)
end

-- 支付成功
function TradeActivityModel:onSdkPaySuccess(productID)

end

-- 后台礼包数据进行刷新
function TradeActivityModel:refreshGiftData()
    -- 刷新成长基金购买按钮
    self:setForce("growFundIsBuy")
    -- 刷新新成长基金购买按钮
    self:setForce("newGrowFundIsBuy")
    -- 刷新2阶新成长基金购买按钮
    self:setForce("newGrowFundTwoIsBuy")
    -- 刷新每日礼包显示
    self:setForce("dailyGiftData")
    -- 特惠礼包，这里需要特别地刷新一下按钮显示
    self:refreshFirstGiftOpenState()
    self:setForce("firstGiftGrade")
    -- 刷新进阶长基金购买按钮
    self:setForce("growFundIIIsBuy")
    -- 刷新进阶长基金购买按钮
    self:setForce("graspBookFundIsBuy")
    -- 刷新三阶长基金购买按钮
    self:setForce("growFund3IsBuy")

    -- 刷新缤纷活动页签显示
    Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_REFRESH)
end

-- [[获取礼包购买的数据]]
function TradeActivityModel:refreshGiftBoughtData(GiftType)
    local types = {}
    local needs = {}

    local iapDatas = SdkManager:getInstance():getIapDatas()
    if iapDatas then
        for k, v in pairs(iapDatas) do
            if v.label == GiftType then
                table.insert(needs, v.productID)
                types[tostring(v.productID)]= v.label
            end
        end
    end

    if table.nums(types) == 0 then
        return
    end

    local boughts = SdkManager:getInstance():getBoughts()
    if boughts == nil then
        SdkManager:getInstance():reqBoughtNum(needs,types)
    else
        local find = false
        for i, v in ipairs(needs) do
            find = false
            for i1,v1 in ipairs(boughts) do
                if v == v1.productID then
                    find = true
                    break
                end
            end
            if not find then
                SdkManager:getInstance():reqBoughtNum(needs,types)
                break
            end
        end
    end
end

-- 接收礼包购买数据
function TradeActivityModel:setGiftBoughtData(data)
    for k, v in pairs(data.boughtNum) do
        if not self.giftBoughtList[v.productID] or self.giftBoughtList[v.productID] ~= v.boughtNum then
            self.giftBoughtList[v.productID] = v.boughtNum
        end
    end

    self:setForce("giftBoughtList")
end

-- 获取礼包购买数据
function TradeActivityModel:getGiftBoughtData()
    return self.giftBoughtList
end

-- 接收服务器下发缤纷活动数据
function TradeActivityModel:setNetData(data)
    -- 设置成长基金数据
    if ProtobufUtil:checkFieldIsInit(data, "levelFund") then
        self:setGrowFundData(data.levelFund)
    end

    -- 设置特惠礼包购买档次(这里是购买的上个档次标记)
    if ProtobufUtil:checkFieldIsInit(data, "purchaseFirstIndex") then
        self:setFirstGrade(data.purchaseFirstIndex + 1)
    end
end

-- 设置成长基金数据
function TradeActivityModel:setGrowFundData(datas)

    for k,data in pairs(datas) do
        -- 成长基金未开启且购买时间在活动时间内
        if ProtobufUtil:checkFieldIsInit(data, "purchaseTime") 
            and (not self.growFundIsBuy 
            or not self.newGrowFundIsBuy 
            or not self.newGrowFundTwoIsBuy 
            or not self.growFundIIIsBuy
            or not self.growFund3IsBuy) 
            and self:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityGrowFund, data.purchaseTime) then
                
                if (data.id == PublicDefine.TradeActivityIDList.TradeActivityGrowFund) then
                    self:set("growFundIsBuy", true)
                elseif (data.id == PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund) then
                    self:set("newGrowFundIsBuy", true)
                elseif (data.id == PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo) then
                    self:set("newGrowFundTwoIsBuy", true)
                elseif (data.id == PublicDefine.TradeActivityIDList.TradeActivityGrowFundII) then
                    self:set("growFundIIIsBuy", true)
                elseif (data.id == PublicDefine.TradeActivityIDList.TradeActivityEquipmentStarFund) then
                    self:set("graspBookFundIsBuy", true)    
                elseif (data.id == PublicDefine.TradeActivityIDList.TradeActivityGrowFund3) then
                    self:set("growFund3IsBuy", true) 
                end
        end

        if ProtobufUtil:checkFieldIsInit(data, "claimData") then
            for k, v in ipairs(data.claimData) do
                self:setGrowFundGotList(v, true, data.id)
            end
        end
    end
end

-- 设置成长基金数据
function TradeActivityModel:setGrowFundGotList(claimData, isInit, activityId)
    if (activityId == 1000002) then
        if self:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityGrowFund, claimData.claimTime) and not self.growFundGotAwardsList[claimData.claimLevel] then
            self.growFundGotAwardsList[claimData.claimLevel] = claimData.claimTime
    
            if not isInit then
                UI.ScrollBar:createByText(UI.TEXT_1212026)
                self:setForce("growFundGotAwardsList", self.growFundGotAwardsList)
            end
        end
    elseif (activityId == 1000019) then
        if self:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityGrowFund, claimData.claimTime) and not self.newGrowFundGotAwardsList[claimData.claimLevel] then
            self.newGrowFundGotAwardsList[claimData.claimLevel] = claimData.claimTime
    
            if not isInit then
                UI.ScrollBar:createByText(UI.TEXT_1212026)
                self:setForce("newGrowFundGotAwardsList", self.newGrowFundGotAwardsList)
            end
        end
    elseif (activityId == 1000024) then
        if self:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo, claimData.claimTime) and not self.newGrowFundTwoGotAwardsList[claimData.claimLevel] then
            self.newGrowFundTwoGotAwardsList[claimData.claimLevel] = claimData.claimTime
            if not isInit then
                UI.ScrollBar:createByText(UI.TEXT_1212026)
                self:setForce("newGrowFundTwoGotAwardsList", self.newGrowFundTwoGotAwardsList)
            end
        end
    elseif (activityId == 1000020) then
        if self:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityEquipmentStarFund, claimData.claimTime) and not self.graspBookFundGotAwardsList[claimData.claimLevel] then
            self.graspBookFundGotAwardsList[claimData.claimLevel] = claimData.claimTime
    
            if not isInit then
                UI.ScrollBar:createByText(UI.TEXT_1212026)
                self:setForce("graspBookFundGotAwardsList", self.graspBookFundGotAwardsList)
            end
        end
        
    elseif (activityId == 1000021) then
        if self:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityGrowFund, claimData.claimTime) and not self.growFundIIGotAwardsList[claimData.claimLevel] then
            self.growFundIIGotAwardsList[claimData.claimLevel] = claimData.claimTime
    
            if not isInit then
                UI.ScrollBar:createByText(UI.TEXT_1212026)
                self:setForce("growFundIIGotAwardsList", self.growFundIIGotAwardsList)
            end
        end
    elseif (activityId == PublicDefine.TradeActivityIDList.TradeActivityGrowFund3) then
        if self:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityGrowFund3, claimData.claimTime) and not self.growFund3GotAwardsList[claimData.claimLevel] then
            self.growFund3GotAwardsList[claimData.claimLevel] = claimData.claimTime
    
            if not isInit then
                UI.ScrollBar:createByText(UI.TEXT_1212026)
                self:setForce("growFund3GotAwardsList", self.growFund3GotAwardsList)
            end
        end
    end
    
end

-- 获取成长基金是否购买
function TradeActivityModel:getGrowFundIsBuy()
    return self.growFundIsBuy
end

-- 获取新成长基金是否购买
function TradeActivityModel:getNewGrowFundIsBuy()
    return self.newGrowFundIsBuy
end

-- 获取2阶新成长基金是否购买
function TradeActivityModel:getNewGrowFundTwoIsBuy()
    return self.newGrowFundTwoIsBuy
end

-- 获取进阶成长基金是否购买
function TradeActivityModel:getGrowFundIIIsBuy()
    return self.growFundIIIsBuy
end

-- 获取领悟之书基金是否购买
function TradeActivityModel:getGraspBookFund()
    return self.graspBookFundIsBuy
end

-- 获取三阶成长基金是否购买
function TradeActivityModel:getGrowFund3IsBuy()
    return self.growFund3IsBuy
end

-- 获取成长基金礼包
function TradeActivityModel:getGrowFundGiftData(activityId)
    local growFundGiftData = nil
    local iapDatas = SdkManager:getInstance():getIapDatas()
    for k, v in pairs(iapDatas) do
        if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.LevelFund then

            if ProtobufUtil:checkFieldIsInit(v, "ext") and v.ext ~= nil and v.ext ~= "'" then
                xpcall(function()
                    local extParam = json.decode(v.ext)
                    if not extParam.levelFundId and activityId == PublicDefine.TradeActivityIDList.TradeActivityGrowFund then
                        growFundGiftData = v
                    elseif extParam.levelFundId == activityId then
                        -- dump(extParam, "getGrowFundGiftData121")
                        growFundGiftData = v
                    -- elseif activityId == PublicDefine.TradeActivityIDList.TradeActivityGrowFundII then
                    --     growFundGiftData = v
                    end
                end, 
                function(e) 
                end, 1)
            end

            -- growFundGiftData = v
            -- break
        end
    end

    return growFundGiftData
end

-- 获取成长基金领取数据
function TradeActivityModel:getGrowFundGotAwardsList()
    return self.growFundGotAwardsList
end

-- 获取新成长基金领取数据
function TradeActivityModel:getNewGrowFundGotAwardsList()
    return self.newGrowFundGotAwardsList
end

-- 获取新成长基金领取数据
function TradeActivityModel:getNewGrowFundTwoGotAwardsList()
    return self.newGrowFundTwoGotAwardsList
end

-- 获取进阶成长基金领取数据
function TradeActivityModel:getGrowFundIIGotAwardsList()
    return self.growFundIIGotAwardsList
end

-- 获取领悟之书基金领取数据
function TradeActivityModel:getGrasBookFundGotAwardsList()
    return self.graspBookFundGotAwardsList
end

-- 获取三阶成长基金领取数据
function TradeActivityModel:getGrowFund3GotAwardsList()
    return self.growFund3GotAwardsList
end

-- 设置返回城镇成长基金是否弹窗(弹窗等级为0时不弹窗)
function TradeActivityModel:setGrowFundTipsShow(lv)
    self.growFundAutoShowLv = lv
end

-- 获取返回城镇成长基金是否弹窗(弹窗等级为0时不弹窗)
function TradeActivityModel:getGrowFundTipsShow()
    return self.growFundAutoShowLv
end

-- 设置返回城镇新成长基金是否弹窗(弹窗等级为0时不弹窗)
function TradeActivityModel:setNewGrowFundTipsShow(lv)
    self.newGrowFundAutoShowLv = lv
end

-- 获取返回城镇成长新基金是否弹窗(弹窗等级为0时不弹窗)
function TradeActivityModel:getNewGrowFundTipsShow()
    return self.newGrowFundAutoShowLv
end

-- 设置返回城镇2阶新成长基金是否弹窗(弹窗等级为0时不弹窗)
function TradeActivityModel:setNewGrowFundTwoTipsShow(lv)
    self.newGrowFundTwoAutoShowLv = lv
end

-- 获取返回城镇2阶成长新基金是否弹窗(弹窗等级为0时不弹窗)
function TradeActivityModel:getNewGrowFundTwoTipsShow()
    return self.newGrowFundTwoAutoShowLv
end

-- 设置返回城镇进阶成长基金是否弹窗(弹窗等级为0时不弹窗)
function TradeActivityModel:setNewGrowFundIITipsShow(lv)
    self.growFundIIAutoShowLv = lv
end

-- 获取返回城镇进阶成长基金是否弹窗(弹窗等级为0时不弹窗)
function TradeActivityModel:getGrowFundIITipsShow()
    return self.growFundIIAutoShowLv
end

-- 获取返回城镇三阶成长基金是否弹窗(弹窗等级为0时不弹窗)
function TradeActivityModel:getGrowFund3TipsShow()
    return self.growFund3AutoShowLv
end

-- 设置返回城镇三阶成长基金是否弹窗(弹窗等级为0时不弹窗)
function TradeActivityModel:setNewGrowFund3TipsShow(lv)
    self.growFund3AutoShowLv = lv
end

-- 设置每日超值礼包数据
function TradeActivityModel:setDailyGiftData(data)
    -- 排序
    local curData = data
    table.sort(curData.slotData, function (a, b)
        return a.treasureSlot < b.treasureSlot
    end)
    self:set("dailyGiftData", data)
end

-- 获取每日超值礼包数据
function TradeActivityModel:getDailyGiftData()
    return self.dailyGiftData
end

-- 获取每日超值礼包数据的每日免费
function TradeActivityModel:getSpecialFreeDailyGiftData()
    local data = self:getActivityTargetByID(SPECIAL_TRADE_ACTIVITY_ID)
    -- 这里状态等于3就表示已经完成了
    if(data) then
        for k,v in ipairs(data) do 
            if(v.stat == 3) then 
                return nil
            end
        end
    end

    return data
end

-- 刷新特惠礼包入口按钮显示状态
function TradeActivityModel:refreshFirstGiftOpenState()
    -- 判断特惠礼包显示状态是否改变，刷新按钮入口显示
    if self.firstActivityIsOpenState ~= self:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityFirstPay) then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
    end
    self.firstActivityIsOpenState = self:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityFirstPay)
end

-- 设置特惠礼包当前档次
function TradeActivityModel:setFirstGrade(grade)

    self:set("firstGiftGrade", grade)

    self:refreshFirstGiftOpenState()
end

-- 获取特惠礼包当前档次
function TradeActivityModel:getFirstGrade()
    return self.firstGiftGrade
end

-- 获取首充礼包是否购买完毕，其中礼包购买完毕、无后台礼包配置、后台礼包与配置数量不一致均返回true
function TradeActivityModel:getFirstPayIsOver()
    local firstPayGiftData = self:getFirstPayGiftData()
    local giftGrade = self:getFirstGrade()

    -- 没有获取到后台配置的特惠礼包，配置错误
    if not firstPayGiftData then
        return true
    end

    -- 搜索不到当前档次的礼包（后台配置问题或者已经购买完毕）
    if not firstPayGiftData[giftGrade] then
        return true
    end

    -- 当后台礼包配置与活动配置表数量不一致时，关闭显示（防止玩家购买错误配置内容）
    local configData = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityFirstPay)
    if table.nums(firstPayGiftData) ~= #configData.exchange then
        return true
    end

    return false
end

-- 获取首充礼包
function TradeActivityModel:getFirstPayGiftData()
    local firstPayGiftData = nil
    local iapDatas = SdkManager:getInstance():getIapDatas()
    for k, v in pairs(iapDatas) do
        if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_EXTRA_GIFT then
            if not firstPayGiftData then
                firstPayGiftData = {}
            end

            if firstPayGiftData[v.specialOfferIndex] then
                -- 如果遇到后台不同礼包同档次情况，直接返回nil不显示特惠礼包
                return nil
            else
                firstPayGiftData[v.specialOfferIndex] = v
            end
        end
    end

    return firstPayGiftData
end

-- 月卡、终身卡
function TradeActivityModel:haveLifeTimeMembershipReward()
	local have = false
	local heroData = GameDataManager:getInstance():getMaster()
	if (heroData and heroData:getIsLifeTimeMember() and not heroData:getIsLifeTimeGiftReceivedToday()) then
		have = true
	end
	return have
end

function TradeActivityModel:haveMonthCardReward()
    local have = false
	if (mvc.tradeActivityModel:getMonthCardRestDay() > 0) and not mvc.tradeActivityModel:AlreayGotSupply() then
		have = true
	end
	return have
end

function TradeActivityModel:haveSubCardReward()
    local have = false
	if (mvc.tradeActivityModel:getSubsMonthCardRestDay() > 0) and not mvc.tradeActivityModel:subsMonthAlreayGotSupply() then
		have = true
	end
	return have
end

function TradeActivityModel:getMonthCardRestDay()
    local heroData = GameDataManager:getInstance():getMaster()
	local currentDay = heroData:getRefreshDay() or 0
	local monthCardDay = heroData:getMonthCardDay() or 0
	return monthCardDay - currentDay
end

function TradeActivityModel:getSubsMonthCardRestDay()
    local heroData = GameDataManager:getInstance():getMaster()

	return heroData:getSubDaysLeft() or 0
end

function TradeActivityModel:subsMonthAlreayGotSupply()
	local heroData = GameDataManager:getInstance():getMaster()
	local currentDay = heroData:getRefreshDay() or 0
	local getSupplyData = heroData:getSubsMonthSupplyReceiveDay() or 0
	local already = false
	if currentDay == getSupplyData then
		already = true
	end
	return already
end

function TradeActivityModel:AlreayGotSupply()
	local heroData = GameDataManager:getInstance():getMaster()
	local currentDay = heroData:getRefreshDay() or 0
	local getSupplyData = heroData:getSupplyReceiveDay() or 0
	local already = false
	if currentDay == getSupplyData then
		already = true
	end
	return already
end

-- 获取服务器发送的活动目标信息
function TradeActivityModel:initNetActivityTarget(data)
    for k, group in ipairs(data) do
        if not self._targetList[group.groupId] then
            self._targetList[group.groupId] = {}
        end

        for index, target in ipairs(group.targets) do
            local targetInfo = {}
            targetInfo.sudId = target.sudId
            targetInfo.stat = target.stat
            targetInfo.count = target.count
            targetInfo.claimTime = target.claimTime
            targetInfo.groupId = group.groupId

            local activity = Config.TargetConfig:getTargetConfigById(tonumber(target.sudId))
            targetInfo.target = activity.param[2]
            targetInfo.desc = activity.desc
            targetInfo.rewardid = activity.rewardid
            targetInfo.rewardnum = activity.rewardnum
            targetInfo.type = activity.type

            self._targetList[group.groupId][index] = targetInfo
        end
    end
end

-- 设置活动目标数据
function TradeActivityModel:setActivityTarget(target, groupId)
    UI.WaitingLayer:hideWaiting()

    if not self._targetList[groupId] then
        self._targetList[groupId] = {}
    end

    for k, v in pairs(self._targetList[groupId]) do
        if v.sudId == target.sudId then
            v.stat = target.stat
            v.count = target.count
            v.claimTime = target.claimTime
            break
        end
    end

    local data = {}
    data.target = target
    data.groupId = groupId
    self:setForce("_targetList", data)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_REFRESH)
end

-- 根据活动ID获取目标列表
function TradeActivityModel:getActivityTargetByID(ID)
    return self._targetList[ID]
end

-- 获取所有目标数据
function TradeActivityModel:getAllActivityTarget()
    return self._targetList
end

-- 2阶魂器成长礼包开启条件
function TradeActivityModel:newGrowFundTwoCanBeOpened()
    local tradeActivityConfig = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo)
    if not self:getGrowFundGiftData(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo) or table.nums(self.newGrowFundTwoGotAwardsList) >= #tradeActivityConfig.exchange then
        return false
    end
    if not self.newGrowFundIsBuy  then
        return false
    end

    local tradeActivityConfig2 = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund)
    if self:getGrowFundGiftData(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund) and table.nums(self.newGrowFundGotAwardsList) < #tradeActivityConfig2.exchange then
        return false
    end

    return true
end

-- 是否添加到福利活动列表
function TradeActivityModel:isAddToOpenActivityList(activityId)
    local isAdd = true
    if activityId == SPECIAL_TRADE_ACTIVITY_ID or 
    activityId == PublicDefine.TradeActivityIDList.TradeActivityAppointmentTask or 
    activityId == PublicDefine.TradeActivityIDList.TradeActivityAppointmentCoinReward or 
    activityId == PublicDefine.TradeActivityIDList.TradeActivityAppointmentServerReward then
        isAdd = false
    end
    return isAdd
end


return TradeActivityModel