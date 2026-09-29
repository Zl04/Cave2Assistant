-- WorldEventData.lua
-- Author:zp
-- 2017年6月20日
-- Using:解锁数据

require "app.datas.GameData"
local ProtobufUtil = require("utils.ProtobufUtil")
local LanguageManager = require("app.game.LanguageManager")

local OneEvent = class("OneEvent")

function OneEvent:ctor()
    self.targetID = 0
    self.targetNum = 0
    self.targetDes = nil

    self.totalNum = 0
end

function OneEvent:initConfig(targetID, targetNum, targetDes)
    self.targetID = targetID
    self.targetNum = targetNum or 0
    if(targetDes) then 
        self.targetDes = LanguageManager:getInstance():getLocalString(targetDes)
    else 
        self.targetDes = ""
    end
end

function OneEvent:updateCount(totalNum)
    self.totalNum = totalNum
end

function OneEvent:getTotalNum()
    return self.totalNum
end

function OneEvent:getTargetID()
    return self.targetID
end

function OneEvent:getTargetNum()
    return self.targetNum
end

function OneEvent:getTargetDes()
    return self.targetDes
end


-- 扭曲空间事件
local WorldEventData = class("WorldEventData")

Data = Data or {}
Data.WorldEventData = WorldEventData

function WorldEventData:ctor()
    self.ID = 0
    self.eventName = nil 
    self.eventDes = nil
    self.eventEndDes = nil

    self.eventArr = {}
end

function WorldEventData:initNet(data)
    -- 初始化网络数据
    self.ID = data.eventID
    -- PublicDefine.DistortedSpaceEventState
    self.state = ProtobufUtil:enum_id("PublicDefine.DistortedSpaceEventState", data.state)
    self._isHide = data.isHide
    self.eventArr = {}
    local worldEventConfig = ConfigManager:getWorldEventByID(self.ID)
    if(worldEventConfig) then 
        for k,tarID in ipairs(worldEventConfig.targetID) do 
            local oneEvent = OneEvent:create()
            oneEvent:initConfig(worldEventConfig.targetID[k], worldEventConfig.targetNum[k], worldEventConfig.targetDes[k])
            for key, ID in ipairs(worldEventConfig.targetID) do 
                if(ID == tarID) then 
                    if data.targetNum ~= nil then
                        oneEvent:updateCount(data.targetNum[key] or 0)
                    else
                        oneEvent:updateCount(0)
                    end
                    break
                end
            end
            table.insert(self.eventArr, oneEvent)
        end
        self.eventName = worldEventConfig.eventName
        self.eventDes = worldEventConfig.eventDes
        self.eventEndDes = worldEventConfig.eventEndDes
    end
end

function WorldEventData:isValid()
    if self.state ==  PublicDefine.DistortedSpaceEventState.DistortedSpaceEventState_Doing then
        if self:isHide() then
            return false
        elseif MasterDataManager:isHaveVildPreEventAndTask(self.ID) then
            return false
        else
            return true
        end
    end
    return false
end

function WorldEventData:isHide()
    return self._isHide
end


function WorldEventData:getID()
    return self.ID
end

function WorldEventData:getEventName()
    return self.eventName
end

function WorldEventData:getEventDes()
    return self.eventDes
end

function WorldEventData:getEventEndDes()
    return self.eventEndDes
end

function WorldEventData:getEventArr()
    return self.eventArr
end

function WorldEventData:getState()
    return self.state
end

function WorldEventData:getDesc()
    local percent = 0
    local size = 0
    for k, v in ipairs(self.eventArr) do
        if v:getTargetNum() ~= 0 then
            percent = percent + v:getTotalNum() / v:getTargetNum()
            size = size + 1
        end
    end
    if size == 0 then
        return self:getEventDes(), 0
    end
    percent = percent / size
    percent = percent > 1 and 1 or percent
    if percent >= 1 then
        return self:getEventEndDes(), percent
    end
    return self:getEventDes(), percent
end
