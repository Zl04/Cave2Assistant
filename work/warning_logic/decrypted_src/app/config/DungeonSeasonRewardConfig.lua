

Config = Config or {}


local DungeonSeasonRewardConfig = {}
Config.DungeonSeasonRewardConfig = DungeonSeasonRewardConfig 

-- 缓存配置数据
local DataCache = nil

function DungeonSeasonRewardConfig:getAllRewardConfig()
    if (not DataCache) then
        local list = require("profiles/commonProfile/ProfileDungeonSeasonReward")
        assert(type(list) == "table", "[ERROR] DungeonSeasonRewardConfig DataCache: could not get all the DungeonSeasonRewardConfig config.")
        DataCache = {}
        for k,v in pairs(list) do
            if type(v) == "table" and v.ID then
                table.insert(DataCache, v)
            end
        end
    end
    return DataCache
end

function DungeonSeasonRewardConfig:getDungeonSeasonRewardById(seasonID)
    local allData = self:getAllRewardConfig()
    for k, v in pairs(allData) do
        if v.ID == seasonID then
            return v
        end
    end
end

-- 清理
function DungeonSeasonRewardConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileDungeonSeasonReward")
    DataCache = nil
end