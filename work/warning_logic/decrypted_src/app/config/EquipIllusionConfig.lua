

Config = Config or {}


local EquipIllusionConfig = {}
Config.EquipIllusionConfig = EquipIllusionConfig 

-- 缓存效果配置数据
local EquipIllusionConfigCache = nil

function EquipIllusionConfig:getAllEquipIllusions()
    -- 获取所有幻化
    if (not EquipIllusionConfigCache) then
        EquipIllusionConfigCache = require("profiles/commonProfile/ProfileEquipIllusion")
        
        assert(type(EquipIllusionConfigCache) == "table", "[ERROR] EquipIllusionConfig getAllEquipIllusions: could not get all the EquipIllusionConfig config.")
    end
    return EquipIllusionConfigCache
end


-- 根据ID获取幻化配置属性
function EquipIllusionConfig:getEquipIllusionByID(ID)
    local allEquipIllusions = self:getAllEquipIllusions()

    return allEquipIllusions[tonumber(ID)]
end


-- 清理
function EquipIllusionConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileEquipIllusion")
    EquipIllusionConfigCache = nil
end