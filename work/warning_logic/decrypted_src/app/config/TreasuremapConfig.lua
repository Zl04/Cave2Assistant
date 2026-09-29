

Config = Config or {}


local TreasuremapConfig = {}
Config.TreasuremapConfig = TreasuremapConfig 

-- 缓存效果配置数据
local TreasuremapConfigDataCache = nil

local FragmentConfigDataCache = nil

function TreasuremapConfig:getAllTreasuremapConfig()
    -- 获取所有技能
    if (not TreasuremapConfigDataCache) then
        TreasuremapConfigDataCache = require("profiles/commonProfile/ProfileTreasureMap")
        
        assert(type(TreasuremapConfigDataCache) == "table", "[ERROR] TreasuremapConfig getAllTreasuremapConfig: could not get all the TreasuremapConfig config.")
    end
    return TreasuremapConfigDataCache
end

-- 清理
function TreasuremapConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileTreasureMap")
    reload_script_file("profiles/commonProfile/ProfileVirtualGoods")
    TreasuremapConfigDataCache = nil
    FragmentConfigDataCache = nil
end

function TreasuremapConfig:getTreasuremapConfig(ID)
    ID = tonumber(ID)
    --print("Get skill config skillID=", skillGroupID)
    -- TODO 根据skill id 获取配置文件
    local allTreasuremapConfig = self:getAllTreasuremapConfig()
    return allTreasuremapConfig[ID]
end


function TreasuremapConfig:getTreasuremapList()
    local TreasuremapConfigData = self:getAllTreasuremapConfig();
    local data = {}
    for k,v in pairs(TreasuremapConfigData) do
        if type(v) == "table" and v.ID then
            table.insert(data,v)
        end
    end
    return data
end

-- 获取所有碎片配置
function TreasuremapConfig:getAllFragmentConfig()
    -- 获取所有技能
    if (not FragmentConfigDataCache) then
        FragmentConfigDataCache = require("profiles/commonProfile/ProfileVirtualGoods")
        
        assert(type(FragmentConfigDataCache) == "table", "[ERROR] TreasuremapConfig ProfileVirtualGoods: could not get all the ProfileVirtualGoods config.")
    end
    return FragmentConfigDataCache
end
-- 获取碎片配置表数据
function TreasuremapConfig:getFragmentList()
    local TreasuremapConfigData = self:getAllFragmentConfig();
    local data = {}
    for k,v in pairs(TreasuremapConfigData) do
        if type(v) == "table" and v.ID then
            table.insert(data,v)
        end
    end
    return data
end