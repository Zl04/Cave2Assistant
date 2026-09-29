-- 模块初始化 --
--------------------------------------------
require "utils.message.MessageCenter"
require "app.utils.PlaceholderUtil"
require "app.datas.PublicDefine"
require "app.datas.RoleDataManager"
require "app.datas.MasterDataManager"
require "app.game.GameManager"
require "app.game.GameDataManager"

local SdkBox = require "utils.sdkbox.SdkBox"
local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")
local LanguageManager = require("app.game.LanguageManager")

PushUtil = PushUtil or {}
--------------------------------------------
-- 模块初始化 --









-- 资源 --
--------------------------------------------
local NOTI_AUTH_REQ_LOTTERY_DIALOG_ID = 100036
local NOTI_AUTH_REQ_BLACK_STORE_DIALOG_ID = 100037
local NOTI_AUTH_REQ_GEM_DIALOG_ID = 100161

-- local LOTTERY_PUSH_TEXT = "HEY #name，今天的免费抽奖又开始了，你还在等什么>>"
-- local BLACK_STORE_PUSH_TEXT = "HEY #name，今天的商店又有了新的货品，快来看看吧>>"
-- local AFTER48_PUSH_TEXT = "#name, 你的小伙伴们已经组好队在等你了，今天的洞窟看上去非常热闹>>"

-- local LOTTERY_PUSH_TEXT = LanguageManager:getInstance():getLocalString(1111010)
-- local BLACK_STORE_PUSH_TEXT = LanguageManager:getInstance():getLocalString(1111011)
-- local AFTER48_PUSH_TEXT = LanguageManager:getInstance():getLocalString(1111012)

local gemShopIDToTexts = {
	[101] = LanguageManager:getInstance():getLocalString(1111402),
	[102] = LanguageManager:getInstance():getLocalString(1111403),
	[103] = LanguageManager:getInstance():getLocalString(1111404),
}
local LOTTERY_PUSH_TEXT = LanguageManager:getInstance():getLocalString(1111405)
local AFTER48_PUSH_TEXT = LanguageManager:getInstance():getLocalString(1111406)
local AFTER120_PUSH_TEXT = LanguageManager:getInstance():getLocalString(1111407)
local AFTER168_PUSH_TEXT = LanguageManager:getInstance():getLocalString(1111408)
local AFTER240_PUSH_TEXT = LanguageManager:getInstance():getLocalString(1111420)
local TITLE_TEXT = LanguageManager:getInstance():getLocalString(1111216)
--------------------------------------------
-- 资源 --









-- 程序逻辑 --
--------------------------------------------
-- 内部方法 --
local function round(self, num)
	return math.floor(num + 0.5)
end

local function getServerDate(self)
	return os.date("!*t", GameManager:getNowServerTime())
end

local function getServerTime(self)
	return os.time(getServerDate(self))
end

-- 内部方法, 获取现在到XX小时后的下一个的时间差
local function getDeltaSecToNextTimeInDayAfterHours(self, targetTime, shiftHours, useServerTime)
	assert(targetTime >= 0 and targetTime < 24)
	if (useServerTime == nil) then useServerTime = true end
	-- 从服务器时区时间获得一天中的时间
	local nowDate = useServerTime and getServerDate(self) or os.date("*t", os.time())
	local nowSecInDay = nowDate.hour * SECONDS_ONE_HOUR + nowDate.min * 60 + nowDate.sec

	-- 从一天中的时间获得下一次距离到达目标时间点的时间差
	local deltaToTarget = targetTime / 24 * SECONDS_ONE_DAY - nowSecInDay
	-- 如果还未到目标时间就选取今天的目标时间, 如果已经过了目标时间就选取明天的目标时间
	local deltaToTargetNext = deltaToTarget > 0 and deltaToTarget or deltaToTarget + SECONDS_ONE_DAY
	-- 加偏移时间, 返回现在与偏移时间后的第一个目标时间之间的时间差
	return deltaToTargetNext + shiftHours * SECONDS_ONE_HOUR
end

local function getLocalHourInDayAfterSeconds(self, seconds)
	local nowDate =  os.date("*t", os.time() + seconds)
	return nowDate.hour
end

-- 内部方法, 从服务器一天中的时间转为本地一天中的时间, 只会向前转换
local function getLocalHourInDayFromServerHourInDay(self, serverHourInDay)
	-- 从服务器时区时间获得一天中的时间
	local localDate = os.date("*t", os.time())
	local localSecInDay = localDate.hour * SECONDS_ONE_HOUR + localDate.min * 60 + localDate.sec
	local targetSecInDay = localSecInDay + getDeltaSecToNextTimeInDayAfterHours(self, serverHourInDay, 0)
	local targetHourInDay = round(self, targetSecInDay / SECONDS_ONE_HOUR) % 24
	return targetHourInDay
end

-- 内部方法, 获取黑商刷新小时列表
local function getValidBlackStoreRefreshTimeListInServerTime(self)
	-- 获取配置的黑商刷新时间
	local refresTimeStr = ConfigManager:getBlackRefreshTime()
    local splitArr = string.split(refresTimeStr, ";")

    -- 计算本地刷新时间
    local refreshTimeArr = {}
    for _,str in pairs(splitArr) do
    	-- 从UTC-0时间计算本地时间
    	local serverHour = tonumber(str)
    	local localHour = getLocalHourInDayFromServerHourInDay(self, serverHour)
    	-- 00:00 - 10:00 之间的时间不算入推送时间
    	if (localHour >= 10) then table.insert(refreshTimeArr, serverHour) end
    end

	return refreshTimeArr
end

-- 内部方法, 获取抽奖刷新时间 (目前为服务器0时)
local function getLotteryHourInServerTime(self)
	return 0
end

local function getLotteryHourInLocalTime(self)
	return getLocalHourInDayFromServerHourInDay(self, getLotteryHourInServerTime(self))
end

-- 内部方法, 显示对话框并在对话框结束后请求授权本地推送
-- 参数: 配置好的对话框ID
local function requestNotiAuthWithDialog(self, dialogId, callback)
    -- 检查是否已经申请授权过了
    if (self:isAuthenticated()) then return end

    -- 如果没有就显示对话框进行申请推送授权
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, dialogId, function() 
        SdkBox:getInstance():notificationAuthentication()
        cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.IsNotificationAuthenticationRequested, true)
        if (callback) then callback() end
    end)
end

-- 内部方法, 检查推送时间
local function isWithinPushingHour(self, hour, includeStart, includeEnd)
	local startHour = 22
	local endHour = 8
	if (includeStart and startHour == hour) then startHour = startHour - 1 end
	if (includeEnd and endHour == hour) then endHour = endHour + 1 end
	if (hour >= startHour or hour <= endHour) then 
		return false
	end
	return true
end

-- 内部方法, 检查推送偏移量是否在10分钟之内
local function isWithin10Minutes(offsetList, offset)
	-- for i,v in ipairs(offsetList) do
	-- 	if (offset >= v - 300 and offset <= v + 300) then
	-- 		return true
	-- 	end
	-- end
	-- return false

	-- 暂时不判断10分钟内推送
	return false
end










function PushUtil:requestNotiPremission()
	if (self:isAuthenticated()) then return end
	SdkBox:getInstance():notificationAuthentication()
end

-- 公共方法 --
function PushUtil:isAuthenticated()
	return cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.IsNotificationAuthenticationRequested, false)
end

-- 显示抽奖对话框并请求推送权限
function PushUtil:requestNotiAuthWithLotteryDialog(callback)
	requestNotiAuthWithDialog(self, NOTI_AUTH_REQ_LOTTERY_DIALOG_ID, callback)
end

-- 显示黑商对话框并请求推送权限
function PushUtil:requestNotiAuthWithBlackShopDialog(callback)
	requestNotiAuthWithDialog(self, NOTI_AUTH_REQ_BLACK_STORE_DIALOG_ID, callback)
end

-- 显示符文对话框并请求推送权限
function PushUtil:requestNotiAuthWithGemDialog(callback)
	requestNotiAuthWithDialog(self, NOTI_AUTH_REQ_GEM_DIALOG_ID, callback)
end

-- 清除所有的通知和气泡
function PushUtil:removeAllLocalNotifications()
	SdkBox:getInstance():removeAllLocalNotifications()
end

-- 根据不同的目标设置消息推送
function PushUtil:setupNotifications()
	self:removeAllLocalNotifications()
	local offsetList = {}
	self:setupLotteryNotification(offsetList)
	-- self:setupBlackStoreNotification(offsetList)
	self:setupGemNotification(offsetList)
	self:setupLeaveNotification(offsetList)
end

-- 设置抽奖推送
function PushUtil:setupLotteryNotification(offsetList)
	-- 如果未解锁, 什么都不做, 直接返回
	if (not FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.LUCKYWHEEL_TURN)) then 
		return 
	end

	-- 替换文字里的占位符
	local pushText = PlaceholderUtil:parseMasterName(LOTTERY_PUSH_TEXT)

	-- 判断推送时间
	local hourInDay = getLotteryHourInLocalTime(self)
	if (not isWithinPushingHour(self,hourInDay)) then return end

	-- 推送
	local offset = getDeltaSecToNextTimeInDayAfterHours(self, getLotteryHourInServerTime(self), 0 --[[i * 24]])
	if (not isWithin10Minutes(offsetList, offset)) then
		table.insert(offsetList, offset)
		SdkBox:getInstance():addLocalNotification(
			TITLE_TEXT,
			pushText,
			offset,
			1
		)
	end
end

-- 设置黑商推送
function PushUtil:setupBlackStoreNotification(offsetList)
	-- 如果未解锁, 什么都不做, 直接返回
	if (not FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.BLACK_MARKET)) then 
		return 
	end

	-- 获取一天以内的抽奖刷新时间 (0-10点之间的不算)
	local validTimeList = getValidBlackStoreRefreshTimeListInServerTime(self)

	-- 替换文字里的占位符
	local pushText = PlaceholderUtil:parseMasterName(BLACK_STORE_PUSH_TEXT)

	-- 连续三天自动推送
	for j=0,2 do
		for i,v in ipairs(validTimeList) do
			local offset = getDeltaSecToNextTimeInDayAfterHours(self, v, 24*j)
			if (not isWithin10Minutes(offsetList, offset)) then
				table.insert(offsetList, offset)
				SdkBox:getInstance():addLocalNotification(
					TITLE_TEXT,
					pushText,
					offset,
					2
				)
			end
		end
	end
end

-- 设置符文宝石推送
function PushUtil:setupGemNotification(offsetList)
	-- 如果未解锁, 什么都不做, 直接返回
	if (not FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.GEMSTONE_BUY)) then 
		return 
	end

	local gemConfigs = ConfigManager:getAllGemStoneShopData()
	for id, cfgData in pairs(gemConfigs) do
		-- 循环每个可以购买的宝石配置
		local netData = MasterDataManager:getOneGemstoneShopRecordById(cfgData.ID)
		local pushText = gemShopIDToTexts[cfgData.ID]
		if (netData and pushText) then
			-- 替换文字里的占位符
			pushText = PlaceholderUtil:parseMasterName(pushText)

			-- 计算免费时间到现在的时间差
			local secondsToNotice = netData.freeSec - GameManager:getNormalServerTime()

			-- 如果已经免费, 默认在下一个晚上6点推送
			if (secondsToNotice <= 0) then
				secondsToNotice = getDeltaSecToNextTimeInDayAfterHours(self, 18, 0, false)
			end

			-- 判断推送时间
			local hourInDay = getLocalHourInDayAfterSeconds(self, secondsToNotice)
			if (isWithinPushingHour(self, hourInDay, nil, true)) then
				-- 推送
				local offset = secondsToNotice
				if (not isWithin10Minutes(offsetList, offset)) then
					table.insert(offsetList, offset)
					SdkBox:getInstance():addLocalNotification(
						TITLE_TEXT,
						pushText,
						offset,
						6 + cfgData.ID -- 消息ID不应该和其他消息重叠
					)
				end
			end
		end
	end
end

-- 设置下线延迟推送
function PushUtil:setupLeaveNotification(offsetList)
	-- -- 替换文字里的占位符
	local pushText = PlaceholderUtil:parseMasterName(AFTER48_PUSH_TEXT)
	local offset = getDeltaSecToNextTimeInDayAfterHours(self, 12, 48, false)
	table.insert(offsetList, offset)
	SdkBox:getInstance():addLocalNotification(
		TITLE_TEXT,
		pushText,
		offset,
		3
	)
	
	local pushText = PlaceholderUtil:parseMasterName(AFTER120_PUSH_TEXT)
	local offset = getDeltaSecToNextTimeInDayAfterHours(self, 12, 120, false)
	table.insert(offsetList, offset)
	SdkBox:getInstance():addLocalNotification(
		TITLE_TEXT,
		pushText,
		offset,
		4
	)

	local pushText = PlaceholderUtil:parseMasterName(AFTER168_PUSH_TEXT)
	local offset = getDeltaSecToNextTimeInDayAfterHours(self, 12, 168, false)
	table.insert(offsetList, offset)
	SdkBox:getInstance():addLocalNotification(
		TITLE_TEXT,
		pushText,
		offset,
		5
	)

	local pushText = PlaceholderUtil:parseMasterName(AFTER240_PUSH_TEXT)
	local offset = getDeltaSecToNextTimeInDayAfterHours(self, 12, 240, false)
	table.insert(offsetList, offset)
	SdkBox:getInstance():addLocalNotification(
		TITLE_TEXT,
		pushText,
		offset,
		6
	)
end

-- 显示游戏内消息
function PushUtil:showInAppPushMessage(label, callback)
	SdkBox:getInstance():onInAppMessageClosed(callback)
	SdkBox:getInstance():showInAppPushMessage(label)
end
--------------------------------------------
-- 程序逻辑 --





return PushUtil
