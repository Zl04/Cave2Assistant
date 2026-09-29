--
-- Author: ydli
-- Date: 2019-01-04
--
local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}

local MainTalentConfig = {}
Config.MainTalentConfig = MainTalentConfig 

-- 缓存效果配置数据
local DataCache = nil

function MainTalentConfig:getAllMainTalentData()
    -- 考虑这里是否做全局缓存
    if (not DataCache) then
    -- 获取所有技能
        local list = require("profiles/commonProfile/ProfileMainTalent")
        -- 处理里面字段的替换
        DataCache = {}
        for k,v in pairs(list) do
            if (type(v) == "table") then
                v.skillName = LanguageManager:getInstance():getLocalString(checkint(v.skillName))
                v.name = LanguageManager:getInstance():getLocalString(checkint(v.name))
                v.skillDesc = LanguageManager:getInstance():getLocalString(checkint(v.skillDesc))
                table.insert(DataCache, v)
            end
        end
    end
    return DataCache
end

function MainTalentConfig:getMainTalentDataById(id)
    local list = self:getAllMainTalentData()
    for k, v in ipairs(list) do
        if v.ID == id then
            return v
        end
    end
    return nil
end

function MainTalentConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileMainTalent")
    DataCache = nil
end