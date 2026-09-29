--
-- Author: yueyingsong
-- Date: 2017-11-06 16:02:49
-- 分享的工具类
ShareUtil = ShareUtil or {}

local SHARE_CHANNEL = PublicDefine.SHARE_CHANNEL



function ShareUtil:getImageNameByType(platform)
	local btnImage = "ui_share_button_entrance_facebook.png";
    if platform == SHARE_CHANNEL.SHARE_CHANNEL_FB then
        btnImage = "ui_share_button_entrance_facebook.png";
    elseif platform == SHARE_CHANNEL.SHARE_CHANNEL_WX then
        btnImage = "ui_share_icon_button_entrance_wechatfriends.png";
    elseif platform == SHARE_CHANNEL.SHARE_CHANNEL_QQ then
    	btnImage = "ui_share_button_entrance_qqzone.png";
    elseif platform == SHARE_CHANNEL.SHARE_CHANNEL_TWITTER then
        btnImage = "ui_share_icon_button_entrance_twitter.png";
    elseif platform == SHARE_CHANNEL.SHARE_CHANNEL_WX_SESSION then
    	btnImage = "ui_share_button_entrance_wechat.png";
    elseif platform == SHARE_CHANNEL.SHARE_CHANNEL_QQ_SESSION then
    	btnImage = "ui_share_button_entrance_qq.png"; 
    elseif platform == SHARE_CHANNEL.SHARE_CHANNEL_WEIBO then
	   	btnImage = "ui_share_button_entrance_sina.png"; 	
    end
    return btnImage
end