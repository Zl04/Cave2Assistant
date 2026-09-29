

Config = Config or {}


local QuickExpressionConfig = {}
Config.QuickExpressionConfig = QuickExpressionConfig 

-- 缓存配置数据
local DataCache = nil

function QuickExpressionConfig:getAllExpressionConfig()
    if (not DataCache) then
        local list = require("profiles/dataProfile/ProfileClientExpression")
        assert(type(list) == "table", "[ERROR] QuickExpressionConfig DataCache: could not get all the QuickExpressionConfig config.")
        DataCache = {}
        for k,v in pairs(list) do
            if type(v) == "table" and v.ID then
                table.insert(DataCache, v)
            end
        end
    end
    return DataCache
end

-- 清理
function QuickExpressionConfig:clear()
    reload_script_file("profiles/dataProfile/ProfileClientExpression")
    DataCache = nil
end