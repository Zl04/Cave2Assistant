-- MonsterAffixConfig.lua
-- Author:zp
-- 2017年4月12日
-- Using:怪物词缀配置

local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local MonsterAffix = {}
Config.MonsterAffix = MonsterAffix

-- 缓存效果配置数据
local MonsterAffixDataCache = nil
-- 处理相关的逻辑处理
local MonsterCoefficientCache = nil

-- 获取所有的效果配置数据
function MonsterAffix:getAllMonsterAffix()
    if (not MonsterAffixDataCache) then
        MonsterAffixDataCache = require("profiles/commonProfile/ProfileMonsterAffix")
        
        assert(type(MonsterAffixDataCache) == "table", "[ERROR] MonsterAffix getAllMonsterAffix: could not get all the MonsterAffix config.")
    end
    return MonsterAffixDataCache
end

function MonsterAffix:getAllMonsterCoefficient()
    if (not MonsterCoefficientCache) then
        MonsterCoefficientCache = require("profiles/commonProfile/ProfileMonsterCoefficient")
        
        assert(type(MonsterCoefficientCache) == "table", "[ERROR] MonsterAffix getAllMonsterAffix: could not get all the MonsterAffix config.")
    end
    return MonsterCoefficientCache
end

-- 根据效果id获取配置数据
function MonsterAffix:getAffix(affixID)
    local allAffixData = self:getAllMonsterAffix()
    if (allAffixData) then
        local affixData = allAffixData[affixID]
        if (affixData) then
            -- 处理多语言解析
            affixData.name = LanguageManager:getInstance():getLocalString(affixData.name)

            return affixData
        else
            assert(false, "[ERROR] MonsterAffix getAffix: could not get MonsterAffix config.")
        end
    end

    return nil
end

-- 获取大秘境倍率逻辑
function MonsterAffix:getCoefficient(level)
    local allCoefficient = self:getAllMonsterCoefficient()
    if(allCoefficient) then 
        return allCoefficient[level]
    end

    return nil
end

-- 清理
function MonsterAffix:clear()
    reload_script_file("profiles/commonProfile/ProfileMonsterAffix")
    reload_script_file("profiles/commonProfile/ProfileMonsterCoefficient")
    MonsterAffixDataCache = nil
    MonsterCoefficientCache = nil
end