--[[
    称号管理器
]]
------------------------------------------------------
require "app.config.ConfigManager"
require "app.datas.home.GoldenMineData"
require "app.datas.home.RuneFactoryData"

local DEBUG = false

HomeDataManager = HomeDataManager or {}

-- 初始化
function HomeDataManager:init()
    self._goldenMineData = Data.GoldenMineData:create()
    self._runeFactoryData = Data.RuneFactoryData:create()
end

-- 网络初始化
function HomeDataManager:initNetGoldenMine(initData)
    if (not self._goldenMineData) then return end
    self._goldenMineData:initNet(initData)
end

-- 网络初始化
function HomeDataManager:initNetRuneFactory(initData)
    if (not self._runeFactoryData) then return end
    self._runeFactoryData:initNet(initData)
end

-- 清空
function HomeDataManager:clear()
    
end

-- 回档（恢复）清理数据
function HomeDataManager:restoreClear()
    
end

-- 获取金矿数值
function HomeDataManager:getGoldenMineData()
    return self._goldenMineData
end

-- 金矿升级
function HomeDataManager:goldenMineLvUp()
	self._goldenMineData:lvUp()
end

-- 获取工坊数值
function HomeDataManager:getRuneFactoryData()
    return self._runeFactoryData
end

-- 工坊升级
function HomeDataManager:runeFactoryLvUp()
	self._runeFactoryData:lvUp()
end

--默认初始化
HomeDataManager:init()