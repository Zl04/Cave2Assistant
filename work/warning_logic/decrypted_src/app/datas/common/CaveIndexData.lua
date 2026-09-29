-- CaveIndexData.lua
-- Author:zp
-- 2019年3月21日
-- Using:关卡挑战记录

require "app.datas.GameData"

local CaveIndexData = class("CaveIndexData")

Data = Data or {}
Data.CaveIndexData = CaveIndexData

function CaveIndexData:ctor()
    -- 玩法
    self._mode = 0
    -- 难度
	self._difficulty = 0
    self._index = 0
    -- 
    self._caveIndexArr = {}
end

function CaveIndexData:init(caveMode,caveDifficulty,index)
    self._mode = caveMode
    self._difficulty = caveDifficulty
    self._index = index
    self:_handleIndex()
end

function CaveIndexData:initNet(data)
    -- 初始化网络数据
    self._mode = data.caveMode
    self._difficulty = data.caveDifficulty
    self._index = data.index
    self:_handleIndex()
end

function CaveIndexData:getMode()
    return self._mode
end

function CaveIndexData:getDifficulty()
    return self._difficulty
end

function CaveIndexData:getCaveIndexArr()
    return self._caveIndexArr
end

function CaveIndexData:_handleIndex()
    self._caveIndexArr = {}
    local funcArray = ToolsUtil:splitFunctionType(self._index, true)
    local baseNum = 10000 * self._mode
    baseNum = baseNum + 100 * self._difficulty
    -- print("CaveIndexData:_handleIndex", self._mode, self._difficulty, self._index, funcArray)
    if(funcArray) then
        for _,v in ipairs(funcArray) do 
            local key = baseNum + v
            self._caveIndexArr[key] = key
        end 
    end
end