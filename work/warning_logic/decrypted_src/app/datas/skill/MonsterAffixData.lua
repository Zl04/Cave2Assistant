
--[[
    buffer数据
]]

require "app.datas.GameData"

local MonsterAffixData = class("MonsterAffixData",GameData.Base)

Data = Data or {}
Data.MonsterAffixData = MonsterAffixData

-- privte:

-- 构造函数
function MonsterAffixData:ctor(affixID)
    self.super.ctor(self, Category.AFFIX)
    
    if affixID then
        self.affixID = affixID
    end
    self:conbinationLocalData()
end

-- public:
-- 初始化网络数据
function MonsterAffixData:initNet(mesData)
    -- 根据网络数据初始化
    local oldId = self.affixID

    self.affixID = mesData.affixID
    
    if oldId ~= mesData.affixID then
        self:conbinationLocalData()
    end
end

-- 合并网络数据和本地数据
function MonsterAffixData:conbinationLocalData()
    if (self.affixID ~= -1) then
        local data = ConfigManager:getMonsterAffixConfigByID(self.affixID)
        self:setLocalConfigData(data)
    end
end

-- 获取配置数据id
function MonsterAffixData:getID()
    return self.affixID
end

-- 获取词缀名称
function MonsterAffixData:getAffixName()
    return self.name
end


