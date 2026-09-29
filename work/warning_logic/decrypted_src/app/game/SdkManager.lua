-- SdkManager.lua
-- Author:yueyingsong
-- 2017年11月27日
-- Using:支付管理
local SdkBox = require("utils.sdkbox.SdkBox")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local scheduler = cc.Director:getInstance():getScheduler()
local SdkManager = class("SdkManager")
local ProtobufUtil = require "utils.ProtobufUtil"

g_SdkManager = nil;

local POLLING_INTERVAL = math.random( 15,25 );
local POLLING_TIME = 5;
-- 是否启用检测发货状态检测的轮询
local ENABLE_DELIVER_STATUS_POOLLING = false
-- 是否启用验证超时轮询
local ENABLE_TIMEOUT_POOLLING = true
local commentFile = "comment.ud"

local loadingProducts = false
local authorizationCode = "51d8cd0b2e5948465d484f944461c23a"
function SdkManager:ctor()
    self._curIdx = 1
    self._products = nil;
    self._productsLan = nil
    self._boughts = nil
    self._payParams = nil
    self.schedulerID = 0
    self._purchaseData = nil;
    self._isManualPurchase = false;
    self._curOrderId = nil;
    self._iapDatas = {};
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    self._rdata = globalUserData:getPayRData()
    if self._rdata then
        print(" 初始化读取 self._rdata ========= ")
        dump(self._rdata)
    end
    self._buyCount = 1
    self._inited = false
    self._reqIapDatas = false
    self._limitTypes = {}
    self._newIapBox = false;
    self._cacheOrderData = {};
    self._productDataBuffer = {}
    self._iapPriceStringTable = {}
    self._orderMap = {}  -- {orderID:projectId}
    
    --引导评论数据
    self._commentEventMap = nil
    self._isRecordBeginTime = 0
    self.recordEventCfg = nil
    Avalon.MessageCenter:bind(AvalonMessage.MC_COMMENT_END, self, self.endRecordTime)
    self._commentSuccess = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.CommentSuccess,false) 
    self._deliverOrderID = 0;
    SdkBox:getInstance():onPayCurrencyCodeCallback(function(isSuccess, iapToPriceString)
        if (CONFIG_SHOW_DEBUG_PANEL)  then
            local tableSample = ""
            if (next(iapToPriceString)) then
                local sampleKey = next(iapToPriceString)
                tableSample = iapToPriceString[sampleKey]
            end
            UI.ScrollBar:createByText("调试信息: 获取状态-" .. tostring(isSuccess) .. "\n" .. tableSample)
        end
        if (isSuccess and type(iapToPriceString) == "table") then
            for k,v in pairs(iapToPriceString) do
                local strArr = v:split("|")
                if (not self._iapPriceStringTable[k]) then
                    self._iapPriceStringTable[k] = {}
                end

                -- 带符号的价钱值
                self._iapPriceStringTable[k].priceString = strArr[1] ~= "" and strArr[1] or nil

                -- 实际价钱: 获取到的是10^6值, 需要处理一下
                local value = tonumber(strArr[2])
                if (value) then
                    value = value / 1000000
                else
                    value = 0
                end
                self._iapPriceStringTable[k].value = value

                -- 初始优惠价值
                local initialPrice = strArr[3] ~= "" and strArr[3] or nil
                self._iapPriceStringTable[k].initialPrice = initialPrice

                if(self._iapPriceStringTable[k].priceString) then
                    local channel = SdkBox:getInstance():getVersionChannel()
                    channel = checkint(channel)
                    if(channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_ONESTORE) then 
                        -- 这里对于OneStore渠道做一个特殊处理，手动添加一下韩国货币字符串
                        self._iapPriceStringTable[k].value = tonumber(self._iapPriceStringTable[k].priceString)
                        self._iapPriceStringTable[k].initialPrice = tonumber(self._iapPriceStringTable[k].priceString)
                        self._iapPriceStringTable[k].priceString ="₩" .. self._iapPriceStringTable[k].priceString
                    end
                end
            end
        end
    end)
    -- local dummy = {["com.avalon.caveonline.cn.yueka.30.1"] = "US$49.99|49990000", ["com.avalon.caveonline.cn.baoxiang.6.7"] = "US$4.99|4990000", ["com.avalon.caveonline.cn.jinjielibao.68"] = "US$9.99|9990000", ["com.avalon.caveonline.cn.jinjielibao.128"] = "US$19.99|19990000", ["com.avalon.caveonline.cn.jinjielibao.30"] = "US$4.99|4990000", ["com.avalon.caveonline.cn.jinjielibao.648"] = "US$99.99|99990000", ["com.avalon.caveonline.cn.jinjielibao.6"] = "US$0.99|990000"}
    -- for k,v in pairs(dummy) do
    --     local strArr = v:split("|")
    --     if (not self._iapPriceStringTable[k]) then
    --         self._iapPriceStringTable[k] = {}
    --     end

    --     -- 带符号的价钱值
    --     self._iapPriceStringTable[k].priceString = strArr[1]

    --     -- 实际价钱: 获取到的是10^6值, 需要处理一下
    --     local value = tonumber(strArr[2])
    --     if (value) then
    --         value = value / 1000000
    --     else
    --         value = 0
    --     end
    --     self._iapPriceStringTable[k].value = value
    -- end
end

function SdkManager:dtor()
    print("SdkManager:dtor()")
    if self.schedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = 0
    end
    self._products = nil;
    self._newIapBox = nil
    
    self._payParams = nil
    self._iapDatas = {};
    self._orderMap = {}

    self._omissionOrderData = {} --上报遗漏的订单数据
    self._serverReturnOderData = {} --服务器发货的订单数据
    --引导评论数据
    self._commentEventMap = nil
    self._isRecordBeginTime = 0
    self.recordEventCfg = nil
    Avalon.MessageCenter:unbind(AvalonMessage.MC_COMMENT_END, self, self.endRecordTime)

    Avalon.MessageCenter:unbind(GameMessage.MC_PURCHASE_SUCCESS, self,self.onPurchaseResult)

    Avalon.MessageCenter:unbind(GameMessage.MC_GET_ORDER_RESP, self,self.onGetOrderResp)
    Avalon.MessageCenter:unbind(GameMessage.MC_GET_BOUGHT_RESP, self,self.onGetBoughtResp)

    Avalon.MessageCenter:unbind(GameMessage.MC_ON_TIPS_CLOSE_BUTTON, self,self.onCloseAward)
    -- Avalon.MessageCenter:unbind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.refreshProducts)
    Avalon.MessageCenter:unbind(GameMessage.MC_REQ_PURCHASE_ERROR, self,self.onGetOrderError)
    SdkBox:getInstance():onPayCurrencyCodeCallback(nil)
end

function SdkManager:getInstance()
    if g_SdkManager == nil then
       g_SdkManager = SdkManager.new()
    end
    return g_SdkManager;
end

function SdkManager:getSceneType()
    return self._sceneType
end

function SdkManager:purgeInstance()
    if g_SdkManager ~= nil then
        g_SdkManager:dtor()
        g_SdkManager = nil;
    end
end

-- 初始化
function SdkManager:init()
    self._purchaseData =  Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.PURCHASE, GameDataManager:getInstance():getSaveUserKey())


    if self._inited then
        return
    end
    self._inited = true

    print("SdkManager init")
    SdkBox:getInstance():onSdkPaySuccess(handler(self,self.onSdkPaySuccess))
    SdkBox:getInstance():onSdkPayFail(handler(self,self.onSdkPayFail))
    SdkBox:getInstance():setStorePayListener(handler(self,self.storePayCallBack))
    
    
    -- dump(self._purchaseData,"本地订单")
    Avalon.MessageCenter:bind(GameMessage.MC_PURCHASE_SUCCESS, self,self.onPurchaseResult)

    Avalon.MessageCenter:bind(GameMessage.MC_GET_ORDER_RESP, self,self.onGetOrderResp)
    Avalon.MessageCenter:bind(GameMessage.MC_GET_BOUGHT_RESP, self,self.onGetBoughtResp)
    Avalon.MessageCenter:bind(GameMessage.MC_ON_TIPS_CLOSE_BUTTON, self,self.onCloseAward)
    -- Avalon.MessageCenter:bind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.refreshProducts)
    Avalon.MessageCenter:bind(GameMessage.MC_REQ_PURCHASE_ERROR, self,self.onGetOrderError)
    -- 初始化所有未验证成功的订单为0次
    local orders = self._purchaseData:getAllOrders()
    for i,v in ipairs(orders) do
        v.verifyTimes = 0
    end
    print("POLLING_INTERVAL",POLLING_INTERVAL)
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), POLLING_INTERVAL, false)

    

    -- 设置付费回调的同时会发起补单检查
    -- local SdkBox = require("utils.sdkbox.SdkBox")
    -- SdkBox:getInstance():delaySetPayCallback()
end
function SdkManager:firstReqIapDatas()
    if self._reqIapDatas then
        return
    end
    self._reqIapDatas = true
    local myChannel = SdkBox:getInstance():getVersionChannel()
    printInfo("SdkManager:init, 获取商品列表", myChannel)
    Net.NetPurchaseSystem:reqProducts(nil,nil,myChannel)
end

--extIndex:限时礼包校验客户端和服务器数据是是否一致
function SdkManager:reqOrder(data,count,idx,extIndex,isRedeem)
    if not data then
        return
    end
    local gameLoginManager = require("app.game.GameLoginManager")
    local currentVersionAccount = checkint(gameLoginManager:getInstance():getVersionAccount())

    self._curIdx = idx
    local payMode = 0;
    
    local myChannel = SdkBox:getInstance():getVersionChannel()
    
    local myPlatform = SdkBox:getInstance():getVersionPlatform()
    
    local subChannel = SdkBox:getInstance():getSubChannel()
    local deviceID = ""
    if (device.platform == "ios") then
        deviceID = AvalonUtil.getIDFV()
    elseif(device.platform == "android") then
        deviceID =  AvalonUtil.getIMEI()
    else
        deviceID =  "1234567898012345"
    end
    local uuid = AvalonUtil.getOpenUUID()
    -- deviceID
    -- uuid
    local isOnTopActivityLayer = false
    local topActivityLayer = UI.UIManager:getTopActivityLayer()
    if not tolua.isnull(topActivityLayer) then
        local shopPanel = topActivityLayer:getIapShopPanel()
        if not tolua.isnull(shopPanel) then
            isOnTopActivityLayer = true
        end
    end

    -- 这里判断玩家是否登录，没有登录需要先登录才能支付
    if (PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_GUEST == currentVersionAccount and CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) then
        local bindTips = UI.Tips:createTips(UI.TEXT_1170852,UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
        bindTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SETTING_SHOW_ACCOUNT_BIND)
        end)
        if isOnTopActivityLayer then
            bindTips:setZOrder(UI_ZORDER.MAX)
            bindTips:removeFromParent(false)
            UI.UIManager:addToRootNode(bindTips)
        end
        return
    elseif ((CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_CN) and SdkBox:getInstance():isGuest()) then
        local bindTips = UI.Tips:createTips(UI.TEXT_1170852,UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
        bindTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            SdkBox:getInstance():showAccountCenter()
        end)
        if isOnTopActivityLayer then
            bindTips:setZOrder(UI_ZORDER.MAX)
            bindTips:removeFromParent(false)
            UI.UIManager:addToRootNode(bindTips)
        end
        return
    end
    print("subChannel",subChannel)
    require("utils.HotfixManager")
    local ext = ""
    local extParams = {
        productId = data.productID,
        version = Avalon.HotfixManager:getLocalVersion(),
        subChannel = subChannel,
        isRedeem = isRedeem,
    }
    ext = json.encode(extParams)
    if data.label == PublicDefine.PURCHASE_PRODUCT_TYPE.BattlePass then
        Net.NetPurchaseSystem:reqPurchase(deviceID,uuid,data.productID,count,myChannel,myPlatform,data.iapId,ext, data.stage, data.label) 
    elseif data.label == PublicDefine.PURCHASE_PRODUCT_TYPE.TimePushTreasure then
        Net.NetPurchaseSystem:reqPurchase(deviceID,uuid,data.productID,count,myChannel,myPlatform,data.iapId,ext, extIndex, data.label)
    else
	    Net.NetPurchaseSystem:reqPurchase(deviceID,uuid,data.productID,count,myChannel,myPlatform,data.iapId,ext, extIndex)
    end
	print("获取订单号 ",deviceID,uuid,data.productID,count,myChannel,myPlatform,data.iapId,ext)
	self._rdata = data
	self._buyCount = count

    --将订单数据存起来, 能避免 大部分 玩家掉线或者在支付成功回调前退出游戏, 导致上报日志出错的问题. 但不能避免玩家充值后马上切换设备的情况
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    globalUserData:setPayRData(self._rdata)
end
function SdkManager:onGetOrderError(data)

    mvc.tradeActivityModel:onGetOrderError(data)

    UI.WaitingLayer:hideWaiting()
    -- dump(data)
    local ProtobufUtil = require "utils.ProtobufUtil"
    if(data.errResult == ProtobufUtil:enum_id("PurchaseSystem.ReqPurchaseErrResult", "ReqPurchaseErrResult_NoProduct")) then 
        UI.ScrollBar:createByText(UI.TEXT_1170847)
    elseif(data.errResult == ProtobufUtil:enum_id("PurchaseSystem.ReqPurchaseErrResult", "ReqPurchaseErrResult_NoCondition")) then 
        UI.ScrollBar:createByText(UI.TEXT_1170848)
    elseif(data.errResult == ProtobufUtil:enum_id("PurchaseSystem.ReqPurchaseErrResult", "ReqPurchaseErrResult_RepeatOrder")) then 
        UI.ScrollBar:createByText(UI.TEXT_1170849)
    elseif(data.errResult == ProtobufUtil:enum_id("PurchaseSystem.ReqPurchaseErrResult", "ReqPurchaseErrResult_OutNum")) then 
        UI.ScrollBar:createByText(UI.TEXT_1170851)
    elseif(data.errResult == ProtobufUtil:enum_id("PurchaseSystem.ReqPurchaseErrResult", "ReqPurchaseErrResult_SystemError")) then 
        UI.ScrollBar:createByText(UI.TEXT_1170850)
    end
    dump(data,"获取订单号失败")
end
function SdkManager:getOrder(data,count,idx, extIdx, isRedeem)
    if isRedeem == nil then
        isRedeem = false
    end
    if(LOG_PAY_FLAG) then 
        print("PAY: start get order from server data=",data,count,idx, extIdx, isRedeem)
    end
    self:reqOrder(data,count,idx, extIdx, isRedeem)
end

-- 延迟处理多批数据
function SdkManager:parseProducts(params)
    local isSingle = self._productDataBuffer.isSingle
    local datas = self._productDataBuffer.infos or {}

    -- 删掉已下架的
    for i= table.nums(self._iapDatas),1,-1 do
        local find = false;
        for i1,v1 in ipairs(datas) do
            if self._iapDatas[i].productID == v1.productID then
                find = true
                break;
            end
        end
        if not find then
            table.remove( self._iapDatas, i)
        end
    end
    
    for i1,v1 in ipairs(datas) do
        local find = false
        for i,v in ipairs(self._iapDatas) do
            if v.productID == v1.productID then
                find = true
                self._iapDatas[i] = v1
                break;
            end
        end
        if not find then
            table.insert( self._iapDatas, v1 )
        end
    end
    
    if mvc.limitTimePackageModel then
        mvc.limitTimePackageModel:setIapDatas(self._iapDatas)
    end

    local localData = {}
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if(RoleDataManager:getMasterPK() ~= -1) then
        localData = globalUserData:getIapBoxs()
    end

    -- dump(localData)
    -- local newIapCheckData = clone(self._iapDatas)
    -- SdkManager:getInstance():filterDataWithWebCondition(newIapCheckData)
    -- for i,v in ipairs(newIapCheckData) do
    local foundNewBox = #localData <= 0
    if (not foundNewBox) then
        for i,v in ipairs(self._iapDatas) do
            if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_TREASURE then
                for idx, productID in ipairs(localData) do
                    if v.productID == productID then
                        foundNewBox = true
                        break
                    end
                end
            end
        end
    end
    if not foundNewBox then
        self:markNewIapBox()
        Avalon.MessageCenter:notice(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, {})
    else
        self:removeNewIapBoxMark()
        Avalon.MessageCenter:notice(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, {})
    end

    -- dump(self._iapDatas,"所有商品信息")
    local myChannel = SdkBox:getInstance():getVersionChannel()
    local iaps = {}
    localData = {}

    -- 储存在本地
    for i,v in ipairs(self._iapDatas) do
        -- 找到ipaid
        v.iapId = ""
        for i,idAndChannel in ipairs(v.IAPList) do
            if checkint(idAndChannel.channelID) == myChannel then
                v.iapId = idAndChannel.iapId
                table.insert( iaps,idAndChannel.iapId)
                break;      
            end
        end
        if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_TREASURE then
            table.insert( localData,v.productID )
        end
    end
    -- 检测一次,是否存在预购商品
    if (CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) and device.platform == "ios" then
        -- 如果是海外版,需要先等商品信息加载完毕
        -- print("iaps=", iaps)
        self._iaps = iaps
        self:_delayLoadProdects()
    else
        self:storePayCallBack()
    end
    
    globalUserData:setIapBoxs(localData)

    if(RoleDataManager:getMasterPK() ~= -1) then
        Avalon.UserDataManager:saveDataToFile(globalUserData:getType())
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_PRODUCTS, self._productDataBuffer)

    -- 缤纷活动数据
    if mvc.tradeActivityModel then
        mvc.tradeActivityModel:refreshGiftData()
    end

    --返场活动
    if mvc.comebackPackageModel then
        mvc.comebackPackageModel:refreshGiftData()
    end

    self:requestCurrencyLocationCode()
end

function SdkManager:refreshProducts(data)
    -- 因为服务器PB 8K大小限制, 这里建立了一个缓存来累积数据内容.
    -- 有时间戳并且不是单独刷新, 就累积更新数据
    local ProtobufUtil = require "utils.ProtobufUtil"
    if ProtobufUtil:checkFieldIsInit(data, "hasMoreData") then
        if (ProtobufUtil:checkFieldIsInit(data, "refreshStat") and 
            (not ProtobufUtil:checkFieldIsInit(data, "isSingle") or not data.isSingle)
        ) then
            if (data.refreshStat ~= self._productDataBuffer.refreshStat) then
                self._productDataBuffer = data
            else
                local datas = data.infos or {}
                for i,v in ipairs(datas) do
                    table.insert(self._productDataBuffer.infos, v)
                end
            end
        else
            self._productDataBuffer = data
        end
        if not data.hasMoreData then
            self:parseProducts()
        end
    end
end

function SdkManager:_delayLoadProdects()
    if(loadingProducts == true or self._iaps == nil) then
        return
    end
    -- print("_delayLoadProdects=", self._iaps)
    loadingProducts = true
    self:loadProducts(self._iaps,function ()
        loadingProducts = false
        self:storePayCallBack()
    end)  
end

function SdkManager:getIAPProductID(productID)
    for k, v in pairs(self._iapDatas) do
        if v.productID == productID then
            return v.iapProductID
        end
    end

    return 0
end

function SdkManager:getIAPProductData(productID)
    for k, v in pairs(self._iapDatas) do
        if v.productID == productID then
            return v
        end
    end

    return 0
end

-- 购买 如果不支持合并支付,需要在每次成功之后再次发起,如果失败直接中断
-- orderId 			我们自己的订单ID
-- productId 		商品ID 某些sdk可能需要。不需要的就传0
-- iapId 		    支付用的ID
-- productName 		详细的商品名字 类似 10元宝
-- productPrice 	商品价格 现金单位 分
-- productCount 	购买数量 一般都为0 但是可能涉及到特殊需求,比如礼包
-- productDes 		商品的介绍,都加上,因为有些SDK会展示
-- diamond 			购买后得到的钻石
-- unitName 		单位名字  比如 元宝  礼包
-- unitRate  		单位的兑换比例 比如10元宝一现金单位
-- roleId 			角色ID
-- roleName 		角色名字
-- roleLevel 		角色等级
-- vipLevel 		vip等级
-- balance 			余额
-- guildName 		公会名字
-- zoneId 			服务器ID
-- zoneName 		服务器名字
-- notifyUri 		充值成功之后的验证地址
-- ext 			拓展字段(非常有用,一般用来传我们自己的参数,比如我们自己订单号,
-- 				一般的sdk回调到服务器会原封不动带上这参数)
function SdkManager:onGetOrderResp(data )
    if(LOG_PAY_FLAG) then 
        print("PAY: get order from server response data", data)
    end
    print(data,"获取订单号返回")
    if self:enableNewPay() then
        self:onGetOrderRespNew(data)
        return
    end
    self._isManualPurchase = true
    Avalon.MessageCenter:notice(AvalonMessage.MC_GET_ORDER_SHOWLOADING )

    -- 测试用
    if CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT then
        math.newrandomseed()
        -- dump(data,"测试用 获取订单返回")
        local testParams = {}
        testParams.cpOrderId = data.orderID
        testParams.transactionIdentifier = "test_transactionId_"..math.random(1000,9999)..math.random(1000,9999)..math.random(1000,9999)
        testParams.receipt = data.orderID
        testParams.productIdentifier = self._rdata.iapId
        self:onSdkPaySuccess(testParams)

        return
    end
    self._curOrderId = data.orderID
    self._curIapId = data.iapID
    
    -- 获取钻石数量 由于iap内购的缘故,修改为洞窟内可以购买
	-- if not SceneManager:getInstance():isInTown() then--不在城镇
    --     if self._rdata.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_TREASURE then
    --         printError("can not call purchase of box in other scene")
    --         return
    --     end
    -- end
	local heroData = RoleDataManager:getMaster()
	local gameLoginManager = require("app.game.GameLoginManager")
	local guildData = MasterDataManager:getGuildData() or {}

    local ext = ""
    local extParams = {
        price = data.price
    }
    ext = json.encode(extParams)
    local verifyHost = ServerConfigUtil:getPurchaseUrl()
    local productName = self:getProductName(data.productNameID)
    
    local isRedeem = "0"
    if ProtobufUtil:checkFieldIsInit(data, "ext") then
        xpcall(function()
            local netData = json.decode(data.ext)
            if netData.isRedeem then
                isRedeem = "1"
            end
        end, 
        function(e) 
        end, 1)
    end
	local params = {
		productId = data.productId,
		iapId = data.iapID,
		orderId = data.orderID,
		productName = productName,
		productPrice = data.price,
		productCount = tostring(data.count),
		productDes = productName,
		diamond = data.diamond,
		unitName = UI.TEXT_1170327,
		unitRate = "10",
		roleId = GameDataManager:getMasterPK(),
		roleName = heroData:getNickName(),
		roleLevel = tostring(heroData:getLevel()),
		vipLevel = "1",
		balance = tostring(heroData:getCurCoin()),
		guildId = tostring(guildData.ID or ""),
        guildName = tostring(guildData.name or "none"),
		zoneId = tostring(gameLoginManager:getInstance():getServerId()),
		zoneName = tostring(gameLoginManager:getInstance():getServerId()),
		notifyUri = verifyHost,
		ext = ext,
        isRedeem = isRedeem,
	}
	
	SdkBox:getInstance():purchase(params)
end


-- 为了适配新流程，需要先到web再请求一次order，再去第三方进行支付
function SdkManager:onGetOrderRespNew(data)
    self._cacheOrderData = clone(data)
    -- 这里使用 orderID 和 productId绑定
    self._orderMap[data.orderID] = data.productId
    
    local isRedeem = false
    if ProtobufUtil:checkFieldIsInit(data, "ext") then
        xpcall(function()
            local netData = json.decode(data.ext)
            if netData.isRedeem then
                isRedeem = true
            end
        end, 
        function(e) 
        end, 1)
    end
    require("utils.AvalonUtil")
    local ServerConfigUtil = require("app.utils.ServerConfigUtil")
    local gameLoginManager = require("app.game.GameLoginManager")
    local newdata = {}
    newdata.game_order_id = data.orderID
    newdata.iap_product_id = self:getIAPProductID(tonumber(data.productId))
    newdata.product_id = tonumber(data.productId)
    newdata.project_id = ServerConfigUtil:getProjectId()
    newdata.server_id = tostring(gameLoginManager:getInstance():getServerId())
    newdata.quantity = self._buyCount
    -- add by zp 这里为了创建订单时候，支付中心能够根据角色过滤部分订阅换角色问题
    -- newdata.user_id = ServerConfigUtil:getPlayerID()
    newdata.user_id = gameLoginManager:getInstance():getAccountId()
    newdata.player_key = tostring(GameDataManager:getInstance():getMasterPK())
    newdata.channel = SdkBox:getInstance():getVersionChannel()
    newdata.platform = 0
    newdata.device_id = AvalonUtil.getDeviceID()
    newdata.open_uuid = AvalonUtil.getOpenUUID()
    newdata.price = self._rdata.price

    -- 这里为了获取相关的数据信息
    local iapData = self:getIAPProductData(self._cacheOrderData.productId)
    -- print("iapData=", iapData)
    if(iapData and iapData.label == PublicDefine.PURCHASE_PRODUCT_TYPE.MonthlySubscription) then 
        -- iapType = 3
        local transStr = SdkBox:getInstance():getCompletionInfoForIAPID(data.iapID)
        local subscribe_owner = newdata.project_id.."-"..newdata.server_id.."-"..newdata.user_id
        if(data.orderOwner) then
            subscribe_owner = data.orderOwner
        end
        newdata.subscribe_owner = subscribe_owner --"cave_online_trunk_internal-3-170111111"
        print("subscribe_owner", subscribe_owner)
        if(transStr and transStr ~= "")then
            local resp = json.decode(transStr)
            if device.platform == "ios" then
                newdata.subscribe_history_info = {}
                newdata.subscribe_history_info.transaction_id = resp.transaction_id
                newdata.subscribe_history_info.original_transaction_id = resp.original_transaction_id
            elseif device.platform == "android" then
                newdata.subscribe_history_info = {}
                newdata.subscribe_history_info.purchase_token = resp.purchaseToken
            end
        end
        print("getCompletionInfoForIAPID="..transStr.."  platform="..device.platform)
    end

    require("utils.HotfixManager")
    local ext = ""
    local extParams = {
        version = Avalon.HotfixManager:getLocalVersion(),
        subChannel = SdkBox:getInstance():getSubChannel(),
        isRedeem = isRedeem,
    }
    ext = json.encode(extParams)
    newdata.ext = ext

    if device.platform == "ios" then
        newdata.platform = 1
    elseif device.platform == "android" then
        newdata.platform = 2
    end
    
    local sortTable = AvalonUtil:sortParamByFirstChar(newdata)
    local md5ParamStr = ""
    local paramTable = {}
    -- add by zp 和支付中心约定，换成第二版的签名，现阶段服务器先不验证，后面统一后在启用。
    for k, v in ipairs(sortTable) do
    --     md5ParamStr = md5ParamStr..v.value
        paramTable[v.key] = v.value
    end
    local md5Str = AvalonUtil:MD5(md5ParamStr..authorizationCode)

    local sendParam = json.encode(paramTable)
    print("sendParam",sendParam)

    local verifyHost = ServerConfigUtil:getPurchaseUrl()
    local httpurl = verifyHost.."/order/create"
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    
    xhr:open("POST", httpurl)
    xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    xhr:setRequestHeader("Authorization", "Bearer "..md5Str)
    local function onReadyStateChanged()
        if(LOG_PAY_FLAG) then 
            print("PAY: get order from web response data=",xhr.readyState,xhr.status,xhr.response)
        end
        print("request_check",xhr.readyState,xhr.status,xhr.response)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            -- print("response",xhr.response)
            local xhrResp = xhr.response:gsub("\\/", "/")
            local resp = json.decode(xhrResp)
            print(resp,"web create order")
            local status = checkint(resp.status)
            if status == 0 then
                self:onGetOrderFromWebResp(resp.data)
            else
                UI.WaitingLayer:hideWaiting()
                if(status == 45209) then 
                    -- 
                    self:createByTextWhenNotInPolling(false,UI.TEXT_1326003)
                else
                    -- Web订单创建失败
                    self:createByTextWhenNotInPolling(false,UI.TEXT_1326004)
                end
            end
        else
            self:createByTextWhenNotInPolling(false,UI.TEXT_1326004)
            print("web create order  failed")
        end
    end
    
    xhr:registerScriptHandler(onReadyStateChanged)
    xhr:send(sendParam)
end

-- 适配新web流程而新增的接口
function SdkManager:onGetOrderFromWebResp(data)
    print(data,"从web获取订单号返回")
    local isRedeem = "0"
    if data.ext ~= nil and data.ext.isRedeem then
        isRedeem = "1"
    end

    self._cacheOrderData.orderID = data.order_id
    self._cacheOrderData.iapID = data.iap_id

    self._isManualPurchase = true
    Avalon.MessageCenter:notice(AvalonMessage.MC_GET_ORDER_SHOWLOADING )  
    -- TODO 测试用
    if CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT then
        math.newrandomseed()
        -- dump(data,"测试用 获取订单返回")
        local testParams = {}
        testParams.cpOrderId = self._cacheOrderData.orderID
        testParams.transactionIdentifier = "test_transactionId_"..math.random(1000,9999)..math.random(1000,9999)..math.random(1000,9999)
        testParams.receipt = self._cacheOrderData.orderID
        testParams.productIdentifier = self._rdata.iapId
        self:onSdkPaySuccess(testParams)

        return
    end
    self._curOrderId = self._cacheOrderData.orderID
    self._curIapId = self._cacheOrderData.iapID
    
    -- 获取钻石数量 由于iap内购的缘故,修改为洞窟内可以购买
	-- if not SceneManager:getInstance():isInTown() then--不在城镇
    --     if self._rdata.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_TREASURE then
    --         printError("can not call purchase of box in other scene")
    --         return
    --     end
    -- end
	local heroData = RoleDataManager:getMaster()
	local gameLoginManager = require("app.game.GameLoginManager")
	local guildData = MasterDataManager:getGuildData() or {}

    local ext = ""
    local extParams = {
        price = self._cacheOrderData.price  
    }
    ext = json.encode(extParams)
    local verifyHost = ServerConfigUtil:getPurchaseUrl()
    local productName = self:getProductName(self._cacheOrderData.productNameID)
    local iapType = 1
    local iapData = self:getIAPProductData(self._cacheOrderData.productId)
    -- print("iapData=", iapData)
    if(iapData and iapData.label == PublicDefine.PURCHASE_PRODUCT_TYPE.MonthlySubscription) then 
        iapType = 3
    end
    
	local params = {
		productId = self._cacheOrderData.productId,
		iapId = self._cacheOrderData.iapID,
		orderId = self._cacheOrderData.orderID,
		productName = productName,
		productPrice = self._cacheOrderData.price,
		productCount = tostring(self._cacheOrderData.count),
		productDes = productName,
		diamond = self._cacheOrderData.diamond,
		unitName = UI.TEXT_1170327,
		unitRate = "10",
		roleId = GameDataManager:getMasterPK(),
		roleName = heroData:getNickName(),
		roleLevel = tostring(heroData:getLevel()),
		vipLevel = "1",
		balance = tostring(heroData:getCurCoin()),
		guildId = tostring(guildData.ID or ""),
        guildName = tostring(guildData.name or "none"),
		zoneId = tostring(gameLoginManager:getInstance():getServerId()),
		zoneName = tostring(gameLoginManager:getInstance():getServerId()),
		notifyUri = verifyHost,
		ext = ext,
        isRedeem = isRedeem,
        iapType = iapType,
	}
    if(LOG_PAY_FLAG) then 
        print("PAY: 开始调用第三方支付接口 data=",params)
    end
	SdkBox:getInstance():purchase(params)
end

function SdkManager:getProductName(productNameID)
    local productNameStr = [[{"text":""}]]
    local productName = ""
    -- UI.TEXT_1170327
    if self._productsLan then
        for k,v in pairs(self._productsLan) do
            if productNameID == k then
                productNameStr = v
                break;
            end
        end
    end
    xpcall(function()
        local jsonTable = json.decode(productNameStr) or {}
        for i,v in ipairs(jsonTable) do
            productName = productName..v.text
        end
        if string.len(productName) <= 0 then
            productName = UI.TEXT_1170327
        end
    end, 
    function(e) 
        printWarn("获取到的商品多语言格式不正确")
    end, 1)
    return productName
end
-- 如果成功
-- 底层回调回来的参数有 
-- transactionIdentifier 第三方orderid 类似苹果的transactionIdentifier 和雷霆的orderid
-- cpOrderId 我们自己的orderId
-- receipt 详细订单数据,类似苹果的订单数据字段receipt
function SdkManager:onSdkPaySuccess(params) 
    -- if(LOG_PAY_FLAG) then 
        print("PAY: 第三方支付成功回调 data=",params)
    -- end
    if(params and params.cpOrderId) then
        if(self._orderMap[params.cpOrderId]) then 
            self:boughtNumAdd(self._orderMap[params.cpOrderId])
        end
    end
    mvc.tradeActivityModel:onSdkPaySuccess(self._rdata and self._rdata.productID or 0)
    Avalon.MessageCenter:notice(AvalonMessage.MC_SDK_PURCHASE_SUCC , self._rdata and self._rdata.productID or 0) 
    -- print("CAVEOL_TARGET == CAVEOL_TARGET_CN",CAVEOL_TARGET == CAVEOL_TARGET_CN,CAVEOL_TARGET , CAVEOL_TARGET_CN,type(CAVEOL_TARGET ),type(CAVEOL_TARGET_CN))
    if CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE then
        -- 数据上报 cn和global使用同一个接口 但是数据内容不一致 
        if self._rdata and self._rdata.price and self._rdata.productID then
            GameDataManager:getInstance():payReport(
            self._curIdx, 
            self._rdata and self._rdata.price or 0, 
            params.transactionIdentifier, 
            self._curIapId, 
            self._buyCount,
            self._rdata and self._rdata.productID or 0)
        -- else
        --     print(" params.cpOrderId ==== ", params.cpOrderId)
        --     --当订单数据丢失时, 保存需要上报的数据
        --     if(params and params.cpOrderId) then
        --         self._omissionOrderData[params.cpOrderId] = {}
        --         self._omissionOrderData[params.cpOrderId].curIdx = self._curIdx
        --         self._omissionOrderData[params.cpOrderId].price = 0
        --         self._omissionOrderData[params.cpOrderId].transactionIdentifier = params.transactionIdentifier
        --         self._omissionOrderData[params.cpOrderId].curIapId = self._curIapId
        --         self._omissionOrderData[params.cpOrderId].buyCount = self._buyCount
        --         self._omissionOrderData[params.cpOrderId].productID = 0

        --         self:actionOmissionOrderData()
        --     end
        end
        UI.WaitingLayer:hideWaiting()
        return
    end

    --qoo不请求支付验证
    local gameLoginManager = require("app.game.GameLoginManager")
    local versionAccount = gameLoginManager:getInstance():getVersionAccount()
    versionAccount = checkint(versionAccount)
    print("qoo不请求支付验证:", versionAccount, PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_QOOAPP, versionAccount == PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_QOOAPP)
    if versionAccount == PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_QOOAPP then
        return
    end
    
    -- dump(params,"支付成功 参数")
    
    local orders = self._purchaseData:getAllOrders()
    dump(orders)
    local find = nil
    for i,v in ipairs(orders) do
        if v.transactionIdentifier == params.transactionIdentifier then
            find = true
            break;
        end
    end
    if not self._curOrderId and (not params.cpOrderId or params.cpOrderId == "" or params.cpOrderId == "0")  then
        -- add by zp 调试出现的错误 CO-13475【支付】IOS支付补单异常问题修复
        print("params=", params)
        print("角色基本信息")
        print(NetHelper:getCommonSharedData())
        if (device.platform == "ios" or device.platform == "android") then
            buglyReportLuaException(tostring("支付丢单跟踪：订单号异常,不作处理"), "支付丢单跟踪：订单号异常,不作处理",false)    
        end
        return
    end
    -- vstatus 0 新订单(或者 需要验证) 1 正在验证
    if  not find then
        params.vstatus = 1;
        params.verifyTimes = 0
        if not params.cpOrderId or params.cpOrderId == "" or params.cpOrderId =="0" then
            params.cpOrderId = self._curOrderId
        end
        table.insert(orders, params)
        Avalon.UserDataManager:saveDataToFile(self._purchaseData:getType());
    end
    print("self._isManualPurchase",self._isManualPurchase)
    self:verify(params,not self._isManualPurchase)
    self._curOrderId = nil;
end
function SdkManager:boughtNumAdd(productID)
    if (not self._rdata) then return end
    productID = productID or 0
    local products = self._purchaseData:getProducts()
    -- local productID = self._rdata.productID;
    if productID > 0 then
        for i,v in ipairs(products) do
            if productID == v.productID then
                if v.boughtNum then
                    v.boughtNum = v.boughtNum + self._buyCount
                    print("找到限购商品,已购买数量 + ",self._buyCount ,productID,v.boughtNum)
                    Avalon.UserDataManager:saveDataToFile(self._purchaseData:getType());
                else
                    print("异常 在付款成功之后 为本地限购商品的限购次数计数+1的时候数据异常",productID)
                end
                break;
            end
        end
    end
end
-- 去验证
function SdkManager:verify(params,background)
    if(LOG_PAY_FLAG) then 
        print("PAY: 开始到web服务器验证订单 data=",params,background)
    end
    -- 这里是判断是否采用新的支付接口
    if self:enableNewPay() then
        self:verifyNew(params,background)
        return
    end

    print("请求验证 是否后台执行",background)
    if background then
        params.verifyTimes = (params.verifyTimes or 0) + 1;
    end
    local data = {}
    data.order_id = params.cpOrderId
    data.transaction_id = params.transactionIdentifier
    data.receipt_data = params.receipt
    
    local sortTable = AvalonUtil:sortParamByFirstChar(data)
    -- dump(sortTable, "sortTable")
    local md5ParamStr = ""
    local paramTable = {}
    for k, v in ipairs(sortTable) do
        md5ParamStr = md5ParamStr..v.value
        paramTable[v.key] = v.value
    end
    local md5Str = AvalonUtil:MD5(md5ParamStr.."avalon_iap")


    local sendParam = json.encode(paramTable)
    print("sendParam",sendParam)

    local ServerConfigUtil = require("app.utils.ServerConfigUtil")
    local verifyHost = ServerConfigUtil:getPurchaseUrl()
    local httpurl = verifyHost.."/request_check?XDEBUG_SESSION_START=PHPSTORM"
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    
    xhr:open("POST", httpurl)
    xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    xhr:setRequestHeader("Authorization", "Bearer "..md5Str)
    local function onReadyStateChanged()
        print("request_check",xhr.readyState,xhr.status,xhr.response)
        UI.WaitingLayer:hideWaiting()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            -- print("response",xhr.response)
            local resp = json.decode(xhr.response)
            dump(resp,"验证服务器结果")
            local status = checkint(resp.status)
            local order_id = resp.order_id or {}
            if status ==  1 then
                print("订单处理成功",resp.iap_status)
                -- 找到本地储存的订单  删掉
                local iap_status = resp.iap_status
                -- 验证成功待发货
                if iap_status == 1 then
                    if checkint(self._deliverOrderID) ~= checkint(params.cpOrderId) then
                        self:createByTextWhenNotInPolling(background,UI.TEXT_1170833) 
                    end
                    if ENABLE_DELIVER_STATUS_POOLLING then
                        params.vstatus = 0
                    else
                        -- 删除记录
                        self:removeOrderById(order_id)
                    end
                else
                    if iap_status == 2 then
                        self:createByTextWhenNotInPolling(background,UI.TEXT_1170834)
                    elseif iap_status == 5 then
                        self:createByTextWhenNotInPolling(background,UI.TEXT_1170840)
                    elseif iap_status == 6 then
                        self:createByTextWhenNotInPolling(background,UI.TEXT_1170857)
                    end
                    -- 删除记录
                    self:removeOrderById(order_id)
                end
                -- 订单状态介绍
                -- 0: 还未付款.(WEB后台不可补单)
                -- 1: 验证成功待发货. (WEB后台可补单.理论上由客户端和充值服自动补单)
                -- 2: 验证失败.(WEB后台不可补单)
                -- 3: 发货成功. (WEB后台不可补单)
                -- 4: 发货成功(有争议). (WEB后台不可补单,需要查询日志单独通过邮箱发送)
                -- 5: 发货失败. (WEB后台可补单)
                -- 6: 验证服务器去第三方验证超时
                
            else
                print("订单处理失败,不做轮询")
                -- 删除记录
                self:removeOrderById(order_id)
                local msg_code = resp.msg_code
                if msg_code == -1 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170834)
                elseif msg_code == 2 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170835)
                elseif msg_code == 3 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170836)
                elseif msg_code == 4 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170837)
                elseif msg_code == 6 or msg_code == 8 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170838)
                elseif msg_code == 7 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170839)
                end
                -- 只处理这几个
                -- -1: 通用失败.
                -- 2: 使用过的(已经成功发货的)订单
                -- 3: 订单ID和收据ID不匹配.
                -- 4: 通过订单ID没有找到订单.
                -- 5: 到第三方验证订单成功.
                -- 6: 到第三方验证订单失败.
                -- 7: 渠道不合法.
            
            end
            -- dump(resp)
        else
            print("请求验证订单号失败,需要再次请求")
            -- 失败 需要再次验证
            if ENABLE_TIMEOUT_POOLLING then
                params.vstatus = 0
            end

            -- 每次失败了之后，强行写本地一次，便于下次启动游戏时，订单的状态正确
            Avalon.UserDataManager:saveDataToFile(self._purchaseData:getType())

            self:createByTextWhenNotInPolling(background,UI.TEXT_1170841)
        end
        if params.vstatus == 0 then
            -- 如果关闭状态 开启
            if self.schedulerID == 0 then
                -- 初始化所有验证超时的订单为0次
                -- 不能加入自己，因为自己刚刚去服务器验证的时候刚刚把verifyTimes 赋值为5 请求结束就又会初始化到0,会再次开启 死循环
                local orders = self._purchaseData:getAllOrders()
                for i,v in ipairs(orders) do
                    if checkint(v.verifyTimes) >= POLLING_TIME and params.cpOrderId ~= order_id then
                        v.verifyTimes = 0
                    end
                end
                self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), POLLING_INTERVAL, false)
            end
        end
    end
    
    xhr:registerScriptHandler(onReadyStateChanged)
    
    xhr:send(sendParam)
end

-- 去验证
function SdkManager:verifyNew(params,background)
    print("请求验证 是否后台执行",background)
    if background then
        params.verifyTimes = (params.verifyTimes or 0) + 1;
    end
    local data = {}
    data.order_id = params.cpOrderId
    data.transaction_id = params.transactionIdentifier
    data.receipt_data = params.receipt
    
    local sortTable = AvalonUtil:sortParamByFirstChar(data)
    -- dump(sortTable, "sortTable")
    local md5ParamStr = ""
    local paramTable = {}
    for k, v in ipairs(sortTable) do
        md5ParamStr = md5ParamStr..v.value
        paramTable[v.key] = v.value
    end
    local md5Str = AvalonUtil:MD5(md5ParamStr..authorizationCode)


    local sendParam = json.encode(paramTable)
    print("sendParam",sendParam)

    local ServerConfigUtil = require("app.utils.ServerConfigUtil")
    local verifyHost = ServerConfigUtil:getPurchaseUrl()
    local httpurl = verifyHost.."/order/pay_verify"
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    
    xhr:open("POST", httpurl)
    xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    xhr:setRequestHeader("Authorization", "Bearer "..md5Str)
    local function onReadyStateChanged()
        if(LOG_PAY_FLAG) then 
            print("PAY: web 订单验证返回值 data=", xhr.readyState,xhr.status,xhr.response)
        end
        print("request_check",xhr.readyState,xhr.status,xhr.response)
        UI.WaitingLayer:hideWaiting()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            -- print("response",xhr.response)
            local xhrResp = xhr.response:gsub("\\/", "/")
            local resp = json.decode(xhrResp)
            dump(resp,"验证服务器结果")
            local status = checkint(resp.status)
            local respData = resp.data or {}
            local order_id = respData.order_id
            if status == 0 then
                print("订单处理成功",respData.order_status)
                -- 找到本地储存的订单  删掉
                local iap_status = respData.order_status
                -- 验证成功待发货
                if iap_status == 1 then
                    if checkint(self._deliverOrderID) ~= checkint(params.cpOrderId) then
                        self:createByTextWhenNotInPolling(background,UI.TEXT_1170833) 
                    end
                    if ENABLE_DELIVER_STATUS_POOLLING then
                        params.vstatus = 0
                    else
                        -- 删除记录
                        self:removeOrderById(order_id)
                    end
                else
                    if iap_status == 2 then
                        self:createByTextWhenNotInPolling(background,UI.TEXT_1170834)
                    elseif iap_status == 5 then
                        self:createByTextWhenNotInPolling(background,UI.TEXT_1170840)
                    elseif iap_status == 6 then
                        self:createByTextWhenNotInPolling(background,UI.TEXT_1170857)
                    end
                    -- 删除记录
                    self:removeOrderById(order_id)
                end
                -- 订单状态介绍
                -- 0: 还未付款.(WEB后台不可补单)
                -- 1: 验证成功待发货. (WEB后台可补单.理论上由客户端和充值服自动补单)
                -- 2: 验证失败.(WEB后台不可补单)
                -- 3: 发货成功. (WEB后台不可补单)
                -- 4: 发货成功(有争议). (WEB后台不可补单,需要查询日志单独通过邮箱发送)
                -- 5: 发货失败. (WEB后台可补单)
                -- 6: 验证服务器去第三方验证超时
                
            else
                print("订单处理失败,不做轮询")
                -- 40202   订单已被锁
                -- 40203   订单不存在
                -- 40204   订单已发货
                -- 40205   第三方订单号和本地订单号不匹配
                -- 40206   向第三方验证失败
                -- 40207   向第三方验证超时
                -- 删除记录
                self:removeOrderById(order_id)
                local msg_code = status
                if msg_code == 40202 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170859)
                elseif msg_code == 40203 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170837)
                elseif msg_code == 40204 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170835)
                elseif msg_code == 40205 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170836)
                elseif msg_code == 40206 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170838)
                elseif msg_code == 40207 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1170860)
                elseif msg_code == 45209 then
                    self:createByTextWhenNotInPolling(background,UI.TEXT_1326003)
                end

                -- if msg_code == -1 then
                --     self:createByTextWhenNotInPolling(background,UI.TEXT_1170834)
                -- elseif msg_code == 2 then
                --     self:createByTextWhenNotInPolling(background,UI.TEXT_1170835)
                -- elseif msg_code == 3 then
                --     self:createByTextWhenNotInPolling(background,UI.TEXT_1170836)
                -- elseif msg_code == 4 then
                --     self:createByTextWhenNotInPolling(background,UI.TEXT_1170837)
                -- elseif msg_code == 6 or msg_code == 8 then
                --     self:createByTextWhenNotInPolling(background,UI.TEXT_1170838)
                -- elseif msg_code == 7 then
                --     self:createByTextWhenNotInPolling(background,UI.TEXT_1170839)
                -- end
                -- 只处理这几个
                -- -1: 通用失败.
                -- 2: 使用过的(已经成功发货的)订单
                -- 3: 订单ID和收据ID不匹配.
                -- 4: 通过订单ID没有找到订单.
                -- 5: 到第三方验证订单成功.
                -- 6: 到第三方验证订单失败.
                -- 7: 渠道不合法.
            
            end
            -- dump(resp)
        else
            print("角色基本信息")
            print(NetHelper:getCommonSharedData())
            print("请求验证订单号失败,需要再次请求")
            if (device.platform == "ios" or device.platform == "android") then
                -- add by zp 调试出现的错误 CO-13475【支付】IOS支付补单异常问题修复
                buglyReportLuaException(tostring("支付丢单跟踪：请求验证订单号失败,需要再次请求"), "支付丢单跟踪：请求验证订单号失败,需要再次请求",false)  
            end
            -- 失败 需要再次验证
            if ENABLE_TIMEOUT_POOLLING then
                params.vstatus = 0
            end

            -- 每次失败了之后，强行写本地一次，便于下次启动游戏时，订单的状态正确
            Avalon.UserDataManager:saveDataToFile(self._purchaseData:getType())

            self:createByTextWhenNotInPolling(background,UI.TEXT_1170841)
        end
        if params.vstatus == 0 then
            -- 如果关闭状态 开启
            if self.schedulerID == 0 then
                -- 初始化所有验证超时的订单为0次
                -- 不能加入自己，因为自己刚刚去服务器验证的时候刚刚把verifyTimes 赋值为5 请求结束就又会初始化到0,会再次开启 死循环
                local orders = self._purchaseData:getAllOrders()
                for i,v in ipairs(orders) do
                    if checkint(v.verifyTimes) >= POLLING_TIME and params.cpOrderId ~= order_id then
                        v.verifyTimes = 0
                    end
                end
                self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), POLLING_INTERVAL, false)
            end
        end
    end
    
    xhr:registerScriptHandler(onReadyStateChanged)
    
    xhr:send(sendParam)
end
function SdkManager:getBoughts()
    return self._boughts
end
-- 请求已经购买过的数量
function SdkManager:reqBoughtNum(ids,types)
    for k,v in pairs(types) do
        self._limitTypes[k] = v
    end
    Net.NetPurchaseSystem:reqBoughtNum(GameDataManager:getInstance():getMasterPK(),ids);
end
function SdkManager:onGetBoughtResp(data)
    -- 刷新活动礼包购买数据
    if mvc.tradeActivityModel then
        mvc.tradeActivityModel:setGiftBoughtData(data)
    end

    self._boughts = data
    local timeStamp = GameManager:getNowServerTime()
    local curDays = math.floor( timeStamp/86400 )
    -- print("timeStamp",timeStamp/86400)
    local products = self._purchaseData:getProducts()

    local boughtNum = data.boughtNum or {}
    for i,v in ipairs(boughtNum) do
        local find = false
        for i1,v1 in ipairs(products) do
            if v1.productID == v.productID then
                find = v1
                break
            end
        end
        if not find then
            print("新的限购类型的商品,储存到本地 ",v.productID,v.boughtNum)
            table.insert(products,{productID = v.productID,boughtNum = v.boughtNum,days = curDays})
        else
            print("已经存在的限购类型的商品,更新限购数量 服务器的",v.boughtNum,"本地的",find.boughtNum)
            -- 如果当前的天数 大于了记录或者更新时候的天数,说明已经跨天了 需要使用服务器的记录
            local limitType = PublicDefine.PurchaseLimitType.PurchaseLimitType_Daily  
            for k,v in pairs(self._limitTypes) do
                if checkint(k) == find.productID then
                    limitType = v
                    break
                end
            end
            -- print("限购类型",find.productID,limitType)
            if not find.days then
                find.days = curDays
            end
           
            if find.days < curDays then
                if limitType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Daily or 
                limitType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Weekly
                 then
                    -- 每隔一天清理一次。降低误差
                    find.boughtNum = v.boughtNum
                end
                find.days = curDays
            else
                find.boughtNum = math.max( v.boughtNum,find.boughtNum)
            end
            
        end
    end

    local size = table.nums(products)  
    for i = size, 1, -1  do  
        local v = products[i]
        local find = false
        for i1,v1 in ipairs(boughtNum) do
            
            if v1.productID == v.productID then
                find = true
                break
            end
            
        end
        if not find then
            print("已经不存在的限购商品,从本地删除",v.productID)
            table.remove( products,i )
        end
    end  
    
    Avalon.UserDataManager:saveDataToFile(self._purchaseData:getType());

end
function SdkManager:createByTextWhenNotInPolling(background,text)
    if background then
        return ;
    end
    UI.ScrollBar:createByText(text)
end
-- 每10s轮询一次
function SdkManager:update(dt)
    local orders = self._purchaseData:getAllOrders()
    if table.nums(orders) <= 0 then
        
        if self.schedulerID ~= 0 then
            scheduler:unscheduleScriptEntry(self.schedulerID)
            self.schedulerID = 0
        end
        print("没有未验证成功的订单,关闭后台")
        return
    end
    local nums = 0
    for i,v in ipairs(orders) do
        if v.vstatus == 0 and v.verifyTimes < POLLING_TIME then
            nums = nums + 1;
            print("轮询订单 ",v.cpOrderId,"第几次",v.verifyTimes)
            self:verify(v,true)
        end
    end
    if nums <= 0 then
        if self.schedulerID ~= 0 then
            scheduler:unscheduleScriptEntry(self.schedulerID)
            self.schedulerID = 0
        end
        print("没有需要轮询的订单,或者都已经超过了次数限制,关闭后台")
    end
end
function SdkManager:removeOrderById(id, notSaveLocal)
    local orders = self._purchaseData:getAllOrders()
    local find = false
    for i,v in ipairs(orders) do
        if tostring(v.cpOrderId) == tostring(id) then
            table.remove( orders, i )
            find = true
            break;
        end
    end
    if not find then
        print("删除本地订单记录时未找到",id)
    end
    
    if not notSaveLocal then
        Avalon.UserDataManager:saveDataToFile(self._purchaseData:getType());
    end
end
-- 发货结果
-- orderID
-- result
function SdkManager:onPurchaseResult(data)
    dump(data,"发货结果")
    
    local ProtobufUtil = require "utils.ProtobufUtil"
    -- OrderStat_New = 1;//新订单
    -- OrderStat_Sending = 2;//正在发货
    -- OrderStat_SendedSuc = 3;  //成功发货
    -- OrderStat_OutTimeSendedSuc= 4;  //超时成功发货
    -- OrderStat_SendFailed = 5;  //发货失败
    -- OrderStat_SendByMail = 6; //发送邮件
    if(data.result == ProtobufUtil:enum_id("PurchaseSystem.OrderStat", "OrderStat_SendedSuc")) then 
        self._deliverOrderID = data.orderID
        if self._rdata and self._rdata.productID == data.productID and self._rdata.currencyType == PublicDefine.PurchaseCurrencyType.PurchaseCurrencyType_Diamond then
            self:boughtNumAdd(data.productID)
            Avalon.MessageCenter:notice(AvalonMessage.MC_SDK_PURCHASE_SUCC, data.productID) 
        end


        if self._rdata and self._rdata.productID == data.productID and self._rdata.currencyType == PublicDefine.PurchaseCurrencyType.PurchaseCurrencyType_Real then
            if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
                GameDataManager:getInstance():payReport( 
                self._curIdx, 
                self._rdata and self._rdata.price or 0, 
                data.orderID, 
                data.productID,
                data.buyNum,
                self._rdata and self._rdata.productID or 0)
            end
        end

        -- if CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE then
        --     if data.orderID then
        --         print("data.orderID =========== ",data.orderID, data.price, data.productID)
        --         self._serverReturnOderData[data.orderID] = {}
        --         self._serverReturnOderData[data.orderID].price = data.price
        --         self._serverReturnOderData[data.orderID].productID = data.productID

        --         self:actionOmissionOrderData()
        --     end
        -- end


        if self._curIdx ==  PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_DIAMOND then
            -- self:createByTextWhenNotInPolling(not self._isManualPurchase,UI.TEXT_1170853)
        else
            self:createByTextWhenNotInPolling(not self._isManualPurchase,UI.TEXT_1170843)
        end
        local purchased = RoleDataManager:getMaster():getDiamondPurchased()
        local isFind = false
        for i,v in ipairs(purchased) do
            if v.productID == data.productID then
                v.buyNum = v.buyNum + data.buyNum
                isFind = true;
            end
        end
        if not isFind then
            table.insert(purchased,{productID = data.productID,buyNum = data.buyNum})    
        end
        
        -- 
        -- 23030001
        -- diamond
        local diamond = checkint(data.diamond)

        -- dump(data)
        -- 生成相关的物品
        local rewardGoodsArr = {}
        for _,rewardData in pairs(data.goods) do
            local goodsData = GoodsDataManager:createLocalGoodsData(rewardData.goodsID)
            if (goodsData) then
                goodsData:setNum(rewardData.num)
                -- 这里默认给点金
                goodsData:setIsGolden(true)

                table.insert(rewardGoodsArr, goodsData)
            end
        end
        if diamond > 0 then
            local goodsData = GoodsDataManager:createLocalGoodsData(Game.ConstGoods.Diamond)
            if (goodsData) then
                goodsData:setNum(diamond)
                -- 这里默认给点金
                goodsData:setIsGolden(true)

                table.insert(rewardGoodsArr, goodsData)
            end
        end
        -- 如果没有 不提示
        if table.nums(rewardGoodsArr) <= 0 then
            return 
        end
        -- dump(rewardGoodsArr)
        -- TODO 显示获取物品TIPS
        local rewardData = {}
        rewardData.goods = rewardGoodsArr
        -- 是否因为背包已满走的邮件
        rewardData.isFullBagByMail = data.isFullBagByMail

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.IAP_ON_PURCHASERESULT, rewardData)
        SceneManager:getInstance():pushCommand(command)

        
        -- TODO 暂时收到此消息,不再做轮询处理
        self:removeOrderById(data.orderID)

        
    elseif(data.result == ProtobufUtil:enum_id("PurchaseSystem.OrderStat", "OrderStat_SendFailed")) then 
        if self._rdata and self._rdata.productID == data.productID and self._rdata.currencyType == PublicDefine.PurchaseCurrencyType.PurchaseCurrencyType_Diamond then
            if data.errType == ProtobufUtil:enum_id("PurchaseSystem.DeliverErrorType", "DeliverErrorType_NoEnoughDiamond") then
                UI.ScrollBar:createByTextID(1170016)
            elseif data.errType == ProtobufUtil:enum_id("PurchaseSystem.DeliverErrorType", "DeliverErrorType_FullPacket") then
                UI.ScrollBar:createByTextID(1170081)
            end
            return
        end
        self:createByTextWhenNotInPolling(not self._isManualPurchase,UI.TEXT_1170844)
    else
        print("warning 不正常的状态值",data.result)
        -- TODO 暂时收到此消息,不再做轮询处理
        self:removeOrderById(data.orderID)
    end
    
end

function SdkManager:onCloseAward(data)
    -- print("data.isFullBagByMail",data.isFullBagByMail)
    if data.isFullBagByMail then
        UI.ScrollBar:createByText(UI.TEXT_1170856)
    end
end
function SdkManager:storePayCallBack(params)
    local function readyToGetOrder()
        local preOrderParams = SdkBox:getInstance():getPreOrderParams()
        if #preOrderParams == 0 then return end
        local tempList = {}
        for k, data1 in pairs(preOrderParams) do
            local iapId = data1.productId
            if self._reqIapDatas then
                if iapId and iapId ~= "" then
                    for i,data2 in ipairs(self._iapDatas) do
                        local isRedeem = false
                        if Avalon.StrorePayFrom.SPFReedom == data1.from then
                            isRedeem = true
                        end
                        if data2.iapId == iapId then
                            self:getOrder(data2,1,data2.label, nil, isRedeem)   
                            table.insert(tempList, data1)
                        end
                    end
                end
            end
        end

        for k, v in pairs(tempList) do
            for k2, v2 in pairs(preOrderParams) do
                if v.productId == v2.productId then
                    preOrderParams[k2] = nil
                end
            end
        end
        SdkBox:getInstance():setPreOrderParams(preOrderParams)
    end
    
    if not self._products and (CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) and device.platform == "ios" then
        -- 如果是海外版,需要先等商品信息加载完毕
        self:loadProducts(iaps,function ()
            readyToGetOrder()
        end)    
    else
        readyToGetOrder()
    end
end
function SdkManager:onSdkPayFail(params)
    dump(params,"支付失败 参数 ")
    if(LOG_PAY_FLAG) then 
        print("PAY: 第三方支付失败回调 data=",params)
    end
    SdkBox:getInstance():finishTransaction(params.transactionIdentifier)
    Avalon.MessageCenter:notice(AvalonMessage.MC_SDK_PURCHASE_FAIL )

    mvc.tradeActivityModel:onSdkPayFail(params)
end
function SdkManager:getProducts()
    return self._products
end
-- 获取商品的多语言文本
function SdkManager:getProductsLan()
    return self._productsLan
end

function SdkManager:loadProductsLan(keyList,callback)
    LanguageManager:getInstance():getLanguageFromWebServer( keyList, function (webLaunguageList, params)
        self._productsLan = webLaunguageList
        if callback then
            callback(webLaunguageList)
        end
    end)
end

function SdkManager:loadProducts(iaps,callback)
    -- 加载所有商品信息
    printInfo("加载商品信息",iaps)
    local isSame = self:isSame(self.lastIaps, iaps)
    if not isSame then
        self.lastIaps = iaps
        SdkBox:getInstance():loadProducts(iaps,function(products)
            print("+++++++++loadProducts callback.")
            self._products = products
            if(callback) then
                callback()
            end
        end)

        Avalon.Scheduler:scheduleUpdateOnce(self, function()
             --如果15s之后还没收到苹果的产品信息， 需要把记录清0， 让15s后的下次拉取产品信息请求能够执行
            if self._products == nil then
                self.lastIaps = nil
            end
        end, 15)
    end
end

function SdkManager:isSame(oldIaps, newIaps)
    if oldIaps == nil then
        return false
    end
    if newIaps == nil then
        return true
    end
    if #oldIaps ~= #newIaps then
        return false
    end
    for _, v1 in ipairs(newIaps) do
        local isFind = false 
        for _, v2 in ipairs(oldIaps) do
            if v1 == v2 then
                isFind = true
            end
        end
        if not isFind then
            return false
        end
    end
    return true 
end

function SdkManager:setIapDatas(datas)
    self._iapDatas = datas
end
function SdkManager:getIapDatas()
    return self._iapDatas
end

--需要筛选掉 要隐藏的物品
function SdkManager:getShowIapDatas()
    local temp = {}
    local ProtobufUtil = require "utils.ProtobufUtil"
    for k, v in ipairs(self._iapDatas) do
        local isHide = false
        if ProtobufUtil:checkFieldIsInit(v, "ext") and v.ext ~= nil and v.ext ~= "'" then
            xpcall(function()
                local extParam = json.decode(v.ext)
                if extParam.show == false then
                    isHide = true
                end
            end, 
            function(e) 
            end, 1)
        end
        if not isHide then
            table.insert(temp, v)
        end
    end
    -- print("-------getShowIapDatas-----------", #self._iapDatas, #temp)
    return temp
end
-- 上传UI操作记录
function SdkManager:recordUIOperation(type)
    
    local gameLoginManager = require("app.game.GameLoginManager")
    local data = {
        zone = tostring(gameLoginManager:getInstance():getServerId()),
        type = type,
        pk = GameDataManager:getInstance():getMasterPK(),
    }
    Net.Helper:sendHttpMessage(Net.HttpSubDirection.UIOperationLog,data)
end
-- 上传新手引导步骤
function SdkManager:recordStoryModeStep(step)
    local gameLoginManager = require("app.game.GameLoginManager")
    local data = {
        zone = tostring(gameLoginManager:getInstance():getServerId()),
        step = step,
        pk = GameDataManager:getInstance():getMasterPK(),
    }
    
    Net.Helper:sendHttpMessage(Net.HttpSubDirection.StoryModeStep,data)
end

-----------------
--引导评论相关-----
-----------------

--检查触发点
function SdkManager:checkCommentEvent(eventId)
    print("-------------checkCommentEvent")
    if not CONFIG_COMMENT then
        return
    end
    local ServerConfigUtil = require("app.utils.ServerConfigUtil")
    if ServerConfigUtil:getWebConfiguredCommentUrl() == "" and ServerConfigUtil:getWebConfiguredBundleId() == "" then
        return
    end
    if self._commentEventMap == nil then
        self:readLocalFile()
    end
    local eventCfg = ConfigManager:getAllCommentEventCfg()[eventId]
    if eventCfg == nil then
        return
    end
    local isShow = self:isShowCommandLayer(eventId, eventCfg)
    if isShow then
        if ServerConfigUtil:isInReview() then 
            -- eventCfg.alertType = COMMENT_ALERT_TYPE.SCORE
            return
        end
        if eventCfg.alertType == COMMENT_ALERT_TYPE.SCORE and SdkBox:getInstance():isCanOpenReview() then
            SdkBox:getInstance():requestReview()
            self:beginRecordTime(eventCfg)
        else
            self:jumpToAppStore(eventCfg)
        end
    end
end

function SdkManager:isShowCommandLayer(eventId, eventCfg)
    local allEventCfg = ConfigManager:getAllCommentEventCfg()
    if self._commentSuccess then
        -- print("---------comment have finish !")
        return false
    end
    local data = self._commentEventMap[eventId]
    local size = table.nums(self._commentEventMap)
    if data == nil and size <= 0 then
        return true
    end
    local curTime = os.time()
    local publicTime = 0
    for k, v in pairs(self._commentEventMap) do
        if v.generateTime > publicTime then
            publicTime = v.generateTime
        end
    end
    if publicTime ~= 0 and (curTime - publicTime) / SECONDS_ONE_DAY <= tonumber(Config.General:getValueForKey("commentPublicCDTime")) then
        -- print("---------is in public cd")
        return false
    end
    if data == nil then
        return true
    end
    if (curTime - data.generateTime) / SECONDS_ONE_DAY <= eventCfg.CDTime then
        -- print("---------is in self cd")
        return false
    end
end

 --1、播放剧情对话 2、弹出tips 界面 3 点击按钮跳转商店评论
function SdkManager:jumpToAppStore(eventCfg)
    local okCallback = function()
        local ServerConfigUtil = require("app.utils.ServerConfigUtil")
        SdkBox:getInstance():jumpToAppStore(ServerConfigUtil:getWebConfiguredCommentUrl(), ServerConfigUtil:getWebConfiguredBundleId())
        self:beginRecordTime(eventCfg)
    end

    local cancleCallback = function()
        self:beginRecordTime(eventCfg)
    end
    
    if eventCfg.dialogue == 0 then
        -- okCallback()
        UI.TipsLayer:onJumpToComment(okCallback, cancleCallback)
        return
    end
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, eventCfg.dialogue, function()
        UI.TipsLayer:onJumpToComment(okCallback, cancleCallback)
    end)         
end

function SdkManager:writeLocalFile()
    Avalon.FileManager:saveMapDataToLocal(self._commentEventMap, commentFile, false)
end

function SdkManager:readLocalFile()
    self._commentEventMap = Avalon.FileManager:readMapDataFromLocal(commentFile, false) or {}
end

--记录上次点击屏幕时间 和 下次点击屏幕时间 超过8秒算评分成功  超过12秒算评论成功
function SdkManager:beginRecordTime(eventCfg)
    self._isRecordBeginTime = os.time()
    self.recordEventCfg = eventCfg

    local data = {}
    data.generateTime = self._isRecordBeginTime 
    self._commentEventMap[eventCfg.ID] = data
    self:writeLocalFile()
end

--1: 表示唤醒触发， 2表示点击屏幕触发
function SdkManager:endRecordTime(noticeType)
    -- print("----endRecordTime noticeType = "..noticeType)
    if self._isRecordBeginTime == 0 then
        return
    end
    local curTime = os.time()
    local isSuccess = false


    if self.recordEventCfg and self.recordEventCfg.alertType == COMMENT_ALERT_TYPE.SCORE and noticeType == COMMENT_END_NOTICE_TYPE.TOUCH_SCREEN and curTime - self._isRecordBeginTime > 6 then
        isSuccess = true
    elseif self.recordEventCfg and self.recordEventCfg.alertType == COMMENT_ALERT_TYPE.MESSAGE and  noticeType == COMMENT_END_NOTICE_TYPE.GAME_ACTIVE and curTime - self._isRecordBeginTime > 12 then
        isSuccess = true
    end
    if isSuccess then
        --todo  记录 本地评论成功
        self._commentSuccess = true
        cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.CommentSuccess,true) 
        self:writeLocalFile()
    end
    self._isRecordBeginTime = 0
    self.recordEventCfg = nil
end

----web服务器 记录打点---
function SdkManager:sendWebLog(logType,subId,opttype,old,new)
    local data = self:getShareWebData()
    data.type = logType
    data.id = subId
    data.opttype = opttype
    data.old = old
    data.new = new
    -- dump(data,"上报客户端操作记录")
    Net.Helper:sendHttpMessage(Net.HttpSubDirection.WebLog, data)
end

--对接口的扩展 可以已table格式传入多个参数 params：table 格式
function SdkManager:sendWebLogWithParams(logType, subId, params, repeatCount)
    local data = self:getShareWebData()
    data.type = logType
    data.id = subId

    if type(params) == "table" then
        table.merge(data, params)
    end
    Net.Helper:sendHttpMessage(Net.HttpSubDirection.WebLog, data, nil, nil, repeatCount)
end

function SdkManager:getShareWebData()
    local gameLoginManager = require("app.game.GameLoginManager")
    local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
    local guildData = MasterDataManager:getGuildData() or {}
    local checkpointTb = RoleDataManager:getCheckpointData(LevelSelectUtil:getInstance().mCaveMode,LevelSelectUtil:getInstance().mOpenDifficulty) or {}
    
    local zone = gameLoginManager:getInstance():getServerId()
    local data = {
        accountStr = gameLoginManager:getInstance():getAccountId(),--"1_2_3_4_5_9999",
        nickname = RoleDataManager:getMaster():getNickName(),
        pk = RoleDataManager:getMaster():getPK(),
        lv = RoleDataManager:getMaster():getLevel(),
        mode = LevelSelectUtil:getInstance().mCaveMode,
        diff = LevelSelectUtil:getInstance().mOpenDifficulty, 
        scLv = guildData.techTotalLv,
        checkpoint = checkpointTb:getCheckpoint(),
        deviceInfo = AvalonUtil.getDeviceName(),
        idfa = AvalonUtil.getIDFA(),
        uuid = AvalonUtil.getOpenUUID(),
        imei = AvalonUtil.getIMEI(),
        adid = AvalonUtil.getADID(),
        mac = AvalonUtil.getMAC(),
        languageType = LanguageManager:getInstance():getLanguage(),

        platform = SdkBox:getInstance():getVersionPlatform(),
        account = SdkBox:getInstance():getVersionAccount(),
        zone = zone,
        channel = SdkBox:getInstance():getVersionChannel(),
        scene = SceneManager:getInstance()._state,
    }
    return data
end

----web服务器 客服工具---
--设备名、系统版本、mac地址、IP、IMEI, 位置，网络环境 )  -- 版本号（原始版本和热更后的版本要有所区分）、客户端使用语言
function SdkManager:openCSWeb(roleId, roleName, roleLevel, zoneId)
    local SdkBox = require("utils.sdkbox.SdkBox")
    local params = {
        deviceId = AvalonUtil.getDeviceID(),
        device = AvalonUtil.getDeviceName(),
        osVersion = AvalonUtil.getSystemVersion(),
        mac = AvalonUtil.getMAC(),
        ip = Net.Helper:getIPAddress(),
        imei = AvalonUtil.getIMEI(),      
        location = AvalonUtil.getLocation(),
        networkMode = AvalonUtil.getNetworkMode(),
        clientVersion = Avalon.HotfixManager:getLocalVersion(),
        languageId = LanguageManager:getInstance():getLanguage(),
        target = SdkBox:getInstance():getVersionTarget(),
        channel = SdkBox:getInstance():getVersionChannel(),
        platform = SdkBox:getInstance():getVersionPlatform(),
        roleId = roleId, 
        roleLevel = roleLevel, 
        zoneId = zoneId
    } 
    if roleName then
        params.roleName = string.urlencode(roleName)
    end
    local sortTable = AvalonUtil:sortParamByFirstChar(params)
    -- dump(sortTable, "sortTable")
    local md5ParamStr = ""
    local paramsStr = ""
    local paramTable = {}
    for k, v in ipairs(sortTable) do
        md5ParamStr = md5ParamStr..v.value
        paramsStr = paramsStr..v.key.."="..v.value.."&"
    end
    local md5Str = AvalonUtil:MD5(md5ParamStr..WEB_MD5_KEY)
    paramsStr = paramsStr.."md5Str="..md5Str
    local url = ServerConfigUtil:getWebManageUrl()..Net.HttpSubDirection.CS.."?"..paramsStr
    print("----url = "..url)
    GameManager:openUrl(url)
end

function SdkManager:filterDataWithWebCondition(dataArr)
    -- 过滤WEB后台条件限制
    local masterData = GameDataManager:getInstance():getMaster()
    
    for i = #dataArr, 1, -1 do
        local data = dataArr[i]
        local meetCondition = true
        for i,v in ipairs(data.buyLimit) do
            if v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_Level then
                local min = v.conditionValue
                local max = v.conditionMax or 0
                if (max == 0) then
                    max = nil
                end
                local currentLv = masterData:getLevel()
                if (currentLv) then
                    if ((min and currentLv < min) or (max and currentLv > max)) then
                        meetCondition = false
                    end
                end
            elseif v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_Cave or 
            v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_DesertEye then
                --到达指定层数(模式难度层数复合字段)
                -- 探索XX难度洞窟YY层：   01:01:1001  模式:难度:层数
                -- 参与大秘境XX层：
                local function parseCaveParams(rawValue)
                    local caveMode = 1
                    local diffculty = 1
                    local level = 23
                    local value = checkint(rawValue)
                    -- caveMode = math.modf(value/1000000)
                    -- value = value - 1000000 * caveMode
                    -- diffculty = math.modf(value/10000)
                    -- value = value - 10000 * diffculty
                    -- level = value

                    caveMode = math.modf(value/10000)
                    value = value - 10000 * caveMode
                    diffculty = math.modf(value/100)
                    value = value - 100 * diffculty
                    level = value * 10

                    return caveMode, diffculty, level
                end
                local min = v.conditionValue
                local max = v.conditionMax or 0
                local caveMode, diffculty, min = parseCaveParams(min)

                if (max and max ~= 0) then
                    local _1, _2, maxProcessed = parseCaveParams(max)
                    max = maxProcessed
                end
                if (max == 0) then
                    max = nil
                end
                
                local maxLevel = 0
                local maxLevelData = masterData:getMaxLevelData(caveMode, diffculty)
                if (maxLevelData) then
                    maxLevel = maxLevelData:getMaxLevel()
                end
                
                if ((min and maxLevel < min) or (max and maxLevel > max)) then
                    meetCondition = false
                end

            elseif v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_HeroCave then

                if(not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)) then
                    meetCondition = false;
                end

            elseif v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_DistortedSpace or 
                v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_Inferno then
                -- 扭曲空间 和炼狱
                local function parseCaveParams(rawValue)
                    local caveMode = 1
                    local diffculty = 1
                    local level = 1
                    local value = checkint(rawValue)

                    caveMode = math.modf(value/10000)
                    value = value - 10000 * caveMode
                    level = math.modf(value/100)
                    value = value - 100 * level
                    diffculty = value
                    level = level * 10

                    return caveMode, diffculty, level
                end
                local min = v.conditionValue
                local max = v.conditionMax or 0
                local caveMode, diffculty, min = parseCaveParams(min)
                if (max and max ~= 0) then
                    local _1, _2, maxProcessed = parseCaveParams(max)
                    max = maxProcessed
                end
                if (max == 0) then
                    max = nil
                end
                local maxLevel = 0
                local maxLevelData = masterData:getMaxLevelData(caveMode, diffculty)
                if (maxLevelData) then
                    maxLevel = maxLevelData:getMaxLevel()
                end
                
                min = min / 10
                if min < 1 then
                    min = 1
                end
                if ((min and maxLevel < min) or (max and maxLevel > max)) then
                    meetCondition = false
                end

            elseif v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_CreateTime then
                local roleCreateTime = masterData:getCreateRoleTime()
                local minInDay = v.conditionValue / SECONDS_ONE_DAY
                local maxInDay = v.conditionMax and v.conditionMax / SECONDS_ONE_DAY or 0
                if (maxInDay == 0) then
                    maxInDay = nil
                end
                if ((minInDay and roleCreateTime < minInDay) or (maxInDay and roleCreateTime > maxInDay)) then
                    meetCondition = false
                end
            elseif v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_ChargeAmount then
                require "app.datas.MasterDataManager"
                local totalPaid = MasterDataManager:getPayMoneyCount()
                local min = v.conditionValue
                local max = v.conditionMax or 0
                if (max == 0) then
                    max = nil
                end
                if ((min and totalPaid < min) or (max and totalPaid > max)) then
                    meetCondition = false
                end
            elseif v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_LastChargeTime then
                local lastPurchaseDeltaInDay = masterData:getLastPurchaseTime()
                local minInDay = v.conditionValue / SECONDS_ONE_DAY
                local maxInDay = v.conditionMax and v.conditionMax / SECONDS_ONE_DAY or 0
                if (maxInDay == 0) then
                    maxInDay = nil
                end
                if ((minInDay and lastPurchaseDeltaInDay < minInDay) or (maxInDay and lastPurchaseDeltaInDay > maxInDay)) then
                    meetCondition = false
                end
            end
            if (not meetCondition) then break end
        end
        if (not meetCondition) then
            table.remove(dataArr, i)
        end
    end
end

-- 已弃用, 留着做兼容
function SdkManager:getCurrentcyLocationCode()
    return self._currencyLocationCode
end

-- 获取SDK返回的初始打折价钱
function SdkManager:getPriceInitial(iapID)
    if ((not self._iapPriceStringTable and not self._products) or not iapID) then return end

    -- 检查self._iapPriceStringTable
    local initPrice = -1
    local entry = self._iapPriceStringTable[iapID]
    if (entry) then 
        initPrice = entry.initialPrice
    end
    if(initPrice == nil) then 
        initPrice = -1
    end

    -- 检查self._products
    if (initPrice < 0 and self._products) then
        local entry = nil
        for i,v in ipairs(self._products) do
            if (v.introPrice and v.introPrice > 0 and v.productIdentifer == iapID) then
                initPrice = v.introPrice
                break
            end
        end
    end

    -- 如果没有返回空
    if (initPrice < 0) then
        return
    end
    return initPrice
end

-- 获取SDK返回的包含货币符号的价钱
function SdkManager:getPriceStringFromIapID(iapID)
    if (not self._iapPriceStringTable or not iapID) then return end

    local entry = self._iapPriceStringTable[iapID]
    if (not entry) then return end

    return entry.priceString
end

-- 获取SDK返回的不带货币符号的值
function SdkManager:getPriceValueFromIapID(iapID)
    if (not self._iapPriceStringTable or not iapID) then return end

    local entry = self._iapPriceStringTable[iapID]
    if (not entry) then return end

    return entry.value
end

function SdkManager:requestIAPInfoData(iapIDList)
    local params = {}
    local consumptionArr ={}
    local subscribeArr = {}
    params.consumptionArr = consumptionArr
    params.subscribeArr = subscribeArr

    if (iapIDList) then
        for i,v in ipairs(iapIDList) do
            if (v ~= "") then
                if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.MonthlySubscription then 
                    table.insert(subscribeArr, v.iapId)
                else
                    table.insert(consumptionArr, v.iapId)
                end
            end
        end
    elseif (self._iapDatas and #self._iapDatas > 0) then
        for i,v in ipairs(self._iapDatas) do
            if (v.iapId and v.iapId:gsub(" ", "") ~= "") then
                if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.MonthlySubscription then 
                    table.insert(subscribeArr, v.iapId)
                else
                    table.insert(consumptionArr, v.iapId)
                end
            end
        end
    end

    local SdkBox = require("utils.sdkbox.SdkBox")
    local requestStr = json.encode(params)
    print("requestIAPInfoData=", requestStr)
    SdkBox:getInstance():requestIAPInfoData(requestStr)
end

function SdkManager:requestCurrencyLocationCode(iapIDList)
    if(SdkBox:getInstance():isSupportSubscribe()) then 
        local channel = SdkBox:getInstance():getVersionChannel()
        channel = checkint(channel)
        if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_GOOGLEPLAY then
            self:requestIAPInfoData(iapIDList)
            return
        end
    end

    local params = {}

    if (iapIDList) then
        for i,v in ipairs(iapIDList) do
            if (v ~= "") then
                params[v.iapId] = "" -- 底层要求这么传, 用id做key
            end
        end
    elseif (self._iapDatas and #self._iapDatas > 0) then
        for i,v in ipairs(self._iapDatas) do
            if (v.iapId and v.iapId:gsub(" ", "") ~= "") then
                params[v.iapId] = "" -- 底层要求这么传, 用id做key
            end
        end
    end

    local SdkBox = require("utils.sdkbox.SdkBox")
    SdkBox:getInstance():getPriceLocationCode(params)
end

-----------------
--推送相关-----
-----------------


function SdkManager:markNewIapBox()
    self._newIapBox = true
end
function SdkManager:removeNewIapBoxMark()
    self._newIapBox = false
end
function SdkManager:haveNewIapBox()
    return self._newIapBox
end

-- 是否启用新支付的接口
function SdkManager:enableNewPay()
    -- if CAVEOL_TARGET ~= CAVEOL_TARGET_CN then
    --     return true
    -- end

    -- return false
    return true
end

-- --处理订单数据丢失的数据上报逻辑
-- function SdkManager:actionOmissionOrderData()

--     self._omissionOrderData = {} --上报遗漏的订单数据
--     self._serverReturnOderData = {} --服务器发货的订单数据

--     local deleteOrderTable = {}

--     for k,v in pairs(self._omissionOrderData) do
--         for m,n in pairs(self._serverReturnOderData) do
--             if tostring(k) == tostring(m) then
--                 GameDataManager:getInstance():payReport(
--                 v.curIdx, 
--                 n.price or 0, 
--                 v.transactionIdentifier, 
--                 v.curIapId, 
--                 v.buyCount,
--                 n.productID or 0)

--                 table.insert(deleteOrderTable,k)
--                 break;
--             end
--         end
--     end

--     for k,v in pairs(deleteOrderTable) do
--         self._omissionOrderData[k] = nil
--     end


-- end

--国家特殊日期要求屏蔽部分功能的条件和开关
function SdkManager:responsePolicySwitch()
    local switch = false
    if (CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_CN) and SdkBox:getInstance():isGuest() then
    -- if (CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_CN) then
        switch = true
    end

    return switch
end

return SdkManager;
