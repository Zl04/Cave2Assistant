--
-- Author: yueyingsong
-- Date: 2017-11-21 17:31:12
--
PayUtil = PayUtil or {}

-- 20001	余额不足
-- 20002	充值设备被封停
-- 20003	充值包体被封停
-- 20004	充值功能未开放
-- 20005	订单号重复
-- 20006	当日充值额度达到上限
-- 20007	雷霆订单号不存在
-- 20008	下单用户与付款用户信息不一致
-- 20009	游客账号禁止充值
-- 20010	当日充值次数达到上限
-- 20011	第三方订单获取失败
-- 20012	凭证已被使用
-- 20013	商品ID验证失败
-- 20014	通知游戏发货失败
-- 20015	连接游戏服务器网络异常
-- 20016	订单正在处理中
-- 20017	订单状态异常
-- 20018	订单非待推状态，客户端无须重推
function PayUtil:createTips(code,transaction)
	code = checkint(code)
	if code ==  Avalon.PayResultCode.kPaySuccess 
		or code ==  Avalon.PayResultCode.kPayRechargeSuccess
	then
		-- add by zp 九游这里返回的成功只是创建订单成功，不是支付成功，所以直接不提示支付成功
		local SdkBox = require("utils.sdkbox.SdkBox")
        local channel = SdkBox:getInstance():getVersionChannel()
        channel = checkint(channel)
        if not (CAVEOL_TARGET == CAVEOL_TARGET_CN and channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_UC)  then
			self:createDelayToast(UI.TEXT_1170814)
		end
	-- 拓展字段 一般是第三方sdk的
	elseif code ==  Avalon.PayResultCode.kPayExtension then
		code = checkint(transaction.errorCode)
		if code == 20001 then
		elseif code == 20001 then
			self:createDelayToast(UI.TEXT_1170802)
		elseif code == 20002 then
			self:createDelayToast(UI.TEXT_1170803)
		elseif code == 20003 then
			self:createDelayToast(UI.TEXT_1170803)
		elseif code == 20004 then	
			self:createDelayToast(UI.TEXT_1170804)
		elseif code == 20005 then
			self:createDelayToast(UI.TEXT_1170805)
		elseif code == 20006 then
			self:createDelayToast(UI.TEXT_1170806)
		elseif code == 20007 then
			self:createDelayToast(UI.TEXT_1170807)
		elseif code == 20008 then
			self:createDelayToast(UI.TEXT_1170817)
		elseif code == 20009 then
			self:createDelayToast(UI.TEXT_1170808)
		elseif code == 20010 then
			self:createDelayToast(UI.TEXT_1170809)
		elseif code == 20011 then
			self:createDelayToast(UI.TEXT_1170812)
		elseif code == 20012 then
			self:createDelayToast(UI.TEXT_1170812)
		elseif code == 20013 then
			self:createDelayToast(UI.TEXT_1170817)
		elseif code == 20014 then
			self:createDelayToast(UI.TEXT_1170812)
		elseif code == 20015 then
			self:createDelayToast(UI.TEXT_1170816)
		elseif code == 20016 then
			self:createDelayToast(UI.TEXT_1170811)
		elseif code == 20017 then
			self:createDelayToast(UI.TEXT_1170812)
		elseif code == 20018 then
			self:createDelayToast(UI.TEXT_1170813)
		else
			self:createDelayToast(UI.TEXT_1170803)
		end
	elseif code ==  Avalon.PayResultCode.kPayFail  then
		local text = UI.TEXT_1170803
		local ignore = false
		if (transaction.billingResponseCode ~= nil) then
			text = text .. " (" .. transaction.billingResponseCode .. ")"
			-- add by zp CO-15541【SDK】global玩家登录游戏就弹出payment failed(3)提示
			if(transaction.billingResponseCode == 3 or transaction.billingResponseCode == "3") then 
				ignore = true
			end
		end
		if not ignore then
			self:createDelayToast(text)
		end
	elseif code ==  Avalon.PayResultCode.kPayCancel then
		self:createDelayToast(UI.TEXT_1170815)
	elseif code ==  Avalon.PayResultCode.kPayNetworkError then
		self:createDelayToast(UI.TEXT_1170816)
	elseif code ==  Avalon.PayResultCode.kPayProductionInforIncomplete then
		self:createDelayToast(UI.TEXT_1170817)
	elseif code ==  Avalon.PayResultCode.kPayInitFail then
		self:createDelayToast(UI.TEXT_1170858)
	elseif code ==  Avalon.PayResultCode.kPayNowPaying then
		
		self:createDelayToast(UI.TEXT_1170813)
	elseif code ==  Avalon.PayResultCode.kPayAlreadyPurchased then
		self:createDelayToast(UI.TEXT_1170826)
	elseif code ==  Avalon.PayResultCode.kPayInvalidSku then
		self:createDelayToast(UI.TEXT_1170847)
	elseif code ==  Avalon.PayResultCode.kPayNotSupported then
		self:createDelayToast(UI.TEXT_1170848)
	elseif code ==  Avalon.PayResultCode.kPayNotLoginMarketplace then
		self:createDelayToast(UI.TEXT_1170861)
	end	
end
function PayUtil:createDelayToast(text)
	local delay = cc.DelayTime:create(0.3)
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function ()
		UI.ScrollBar:createByText(text)
	end))
	local scene = cc.Director:getInstance():getRunningScene()
	if not tolua.isnull(scene) then
		scene:runAction(sequence)
	end
    
end