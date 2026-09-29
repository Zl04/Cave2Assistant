--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:CMonk
    time:2019-05-07 22:42:46
]]

-- 模块初始化 --
--------------------------------------------
require "app.game.GameManager"
require "app.game.ChatManager"
require "utils.Scheduler"
require "utils.message.MessageCenter"

local LanguageManager = require("app.game.LanguageManager")

GoalUtil = GoalUtil or {}
--------------------------------------------
-- 模块初始化 --



-- 程序逻辑 --
--------------------------------------------
-- 设置展现更新
function GoalUtil:updateVisual()
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end

-- 设置目标关闭推送
function GoalUtil:closePush()
    Game.ChatManager:getInstance():sendSystemMsg(LanguageManager:getInstance():getLocalString(1112017) --[["你的《入门守则》已过期"]], ChatMessageType.SYSTEM_MESSAGE)
end

-- 为所有目标关闭预设
function GoalUtil:scheduleGoalCloseNotifications()
    local timeNow = GameManager:getNormalServerTime()
    for k,goal in pairs(mvc.sevenDaysModel:getGoalTable()) do
        if (goal.closeTimeStamp and timeNow < goal.closeTimeStamp) then
            Avalon.Scheduler:setDelayForUpdateOnce(self, self.closePush, goal.closeTimeStamp - timeNow)
            Avalon.Scheduler:setDelayForUpdateOnce(self, self.updateVisual, goal.closeTimeStamp - timeNow + 0.5)
        end
    end
end
--------------------------------------------
-- 程序逻辑 --


return GoalUtil
