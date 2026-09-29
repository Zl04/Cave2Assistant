
Config = Config or {}


local EquipStrengthenConfig = {}
Config.EquipStrengthenConfig = EquipStrengthenConfig 

-- 缓存配置数据
local DataCache = nil

function EquipStrengthenConfig:getAllEquipStrengthenConfig()
    if (not DataCache) then
        local list = require("profiles/commonProfile/ProfileEquipStrengthen")
        assert(type(list) == "table", "[ERROR] ProfileEquipStrengthen DataCache: could not get all the ProfileEquipStrengthen config.")
        DataCache = {}
        for k,v in pairs(list) do
            if type(v) == "table" then
                table.insert(DataCache, v)
            end
        end
    end
    return DataCache
end
function EquipStrengthenConfig:getEquipStrengthenCost(level)
    local allCfg = self:getAllEquipStrengthenConfig() or {}
    
    local cfg = allCfg[level] or {}
    return cfg
end
function EquipStrengthenConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileEquipStrengthen")
    DataCache = nil
end