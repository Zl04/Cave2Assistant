--[[
    活动网络消息
]]
local SceneManager = require("app.game.SceneManager")

Net = Net or {}

local NetActivitySystem = {}
Net.NetActivitySystem = NetActivitySystem
local ProtobufUtil = require "utils.ProtobufUtil"
local DEBUG = false

-- 请求：领取活动奖励
function NetActivitySystem:requestActivityReward(id, subID)
    if(DEBUG) then
        print("NetActivitySystem:requestActivityReward", id, subID)
    end

    local requestData = {}
    requestData.id = id
    requestData.subId = subID

    MasterDataManager:insertRepeatHandleData(RepeatHandleType.ACTIVITY_REWARD, id..":"..subID, true)

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQUEST_ACTIVITY_REWARD, requestData)
end


--活动副本 begin
--请求匹配
function NetActivitySystem:requestMacth(activityID, mapID)
    if(DEBUG) then
        print("NetActivitySystem:requestMacth", activityID)
    end

    local requestData = {}
    requestData.activityID = activityID
    requestData.mapID = mapID

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQUEST_MATCH, requestData)
end

--请求取消匹配   无内容 
function NetActivitySystem:requestCancleMacth(isAlreadyMatch)
    if(DEBUG) then
        print("NetActivitySystem:requestCancleMacth")
    end

    local requestData = {}
    requestData.isQuitRoom = isAlreadyMatch
    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQUEST_CANCLE_MATCH, requestData)
end

--确认匹配  无内容 ()
function NetActivitySystem:requestSureMacth()
    if(DEBUG) then
        print("NetActivitySystem:requestSureMacth")
    end

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQUEST_SURE_MATCH)
end
--活动副本 end

-- worldboss
function NetActivitySystem:requestJoinWorldboss(battleNo)
    if(DEBUG) then
        print("NetActivitySystem:requestJoinWorldboss")
    end

    local requestData = {}
    requestData.battleNo = battleNo

    if not battleNo then
        print("NetActivitySystem:requestJoinWorldboss battleNo is nil, ERROR!!!")
    end

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQ_JOIN_WORLDBOSS, requestData)
end

function NetActivitySystem:requestWorldbossQuitRoom()
    if(DEBUG) then
        print("NetActivitySystem:requestWorldbossQuitRoom")
    end

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQ_WORLDBOSS_QUIT_ROOM)
end

function NetActivitySystem:requestWorldbossChangeRoom()
    if(DEBUG) then
        print("NetActivitySystem:requestWorldbossChangeRoom")
    end

    self.worldbossSwitchingRoom = true

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQ_WORLDBOSS_CHANGE_ROOM)
end

function NetActivitySystem:requestWorldbossPrepareBattle()
    if(DEBUG) then
        print("NetActivitySystem:requestWorldbossPrepareBattle")
    end

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQ_WORLDBOSS_PREPARE_BATTLE)
end

--[[
  required uint32 actID = 1;//活动ID
    required uint32 optType = 2;//操作类型LuckyLotteryOptType
    optional uint32 turnNum = 3;//转盘时表明是几连
    optional uint32 costType = 4;//转盘时的消耗类型LuckyLotteryCostType
]]
function NetActivitySystem:requestLuckLottery(activityId, optType, costType, turnNum)
  
    local requestData = {}
    requestData.actID = activityId
    requestData.optType = optType
    requestData.costType = costType
    requestData.turnNum = turnNum
    -- if(DEBUG) then
        print("NetActivitySystem:requestLuckLottery requestData = ", requestData)
    -- end
    Net.Helper:sendMessage(NetMessageType.ACTIVITY_LOTTERY_REQUEST, requestData)
end

-- 请求扭曲空间世界事件处理
function NetActivitySystem:requestDistortedSpaceGlobalEvent()

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_DISTORTED_SPACE_REQ_GLOBAL_EVENT_DATA, nil)
end

-- 请求购买兑换商店
function NetActivitySystem:requestPurchaseExchangeShop(activityId, purchaseId)
    local messageData = {}
    messageData.activityId = activityId
    messageData.purchaseId = purchaseId
    -- print("requestPurchaseExchangeShop", messageData)

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQUEST_PURCHASE_EXCHANGE_SHOP, messageData)
end

-- 请求更新分享活动分享时间
function NetActivitySystem:requestSetShareTime(activityId)
    local messageData = {}
    messageData.activityId = activityId
    print("requestPurchaseExchangeShop", messageData)

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQUEST_SET_SHARE_TIME, messageData)
end

-- 客户端请求周年庆抽奖数据
function NetActivitySystem:requestAnnivesaryLotteryData(activityId)
    local messageData = {}
    messageData.activityId = activityId
    print("requestAnnivesaryLotteryData", messageData)

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQ_ANNIVERSARY_LOTTERY_DATA, messageData)
end

-- 周年庆抽奖报名
function NetActivitySystem:requestAnnivesaryLotterySign(activityId, signType)
    local messageData = {}
    messageData.activityId = activityId
    messageData.signType = signType
    print("requestAnnivesaryLotterySign", messageData)

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQ_ANNIVERSARY_LOTTERY_SIGN, messageData)
end

-- 客户端请求周年庆抽奖已阅读过抽奖结果
function NetActivitySystem:requestAnnivesaryLotteryReadReward(activityId)
    local messageData = {}
    messageData.activityId = activityId

    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQ_ANNIVERSARY_LOTTERY_HAS_READ, messageData)
end

-- 客户端请求周年庆抽奖已阅读过抽奖结果
function NetActivitySystem:requestAnnivesaryLotteryCheckRewardRoster(activityId)
    local messageData = {}
    messageData.activityId = activityId
    print("requestAnnivesaryLotteryCheckRewardRoster", messageData)
    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQ_ANNIVERSARY_LOTTERY_CHECK_READ_RESULT, messageData)
end


-- 客户端请求完成限时登录
function NetActivitySystem:requestTimeLimitedLoginComplete(activityId)
    local messageData = {}
    messageData.activityId = activityId
    Net.Helper:sendMessage(NetMessageType.ACTIVITY_REQ_TIMELIMITED_LOGIN_FINISH, messageData)
end

-- 处理器
function NetActivitySystem:onActivityMessageHandler(no, data)
    if(DEBUG) then
            print("---------NetActivitySystem:onActivityMessageHandler ", no, data)
    end
    if (no == NetMessageType.ACTIVITY_ADD_ACTIVITY_TEMP.NO) then
        if(DEBUG) then
            print("ACTIVITY_ADD_ACTIVITY_TEMP ", data)
        end

        MasterDataManager:addActivityData(data)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_REFRESH)

        if(DEBUG) then
            local activitArr = MasterDataManager:getActivityDataArr()
            print("NetActivitySystem:onActivityMessageHandler ACTIVITY_ADD_ACTIVITY_TEMP ", activitArr)
        end

        local battleCMD = Command.BattleCommand:create(true)
        battleCMD:initTriggerNpcActivityCrying()
        SceneManager:getInstance():pushCommand(battleCMD)
    elseif (no == NetMessageType.ACTIVITY_DEL_ACTIVITY_TEMP.NO) then
        if(DEBUG) then
            print("ACTIVITY_DEL_ACTIVITY_TEMP ", data)
        end

        MasterDataManager:delActivityData(data)

        Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_REFRESH)

        local battleCMD = Command.BattleCommand:create(true)
        battleCMD:initTriggerNpcActivityCrying()
        SceneManager:getInstance():pushCommand(battleCMD)
    elseif (no == NetMessageType.ACTIVITY_ACTIVITY_STATUS_UPDATE.NO) then
        -- 更新活动的状态
        if(DEBUG) then
            print("ACTIVITY_ACTIVITY_STATUS_UPDATE ", data)
        end

        MasterDataManager:updateActivityStatus(data)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_REFRESH)
    elseif (no == NetMessageType.ACTIVITY_HERO_ACTIVITY_DATA.NO) then
        if(DEBUG) then
            print("ACTIVITY_HERO_ACTIVITY_DATA ", data)
        end

        MasterDataManager:initActivityCountData(data)
    elseif (no == NetMessageType.ACTIVITY_UPDATE_ACTIVITY_COUNT.NO) then
        if(DEBUG) then
            print("ACTIVITY_UPDATE_ACTIVITY_COUNT ", data)
        end

        local activityData = MasterDataManager:updateActivityCount(data)
        if(activityData and activityData:getType() ~= PublicDefine.ActivityType.ActivityType_Exchange) then 
            Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_REFRESH, true)
        end
    elseif (no == NetMessageType.ACTIVITY_REPONSE_ACTIVITY_REWARD.NO) then
        if(DEBUG) then
            print("ACTIVITY_REPONSE_ACTIVITY_REWARD", data)
        end
        
        -- 活动领奖结果
        MasterDataManager:removeRepeatHandleData(RepeatHandleType.ACTIVITY_REWARD, data.id..":"..data.subId)

        if(data.result == "ActivityRewardResult_Succeed") then
            -- 处理修改状态
            MasterDataManager:handleReceiveReward(data)
            local LanguageManager = require("app.game.LanguageManager")
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111430))
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_REWARD_RESULT, data)

    --响应请求匹配
    elseif (no == NetMessageType.ACTIVITY_REPONSE_MATCH.NO) then
        UI.WaitingLayer:hideWaiting()
        mvc.festivalModel:joinResp(data.activityID, data.mapID, data.result, data.extra)

        if data.result == ProtobufUtil:enum_id("ActivitySystem.MatchResult", "MatchResult_Ok") then
            TeamDataManager:setReadyState(true)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_CLOSE)
            TeamDataManager:setTeamType(Game.TeamType.FromActivity)
            if not SceneManager:getInstance():getIsInLoading() then
                UI.ScrollBar:createByText(UI.TEXT_1212093)
            end

            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_SHOW_MATCH_TEAM, Game.TeamType.FromActivity)
            SceneManager:getInstance():pushCommand(command)
        else
            if data.result == 204 then -- 惩罚时间
                if not SceneManager:getInstance():getIsInLoading() then 
                    local nowTime = GameManager:getNormalServerTime()
                    local gap = mvc.festivalModel:getCurJoinData().extra - nowTime
                    if gap > 0 then
                        local isClose = false
                        local confirmDialog = UI.ConfirmDialog.showConfrimOnlyShowRed(string.format(UI.TEXT_1213432, gap), function()
                            Avalon.MessageCenter:notice(GameMessage.MC_TEAM_NOTIFY_CANCEL_MATCH)
                            isClose = true
                        end)
                        local function cdUpdate()
                            if isClose or tolua.isnull(confirmDialog) then
                                return
                            end
                            confirmDialog:updateContent(string.format(UI.TEXT_1213432, gap))
                            if gap == 0 then
                                confirmDialog:confirm()
                            end
                            Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, cdUpdate, 1)
                            gap = gap - 1
                        end
                        cdUpdate()
                    end
                end
                mvc.festivalModel:cancleJoinResp()
                TeamDataManager:setReadyState(false)
            else
                TeamDataManager:setReadyState(false)
                GameErrorManager:showError(data.result)
            end
        end
    --通知取消匹配   无内容
    elseif (no == NetMessageType.ACTIVITY_REPONSE_CANCLE_MATCH.NO) then
        UI.WaitingLayer:hideWaiting()
        mvc.festivalModel:cancleJoinResp()
        TeamDataManager:setReadyState(false)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH)
    --匹配成功  无内容
    elseif (no == NetMessageType.ACTIVITY_NOTIFY_MATCH_SUCCESS.NO) then    
        -- require("app.ui.activity.ActivityTimeBarTips")
        print(data)
        if data.mapID == PublicDefine.CONST_DEFINITION.MAZE_MAP_ID 
            or data.mapID == PublicDefine.CONST_DEFINITION.RAT_MAP_ID 
            or data.mapID == PublicDefine.CONST_DEFINITION.BIG_CRACK_MAP_ID
            -- or data.mapID == PublicDefine.CONST_DEFINITION.EASTER_MAP_ID 
            then
            UI.WaitingLayer:hideWaiting()
            mvc.festivalModel:matchSucess(data)
            TeamDataManager:setReadyState(false)
            Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_RESPONSE_MATCH)
        else--新春副本活动 匹配成功后，还有一个倒计时确认匹配
            UI.WaitingLayer:hideWaiting()
            mvc.festivalModel:matchSucess(data)
            TeamDataManager:setReadyState(true) 
            Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_RESPONSE_MATCH)

            local command = Command.ControlCommand:create(true)
            local commandData = {}
            commandData.teamType = Game.TeamType.FromActivity
            commandData.remainTime = data.remainTime
            command:initForTypeAndData(CommandType.CONTROL_SHOW_TEAM_CONFIRE, commandData)
            SceneManager:getInstance():pushCommand(command)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_CLOSE)
        end
        
    elseif (no == NetMessageType.ACTIVITY_REPONSE_SURE_MATCH.NO) then
        if(data.pk == RoleDataManager:getMasterPK()) then
            UI.WaitingLayer:hideWaiting()
            if data.result == ProtobufUtil:enum_id("ActivitySystem.ReponseSureMatchResult", "ReponseSureMatchResult_Succeed") then
                mvc.festivalModel:memberSureUpdate(data.pk)
                Avalon.MessageCenter:notice(AvalonMessage.MC_ACTIVITY_TEAM_FIGHT_ACTIVITY_SURE_REPONSE, true, data.pk)
            else
                GameErrorManager:showError(data.result)
                -- Avalon.MessageCenter:notice(AvalonMessage.MC_ACTIVITY_TEAM_FIGHT_ACTIVITY_SURE_REPONSE, false)
                -- Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_CLOSE)
                TeamDataManager:setReadyState(false)
            end
        end
    elseif (no == NetMessageType.ACTIVITY_NOTIFY_COUNT_DOWN_CANCLE_MATCH.NO) then 
        UI.WaitingLayer:hideWaiting()
        if (not data.rematching) then
            local joinData = mvc.festivalModel:getCurJoinData()
            if joinData and (joinData.mapID == PublicDefine.CONST_DEFINITION.BIG_CRACK_MAP_ID) then
                Game.ChatManager:getInstance():sendSystemMsg(UIUtil:lang(1113128), ChatMessageType.SYSTEM_MESSAGE)
            end
        end

        mvc.festivalModel:CDCancelMatch(data.rematching)
        if data.rematching then
            TeamDataManager:setReadyState(true)
            TeamDataManager:setTeamType(Game.TeamType.FromActivity)

            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_SHOW_MATCH_TEAM, Game.TeamType.FromActivity)
            SceneManager:getInstance():pushCommand(command)
        else
            TeamDataManager:setReadyState(false)
            Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH, data)
        end
        -- if data.isPunishing then
        --     local time = AvalonUtil:_getFullFormatTime(data.punishingTime, false, true) 
        --     UI.ConfirmDialog.showConfrimOnly(string.format(UI.TEXT_1212091, time), nil, nil, nil, nil)
        --     Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH)
        -- else
        --     Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH)
        --     UI.ScrollBar:createByText(UI.TEXT_1212092)
        -- end
    elseif (no == NetMessageType.ACTIVITY_ROOM_MEMBER_CHANGE.NO) then 
        UI.WaitingLayer:hideWaiting()
        mvc.festivalModel:roomMemberChange(data.leavePks)
    elseif (no == NetMessageType.ACTIVITY_NOTIFY_END_CANCLE_MATCH.NO) then 
        UI.WaitingLayer:hideWaiting()
        Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH)
        TeamDataManager:setReadyState(false)
        if data.reason == ProtobufUtil:enum_id("ActivitySystem.CancelMatchReason", "CancelMatchReason_ActivityClosed") then
            UI.ScrollBar:createByTextID(1111668)
        elseif data.reason == ProtobufUtil:enum_id("ActivitySystem.CancelMatchReason", "CancelMatchReason_SystemError") then
            UI.ScrollBar:createByTextID(1170002)
        else
            UI.ScrollBar:createByTextID(1170002)
        end
    elseif (no == NetMessageType.ACTIVITY_DES_UPDATE.NO) then
        MasterDataManager:updateActivityDes(data)
    elseif (no == NetMessageType.ACTIVITY_WORLDBOSS_STATE_BROADCAST.NO) then
        mvc.worldBossModel:updateStateData(data)
    elseif (no == NetMessageType.ACTIVITY_RESP_WORLDBOSS_ROOM_INFO.NO) then
        mvc.worldBossModel:initRoomData(data)

        if self.worldbossSwitchingRoom then
            mvc.worldBossController:onRoomSwitchResponse()
        else
            if mvc.worldBossController then
                mvc.worldBossController:onRoomInitDataResponse()
            end
        end

        self.worldbossSwitchingRoom = false
    elseif (no == NetMessageType.ACTIVITY_RESP_WORLDBOSS_ROOM_INFO_UPDATE.NO) then
        mvc.worldBossModel:updateRoomData(data)

        if mvc.worldBossController then
            mvc.worldBossController:onRoomUpdateDataResponse()
        end
    elseif (no == NetMessageType.ACTIVITY_REQ_WORLDBOSS_QUIT_ROOM.NO) then
        mvc.worldBossModel:rmRoomData()

        if not self.worldbossSwitchingRoom and mvc.worldBossController then
            mvc.worldBossController:onRemoveRoomResponse()
        end
    elseif (no == NetMessageType.ACTIVITY_RESP_WORLDBOSS_PERSONAL_DATA_UPDATE.NO) then
        mvc.worldBossModel:updatePersonalStateData(data)
    elseif (no == NetMessageType.ACTIVITY_LOTTERY_RESPONSE.NO) then
        UI.WaitingLayer:hideWaiting()
        Avalon.MessageCenter:notice(AvalonMessage.MC_ACTIVITY_LUCKY_LOTTERY_RESULT, data)
        if data.result ~= ProtobufUtil:enum_id("ActivitySystem.LuckyLotteryResult", "LuckyLotteryResult_Succeed") then
            GameErrorManager:showError(data.result)
        end
        -- SC 回复扭曲空间全局事件
    elseif (no == NetMessageType.ACTIVITY_DISTORTED_SPACE_RSW_GLOBAL_EVENT_DATA.NO) then
        -- print("ACTIVITY_DISTORTED_SPACE_RSW_GLOBAL_EVENT_DATA", type(data), data)
        if(type(data) == "table" and ProtobufUtil:checkFieldIsInit(data, "datas")) then
            MasterDataManager:handleWorldEventData(data.datas)
            TaskDataManager:triggerAcceptTask()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_SPACE_WORLD_EVENT)  
        end
    elseif (no == NetMessageType.ACTIVITY_RESPONSE_PURCHASE_EXCHANGE_SHOP.NO) then
        -- print("ACTIVITY_RESPONSE_PURCHASE_EXCHANGE_SHOP", data)
        mvc.send(mvc.events.Festival_ExchangeShopExchangeResult, data)
    elseif (no == NetMessageType.ACTIVITY_RESP_ANNIVERSARY_LOTTERY_READ_RESULT.NO) then
        mvc.activityAnnivesaryLotteryModel:setLotteryRewardRoster(data)
        if data.rewardState == 3 and data.luckName and #data.luckName > 0 then
            mvc.send("ActivityAnnivesary_Show_Reward_Roster_View", data)
        end
    elseif (no == NetMessageType.ACTIVITY_RESP_TIMELIMITED_LOGIN_FINISH.NO) then
        if not data.isFinish then
            MasterDataManager:setLimitTimeLoginTaskOpenStat(true)
        end
    else
        print(string.format("[WARNING] NetGMSystem no handler for this message. [no:%d data:%s]", no, data))
    end
end