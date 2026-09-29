--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:CMonk
    time:2019-06-19 01:31:05
]]

-- 模块初始化 --
--------------------------------------------
require "app.game.ChatManager"
require "utils.Scheduler"
require "utils.message.MessageCenter"

local LanguageManager = require("app.game.LanguageManager")
local adultTypeOverride = nil
local loginNoticeShowed = false

AntiAddictionUtil = AntiAddictionUtil or {}
--------------------------------------------
-- 模块初始化 --



-- 程序逻辑 --
--------------------------------------------
-- 获取映射过后的防沉迷类型
function AntiAddictionUtil:getMappedAdultType()
    if (adultTypeOverride) then return adultTypeOverride end
    require "app.utils.ServerConfigUtil"
    -- 映射一下
    local adultType = 5
    local adultTypeRaw = ServerConfigUtil:getAdultType()
    local isGuest = ServerConfigUtil:getIsGuest()
    local age = ServerConfigUtil:getAge()
    if (isGuest) then               -- 游客
        adultType = 1
    elseif (adultTypeRaw == 1) then -- 成年
        adultType = 5
    elseif (adultTypeRaw == 2) then -- 未实名
        adultType = 2
    elseif (age and age < 12) then -- 青少年
        adultType = 3
    elseif (age and age < 18) then  -- 未成年
        adultType = 4
    end
    return adultType
end

-- 显示登陆提示
function AntiAddictionUtil:showLoginNotice()
    if (loginNoticeShowed) then return end

    local limitTime, timeRemaining = MasterDataManager:getAntiData()
    -- 显示提示
    if limitTime ~= 0 and timeRemaining ~= 0 then
        loginNoticeShowed = true
        require("app.ui.notice.RunningLamp")
        local time = string.format("%.2f", limitTime/3600)
        Game.ChatManager:getInstance():insertRunLampData(string.format(LanguageManager:getInstance():getLocalString(1170242), time, math.floor(timeRemaining/60)), 1, true) --"受防沉迷限制，您每日在线时长不得超过%s小时，当前您在线时长还剩%s分钟"
    end
end

-- 15分钟前提示
function AntiAddictionUtil:show15MinNotification()
    Game.ChatManager:getInstance():insertRunLampData(LanguageManager:getInstance():getLocalString(1170243), 1, true) 
end

-- 为15分钟提示预设
function AntiAddictionUtil:scheduleAntiAddictionNotifications()
    local timeOffsetInMin = 15
    local limitTime, timeRemaining = MasterDataManager:getAntiData()
    local timeToOffset = timeRemaining - timeOffsetInMin * 60
    if (timeToOffset > 0) then
        Avalon.Scheduler:setDelayForUpdateOnce(self, self.show15MinNotification, timeToOffset)
    end
end

-- 做登陆动作
function AntiAddictionUtil:doLoginActions()
    if (CAVEOL_TARGET ~= CAVEOL_TARGET_GLOBAL) then
        self:showLoginNotice()
        self:scheduleAntiAddictionNotifications()
    end
end

-- 显示登陆验证错误
function AntiAddictionUtil:showLoginError(errorID)
    require "app.ui.common.Dialog.ScrollBar"
    if (errorID == 998) then
        local adultType = self:getMappedAdultType()
        if (adultType == 1) then
            -- UI.ScrollBar:createByTextID(1170237) --"由于您当前是游客账号，受防沉迷限制无法在当前时段登录"
            local text = LanguageManager:getInstance():getLocalString(1170237) .. LanguageManager:getInstance():getLocalString(1110788)
            local bindTips = UI.Tips:createTips(text, UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
            bindTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                local SdkBox = require("utils.sdkbox.SdkBox")
                SdkBox:getInstance():showAccountCenter()
            end)
            if isOnTopActivityLayer then
                bindTips:setZOrder(UI_ZORDER.MAX)
                bindTips:removeFromParent(false)
                UI.UIManager:addToRootNode(bindTips)
            end
        elseif (adultType == 2) then
            UI.ScrollBar:createByTextID(1170238) --"由于您还未实名认证，受防沉迷限制无法登陆游戏，请尽快实名认证" 
        elseif (adultType == 3) then
            UI.ScrollBar:createByTextID(1170239) --"由于您未满18周岁，受防沉迷限制无法在当前时段登录" 
        elseif (adultType == 4) then
            UI.ScrollBar:createByTextID(1170240) --"由于您未满18周岁，受防沉迷限制无法在当前时段登录" 
        elseif (adultType == 5) then
            UI.ScrollBar:createByTextID(1111118) --"系统错误" 
        end
    elseif (errorID == 999) then
        UI.ScrollBar:createByTextID(1170241) --"您今日在线时长已耗尽，受防沉迷限制您无法登入游戏"
    end
end

-- 检查是否能进洞
function AntiAddictionUtil:isAbleToEnterCave()
    if (CAVEOL_TARGET ~= CAVEOL_TARGET_GLOBAL) then
        require "app.datas.RoleDataManager"
        local masterData = RoleDataManager:getMaster()
        if (not masterData) then return false end
        local inCaveTime = masterData:getInCaveTime() / 1000
        if (not inCaveTime) then return true end
        local limitTime = tonumber(ConfigManager:getGeneralForKey("antiAddictionTimeRefresh")) * 60
        if (not limitTime) then return true end
        return inCaveTime < limitTime
    else
        return true
    end
end

-- 强制设定成人判定
function AntiAddictionUtil:setAntiAddictionOverride(n)
    adultTypeOverride = tonumber(n)
end

-- 清除状态
function AntiAddictionUtil:clear()
    Avalon.Scheduler:unscheduleUpdateOnce(self, self.show15MinNotification)
    loginNoticeShowed = false
end
-- 
--------------------------------------------
-- 程序逻辑 --


return AntiAddictionUtil
