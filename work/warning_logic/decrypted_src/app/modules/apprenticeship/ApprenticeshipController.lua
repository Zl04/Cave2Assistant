--[[--
控制器ApprenticeshipController，view已经注入,可以通过mvc.apprenticeshipProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: CMonk
-- date	: 2019/07/30
-- desc	: 
------------------------------------------------------------------------------
require "app.net.NetMentorSystem"

local ApprenticeshipController = class("ApprenticeshipController", mvc.GameController)

local ProtobufUtil = require("utils.ProtobufUtil")
local LanguageManager = require("app.game.LanguageManager")

-- 请求推荐列表
function ApprenticeshipController:requestRecommendTutorList(isShowWarning)
    local timeNow = GameManager:getNormalServerTime()
    if (self._nextRequestTime and self._nextRequestTime > timeNow) then 
        if (isShowWarning) then
            local secondsLeft = math.ceil(self._nextRequestTime - timeNow)
            UI.ScrollBar:createByText(tostring(secondsLeft) .. LanguageManager:getInstance():getLocalString(1112633) --[["秒后才能刷新"]])
        end
        return
    end
    self._nextRequestTime = GameManager:getNormalServerTime() + 10

    Net.NetMentorSystem:requestRecommendTutorListMessage()
end

-- 请求查看详情
function ApprenticeshipController:viewRecommendMentorDetail(idx)
    local recommandMentor = mvc.apprenticeshipModel:getMentorRecommendationList()[idx]
    if (not recommandMentor or not recommandMentor.userID) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112684) --[["导师信息错误"]])
        return
    end
    if (recommandMentor.userID == 0) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112685) --[["导师不在线, 请稍后再拨"]])
        return
    end

    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()

    GameManager:heroDetailRequest(recommandMentor.PK, recommandMentor.userID)
end

-- 请求拜师
function ApprenticeshipController:applyForMentor(idx)
    local isAble, reason = mvc.apprenticeshipModel:isAbleToApprentice()
    if (not isAble) then
        if (reason == mvc.apprenticeshipModel.APPRENTICE_UNABLE_REASON.LV) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112686) --[["等级不足, 不能拜师"]])           
        elseif (reason == mvc.apprenticeshipModel.APPRENTICE_UNABLE_REASON.DAILY_NUM) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112687) --[["今日拜师次数已用光"]])
        elseif (reason == mvc.apprenticeshipModel.APPRENTICE_UNABLE_REASON.CD) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112688) --[["过一段时间才能再拜师了"]])
        elseif (reason == mvc.apprenticeshipModel.APPRENTICE_UNABLE_REASON.ALREADY_IS) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111118) --[["系统错误"]])
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111118) --[["系统错误"]])
        end
        return
    end

    local recommandMentor = mvc.apprenticeshipModel:getMentorRecommendationList()[idx]
    if (not recommandMentor) then return end

    self:applyForMentorByPK(recommandMentor.PK)
end

-- 用PK请求拜师
function ApprenticeshipController:applyForMentorByPK(pk)
    -- 检查城镇
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():isInFightScene()) then 
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112830) --[["此场景不可拜师"]])
        return 
    end

    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()

    Net.NetMentorSystem:requestInviteTutorMessage(masterPK, pk)
end

-- 导师请求清空申请列表
function ApprenticeshipController:clearApplyList()
    local applyNum = mvc.apprenticeshipModel:getApprenticeApplyCount()
    if (applyNum <= 0) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112689) --[["不用清啦, 列表是空的"]])
        return 
    end

    Net.NetMentorSystem:clearApplyList()
end

-- 导师同意
function ApprenticeshipController:mentorAgree(idx)
    local isAble, reason = mvc.apprenticeshipModel:isAbleToMentor()
    if (not isAble) then
        if (reason == mvc.apprenticeshipModel.MENTOR_UNABLE_REASON.LV) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112690) --[["等级不足, 不能收徒"]])           
        elseif (reason == mvc.apprenticeshipModel.MENTOR_UNABLE_REASON.DAILY_NUM) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112691) --[["今日收徒次数已用光"]])            
        elseif (reason == mvc.apprenticeshipModel.MENTOR_UNABLE_REASON.CD) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112692) --[["过一段时间才能再收徒弟了"]])
        elseif (reason == mvc.apprenticeshipModel.MENTOR_UNABLE_REASON.FULL) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112693) --[["徒弟数量已满"]])
        elseif (reason == mvc.apprenticeshipModel.MENTOR_UNABLE_REASON.NOT_ALLOW) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112694) --[["收徒已在设置中被禁用"]])
        elseif (reason == mvc.apprenticeshipModel.MENTOR_UNABLE_REASON.GRADUATE_REWARD) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112695) --[["毕业奖励还未领取"]])
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111118) --[["系统错误"]])
        end
        return
    end

    local applier = mvc.apprenticeshipModel:getApprenticeApplyByIndex(idx)
    if (not applier) then return end

    local timeNow = GameManager:getNormalServerTime()
    if (self._nextAgreeTime and self._nextAgreeTime > timeNow) then return end
    self._nextAgreeTime = timeNow + 1

    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()

    Net.NetMentorSystem:confirmTutorMessage(
        masterPK,
        applier.PK,
        ProtobufUtil:enum_id("TutorSystem.ConfirmTutorMode","ConfirmTutorMode_Agree"))
end

-- 舍弃导师
function ApprenticeshipController:cancelMentor()
    local mentor = mvc.apprenticeshipModel:getMentor()
    if (not mentor) then return end

    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    Net.NetMentorSystem:confirmTutorMessage(
        masterPK,
        mentor.PK,
        ProtobufUtil:enum_id("TutorSystem.ConfirmTutorMode","ConfirmTutorMode_Cancel"))
end

-- 通过下标舍弃学徒
function ApprenticeshipController:cancelApprenticeByIdx(idx)
    local apprentice = mvc.apprenticeshipModel:getApprenticeByIndex(idx)
    if (not apprentice) then return end

    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    Net.NetMentorSystem:confirmTutorMessage(
        masterPK,
        apprentice.PK,
        ProtobufUtil:enum_id("TutorSystem.ConfirmTutorMode","ConfirmTutorMode_Cancel"))
end

-- 导师确认任务
function ApprenticeshipController:mentorConfirmQuestByIndex(idx)
    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    local applier = mvc.apprenticeshipModel:getApprenticeByIndex(idx)
    if (not applier) then return end

    Net.NetMentorSystem:tutorTaskChangeMessage(applier.PK)
end

-- 学徒确认任务
function ApprenticeshipController:apprenticeConfirmQuest()
    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    Net.NetMentorSystem:tutorTaskChangeMessage(masterPK)
end

-- 学徒给导师踩赞, 1赞 2踩
function ApprenticeshipController:apprenticeMentorInteract(mode)
    local isAble, timeToAble = mvc.apprenticeshipModel:apprenticeIsAbleToInteract()
    if (not isAble) then 
        if (timeToAble) then
            local minutes = math.ceil(timeToAble / 60)
            UI.ScrollBar:createByText(string.format("%s分钟后才能再次操作", minutes))
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112696) --[["明天才能再次操作"]])
        end
        return 
    end

    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    local mentor = mvc.apprenticeshipModel:getMentor()
    if (not mentor) then return end

    Net.NetMentorSystem:tutorInteractMessage(masterPK, mentor.PK, mode)
end

-- 导师获得每日奖励
function ApprenticeshipController:mentorGetDailyRewardByIndex(idx)
    -- 检查城镇
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():isInFightScene()) then 
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112420) --[["此场景不可领奖"]])
        return 
    end

    -- 检查背包满
    local itemIDArr, itemNumArr = mvc.apprenticeshipModel:mentorGetDailyRewardItemArr()
    if (not self:isEnoughBagSpaceForItems(itemIDArr, itemNumArr)) then return end

    local apprentice = mvc.apprenticeshipModel:getApprenticeByIndex(idx)
    if (not apprentice) then return end

    local rewardType = ProtobufUtil:enum_id("TutorSystem.TutorRewardType","TutorRewardType_Daily")
    Net.NetMentorSystem:getTutorRewardMessage(rewardType, apprentice.PK)
end

-- 导师获得学员进度奖励
function ApprenticeshipController:mentorGetResultRewardByIndex(apprenticeIdx, resultIdx)
    -- 检查城镇
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():isInFightScene()) then 
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112420) --[["此场景不可领奖"]])
        return 
    end

    -- 检查背包满
    local itemIDArr, itemNumArr = mvc.apprenticeshipModel:mentorGetStageRewardItemArrByIndex(resultIdx)
    if (not self:isEnoughBagSpaceForItems(itemIDArr, itemNumArr)) then return end

    local apprentice = mvc.apprenticeshipModel:getApprenticeByIndex(apprenticeIdx)
    if (not apprentice) then return end

    local timeNow = GameManager:getNormalServerTime()
    if (self._nextMentorResultTime and self._nextMentorResultTime > timeNow) then return end
    self._nextMentorResultTime = timeNow + 1

    local rewardType = ProtobufUtil:enum_id("TutorSystem.TutorRewardType","TutorRewardType_Stage")
    Net.NetMentorSystem:getTutorRewardMessage(rewardType, apprentice.PK, resultIdx)
end

-- 导师获得学员点赞奖励
function ApprenticeshipController:mentorGetPraiseRewardByIndex(idx)
    -- 检查城镇
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():isInFightScene()) then 
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112420) --[["此场景不可领奖"]])
        return 
    end

    -- 检查背包满
    local itemIDArr, itemNumArr = mvc.apprenticeshipModel:mentorGetInteractRewardItemArr()
    if (not self:isEnoughBagSpaceForItems(itemIDArr, itemNumArr)) then return end

    local apprentice = mvc.apprenticeshipModel:getApprenticeByIndex(idx)
    if (not apprentice) then return end

    local timeNow = GameManager:getNormalServerTime()
    if (self._nextMentorPraiseRewardTime and self._nextMentorPraiseRewardTime > timeNow) then return end
    self._nextMentorPraiseRewardTime = timeNow + 1

    local rewardType = ProtobufUtil:enum_id("TutorSystem.TutorRewardType","TutorRewardType_Interact")
    Net.NetMentorSystem:getTutorRewardMessage(rewardType, apprentice.PK)
end

-- 学员获取每日奖励
function ApprenticeshipController:apprenticeGetDailyReward()
    -- 检查城镇
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():isInFightScene()) then 
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112420) --[["此场景不可领奖"]])
        return 
    end

    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    local rewardType = ProtobufUtil:enum_id("TutorSystem.TutorRewardType","TutorRewardType_Daily")
    Net.NetMentorSystem:getTutorRewardMessage(rewardType, masterPK)
end

-- 学员获取毕业奖励
function ApprenticeshipController:apprenticeGetGraduationReward()
    -- 检查城镇
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():isInFightScene()) then 
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112420) --[["此场景不可领奖"]])
        return 
    end

    -- 检查背包满
    local itemIDArr, itemNumArr = mvc.apprenticeshipModel:apprenticeGetGraduateRewardItemArr()
    if (not self:isEnoughBagSpaceForItems(itemIDArr, itemNumArr)) then return end

    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    local rewardType = ProtobufUtil:enum_id("TutorSystem.TutorRewardType","TutorRewardType_Tutor")
    Net.NetMentorSystem:getTutorRewardMessage(rewardType, masterPK)
end

-- 导师设置不收徒
function ApprenticeshipController:mentorSetting(isReject)
    Net.NetMentorSystem:mentorSettingMessage(isReject)
end

-- 导师更新学徒角色信息(1分钟一次)
function ApprenticeshipController:mentorUpdateApprenticeInfoByIndex(idx)
    local apprentice = mvc.apprenticeshipModel:getApprenticeByIndex(idx)
    if (not apprentice or not apprentice.userID or apprentice.userID == 0 or not self:updateInfoUpdateTimer()) then return end

    GameManager:heroDetailRequest(apprentice.PK, apprentice.userID, false)
end

-- 学徒更新导师角色信息(1分钟一次)
function ApprenticeshipController:apprenticeUpdateMentorInfo()
    local mentor = mvc.apprenticeshipModel:getMentor()
    if (not mentor or not mentor.userID or mentor.userID == 0 or not self:updateInfoUpdateTimer()) then return end
    
    GameManager:heroDetailRequest(mentor.PK, mentor.userID, false)
end

-- 更新信息计时器
function ApprenticeshipController:updateInfoUpdateTimer(forceSetTimer)
    local timeNow = GameManager:getNormalServerTime()
    if (forceSetTimer) then self._nextInfoUpdateTime = timeNow + 60 end
    if (self._nextInfoUpdateTime and self._nextInfoUpdateTime > timeNow) then return false end
    self._nextInfoUpdateTime = timeNow + 60
    return true
end

-- 检查背包空间
function ApprenticeshipController:isEnoughBagSpaceForItems(itemIDArr, itemNumArr)
    local goodsArr = {}
    for i,goodsID in ipairs(itemIDArr) do
        local num = itemNumArr[i]
        local data = {}
        data.goodsID = goodsID
        data.num = num or 1
        data.isGolden = true
        table.insert(goodsArr, data)
    end
    local GameDataManager = require("app.game.GameDataManager")
    local isEnough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
    if (not isEnough) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170081) --[["背包空间不足"]])
        return false
    end
    return true
end

-- 更新称号
function ApprenticeshipController:updateTitle()
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():getIsInLoading()) then return end

    require "app.datas.RoleDataManager"
    local masterData = RoleDataManager:getMaster()
    if (masterData) then
        local titleCommand = Command.BattleCommand:create(true)
        titleCommand:initForRoleTitle(masterData:getSpriteID())
        SceneManager:getInstance():pushCommand(titleCommand)
    end
end


























-------------------------------------网络消息-----
-- 回复导师推荐列表
-- mvc.events.MENTOR_RESPONSE_RECOMMEND_TUTOR_LIST_MESSAGE 处理函数
function ApprenticeshipController:noticeMENTORRESPONSERECOMMENDTUTORLISTMESSAGE(notification, data)
    -- 更新申请列表
    mvc.apprenticeshipModel:netUpdateMentorRecommandationList(data)

    -- 刷新表现
    if (self.apprenticeshipApplyView) then
        self.apprenticeshipApplyView:updateRecommendView()
    end
end


-- 回复申请导师
-- mvc.events.MENTOR_RESPONSE_INVITE_TUTOR_MESSAGE 处理函数
function ApprenticeshipController:noticeMENTORRESPONSEINVITETUTORMESSAGE(notification, data)
    if (data.result == ProtobufUtil:enum_id("TutorSystem.InviteTutorResult","InviteTutorResult_Success")) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112697) --[["导师申请成功"]])
    elseif (data.result == ProtobufUtil:enum_id("TutorSystem.InviteTutorResult","InviteTutorResult_Systemerror")) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112698) --[["导师申请失败"]])
    elseif (data.result == ProtobufUtil:enum_id("TutorSystem.InviteTutorResult","InviteTutorResult_TutorRequirementNotMet")) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170249) --[["角色不满足导师条件"]])
    elseif (data.result == ProtobufUtil:enum_id("TutorSystem.InviteTutorResult","InviteTutorResult_TutorExceedDailyLimit")) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170250) --[["导师日收徒次数已满"]])
    elseif (data.result == ProtobufUtil:enum_id("TutorSystem.InviteTutorResult","InviteTutorResult_TutorInCD")) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170251) --[["导师收徒冷却中"]])
    end

    -- 更新按钮显示
    Avalon.MessageCenter:notice(GameMessage.MC_MENTOR_MESSAGE_UPDATE_BUTTONS)
end


-- 回复确认关系
-- mvc.events.MENTOR_CONFIRM_TUTOR_RESULT_MESSAGE 处理函数
function ApprenticeshipController:noticeMENTORCONFIRMTUTORRESULTMESSAGE(notification, data)
    -- 提示成功失败
    local modeStr = LanguageManager:getInstance():getLocalString(1112699) --[["请求"]]
    if (data.mode == ProtobufUtil:enum_id("TutorSystem.ConfirmTutorMode","ConfirmTutorMode_Agree")) then
        modeStr = LanguageManager:getInstance():getLocalString(1112700) --[["建立关系"]]
    elseif (data.mode == ProtobufUtil:enum_id("TutorSystem.ConfirmTutorMode","ConfirmTutorMode_Cancel")) then 
        modeStr = LanguageManager:getInstance():getLocalString(1112701) --[["断绝关系"]]
    end
    if (data.result == ProtobufUtil:enum_id("TutorSystem.ConfirmTutorResultResult","ConfirmTutorResultResult_Success")) then
        UI.ScrollBar:createByText(modeStr .. LanguageManager:getInstance():getLocalString(1170001) --[["成功"]])
    elseif (data.result == ProtobufUtil:enum_id("TutorSystem.ConfirmTutorResultResult","ConfirmTutorResultResult_Systemerror")) then
        UI.ScrollBar:createByText(modeStr .. LanguageManager:getInstance():getLocalString(1111818) --[["失败"]])
    elseif (data.result == ProtobufUtil:enum_id("TutorSystem.ConfirmTutorResultResult","ConfirmTutorResultResult_AlreadyHaveTutor")) then
        UI.ScrollBar:createByText(modeStr .. LanguageManager:getInstance():getLocalString(1112702) --[["失败, 已有导师"]])
    end

    -- 断绝关系, 关闭界面
    if (data.mode == ProtobufUtil:enum_id("TutorSystem.ConfirmTutorMode","ConfirmTutorMode_Cancel") and 
        data.result == ProtobufUtil:enum_id("TutorSystem.ConfirmTutorResultResult","ConfirmTutorResultResult_Success")) 
    then
        mvc.apprenticeshipModel:removeMentor()
        mvc.apprenticeshipModel:removeApprentice(data.targetPk)
        mvc.closePanel("Apprenticeship", "ApprenticeshipMentor")
        mvc.closePanel("Apprenticeship", "ApprenticeshipApprentice")
    end

    -- 建立成功, 检查导师是否满员, 满员关闭界面
    if (data.mode == ProtobufUtil:enum_id("TutorSystem.ConfirmTutorMode","ConfirmTutorMode_Agree") and 
        data.result == ProtobufUtil:enum_id("TutorSystem.ConfirmTutorResultResult","ConfirmTutorResultResult_Success")) 
    then
        if (#mvc.apprenticeshipModel:getApprenticeArr() >= 2) then
            mvc.closePanel("Apprenticeship", "ApprenticeshipReceive")
        end
    end

    -- 更新按钮显示
    Avalon.MessageCenter:notice(GameMessage.MC_MENTOR_MESSAGE_UPDATE_BUTTONS)
end


-- 回复加载导师关系
-- mvc.events.MENTOR_LOAD_TUTOR_ARCHIVE_MESSAGE 处理函数
function ApprenticeshipController:noticeMENTORLOADTUTORARCHIVEMESSAGE(notification, data)
    mvc.apprenticeshipModel:netUpdateApprenticeApplyList(data)
    mvc.apprenticeshipModel:netUpdateMentor(data)
    mvc.apprenticeshipModel:netUpdateApprentice(data)

    if (self.apprenticeshipMentorView) then self.apprenticeshipMentorView:updateView() end
    if (self.apprenticeshipApprenticeView) then self.apprenticeshipApprenticeView:updateView() end
    if (self.apprenticeshipApplyView) then self.apprenticeshipApplyView:updateView() end
    if (self.apprenticeshipReceiveView) then self.apprenticeshipReceiveView:updateView() end
    if (self.apprenticeshipMentorResultView) then self.apprenticeshipMentorResultView:updateView() end

    -- 更新称号
    self:updateTitle()

    -- 更新按钮显示
    Avalon.MessageCenter:notice(GameMessage.MC_MENTOR_MESSAGE_UPDATE_BUTTONS)
end


-- 回复导师好评差评
-- mvc.events.MENTOR_TUTOR_INTERACT_RESULT_MESSAGE 处理函数
function ApprenticeshipController:noticeMENTORTUTORINTERACTRESULTMESSAGE(notification, data)
    mvc.apprenticeshipModel:netUpdateMentorPoints(data)
    
    -- 提示成功
    if (mvc.apprenticeshipModel:isMentorReqMet()) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112703) --[["获得学徒评价奖励"]])
    else
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112704) --[["评价成功"]])
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_MENTOR_MESSAGE_UPDATE_BUTTONS)
end


-- 学生任务改变
-- mvc.events.MENTOR_TUTOR_TASK_CHANGE_MESSAGE 处理函数
function ApprenticeshipController:noticeMENTORTUTORTASKCHANGEMESSAGE(notification, data)
    mvc.apprenticeshipModel:netSetQuestProgress(data)

    if (self.apprenticeshipApprenticeView) then
        self.apprenticeshipApprenticeView:updateView()
    end

    if (self.apprenticeshipApprenticeQuestView) then
        self.apprenticeshipApprenticeQuestView:updateView()
    end

    if (self.apprenticeshipMentorView) then
        self.apprenticeshipMentorView:updateView()
    end

    if (self.apprenticeshipMentorQuestView) then
        self.apprenticeshipMentorQuestView:updateView()
    end

    -- 更新红点
    Avalon.MessageCenter:notice(GameMessage.MC_MENTOR_MESSAGE_UPDATE_REDPOINTS)
end

-- 个人信息推送
-- mvc.events.MENTOR_ROLE_TUTOR_DATA_MESSAGE 处理函数
function ApprenticeshipController:noticeMENTORROLETUTORDATAMESSAGE(notification, data)
    mvc.apprenticeshipModel:netUpdateGeneralInfo(data)

    -- 更新领取界面
    if (self.apprenticeshipMentorResultDailyView) then
        self.apprenticeshipMentorResultDailyView:updateView()
    end
    if (self.apprenticeshipApprenticeResultView) then
        self.apprenticeshipApprenticeResultView:updateView()
    end
    if (self.apprenticeshipMentorView) then
        self.apprenticeshipMentorView:updateView()
    end
    if (self.apprenticeshipApprenticeView) then
        self.apprenticeshipApprenticeView:updateView()
    end

    -- 更新按钮显示
    Avalon.MessageCenter:notice(GameMessage.MC_MENTOR_MESSAGE_UPDATE_BUTTONS)

    -- 检查领奖
    self:checkGraduateReward()
end

-- 回复师徒领奖
-- mvc.events.MENTOR_GET_TUTOR_REWARD_RESULT_MESSAGE 处理函数
function ApprenticeshipController:noticeMENTORGETTUTORREWARDRESULTMESSAGE(notification, data)
    -- optional uint32 rewardType = 1; //领奖类型TutorRewardType
    -- optional uint64 targetPk = 2;   //领奖目标PK
    -- optional uint32 rewardStat =3;  //领奖阶段
    -- optional uint32 result = 4; //GetTutorRewardResult
    -- enum TutorRewardType {
    --     TutorRewardType_Daily = 1;  //每日奖励
    --     TutorRewardType_Tutor = 2;  //出师奖励
    --     TutorRewardType_Stage = 3;  //阶段奖励
    --     TutorRewardType_Interact = 4;  //互动奖励
    -- }
    -- enum GetTutorRewardResult {
    --     GetTutorRewardResult_Success = 1;
    --     GetTutorRewardResult_Systemerror = 2;
    -- }


    -- 一次领奖个数
    local rewardNum = 1
    if (ProtobufUtil:checkFieldIsInit(data, "rewardNum")) then
        rewardNum = data.rewardNum
    end

    -- 判断种类
    local itemIDArr
    local itemNumArr
    if (ProtobufUtil:checkFieldIsInit(data, "rewardType")) then
        if (data.rewardType == ProtobufUtil:enum_id("TutorSystem.TutorRewardType","TutorRewardType_Daily")) then
            -- 获取奖励配置
            if (mvc.apprenticeshipModel:isMentorReqMet()) then
                itemIDArr, itemNumArr = mvc.apprenticeshipModel:mentorGetDailyRewardItemArr()
            else
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112816) --[["角色等级成功提升"]])
            end

        elseif (data.rewardType == ProtobufUtil:enum_id("TutorSystem.TutorRewardType","TutorRewardType_Tutor")) then
            -- 学徒关闭出师界面
            if (ProtobufUtil:checkFieldIsInit(data, "result") and data.result == ProtobufUtil:enum_id("TutorSystem.GetTutorRewardResult","GetTutorRewardResult_Success")) then
                mvc.closePanel("Apprenticeship", "ApprenticeshipApprenticeGraduate")
            end

            -- 导师更新界面
            if (self.apprenticeshipMentorView) then
                self.apprenticeshipMentorView:updateView()
            end

            -- 获取奖励配置
            itemIDArr, itemNumArr = mvc.apprenticeshipModel:apprenticeGetGraduateRewardItemArr()
        elseif (data.rewardType == ProtobufUtil:enum_id("TutorSystem.TutorRewardType","TutorRewardType_Stage")) then
            -- 更新阶段领奖界面
            if (self.apprenticeshipMentorResultView) then
                self.apprenticeshipMentorResultView:updateView()
            end

            -- 获取奖励配置
            if (ProtobufUtil:checkFieldIsInit(data, "rewardStat")) then
                itemIDArr, itemNumArr = mvc.apprenticeshipModel:mentorGetStageRewardItemArrByIndex(data.rewardStat)
            end
        elseif (data.rewardType == ProtobufUtil:enum_id("TutorSystem.TutorRewardType","TutorRewardType_Interact")) then
            -- 获取奖励配置
            itemIDArr, itemNumArr = mvc.apprenticeshipModel:mentorGetInteractRewardItemArr()
        end
    end

    -- 通过累计领奖次数来更新奖励数量
    if (rewardNum ~= 1) then
        for i,v in ipairs(itemNumArr) do
            itemNumArr[i] = v * rewardNum
        end
    end

    -- 提示成功失败
    if (ProtobufUtil:checkFieldIsInit(data, "result")) then
        if (data.result == ProtobufUtil:enum_id("TutorSystem.GetTutorRewardResult","GetTutorRewardResult_Success")) then
            -- 展示道具
            if (itemIDArr and itemNumArr) then
                -- 组装道具列表
                require "app.datas.GoodsDataManager"
                local displayItemArr = {}
                for i,itemID in ipairs(itemIDArr) do
                    local dummyItem = GoodsDataManager:createLocalGoodsData(itemID)
                    if(dummyItem) then
                        dummyItem:setNum(itemNumArr[i] or 0)
                        table.insert(displayItemArr, dummyItem)
                    end
                end

                -- 展示道具
                Avalon.MessageCenter:notice(
                    GameMessage.MC_UI_COMMON_REWARD, 
                    displayItemArr, 
                    nil,
                    LanguageManager:getInstance():getLocalString(1112347))     
            end
        elseif (data.result == ProtobufUtil:enum_id("TutorSystem.GetTutorRewardResult","GetTutorRewardResult_Systemerror")) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112705) --[["奖励领取失败"]])
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110382) --[["未知错误"]])
        end
    end

    -- 更新红点
    Avalon.MessageCenter:notice(GameMessage.MC_MENTOR_MESSAGE_UPDATE_REDPOINTS)
end


-- mvc.events.MENTOR_UPDATE_ROLE_INFO_MESSAGE 处理函数
function ApprenticeshipController:noticeMENTORUPDATEROLEINFOMESSAGE(notification, data)
    mvc.apprenticeshipModel:netUpdateRoleData(data)
    if (self.apprenticeshipApprenticeView) then 
        self.apprenticeshipApprenticeView:updateMentorData() 
    end
    if (self.apprenticeshipMentorView) then
        self.apprenticeshipMentorView:updateApprenticeData() 
    end
end





























-------------------------------------其他模块消息-----
-- mvc.events.Mentor_Request_Invite_Tutor_Message 处理函数
function ApprenticeshipController:noticeMentorRequestInviteTutorMessage(notification, PK)
    self:applyForMentorByPK(PK)
end



-- mvc.events.Mentor_Tutor_Setting_Message 处理函数
function ApprenticeshipController:noticeMentorTutorSettingMessage(notification, isReject)
    self:mentorSetting(isReject)
end



-- mvc.events.Mentor_Tutor_Interact_Message 处理函数
function ApprenticeshipController:noticeMentorTutorInteractMessage(notification, modeOrIdx)
    if (mvc.apprenticeshipModel:isMentorReqMet()) then
        self:mentorGetPraiseRewardByIndex(modeOrIdx)
    else
        self:apprenticeMentorInteract(modeOrIdx)
    end
end



-- mvc.events.Mentor_Back_Town 处理函数
function ApprenticeshipController:noticeMentorBackTown(notification)
    self:checkApprenticeableFirstShow()
    self:checkGraduateReward()
end

-- 检查显示第一次推荐导师弹窗
function ApprenticeshipController:checkApprenticeableFirstShow()
    -- 检查第一次学徒显示
    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    local isViewShown = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.ApprenticeFirstTimeShown .. masterPK, false)
    if (isViewShown) then return end

    -- 检查满足师傅要求
    if (mvc.apprenticeshipModel:isAbleToMentor() or mvc.apprenticeshipModel:getMentor()) then
        -- 保存第一次学徒显示状态
        self:setFirstTimeShown()
        return
    end

    -- 检查满足徒弟要求
    if (not mvc.apprenticeshipModel:isAbleToApprentice()) then return end

    -- 打开推荐窗口
    mvc.openPanel("Apprenticeship", "ApprenticeshipApply")

    -- 保存第一次学徒显示状态
    self:setFirstTimeShown()
end

-- 保存第一次学徒显示状态
function ApprenticeshipController:setFirstTimeShown()
    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.ApprenticeFirstTimeShown .. masterPK, true)
end

-- 检查毕业
function ApprenticeshipController:checkGraduateReward()
    local SceneManager = require("app.game.SceneManager")
    if (not SceneManager:getInstance():getIsInLoading() and
        not SceneManager:getInstance():isInFightScene() and
        mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist()) 
    then
        mvc.openPanel("Apprenticeship", "ApprenticeshipApprenticeGraduate")
    end
end



return ApprenticeshipController