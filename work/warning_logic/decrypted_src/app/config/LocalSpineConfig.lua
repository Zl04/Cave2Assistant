Config = Config or {}

local LocalSpine = {}
Config.LocalSpine = LocalSpine

-- 缓存效果配置数据
local LocalSpineDataCache = nil

function LocalSpine:getAllConfig()
    if not LocalSpineDataCache then
        LocalSpineDataCache = require("clientConfig/LocalSpineConfig")
    end

    return LocalSpineDataCache
end

function LocalSpine:getValueForKey(key)
    local generalData = self:getAllConfig()
    
    return generalData[key]
end


-- 清理
function LocalSpine:clear()
    LocalSpineDataCache = nil
end