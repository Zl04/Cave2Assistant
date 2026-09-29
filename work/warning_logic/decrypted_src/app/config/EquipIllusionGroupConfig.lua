

Config = Config or {}


local EquipIllusionGroupConfig = {}
Config.EquipIllusionGroupConfig = EquipIllusionGroupConfig 

-- 缓存效果配置数据
local EquipIllusionGroupConfigCache = nil

function EquipIllusionGroupConfig:getAllEquipIllusionGroups()
    -- 获取所有幻化
    if (not EquipIllusionGroupConfigCache) then
        EquipIllusionGroupConfigCache = require("profiles/commonProfile/ProfileEquipIllusionGroup")
        
        assert(type(EquipIllusionGroupConfigCache) == "table", "[ERROR] EquipIllusionGroupConfig getAllEquipIllusionGroups: could not get all the EquipIllusionGroupConfig config.")
    end
    return EquipIllusionGroupConfigCache
end


-- 根据ID获取幻化配置属性
function EquipIllusionGroupConfig:getEquipIllusionGroupByID(ID)
    local allEquipIllusionGroups = self:getAllEquipIllusionGroups()

    return allEquipIllusionGroups[tonumber(ID)]
end


-- 清理
function EquipIllusionGroupConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileEquipIllusionGroup")
    EquipIllusionGroupConfigCache = nil
end