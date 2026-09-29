-- MaxLevelData.lua
-- Author:zp
-- 2017年4月19日
-- Using:最大楼层数据结构

require "app.datas.GameData"

local MaxLevelData = class("MaxLevelData")

Data = Data or {}
Data.MaxLevelData = MaxLevelData

function MaxLevelData:ctor()
    -- 玩法
    self._mode = 0
    -- 难度
	self._difficulty = 0
    -- 最大楼层
    self._maxLevel = 0
    -- 不回档的最大楼层
    self._noBackMaxLevel = 0
    -- 时光之梦英雄模式中  每个地块（一个入口按钮）的进度是分开的 所有需要区分
    self.levelId = 0
end

function MaxLevelData:init(caveMode,caveDifficulty,maxLevel)
    self._mode = caveMode
    self._difficulty = caveDifficulty
    self._maxLevel = maxLevel
    self._noBackMaxLevel = maxLevel
end

function MaxLevelData:setLevelId(levelId)
     self.levelId = levelId
end

function MaxLevelData:getLevelId()
     return self.levelId
end

function MaxLevelData:initNet(data)
    -- 初始化网络数据
    self._mode = data.caveMode
    self._difficulty = data.caveDifficulty
    self._maxLevel = data.maxLevel
    self._noBackMaxLevel = data.maxLevel
end

function MaxLevelData:getMode()
    return self._mode
end

function MaxLevelData:getDifficulty()
    return self._difficulty
end

function MaxLevelData:setMaxLevel(maxLevel)
    self._maxLevel = maxLevel
    if self._maxLevel > self._noBackMaxLevel then
        self._noBackMaxLevel = self._maxLevel
    end
end

function MaxLevelData:getMaxLevel()
    return self._maxLevel
end

function MaxLevelData:setNoBackMaxLevel(maxLevel)
    self._noBackMaxLevel = maxLevel
end

function MaxLevelData:getNoBackMaxLevel()
    return self._noBackMaxLevel
end