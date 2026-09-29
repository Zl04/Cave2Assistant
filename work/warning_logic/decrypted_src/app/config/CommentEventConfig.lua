

Config = Config or {}


local CommentEventConfig = {}
Config.CommentEventConfig = CommentEventConfig 

-- 缓存配置数据
local DataCache = nil

function CommentEventConfig:getAllEventConfig()
    if (not DataCache) then
        local list = require("profiles/dataProfile/ProfileClientcomment")
        assert(type(list) == "table", "[ERROR] CommentEventConfig DataCache: could not get all the CommentEventConfig config.")
        DataCache = {}
        for k,v in pairs(list) do
            if type(v) == "table" and v.ID then
                DataCache[v.ID] = v
            end
        end
    end
    return DataCache
end

function CommentEventConfig:getEventCfgById(eventId)
    local allData = self:getAllEventConfig()
    return allData[eventId]
end

function CommentEventConfig:clear()
    reload_script_file("profiles/dataProfile/ProfileClientcomment")
    DataCache = nil
end