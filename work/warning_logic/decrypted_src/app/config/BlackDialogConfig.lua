

Config = Config or {}


local BlackDialogConfig = {}
Config.BlackDialogConfig = BlackDialogConfig 

-- 缓存配置数据
local DataCache = nil

function BlackDialogConfig:getAllDialogEventConfig()
    if (not DataCache) then
        local list = require("profiles/dataProfile/ProfileClientBlackDialogue")
        assert(type(list) == "table", "[ERROR] BlackDialogConfig DataCache: could not get all the BlackDialogConfig config.")
        DataCache = {}
        for k,v in pairs(list) do
            if type(v) == "table" and v.ID then
                table.insert(DataCache, v)
            end
        end
    end
    return DataCache
end

function BlackDialogConfig:clear()
    reload_script_file("profiles/dataProfile/ProfileClientBlackDialogue")
    DataCache = nil
end