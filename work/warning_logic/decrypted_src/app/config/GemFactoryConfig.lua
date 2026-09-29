
Config = Config or {}


local GemFactoryConfig = {}
Config.GemFactoryConfig = GemFactoryConfig 

-- 缓存配置数据
local DataCache = nil

function GemFactoryConfig:getAllGemFactoryConfig()
    if (not DataCache) then
        local list = require("profiles/commonProfile/ProfileGSFactory")
        assert(type(list) == "table", "[ERROR] GemFactoryConfig DataCache: could not get all the GemFactoryConfig config.")
        DataCache = {}
        for k,v in pairs(list) do
            if type(v) == "table" and v.ID then
                table.insert(DataCache, v)
            end
        end
    end
    return DataCache
end

function GemFactoryConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileGSFactory")
    DataCache = nil
end