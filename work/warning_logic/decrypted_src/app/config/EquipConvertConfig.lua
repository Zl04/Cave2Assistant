--
-- Author: 岳溁松
-- Date: 2017-10-25 14:00:01
--
Config = Config or {}

local EquipConvert = {}
Config.EquipConvert = EquipConvert 

-- 缓存效果配置数据
local EquipConvertDataCache = nil

function EquipConvert:getAllEquipConvert()
    -- 考虑这里是否做全局缓存
    if (not EquipConvertDataCache) then
        EquipConvertDataCache = require("profiles/commonProfile/ProfileEquipConvert")
    end
    
    return EquipConvertDataCache
end


function EquipConvert:getEquipConvert(id)
    local all = self:getAllEquipConvert()

    local task = all[id]

    return task
end

function EquipConvert:getEquipIdByConvertEquipId(conventId)
    self:getAllEquipConvert()
    for k, v in pairs(EquipConvertDataCache) do

        if k ~= "size" then
            if v.targetEquipID == conventId then
                return k
            end
        end
    end
    return nil
end

function EquipConvert:isEquipCanConvert(id)
    return self:getEquipConvert(id) ~= nil
end
function EquipConvert:clear()
    reload_script_file("profiles/commonProfile/ProfileEquipConvert")
    EquipConvertDataCache = nil
end