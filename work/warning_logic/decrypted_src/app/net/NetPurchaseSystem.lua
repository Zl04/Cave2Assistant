local ProtobufUtil = require "utils.ProtobufUtil"

Net = Net or {}
local NetPurchaseSystem = {}
Net.NetPurchaseSystem = NetPurchaseSystem


-- 内购消息处理
function NetPurchaseSystem:onPurchaseMessageHandler(no, data)
     if (no == NetMessageType.PURCHASE_RESPONSE_PRODUCTS.NO) then
        local SdkManager = require "app.game.SdkManager"
        SdkManager:getInstance():refreshProducts(data)
        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_PRODUCTS, data) -- 因为服务器需要多次发放Data, 所以把数据SdkManager里缓存后发放
        -- dump(data,"商品列表",10)
    elseif (no == NetMessageType.PURCHASE_RESPONSE_ORDER.NO) then
        -- dump(data,"获取到的订单号")
        Avalon.MessageCenter:notice(GameMessage.MC_GET_ORDER_RESP, data)
    -- 客户端发货成功
    elseif (no == NetMessageType.DELIVER_PRODUCT_RESULT_MESSAGE.NO) then
        
        Avalon.MessageCenter:notice(GameMessage.MC_PURCHASE_SUCCESS, data)
        -- required string orderID = 1;  //订单ID
        -- optional uint32 result = 2;   //发货结果 OrderStat
    elseif (no == NetMessageType.REQ_PURCHASE_ERROR.NO) then
        Avalon.MessageCenter:notice(GameMessage.MC_REQ_PURCHASE_ERROR, data)
    -- 返回玩家已经购买的商品信息
    elseif (no == NetMessageType.PURCHASE_RESPONSE_PRODUCTBOUGHTNUM.NO) then
        Avalon.MessageCenter:notice(GameMessage.MC_GET_BOUGHT_RESP, data)
    -- 服务器通知上新宝箱
    elseif (no == NetMessageType.UPDATE_IAPSHOP_BOX_NUMS.NO) then
        -- 记录有新宝箱上架
        local SdkManager = require "app.game.SdkManager"
        SdkManager:getInstance():markNewIapBox()
        
        Game.ChatManager:getInstance():sendSystemMsg(UI.TEXT_1170855,ChatMessageType.SYSTEM_MESSAGE)
        Avalon.MessageCenter:notice(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, data)
    elseif (no == NetMessageType.RECHARGE_RESPONSE_FIRST_RECHARGE.NO) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_FIRST_RECHARGE_STATUS_CHANGED, data)
    elseif (no == NetMessageType.RECHARGE_RESPONSE_SUPPLY.NO) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_SUPPLY_STATUS_REFRESH, data)
        Avalon.MessageCenter:notice(AvalonMessage.MC_MONTH_CARD_STATUS_REFRESH)
        if (data.result == ProtobufUtil:enum_id("PurchaseSystem.ReqSupplyReceiveResult", "ReqSupplyReceiveResult_Succeed")) then
            UI.ScrollBar:createByTextID(1111430)
        else
            UI.ScrollBar:createByTextID(1111118)
        end
    elseif (no == NetMessageType.RECHARGE_RESP_CLAIM_MONTH_SUBS.NO) then
        -- print("RECHARGE_RESP_CLAIM_MONTH_SUBS", data)
        Avalon.MessageCenter:notice(AvalonMessage.MC_SUPPLY_STATUS_REFRESH, data)
        Avalon.MessageCenter:notice(AvalonMessage.MC_MONTH_CARD_STATUS_REFRESH)
        if (data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            UI.ScrollBar:createByTextID(1111430)
        else
            UI.ScrollBar:createByTextID(1111430)
        end
    elseif (no == NetMessageType.RES_LIFETIME_REWARD_MESSAGE.NO) then
        if (data.result == "ResLifetimeRewardResult_HasReveived") then
            UI.ScrollBar:createByTextID(1170185)
        elseif (data.result == "ResLifetimeRewardResult_Succeed") then
            UI.ScrollBar:createByTextID(1111430)
        else
            UI.ScrollBar:createByTextID(1111118)
        end
    else
        assert(false, string.format("[Net.NetPurchaseSystem] onPurchaseMessageHandler no %d is invaild.", no))
    end
end

function NetPurchaseSystem:reqBoughtNum(pk,ids)
    local requestData = {}
    requestData.pk = pk
    requestData.productID = ids
    dump(requestData,"请求已购买的商品数量")
    
    Net.Helper:sendMessage(NetMessageType.PURCHASE_REQ_PRODUCTBOUGHTNUM,requestData)
    
end

function NetPurchaseSystem:reqProducts(list,isSingle,myChannel)
    
    local requestData = {}
    requestData.reqList = list or {}
    requestData.isSingle = isSingle or false
    requestData.channel = myChannel
    
    Net.Helper:sendMessage(NetMessageType.PURCHASE_REQUEST_PRODUCTS,requestData)
    -- print("请求商品列表")
end
function NetPurchaseSystem:reqPurchase(deviceID,uuid,productId,count,channel,platform,iapID,ext, index, productType)
    local requestData = {}
    requestData.deviceID = deviceID
    requestData.uuid = uuid
    requestData.productId = productId
    requestData.count = count
    requestData.channel = channel
    requestData.platform = platform
    requestData.ext = ext
    requestData.iapID = iapID
    requestData.index = index
    requestData.productType = productType

    print("NetPurchaseSystem:reqPurchase requestData ==== ")
    print(requestData)

    Net.Helper:sendMessage(NetMessageType.PURCHASE_REQ_PURCHASE,requestData)
    
end
function NetPurchaseSystem:reqVerify(orderID,IAPid,VerifCode )
    local requestData = {}
    requestData.orderID = orderID
    requestData.IAPid = IAPid
    requestData.VerifCode = VerifCode

    dump(requestData)
    Net.Helper:sendMessage(NetMessageType.PURCHASE_VERIFY,requestData)
    
end