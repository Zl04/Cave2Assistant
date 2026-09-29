--
-- Author: ydli
-- Date: 2018-05-10 14:00:01
--
local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}

local QuickChatConfig = {}
Config.QuickChatConfig = QuickChatConfig 

-- 缓存效果配置数据
local QuickChatDataCache = nil

function QuickChatConfig:getAllQuickChatData()
    -- 考虑这里是否做全局缓存
    if (not QuickChatDataCache) then
    -- 获取所有技能
        local list = require("profiles/dataProfile/ProfileClientQuickChat")
        -- 处理里面字段的替换
        QuickChatDataCache = {}
        for k,v in pairs(list) do
            if (type(v) == "table") then
                v.description = LanguageManager:getInstance():getLocalString(v.description)
                table.insert(QuickChatDataCache, v)
            end
        end
    end
    return QuickChatDataCache
end

function QuickChatConfig:getQuickChatDataById(id)
    local list = self:getAllQuickChatData()
    for k, v in ipairs(list) do
        if k == id then
            return v.description
        end
    end
    return ""
end

function QuickChatConfig:clear()
    reload_script_file("profiles/dataProfile/ProfileClientQuickChat")
    QuickChatDataCache = nil
end