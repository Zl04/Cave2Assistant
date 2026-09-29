
Config = Config or {}


local GoldenMineConfig = {}
Config.GoldenMineConfig = GoldenMineConfig 

-- 缓存配置数据
local DataCache = nil

function GoldenMineConfig:getAllGoldenMineConfig()
    if (not DataCache) then
        local list = require("profiles/commonProfile/ProfileGoldMine")
        assert(type(list) == "table", "[ERROR] GoldenMineConfig DataCache: could not get all the GoldenMineConfig config.")
        DataCache = {}
        for k,v in pairs(list) do
            if type(v) == "table" and v.ID then
                table.insert(DataCache, v)
            end
        end
    end
    return DataCache
end

function GoldenMineConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileGoldMine")
    DataCache = nil
end