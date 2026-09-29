-- NetRankSystem.lua
-- Author: zp
-- 

require "utils.MathUtil"
Net = Net or {}
local NetRankSystem = {}
Net.NetRankSystem = NetRankSystem
local ProtobufUtil = require("utils.ProtobufUtil")
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
require "app.datas.TeamDataManager"
local DEBUG = false
local rankListCache = {} --接受服务器 分批次的数据

--请求排行榜数据
function NetRankSystem:requestRankList(rankType, preWeekRank)
    if DEBUG then
        print ("[Net.NetRankSystem] requestRankList  rankType,preWeekRank",rankType, preWeekRank)
    end
    -- 4* 100 + 3 

    local rType = rankType - math.floor(rankType/10)*10
    local tmp = (rankType - rType)/10
    local filterType = tmp - math.floor(tmp/100) * 100
    local filterIndex = (tmp - filterType)/100

    local messageData = {}
    messageData.rankType = rType
    if rType ~= 3 and rType ~= 7 then
        messageData.selfPk = RoleDataManager:getMasterPK()
    else
        if MasterDataManager:getGuildData() then
            messageData.selfPk = MasterDataManager:getGuildData():getID()
        end
    end
    messageData.filter = {filterType = filterType, filterIndex = filterIndex}
    if(preWeekRank) then
        messageData.preWeekRank = preWeekRank
    end
    -- print("====================requestRankList============================")
    -- print("====================requestRankList============================")
    -- print(messageData)
    -- print("====================requestRankList============================")
    -- print("====================requestRankList============================")
    rankListCache[rankType] = {}
    Net.Helper:sendMessage(NetMessageType.RANK_REQUEST_RANK_LIST, messageData)
end

--请求排行榜数据
function NetRankSystem:requestRankHeroInfo(pk, rankType)
    if DEBUG then
        print ("[Net.NetRankSystem] requestRankList  pk",pk)
    end

    local messageData = {}
    messageData.pk = pk
    messageData.rankType = rankType
    -- dump(messageData)

    Net.Helper:sendMessage(NetMessageType.RANK_REQUEST_RANK_HERO_INFO, messageData)
end

--请求指定id排行
function NetRankSystem:requestSpecifyRank(requestID, requestType)
    if DEBUG then
        print ("[Net.NetRankSystem] requestSpecifyRank  requestID,requestType=",requestID, requestType)
    end

    local messageData = {}
    messageData.requestID = requestID
    messageData.requestType = requestType
    -- dump(messageData)

    Net.Helper:sendMessage(NetMessageType.RANK_REQUEST_SPECIFY_RANK, messageData)
end

-- 请求指定宠物模板id排行
function NetRankSystem:requestPetRank(petTemplateIds)
    if DEBUG then
        print ("[Net.NetRankSystem] requestPetRank  requestID=",requestID)
    end
    local messageData = {}
    messageData.petTemplateIds = petTemplateIds

    Net.Helper:sendMessage(NetMessageType.RANK_REQUEST_PET_RANK, messageData)
end

--请求自定排行榜数据
function NetRankSystem:requestRankCustomRankList(rankType,rankId,subType,subIndex,myPk)
    local messageData = {}
    messageData.rankType = rankType
    messageData.rankId = rankId
    messageData.subType = subType
    messageData.subIndex = subIndex
    messageData.myPk = myPk


    Net.Helper:sendMessage(NetMessageType.RANK_REQUEST_CUSTOM_RANK_LIST, messageData)
end

--请求自定排行玩家所属子榜数据
function NetRankSystem:requestCustomRankHeroDetailData(rankType,rankId,pk)
    local messageData = {}
    messageData.rankType = rankType
    messageData.rankId = rankId
    messageData.pk = pk

    Net.Helper:sendMessage(NetMessageType.RANK_REQUEST_CUSTOM_RANK_HERO_DETAIL_DATA, messageData)
end

-- 请求自定排行玩家所属子榜数据
function NetRankSystem:requestCustomRankSelfIndexData(rankType,rankId,subType)
    local messageData = {}
    messageData.rankType = rankType
    messageData.rankId = rankId
    messageData.subType = subType

    print("  requestCustomRankSelfIndexData  messageData ", messageData)
    Net.Helper:sendMessage(NetMessageType.RANK_REQUEST_CUSTOM_RANK_SELF_INDEX_DATA, messageData)
end


-- team消息处理
function NetRankSystem:onRankMessageHandler(no, data)

    -- if (DEBUG) then
    --     if data and type(data) == "table" then
    --         for k,v in pairs(data) do 
    --             if type(v) == "table" then
    --                 print("[Net.NetRankSystem] onTeamMessageHandler  k="..k.."  v=")
    --             end
    --         end
    --     end
    -- end

    -- 回应排行榜数据
    if (no == NetMessageType.RANK_RESPONSE_RANK_LIST.NO) then
        if DEBUG then
            print("[Net.NetRankSystem]  RANK_RESPONSE_RANK_LIST ")
            -- dump(data,"RANK_RESPONSE_RANK_LIST",5)
        end
        --print("RANK_RESPONSE_RANK_LIST==>: ", data)
        local rankType = data.rankType
        if data.filter ~= nil then
            rankType = data.filter.filterIndex * 1000 + data.filter.filterType * 10 + data.rankType  
        end
        local preData = rankListCache[rankType]
        preData.rankType = data.rankType;
        preData.selfRank = data.selfRank;
        preData.selfScore = data.selfScore;
        preData.filter = data.filter;
        preData.preWeekRank = data.preWeekRank;
        preData.period = data.period;
        if preData.rankList == nil then
            preData.rankList = data.rankList
        else
            for k, v in ipairs(data.rankList) do
                table.insert(preData.rankList, v)
            end
        end
        if data.isEnd then
            MasterDataManager:handleLastRankData(preData)
            Avalon.MessageCenter:notice(AvalonMessage.MC_RANK_LIST,preData)  
            rankListCache[data.rankType] = {}         
        end
    --回应排行榜玩家数据
    elseif (no == NetMessageType.RANK_RESPONSE_RANK_HERO_INFO.NO) then
        if DEBUG then
            print("[Net.NetRankSystem]  RANK_RESPONSE_RANK_HERO_INFO ")
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_RANK_HERO_INFO,data)

    --RC 返回指定id排行
    elseif (no == NetMessageType.RANK_RESPONSE_SPECIFY_RANK.NO) then
        if DEBUG then
            print("[Net.NetRankSystem]  RANK_RESPONSE_GUILD_RANK ")
        end
        if(data.type == PublicDefine.RankType.RankType_Guild) then
            local guildData = MasterDataManager:getGuildData()
            if(guildData) then
                guildData:changeRank(data)
            end     

            Avalon.MessageCenter:notice(AvalonMessage.MC_RANK_GUILD_RANK)  
        elseif data.type == PublicDefine.RankType.RankType_Dungeon then
            if data.ranking ~= 0 and data.ranking ~= nil then
                MasterDataManager:setDungeonRanking(data.ranking)
            else
                MasterDataManager:setDungeonRanking(-1)
            end
            Avalon.MessageCenter:notice(AvalonMessage.MC_RANK_DUNGEON_SEASON_RANKING)  
            Avalon.MessageCenter:notice(AvalonMessage.MC_RANK_DUNGEON_SEASON_TO_REWARD)
        else
            -- TODO 处理其余排行榜请求返回

        end
    -- elseif (no == NetMessageType.RANK_UPDATE_LAST_RANK.NO) then
    --     -- SC发送上一次榜单数据
    --     if DEBUG then
    --         print("[Net.NetRankSystem]  RANK_UPDATE_LAST_RANK ", data)
    --     end
        
    --     MasterDataManager:handleLastRankData(data)
    elseif (no == NetMessageType.RANK_RESPONSE_PET_RANK.NO) then
        if DEBUG then
            print("[Net.NetRankSystem]  RANK_RESPONSE_PET_RANK ")
        end

        mvc.petModel:receivePetRanks(data.rankList)
    elseif (no == NetMessageType.RANK_RESPONSE_CUSTOM_RANK_LIST.NO) then
        print("    NetMessageTypeRANK_RESPONSE_CUSTOM_RANK_LIST =====  ",data)
        if data.rankType == PublicDefine.CustomRankType.CustomRankType_TrialLand then
            mvc.activityModeCaveLeaderboardModel:updateRankData(data)
            if data.isEnd > 0 then
                mvc.activityModeCaveLeaderboardController:updateRankView()
            end
        end
    elseif (no == NetMessageType.RANK_RESPONSE_CUSTOM_RANK_SELF_INDEX_DATA.NO) then
        print("    RANK_RESPONSE_CUSTOM_RANK_SELF_INDEX_DATA =====  ",data)
        if data.rankType == PublicDefine.CustomRankType.CustomRankType_TrialLand then
            print("data.data ====== ",data.data)
            mvc.activityModeCaveLeaderboardController:rankingViewAction(data.data)
        end
    elseif (no == NetMessageType.RANK_RESPONSE_CUSTOM_RANK_HERO_DETAIL_DATA.NO) then
        if data.rankType == PublicDefine.CustomRankType.CustomRankType_TrialLand then
            if(data.detailData.result == "HeroDetailResult_success") then
                local detailData =  MasterDataManager:handleHeroDetail(data.detailData)
                if(detailData) then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_SHOW_ROLE_INFO, detailData)
                end
            end
        end
    else
        assert(false, string.format("[Net.NetRankSystem] onTeamMessageHandler no %d is invaild.", no))
    end    
end

