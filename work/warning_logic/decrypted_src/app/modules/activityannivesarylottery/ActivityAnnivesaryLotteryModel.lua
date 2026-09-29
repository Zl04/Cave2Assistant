--[[--
数据模型ActivityAnnivesaryLotteryModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/17
--desc	: ActivityAnnivesaryLotteryModel
------------------------------------------------------------------------------

local ActivityAnnivesaryLotteryModel = class("ActivityAnnivesaryLotteryModel",mvc.GameModel)
local SdkManager = require "app.game.SdkManager"
local SdkBox = require("utils.sdkbox.SdkBox")


function ActivityAnnivesaryLotteryModel:initData()
    self.activityData = {}
    self.anniversaryLotteryData = {}
	self.isEnabled = false
    self._giftData = {}
    self.rewardRoster = {}
end

function ActivityAnnivesaryLotteryModel:setAnniversaryLotteryActivityData(data)
	self.activityData[data.signType] = data
end

function ActivityAnnivesaryLotteryModel:setAnniversaryLotteryData(data)
	self.anniversaryLotteryData[data.signType] = data
end

function ActivityAnnivesaryLotteryModel:isCanSign(signType)
	-- local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)
    -- local anniversaryLotteryData = activityData:getAnniversaryLotteryData()
    local activityData = self:getAnnivesaryLotteryActivityData(signType)--self.activityData[signType]
    if not activityData then
        return false
    end
    local anniversaryLotteryData = activityData:getAnniversaryLotteryData()--self.anniversaryLotteryData[signType]
    local startTime = activityData.startTime
    local signEndTime = anniversaryLotteryData.signEndTime
    local nowTime = GameManager:getNormalServerTime()
    print("isCanSign: ", startTime, signEndTime, nowTime, nowTime >= startTime, nowTime <= signEndTime )
    -- 比较时间为标准时间
    if nowTime >= startTime and nowTime <= signEndTime then
        return true
    else
        return false
    end
end

function ActivityAnnivesaryLotteryModel:isSignOpening(signType)
	-- local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)
    -- local anniversaryLotteryData = activityData:getAnniversaryLotteryData()
    local activityData = self:getAnnivesaryLotteryActivityData(signType)--self.activityData[signType]
    if not activityData then
        return false
    end
    local anniversaryLotteryData = activityData:getAnniversaryLotteryData()--self.anniversaryLotteryData[signType]
    local startTime = activityData.startTime
    local signEndTime = anniversaryLotteryData.signEndTime
    local nowTime = GameManager:getNormalServerTime()
    print("isSignOpening: ", startTime, signEndTime, nowTime, nowTime >= startTime, nowTime <= signEndTime )
    -- 比较时间为标准时间
    if nowTime >= startTime then
        return true
    else
        return false
    end
end

function ActivityAnnivesaryLotteryModel:isSignEnd(signType)
    local activityData = self:getAnnivesaryLotteryActivityData(signType)
    local anniversaryLotteryData = activityData:getAnniversaryLotteryData()
    if not activityData or not anniversaryLotteryData then
        return false
    end
    local startTime = activityData.startTime
    local signEndTime = anniversaryLotteryData.signEndTime
    -- local showTime = activityData.showTime
    local nowTime = GameManager:getNormalServerTime()
    print("isSignEnd23: ", ignEndTime, nowTime, nowTime > signEndTime )
    -- 比较时间为标准时间
    if nowTime > signEndTime then
        return true
    else
        return false
    end
end

function ActivityAnnivesaryLotteryModel:setAnniversaryLotteryIsShow(data)
    local startTime = data.showTime
    local offTime = data.offTime
    local nowTime = GameManager:getNormalServerTime()
    print("isAnniversaryLotteryShow: ", startTime, offTime, nowTime, GameManager:getNowServerTime(), nowTime >= startTime, nowTime <= offTime)

    -- 比较时间为标准时间
    -- if (nowTime >= startTime and nowTime <= offTime) then
    --     self.isEnabled = true
    -- end
    self.isEnabled = true
end

function ActivityAnnivesaryLotteryModel:isAnniversaryLotteryPreShow(data)
    local isPreShow = false
    local startTime = data.startTime
    local showTime = data.showTime
    local nowTime = GameManager:getNormalServerTime()
    print("isAnniversaryLotteryPreShow: ", startTime, showTime, nowTime, nowTime >= startTime, nowTime <= showTime )
    -- 比较时间为标准时间
    if nowTime >= startTime and nowTime <= showTime then
        -- return true
        isPreShow = true
    else
        isPreShow = false
    end
    return isPreShow
end

function ActivityAnnivesaryLotteryModel:getAnniversaryLotteryIsShow(signType, curTime)
    -- if not self.activityData or not next(self.activityData) then
    --     return false
    -- end
    local isEnabled = false
    local activityData = self:getAnnivesaryLotteryActivityData(signType)--MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)
    local startTime = activityData.showTime
    local offTime = activityData.offTime
    local nowTime = curTime or GameManager:getNormalServerTime()
    print("getAnniversaryLotteryIsShow3: ", startTime, offTime, nowTime, nowTime >= startTime, nowTime <= offTime)
    if nowTime >= startTime and nowTime <= offTime then
        isEnabled = true
    else
        isEnabled = false
    end

    print("getAnniversaryLotteryIsShow12: ", isEnabled)
    return isEnabled
end

function ActivityAnnivesaryLotteryModel:getAnniversaryLotteryIsShowByData(data, curTime)
    local isEnabled = false
    local startTime = data.showTime
    local offTime = data.offTime
    local nowTime = curTime or GameManager:getNormalServerTime()
    print("getAnniversaryLotteryIsShowByDatass",nowTime, startTime, offTime, data.endTime, nowTime >= startTime, nowTime <= offTime, nowTime <= data.endTime)
    if nowTime >= startTime and nowTime <= offTime then
        isEnabled = true
    else
        isEnabled = false
    end

    print("getAnniversaryLotteryIsShowByDataisEnabled:", isEnabled)
    return isEnabled
end

function ActivityAnnivesaryLotteryModel:getAnniversaryLotteryIsEnd(data, curTime)
    local isEnabled = false
    local startTime = data.showTime
    local endTime = data.endTime
    local nowTime = curTime or GameManager:getNormalServerTime()
    print("getAnniversaryLotteryIsEnd", data.endTime, nowTime >= data.endTime)
    if nowTime >= endTime then
        isEnabled = true
    else
        isEnabled = false
    end

    print("getAnniversaryLotteryIsEnd:", isEnabled)
    return isEnabled
end

function ActivityAnnivesaryLotteryModel:getAnniversaryLotteryIsShowBtn()
    local isShow = false
    local SceneManager = require("app.game.SceneManager")
    if not SceneManager:getInstance():isInTown() then
        print("not isInTown")
        return false
    else
        local data1 = self:getAnnivesaryLotteryActivityData(1)
        if data1 then
            isShow = self:getAnniversaryLotteryIsShowByData(data1)
        end

        local data2 = self:getAnnivesaryLotteryActivityData(2)
        if data2 and not isShow then
            isShow = self:getAnniversaryLotteryIsShowByData(data2)
        end

        return isShow
    end
end

function ActivityAnnivesaryLotteryModel:getAnnivesaryLotteryActivityData(signType)
	-- local anniversaryLotteryData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)
    local anniversaryLotteryData = MasterDataManager:getActivityDataArrForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)

    for k, activityData in pairs(anniversaryLotteryData) do
        local lotteryData = activityData:getAnniversaryLotteryData()
        if lotteryData.signType == signType then
            return activityData
        end
    end

    return nil
end

function ActivityAnnivesaryLotteryModel:getAnnivesaryLotteryData(signType)
	-- local anniversaryLotteryData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)
    local anniversaryLotteryData = MasterDataManager:getActivityDataArrForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)

    for k, activityData in pairs(anniversaryLotteryData) do
        local lotteryData = activityData:getAnniversaryLotteryData()
        if lotteryData.signType == signType then
            return lotteryData
        end
    end

    return nil
end

function ActivityAnnivesaryLotteryModel:getAnnivesaryLotteryRewardStateData()
    local anniversaryLotteryData = MasterDataManager:getActivityDataArrForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)

    for k, activityData in pairs(anniversaryLotteryData) do
        local lotteryData = activityData:getAnniversaryLotteryData()
        if lotteryData.rewardState ~= 0 and self:getAnniversaryLotteryIsShowByData(activityData) then
            return lotteryData
        end
    end

    return nil
end

function ActivityAnnivesaryLotteryModel:setLotteryRewardRoster(data)
    if data.signType then
        self.rewardRoster[data.signType] = data
    end
end

function ActivityAnnivesaryLotteryModel:getLotteryRewardRosterByType(signType)
    return self.rewardRoster[signType] or nil
end

function ActivityAnnivesaryLotteryModel:isShowRedPoint()
    local hasClicked = cc.UserDefault:getInstance():getBoolForKey("annivesaryLotteryRedPontShow", false)
    if not hasClicked then
        return true
    end
    local isShow = false
    local data1 = self:getAnnivesaryLotteryData(1)
    if data1 and self:isCanSign(1) and not data1.isSign then
        isShow = true
    elseif data1 and data1.rewardState == 1 and not data1.isGetReward then
        isShow = true
    end

    local data2 = self:getAnnivesaryLotteryData(2)
    if data2 and self:isCanSign(2) and not data2.isSign then
        isShow = true
    elseif data2 and data2.rewardState == 1 and not data2.isGetReward then
        isShow = true
    end

    return isShow
end

function ActivityAnnivesaryLotteryModel:isShowRedPointInTab(signType)
    local isShow = false
    local data = self:getAnnivesaryLotteryData(signType)
    if data and self:isCanSign(signType) and not data.isSign then
        isShow = true
    elseif data and data.rewardState == 1 and not data.isGetReward then
        isShow = true
    end

    return isShow
end

-- 获取周年庆抽奖购买礼包数据
function ActivityAnnivesaryLotteryModel:getPackageData(giftID)
    local ProtobufUtil = require("utils.ProtobufUtil")
    local giftData = SdkManager:getInstance():getIapDatas()
    local giftArr = {}
    for k, v in pairs(giftData) do
        -- if ProtobufUtil:checkFieldIsInit(v, "ext") and v.ext ~= nil and v.ext ~= "'" then
        --     xpcall(function()
        --         local extParam = json.decode(v.ext)
        --         if extParam.show and extParam.tradeActivityId == giftID then
        --             table.insert(giftArr, v)
        --         end
        --     end, 
        --     function(e) 
        --     end, 1)
        -- end
        if v.productID and v.productID == giftID then
            table.insert(giftArr, v)
        end
    end

    if #giftArr == 0 then
        return giftArr
    end

    self._giftData = clone(giftArr)

    -- 先筛选一次 如果为0 需要删除掉
    for i= table.nums(self._giftData),1,-1 do
        if checkint(self._giftData[i].productID) <=0 then
            table.remove( self._giftData, i )
        else
            self._giftData[i].allDone = true
        end
    end

    if #self._giftData > 1 then
        table.sort(self._giftData, function (a,b)
            -- 如果排序ID一样, 用其他方法排序
            if (a.sortId == b.sortId) then
                -- 排序ID一样, 有hot标签的在前面, 都有或者都没有的时候用其他方法排序
                if (a.isHot and not b.isHot) then
                    return true
                elseif (not a.isHot and b.isHot) then
                    return false
                end

                -- 排序ID一样, hot标签一样, 用价格排序
                if (a.price < b.price) then
                    return true
                elseif (a.price > b.price) then
                    return false
                else -- 价钱相等用productID排序
                    return a.productID > b.productID
                end
            end

            -- 默认用排序标签排序
            return a.sortId > b.sortId
        end )
    end
    self:refreshWebLaunguageCallback({})        
    -- SdkManager:getInstance():setIapDatas(datas)

    

    local curTime = GameManager:getNormalServerTime()
    -- 删除已经下架的 和已经售完 并且标示了隐藏的
    local size = table.nums(self._giftData)
    for i= size,1, -1 do
        local item = self._giftData[i]
        -- 时间到了下架的
        if (item.endTimeSec > 0 and item.endTimeSec < curTime) then
            -- print("从本地删除")
            table.remove(self._giftData,i)
        end
        
    end
    
    local keyList = {}
    for i,v in ipairs(self._giftData) do
        table.insert( keyList, v.nameID )
        table.insert( keyList, v.desID )
    end

    local lans = SdkManager:getInstance():getProductsLan()
    if lans and table.nums(lans) > 0 then
        local hasOneUpdate = false
        for i,v in ipairs(self._giftData) do
            local findName = false
            local findDesc = false
            for idx,lan in pairs(lans) do
                if v.nameID == idx then
                    findName = true;
                end
                if v.desID == idx then
                    findDesc = true;
                end
                if findDesc and findName then
                    break;
                end
            end
            if not findDesc or not findName then
                hasOneUpdate = true ;
                break;
            end
        end
        if hasOneUpdate then
            SdkManager:getInstance():loadProductsLan( keyList, handler(self, self.refreshWebLaunguageCallback))
        else
            self:refreshWebLaunguageCallback(lans)
        end
        
    else
        -- dump(keyList)
        -- 获取苹果商店的信息
        SdkManager:getInstance():loadProductsLan(keyList, handler(self, self.refreshWebLaunguageCallback))
    end

    --更新购买过的礼包数量
    local needs = {}
    local types = {}
	for i,v in ipairs(self._giftData) do
        local limitedType = v.limitedType
        if limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Daily  
        or limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Weekly  
        or limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Total  then
            table.insert( needs, v.productID)
            types[tostring(v.productID)]= limitedType
        end
    end
    if (#needs > 0) then
        SdkManager:getInstance():reqBoughtNum(needs,types)
    end

    return self._giftData
end

function ActivityAnnivesaryLotteryModel:refreshWebLaunguageCallback(webLaunguageList)
    if not self._giftData  then
        return
    end

    
    local infos = SdkManager:getInstance():getProducts()
    local myChannel = SdkBox:getInstance():getVersionChannel()
    -- printInfo("IapShopMainLayer:refreshWebLaunguageCallback, myChannel",myChannel)

    for i,v in ipairs(self._giftData) do
        v.name = ""
        v.desc = ""
        v.iapId = ""
        for idx,lan in pairs(webLaunguageList) do
            if v.nameID == idx then
                local p = json.decode(lan)
                local str = ""
                if(p) then
                    for i,v in ipairs(p) do
                        str = str .. v.text
                    end
                end
                v.name = str
            end
            if v.desID == idx then
                local p = json.decode(lan)
                local str = ""
                if(p) then
                    for i,v in ipairs(p) do
                        str = str .. v.text
                    end
                end
                v.desc = str
            end
        end
        for i,idAndChannel in ipairs(v.IAPList) do
            if checkint(idAndChannel.channelID) == myChannel then
                -- table.insert( iaps, idAndChannel.iapId)  

                v.iapId = idAndChannel.iapId
                break;      
            end
        end
        -- dump(v.IAPList)
        
    end
    
    UI.WaitingLayer:showWaiting(true, nil, 0)
    -- if mvc.comebackPackageController then
    --     mvc.comebackPackageController:onUpdatePackageView(self._giftData)
    -- end
    UI.WaitingLayer:hideWaiting()

end

return ActivityAnnivesaryLotteryModel