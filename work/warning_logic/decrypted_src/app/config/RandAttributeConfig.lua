

Config = Config or {}


local RandAttribute = {}
Config.RandAttribute = RandAttribute 

-- 缓存效果配置数据
local RandAttributeDataCache = nil

function RandAttribute:getAllRandAttribute()
    -- 获取所有技能
    if (not RandAttributeDataCache) then
        RandAttributeDataCache = require("profiles/commonProfile/ProfileRandAttribute")
        
        assert(type(RandAttributeDataCache) == "table", "[ERROR] RandAttribute getAllRandAttribute: could not get all the RandAttribute config.")
    end
    return RandAttributeDataCache
end


--根据ID获取随机属性配置
function RandAttribute:getRandAttributeByID(ID)
    --print("Get skill config skillID=", skillGroupID)
    -- TODO 根据id 获取配置文件
    local allRandAttribute = self:getAllRandAttribute()

    return allRandAttribute[tonumber(ID)]
end


-- 清理
function RandAttribute:clear()
    reload_script_file("profiles/commonProfile/ProfileRandAttribute")
    RandAttributeDataCache = nil
end