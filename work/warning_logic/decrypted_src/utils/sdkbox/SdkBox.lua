--[[
	sdk相关代码(不要多次初始化)
]]

require("utils.sdkbox.SdkBoxConst")
require("cocos.cocos2d.functions")
require("app.utils.PayUtil")
require("app.datas.PublicDefine")
local bit32 = require("bit")
local json = require "json"

GOOGLE_TRANSLATE_EVENT = {
	TRANSLATE_EVENT = 1,
	GET_SUPORT_LANGUAGE_EVENT = 2,
	DETECT_LANGUAGE_EVENT = 3,
	CAN_NOT_TRANSLATE_EVENT = 4,
}

--AvalonADS 的 AdsSDKType定义一致
AdsSDKType = {
	AdsNormal = 0,--以前老的SDK的统一ID*/
	AdsTOPON = 1, --topon 广告聚合平台*/
}

local INIT_GOOGLE_TRANSLATE_COMMAND_ID = "-100000"

local SdkBox = class("SdkBox")

g_SdkBox = nil;

function SdkBox:getInstance()
	if g_SdkBox == nil then
		g_SdkBox = SdkBox.new()
		g_SdkBox:init()
	end
	return g_SdkBox;
end


function SdkBox:purgeInstance()
	if g_SdkBox ~= nil then
		g_SdkBox = nil;
	end
end


function SdkBox:ctor()
	self._isInit 				= false;
	self._isUserActionAvailable	= true
	self._sdk 					= nil;	
	self._loginSuccessCallback 	= nil;
	self._loginFailCallback 	= nil;

	self._logoutSuccessCallback = nil;
	self._logoutFailCallback  	= nil;

	self._paySuccessCallback 	= nil;
	self._payFailCallback 		= nil;
	self._payCurrencyCodeCallback     = nil;
	self._storePayCallback 		= nil;
	-- 用户系统插件
	self._userPlugin 			= nil;
	-- 分享系统插件
	self._sharePlugin 			= nil;
	-- 支付系统插件
	self._payPlugin 			= nil;
	-- 推送系统插件
	self._pushPlugin			= nil;
	self._onInAppMessageClosed  = nil
	-- 数据统计插件
	self._analyticsPlugin 		= nil;
    -- 广告插件
	self._adsPlugin	            = nil
	-- 扩展包插件
	self._expansionPlugin		= nil
	self._expDlSuccessCallback	= nil
	-- 录屏插件
	self._screenRecordPlugin	= nil
	self._screenRecordAuthSucc 	= nil
	self._screenRecordAuthFail	= nil
	self._screenRecordStartSucc = nil
	self._screenRecordStartFail	= nil
	self._screenRecordingError	= nil
	self._screenRecordSaveSucc	= nil
	self._screenRecordSaveFail	= nil

	self._sharePlatform			= nil;

	self.translationCallback 	= nil;
	self.currentGoogleTranslationLanguage = ""

	self._isToLogoutGameWhenSDKLogout = true

	self.antiAddictionStatus = nil
	self._preOrderParams = {}
	self._successOrder = {}


	self.buglyInit = false
end

-- 设置是否在SDK登出的时候也自动登出游戏
function SdkBox:setToLogoutGameWhenSDKLogout(b)
	self._isToLogoutGameWhenSDKLogout = b
end

-- 游戏内消息关闭回调
function SdkBox:onInAppMessageClosed(callback)
	self._onInAppMessageClosed = callback
end
-- 登出失败
function SdkBox:onSdkLogoutFail(callback)
	self._logoutFailCallback = callback
end
-- 登出成功
function SdkBox:onSdkLogoutSuccess(callback)
	self._logoutSuccessCallback = callback
end
-- 登入成功
function SdkBox:onSdkLoginSuccess(callback)
	self._loginSuccessCallback = callback
end
-- 登入失败
function SdkBox:onSdkLoginFail(callback)
	self._loginFailCallback = callback;
end
-- 支付成功
function SdkBox:onSdkPaySuccess(callback)
	print("onSdkPaySuccess",callback)
	self._paySuccessCallback = callback
	if(self._paySuccessCallback) then
		for i,v in ipairs(self._successOrder) do
			self._paySuccessCallback(v)
		end
		self._successOrder = {}
	end
	print("self._paySuccessCallback",self._paySuccessCallback)
end
-- 支付失败
function SdkBox:onSdkPayFail(callback)
	self._payFailCallback = callback
end

-- 支付获取详细信息
function SdkBox:onPayCurrencyCodeCallback(callback)
	self._payCurrencyCodeCallback = callback
end

function SdkBox:getIsWaitingSdkInitSuccess()
	if (CAVEOL_TARGET_CN == CAVEOL_TARGET or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) 
		and device.platform == "android" 
		and SdkBox:getInstance():isSupportPrivacy() then
		return true
	end

	return false
end

function SdkBox:init()
	if self._isInit then return end;
	self._sdk = avalon.SdkBox:getInstance()
	local waitingSdkInitSuccess = self:getIsWaitingSdkInitSuccess()

	if self._sdk:getUserPlugin() then
		print("已经初始化过 !@#$")
	else
		self._sdk:init()
	end
	self._userPlugin 				= self._sdk:getUserPlugin()
	self._sharePlugin 				= self._sdk:getSharePlugin()
	self._payPlugin 				= self._sdk:getPayPlugin()
	self._pushPlugin				= self._sdk:getPushPlugin()
	self._analyticsPlugin 			= self._sdk:getAnalyticsPlugin()
	self._adsPlugin					= self._sdk:getAdsPlugin()
	self._expansionPlugin 			= self._sdk:getExpansionPlugin()
	self._screenRecordPlugin		= self._sdk:getScreenRecordPlugin()
	self._googleTranslationPlugin 	= self._sdk:getAvalonGoogleTranslate()

	print("self._googleTranslationPlugin = ", self._googleTranslationPlugin)

	if (self._userPlugin) then
		self._userPlugin:setActionListener(handler(self,self.onUserActionListener))
	end
	if(not waitingSdkInitSuccess) then
		if (self._sharePlugin) then
			self._sharePlugin:setActionListener(handler(self,self.onShareActionListener))
		end
		if (self._adsPlugin) then
			self._adsPlugin:setActionListener(handler(self,self.onLoadAdsListener), handler(self,self.onPlayAdsListener))
		end
		if (self._expansionPlugin) then
			self._expansionPlugin:setActionListener(handler(self, self.onExpansionActionListener))
		end
		if (self._pushPlugin) then
			self._pushPlugin:setActionListener(handler(self, self.onPushActionListener))
		end
		if (self._screenRecordPlugin) then
			self._screenRecordPlugin:setActionListener(handler(self, self.onScreenRecordPlugin))
		end

		if self._googleTranslationPlugin then
			self._googleTranslationPlugin:setActionListener(handler(self, self.onGoogleTranslationCallback))
		end
		if (self._payPlugin) then
			self._payPlugin:setResultListener(handler(self,self.onPayListener))
		end
		-- 设置商店预购类回调
		if (self._payPlugin) then
			if self._payPlugin.setStorePayListener then
				self._payPlugin:setStorePayListener(handler(self,self.storePayCallBack))
			end
		end
	end
	self._isInit = true;
end

-- 初始化雷霆SDK，在sdk初始化成功后
function SdkBox:initOtherSdkWaitingLTSdkInitSuccess()
	-- print(debug.traceback())
	if (self._sharePlugin) then
		self._sharePlugin:setActionListener(handler(self,self.onShareActionListener))
	end
	if (self._adsPlugin) then
		self._adsPlugin:setActionListener(handler(self,self.onLoadAdsListener), handler(self,self.onPlayAdsListener))
	end
	if (self._expansionPlugin) then
		self._expansionPlugin:setActionListener(handler(self, self.onExpansionActionListener))
	end
	if (self._pushPlugin) then
		self._pushPlugin:setActionListener(handler(self, self.onPushActionListener))
	end
	if (self._screenRecordPlugin) then
		self._screenRecordPlugin:setActionListener(handler(self, self.onScreenRecordPlugin))
	end

	if self._googleTranslationPlugin then
		self._googleTranslationPlugin:setActionListener(handler(self, self.onGoogleTranslationCallback))
	end
	if (self._payPlugin) then
		self._payPlugin:setResultListener(handler(self,self.onPayListener))
	end
	-- 设置商店预购类回调
	if (self._payPlugin) then
		if self._payPlugin.setStorePayListener then
			self._payPlugin:setStorePayListener(handler(self,self.storePayCallBack))
		end
	end
	if device.platform == "android" and self._sdk.initBuglyAfterinitSDK then
		print("self._sdk:initBuglyAfterinitSDK()")
		self._sdk:initBuglyAfterinitSDK()
		self.buglyInit = true
	end
end

function SdkBox:setStorePayListener(callback)
	self._storePayCallback = callback
end
function SdkBox:getSuccessOrderParams()
	return self._successOrder
end
function SdkBox:restoreSuccessOrderParams()
	self._successOrder = {}
end

function SdkBox:getSDKIsInit()
	return self.buglyInit
end
-- 注意!!!!!!设置回调的同时会查询补单
-- function SdkBox:delaySetPayCallback()
-- 	if (self._payPlugin) then
-- 		self._payPlugin:setResultListener(handler(self,self.onPayListener))
-- 	end
-- end

function SdkBox:initPlugin(params)
	if not self._userPlugin then
		return
	end
	self._userPlugin:initPlugin(params)
end


    -- typedef enum
    -- {
        -- kScreenRecordAuthenticationDone = 0,  /*授权成功*/
        -- kScreenRecordAuthenticationError,     /*授权失败*/
        -- kScreenRecordStartSucc,
        -- kScreenRecordStartFail,
        -- kScreenRecordingError,
        -- kScreenRecordStopSucc,
        -- kScreenRecordStopFail
    -- } ScreenRecordCallbackCode;
function SdkBox:onScreenRecordPlugin(pPlugin, code, params)
	print("屏幕录像回调", code, params)

	local errorCode = -1
	if (params.errorCode) then
		errorCode = tonumber(params.errorCode)
	end	

	if (code == 0) then
		if (self._screenRecordAuthSucc) then self._screenRecordAuthSucc() end
	elseif (code == 1) then
		if (self._screenRecordAuthFail) then self._screenRecordAuthFail(errorCode) end
	elseif (code == 2) then
		if (self._screenRecordStartSucc) then self._screenRecordStartSucc() end
	elseif (code == 3) then
		if (self._screenRecordStartFail) then self._screenRecordStartFail(errorCode) end
	elseif (code == 4) then
		if (self._screenRecordingError) then self._screenRecordingError(errorCode) end
	elseif (code == 5) then
		Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CONTROL_END)
		if (self._screenRecordSaveSucc) then self._screenRecordSaveSucc() end
	elseif (code == 6) then
		Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CONTROL_END)
		if (self._screenRecordSaveFail) then self._screenRecordSaveFail() end
	end
end

-- local LoadAdsResultCode = {
--     kInAppPushMessageClosed     	= 0,       -- 成功
-- }
function SdkBox:onPushActionListener(pPlugin, code, params)
	print("推送消息回调",code, params)
	if (code == 0 and self._onInAppMessageClosed) then
		self._onInAppMessageClosed()
	end
end

-- local LoadAdsResultCode = {
--     Done  	                 	= 0,       -- 成功
--     Error                       	= 1,       -- 失败
--	   Progress						= 2		   -- 过程中
-- }
function SdkBox:onExpansionActionListener(pPlugin, code, params)
	print("扩展包下载回调",code, params)
	
	if (code == 0 and self._expDlSuccessCallback) then
		self._expDlSuccessCallback()
	end
end

function SdkBox:onExpansionDownloadSuccess(cb)
	self._expDlSuccessCallback = cb
end

-- local LoadAdsResultCode = {
--     Success                      = 0,       -- 成功
--     Fail                         = 2,       -- 失败
-- }
function SdkBox:onLoadAdsListener(pPlugin, code, params)
	print("加载广告结果  ",code, params)
    if code == 0 then
        Avalon.MessageCenter:notice(AvalonMessage.MC_SDK_ADS_LOAD_RESULT, true)
    elseif code == 2 then
    	Avalon.MessageCenter:notice(AvalonMessage.MC_SDK_ADS_LOAD_RESULT, false)
    end
end


-- kPlayStart = 0; //开始
-- kPlayFinishEnd = 1; //自动结束
-- kPlayInterruptEnd = 2; //手动取消结束
-- kPlayFail = 3; //失败
function SdkBox:onPlayAdsListener(pPlugin, code, msg)
	print("播放广告结果  ",code, msg)
	--打开GM的 情况下 走开发者模式  有客户端发起奖励
	local SdkManager = require"app.game.SdkManager"
	
	code = checkint(code)
	local lastData = self.lastPlayAdsData or {}
	local params = {}
	params.serPlace = lastData.serPlace
    params.cfgPlace = lastData.cfgPlace
    params.adsId = lastData.codeId
    params.time = lastData.timeStamp
    if code == 10 then--开始
        -- SdkManager:getInstance():sendWebLogWithParams(PublicDefine.WebLogType.WebLogType_AdsEvent, 1, params, ADS_HTTP_REPEAT_COUNT)
        Avalon.AWSLogUtil:sendAWSAdInfo(1, params.adsId, params.cfgPlace, params.serPlace)
	elseif code == 11 then--正常完成奖励
        if (self:adsClientAward()) then
        	Net.NetRoleSystem:reqViewADSResult(lastData.serPlace, lastData.timeStamp.."") 
        end
		-- SdkManager:getInstance():sendWebLogWithParams(PublicDefine.WebLogType.WebLogType_AdsEvent, 2, params, ADS_HTTP_REPEAT_COUNT)
		Avalon.AWSLogUtil:sendAWSAdInfo(2, params.adsId, params.cfgPlace, params.serPlace)
	elseif code == 12 then--手动取消结束
  		-- SdkManager:getInstance():sendWebLogWithParams(PublicDefine.WebLogType.WebLogType_AdsEvent, 3, params, ADS_HTTP_REPEAT_COUNT)
  		Avalon.AWSLogUtil:sendAWSAdInfo(3, params.adsId, params.cfgPlace, params.serPlace)
    elseif code == 13 then--失败
        -- SdkManager:getInstance():sendWebLogWithParams(PublicDefine.WebLogType.WebLogType_AdsEvent, 4, params, ADS_HTTP_REPEAT_COUNT)
        Avalon.AWSLogUtil:sendAWSAdInfo(4, params.adsId, params.cfgPlace, params.serPlace)
    elseif code == 14 then--还未加载好
    	UI.ScrollBar:createByTextID(1112109)
	end
end
function SdkBox:storePayCallBack(pPlugin,params)
	table.insert(self._preOrderParams, params)
	if self._storePayCallback then
		self._storePayCallback(self._preOrderParams)
	end
end

function SdkBox:getPreOrderParams()
	return self._preOrderParams
end

function SdkBox:restorePreOrderParams()
	self._preOrderParams = {};
end

function SdkBox:setPreOrderParams(params)
	self._preOrderParams = params or {}
end

-- local PayResultCode = {
--     kPaySuccess                      = 0,       -- 支付成功
--     kPayFail                         = 1,       -- 支付失败
--     kPayCancel                       = 2,       -- 支付取消
--     kPayNetworkError                 = 3,       -- 网络错误
--     kPayProductionInforIncomplete    = 4,       -- 支付信息提供不完全
--     kPayInitSuccess                  = 5,       -- 初始化成功
--     kPayInitFail                     = 6,       -- 初始化失败
--     kPayNowPaying                    = 7,       -- 支付中
--     kPayRechargeSuccess              = 8,       -- 充值成功
--	   kPayRequestSkuDetailFailed 		= 9;	   -- 获取详细信息失败
--     kPayRequestSkuDetailSuccess 		= 10;	   -- 获取详细信息成功、
-- 	   kPayAlreadyPurchased             = 11;      -- 已经购买，主要适用于订阅等不能重复购买的物品
--     kPayInvalidSku                   = 12;      -- 无效的IAP
--	   kPayNotSupported                 = 13;      -- 不支持的购买
--	   kPayNotLoginMarketplace          = 14;      -- 没有登录市场
--     kPayExtension                    = 30000    -- 拓展字段
-- }
function SdkBox:onPayListener(pPlugin, code, params)
	-- 只要成功了就删除,避免多次回调
	print("支付结果  ",code, params)
	self:finishTransaction(params.transactionIdentifier or "")
	PayUtil:createTips(code,params);
	if code ==  Avalon.PayResultCode.kPaySuccess 
		or code ==  Avalon.PayResultCode.kPayRechargeSuccess
	then
		
		if self._paySuccessCallback then
			self._paySuccessCallback(params)
			for i,v in ipairs(self._successOrder) do
				self._paySuccessCallback(v)
			end
			self._successOrder = {}
		else
			table.insert(self._successOrder, params)
		end
	-- 拓展字段 一般是第三方sdk的
	elseif code ==  Avalon.PayResultCode.kPayExtension then
		if self._payFailCallback then
			self._payFailCallback(params)
		end
	elseif code ==  Avalon.PayResultCode.kPayFail 
		or code ==  Avalon.PayResultCode.kPayCancel 
		or code ==  Avalon.PayResultCode.kPayNetworkError 
		or code ==  Avalon.PayResultCode.kPayProductionInforIncomplete 
		or code ==  Avalon.PayResultCode.kPayInitFail 
		or code ==  Avalon.PayResultCode.kPayNowPaying
		or code ==  Avalon.PayResultCode.kPayNotSupported 
		or code ==  Avalon.PayResultCode.kPayInvalidSku
		or code ==  Avalon.PayResultCode.kPayAlreadyPurchased
		or code ==  Avalon.PayResultCode.kPayNotLoginMarketplace
		then 
		if self._payFailCallback then
			self._payFailCallback(params)
		end
	elseif code == Avalon.PayResultCode.kPayRequestSkuDetailFailed or code == Avalon.PayResultCode.kPayRequestSkuDetailSuccess then
		if (self._payCurrencyCodeCallback) then
			self._payCurrencyCodeCallback(code == Avalon.PayResultCode.kPayRequestSkuDetailSuccess and true or false, params)
		end
	elseif code == Avalon.PayResultCode.kPayCertificateNTFSuccess then
		--todo 如果登录成功 向服务器发送生成订单请求， 清除object_c缓存

	end
end
function SdkBox:onShareActionListener(pPlugin, code, msg)
	print("分享插件操作返回 code, msg",code, msg)
	UI.WaitingLayer:hideWaiting()

	Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
		if code == Avalon.ShareActionResultCode.kShareFail then
			-- UI.ScrollBar:createByText(UI.TEXT_111145)
			------ facebook分享功能有问题，暂时点击分享按钮即视为分享任务完成
			if self._sharePlatform and self._sharePlatform == PublicDefine.SHARE_CHANNEL.SHARE_CHANNEL_FB then
				Avalon.MessageCenter:notice(AvalonMessage.MC_SDK_SHARE_SUCCESS)
				Net.NetRoleSystem.netShare(self._sharePlatform)
			end
			------
		elseif code == Avalon.ShareActionResultCode.kShareCancel then 
			-- UI.ScrollBar:createByText(UI.TEXT_111149)
		elseif code == Avalon.ShareActionResultCode.kShareNeedThridAppInstalled then 
			UI.ScrollBar:createByText(UI.TEXT_111147)
		elseif code == Avalon.ShareActionResultCode.kShareNeedThridLogin then 
			UI.ScrollBar:createByText(UI.TEXT_111148)
		elseif code == Avalon.ShareActionResultCode.kShareSuccess then
			-- UI.ScrollBar:createByText(UI.TEXT_111144)
			Avalon.MessageCenter:notice(AvalonMessage.MC_SDK_SHARE_SUCCESS)
			if self._sharePlatform ~= nil then
				Net.NetRoleSystem.netShare(self._sharePlatform)
			end
		end
	end, 1)
end

function SdkBox:onUserActionListener(pPlugin, code, params)
	-- print("用户插件操作返回 code",code, params)
	-- dump(params)
	-- params.host = "192.168.1.101"
	-- params.port = 10002
	if code == Avalon.UserActionResultCode.kLoginSuccess then
		-- print("登录成功   账号 ",params)
		self:saveUserDataLoginType(self:getVersionAccount())
		if self._loginSuccessCallback then
			self._loginSuccessCallback(params)
		end
	elseif code == Avalon.UserActionResultCode.kLogoutSuccess then
		-- 存入本地
		print("登出成功")
		self:saveUserDataLoginType(0)
		local gameLoginManager = require("app.game.GameLoginManager")
		-- dump(gameLoginManager:getInstance())
		if self._logoutSuccessCallback then
			self._logoutSuccessCallback(params)
		end
		if (self._isToLogoutGameWhenSDKLogout) then
			gameLoginManager:getInstance():loginOutGame()
		end
	elseif code == Avalon.UserActionResultCode.kLogoutFail then
		if self._logoutFailCallback then
			self._logoutFailCallback(params)
		end
	elseif code == Avalon.UserActionResultCode.kLoginFail  then
        UI.ScrollBar:createByText(UI.TEXT_111143)
        if self._loginFailCallback then
			self._loginFailCallback(code,params)
		end
    elseif code == Avalon.UserActionResultCode.kLoginNetworkError then
        UI.ScrollBar:createByText(UI.TEXT_111142)
        if self._loginFailCallback then
			self._loginFailCallback(code,params)
		end
    elseif code == Avalon.UserActionResultCode.kLoginNoNeed then
    	if self._loginFailCallback then
			self._loginFailCallback(code,params)
		end
    elseif code == Avalon.UserActionResultCode.kLoginNeedThridAppInstalled then
        UI.ScrollBar:createByText(UI.TEXT_111147)
        if self._loginFailCallback then
			self._loginFailCallback(code,params)
		end
    elseif code == Avalon.UserActionResultCode.kLoginCancel then
    	UI.ScrollBar:createByText(UI.TEXT_111150)
    	if self._loginFailCallback then
			self._loginFailCallback(code,params)
		end
	-- 初始化失败的异常在业务逻辑处理(照顾gamecenter)
    elseif code == Avalon.UserActionResultCode.kInitFail then
    	print("-----Avalon.UserActionResultCode.kInitFail")
        if self._loginFailCallback then
			self._loginFailCallback(code,params)
		elseif (CAVEOL_TARGET_CN == CAVEOL_TARGET or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) and device.platform == "android" then
			Game.Manager:enterSplash()
		end
	elseif code == Avalon.UserActionResultCode.kInitSuccess then
		print("-----Avalon.UserActionResultCode.kInitSuccess")

		if(self:getIsWaitingSdkInitSuccess()) then
			-- print("-----Avalon.UserActionResultCode.kInitSuccess 1")
			-- 计时器
			require "utils.Scheduler"
			Avalon.Scheduler:init()
			Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
				-- print("-----Avalon.UserActionResultCode.kInitSuccess 2.")
				self:initOtherSdkWaitingLTSdkInitSuccess()
				if (CAVEOL_TARGET_CN == CAVEOL_TARGET or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) and device.platform == "android" then
					Game.Manager:enterSplash()
				end
			end, 0.1)
		else 
			if (CAVEOL_TARGET_CN == CAVEOL_TARGET or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) and device.platform == "android" then
				Game.Manager:enterSplash()
			end
		end
	elseif code == Avalon.UserActionResultCode.kExitPage then
		if CAVEOL_TARGET_CN == CAVEOL_TARGET or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE then
			print("------code-----", code)
			-- 这里没有修改为统一的退出代码，如果添加可能形成死循环
			cc.Director:getInstance():endToLua()
	        os.exit()
	    end
	end
	self:setUserActionAvailable(true)
end
-- 获取子渠道
function SdkBox:getSubChannel()
	local subChannel = 0
	if self._userPlugin then
		subChannel = self._userPlugin:getSubChannel()
	end
	if subChannel == 0 then
        if CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE then
            if (device.platform == "ios") then
                subChannel = 210009
            elseif(device.platform == "android") then
                subChannel = 110001
            end
        end
	end
	return subChannel;
end

function SdkBox:getOAID()
	local oaid = ""
	-- print("SdkBox:getOAID 222", oaid)
	if self._userPlugin and self._userPlugin.getOAID then
		oaid = self._userPlugin:getOAID()
		-- print("SdkBox:getOAID", oaid)
	end

	return oaid;
end

-- 是否支持合并支付
function SdkBox:isSupportMergePay()
	if device.platform == "mac" then
		return false
	end
	if self._payPlugin then
		return self._payPlugin:isSupportMergePay()
	end
	return false
end

-- 是否支持订阅（这里通过是否实现了某个接口来判断是否支持订阅处理逻辑）
function SdkBox:isSupportSubscribe()
	if self._payPlugin and self._payPlugin.requestIAPInfoData then
		local channel = SdkBox:getInstance():getVersionChannel()
        channel = checkint(channel)
		-- print("isSupportSubscribe  channel=", channel,  PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_GOOGLEPLAY)
        if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL and
			(channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_GOOGLEPLAY
			or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE) then
			-- print("isSupportSubscribe  true")
            return true
        end
	end

	if (device.platform == "mac" or device.platform == "windows") then 
		return true
	end

	return false
end

-- 获取账号渠道编号 360登陆 qq登陆 等等
function SdkBox:getVersionAccount()
	return self._sdk:getVersionAccount()
end
-- 服务器编号
function SdkBox:getVersionZone()
	return self._sdk:getVersionZone()
end
--渠道编号 渠道编号(决定客户端)苹果商店 GOOGLEPLAY等等
function SdkBox:getVersionChannel()
	return self._sdk:getVersionChannel()
end
-- 版本编号 VERSION_TARGET_GLOBAL VERSION_TARGET_CN
function SdkBox:getVersionTarget()
	return self._sdk:getVersionTarget()
end
-- 平台编号 android ios
function SdkBox:getVersionPlatform()
	return self._sdk:getVersionPlatform()
end
function SdkBox:postInitWithTransactionListener(callback)
	assert(self._payPlugin ~= nil,"self._payPlugin can not be nil")
	self._payPlugin:postInitWithTransactionListener(callback)
end
-- 加载iap商品信息
--[[
	productsIds iap ID列表
	callback(params)
		-- 无效的ID
		invalidProductsId = {
			
		},
		-- 有效的
		products = {
			productIdentifier = "",
			localizedTitle = "",
			localizedDescription = "",
			priceLocale = "",
			price = "",
		},
]]
function SdkBox:loadProducts(productsIds,callback)
	assert(self._payPlugin ~= nil,"self._payPlugin can not be nil")
	productsIds = productsIds or {}
	self._payPlugin:loadProducts(productsIds,callback)

	self:restore()
end
-- 发起支付 参数都为string 除非特别说明,参数都传,而且不要为nil
--[[
	orderId 		我们自己的订单ID
	productId 		商品ID 某些sdk可能需要。不需要的就传0
	productName 	详细的商品名字 类似 10元宝
	productPrice 	商品价格 现金单位 分
	productCount 	购买数量 一般都为0 但是可能涉及到特殊需求,比如礼包
	productDes 		商品的介绍,都加上,因为有些SDK会展示
	diamond 		购买后得到的钻石
	unitName 		单位名字  比如 元宝  礼包
	unitRate  		单位的兑换比例 比如10元宝一现金单位
	roleId 			角色ID
	roleName 		角色名字
	roleLevel 		角色等级
	vipLevel 		vip等级
	balance 		余额
	guildName 		公会名字
	zoneId 			服务器ID
	zoneName 		服务器名字
	notifyUri 		充值成功之后的验证地址
	ext 			拓展字段(非常有用,一般用来传我们自己的参数,比如我们自己订单号,
					一般的sdk回调到服务器会原封不动带上这参数)
]]
function SdkBox:purchase(params)
	assert(self._payPlugin ~= nil,"self._payPlugin can not be nil")
	dump(params,"支付参数")
	self._payPlugin:purchase(params)
end

function SdkBox:restore()
	assert(self._payPlugin ~= nil,"self._payPlugin can not be nil")
	-- dump(params,"支付参数")
	if(LOG_PAY_FLAG) then 
		print("PAY: restore ")
	end
	self._payPlugin:restore()
end

function SdkBox:finishTransaction(transactionIdentifier)
	assert(self._payPlugin ~= nil,"self._payPlugin can not be nil")
	-- dump(params,"支付参数")
	if(LOG_PAY_FLAG) then 
		print("PAY: finishTransaction data=", transactionIdentifier)
	end
	self._payPlugin:finishTransaction(transactionIdentifier)
end

function SdkBox:getCompletionInfoForIAPID(iapID)
	assert(self._payPlugin ~= nil,"self._payPlugin can not be nil")
	-- dump(params,"支付参数")
	if(LOG_PAY_FLAG) then 
		print("PAY: getCompletionInfoForIAPID data=", iapID)
	end
	if(self._payPlugin and self._payPlugin.getCompletionInfoForIAPID) then
		return self._payPlugin:getCompletionInfoForIAPID(iapID)
	end

	return ""
end

--[[
	（支持订阅的接口，老版接口getPriceLocationCode）
	用于请求IAP商品详细信息，
]]
function SdkBox:requestIAPInfoData(jsonParams)
	assert(self._payPlugin ~= nil,"self._payPlugin can not be nil")
	if (self._payPlugin and self._payPlugin.requestIAPInfoData) then
		self._payPlugin:requestIAPInfoData(jsonParams)
	end
end

--[[
	productId 		商品ID
]]
function SdkBox:getPriceLocationCode(params)
	assert(self._payPlugin ~= nil,"self._payPlugin can not be nil")
	if (self._payPlugin.getPriceLocationCode) then
		self._payPlugin:getPriceLocationCode(params)
	end
end

-- 参数params类型为table 尽量不要为nil,就算用不到也要传空字符
-- channel  sdk枚举在PublicDefine
-- type 	类型 文字 图片... 枚举在SdkBoxConst
-- stype    二级类型 可能第某些sdk会用到 目前只有微信需要这个参数 枚举在SdkBoxConst
-- content  文字内容
-- link 	链接
-- title 	标题
-- image 	图片路径
-- thumb 	缩略图片路径
--[[
	
]]
function SdkBox:share(params)
	-- assert(self._sharePlugin ~= nil,"self._sharePlugin can not be nil")
	if self._sharePlugin then
		UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
	    self._sharePlatform = params.channel
	    self._sharePlugin:share(params)
	    local SCH = PublicDefine.SHARE_CHANNEL
    	if (device.platform == "android") and (params.channel == SCH.SHARE_CHANNEL_WX or params.channel == SCH.SHARE_CHANNEL_WX_SESSION 
	    	or params.channel == SCH.SHARE_CHANNEL_QQ or params.channel == SCH.SHARE_CHANNEL_QQ_SESSION) then
			Net.NetRoleSystem.netShare(params.channel)
		end
	end
end

function SdkBox:login()
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	self._userPlugin:login()
end

function SdkBox:isUserActionAvailable()
	return self._isUserActionAvailable
end

function SdkBox:setUserActionAvailable(b)
	self._isUserActionAvailable = b
end
-- 查询实名状态:已弃用
function SdkBox:queryAntiAddiction()
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	if self.antiAddictionStatus == nil then
		self.antiAddictionStatus = self._userPlugin:queryAntiAddiction()
	end
	return self.antiAddictionStatus
	
end
-- 查询SDK游客状态
function SdkBox:isGuest()
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	if self._userPlugin.isGuest == nil then
		return false
	end
	return self._userPlugin:isGuest()
end
-- 调起实名认证
function SdkBox:realNameRegister()
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	self._userPlugin:realNameRegister()
	print("发起实名认证")
end
-- 登录 参数params类型为table 目前使用到的参数如下 后续根据sdk额外需求拓展
-- channel 参数枚举在PublicDefine
-- 
function SdkBox:loginCustom(params)
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	if (self:isUserActionAvailable() == false) then return end
	self:setUserActionAvailable(false)
	self._userPlugin:loginCustom(params)
end
-- 注销
function SdkBox:logout(isNoCallback, isResetToGuest)
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	if (isNoCallback == nil) then isNoCallback = false end
	if (isResetToGuest == nil) then isResetToGuest = false end
	self._userPlugin:logout(isNoCallback, isResetToGuest)
end

function SdkBox:exit()
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	self._userPlugin:exit()
end

function SdkBox:getExitGameState()
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	if self._userPlugin == nil or self._userPlugin.getExitGameState == nil then
		return 1
	else
		return self._userPlugin:getExitGameState()
	end
end

--sdk是否支持隐私协议
function SdkBox:isSupportPrivacy()
	if self._userPlugin == nil or self._userPlugin.isSupportPrivacy == nil then
		return false
	else
		return self._userPlugin:isSupportPrivacy()
	end
end

function SdkBox:showSdkPrivacy()
	if self._userPlugin == nil or self._userPlugin.showSdkPrivacy == nil then
		return false
	else
		self._userPlugin:showSdkPrivacy()
		return true
	end
end

--sdk是否支持用户协议
function SdkBox:isSupportLicense()
	if self._userPlugin == nil or self._userPlugin.isSupportLicense == nil then
		return false
	else
		return self._userPlugin:isSupportLicense()
	end
end

function SdkBox:showSdkLicense()
	if self._userPlugin == nil or self._userPlugin.showSdkLicense == nil then
		return false
	else
		self._userPlugin:showSdkLicense()
		return true
	end
end

--sdk是否支持个人信息收集清单
function SdkBox:isSupportPrivacyCollection()
	if self._userPlugin == nil or self._userPlugin.isSupportPrivacyCollection == nil then
		return false
	else
		return self._userPlugin:isSupportPrivacyCollection()
	end
end

function SdkBox:showSdkPrivacyCollection()
	if self._userPlugin == nil or self._userPlugin.showSdkPrivacyCollection == nil then
		return false
	else
		self._userPlugin:showSdkPrivacyCollection()
		return true
	end
end

--sdk是否支持第三方SDK收集信息清单
function SdkBox:isSupportThirdpartyCollection()
	if self._userPlugin == nil or self._userPlugin.isSupportThirdpartyCollection == nil then
		return false
	else
		return self._userPlugin:isSupportThirdpartyCollection()
	end
end

function SdkBox:showSdkThirdpartyCollection()
	if self._userPlugin == nil or self._userPlugin.showSdkThirdpartyCollection == nil then
		return false
	else
		self._userPlugin:showSdkThirdpartyCollection()
		return true
	end
end

--[[
	角色数据上报,很多sdk都要求必须实现此接口 分别在创建角色,登入角色,和角色信息变动的时候调用
	具体参数是个table 从游戏层传过去都是写死的参数名,在sdk实现层 再根据实际需求的参数名来修改
	比如某个平台,要求上传创建角色信息,但是代表角色唯一标示符的参数名叫playerId 这个就需要自己
	在实现sdk相关接口的时候处理

	type 		    上传类型 定义在 SubmitExtraDataType
	roleId 		    角色id
	roleName 	    角色名字
	roleLevel 	    角色等级
	vipLevel 		vip等级
	zoneId 			服务器ID
	zoneName 		服务器名字
	roleCTime 		角色创建时间
	roleLevelMTime  角色信息变动时间(比如等级)
	guildId 		公会ID
	guildName 		公会名字
	coin 			当前金币数量
	diamond 		当前钻石数量

	参数都是string格式 而且type必须不能为空
]]

function SdkBox:submitExtraData(params)
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	self._userPlugin:submitExtraData(params)
end
-- 显示账号中心
function SdkBox:showAccountCenter()
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	self._userPlugin:showAccountCenter()
end
-- 显示客服电话(根据实际需求有可能会有渠道有这个需求)
function SdkBox:showHelpPage()
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	self._userPlugin:showHelpPage()
end
-- 显示客服专区(根据实际需求有可能会有渠道有这个需求)
--[[ 
	参数列表(尽量都传)
	roleId 		    角色id
	roleName 	    角色名字
	roleLevel 	    角色等级
	zoneId 			服务器ID
	zoneName 		服务器名字
]]
function SdkBox:helper(params)
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")

	if(CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL ) then
		if not AvalonUtil.isClientPackageVersionEqualOrGreaterThan(AI_HELP_ADD_VERSION) then
			local SdkManager = require"app.game.SdkManager"
	        SdkManager:getInstance():openCSWeb()
	        return
		end
		if (params.roleName) then--规避c_str报错crash问题
		    if AvalonUtil:isUpLimiteStr(params.roleName, 80, 18) then
				params.roleName = AvalonUtil:getSubNameStrByLabel(params.roleName, 80, 18)
		    end
		end
		local num = MasterDataManager:getPayMoneyCount() or 0
		if num > 0 then
			params.payMoney = num
		end
	end

	self._userPlugin:helper(params)
end


function SdkBox:showWebView(params)
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	if self._userPlugin.showWebView then
	    self._userPlugin:showWebView(params)
	end
end

function SdkBox:isHaveShowWebViewAPI()
    if self._userPlugin == nil or self._userPlugin.showWebView == nil then
        return false
    end
    return true
end

--[[
	异步生成一个图片保存在本地,并且在回调返回它的绝对路径
	node 要截图的那个节点
	name 保存的图片名字
	callback(path) 回调
]]
function SdkBox:createImage(node,name,callback)
	local callfunc = function (path)
	    -- print("-----callback path = "..path)
		if callback then
			callback(path)
		end
	end
	local screenFileName = cc.UserDefault:getInstance():getStringForKey("ScreenFileName", "")
    if screenFileName ~= "" then
    	local path = cc.FileUtils:getInstance():getWritablePath()..screenFileName
        cc.FileUtils:getInstance():removeFile(path)
    end
    name = AvalonUtil.getCurrentTime()..name
    cc.UserDefault:getInstance():setStringForKey("ScreenFileName", name)
    self._sdk:createImage(node,name,callfunc)
end

function SdkBox:getSupportLanguages()
	local versionTarget = SdkBox:getInstance():getVersionTarget()		
	if versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN 
	or versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE then
        return {cc.LANGUAGE_CHINESE}
	else
		return {cc.LANGUAGE_ENGLISH, cc.LANGUAGE_CHINESE, cc.LANGUAGE_CHINESE_TRADITIONAL, 
				cc.LANGUAGE_KOREAN, cc.LANGUAGE_RUSSIAN, cc.LANGUAGE_THAI}
	end
end

function SdkBox:createQRSprite(str)
	
	local sprite = self._sdk:createQRSprite(str)
	return sprite
end
-- 获取支持的登录sdk
function SdkBox:getSupportLoginSdks()
	if self._userPlugin ~= nil then
		local channel = SdkBox:getInstance():getVersionChannel()
		channel = checkint(channel)
		-- add by zp 这里由于屏蔽了catappult渠道的google登录
		if(channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_CATAPPULT) then 
			return {PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_GUEST, PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_FB}
		else
			return self._userPlugin:getSupportSdks();
		end
	end
	return {}
end

--[[
global
    ios：     fb、wx朋友圈
    android： fb、tw、wx朋友圈、微信好友

CN 
    ios：     wx好友、wx朋友圈、qq空间、新浪web
    android： wx好友、wx朋友圈、qq好友、qq空间、新浪web

    //分享相关的渠道标识
typedef enum  {
    SHARE_CHANNEL_FB = 1,//FACEBOOK
    SHARE_CHANNEL_WX = 2,//微信朋友圈
    SHARE_CHANNEL_WX_SESSION = 3, //微信会话
    SHARE_CHANNEL_QQ = 4,//QQ空间
    SHARE_CHANNEL_QQ_SESSION = 5,//QQ聊天窗口
    SHARE_CHANNEL_TWITTER = 6,//推特
    SHARE_CHANNEL_WEIBO = 7, // 微博    
} SHARE_CHANNEL;
]]
-- 获取支持的分享sdk
function SdkBox:getSupportShareSdks()
	   -- 如果是国内CN 子渠道,不显示(暂时只有雷霆官方渠道显示)
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    local channel = SdkBox:getInstance():getVersionChannel()
    channel = checkint(channel)
    if (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE ) then
        if channel ~= PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING 
        and channel ~= PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE 
        and channel ~= PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_BILIBILI 
		and channel ~= PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_QUICK 
        then
	       return {}
        end
    end

	local SCH = PublicDefine.SHARE_CHANNEL
	if ServerConfigUtil:isInReview() then
	    return {}
	end
	--方便测试
	local deviceTarget = cc.Application:getInstance():getTargetPlatform()
    if deviceTarget == cc.PLATFORM_OS_WINDOWS or deviceTarget == cc.PLATFORM_OS_MAC then
        return {1,2,3,4,5,6,7} --all
    end
    --产品包 (临时处理, FB分享屏蔽掉)
    local target = self:getVersionTarget()
    local platform = self:getVersionPlatform()
    if target == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
		if platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID then
			if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_AMAZON
				or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_ONESTORE
				or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_HUAWEI_GLOBAL then 
				return {SCH.SHARE_CHANNEL_FB}
			else
				return {SCH.SHARE_CHANNEL_FB, SCH.SHARE_CHANNEL_TWITTER, SCH.SHARE_CHANNEL_WX, SCH.SHARE_CHANNEL_WX_SESSION}
			end
    	elseif platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS then
            return {SCH.SHARE_CHANNEL_FB, SCH.SHARE_CHANNEL_WX, SCH.SHARE_CHANNEL_WX_SESSION, SCH.SHARE_CHANNEL_TWITTER}
    	end
    elseif target == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or target == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE then
        if platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID then
            return {SCH.SHARE_CHANNEL_QQ, SCH.SHARE_CHANNEL_QQ_SESSION, SCH.SHARE_CHANNEL_WEIBO, SCH.SHARE_CHANNEL_WX, SCH.SHARE_CHANNEL_WX_SESSION}
    	elseif platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS then
            return {SCH.SHARE_CHANNEL_QQ_SESSION, SCH.SHARE_CHANNEL_WEIBO, SCH.SHARE_CHANNEL_WX, SCH.SHARE_CHANNEL_WX_SESSION}
    	end
    end
	return {}
end

function SdkBox:isCanOpenReview()
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	return self._userPlugin:isCanOpenReview()
end

function SdkBox:requestReview()
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	return self._userPlugin:requestReview()
end

--优先跳转商店app，其次跳转url
--url  跳转网页地址， storePackageName 跳转商店包名（只有android 有意义）
function SdkBox:jumpToAppStore(url, storePackageName)
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	return self._userPlugin:jumpToAppStore(url, storePackageName)
end

function SdkBox:jumpToAppStoreByGameName(url, storePackageName, gameName)
	assert(self._userPlugin ~= nil,"self._userPlugin can not be nil")
	if self._userPlugin.jumpToAppStoreByGameName then
		self._userPlugin:jumpToAppStoreByGameName(url, storePackageName, gameName)
	end
end


function SdkBox:notificationAuthentication()
	if (self._pushPlugin == nil) then print("self._userPlugin does not exist, do nothing") return end
	self._pushPlugin:notificationAuthentication()
end


-- 添加一个推送, 延迟时间秒为单位
function SdkBox:addLocalNotification(title, content, delay, key)
	if (self._pushPlugin == nil) then print("self._userPlugin does not exist, do nothing") return end
	assert(type(title) == "string")
	assert(type(content) == "string")
	assert(type(delay) == "number")
	assert(type(key) == "number")

	local params = {}
	params.title = title
	params.content = content
	params.delay = math.floor(delay)
	params.key = key
	self._pushPlugin:addLocalNotification(params)
end

-- 移除一个等待中的推送
function SdkBox:removeLocalNotification(key)
	if (self._pushPlugin == nil) then print("self._userPlugin does not exist, do nothing") return end
	assert(type(key) == "number")
	local params = {}
	params.key = key
	self._pushPlugin:removeLocalNotification(params)
end

-- 移除所有等待中的推送
function SdkBox:removeAllLocalNotifications()
	if (self._pushPlugin == nil) then print("self._userPlugin does not exist, do nothing") return end
	self._pushPlugin:removeAllLocalNotifications()
end

-- 调用应用显示应用内消息
function SdkBox:showInAppPushMessage(label)
	if (self._pushPlugin == nil) then print("self._userPlugin does not exist, do nothing") return end
	self._pushPlugin:showInAppPushMessage(label)
end

-- 检查扩展包是否存在
function SdkBox:checkLocalExpansionExists()
	if (self._expansionPlugin == nil) then 
		print("self._expansionPlugin does not exist, do nothing") 
		if(self:getIsWaitingSdkInitSuccess()) then 
			return true
		end
		return false
	end
	return self._expansionPlugin:checkLocalExpansionExists()
end

-- 开始下载扩展包
function SdkBox:downloadExpansion()
	if (self._expansionPlugin == nil) then print("self._expansionPlugin does not exist, do nothing") return end
	self._expansionPlugin:downloadExpansion()
end
------------------------------------------------数据统计相关接口------------------------------------------------
-- 开始关卡调用
function SdkBox:startLevel(level)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:startLevel(tostring(level))
end

-- 关卡挑战失败调用
function SdkBox:failLevel(level,reason)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:failLevel(tostring(level),tostring(reason))
end

-- 完成关卡调用
function SdkBox:finishLevel(level)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:finishLevel(tostring(level))
end



-- 任务开始
function SdkBox:startTask(task,type)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:startTask(tostring(task),tostring(type))
end
-- 任务失败
function SdkBox:failTask(level,reason)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:failTask(tostring(level),tostring(reason))
end
-- 完成任务
function SdkBox:finishTask(level)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:finishTask(tostring(level))
end


-- 充值之后调用
function SdkBox:pay(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:pay(params)
end
-- 游戏中所有虚拟消费，比如用金币购买某个道具都使用 buy 方法
function SdkBox:buy(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:buy(params)
end
-- 消耗物品的时候，调用
function SdkBox:use(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:use(params)
end
-- //额外获取虚拟币时
function SdkBox:bonus(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:bonus(params)
end



--第一次打开游戏
function SdkBox:activity(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:activity(params)
end
-- 创建账号
function SdkBox:createAccountreport(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:createAccount(params)
end
-- 创建角色
function SdkBox:createRolereport(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:createRole(params)
end
--登陆
function SdkBox:loginreport(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:login(params)
end
--创建角色
function SdkBox:logoutreport(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:logout(params)
end
--升级
function SdkBox:levelup(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	self._analyticsPlugin:levelup(params)
end

--完成新手洞窟引导 出洞
function SdkBox:finishCaveGuild(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
    --由于兼容热更， 做接口判断
    if self._analyticsPlugin.finishCaveGuild then
	    self._analyticsPlugin:finishCaveGuild(params)
	end
end

--进入普通模式商店层
function SdkBox:EnterNormalShopCave(params)
	if (self._analyticsPlugin == nil) then print("self._analyticsPlugin does not exist, do nothing") return end
	--由于兼容热更， 做接口判断
    if self._analyticsPlugin.EnterNormalShopCave then
	    self._analyticsPlugin:EnterNormalShopCave(params)
	end
end
function SdkBox:uploadNetDelayInfo(params)
	if (self._analyticsPlugin == nil) then print("uploadNetDelayInfo:self._analyticsPlugin does not exist, do nothing") return end
	--由于兼容热更， 做接口判断
	print("uploadNetDelayInfo",self._analyticsPlugin.uploadNetDelayInfo)
    if self._analyticsPlugin.uploadNetDelayInfo then
	    self._analyticsPlugin:uploadNetDelayInfo(params)
	end
end
--加载广告
function SdkBox:loadAds(params)
	if (self._adsPlugin == nil) then print("self._adsPlugin does not exist, do nothing") return end
	if self._adsPlugin.getAdsVersion and self._adsPlugin:getAdsVersion() > 0 then
	    self._adsPlugin:loadAds(params)
	else
        print(" not have new API at c++")
	end
end

function SdkBox:getAdsVersion()
    if (self._adsPlugin == nil) then return 0 end
    if self._adsPlugin.getAdsVersion == nil then return 0 end
    return self._adsPlugin:getAdsVersion()
end

--[[
	是否允许客户端发奖
]]
function SdkBox:adsClientAward()
	local versionTarget = SdkBox:getInstance():getVersionTarget()
	if ( versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL) then
		return true 
	elseif( versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN 
		and self:getVersionPlatform() == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS
		and self:getAdsSDKType() == AdsSDKType.AdsTOPON) then 
		return true
	end

	return false
end



--播放广告
function SdkBox:playAds(params)
	if (self._adsPlugin == nil) then print("self._adsPlugin does not exist, do nothing") return end
	if self._adsPlugin.getAdsVersion and self._adsPlugin:getAdsVersion() > 0 then
		self.lastPlayAdsData = params
		print("--------playAds------", params)
	    self._adsPlugin:playAds(params)
	else
        print(" not have new API at c++")
	end
end

--[[
	获取广告SDK类型,返回值为枚举值，和 AvalonADS.AdsSDKType 枚举一致
]]
function SdkBox:getAdsSDKType()
	if (self._adsPlugin.getAdsSDKType) then
		return self._adsPlugin:getAdsSDKType()
	end

	return AdsSDKType.AdsNormal
end

function SdkBox:screenRecordIsAvailable()
	if (self._screenRecordPlugin == nil) then print("self._screenRecordPlugin does not exist, do nothing") return end
	return self._screenRecordPlugin:isAvailable()
end

function SdkBox:screenRecordAuthenticate(succCb, failCb)
	if (self._screenRecordPlugin == nil) then print("self._screenRecordPlugin does not exist, do nothing") return end
	self._screenRecordAuthSucc = succCb
	self._screenRecordAuthFail = failCb
	self._screenRecordPlugin:authenticate()
end

function SdkBox:screenRecordStart(succCb, failCb, ingError)
	if (self._screenRecordPlugin == nil) then print("self._screenRecordPlugin does not exist, do nothing") return end
	self._screenRecordStartSucc = succCb
	self._screenRecordStartFail	= failCb
	self._screenRecordingError = ingError
	self._screenRecordPlugin:startRecording()
end

function SdkBox:screenRecordEnd(isToDiscard, succCB, failCB)
	if (self._screenRecordPlugin == nil) then print("self._screenRecordPlugin does not exist, do nothing") return end
	self._screenRecordSaveSucc = succCB
	self._screenRecordSaveFail = failCB
	self._screenRecordPlugin:stopRecording(isToDiscard)
end

----------------------------帮助方法----------------------------
function SdkBox:saveUserDataLoginType(loginType)
	printInfo("SdkBox:saveUserDataLoginType 保存已登录SDK", loginType)
	local uuid = AvalonUtil.getIdentifier()
	local gameData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, uuid)
	if (gameData) then gameData:setLoginType(loginType) end
    Avalon.UserDataManager:writeUserData(uuid, gameData);
end

function SdkBox:readUserDataLoginType()
	local gameData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
    local loginType = 0
    if(gameData) then
    	loginType = tonumber(gameData:getLoginType())
    end
    local ret = (loginType == nil or loginType < 0) and 0 or loginType
    printInfo("SdkBox:readUserDataLoginType 读取已登录SDK", ret)
    return ret
end

---------------------------------------google translation API start ---------------------------------------------

-- 获取插件
function SdkBox:getGoogleTranslationPlugin()
	return self._googleTranslationPlugin;
end

function SdkBox:isSupportTranslationFunction()
	local support = true;
	local versionTarget = self:getVersionTarget()
	if versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN 
	or versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE
	then
		support = false
	end
    return support;
end

-- 设置回调
function SdkBox:setGoogleTranslationActionListener(func)
	self.translationCallback = func
end

-- initGoogleTranslation
function SdkBox:initGoogleTranslation(languageType)
	if languageType == cc.LANGUAGE_ENGLISH then
		self.currentGoogleTranslationLanguage = "en"
	elseif languageType == cc.LANGUAGE_CHINESE then
		self.currentGoogleTranslationLanguage = "zh-CN"
	elseif languageType == cc.LANGUAGE_FRENCH then
		self.currentGoogleTranslationLanguage = "fr"
	elseif languageType == cc.LANGUAGE_ITALIAN then
		self.currentGoogleTranslationLanguage = "it"
	elseif languageType == cc.LANGUAGE_GERMAN then
		self.currentGoogleTranslationLanguage = "de"
	elseif languageType == cc.LANGUAGE_SPANISH then
		self.currentGoogleTranslationLanguage = "es"
	elseif languageType == cc.LANGUAGE_RUSSIAN then
		self.currentGoogleTranslationLanguage = "ru"
	elseif languageType == cc.LANGUAGE_KOREAN then
		self.currentGoogleTranslationLanguage = "ko"
	elseif languageType == cc.LANGUAGE_JAPANESE then
		self.currentGoogleTranslationLanguage = "ja"
	elseif languageType == cc.LANGUAGE_HUNGARIAN then
		self.currentGoogleTranslationLanguage = "hu"
	elseif languageType == cc.LANGUAGE_PORTUGUESE then
		self.currentGoogleTranslationLanguage = "pt"
	elseif languageType == cc.LANGUAGE_ARABIC then
		self.currentGoogleTranslationLanguage = "ar"
	elseif languageType == cc.LANGUAGE_CHINESE_TRADITIONAL then
		self.currentGoogleTranslationLanguage = "zh-TW"
	elseif languageType == cc.LANGUAGE_THAI then
		self.currentGoogleTranslationLanguage = "th"
	else
		self.currentGoogleTranslationLanguage = "en"
	end

	if(CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL ) and self._userPlugin then
		if not AvalonUtil.isClientPackageVersionEqualOrGreaterThan(AI_HELP_ADD_VERSION_2) then
	        return
		end

		local params = {}
		params.lang = self.currentGoogleTranslationLanguage
		if languageType == cc.LANGUAGE_CHINESE then
			params.lang = "zh_CN"
		elseif languageType == cc.LANGUAGE_CHINESE_TRADITIONAL then
			params.lang = "zh_TW"
		end
		self._userPlugin:helper(params)
	end

end

-- 检测语言
function SdkBox:detectLanguage(commandId, text)
	print("detectLanguage")
	if self._googleTranslationPlugin and (commandId == INIT_GOOGLE_TRANSLATE_COMMAND_ID or  (self:isSupportTranslationFunction() and self.translationCallback ~= nil)) then
		local requestStr = string.gsub(text, " ", "+")
		self._googleTranslationPlugin:detectLanguage(commandId, requestStr)
	end
end

function SdkBox:getGoogleTranslationSupportLanguage(commandId, language)
	if self._googleTranslationPlugin and self:isSupportTranslationFunction() and self.translationCallback ~= nil then
		if language == nil then
			language = self.currentGoogleTranslationLanguage
		end
		self._googleTranslationPlugin:getSupportedLanguages(commandId, language)
	end
end

function SdkBox:translate(commandId, textVale, targetLanguage)
	if self._googleTranslationPlugin and  self:isSupportTranslationFunction() and self.translationCallback ~= nil then
		if targetLanguage == nil then
			targetLanguage = self.currentGoogleTranslationLanguage
		end

		local requestTable = {}
		if type(textVale) == "table" then
			for k, v in pairs(textVale) do
				local requestStr = string.gsub(v, " ", "+")
				requestTable[k] = requestStr;
			end
		else
			local requestStr = string.gsub(textVale, " ", "+")
			table.insert(requestTable, requestStr);
		end
		self._googleTranslationPlugin:translate(commandId, requestTable, targetLanguage)
	end
end

function SdkBox:onGoogleTranslationCallback(eventType, commandId, data, url)
	if data == nil or data == "" then
		return
	end
	--print("onGoogleTranslationCallback", eventType, commandId, data)
	local jsonObject = nil
	AvalonUtil.TryCatch(
		function()
			jsonObject = json.decode(data)
		end, 
		function (e)
			if self.translationCallback then
				self.translationCallback(GOOGLE_TRANSLATE_EVENT.CAN_NOT_TRANSLATE_EVENT)
			end
			printError("decode data error can not be translated : ")
		end);
	

	if commandId == INIT_GOOGLE_TRANSLATE_COMMAND_ID or (self.translationCallback and jsonObject ~= nil) then
		if jsonObject.error ~= nil then
			printError("google translate error " .. data)
			return
		end

		local resultObject = {}
		if eventType == GOOGLE_TRANSLATE_EVENT.TRANSLATE_EVENT then
			local info = jsonObject.data.translations
			for k, v in pairs(info) do
				local tmp = {};
				tmp.translatedText 			= v.translatedText
				tmp.detectedSourceLanguage 	= v.detectedSourceLanguage
				resultObject[k] = tmp
			end
		elseif eventType == GOOGLE_TRANSLATE_EVENT.GET_SUPORT_LANGUAGE_EVENT then
			local info = jsonObject.data.languages
			for k, v in pairs(info) do
				local languageData = {}
				languageData.language = v.language;
				languageData.name = v.name
				resultObject[v.language] = languageData
			end
		elseif eventType == GOOGLE_TRANSLATE_EVENT.DETECT_LANGUAGE_EVENT then
			local info = jsonObject.data.detections[1][1]
			resultObject.language = info.language
			resultObject.confidence = info.confidence
			resultObject.isReliable = info.isReliable;
		else
			printError("never reach hear")
		end
		if commandId == INIT_GOOGLE_TRANSLATE_COMMAND_ID  then
			self.currentGoogleTranslationLanguage = resultObject.language
		else
			self.translationCallback(eventType, commandId, resultObject)
		end
	end
end

function SdkBox:isNeedTranslation(text)
	local support = true;
	local versionTarget = self:getVersionTarget()
	if versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or versionTarget ==  PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE then
		support = false
	end
	return support
end

function SdkBox:Utf8to32(utf8str)
    assert(type(utf8str) == "string")
    local res, seq, val = {}, 0, nil
    for i = 1, #utf8str do
        local c = string.byte(utf8str, i)
        if seq == 0 then
            table.insert(res, val)
            seq =
                c < 0x80 and 1 or c < 0xE0 and 2 or c < 0xF0 and 3 or c < 0xF8 and 4 or --c < 0xFC and 5 or c < 0xFE and 6 or
                error("invalid UTF-8 character sequence")
            val = bit32.band(c, 2 ^ (8 - seq) - 1)
        else
            val = bit32.bor(bit32.lshift(val, 6), bit32.band(c, 0x3F))
        end
        seq = seq - 1
    end
    table.insert(res, val)
    table.insert(res, 0)
    return res
end
--{DeepLinkParams = "https://game.leiting.com/list/cave2/open?layerId=100&action=2"}
function SdkBox:getDeepLinkParams()
	if self:getVersionTarget() == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN and self:getVersionPlatform() == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS then
		local url = cc.UserDefault:getInstance():getStringForKey("DeepLinkParams")
		print("---getDeepLinkParams--url = ", url)
		local startPos = string.find(url, "game.leiting.com")
		if startPos then
			local str = string.split(url, "?")[2] or ""
			local paramStr = string.split(str, "&")
			local data = {}
			for k, v in ipairs(paramStr) do
				local param = string.split(v, "=")
				if #param >= 2 then
					data[param[1]] = param[2]
				end
			end
			print("---getDeepLinkParams--data = ", data)
			return true, data
		end
	end
	return false
end

function SdkBox:clearDeepLinkParams()
	 cc.UserDefault:getInstance():setStringForKey("DeepLinkParams", "")
end

function SdkBox:callJavaStaticMethod(funcName, args, sigs)
	local luaj = require "cocos.cocos2d.luaj"
	local className = "com/avalon/sdkbox/leiting/LeiTingWrapper"
	local isOk, result = luaj.callStaticMethod(className, funcName, args, sigs)
	if not isOk then
		print("callJavaStaticMethodss: ", result)
	end
	return  isOk and result or ""
end

-- function SdkBox:getLeitingMediaValue()
-- 	-- tap的包体M值——M142073
-- 	local sigs = "()Ljava/lang/String;"
-- 	local mediaValue = self:callJavaStaticMethod("getMediaValue", nil, sigs)
-- 	print("mediaValueaaaa:", mediaValue)

-- 	return mediaValue
-- end

function SdkBox:getLeitingMediaValue()
	-- tap的包体M值——M142073
	local mediaValue = "none"
	-- print("SdkBox:getOAID 222", oaid)
	if self._userPlugin and self._userPlugin.getLeitingMediaValue then
		mediaValue = self._userPlugin:getLeitingMediaValue()
		print("SdkBoxgetLeitingMediaValue", mediaValue)
	end

	return mediaValue
end

function SdkBox:detactLocalLanguageForChar(value)
	local language = ""
	if value >= tonumber("4E00", 16) and value <= tonumber("9FA5", 16) then --：CJK 统一表意符号 (CJK Unified Ideographs)
		language = "4E00"
	elseif value >= tonumber("0000", 16) and value <= tonumber("007F", 16) then --：C0控制符及基本拉丁文 (C0 Control and Basic Latin)
		language = "0000"
	elseif value >= tonumber("0080", 16) and value <= tonumber("00FF", 16) then --：C1控制符及拉丁文补充-1 (C1 Control and Latin 1 Supplement)
		language = "0080"
	elseif value >= tonumber("0100", 16) and value <= tonumber("017F", 16) then --：拉丁文扩展-A (Latin Extended-A)
		language = "0100"
	elseif value >= tonumber("0180", 16) and value <= tonumber("024F", 16) then --：拉丁文扩展-B (Latin Extended-B)
		language = "0180"
	elseif value >= tonumber("0250", 16) and value <= tonumber("02AF", 16) then --：国际音标扩展 (IPA Extensions)
		language = "0250"
	elseif value >= tonumber("02B0", 16) and value <= tonumber("02FF", 16) then --：空白修饰字母 (Spacing Modifiers)
		language = "02B0"
	elseif value >= tonumber("0300", 16) and value <= tonumber("036F", 16) then --：结合用读音符号 (Combining Diacritics Marks)
		language = "0300"
	elseif value >= tonumber("0370", 16) and value <= tonumber("03FF", 16) then --：希腊文及科普特文 (Greek and Coptic)
		language = "0370"
	elseif value >= tonumber("0400", 16) and value <= tonumber("04FF", 16) then --：西里尔字母(Cyrillic)
		language = "0400"
	elseif value >= tonumber("0500", 16) and value <= tonumber("052F", 16) then --：西里尔字母补充 (Cyrillic Supplement)
		language = "0500"
	elseif value >= tonumber("0530", 16) and value <= tonumber("058F", 16) then --：亚美尼亚语 (Armenian)
		language = "0530"
	elseif value >= tonumber("0590", 16) and value <= tonumber("05FF", 16) then --：希伯来文 (Hebrew)
		language = "0590"
	elseif value >= tonumber("0600", 16) and value <= tonumber("06FF", 16) then --：阿拉伯文 (Arabic)
		language = "0600"
	elseif value >= tonumber("0700", 16) and value <= tonumber("074F", 16) then --：叙利亚文 (Syriac)
		language = "0700"
	elseif value >= tonumber("0750", 16) and value <= tonumber("077F", 16) then --：阿拉伯文补充 (Arabic Supplement)
		language = "0750"
	elseif value >= tonumber("0780", 16) and value <= tonumber("07BF", 16) then --：马尔代夫语 (Thaana)
		language = "0780"
	elseif value >= tonumber("07C0", 16) and value <= tonumber("07FF", 16) then --：西非书面语言 (N'Ko)
		language = "07C0"
	elseif value >= tonumber("0800", 16) and value <= tonumber("085F", 16) then --：阿维斯塔语及巴列维语(Avestan and Pahlavi)
		language = "0800"
	elseif value >= tonumber("0860", 16) and value <= tonumber("087F", 16) then --：Mandaic
		language = "0860"
	elseif value >= tonumber("0880", 16) and value <= tonumber("08AF", 16) then --：撒马利亚语 (Samaritan)
		language = "0880"
	elseif value >= tonumber("0900", 16) and value <= tonumber("097F", 16) then --：天城文书 (Devanagari)
		language = "0900"
	elseif value >= tonumber("0980", 16) and value <= tonumber("09FF", 16) then --：孟加拉语 (Bengali)
		language = "0980"
	elseif value >= tonumber("0A00", 16) and value <= tonumber("0A7F", 16) then --：锡克教文 (Gurmukhi)
		language = "0A00"
	elseif value >= tonumber("0A80", 16) and value <= tonumber("0AFF", 16) then --：古吉拉特文 (Gujarati)
		language = "0A80"
	elseif value >= tonumber("0B00", 16) and value <= tonumber("0B7F", 16) then --：奥里亚文 (Oriya)
		language = "0B00"
	elseif value >= tonumber("0B80", 16) and value <= tonumber("0BFF", 16) then --：泰米尔文 (Tamil)
		language = "0B80"
	elseif value >= tonumber("0C00", 16) and value <= tonumber("0C7F", 16) then --：泰卢固文 (Telugu)
		language = "0C00"
	elseif value >= tonumber("0C80", 16) and value <= tonumber("0CFF", 16) then --：卡纳达文 (Kannada)
		language = "0C80"
	elseif value >= tonumber("0D00", 16) and value <= tonumber("0D7F", 16) then --：德拉维族语 (Malayalam)
		language = "0D00"
	elseif value >= tonumber("0D80", 16) and value <= tonumber("0DFF", 16) then --：僧伽罗语 (Sinhala)
		language = "0D80"
	elseif value >= tonumber("0E00", 16) and value <= tonumber("0E7F", 16) then --：泰文 (Thai)
		language = "0E00"
	elseif value >= tonumber("0E80", 16) and value <= tonumber("0EFF", 16) then --：老挝文 (Lao)
		language = "0E80"
	elseif value >= tonumber("0F00", 16) and value <= tonumber("0FFF", 16) then --：藏文 (Tibetan)
		language = "0F00"
	elseif value >= tonumber("1000", 16) and value <= tonumber("109F", 16) then --：缅甸语 (Myanmar)
		language = "1000"
	elseif value >= tonumber("10A0", 16) and value <= tonumber("10FF", 16) then --：格鲁吉亚语(Georgian)
		language = "10A0"
	elseif value >= tonumber("1100", 16) and value <= tonumber("11FF", 16) then --：朝鲜文 (Hangul Jamo)
		language = "1100"
	elseif value >= tonumber("1200", 16) and value <= tonumber("137F", 16) then --：埃塞俄比亚语 (Ethiopic)
		language = "1200"
	elseif value >= tonumber("1380", 16) and value <= tonumber("139F", 16) then --：埃塞俄比亚语补充 (Ethiopic Supplement)
		language = "1380"
	elseif value >= tonumber("13A0", 16) and value <= tonumber("13FF", 16) then --：切罗基语 (Cherokee)
		language = "13A0"
	elseif value >= tonumber("1400", 16) and value <= tonumber("167F", 16) then --：统一加拿大土著语音节 (Unified Canadian Aboriginal Syllabics)
		language = "1400"
	elseif value >= tonumber("1680", 16) and value <= tonumber("169F", 16) then --：欧甘字母 (Ogham)
		language = "1680"
	elseif value >= tonumber("16A0", 16) and value <= tonumber("16FF", 16) then --：如尼文(Runic)
		language = "16A0"
	elseif value >= tonumber("1700", 16) and value <= tonumber("171F", 16) then --：塔加拉语 (Tagalog)
		language = "1700"
	elseif value >= tonumber("1720", 16) and value <= tonumber("173F", 16) then --：Hanunóo
		language = "1720"
	elseif value >= tonumber("1740", 16) and value <= tonumber("175F", 16) then --：Buhid
		language = "1740"
	elseif value >= tonumber("1760", 16) and value <= tonumber("177F", 16) then --：塔格班瓦文(Tagbanwa)
		language = "1760"
	elseif value >= tonumber("1780", 16) and value <= tonumber("17FF", 16) then --：高棉语 (Khmer)
		language = "1780"
	elseif value >= tonumber("1800", 16) and value <= tonumber("18AF", 16) then --：蒙古文 (Mongolian)
		language = "1800"
	elseif value >= tonumber("18B0", 16) and value <= tonumber("18FF", 16) then --：Cham
		language = "18B0"
	elseif value >= tonumber("1900", 16) and value <= tonumber("194F", 16) then --：Limbu
		language = "1900"
	elseif value >= tonumber("1950", 16) and value <= tonumber("197F", 16) then --：德宏泰语 (Tai Le)
		language = "1950"
	elseif value >= tonumber("1980", 16) and value <= tonumber("19DF", 16) then --：新傣仂语 (New Tai Lue)
		language = "1980"
	elseif value >= tonumber("19E0", 16) and value <= tonumber("19FF", 16) then --：高棉语记号 (Kmer Symbols)
		language = "19E0"
	elseif value >= tonumber("1A00", 16) and value <= tonumber("1A1F", 16) then --：Buginese
		language = "1A00"
	elseif value >= tonumber("1A20", 16) and value <= tonumber("1A5F", 16) then --：Batak
		language = "1A20"
	elseif value >= tonumber("1A80", 16) and value <= tonumber("1AEF", 16) then --：Lanna
		language = "1A80"
	elseif value >= tonumber("1B00", 16) and value <= tonumber("1B7F", 16) then --：巴厘语 (Balinese)
		language = "1B00"
	elseif value >= tonumber("1B80", 16) and value <= tonumber("1BB0", 16) then --：巽他语 (Sundanese)
		language = "1B80"
	elseif value >= tonumber("1BC0", 16) and value <= tonumber("1BFF", 16) then --：Pahawh Hmong
		language = "1BC0"
	elseif value >= tonumber("1C00", 16) and value <= tonumber("1C4F", 16) then --：雷布查语(Lepcha)
		language = "1C00"
	elseif value >= tonumber("1C50", 16) and value <= tonumber("1C7F", 16) then --：桑塔利文(Ol Chiki)
		language = "1C50"
	elseif value >= tonumber("1C80", 16) and value <= tonumber("1CDF", 16) then --：曼尼普尔语(Meithei/Manipuri)
		language = "1C80"
	elseif value >= tonumber("1D00", 16) and value <= tonumber("1D7F", 16) then --：语音学扩展 (Phonetic Extensions)
		language = "1D00"
	elseif value >= tonumber("1D80", 16) and value <= tonumber("1DBF", 16) then --：语音学扩展补充 (Phonetic Extensions Supplem
		language = "1D80"
	elseif value >= tonumber("1DC0", 16) and value <= tonumber("1DFF", 16) then --：结合用读音符号补充 (Combining Diacritics Marks Supplement)
		language = "1DC0"
	elseif value >= tonumber("1E00", 16) and value <= tonumber("1EFF", 16) then --：拉丁文扩充附加 (Latin Extended Additional)
		language = "1E00"
	elseif value >= tonumber("1F00", 16) and value <= tonumber("1FFF", 16) then --：希腊语扩充 (Greek Extended)
		language = "1F00"
	elseif value >= tonumber("2000", 16) and value <= tonumber("206F", 16) then --：常用标点(General Punctuation)
		language = "2000"
	elseif value >= tonumber("2070", 16) and value <= tonumber("209F", 16) then --：上标及下标 (Superscripts and Subscripts)
		language = "2070"
	elseif value >= tonumber("20A0", 16) and value <= tonumber("20CF", 16) then --：货币符号 (Currency Symbols)
		language = "20A0"
	elseif value >= tonumber("20D0", 16) and value <= tonumber("20FF", 16) then --：组合用记号 (Combining Diacritics Marks for Symbols)
		language = "20D0"
	elseif value >= tonumber("2100", 16) and value <= tonumber("214F", 16) then --：字母式符号 (Letterlike Symbols)
		language = "2100"
	elseif value >= tonumber("2150", 16) and value <= tonumber("218F", 16) then --：数字形式 (Number Form)
		language = "2150"
	elseif value >= tonumber("2190", 16) and value <= tonumber("21FF", 16) then --：箭头 (Arrows)
		language = "2190"
	elseif value >= tonumber("2200", 16) and value <= tonumber("22FF", 16) then --：数学运算符 (Mathematical Operator)
		language = "2200"
	elseif value >= tonumber("2300", 16) and value <= tonumber("23FF", 16) then --：杂项工业符号 (Miscellaneous Technical)
		language = "2300"
	elseif value >= tonumber("2400", 16) and value <= tonumber("243F", 16) then --：控制图片 (Control Pictures)
		language = "2400"
	elseif value >= tonumber("2440", 16) and value <= tonumber("245F", 16) then --：光学识别符 (Optical Character Recognition)
		language = "2440"
	elseif value >= tonumber("2460", 16) and value <= tonumber("24FF", 16) then --：封闭式字母数字 (Enclosed Alphanumerics)
		language = "2460"
	elseif value >= tonumber("2500", 16) and value <= tonumber("257F", 16) then --：制表符 (Box Drawing)
		language = "2500"
	elseif value >= tonumber("2580", 16) and value <= tonumber("259F", 16) then --：方块元素 (Block Element)
		language = "2580"
	elseif value >= tonumber("25A0", 16) and value <= tonumber("25FF", 16) then --：几何图形 (Geometric Shapes)
		language = "25A0"
	elseif value >= tonumber("2600", 16) and value <= tonumber("26FF", 16) then --：杂项符号 (Miscellaneous Symbols)
		language = "2600"
	elseif value >= tonumber("2700", 16) and value <= tonumber("27BF", 16) then --：印刷符号 (Dingbats)
		language = "2700"
	elseif value >= tonumber("27C0", 16) and value <= tonumber("27EF", 16) then --：杂项数学符号-A (Miscellaneous Mathematical Symbols-A)
		language = "27C0"
	elseif value >= tonumber("27F0", 16) and value <= tonumber("27FF", 16) then --：追加箭头-A (Supplemental Arrows-A)
		language = "27F0"
	elseif value >= tonumber("2800", 16) and value <= tonumber("28FF", 16) then --：盲文点字模型 (Braille Patterns)
		language = "2800"
	elseif value >= tonumber("2900", 16) and value <= tonumber("297F", 16) then --：追加箭头-B (Supplemental Arrows-B)
		language = "2900"
	elseif value >= tonumber("2980", 16) and value <= tonumber("29FF", 16) then --：杂项数学符号-B (Miscellaneous Mathematical Symbols-B)
		language = "2980"
	elseif value >= tonumber("2A00", 16) and value <= tonumber("2AFF", 16) then --：追加数学运算符 (Supplemental Mathematical Operator)
		language = "2A00"
	elseif value >= tonumber("2B00", 16) and value <= tonumber("2BFF", 16) then --：杂项符号和箭头 (Miscellaneous Symbols and Arrows)
		language = "2B00"
	elseif value >= tonumber("2C00", 16) and value <= tonumber("2C5F", 16) then --：格拉哥里字母(Glagolitic)
		language = "2C00"
	elseif value >= tonumber("2C60", 16) and value <= tonumber("2C7F", 16) then --：拉丁文扩展-C (Latin Extended-C
		language = "2C60"
	elseif value >= tonumber("2C80", 16) and value <= tonumber("2CFF", 16) then --：古埃及语 (Coptic)
		language = "2C80"
	elseif value >= tonumber("2D00", 16) and value <= tonumber("2D2F", 16) then --：格鲁吉亚语补充 (Georgian Supplement)
		language = "2D00"
	elseif value >= tonumber("2D30", 16) and value <= tonumber("2D7F", 16) then --：提非纳文 (Tifinagh)
		language = "2D30"
	elseif value >= tonumber("2D80", 16) and value <= tonumber("2DDF", 16) then --：埃塞俄比亚语扩展 (Ethiopic Extended)
		language = "2D80"
	elseif value >= tonumber("2E00", 16) and value <= tonumber("2E7F", 16) then --：追加标点 (Supplemental Punctuation)
		language = "2E00"
	elseif value >= tonumber("2E80", 16) and value <= tonumber("2EFF", 16) then --：CJK 部首补充 (CJK Radicals Supplement)
		language = "2E80"
	elseif value >= tonumber("2F00", 16) and value <= tonumber("2FDF", 16) then --：康熙字典部首 (Kangxi Radicals)
		language = "2F00"
	elseif value >= tonumber("2FF0", 16) and value <= tonumber("2FFF", 16) then --：表意文字描述符 (Ideographic Description Characters)
		language = "2FF0"
	elseif value >= tonumber("3000", 16) and value <= tonumber("303F", 16) then --：CJK 符号和标点 (CJK Symbols and Punctuation)
		language = "3000"
	elseif value >= tonumber("3040", 16) and value <= tonumber("309F", 16) then --：日文平假名 (Hiragana)
		language = "3040"
	elseif value >= tonumber("30A0", 16) and value <= tonumber("30FF", 16) then --：日文片假名 (Katakana)
		language = "30A0"
	elseif value >= tonumber("3100", 16) and value <= tonumber("312F", 16) then --：注音字母 (Bopomofo)
		language = "3100"
	elseif value >= tonumber("3130", 16) and value <= tonumber("318F", 16) then --：朝鲜文兼容字母 (Hangul Compatibility Jamo)
		language = "3130"
	elseif value >= tonumber("3190", 16) and value <= tonumber("319F", 16) then --：象形字注释标志 (Kanbun)
		language = "3190"
	elseif value >= tonumber("31A0", 16) and value <= tonumber("31BF", 16) then --：注音字母扩展 (Bopomofo Extended)
		language = "31A0"
	elseif value >= tonumber("31C0", 16) and value <= tonumber("31EF", 16) then --：CJK 笔画 (CJK Strokes)
		language = "31C0"
	elseif value >= tonumber("31F0", 16) and value <= tonumber("31FF", 16) then --：日文片假名语音扩展 (Katakana Phonetic Extensions)
		language = "31F0"
	elseif value >= tonumber("3200", 16) and value <= tonumber("32FF", 16) then --：封闭式 CJK 文字和月份 (Enclosed CJK Letters and Months)
		language = "3200"
	elseif value >= tonumber("3300", 16) and value <= tonumber("33FF", 16) then --：CJK 兼容 (CJK Compatibility)
		language = "3300"
	elseif value >= tonumber("3400", 16) and value <= tonumber("4DBF", 16) then --：CJK 统一表意符号扩展 A (CJK Unified Ideographs Extension A)
		language = "3400"
	elseif value >= tonumber("4DC0", 16) and value <= tonumber("4DFF", 16) then --：易经六十四卦符号 (Yijing Hexagrams Symbols)
		language = "4DC0"
	elseif value >= tonumber("4E00", 16) and value <= tonumber("9FBF", 16) then --：CJK 统一表意符号 (CJK Unified Ideographs)
		language = "4E00"
	elseif value >= tonumber("A000", 16) and value <= tonumber("A48F", 16) then --：彝文音节 (Yi Syllables)
		language = "A000"
	elseif value >= tonumber("A490", 16) and value <= tonumber("A4CF", 16) then --：彝文字根 (Yi Radicals)
		language = "A490"
	elseif value >= tonumber("A500", 16) and value <= tonumber("A61F", 16) then --：Vai
		language = "A500"
	elseif value >= tonumber("A660", 16) and value <= tonumber("A6FF", 16) then --：统一加拿大土著语音节补充 (Unified Canadian Aboriginal Syllabics Supplement)
		language = "A660"
	elseif value >= tonumber("A700", 16) and value <= tonumber("A71F", 16) then --：声调修饰字母 (Modifier Tone Letters)
		language = "A700"
	elseif value >= tonumber("A720", 16) and value <= tonumber("A7FF", 16) then --：拉丁文扩展-D (Latin Extended-D)
		language = "A720"
	elseif value >= tonumber("A800", 16) and value <= tonumber("A82F", 16) then --：Syloti Nagri
		language = "A800"
	elseif value >= tonumber("A840", 16) and value <= tonumber("A87F", 16) then --：八思巴字 (Phags-pa)
		language = "A840"
	elseif value >= tonumber("A880", 16) and value <= tonumber("A8DF", 16) then --：Saurashtra
		language = "A880"
	elseif value >= tonumber("A900", 16) and value <= tonumber("A97F", 16) then --：爪哇语 (Javanese)
		language = "A900"
	elseif value >= tonumber("A980", 16) and value <= tonumber("A9DF", 16) then --：Chakma
		language = "A980"
	elseif value >= tonumber("AA00", 16) and value <= tonumber("AA3F", 16) then --：Varang Kshiti
		language = "AA00"
	elseif value >= tonumber("AA40", 16) and value <= tonumber("AA6F", 16) then --：Sorang Sompeng
		language = "AA40"
	elseif value >= tonumber("AA80", 16) and value <= tonumber("AADF", 16) then --：Newari
		language = "AA80"
	elseif value >= tonumber("AB00", 16) and value <= tonumber("AB5F", 16) then --：越南傣语 (Vi?t Thái)
		language = "AB00"
	elseif value >= tonumber("AB80", 16) and value <= tonumber("ABA0", 16) then --：Kayah Li
		language = "AB80"
	elseif value >= tonumber("AC00", 16) and value <= tonumber("D7AF", 16) then --：朝鲜文音节 (Hangul Syllables)
		language = "AC00"
	elseif value >= tonumber("D800", 16) and value <= tonumber("DBFF", 16) then --：High-half zone of UTF-16
		language = "D800"
	elseif value >= tonumber("DC00", 16) and value <= tonumber("DFFF", 16) then --：Low-half zone of UTF-16
		language = "DC00"
	elseif value >= tonumber("E000", 16) and value <= tonumber("F8FF", 16) then --：自行使用区域 (Private Use Zone)
		language = "E000"
	elseif value >= tonumber("F900", 16) and value <= tonumber("FAFF", 16) then --：CJK 兼容象形文字 (CJK Compatibility Ideographs)
		language = "F900"
	elseif value >= tonumber("FB00", 16) and value <= tonumber("FB4F", 16) then --：字母表达形式 (Alphabetic Presentation Form)
		language = "FB00"
	elseif value >= tonumber("FB50", 16) and value <= tonumber("FDFF", 16) then --：阿拉伯表达形式A (Arabic Presentation Form-A)
		language = "FB50"
	elseif value >= tonumber("FE00", 16) and value <= tonumber("FE0F", 16) then --：变量选择符 (Variation Selector)
		language = "FE00"
	elseif value >= tonumber("FE10", 16) and value <= tonumber("FE1F", 16) then --：竖排形式 (Vertical Forms)
		language = "FE10"
	elseif value >= tonumber("FE20", 16) and value <= tonumber("FE2F", 16) then --：组合用半符号 (Combining Half Marks)
		language = "FE20"
	elseif value >= tonumber("FE30", 16) and value <= tonumber("FE4F", 16) then --：CJK 兼容形式 (CJK Compatibility Forms)
		language = "FE30"
	elseif value >= tonumber("FE50", 16) and value <= tonumber("FE6F", 16) then --：小型变体形式 (Small Form Variants)
		language = "FE50"
	elseif value >= tonumber("FE70", 16) and value <= tonumber("FEFF", 16) then --：阿拉伯表达形式B (Arabic Presentation Form-B)
		language = "FE70"
	elseif value >= tonumber("FF00", 16) and value <= tonumber("FFEF", 16) then --：半型及全型形式 (Halfwidth and Fullwidth Form)
		language = "FF00"
	elseif value >= tonumber("FFF0", 16) and value <= tonumber("FFFF", 16) then --：特殊 (Specials)
		language = "FFF0"
	end

	return language
end

---------------------------------------google translation API end -------------------------------------------------


return SdkBox
