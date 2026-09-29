-- GoldenMineData.lua
-- Author:CMonk
-- 2018年12月12日

require "app.config.ConfigManager"
require "app.datas.GameData"

local GoldenMineData = class("GoldenMineData")

Data = Data or {}
Data.GoldenMineData = GoldenMineData

-- required uint32 lv = 1;                         //等级
-- required uint32 output = 3;                     //当前总产量
-- required uint64 activeJobTime = 5;              //激活任务,进入高速状态得起始时间
-- required uint64 beginCalTime = 6;               //计算产量得起始时间

--构造函数(必备)
function GoldenMineData:ctor()
    self._currentLevel = 1
    self._taskStartTimeStamp = 0
    self._preCalcAmount = 0
    self._calcTimeStamp = 0
end

--析构函数, destroy时调用(必备)
function GoldenMineData:dtor()

end

function GoldenMineData:init(data)

end

-- 初始化服务器数据
function GoldenMineData:initNet(data)
    if (not data) then return end

    self._calcTimeStamp = data.beginCalTime or 0
    self._currentLevel = data.lv or 1
    self._preCalcAmount = data.output and data.output / 10000 or 0
    self._taskStartTimeStamp = data.activeJobTime or 0
end

-- 加速时间剩余
function GoldenMineData:getBoostTimeRemaining()
    local config = self:getCurrentLevelConfig()
    local remaining = self._taskStartTimeStamp + config.accelerationTime * 60 - GameManager:getNormalServerTime()
    return remaining > 0 and remaining or 0
end

-- 到下次可以接任务的时间
function GoldenMineData:getTimeToNextQuest()
    local config = self:getCurrentLevelConfig()
    local remaining = self._taskStartTimeStamp + config.taskResetTime * 60 - GameManager:getNormalServerTime()
    return remaining > 0 and remaining or 0
end

-- 现在的等级
function GoldenMineData:getCurrentLevel()
    return self._currentLevel
end

-- 总等级
function GoldenMineData:getMaxLevel()
    return Config.Manager:getGoldenMineConfigMaxLv()
end

-- 现在是否可以加速
function GoldenMineData:getIsQuestAvailable()
    return self:getTimeToNextQuest() <= 0
end

-- 现在是否在加速中
function GoldenMineData:getIsInBoost()
    return self:getBoostTimeRemaining() > 0
end

-- 下一级的基础速度
function GoldenMineData:getBaseSpeedForNextLevel()
    local config = self:getCurrentLevelConfig(1)
    return config and config.unitTimeProduction * 60 or 0
end

-- 现在的基础速度
function GoldenMineData:getCurrentBaseSpeed()
    local config = self:getCurrentLevelConfig()
    return config and config.unitTimeProduction * 60 or 0
end

-- 现在的产出等级(金矿不显示)
function GoldenMineData:getCurrentOutputLevel()
    return nil
end

-- 下一级的产出等级(金矿不显示)
function GoldenMineData:getNextLevelOutputLevel()
    return nil
end

-- 加速的速度参数
function GoldenMineData:getCurrentBoostFactor()
    local config = self:getCurrentLevelConfig()
    return config and config.accelerationRate / 100 or 0
end

-- 现在加速的速度 (从加速百分比中算出的比基础速度高出的速度)
function GoldenMineData:getCurrentExtraBoostSpeedNumber()
    local extraFactor = self:getCurrentBoostFactor() - 1
    if (extraFactor < 0) then extraFactor = 0 end
    return self:getCurrentBaseSpeed() * extraFactor
end

-- 获取现在速度
function GoldenMineData:getCurrentSpeed()
    local speed = self:getCurrentBaseSpeed()
    if (self:getIsInBoost()) then
        speed = speed * self:getCurrentBoostFactor()
    end
    return speed
end

-- 获取现在的产出量
function GoldenMineData:getCurrentSize()
    local deltaTimeInSeconds = GameManager:getNormalServerTime() - self._calcTimeStamp
    local calcSize = self._preCalcAmount + deltaTimeInSeconds / 3600 * self:getCurrentSpeed()
    calcSize = calcSize > 0 and calcSize or 0
    local maxSize = self:getMaxSize()
    return calcSize > maxSize and maxSize or calcSize
end

-- 获取最大产出容量
function GoldenMineData:getMaxSize()
    local config = self:getCurrentLevelConfig()
    return config and config.capacity or 0
end

function GoldenMineData:getCurrentWorkStatus()
    -- 宠物相关, 暂不使用
    return 0
end

function GoldenMineData:getMaxWorkStatus()
    -- 宠物相关, 暂不使用
    return 0
end

-- 获取一个升级需要的物品ID列表
function GoldenMineData:getLvUpMaterialList()
    local config = self:getCurrentLevelConfig()
    local materialList = {}
    for i,v in ipairs(config.upgradeLvCostID) do
        materialList[i] = { id = v }
    end
    for i,v in ipairs(config.upgradeLvCostNum) do
        materialList[i].amount = v
    end
    return materialList
end

-- 获取一个加速需要的物品ID列表
function GoldenMineData:getBoostMaterialList()
    local config = self:getCurrentLevelConfig()
    local materialList = {}
    for i,v in ipairs(config.taskItemID) do
        materialList[i] = { id = v }
    end
    for i,v in ipairs(config.taskItemNum) do
        materialList[i].amount = v
    end
    return materialList
end

-- 获取升级需要达到的层数
function GoldenMineData:getLvUpFloorCondition()
    local config = self:getCurrentLevelConfig()
    return config and config.schedule or nil
end

-- 获取升级需要的另外的家园功能等级
function GoldenMineData:getLvUpNPCCondition()
    local config = self:getCurrentLevelConfig()
    if (config) then
        return config.preNPCID, config.preNPCLV
    else
        return nil, nil
    end
end

-- 获取现在加速时长
function GoldenMineData:getCurrentBoostDuration()
    local config = self:getCurrentLevelConfig()
    return config and config.accelerationTime or 0
end

-- 获取加速间隔时间
function GoldenMineData:getCurrentQuestInterval()
    local config = self:getCurrentLevelConfig()
    return config and config.taskResetTime or 0
end

-- 获取现在的金矿配置, 或便宜于现在
function GoldenMineData:getCurrentLevelConfig(offset)
    offset = offset or 0
    return Config.Manager:getGoldenMineConfigAtLevel(self:getCurrentLevel() + offset)
end

-- 模拟升级
function GoldenMineData:lvUp(num)
    num = num or 1
    self._currentLevel = self._currentLevel + num
end

-- 获取现等级图标
function GoldenMineData:getCurrentIcon()
    local config = self:getCurrentLevelConfig()
    return config and config.image or nil
end

-- 获取下一个等级图标
function GoldenMineData:getIconForNextLevel()
    local config = self:getCurrentLevelConfig(1)
    return config and config.image or nil
end

-- 检查升级后材料是否有变
function GoldenMineData:isMaterialChanging()
    local currentLevel = self:getCurrentLevel()
    if (currentLevel <= 1 or currentLevel + 1 >= self:getMaxLevel()) then
        return false
    end

    -- 现在的材料
    local currentMaterialCheckTable = {}
    local prevLevelConfig = self:getCurrentLevelConfig()
    if (prevLevelConfig and prevLevelConfig.taskItemID) then
        for i,v in ipairs(prevLevelConfig.taskItemID) do
            currentMaterialCheckTable[v] = true
        end
    end
    
    -- 下一级的材料
    local nextLvMaterialCheckTable = {}
    local curLevelConfig = self:getCurrentLevelConfig(1)
    if (curLevelConfig and curLevelConfig.taskItemID) then
        for i,v in ipairs(curLevelConfig.taskItemID) do
            nextLvMaterialCheckTable[v] = true
        end
    end

    -- 对比(要完全一样)
    local isMaterialSame = true
    for k,v in pairs(currentMaterialCheckTable) do
        if (nextLvMaterialCheckTable[k]) then
            nextLvMaterialCheckTable[k] = nil
        else
            isMaterialSame = false
        end
    end
    if (isMaterialSame and next(nextLvMaterialCheckTable) ~= nil) then
        isMaterialSame = false
    end

    return not isMaterialSame
end