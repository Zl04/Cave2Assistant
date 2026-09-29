--[[
    用户数据 － 在洞穴里面保存的相关数据 
]]--

require "utils.userdata.UserData"

Avalon = Avalon or {}

local GameInCaveData = class("GameInCaveData", Avalon.UserData)
Avalon.GameInCaveData = GameInCaveData

-- private:
-- 构造函数
function GameInCaveData:ctor()
    GameInCaveData.super.ctor(self, USER_DATA_TYPE.GAME_IN_CAVE)

    -- 保存本地虚幻效果
    self._deformationData = {}
    -- self._deformationData.delusion = 0
    -- self._deformationData.arr = {}

    self._confuseDirectArr = {}
end

function GameInCaveData:addDeformation(level, mode, difficulty, coordX, coordY, deformationID)
    print("GameInCaveData:addDeformation  ", level, mode, difficulty, coordX, coordY, deformationID)
    local key = self:_makeDeformationKey(level, mode, difficulty)

    local dataArr = self._deformationData[key]
    if(dataArr == nil) then 
        dataArr = {}
        self._deformationData[key] = dataArr
    end

    local dataKey = self:_makeDeformationDataKey(coordX, coordY)
    dataArr[dataKey] = deformationID
end

function GameInCaveData:getDeformation(level, mode, difficulty, coordX, coordY)
    print("GameInCaveData:getDeformation  ", level, mode, difficulty, coordX, coordY)
    local key = self:_makeDeformationKey(level, mode, difficulty)

    local dataArr = self._deformationData[key]
    if(dataArr == nil) then 
        return nil
    end

    local dataKey = self:_makeDeformationDataKey(coordX, coordY)
    print("GameInCaveData:getDeformation  deformationID=", dataArr[dataKey])
    return dataArr[dataKey]
end

function GameInCaveData:removeDeformation(level, mode, difficulty, coordX, coordY)
    print("GameInCaveData:removeDeformation  ", level, mode, difficulty, coordX, coordY)
    local key = self:_makeDeformationKey(level, mode, difficulty)

    local dataArr = self._deformationData[key]
    if(dataArr == nil) then 
        return
    end

    local dataKey = self:_makeDeformationDataKey(coordX, coordY)
    dataArr[dataKey] = nil
end

-- 清理所有的幻境效果
function GameInCaveData:clearAllDeformation()
    print("GameInCaveData:clearAllDeformation  ")
    self._deformationData = {}
end

function GameInCaveData:setConfuseDirection(directArr)
    self._confuseDirectArr = directArr
    if(self._confuseDirectArr == nil) then
        self._confuseDirectArr = {}
    end
end

function GameInCaveData:getConfuseDirection()
    if(self._confuseDirectArr == nil) then
        self._confuseDirectArr = {}
    end
    
    return self._confuseDirectArr
end

function GameInCaveData:clearConfuseDirection()
    self._confuseDirectArr = {}
end

function GameInCaveData:_makeDeformationKey(level, mode, difficulty)
    return string.format("l%d:d%d:level%d", mode, difficulty, level)
end

function GameInCaveData:_makeDeformationDataKey(coordX, coordY)
    return string.format("x%d:y%d", coordX, coordY)
end
