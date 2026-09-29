
Config = Config or {}


local HomeTaskConfig = {}
Config.HomeTaskConfig = HomeTaskConfig 

-- 缓存配置数据
local DataCache = nil

function HomeTaskConfig:getAllHomeTaskConfig()
    if (not DataCache) then
        local list = require("profiles/commonProfile/ProfileHomeTask")
        assert(type(list) == "table", "[ERROR] HomeTaskConfig DataCache: could not get all the HomeTaskConfig config.")
        DataCache = {}
        for k,v in pairs(list) do
            if type(v) == "table" and v.ID then
                table.insert(DataCache, v)
            end
        end
    end
    return DataCache
end

function HomeTaskConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileHomeTask")
    DataCache = nil
end