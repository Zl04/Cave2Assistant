require "utils.message.MessageCenter"
require "utils.AvalonUtil"
require "app.datas.TeamDataManager"
require "app.datas.RoleDataManager"
require "app.ui.common.Dialog.ScrollBar"
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")

Avalon = Avalon or {}
local VoiceChatManager = {}
Avalon.VoiceChatManager = VoiceChatManager

local inited = false
local currentSpeakerVolume = 0
local currentMicVolume = 0
local isSpeakerMuted = true
local isMicMuted = true
local spkOnOffCallback = nil
local micOnOffCallback = nil
local isMicDeniedWhenInit = nil
local isMicDeniedOverride = nil
local isDynamicPermissionUsed = false

-- enum AGORA_ACTION_IDS {
--     init = 1,
--     joinChannel,
--     leaveChannel,
--     userJoined,
--     warn,
--     error,
--     audioQuality,
--     audioVolume,
-- };

-- 回调操作ID
local AGORA_ACTION_IDS = {
	init = 1,
	joinChannel = 2,
	leaveChannel = 3,
	userJoined = 4,
	warn = 5,
	error = 6,
	audioQuality = 7,
	audioVolume = 8,
}

local agora = nil

-- 初始化SDK和加载设置, 目前在游戏开始的时候操作
function VoiceChatManager:init()
	if (not CONFIG_VOICECHAT) then return end
	if (inited) then return end
	inited = true

	if (avalon and avalon.AgoraManager) then
		agora = avalon.AgoraManager:getInstance()
		-- 这里根据渠道等匹配不同的值
		-- agora:setAppCertificate("c892dde5c9064121aa359482d0f9d7fe")
		-- 初始化参数
		agora:setCallback(handler(self, VoiceChatManager.onCallback))
		agora:init()
		printInfo("VoiceChatManager:init() 正在初始化")
	else
		printInfo("VoiceChatManager:init() 找不到Agora模块")
	end
	self:restoreCurrentSettings()

	Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_JOIN, self, function()
		self:joinOrLeaveChannelWithCurrentInfo()
		Avalon.MessageCenter:notice(AvalonMessage.MC_CHAT_QUICK_CHAT_REFRESH)
	end)
	Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_LEAVE, self, function()
		self:joinOrLeaveChannelWithCurrentInfo()
		Avalon.MessageCenter:notice(AvalonMessage.MC_CHAT_QUICK_CHAT_REFRESH)
	end)
	Avalon.MessageCenter:bind(AvalonMessage.MC_NET_DISCONNECT, self, function()
		printInfo("VoiceChatManager 掉线")
		self:leaveChannel()
	end)
	Avalon.MessageCenter:bind(AvalonMessage.MC_GAME_ENTER_BACKGROUND, self, function()
		printInfo("VoiceChatManager:init() 进入后台")
		self:setMuteSpeaker(true, false, false)
		self:setMuteMic(true, false, false)
		if (SceneManager:getInstance():isInFightScene()) then
			self:leaveChannel()
		end
	end)
	Avalon.MessageCenter:bind(AvalonMessage.MC_GAME_ENTER_PROGROUND, self, function()
		Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
			printInfo("VoiceChatManager:init() 进入前台")
			-- 切回时如果麦克风权限打开了, 重新进入游戏
			local isMicDeniedNow = self:isMicPermissionDenied()
			if (not isDynamicPermissionUsed and isMicDeniedWhenInit ~= nil and isMicDeniedNow == false and isMicDeniedNow ~= isMicDeniedWhenInit) then
				Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
				cc.Director:getInstance():restart()
				return
			end

			self:restoreCurrentSettings()

			-- 如果在战斗场景中, 尝试加入语音队伍
			self:joinOrLeaveChannelWithCurrentInfo(false)
		end, 1)
	end)

	isMicDeniedWhenInit = self:isMicPermissionDenied()
end

-- 底层SDK回调方法
function VoiceChatManager:onCallback(actionId, data)
	if (actionId == AGORA_ACTION_IDS.init) then
	elseif (actionId == AGORA_ACTION_IDS.joinChannel) then
		self:restoreCurrentSettings()
	elseif (actionId == AGORA_ACTION_IDS.leaveChannel) then
	elseif (actionId == AGORA_ACTION_IDS.userJoined) then
	elseif (actionId == AGORA_ACTION_IDS.warn) then
	elseif (actionId == AGORA_ACTION_IDS.error) then
		printWarn("VoiceChatManager:onCallback, ERROR", actionId, data)
		if (data.err and data.err == "1111") then
			isMicDeniedOverride = true
			self:setMuteMic(true, false)
			if (device.platform == "ios") then
				self:setMuteSpeaker(true, false)
			end
			return
		end

		-- 报未知错误
		if (data.err and 
			data.err ~= "17" and -- 已经加入
			data.err ~= "18" and -- 已经离开
			data.err ~= "1111" and -- iOS权限
			data.err ~= "1027" ) then -- 安卓权限
			-- 请提示用户关闭第三方录音应用
			if(data.err == "1033" or data.err == "1031") then 
				UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170303))
			else
				UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110382) .. "VC" .. tostring(data.err)) -- 组队语音出错
			end
		end
	elseif (actionId == AGORA_ACTION_IDS.audioQuality) then
	elseif (actionId == AGORA_ACTION_IDS.audioVolume) then
	end
end

-- 加入频道
function VoiceChatManager:joinChannel(channelName, uid)
	if (not agora) then return end
	local SdkBox = require("utils.sdkbox.SdkBox")
	local versionTarget = SdkBox:getInstance():getVersionTarget()
	if(versionTarget == nil) then 
		versionTarget = ""
	end
	local mod = math.fmod(uid, 2147483647)
	agora:joinChannel(versionTarget..":"..channelName, mod)
	printInfo("VoiceChatManager:joinChannel, 正在加入队伍语音", channelName, mod)
end

-- 是否能够加入语音频道
-- true = 能加入, false = 不能加入
function VoiceChatManager:isAbleToJoinChannel()
	if (not self:isToShowVoiceChatButtons()) then
		return false
	end 

	if (not isMicMuted or not isSpeakerMuted) then
		return true
	else
		return false
	end
end

-- 用现在已有信息加入频道, 如果信息不够则不做任何事情
function VoiceChatManager:joinOrLeaveChannelWithCurrentInfo(enableLeave)
	if (enableLeave == nil) then enableLeave = true end
	if (not self:isAbleToJoinChannel()) then 
		-- 只有isAbleToJoin为false和enableLeav被打开时才退队, 否则不做任何事情
		if (enableLeave) then self:leaveChannel() end
		return 
	end
	if(not TeamDataManager:hasTeam()) then return end
	local teamId = TeamDataManager:getTeamID()
	if (not teamId or teamId == 0) then return end

	local masterPK = RoleDataManager:getMaster():getPK()
	masterPK = masterPK or 0
	self:joinChannel(tostring(teamId), masterPK)
end

-- 离开频道
function VoiceChatManager:leaveChannel()
	if (not agora) then return end
	agora:leaveChannel()
	printInfo("VoiceChatManager:leaveChannel, 正在离开队伍语音")
end

-- 设置麦克风音量
function VoiceChatManager:setMicVolume(volume)
	-- currentMicVolume = volume
	currentMicVolume = 0
	if (not agora) then return end
	agora:setMicVolume(volume)
end

-- 获取麦克风音量
function VoiceChatManager:getMicVolume()
	return currentMicVolume
end

-- 设置团队其他人语音音量
function VoiceChatManager:setSpkVolume(volume)
	-- currentSpeakerVolume = volume
	currentSpeakerVolume = 0
	if (not agora) then return end
	agora:setSpkVolume(volume)
end

-- 获取团队其他人语音音量
function VoiceChatManager:getSpkVolume()
	return currentSpeakerVolume
end

-- 静音团队其他人(不会有流量)
function VoiceChatManager:setMuteSpeaker(isMute, isByTouch, checkChannelAction)
	if (checkChannelAction == nil) then checkChannelAction = true end
	if (isByTouch and device.platform == "ios") then AvalonUtil.androidRequestPermission("APPLE_AUDIO") end --ios 申请权限
	if (device.platform == "ios" and self:isMicPermissionDenied()) then -- ios上需要打开录音权限才能使用语音模块, 否则连声音都没有
		isMute = true
		if (isByTouch) then
			UI.ScrollBar:createByTextID(1111743) -- "团队语音功能需要录音权限, 请在系统设置中打开后重新进入游戏"
		end
	end

	isSpeakerMuted = isMute
	if (agora) then
		agora:setMuteAllRemote(isMute)
	end

	if (checkChannelAction) then
		self:joinOrLeaveChannelWithCurrentInfo()
	end
	if (spkOnOffCallback) then spkOnOffCallback(not isMute) end
	return isMute
end

-- 获取是否已经静音团队其他人
function VoiceChatManager:isSpeakerMuted()
	return isSpeakerMuted
end

-- 设置是否本地已经静音
function VoiceChatManager:setMuteMic(isMute, isByTouch, checkChannelAction)
	if (checkChannelAction == nil) then checkChannelAction = true end
	if (isByTouch and device.platform == "ios") then AvalonUtil.androidRequestPermission("APPLE_AUDIO") end --ios 申请权限
	if (not isMute and self:isMicPermissionDenied()) then
		isMute = true

		if (isByTouch and device.platform == "android") then
			if (AvalonUtil.androidRequestPermission("android.permission.RECORD_AUDIO", "Team voice chat needs this permission.")) then
				isMicDeniedOverride = false
				isDynamicPermissionUsed = true
			end
		end
		
		if (isByTouch) then
			UI.ScrollBar:createByTextID(1111743) -- "团队语音功能需要录音权限, 请在系统设置中打开后重新进入游戏"
		end
	end

	isMicMuted = isMute
	if (agora) then
		agora:setMuteLocal(isMute)
	end

	if (checkChannelAction) then
		self:joinOrLeaveChannelWithCurrentInfo()
	end
	if (micOnOffCallback) then micOnOffCallback(not isMute) end
	return isMute
end

-- 获取是否本地已经静音
function VoiceChatManager:isMicMuted()
	return isMicMuted
end

-- 静音频道里的某一个ID(可从加入回调中获得ID, 目前设置为人物PK)
function VoiceChatManager:setMuteUser(userId, isMute)
	if (not agora) then return end
	agora:setMuteUser(userId, isMute)
end

-- 设置说话声音回调(间隔毫秒 - 0为关闭, 顺滑程度 - 默认为3)
function VoiceChatManager:setVolumeIndication(interval, smooth)
	if (not agora) then return end
	agora:setVolumeIndication(interval, smooth)
end

-- 设置音高(0.5 - 2)
function VoiceChatManager:setLocalVoicePitch(pitch)
	if (not agora) then return end
	agora:setLocalVoicePitch(pitch)
end

-- 设置播放回调
function VoiceChatManager:setSpkOnOffCallback(cb)
	spkOnOffCallback = cb
end

-- 设置录音回调
function VoiceChatManager:setMicOnOffCallback(cb)
	micOnOffCallback = cb
end

function VoiceChatManager:isToShowVoiceChatButtons()
	-- add by zp CO-16488【屏蔽】游戏中可以个其他玩家发消息的地方都需要屏蔽掉
	local SdkManager = require"app.game.SdkManager"
	if SdkManager:responsePolicySwitch() then
		local SdkBox = require("utils.sdkbox.SdkBox")
		local target = SdkBox:getInstance():getVersionTarget()
		if target ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
			return false
		end
	end
	

	if (not agora) then
		return false
	end

	local master = RoleDataManager:getMaster()
	if (not master) then return false end
	local masterPK = master:getPK()
	if (not masterPK) then return false end
	return TeamDataManager:judgeIsInTeam(masterPK) and SceneManager:getInstance():isInFightScene() and TeamDataManager:getTeamMemberNum() > 1 
end

-- 保存现在设置
function VoiceChatManager:saveCurrentSettings()
    -- 存储播放设置
	cc.UserDefault:getInstance():setFloatForKey(UserDefaultKeyWord.voiceChatSpeakerVolume, currentSpeakerVolume)
	cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.voiceChatSpeakerMuted, isSpeakerMuted)

	-- 存储录音设置
	cc.UserDefault:getInstance():setFloatForKey(UserDefaultKeyWord.voiceChatMicVolume, currentMicVolume)
	cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.voiceChatMicMuted, isMicMuted)
end

-- 关闭语音设置并保存
function VoiceChatManager:closeVoiceSettings()
	isSpeakerMuted = true;
	isMicMuted = true;
	currentSpeakerVolume = 0
	currentMicVolume = 0
	self:setSpkVolume(currentSpeakerVolume)
	self:setMicVolume(currentMicVolume)
	self:setMuteSpeaker(isSpeakerMuted,false, false)
	self:setMuteMic(isMicMuted, false, false)
	self:saveCurrentSettings()

	self:leaveChannel()
end

-- 从保存的设置里面恢复设置状态
function VoiceChatManager:restoreCurrentSettings()
	-- 还原播放设置
	local currentSpeakerVolume = 0--cc.UserDefault:getInstance():getFloatForKey(UserDefaultKeyWord.voiceChatSpeakerVolume, 1.0)
	self:setSpkVolume(currentSpeakerVolume)
	-- local isSpeakerMuted = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.voiceChatSpeakerMuted, true)
	local isSpeakerMuted = true
	self:setMuteSpeaker(isSpeakerMuted, false, false)

	-- 还原录音设置
	-- local currentMicVolume = cc.UserDefault:getInstance():getFloatForKey(UserDefaultKeyWord.voiceChatMicVolume, 1.0)
	local currentMicVolume = 0
	self:setMicVolume(currentMicVolume)
	local isMicMuted = true--cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.voiceChatMicMuted, true)
	self:setMuteMic(isMicMuted, false, false)
end

-- 重新把设置应用到Agora
function VoiceChatManager:reapplyCurrentSettings()
	self:setSpkVolume(currentSpeakerVolume)
	self:setMuteSpeaker(isSpeakerMuted, false, false)
	self:setMicVolume(currentMicVolume)
	self:setMuteMic(isMicMuted, false, false)
end

-- 检查权限是否和启动时一样, 不一样就重启游戏刷新(统一iOS和安卓一部分异常行为)
function VoiceChatManager:isMicPermissionDenied()
	if (isMicDeniedOverride == true) then 
		return true
	end
	local isMicDeniedNow = AvalonUtil:isMicPermissionDenied()
	-- if (isMicDeniedWhenInit ~= nil and isMicDeniedNow ~= isMicDeniedWhenInit) then
	-- 	Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
	-- 	cc.Director:getInstance():restart()
	-- end
	return isMicDeniedNow
end