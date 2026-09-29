-- 目标配置

Config = Config or {}

local TargetConfig = {}
Config.TargetConfig = TargetConfig 

-- 缓存效果配置数据
local TargetConfigDataCache = nil

function TargetConfig:getAllTargetConfig()
    if (not TargetConfigDataCache) then
        TargetConfigDataCache = require("profiles/commonProfile/ProfileTarget")
    end
    return TargetConfigDataCache
end

-- 根据ID获取数据
function TargetConfig:getTargetConfigById(id)
    local all = self:getAllTargetConfig()

    local TargetConfig = all[id]

    return TargetConfig
end

function TargetConfig:random()
    local all = self:getAllTargetConfig()
    local max = all.size
    local r = math.random( 1,max )
    local w = all[r]
    return w
end

function TargetConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileTarget")
    TargetConfigDataCache = nil
end