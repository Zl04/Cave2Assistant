
Config = Config or {}


local GemChangeCostConfig = {}
Config.GemChangeCostConfig = GemChangeCostConfig 

-- 缓存配置数据
local DataCache = nil

function GemChangeCostConfig:getAllGemChangeCostConfig()
    if (not DataCache) then
        local list = require("profiles/commonProfile/ProfileGemChangeCost")
        assert(type(list) == "table", "[ERROR] GemChangeCostConfig DataCache: could not get all the ProfileGemChangeCost config.")
        DataCache = {}
        for k,v in pairs(list) do
            if type(v) == "table" then
                table.insert(DataCache, v)
            end
        end
    end
    return DataCache
end
function GemChangeCostConfig:getCoastByLevel(level)
    local allCfg = self:getAllGemChangeCostConfig() or {}
    
    local cfg = allCfg[level] or {}
    return cfg.goldCost
end

function GemChangeCostConfig:getComposeCostByLevel(level)
    local allCfg = self:getAllGemChangeCostConfig() or {}
    
    local cfg = allCfg[level] or {}
    return cfg.deComposeCost
end

function GemChangeCostConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileGemChangeCost")
    DataCache = nil
end