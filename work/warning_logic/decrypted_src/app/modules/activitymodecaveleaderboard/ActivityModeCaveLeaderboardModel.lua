--[[--
数据模型ActivityModeCaveLeaderboardModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/11/01
--desc	: ActivityModeCaveLeaderboardModel
------------------------------------------------------------------------------
local ProtobufUtil = require "utils.ProtobufUtil"

local ActivityModeCaveLeaderboardModel = class("ActivityModeCaveLeaderboardModel",mvc.GameModel)

function ActivityModeCaveLeaderboardModel:initData()

    --全服参与奖励数据
    self._participateData = {}


    self._rankType = PublicDefine.CustomRankType.CustomRankType_TrialLand
    self._rankId = 1
    self._rankListData = {} --排行榜列表数据
    self._mineRankData = {} --我的排行榜数据

end


-- optional uint32 subType = 3;                    // 取值根据 rankType 取值
--     optional uint32 subIndex = 4;                   // 档位
--     repeated CustomRankListData rankList = 5;
--     required uint64 myScore = 6;
--     required uint32 myRank = 7;
--     optional uint32 sendType = 11;                  // RankListSendType
function ActivityModeCaveLeaderboardModel:updateRankData(data)

    print("   updateRankData =====   ",data)
    self._rankType = data.rankType
    self._rankId = data.rankId
    if not self._rankListData[data.subType] then
        self._rankListData[data.subType] = {}
    end
    if not self._mineRankData[data.subType] then
        self._mineRankData[data.subType] = {}
    end

    if data.isInitial > 0 then
        self._rankListData[data.subType][data.subIndex] = {}
        self._mineRankData[data.subType][data.subIndex] = {}
    end

    if data.rankList then
        for k,v in pairs(data.rankList) do
            if data.rankType == PublicDefine.CustomRankType.CustomRankType_TrialLand then
                v.data = ProtobufUtil:decode("RankSystem.TrialLandRankData", v.data)
                table.insert(self._rankListData[data.subType][data.subIndex], v)
            end
        end
    end

    if data.isEnd > 0 and #self._rankListData[data.subType][data.subIndex] > 1 then
        table.sort(self._rankListData[data.subType][data.subIndex], function(a, b)
            return a.rank < b.rank
        end)
    end

    if data.mine and data.mine.pk and data.mine.pk ~= 0 then
        data.mine.data = ProtobufUtil:decode("RankSystem.TrialLandRankData", data.mine.data)
        self._mineRankData[data.subType][data.subIndex] = clone(data.mine)
    end
end

function ActivityModeCaveLeaderboardModel:updateParticipateData(data)

    --         message ParticipateData
        -- {
        --     optional uint32 type = 1;                           // 参与类型领取数据
        --     repeated uint32 claimedSchedules = 2;               // 已领取的奖励ID
        --     optional uint32 totalCount = 11;                    // 服务器进度（仅同步客户端时使用）
        -- }

        -- message SyncParticipateDataMessage
        -- {
        --     repeated ParticipateData data = 1;
        -- }
    print(" updateParticipateData ====  ",data)
    for k,v in ipairs(data) do
        self._participateData[v.type] = {}
        self._participateData[v.type].claimedSchedules = v.claimedSchedules or {}
        self._participateData[v.type].totalCount = v.totalCount or 0
    end
end

function ActivityModeCaveLeaderboardModel:getCumulativeCount(participateType)
    local count = 0

    if self._participateData[participateType] then
        count = self._participateData[participateType].totalCount
    end

    return count
end

function ActivityModeCaveLeaderboardModel:canReceiveParticipate(participateType, id, target)
    local canReceive = false

    if self._participateData[participateType] then
        local isReceive = false
        for k,v in pairs(self._participateData[participateType].claimedSchedules) do
            if v == id then
                isReceive = true
                break
            end
        end

        if not isReceive and self._participateData[participateType].totalCount >= target then
            canReceive = true
        end
    end

    return canReceive
end

function ActivityModeCaveLeaderboardModel:isReceiveParticipate(participateType, id)
    local isReceive = false

    if self._participateData[participateType] then
        for k,v in pairs(self._participateData[participateType].claimedSchedules) do
            if v == id then
                isReceive = true
                break
            end
        end
    end

    return isReceive
end

function ActivityModeCaveLeaderboardModel:needShowRedPoint(trialModelID)

    local noShowModel = self:isNoShowModelId(trialModelID)
    local showPoint = false
    if not noShowModel then
        local sData = ConfigManager:getAllParticipateScheduleData()
        local trialModelConf = ConfigManager:getAllTrialModelDataByID(trialModelID)
        if sData then
            for k,v in ipairs(sData) do
                local isReceive = self:isReceiveParticipate(trialModelConf.participateType,v.ID)
                local canReceive = self:canReceiveParticipate(trialModelConf.participateType,v.ID,tonumber(v.target))

                if canReceive and not isReceive then
                    showPoint = true
                    break
                end
            end
        end
    end

    return showPoint
end

--当前活动模式 是否有参与奖励
function ActivityModeCaveLeaderboardModel:isNoShowModelId(modelID)
    local noShowModel = false
    local cfgStr = ConfigManager:getGeneralForKey("noShowModelId")
    local modelList = string.split(cfgStr, ";") 
    for k,v in ipairs(modelList) do
        if modelID == tonumber(v) then
            noShowModel = true
            break
        end
    end

    return noShowModel
end

function ActivityModeCaveLeaderboardModel:getRankListData()
    return self._rankListData
end

function ActivityModeCaveLeaderboardModel:getMineRankData()
    return self._mineRankData
end

function ActivityModeCaveLeaderboardModel:getRankListDataByIndex(subType,subIndex)
    return self._rankListData[subType] and self._rankListData[subType][subIndex] or {}
end

function ActivityModeCaveLeaderboardModel:getMineRankDataByIndex(subType,subIndex)
    return self._mineRankData[subType] and self._mineRankData[subType][subIndex] or {}
end

return ActivityModeCaveLeaderboardModel