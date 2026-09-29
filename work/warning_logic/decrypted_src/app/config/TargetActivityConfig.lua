-- 目标活动配置

Config = Config or {}

local TargetActivityConfig = {}
Config.TargetActivityConfig = TargetActivityConfig 

-- 缓存效果配置数据
local TargetActivityConfigDataCache = nil

function TargetActivityConfig:getAllTargetActivityConfig()
    if (not TargetActivityConfigDataCache) then
        TargetActivityConfigDataCache = require("profiles/commonProfile/ProfileTargetActivity")
    end
    return TargetActivityConfigDataCache
end

-- 根据ID获取数据
function TargetActivityConfig:getTargetActivityConfigById(id)
    local all = self:getAllTargetActivityConfig()

    local TargetActivityConfig = all[id]

    return TargetActivityConfig
end

function TargetActivityConfig:random()
    local all = self:getAllTargetActivityConfig()
    local max = all.size
    local r = math.random( 1,max )
    local w = all[r]
    return w
end

function TargetActivityConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileTargetActivity")
    TargetActivityConfigDataCache = nil
end