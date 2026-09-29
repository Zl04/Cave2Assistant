--[[
    梦境挑战相关配置文件
]]--

local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local DreamTaskConfig = {}
Config.DreamTaskConfig = DreamTaskConfig

-- 缓存效果配置数据
local DreamDataCache = nil

-- 根据效果id获取配置数据
function DreamTaskConfig:getDreamTaskById(id)
    if (not DreamDataCache) then
    -- 获取所有技能
        local list = require("profiles/commonProfile/ProfileDreamChallengeTask")
        -- 处理里面字段的替换
        DreamDataCache = {}
        for k,v in pairs(list) do
            if (type(v) == "table") then
                v.taskName = LanguageManager:getInstance():getLocalString(v.taskName)
                v.taskDesc = LanguageManager:getInstance():getLocalString(v.taskDesc)
                -- if v.type == PublicDefine.DreamTaskType.DreamTaskType_TIME then
                --     v.taskDesc = string.format(mode, v.target1, v.target2)
                -- elseif v.type == PublicDefine.DreamTaskType.DreamTaskType_HP then
                --     v.taskDesc = string.format(mode, v.target1, v.target2)
                -- elseif v.type == PublicDefine.DreamTaskType.DreamTaskType_HPKEEP then
                --     v.taskDesc = string.format(mode, v.target1, v.target2)
                -- elseif v.type == PublicDefine.DreamTaskType.DreamTaskType_CONTROL then
                --     v.taskDesc = string.format(mode, v.target1, v.target2)
                -- elseif v.type == PublicDefine.DreamTaskType.DreamTaskType_ITEMUSED then
                --     v.taskDesc = string.format(mode, v.target1, v.target2)
                -- else
                --     v.taskDesc = mode
                -- end
                table.insert(DreamDataCache, v)
            end
        end
    end

    return DreamDataCache[id]
end

-- 清理
function DreamTaskConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileDreamChallengeTask")
    DreamDataCache = nil
end