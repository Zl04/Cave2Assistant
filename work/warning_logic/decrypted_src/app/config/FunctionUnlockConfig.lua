

Config = Config or {}


local FunctionUnlockConfig = {}
Config.FunctionUnlockConfig = FunctionUnlockConfig 

-- 缓存配置数据
local DataCache = nil

function FunctionUnlockConfig:getAllFunctionUnlockConfig()
    if (not DataCache) then
        local list = require("profiles/commonProfile/ProfileFunctionUnlock")
        assert(type(list) == "table", "[ERROR] ProfileFunctionUnlock DataCache: could not get all the ProfileFunctionUnlock config.")
        DataCache = {}
        for k,v in pairs(list) do
            if type(v) == "table" and v.ID then
                DataCache[v.ID] = v
            end
        end
    end
    return DataCache
end

function FunctionUnlockConfig:getFunctionUnlockCfgData(functionType)
    local dataMap = self:getAllFunctionUnlockConfig()
    -- dump(dataMap, "------------FunctionUnlockConfig:getFunctionUnlockCfgData(functionType) = "..functionType)
    return dataMap[functionType]
end

function FunctionUnlockConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileFunctionUnlock")
    DataCache = nil
end