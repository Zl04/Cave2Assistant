--
-- Author: yueyingsong
-- Date: 2017-10-11 17:30:51
--
Avalon = Avalon or {}
-- sdk用户模块枚举(部分可能没有 预留)
local UserActionResultCode = {
    kInitSuccess             	= 0,       --初始化成功(第三方登录成功).
    kInitFail                	= 1,       --初始化失败(第三方登录失败).
    kLoginSuccess            	= 2,       --登录成功.
    kLoginNetworkError       	= 3,       --网络错误.
    kLoginNoNeed             	= 4,       --不需要登录.
    kLoginNeedThridAppInstalled	= 5,	   --需要第三方app 比如微信 必须安装了才能登录
    kLoginFail               	= 6,       --登录失败.
    kLoginCancel             	= 7,       --取消登录.
    kLogoutSuccess           	= 8,       --登出成功.
    kLogoutFail              	= 9,       --登出失败.
    kPlatformEnter           	= 10,      --进入平台中心.
    kPlatformBack            	= 11,      --离开平台中心.
    kPausePage               	= 12,      --暂停页面.
    kExitPage                	= 13,      --退出页面.
    kAntiAddictionQuery      	= 14,      --反沉迷.
    kRealNameRegister        	= 15,      --实名注册.
    kAccountSwitchSuccess    	= 16,      --切换账号成功.
    kAccountSwitchFail       	= 17,      --切换账号失败.
    kOpenShop                	= 18,      --打开平台商城.
    kUserExtension           	= 50000    --拓展字段.
}
Avalon.UserActionResultCode = UserActionResultCode
-- 玩家分享模块
local ShareActionResultCode = {
	kShareSuccess 			            = 0,
	kShareFail 				            = 1,
    kShareNeedThridAppInstalled         = 2,--需要第三方app 比如微信 必须安装了才能分享
    kShareNeedThridLogin                = 3,--需要第三方登录
	kShareCancel 			            = 4,
}
Avalon.ShareActionResultCode = ShareActionResultCode

local PayResultCode = {
    kPaySuccess                      = 0,       -- 支付成功
    kPayFail                         = 1,       -- 支付失败
    kPayCancel                       = 2,       -- 支付取消
    kPayNetworkError                 = 3,       -- 网络错误
    kPayProductionInforIncomplete    = 4,       -- 支付信息提供不完全
    kPayInitSuccess                  = 5,       -- 初始化成功
    kPayInitFail                     = 6,       -- 初始化失败
    kPayNowPaying                    = 7,       -- 支付中
    kPayRechargeSuccess              = 8,       -- 充值成功
    kPayRequestSkuDetailFailed 		 = 9;	    -- 获取详细信息失败
    kPayRequestSkuDetailSuccess 	 = 10;	    -- 获取详细信息成功
    kPayAlreadyPurchased             = 11;      -- 已经购买，主要适用于订阅等不能重复购买的物品
	kPayInvalidSku                   = 12;      -- 无效的IAP
	kPayNotSupported                 = 13;      -- 不支持的购买
	kPayNotLoginMarketplace          = 14;      -- 没有登录市场
    kPayExtension                    = 30000    -- 拓展字段
}
Avalon.PayResultCode = PayResultCode

local StrorePayFrom = {
    SPFPreOrder = "1",    -- 商店预购
    SPFReedom = "2",      -- 商店兑换码
}
Avalon.StrorePayFrom = StrorePayFrom

-- 分享类型
local ShareType ={
    SHARE_TEXT                  = 0,    -- 纯文本分享
    SHARE_LINK                  = 1,    -- 分享网页或者链接
    SHARE_IMAGE                 = 2,    -- 分享图片
    SHARE_APP                   = 3,    -- app分享(目前预留,微信可能会用到)
}
Avalon.ShareType = ShareType


local WXScene = {
    WXSceneSession  = 0,        -- 聊天界面    
    WXSceneTimeline = 1,        -- 朋友圈      
    WXSceneFavorite = 2,        -- 收藏       
};
Avalon.WXScene = WXScene


local SubmitExtraDataType = {
    SubmitExtraDataCreateRole = 0, -- 创建角色
    SubmitExtraDataLoginRole  = 1,  -- 登入角色
    SubmitExtraDataUpdateRole = 2, -- 角色信息变动(例如升级)
}
Avalon.SubmitExtraDataType = SubmitExtraDataType
