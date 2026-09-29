-- UnlockCaveData.lua
-- Author:zp
-- 2017年6月20日
-- Using:解锁数据

require "app.datas.GameData"

local UnlockCaveData = class("UnlockCaveData")

Data = Data or {}
Data.UnlockCaveData = UnlockCaveData

function UnlockCaveData:ctor()
    -- 玩法
    self._mode = 0
    -- 难度
	self._difficulty = 0
    -- 是否解锁
    self._isUnlock = false
end

function UnlockCaveData:init(caveMode,caveDifficulty,isUnlock)
    self._mode = caveMode
    self._difficulty = caveDifficulty
    self._isUnlock = isUnlock
end

function UnlockCaveData:initNet(data)
    -- 初始化网络数据
    self._mode = data.caveMode
    self._difficulty = data.caveDifficulty
    self._isUnlock = data.isUnlock
end

function UnlockCaveData:getMode()
    return self._mode
end

function UnlockCaveData:getDifficulty()
    return self._difficulty
end

function UnlockCaveData:setIsUnlock(isUnlock)
    self._isUnlock = isUnlock
end

function UnlockCaveData:getIsUnlock()
    return self._isUnlock
end