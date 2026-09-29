--[[--
数据模型ComebackPackageModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/05/26
--desc	: ComebackPackageModel
------------------------------------------------------------------------------

local ComebackPackageModel = class("ComebackPackageModel",mvc.GameModel)
local SdkManager = require "app.game.SdkManager"
local SdkBox = require("utils.sdkbox.SdkBox")

function ComebackPackageModel:initData()
	self._data = {}
end

-- 后台礼包数据进行刷新
function ComebackPackageModel:refreshGiftData()
    -- 刷新成长基金购买按钮
    self:setForce("comebackPackageUpdateView")
end

-- 获取返场活动礼包数据
function ComebackPackageModel:getPackageData()
    
    local ProtobufUtil = require("utils.ProtobufUtil")
    local giftData = SdkManager:getInstance():getIapDatas()
    local giftArr = {}
    for k, v in pairs(giftData) do
        if ProtobufUtil:checkFieldIsInit(v, "ext") and v.ext ~= nil and v.ext ~= "'" then
            xpcall(function()
                local extParam = json.decode(v.ext)
                if extParam.show and extParam.tradeActivityId == PublicDefine.TradeActivityIDList.TradeActivityComeback then
                    table.insert(giftArr, v)
                end
            end, 
            function(e) 
            end, 1)
        end
    end

    if #giftArr == 0 then
        return giftArr
    end

    self._data = clone(giftArr)

    -- 先筛选一次 如果为0 需要删除掉
    for i= table.nums(self._data),1,-1 do
        if checkint(self._data[i].productID) <=0 then
            table.remove( self._data, i )
        else
            self._data[i].allDone = true
        end
    end

    if #self._data > 1 then
        table.sort(self._data, function (a,b)
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
    local size = table.nums(self._data)
    for i= size,1, -1 do
        local item = self._data[i]
        -- 时间到了下架的
        if (item.endTimeSec > 0 and item.endTimeSec < curTime) then
            -- print("从本地删除")
            table.remove(self._data,i)
        end
        
    end
    
    local keyList = {}
    for i,v in ipairs(self._data) do
        table.insert( keyList, v.nameID )
        table.insert( keyList, v.desID )
    end

    local lans = SdkManager:getInstance():getProductsLan()
    if lans and table.nums(lans) > 0 then
        local hasOneUpdate = false
        for i,v in ipairs(self._data) do
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
	for i,v in ipairs(self._data) do
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

    return self._data
end

function ComebackPackageModel:refreshWebLaunguageCallback(webLaunguageList)
    if not self._data  then
        return
    end

    
    local infos = SdkManager:getInstance():getProducts()
    local myChannel = SdkBox:getInstance():getVersionChannel()
    -- printInfo("IapShopMainLayer:refreshWebLaunguageCallback, myChannel",myChannel)

    for i,v in ipairs(self._data) do
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
    if mvc.comebackPackageController then
        mvc.comebackPackageController:onUpdatePackageView(self._data)
    end
    UI.WaitingLayer:hideWaiting()

end

-- 根据活动ID获取活动是否达到开启条件
function ComebackPackageModel:getActivityIsOpeningByID(ID)
    return mvc.tradeActivityModel:getActivityIsOpeningByID(ID)
end

-- 根据活动ID获取活动时间范围
function ComebackPackageModel:getActivityOpeningStrByID(ID)
    return mvc.tradeActivityModel:getActivityOpeningStrByID(ID)
end


return ComebackPackageModel