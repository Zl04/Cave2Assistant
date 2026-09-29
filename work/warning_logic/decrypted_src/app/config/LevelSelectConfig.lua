--
-- Author: ydli
-- Date: 2018-05-10 14:00:01
--
local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}

local LevelSelectData = {}
Config.LevelSelectData = LevelSelectData 

-- 缓存效果配置数据
local LevelSelectDataCache = nil

function LevelSelectData:getAllLevelSelectData()
    -- 考虑这里是否做全局缓存
    if (not LevelSelectDataCache) then
    -- 获取所有技能
        local list = require("profiles/commonProfile/ProfileMisty")
        -- 处理里面字段的替换
        LevelSelectDataCache = {}
        local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
        for k,v in pairs(list) do
            if (type(v) == "table") then
                v.name = LanguageManager:getInstance():getLocalString(v.name)
                local tempList = {}
                for k2, v2 in ipairs(v.includeLevel) do
                    local caveLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(v2)
                    table.insert(tempList, caveLevel)
                end
                v.includeLevel = tempList
                table.insert(LevelSelectDataCache, v)
            end
        end
    end
    
    return LevelSelectDataCache
end

function LevelSelectData:clear()
    reload_script_file("profiles/commonProfile/ProfileMisty")
    LevelSelectDataCache = nil
end