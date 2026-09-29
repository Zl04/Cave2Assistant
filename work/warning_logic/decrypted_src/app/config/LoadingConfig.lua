Config = Config or {}

local Loading = {}
Config.Loading = Loading

-- 缓存效果配置数据
local LoadingDataCache = nil

function Loading:getAllConfig()
    if not LoadingDataCache then
        LoadingDataCache = require("profiles/dataProfile/ProfileClientLoading")
    end

    return LoadingDataCache
end

-- 清理
function Loading:clear()
	reload_script_file("profiles/dataProfile/ProfileClientLoading")
    LoadingDataCache = nil
end