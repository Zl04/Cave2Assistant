--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2019-07-30 21:06:01
]]
require("app.datas.MasterDataManager")
require "utils.MathUtil"
local ProtobufUtil = require("utils.ProtobufUtil")

Net = Net or {}
local NetMentorSystem = {}
Net.NetMentorSystem = NetMentorSystem

local DEBUG = false

-- 请求推荐列表
function NetMentorSystem:requestRecommendTutorListMessage()
    Net.Helper:sendMessage(NetMessageType.MENTOR_REQUEST_RECOMMEND_TUTOR_LIST_MESSAGE)
end

-- 请求拜师
function NetMentorSystem:requestInviteTutorMessage(reqPk, targetPk)
    -- required uint64 reqPk = 1;      //请求PK
    -- required uint64 targetPk = 2;   //目标PK
    local messageData = {
        reqPk = reqPk,
        targetPk = targetPk,
    }
    
    Net.Helper:sendMessage(NetMessageType.MENTOR_REQUEST_INVITE_TUTOR_MESSAGE, messageData)
end

-- 请求清除导师申请列表
function NetMentorSystem:clearApplyList()
    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    local messageData = {
        pk = masterPK,
    }
    
    Net.Helper:sendMessage(NetMessageType.MENTOR_CLEAR_REQUEST_LIST_MESSAGE, messageData)
end

-- 请求确认关系
function NetMentorSystem:confirmTutorMessage(reqPk, targetPk, mode)
    -- required uint64 reqPk = 1;      //请求PK
    -- required uint64 targetPk = 2;   //目标PK
    -- required uint32 mode = 3;       //修改类型ConfirmTutorMode
    -- enum ConfirmTutorMode {
    --     ConfirmTutorMode_Agree = 1; //同意
    --     ConfirmTutorMode_Cancel = 2;    //取消
    -- }
    local messageData = {
        reqPk = reqPk,
        targetPk = targetPk,
        mode = mode,
    }
    
    Net.Helper:sendMessage(NetMessageType.MENTOR_CONFIRM_TUTOR_MESSAGE, messageData)
end

-- 请求导师好评差评
function NetMentorSystem:tutorInteractMessage(reqPk, targetPk, mode)
    -- required uint64 reqPk = 1;      //请求PK
    -- required uint64 targetPk = 2;   //目标PK
    -- required uint32 mode = 3;       //互动类型 TutorInteractMode
    -- enum TutorInteractMode {
    --     TutorInteractMode_Praise = 1;   //赞
    --     TutorInteractMode_Criticize = 2;//踩
    -- }
    local messageData = {
        reqPk = reqPk,
        targetPk = targetPk,
        mode = mode,
    }
    
    Net.Helper:sendMessage(NetMessageType.MENTOR_TUTOR_INTERACT_MESSAGE, messageData)
end

-- 请求任务完成
function NetMentorSystem:tutorTaskChangeMessage(tarPk)
    -- required uint64 tarPk = 1;  //对象PK
    -- optional HeroTutorTask changeTask = 2;
    -- optional uint32 ConfirmStat = 3;    //确认状态
    -- optional uint32 taskRefreshDay = 4; //任务刷新day
    local messageData = {
        tarPk = tarPk,
    }
    
    Net.Helper:sendMessage(NetMessageType.MENTOR_TUTOR_TASK_CHANGE_MESSAGE, messageData)
end

-- 请求奖励
function NetMentorSystem:getTutorRewardMessage(rewardType, targetPk, rewardStat)
    -- optional uint32 rewardType = 1; //领奖类型TutorRewardType
    -- optional uint64 targetPk = 2;   //领奖目标PK
    -- optional uint32 rewardStat =3;  //领奖阶段
    -- enum TutorRewardType {
    --     TutorRewardType_Daily = 1;  //每日奖励
    --     TutorRewardType_Tutor = 2;  //出师奖励
    --     TutorRewardType_Stage = 3;  //阶段奖励
    --     TutorRewardType_Interact = 4;  //互动奖励
    -- }
    local messageData = {
        rewardType = rewardType,
        targetPk = targetPk,
        rewardStat = rewardStat,
    }
    
    Net.Helper:sendMessage(NetMessageType.MENTOR_GET_TUTOR_REWARD_MESSAGE, messageData)
end

-- 设置不当导师
function NetMentorSystem:mentorSettingMessage(isReject)
    -- message TutorSettingMessage {
    --     required bool isReject = 1;
    -- }
    local messageData = {
        isReject = isReject
    }
    
    Net.Helper:sendMessage(NetMessageType.MENTOR_TUTOR_SETTING_MESSAGE, messageData)
end



















-- 师徒消息处理
function NetMentorSystem:onMentorMessageHandler(no, data)
    -- print("NetMentorSystem:onMentorMessageHandler", no, data)

    -- 回复导师推荐列表
    if (no == NetMessageType.MENTOR_RESPONSE_RECOMMEND_TUTOR_LIST_MESSAGE.NO) then
        -- repeated TutorData tutorList = 1;   //推荐的导师列表
        -- //关系角色数据
        -- message TutorData {
        --     required uint64 PK = 1;
        --     optional uint32 loginStatus = 3;             
        --     optional string nickName = 4;           //昵称
        --     optional uint64 userID = 5;
        --     optional uint32 sex = 6;                // 性别
        --     optional uint32 faceDecodeID = 7;       // 脸
        --     optional uint64 updateTimestamp = 9;    //更新的时间戳
        --     optional uint32 roleLV = 10;     
        --     optional bool isInCave = 11;        
        --     optional uint32 offlineTime = 12;       // 当状态为离线时该值有效
        --     optional HeroTutorTask task = 13;       //导师任务数据
        --     optional uint32 taskStat = 14;
        --     optional uint32 taskRefreshDay = 15;
        --     optional uint32 Praise = 16; //赞
        --     optional uint32 Criticize = 17;  //踩
        -- }
        -- {
        --     tutorList = {
        --         {
        --             PK = 17828611, 
        --             updateTimestamp = 618690100, 
        --             userID = 4236145, 
        --             nickName = "\233\130\174\229\183\174\229\165\189\231\186\166\231\145\159\229\164\171", 
        --             sex = 1, 
        --             faceDecodeID = 2020401
        --         }
        --     }
        -- }
        mvc.send(mvc.events.MENTOR_RESPONSE_RECOMMEND_TUTOR_LIST_MESSAGE, data)
    -- 回复申请导师
    elseif (no == NetMessageType.MENTOR_RESPONSE_INVITE_TUTOR_MESSAGE.NO) then
        -- required uint64 reqPk = 1;      //请求PK
        -- required uint64 targetPk = 2;   //目标PK
        -- required uint32 result = 3;     //请求结果 InviteTutorResult
        -- enum InviteTutorResult{
        --     InviteTutorResult_Success = 1;
        --     InviteTutorResult_Systemerror = 2;
        -- }
        -- {
        --     result = 2, 
        --     reqPk = 17830407, 
        --     targetPk = 17828611
        -- }
        mvc.send(mvc.events.MENTOR_RESPONSE_INVITE_TUTOR_MESSAGE, data)
    -- 回复确认关系
    elseif (no == NetMessageType.MENTOR_CONFIRM_TUTOR_RESULT_MESSAGE.NO) then
        -- required uint64 reqPk = 1;      //请求PK
        -- required uint64 targetPk = 2;   //目标PK
        -- required uint32 mode = 3;       //修改类型ConfirmTutorMode
        -- required uint32 result = 4;     //修改结果ConfirmTutorResultResult
        -- enum ConfirmTutorMode {
        --     ConfirmTutorMode_Agree = 1; //同意
        --     ConfirmTutorMode_Cancel = 2;    //取消
        -- }
        -- required uint32 result = 4;     //修改结果ConfirmTutorResultResult
        -- enum ConfirmTutorResultResult {
        --     ConfirmTutorResultResult_Success = 1;
        --     ConfirmTutorResultResult_Systemerror = 2; 
        --     GetTutorRewardResult_AlreadyHaveTutor = 3;
        -- }
        mvc.send(mvc.events.MENTOR_CONFIRM_TUTOR_RESULT_MESSAGE, data)
    -- 回复加载导师关系
    elseif (no == NetMessageType.MENTOR_LOAD_TUTOR_ARCHIVE_MESSAGE.NO) then
        -- required uint64 PK = 1;
        -- optional TutorData tutorPk = 2;    //导师PK
        -- repeated TutorData studentPk = 3;  //学徒PK
        -- repeated TutorData requestPk = 4;   //请求list
        -- //关系角色数据
        -- message TutorData {
        --     required uint64 PK = 1;
        --     optional uint32 loginStatus = 3;             
        --     optional string nickName = 4;           //昵称
        --     optional uint64 userID = 5;
        --     optional uint32 sex = 6;                // 性别
        --     optional uint32 faceDecodeID = 7;       // 脸
        --     optional uint64 updateTimestamp = 9;    //更新的时间戳
        --     optional uint32 roleLV = 10;     
        --     optional bool isInCave = 11;        
        --     optional uint32 offlineTime = 12;       // 当状态为离线时该值有效
        --     optional HeroTutorTask task = 13;       //导师任务数据
        --     optional uint32 taskStat = 14;
        --     optional uint32 taskRefreshDay = 15;
        --     optional uint32 Praise = 16; //赞
        --     optional uint32 Criticize = 17;  //踩
        -- }
        -- optional uint64 updateTimestamp = 5;        //更新时间戳
        -- optional bool isSend = 6;           //是否直接发送
        -- {
            -- PK = 17828611, 
            -- tutorPk = {
            --     sex = 1, 
            --     nickName = "\230\183\183\228\185\177\228\184\173\231\171\139\231\172\168\231\186\166\231\191\176", 
            --     faceDecodeID = 2020304, 
            --     PK = 17830407, 
            --     taskRefreshDay = 0, 
            --     taskStat = 0, 
            --     updateTimestamp = 447154158, 
            --     userID = 0, 
            --     isInCave = false, 
            --     roleLV = 8
            -- }, 
            -- studentPk = {
            --     {
            --         sex = 1, 
            --         nickName = "\230\183\183\228\185\177\228\184\173\231\171\139\231\172\168\231\186\166\231\191\176", 
            --         faceDecodeID = 2020304, 
            --         PK = 17830407, 
            --         taskRefreshDay = 0, 
            --         taskStat = 0, 
            --         updateTimestamp = 447154158, 
            --         userID = 0, 
            --         isInCave = false, 
            --         roleLV = 8
            --     }
            -- }, 
            -- requestPk = {
            --     {
            --         sex = 1, 
            --         nickName = "\230\183\183\228\185\177\228\184\173\231\171\139\231\172\168\231\186\166\231\191\176", 
            --         faceDecodeID = 2020304, 
            --         PK = 17830407, 
            --         taskRefreshDay = 0, 
            --         taskStat = 0, 
            --         updateTimestamp = 447154158, 
            --         userID = 0, 
            --         isInCave = false, 
            --         roleLV = 8
            --     }
            -- }
        -- }
        mvc.send(mvc.events.MENTOR_LOAD_TUTOR_ARCHIVE_MESSAGE, data)
    -- 回复导师好评差评
    elseif (no == NetMessageType.MENTOR_TUTOR_INTERACT_RESULT_MESSAGE.NO) then
        -- required uint64 Pk = 1;      //PK
        -- optional uint32 Praise = 2; //赞
        -- optional uint32 Criticize = 3;  //踩
        -- optional uint32 InteractNum = 4;    //互动次数
        mvc.send(mvc.events.MENTOR_TUTOR_INTERACT_RESULT_MESSAGE, data)
    -- 学生任务改变
    elseif (no == NetMessageType.MENTOR_TUTOR_TASK_CHANGE_MESSAGE.NO) then
        -- required uint64 tarPk = 1;  //对象PK
        -- optional HeroTutorTask changeTask = 2;
        -- optional uint32 ConfirmStat = 3;    //确认状态
        -- optional uint32 taskRefreshDay = 4; //任务刷新day
        -- message HeroTutorTask {
        --     repeated TutorTaskData taskList = 1;
        -- }
        -- //导师任务数据
        -- message TutorTaskData {
        --     required uint32 id = 1;
        --     optional uint32 num = 2;
        --     optional uint32 stat = 3;
        -- }
        mvc.send(mvc.events.MENTOR_TUTOR_TASK_CHANGE_MESSAGE, data)
    -- 回复师徒领奖
    elseif (no == NetMessageType.MENTOR_GET_TUTOR_REWARD_RESULT_MESSAGE.NO) then
        -- optional uint32 rewardType = 1; //领奖类型TutorRewardType
        -- optional uint64 targetPk = 2;   //领奖目标PK
        -- optional uint32 rewardStat =3;  //领奖阶段
        -- optional uint32 result = 4; //GetTutorRewardResult
        -- enum TutorRewardType {
        --     TutorRewardType_Daily = 1;  //每日奖励
        --     TutorRewardType_Tutor = 2;  //出师奖励
        --     TutorRewardType_Stage = 3;  //阶段奖励
        -- }
        -- enum GetTutorRewardResult {
        --     GetTutorRewardResult_Success = 1;
        --     GetTutorRewardResult_Systemerror = 2;
        -- }
        mvc.send(mvc.events.MENTOR_GET_TUTOR_REWARD_RESULT_MESSAGE, data)
    -- 泛用信息推送
    elseif (no == NetMessageType.MENTOR_ROLE_TUTOR_DATA_MESSAGE.NO) then
        -- optional uint32 nextTutorTime = 1;   //下一次导师关系确认的时间
        -- optional uint32 dailyReqNum = 2;    //每日申请的次数
        -- optional uint32 dailyTutorNum = 3;  //每日收徒的次数
        -- optional bool isReject = 4;         //是否拒绝收徒
        -- repeated TutorRewardStat rewardStat  = 5;   //导师奖励领取状态
        -- optional bool isOutTutor = 6;       //是否出师    
        -- optional bool isOutTutorReward = 7;   //出师奖励是否领取
        -- optional uint32 dailyInteractNum = 8;   //每日互动次数
        -- optional uint32 nextInteractTime = 9;   //下次互动时间
        -- message TutorRewardStat {
        --     required uint64 stuPk = 1;  //徒弟PK
        --     optional uint32 dailyRewardStat = 2; //每日任务奖励领奖状态
        --     optional uint32 totalRewardStat = 3;      //阶段奖励领取状态  
        -- }
        mvc.send(mvc.events.MENTOR_ROLE_TUTOR_DATA_MESSAGE, data)
    elseif (no == NetMessageType.MENTOR_NTF_TUTOR_CHANGE_MESSAGE.NO) then
        local mentorName = nil
        if (ProtobufUtil:checkFieldIsInit(data, "tutorName") and data.tutorName:gsub("\"", "") ~= "") then
            mentorName = data.tutorName
        end
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        if(machine and machine._model) then
            local role = machine._model:getRoleBySpriteID(data.spriteID)
            if(role) then
                role:setMentorName(data.tutorName)
            end
        end

        local SceneManager = require("app.game.SceneManager")
        local titleCommand = Command.BattleCommand:create(true)
        titleCommand:initForRoleTitle(data.spriteID)
        SceneManager:getInstance():pushCommand(titleCommand)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_TITLE_CHANGE, self.heroTitle, self:getPK(), self:isMasterHero())
    else
        assert(false, string.format("[Net.NetMentorSystem] onMentorMessageHandler no %d is invaild.", no))
    end    
end
