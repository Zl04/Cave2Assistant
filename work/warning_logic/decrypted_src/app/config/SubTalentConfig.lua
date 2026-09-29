--
-- Author: ydli
-- Date: 2019-01-04
--
local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}

local SubTalentConfig = {}
Config.SubTalentConfig = SubTalentConfig 

-- 缓存效果配置数据
local DataCache = nil

function SubTalentConfig:getAllSubTalentData()
    -- 考虑这里是否做全局缓存
    if (not DataCache) then
    -- 获取所有技能
        local list = require("profiles/commonProfile/ProfileTalent")
        -- 处理里面字段的替换
        DataCache = {}
        for k,v in pairs(list) do
            if (type(v) == "table") then
                v.desc = LanguageManager:getInstance():getLocalString(checkint(v.desc))
                v.name = LanguageManager:getInstance():getLocalString(checkint(v.name))
                table.insert(DataCache, v)
            end
        end
    end
    return DataCache
end

function SubTalentConfig:getSubTalentById(id)
    local list = self:getAllSubTalentData()
    for k, v in ipairs(list) do
        if v.ID == id then
            return v
        end
    end
    return nil
end

function SubTalentConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileTalent")
    DataCache = nil
end