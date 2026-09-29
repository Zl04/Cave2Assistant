-- 屏幕录像模块
-- 06/15/2018
-- CMonk
local SdkBox = require("utils.sdkbox.SdkBox")
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

ScreenRecordUtil = class("ScreenRecordUtil")
g_ScreenRecordUtil = nil;

ScreenRecordUtil.ErrorCode = {
	SRUNotAvailable = 10001,
	SRUIsRecording = 10000,
	RPRecordingErrorUserDeclined = -5801,
	RPRecordingErrorInsufficientStorage = -5805,
}














function ScreenRecordUtil:getInstance()
	if g_ScreenRecordUtil == nil then
		g_ScreenRecordUtil = ScreenRecordUtil.new()
		g_ScreenRecordUtil:init()
	end
	return g_ScreenRecordUtil;
end

function ScreenRecordUtil:purgeInstance()
	if g_ScreenRecordUtil ~= nil then
		g_ScreenRecordUtil = nil;
	end
end

function ScreenRecordUtil:ctor()
	self._isRecording = false
	self._onOffStatusChangeCallback = nil
	self._onRecordingError = nil
end

function ScreenRecordUtil:dtor()
	self:stopRecording(true)
end

function ScreenRecordUtil:init()
end

-- 是否可以使用
function ScreenRecordUtil:isAvailable()
	return SdkBox:getInstance():screenRecordIsAvailable();
end

-- 是否显示按钮
function ScreenRecordUtil:isDiplayRecordButton()
	if (SdkBox:getInstance():screenRecordIsAvailable() and self:getRecorderOn()) then
		return true
	end
	return false
end

-- 开始录像, 参数分别是: 开始成功回调, 开始失败回调, 录像途中错误回调
function ScreenRecordUtil:startRecording(succ, fail, inProgressError)
	if (not self:isDiplayRecordButton()) then return end
	self._isRecording = true
	SdkBox:getInstance():screenRecordStart(
		function()					--录像开始成功
			if (succ) then succ() end
		end, function(errorCode) 	--开始失败
			if (fail) then fail(errorCode) end
		end, function(errorCode) 	--录像途中失败
			self._isRecording = false
			
			if (self._onRecordingError) then self._onRecordingError(errorCode) end
			if (inProgressError) then inProgressError(errorCode) end
		end)
end

-- 停止录像, isToDiscard == true就不会有保存回调
function ScreenRecordUtil:stopRecording(isToDiscard, saveSuccCB, saveFailCB)
	if (not self:isAvailable()) then return end
	SdkBox:getInstance():screenRecordEnd(isToDiscard, saveSuccCB, saveFailCB)
	self._isRecording = false
end

-- 获取是否在录像中
function ScreenRecordUtil:getIsRecording()
	return self._isRecording;
end

-- 设置录像开关, 第一次打开会有申请用户授权, 用户拒绝后下次打开还会申请, 直到第一次得到授权为止
function ScreenRecordUtil:setRecorderOn(isOn, cb)
	if (not self:isAvailable()) then
		cb(false, ScreenRecordUtil.ErrorCode.SRUNotAvailable)
		return
	end

	if (not isOn and self:getIsRecording()) then
		-- 如果在录像中点击关闭录像功能
		cb(false, ScreenRecordUtil.ErrorCode.SRUIsRecording)
		return
	end

	self:saveRecorderOn(isOn)
	if (self._onOffStatusChangeCallback) then self._onOffStatusChangeCallback(isOn) end
	if (isOn) then
		SdkBox:getInstance():screenRecordAuthenticate(function()
			if (cb) then cb(true) end
		end, function(code)
			self:saveRecorderOn(false)
			if (cb) then cb(false, code) end
			if (self._onOffStatusChangeCallback) then self._onOffStatusChangeCallback(false) end
		end)
	end
end

-- 获取现在保存的开关状态
function ScreenRecordUtil:getRecorderOn()
	-- local gameData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, GameDataManager:getInstance():getSaveUserKey())
 --    local isRecorderOn = 0
 --    if(gameData) then
 --    	isRecorderOn = tonumber(gameData:getRecorderOn())
 --    end
 --    return isRecorderOn and isRecorderOn > 0 or false
 	return cc.UserDefault:getInstance():getBoolForKey(GameDataManager:getInstance():getSaveUserKey().."SCREEN_RECORDER_ON", false)
end

-- 将开关状态写入本地存档中
function ScreenRecordUtil:saveRecorderOn(isOn)
	-- local userKey = GameDataManager:getInstance():getSaveUserKey()
	-- local gameData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, userKey)
	-- if (gameData) then gameData:setRecorderOn(isOn and 1 or 0) end
 --    Avalon.UserDataManager:writeUserData(userKey, gameData)
 	cc.UserDefault:getInstance():setBoolForKey(GameDataManager:getInstance():getSaveUserKey().."SCREEN_RECORDER_ON", isOn)
end

-- 录屏中错误回调
function ScreenRecordUtil:setOnRecordingError(cb)
	self._onRecordingError = cb
end

-- 开关状态回调
function ScreenRecordUtil:setOnOffStatusChangeCallback(cb)
	self._onOffStatusChangeCallback = cb
end

-- 获取错误文字
function ScreenRecordUtil:getErrorString(errorCode)
	if (errorCode == ScreenRecordUtil.ErrorCode.SRUNotAvailable) then
        return LanguageManager:getInstance():getLocalString(1111242) --"需要升级到IOS9或更高版本才能使用此功能"
    elseif (errorCode == ScreenRecordUtil.ErrorCode.RPRecordingErrorUserDeclined) then
        return LanguageManager:getInstance():getLocalString(1111243) --"拒绝授权"
    elseif (errorCode == ScreenRecordUtil.ErrorCode.SRUIsRecording) then
        return LanguageManager:getInstance():getLocalString(1111244) --"录像正在进行中, 停止后可以关闭该功能"
    elseif (errorCode == ScreenRecordUtil.ErrorCode.RPRecordingErrorInsufficientStorage) then   
        return LanguageManager:getInstance():getLocalString(1111800) --"存储空间不足"
	else
		local str = LanguageManager:getInstance():getLocalString(1110382)..": "..tostring(errorCode)
    	return str --"未知错误"
    end
end


return ScreenRecordUtil