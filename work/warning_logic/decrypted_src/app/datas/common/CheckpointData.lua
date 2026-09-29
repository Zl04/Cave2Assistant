-- CheckpointData.lua
-- Author:zp
-- 2017年4月19日
-- Using:存档点数据结构

require "app.datas.GameData"

local CheckpointData = class("CheckpointData")

Data = Data or {}
Data.CheckpointData = CheckpointData

function CheckpointData:ctor()
    -- 玩法
    self._mode = 0
    -- 难度
	self._difficulty = 0
    -- 存档点
    self._checkpoint = 0
end

function CheckpointData:init(caveMode,caveDifficulty,checkpoint)
    self._mode = caveMode
    self._difficulty = caveDifficulty
    self._checkpoint = checkpoint
end

function CheckpointData:initNet(data)
    -- 初始化网络数据
    self._mode = data.caveMode
    self._difficulty = data.caveDifficulty
    self._checkpoint = data.checkpoint
end

-- 获取解锁层级
function CheckpointData:getUnlockLevel()
    if (self._checkpoint <2000 or self._checkpoint >= 3000) then
        return 0
    end

    return self._checkpoint - 2000
end

function CheckpointData:getMode()
    return self._mode
end

function CheckpointData:getDifficulty()
    return self._difficulty
end

function CheckpointData:setCheckpoint(checkpoint)
    self._checkpoint = checkpoint
end

function CheckpointData:getCheckpoint()
    return self._checkpoint
end

function CheckpointData:unlockCheckPoint()
    self._checkpoint = 2001
end