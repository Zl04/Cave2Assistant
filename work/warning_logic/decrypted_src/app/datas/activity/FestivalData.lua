
-- FestivalData.lua
-- Author:zp
-- 2019年1月7日
-- Using:节日活动

require "app.datas.GameData"
local ProtobufUtil = require "utils.ProtobufUtil"

local FestivalData = class("FestivalData")

Data = Data or {}
Data.FestivalData = FestivalData

function FestivalData:ctor()
    self.gotReward = false
    self.rank = nil
    self.festivalList = {}
    self.festivalRewards = {}

    self.ratWinNum = 0 -- 异鼠 胜利次数
    self.bigCrackWinNum = 0     -- 大裂缝胜利次数
    self.easterNum = 0          -- 复活节次数
    self.huluCountTime = nil --葫芦计数时间
    self.puzzleNum = 0
end

function FestivalData:init()

end

function FestivalData:initNet(actID, data)
    self.festivalRewards = data.awards
    local datas = data.subActDatas
    for i = 1, #datas do
        local actData = datas[i]

        local one = {}
        one.activityID = actID
        one.mapID = actData.mapID
        one.time = actData.ctlTime
        table.insert(self.festivalList, one)
    end
end

function FestivalData:getRewardsData()
    return self.festivalRewards
end

function FestivalData:getFestivalList()
    return self.festivalList
end

function FestivalData:setGotReward()
    self.gotReward = true
end

function FestivalData:isGotReward()
    return self.gotReward
end

function FestivalData:initCount(data)
    self.gotReward = data.isGetAward
    self.rank = data.mazeLastRank

    self.ratWinNum = data.ratWinNum -- 异鼠 胜利次数
    self.bigCrackWinNum = data.bigCrackWinNum     -- 大裂缝胜利次数
    self.easterNum = data.easterNum          -- 复活节次数
    if(ProtobufUtil:checkFieldIsInit(data, "huluCountTime")) then
        self.huluCountTime = data.huluCountTime --葫芦计数时间
    end
    if(ProtobufUtil:checkFieldIsInit(data, "puzzleNum")) then
        self.puzzleNum = data.puzzleNum --记忆翻牌奖励次数
    end
end

function FestivalData:updateCount(data)
    self.gotReward = data.isGetAward
    self.rank = data.mazeLastRank
    self.ratWinNum = data.ratWinNum -- 异鼠 胜利次数
    self.bigCrackWinNum = data.bigCrackWinNum     -- 大裂缝胜利次数
    self.easterNum = data.easterNum          -- 复活节次数
    if(ProtobufUtil:checkFieldIsInit(data, "huluCountTime")) then
        self.huluCountTime = data.huluCountTime --葫芦计数时间
    end
    if(ProtobufUtil:checkFieldIsInit(data, "puzzleNum")) then
        self.puzzleNum = data.puzzleNum --记忆翻牌奖励次数
    end
end

function FestivalData:clearCount()
    self.gotReward = false
    self.rank = nil
    self.ratWinNum = 0 -- 异鼠 胜利次数
    self.bigCrackWinNum = 0     -- 大裂缝胜利次数
    self.easterNum = 0          -- 复活节次数
    self.huluCountTime = nil --葫芦计数时间
    self.puzzleNum = 0
end

function FestivalData:getIsHuluPlayStatus()
    if(self.huluCountTime) then 
        if(GameManager:getNormalServerTime() - self.huluCountTime >= tonumber(ConfigManager:getGeneralForKey("huluRefreshTime"))) then 
            return true
        end
    end

    return false
end

function FestivalData:getHuluCountTime()
    -- return GameManager:getNormalServerTime() - 2*tonumber(ConfigManager:getGeneralForKey("huluRefreshTime")) + 1

    return self.huluCountTime
end

function FestivalData:getIsHuLuFreshStatus()
    if(self.huluCountTime) then 
        if((GameManager:getNormalServerTime() - self:getHuluCountTime()) >= 2 * (tonumber(ConfigManager:getGeneralForKey("huluRefreshTime")))) then 
            return true
        end
    end

    return false
end

function FestivalData:getHuLuFreshTime()
    if(self.huluCountTime) then 
        local refreshTime = tonumber(ConfigManager:getGeneralForKey("huluRefreshTime"))
        local time = self:getHuluCountTime() + 2 * refreshTime - GameManager:getNormalServerTime() 
        if(time > refreshTime) then 
            time =  time - refreshTime
        end
        -- print("FestivalData:getHuLuFreshTime=", time)
        return time
    end
    -- print("FestivalData:getHuLuFreshTime= no init")
    return 0
end

--[[

return: true 开启状态，false 未开启
]]
function FestivalData:getLostRealmStatus()
    if(self.festivalList) then 
        for k,v in ipairs(self.festivalList) do 
            if(v.mapID == PublicDefine.CONST_DEFINITION.LOST_REALM_MAP_ID) then 
                local curTime = os.date("!*t", GameManager:getNowServerTime())
                local curTimeStamp = curTime.hour*3600+curTime.min*60+curTime.sec
                local timeList = v.time
                local isOpen = false
                for k, v in ipairs(timeList) do
                    if curTimeStamp >= v.startTm and curTimeStamp <= v.endTm then
                        isOpen = true
                        break
                    end
                end

                return isOpen
            end
        end
    end

    return false
end

function FestivalData:getLostRealmFestivalData()
    if(self.festivalList) then 
        for k,v in ipairs(self.festivalList) do 
            if(v.mapID == PublicDefine.CONST_DEFINITION.LOST_REALM_MAP_ID) then 
                return v
            end
        end
    end

    return nil
end