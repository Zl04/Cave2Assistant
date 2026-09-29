

Config = Config or {}


local AudioConfig = {}
Config.AudioConfig = AudioConfig 

-- 缓存效果配置数据
local AudioConfigDataCache = nil

local DEBUG = false

function AudioConfig:getAllAudioConfig()
    -- 获取所有技能
    if (not AudioConfigDataCache) then
        AudioConfigDataCache = require("profiles/dataProfile/ProfileClientSound")        
        assert(type(AudioConfigDataCache) == "table", "[ERROR] AudioConfig getAllAudioConfig: could not get all the AudioConfig config.")
    end
    return AudioConfigDataCache
end

function AudioConfig:getAudioConfig(id)
    if(DEBUG) then
        print("AudioConfig:getAudioConfig",id)
    end
    id = tonumber(id)

    local allAudioConfig = self:getAllAudioConfig()

    return allAudioConfig[id]
end

function AudioConfig:clear()
    AudioConfigDataCache = nil
end