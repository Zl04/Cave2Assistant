-- FunnyRecordConfig.lua
-- Author: ydli
-- Date: 2017-11-16
--趣味数配置表
--
local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}

local FunnyRecordConfig = {}
Config.FunnyRecordConfig = FunnyRecordConfig 

-- 缓存效果配置数据
local FunnyRecordDataCache = nil

function FunnyRecordConfig:getAllFunnyRecord()
    if (not FunnyRecordDataCache) then
        FunnyRecordDataCache = {}
        local cfgList = require("profiles/dataProfile/ProfileClientFunnyRecord")
        -- 处理里面字段的替换
        for k,v in pairs(cfgList) do
            if (type(v) == "table") then
                local data = {}
                data.id = v.ID
                -- 处理多语言转换
                data.name = LanguageManager:getInstance():getLocalString(v.name)
                data.icon = v.icon
                data.types = v.type
                table.insert(FunnyRecordDataCache, data)
            end
        end
    end
    return FunnyRecordDataCache
end


function FunnyRecordConfig:clear()
    reload_script_file("profiles/dataProfile/ProfileClientFunnyRecord")
    FunnyRecordDataCache = nil
end