-- RuneFactoryData.lua
-- Author:CMonk
-- 2018年12月12日

require "app.config.ConfigManager"
require "app.datas.GameData"

local RuneFactoryData = class("RuneFactoryData")

Data = Data or {}
Data.RuneFactoryData = RuneFactoryData

-- required uint32 lv = 1;                         //等级
-- required uint32 output = 3;                     //当前总产量
-- required uint64 activeJobTime = 5;              //激活任务,进入高速状态得起始时间
-- required uint64 beginCalTime = 6;               //计算产量得起始时间

--构造函数(必备)
function RuneFactoryData:ctor()
    self._currentLevel = 1
    self._taskStartTimeStamp = 0
    self._preCalcAmount = 0
    self._calcTimeStamp = 0
    self._taskEquipRarity = {}
    self._taskEquipPart = {}
end

--析构函数, destroy时调用(必备)
function RuneFactoryData:dtor()

end

-- 暂时没有使用
function RuneFactoryData:init(data)

end

-- 从服务器下发的数据, 所有计算都是局域这个数据和配置表里的参数来进行计算
function RuneFactoryData:initNet(data)
    if (not data) then return end

    self._calcTimeStamp = data.beginCalTime or 0
    self._currentLevel = data.lv or 1
    self._preCalcAmount = data.output and data.output / 864000 or 0 --864000是和服务器约定好的一个数值. 配置表里没有小数, 这个数值是为了增加精度.
    self._taskStartTimeStamp = data.activeJobTime or 0
    self._taskEquipRarity = data.equiprarity or {}
    self._taskEquipPart = data.equipPart or {}
end

-- 根据服务器下发数据, 模拟计算返回加速剩余时间
function RuneFactoryData:getBoostTimeRemaining()
    local config = self:getCurrentLevelConfig()
    local remaining = self._taskStartTimeStamp + config.accelerationTime * 60 - GameManager:getNormalServerTime()
    return remaining > 0 and remaining or 0
end

-- 根据服务器下发数据, 模拟计算返回下次任务时间
function RuneFactoryData:getTimeToNextQuest()
    local config = self:getCurrentLevelConfig()
    local remaining = self._taskStartTimeStamp + config.taskResetTime * 60 - GameManager:getNormalServerTime()
    return remaining > 0 and remaining or 0
end

-- 根据服务器下发数据返回现在等级
function RuneFactoryData:getCurrentLevel()
    return self._currentLevel
end

-- 从配置表中读取现在满级数值
function RuneFactoryData:getMaxLevel()
    return Config.Manager:getGemFactoryConfigMaxLv()
end

-- 根据服务器下发数据, 检查是否有任务可做
function RuneFactoryData:getIsQuestAvailable()
    return self:getTimeToNextQuest() <= 0
end

-- 根据服务器下发数据, 计算是否在加速中
function RuneFactoryData:getIsInBoost()
    return self:getBoostTimeRemaining() > 0
end

-- 根据服务器下发数据, 计算下级的基础生产速度
function RuneFactoryData:getBaseSpeedForNextLevel()
    local config = self:getCurrentLevelConfig(1)
    return config and config.unitTimeProduction / 10 or 0
end

-- 根据服务器下发数据和配置表, 计算现在等级的基础速度
function RuneFactoryData:getCurrentBaseSpeed()
    local config = self:getCurrentLevelConfig()
    return config and config.unitTimeProduction / 10 or 0
end

-- 根据服务器下发数据和配置表, 计算现在的加速倍数值
function RuneFactoryData:getCurrentBoostFactor()
    local config = self:getCurrentLevelConfig()
    return config and config.accelerationRate / 100 or 0
end

-- 根据服务器下发数据和配置表, 更新现在加速后比基础数值多出的数值(显示用)
function RuneFactoryData:getCurrentExtraBoostSpeedNumber()
    local extraFactor = self:getCurrentBoostFactor() - 1
    if (extraFactor < 0) then extraFactor = 0 end
    return self:getCurrentBaseSpeed() * extraFactor
end

-- 根据服务器下发数据和配置表, 返回现在包含加速速度值
function RuneFactoryData:getCurrentSpeed()
    local speed = self:getCurrentBaseSpeed()
    if (self:getIsInBoost()) then
        speed = speed * self:getCurrentBoostFactor()
    end
    return speed
end

-- 现在的产出等级
function RuneFactoryData:getCurrentOutputLevel()
    local config = self:getCurrentLevelConfig()
    return config and config.GSLV or nil
end

-- 下一级的产出等级
function RuneFactoryData:getNextLevelOutputLevel()
    local config = self:getCurrentLevelConfig(1)
    return config and config.GSLV or nil
end

-- 根据服务器下发数据, 模拟演算现在的出货量值
function RuneFactoryData:getCurrentSize()
    local deltaTimeInSeconds = GameManager:getNormalServerTime() - self._calcTimeStamp
    if (deltaTimeInSeconds < 0) then
        deltaTimeInSeconds = 0
    end
    local calcSize = self._preCalcAmount + deltaTimeInSeconds / (3600 * 24) * self:getCurrentSpeed()
    calcSize = calcSize > 0 and calcSize or 0
    local maxSize = self:getMaxSize()
    return calcSize > maxSize and maxSize or calcSize
end

-- 根据服务器下发数据和配置表, 计算现在的最大出落量值
function RuneFactoryData:getMaxSize()
    local config = self:getCurrentLevelConfig()
    return config and config.capacity or 0
end

-- 暂时未使用
function RuneFactoryData:getCurrentWorkStatus()
    -- 宠物相关, 暂不使用
    return 0
end

-- 暂时未使用
function RuneFactoryData:getMaxWorkStatus()
    -- 宠物相关, 暂不使用
    return 0
end

-- 根据服务器下发的数据和配置表, 返回现在等级升级需要的材料列表
function RuneFactoryData:getLvUpMaterialList()
    local config = self:getCurrentLevelConfig()
    local materialList = {}
    if (config) then
        for i,v in ipairs(config.upgradeLvCostID) do
            materialList[i] = { id = v }
        end
        for i,v in ipairs(config.upgradeLvCostNum) do
            materialList[i].amount = v
        end
    end
    return materialList
end

-- 根据服务器下发的数据和配置表, 返回现在加速需要的材料列表
function RuneFactoryData:getBoostMaterialList()
    local materialList = {}
    if (#self._taskEquipRarity ~= #self._taskEquipPart) then
        return materialList
    end
    for i,v in ipairs(self._taskEquipRarity) do
        materialList[i] = { rarity = v}
    end
    for i,v in ipairs(self._taskEquipPart) do
        materialList[i].part = v
    end
    return materialList
end

-- 根据服务器下发数据和配置表, 返回现在升级需要的玩家到达最大楼层条件
function RuneFactoryData:getLvUpFloorCondition()
    local config = self:getCurrentLevelConfig()
    return config and config.schedule or nil
end

-- 根据服务器下发数据和配置表, 返回现在升级需要的玩家其他家园功能需要的等级条件
function RuneFactoryData:getLvUpNPCCondition()
    local config = self:getCurrentLevelConfig()
    if (config) then
        return config.preNPCID, config.preNPCLV
    else
        return nil, nil
    end
end

-- 根据服务器下发的数据和配置表, 获取现等级加速的时间
function RuneFactoryData:getCurrentBoostDuration()
    local config = self:getCurrentLevelConfig()
    return config and config.accelerationTime or 0
end

-- 根据服务器下发的数据和配置表, 获取现等级加速任务的间隔时间
function RuneFactoryData:getCurrentQuestInterval()
    local config = self:getCurrentLevelConfig()
    return config and config.taskResetTime or 0
end

-- 根据服务器下发的数据和配置表, 返回当级配置
function RuneFactoryData:getCurrentLevelConfig(offset)
    offset = offset or 0
    return Config.Manager:getGemFactoryConfigAtLevel(self:getCurrentLevel() + offset)
end

-- 模拟升级
function RuneFactoryData:lvUp(num)
    num = num or 1
    self._currentLevel = self._currentLevel + num
end

-- 获取现等级图标
function RuneFactoryData:getCurrentIcon()
    local config = self:getCurrentLevelConfig()
    return config and config.image or nil
end

-- 获取下一个等级图标
function RuneFactoryData:getIconForNextLevel()
    local config = self:getCurrentLevelConfig(1)
    return config and config.image or nil
end