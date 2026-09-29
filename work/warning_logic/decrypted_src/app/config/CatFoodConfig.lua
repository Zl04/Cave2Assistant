local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}


local CatFoodConfig = {}
Config.CatFoodConfig = CatFoodConfig 

-- 缓存效果配置数据
local CatFoodConfigDataCache = nil

function CatFoodConfig:getCatFoodConfigConfig()
    if (not CatFoodConfigDataCache) then
        local catFoodConfig = require("profiles/commonProfile/ProfileCatFood")
        
        assert(type(catFoodConfig) == "table", "[ERROR] CatFoodConfigDataCache CatFoodConfigDataCache: could not get all the CatFoodConfigDataCache config.")

        CatFoodConfigDataCache = {}
        for k,v in pairs(catFoodConfig) do
            if type(v) == "table" and v.ID then
                v.name = LanguageManager:getInstance():getLocalString(v.name)
                table.insert(CatFoodConfigDataCache, v)
            end
        end
    end
    return CatFoodConfigDataCache
end

function CatFoodConfig:getCatFoodConfigDataConfig(ID)
    local allTreasuremapConfig = self:getCatFoodConfigConfig()
    return allTreasuremapConfig[ID]
end

function CatFoodConfig:getCatFoodList()
    return self:getCatFoodConfigConfig()
end

-- 清理
function CatFoodConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileCatFood")
    CatFoodConfigDataCache = nil
end