-- 天气系统

Config = Config or {}

local RandAttributeGroup = {}
Config.RandAttributeGroup = RandAttributeGroup 

-- 缓存效果配置数据
local RandAttributeGroupCache = nil

function RandAttributeGroup:getRandAttributeGroupCache()
    if (not RandAttributeGroupCache) then
        RandAttributeGroupCache = {}
        local list = require("profiles/commonProfile/ProfileRandAttributeGroup")
        for k,v in pairs(list) do
            if (type(v) == "table") then
                RandAttributeGroupCache[v.id] = v.value
            end
        end
    end    
    return RandAttributeGroupCache
end

-- 根据任务ID获取任务数据
function RandAttributeGroup:getRandAttributeGroupByKey(key)
    local map = self:getRandAttributeGroupCache()
    local pool = map[key]
    return pool
end


function RandAttributeGroup:clear()
    reload_script_file("profiles/commonProfile/ProfileRandAttributeGroup")
    RandAttributeGroupCache = nil
end
