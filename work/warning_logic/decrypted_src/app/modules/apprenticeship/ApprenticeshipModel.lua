--[[--
数据模型ApprenticeshipModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/07/30
--desc	: ApprenticeshipModel
------------------------------------------------------------------------------

local ProtobufUtil = require("utils.ProtobufUtil")
local LanguageManager = require "app.game.LanguageManager"

local ApprenticeshipModel = class("ApprenticeshipModel",mvc.GameModel)

ApprenticeshipModel.INTERACT_TYPE = {
    CRIT = 0,
    PRAISE = 1,
}
--------------------------- 师徒数据
-- 通用获取PB角色数据方法
local function parseNetRoleData(netRoleData)
    -- //关系角色数据
    -- message TutorData {
    --     required uint64 PK = 1;
    -- Tutor
    --     optional uint32 loginStatus = 3;             
    --     optional string nickName = 4;           //昵称
    --     optional uint64 userID = 5;
    --     optional uint32 sex = 6;                // 性别
    --     optional uint32 faceDecodeID = 7;       // 脸
    --     optional uint64 updateTimestamp = 8;    //更新的时间戳
    --     optional uint32 roleLV = 9;     
    --     optional bool isInCave = 10;        
    --     optional uint32 offlineTime = 11;       // 当状态为离线时该值有效
    -- Quest
    --     optional HeroTutorTask task = 12;       //导师任务数据
    --     optional uint32 taskStat = 13;      //任务状态
    --     optional uint32 taskStudentConfirmDay = 14;   //任务学生确认天
    --     optional uint32 taskTutorConfirmDay = 15;     //任务导师确认天
    --     optional uint32 taskRefreshDay = 16;
    -- Interact
    --     optional uint32 Praise = 17; //赞
    --     optional uint32 Criticize = 18;  //踩

    -- StageReward
    --     optional uint32 stageStat = 19; //阶段达成情况
    --     optional uint32 stageRewardStat = 20; //阶段领取情况
    --     optional bool activityUnlock = 21;   //活跃度是否解锁
    --     optional uint32 taskLastFinishDay = 22; //每日任务完成天
    -- }
    local roleData = {}
    roleData.PK = netRoleData.PK

    
    if (ProtobufUtil:checkFieldIsInit(netRoleData, "loginStatus")) then
        roleData.loginStatus = netRoleData.loginStatus
    end

    if (ProtobufUtil:checkFieldIsInit(netRoleData, "nickName")) then
        roleData.nickName = ToolsUtil:replaceShowNickNameStr(netRoleData.nickName)
    end

    if (ProtobufUtil:checkFieldIsInit(netRoleData, "userID")) then
        roleData.userID = netRoleData.userID
    end

    if (ProtobufUtil:checkFieldIsInit(netRoleData, "sex")) then
        roleData.sex = netRoleData.sex
    end

    if (ProtobufUtil:checkFieldIsInit(netRoleData, "faceDecodeID")) then
        roleData.faceDecodeID = netRoleData.faceDecodeID
    end
    
    if (ProtobufUtil:checkFieldIsInit(netRoleData, "updateTimestamp")) then
        roleData.updateTimestamp = netRoleData.updateTimestamp
    end

    if (ProtobufUtil:checkFieldIsInit(netRoleData, "roleLV")) then
        roleData.roleLV = netRoleData.roleLV
    end

    if (ProtobufUtil:checkFieldIsInit(netRoleData, "isInCave")) then
        roleData.isInCave = netRoleData.isInCave
    end

    if (ProtobufUtil:checkFieldIsInit(netRoleData, "offlineTime")) then
        roleData.offlineTime = netRoleData.offlineTime
    end

    return roleData
end

-- 获取一个初始任务配置表
local function getOriginalQuestConfig()
    local questConfigArr = {}
    local questConfigTypeTable = {}
    local masterTaskStr = ConfigManager:getGeneralForKey("mastertask")
    local taskInfoStrArr = masterTaskStr:split(";")
    local count = #taskInfoStrArr
    for i,taskInfoStr in ipairs(taskInfoStrArr) do
        local taskInfoArr = taskInfoStr:split(",")
        local taskInfoEntry = {}
        taskInfoEntry.type = tonumber(taskInfoArr[1])
        taskInfoEntry.maxNum = tonumber(taskInfoArr[2])
        taskInfoEntry.title = LanguageManager:getInstance():getLocalString(tonumber(taskInfoArr[3]))
        taskInfoEntry.desc = LanguageManager:getInstance():getLocalString(tonumber(taskInfoArr[4]))
        taskInfoEntry.num = 0
        taskInfoEntry.stat = 0
        table.insert(questConfigArr, taskInfoEntry)
        questConfigTypeTable[taskInfoEntry.type] = taskInfoEntry
    end
    return questConfigArr, questConfigTypeTable, count
end

-- 初始化
function ApprenticeshipModel:initData()
    self._generalInfo = {}
    self._mentorRecommendationList = {}
    self._apprenticeApplyArr = {}
    self._mentor = nil
    self._apprenticeArr = {}
    self._apprenticeTable = {}
    self._pkQuestTable = {}
    self._pkQuestStatTable = {}
    self._pkInteractTable = {}
    self._pkRewardStatTable = {}

    -- 读取奖励配置表
    self._rewardConfigArr = {
        { lv = 15, status = 0,},
        { lv = 20, status = 0,},
        { lv = 23, status = 0,}}
    local rewardConfig = ConfigManager:getAllMasterReward()
    self._rewardConfig = {}
    for i,v in ipairs(rewardConfig) do
        self._rewardConfig[v.type] = v
    end
    

    -- 通用配置
    self._configInfo = {
        mentorQualifications = tonumber(ConfigManager:getGeneralForKey("mentorqualifications")), -- 收徒要求等级
        closeingLevel = tonumber(ConfigManager:getGeneralForKey("closinglevel")), -- 出师等级
        apprenticeInformationLimit = ConfigManager:getGeneralForKey("apprenticeinformationlimit"), -- 拜师信息最大数量
        recruitCD = ConfigManager:getGeneralForKey("recruitCD"), -- 导师断绝关系CD
        apprenticeCD = ConfigManager:getGeneralForKey("apprenticeCD"), -- 学员断绝关系CD
        masterTask = ConfigManager:getGeneralForKey("mastertask"), -- 每日任务配置
        applyLimit = tonumber(ConfigManager:getGeneralForKey("applylimit")), -- 每日申请限制
        recruitLimit = tonumber(ConfigManager:getGeneralForKey("recruitlimit")), -- 每日收徒限制
        interactiveLimit = tonumber(ConfigManager:getGeneralForKey("interactivelimit")), -- 每日踩赞限制
        interactiveTime = tonumber(ConfigManager:getGeneralForKey("interactivetime")), -- 踩赞CD
    }
end

-- 网络加载个人数据
function ApprenticeshipModel:netUpdateGeneralInfo(data)
    -- optional uint32 nextTutorTime = 1;   //下一次导师关系确认的时间
    -- optional uint32 dailyReqNum = 2;    //每日申请的次数
    -- optional uint32 dailyTutorNum = 3;  //每日收徒的次数
    -- optional bool isReject = 4;         //是否拒绝收徒
    -- repeated TutorRewardStat rewardStat  = 5;   //导师每日奖励领取状态 
    -- optional bool isOutTutor = 6;       //是否出师    
    -- optional bool isOutTutorReward = 7;   //出师奖励是否领取
    -- optional uint32 dailyInteractNum = 8;   //每日互动次数
    -- optional uint32 nextInteractTime = 9;   //下次互动时间
    -- optional uint32 stuNoRewardStat = 10;  //学徒未领取每日任务奖励标识
    -- optional uint32 stuDailyRewardStat = 11;  //学徒每日任务奖励标识
    -- message TutorRewardStat {
    --     required uint64 stuPk = 1;  //徒弟PK
    --     optional uint32 dailyRewardStat = 2; //每日任务奖励领奖状态
    --     optional uint32 noRewardStat = 3;      //阶段奖励领取状态  (弃用)
    --     optional uint32 interactRewardNum = 4;//已经领取的互动奖励数量
    --     optional uint32 taskRewardDay = 5; //每日任务领奖天
    -- }
    self._generalInfo = {}
    if (ProtobufUtil:checkFieldIsInit(data, "nextTutorTime")) then
        self._generalInfo.nextTutorTime = data.nextTutorTime
    end
    if (ProtobufUtil:checkFieldIsInit(data, "dailyReqNum")) then
        self._generalInfo.dailyReqNum = data.dailyReqNum
    end
    if (ProtobufUtil:checkFieldIsInit(data, "dailyTutorNum")) then
        self._generalInfo.dailyTutorNum = data.dailyTutorNum
    end
    if (ProtobufUtil:checkFieldIsInit(data, "isReject")) then
        self._generalInfo.isReject = data.isReject
    end
    if (ProtobufUtil:checkFieldIsInit(data, "isOutTutor")) then
        self._generalInfo.isOutTutor = data.isOutTutor
    end
    if (ProtobufUtil:checkFieldIsInit(data, "isOutTutorReward")) then
        self._generalInfo.isOutTutorReward = data.isOutTutorReward
    end
    if (ProtobufUtil:checkFieldIsInit(data, "dailyInteractNum")) then
        self._generalInfo.dailyInteractNum = data.dailyInteractNum
    end
    if (ProtobufUtil:checkFieldIsInit(data, "nextInteractTime")) then
        self._generalInfo.nextInteractTime = data.nextInteractTime
    end
    if (ProtobufUtil:checkFieldIsInit(data, "studentDailyReward")) then
        self._generalInfo.studentDailyReward = data.studentDailyReward
    end
    if (ProtobufUtil:checkFieldIsInit(data, "rewardStat")) then
        for i,v in ipairs(data.rewardStat) do
            self:setPKDailyRewardStat(v.stuPk, v)
        end
    end
end

-- 网络加载导师推荐列表
function ApprenticeshipModel:netUpdateMentorRecommandationList(data)
    if (data and data ~= "" and ProtobufUtil:checkFieldIsInit(data, "tutorList")) then
        self._mentorRecommendationList = {}
        for i,tutor in ipairs(data.tutorList) do
            local mentorInfo = parseNetRoleData(tutor)
            table.insert(self._mentorRecommendationList, mentorInfo)
        end
    end
end

-- 网络加载学徒申请列表
function ApprenticeshipModel:netUpdateApprenticeApplyList(data)
    if (ProtobufUtil:checkFieldIsInit(data, "requestPk")) then
        self._apprenticeApplyArr = {}
        for i,apprentice in ipairs(data.requestPk) do
            local apprenticeInfo = parseNetRoleData(apprentice)
            table.insert(self._apprenticeApplyArr, apprenticeInfo)
        end
    else
        self._apprenticeApplyArr = {}
    end
end

-- 网络加载导师
function ApprenticeshipModel:netUpdateMentor(data)
    if (ProtobufUtil:checkFieldIsInit(data, "tutorPk")) then
        self._mentor = parseNetRoleData(data.tutorPk)

        -- 特殊处理学徒自己的任务通过导师信息传过来
        require "app.datas.RoleDataManager"
        local masterPK = RoleDataManager:getMasterPK()
        if (ProtobufUtil:checkFieldIsInit(data.tutorPk, "task")) then
            if (masterPK) then
                self:setQuestProgress(masterPK, data.tutorPk.task)
            end
        end

        -- 设置任务状态
        self:setQuestStats(masterPK, data.tutorPk)

        -- 设置踩赞数据
        self:setMentorPoints(data.tutorPk.PK, data.tutorPk)
    else
        self._mentor = nil
    end
end

-- 网络加载学徒
function ApprenticeshipModel:netUpdateApprentice(data)
    if (ProtobufUtil:checkFieldIsInit(data, "studentPk")) then
        self._apprenticeArr = {}
        self._apprenticeTable = {}
        for i,student in ipairs(data.studentPk) do
            -- 获取人物信息
            local apprenticeInfo = parseNetRoleData(student)
            table.insert(self._apprenticeArr, apprenticeInfo)
            self._apprenticeTable[apprenticeInfo.PK] = apprenticeInfo

            -- 获取任务信息
            if (ProtobufUtil:checkFieldIsInit(student, "task")) then
                self:setQuestProgress(student.PK, student.task)
            end

            -- 设置任务状态
            self:setQuestStats(student.PK, student)

            -- 设置踩赞数据
            self:setMentorPoints(student.PK, student)

            -- 设置阶段进度
            self:setPKRewardStat(student.PK, student)
        end
    else
        self._apprenticeArr = {}
        self._apprenticeTable = {}
    end
end

-- 网络更新踩赞数据
function ApprenticeshipModel:netUpdateMentorPoints(data)
    self:setMentorPoints(data.Pk, data)
end

-- 设置PK对应的导师分数
function ApprenticeshipModel:setMentorPoints(pk, data)
    local interactEntry = self._pkInteractTable[pk]
    if (not interactEntry) then
        interactEntry = {}
        self._pkInteractTable[pk] = interactEntry
    end

    local isInteractUpdated = false
    if (ProtobufUtil:checkFieldIsInit(data, "Praise")) then
        if (interactEntry.Praise and interactEntry.Praise < data.Praise) then
            interactEntry.lastInteract = ApprenticeshipModel.INTERACT_TYPE.PRAISE
            isInteractUpdated = true
        end
        interactEntry.Praise = data.Praise
    end

    if (ProtobufUtil:checkFieldIsInit(data, "Criticize")) then
        if (interactEntry.Criticize and interactEntry.Criticize < data.Criticize) then
            interactEntry.lastInteract = ApprenticeshipModel.INTERACT_TYPE.CRIT
            isInteractUpdated = true
        end
        interactEntry.Criticize = data.Criticize
    end

    if (isInteractUpdated and interactEntry.lastInteract) then
        require "app.datas.RoleDataManager"
        local masterPK = RoleDataManager:getMasterPK()
        if (masterPK) then
            cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.mentorLastInteraction .. masterPK, interactEntry.lastInteract) 
        end
    end

    if (ProtobufUtil:checkFieldIsInit(data, "InteractNum")) then
        interactEntry.InteractNum = data.InteractNum
    elseif (ProtobufUtil:checkFieldIsInit(data, "dailyInteractNum")) then
        interactEntry.InteractNum = data.dailyInteractNum
    end
end

-- 设置PK对应的进度
function ApprenticeshipModel:setPKRewardStat(pk, data)
    local statEntry = self._pkRewardStatTable[pk]
    if (not statEntry) then
        statEntry = {}
        self._pkRewardStatTable[pk] = statEntry
    end
    
    -- 阶段进度
    if (ProtobufUtil:checkFieldIsInit(data, "stageStat")) then
        statEntry.stageStat = data.stageStat
    else
        statEntry.stageStat = 0
    end

    -- 阶段奖励进度
    if (ProtobufUtil:checkFieldIsInit(data, "stageRewardStat")) then
        statEntry.stageRewardStat = data.stageRewardStat
    else
        statEntry.stageRewardStat = 0
    end

    -- 设置阶段解锁
    if (ProtobufUtil:checkFieldIsInit(data, "activityUnlock")) then
        statEntry.activityUnlock = data.activityUnlock
    else
        statEntry.activityUnlock = false
    end

    -- 阶段解锁更新显示
    self:updateStageQuestForDisplay()
end

-- 设置PK对应的每日任务状态
function ApprenticeshipModel:setPKDailyRewardStat(pk, data)
    local statEntry = self._pkRewardStatTable[pk]
    if (not statEntry) then
        statEntry = {}
        self._pkRewardStatTable[pk] = statEntry
    end

    -- 强制领奖状态
    if (ProtobufUtil:checkFieldIsInit(data, "noRewardStat")) then
        statEntry.noRewardStat = data.noRewardStat
    else
        statEntry.noRewardStat = 0
    end

    -- -- 每日奖励状态
    -- if (ProtobufUtil:checkFieldIsInit(data, "dailyRewardStat")) then
    --     statEntry.dailyRewardStat = data.dailyRewardStat
    -- else
    --     statEntry.dailyRewardStat = 0
    -- end

    -- 领奖的日子
    if (ProtobufUtil:checkFieldIsInit(data, "taskRewardDay")) then
        statEntry.taskRewardDay = data.taskRewardDay
    else
        statEntry.taskRewardDay = 0
    end

    -- 交互已领取奖励
    if (ProtobufUtil:checkFieldIsInit(data, "interactRewardNum")) then
        statEntry.interactRewardNum = data.interactRewardNum
    else
        statEntry.interactRewardNum = 0
    end
end

-- 更新角色信息
function ApprenticeshipModel:netUpdateRoleData(detailData)
    if (not detailData) then return end
    if (not ProtobufUtil:checkFieldIsInit(detailData, "heroData")) then return end
    local heroData = detailData.heroData
    if (not ProtobufUtil:checkFieldIsInit(heroData, "pk")) then return end

    local roleData = self._apprenticeTable[heroData.pk]
    if (not roleData and self._mentor and self._mentor.PK == heroData.pk) then
        roleData = self._mentor
    end
    if (not roleData) then return end


    if (ProtobufUtil:checkFieldIsInit(heroData, "roleLV")) then
        roleData.roleLV = heroData.roleLV
    end

    if (ProtobufUtil:checkFieldIsInit(heroData, "faceDecodeID")) then
        roleData.faceDecodeID = heroData.faceDecodeID
    end

    if (ProtobufUtil:checkFieldIsInit(heroData, "nickName")) then
        roleData.nickName = ToolsUtil:replaceShowNickNameStr(heroData.nickName)
    end
end

-- 获取PK对应的导师分数
function ApprenticeshipModel:getMentorPoints()
    
end

-- 获取导师推荐列表
function ApprenticeshipModel:getMentorRecommendationList()
    return self._mentorRecommendationList
end

-- 获取导师
function ApprenticeshipModel:getMentor()
    return self._mentor
end

-- 通过下标获申请学徒
function ApprenticeshipModel:getApprenticeApplyByIndex(idx)
    return self._apprenticeApplyArr[idx]
end

-- 获取申请学徒数量
function ApprenticeshipModel:getApprenticeApplyCount()
    return #self._apprenticeApplyArr
end

-- 通过PK删除申请者
function ApprenticeshipModel:removeApplierByPK(pk)
    for i=#self._apprenticeApplyArr,-1,1 do
        local applier = self._apprenticeApplyArr[i]
        if (applier.PK == pk) then
            table.remove(self._apprenticeApplyArr, i)
        end
    end
end

-- 从下标获取一个学徒
function ApprenticeshipModel:getApprenticeByIndex(idx)
    return self._apprenticeArr[idx]
end

-- 获取学徒列表
function ApprenticeshipModel:getApprenticeArr()
    return self._apprenticeArr
end

-- 消除一个学徒
function ApprenticeshipModel:removeApprentice(idx)
    table.remove(self._apprenticeArr, idx)
end

-- 是否满足当导师的条件
ApprenticeshipModel.MENTOR_UNABLE_REASON = {
    LV = 101,
    DAILY_NUM = 102,
    CD = 103,
    FULL = 104,
    NOT_ALLOW = 105,
    GRADUATE_REWARD = 106,
    NOT_OUT_TUTOR = 107,
} 
function ApprenticeshipModel:isMentorReqMet(lvToCheck)
    -- 是否已经出师
    local mentor = self:getMentor()
    if (mentor) then
        return false, ApprenticeshipModel.MENTOR_UNABLE_REASON.NOT_OUT_TUTOR
    end

    -- 等级限制
    if (not lvToCheck) then
        require "app.datas.RoleDataManager"
        local master = RoleDataManager:getMaster()
        lvToCheck = master:getLevel()
    end
    
    local isLvMet = lvToCheck >= self._configInfo.mentorQualifications
    if (not isLvMet) then return false, ApprenticeshipModel.MENTOR_UNABLE_REASON.LV end

    return true
end

-- 现在是否能当导师
function ApprenticeshipModel:isAbleToMentor()
    -- 先检查导师条件
    local isReqMet, reason = self:isMentorReqMet()
    if (not isReqMet) then return false, reason end

    -- 每日次数限制
    local underDailyNumLimit
    if (self._generalInfo.dailyTutorNum ~= nil) then
        underDailyNumLimit = self._generalInfo.dailyTutorNum < self._configInfo.recruitLimit
    else
        underDailyNumLimit = true
    end
    if (not underDailyNumLimit) then return false, ApprenticeshipModel.MENTOR_UNABLE_REASON.DAILY_NUM end

    -- CD限制
    local isTimeLimitMet
    if (self._generalInfo.nextTutorTime ~= nil) then
        local timeNow = GameManager:getNormalServerTime()
        isTimeLimitMet = timeNow >= self._generalInfo.nextTutorTime
    else
        isTimeLimitMet = true
    end
    if (not isTimeLimitMet) then return false, ApprenticeshipModel.MENTOR_UNABLE_REASON.CD end

    -- 学员数量限制
    local isApprenticeNumLimitMet = #self:getApprenticeArr() < 2
    if (not isApprenticeNumLimitMet) then return false, ApprenticeshipModel.MENTOR_UNABLE_REASON.FULL end

    -- 拒绝收徒限制
    local isAllowing
    if (self._generalInfo.isReject ~= nil) then
        isAllowing = not self._generalInfo.isReject
    else
        isAllowing = true
    end
    if (not isAllowing) then return false, ApprenticeshipModel.MENTOR_UNABLE_REASON.NOT_ALLOW end

    -- 检查毕业奖励
    if (self:apprenticeIsGraduationRewardExist()) then
        return false, ApprenticeshipModel.MENTOR_UNABLE_REASON.GRADUATE_REWARD
    end

    return true
end

ApprenticeshipModel.APPRENTICE_UNABLE_REASON = {
    LV = 201,
    DAILY_NUM = 202,
    CD = 203,
    OVER_LV = 204,
    ALREADY_IS = 205,
}

-- 学徒条件是否满足
function ApprenticeshipModel:isApprenticeReqMet()
    -- 等级限制
    require "app.datas.RoleDataManager"
    local master = RoleDataManager:getMaster()
    local lv = master:getLevel()
    local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")
    local isUnlocked = FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.APPRENTICESHIP)
    local isLvReqMet = lv < self._configInfo.closeingLevel and isUnlocked
    if (not isLvReqMet) then return false, ApprenticeshipModel.APPRENTICE_UNABLE_REASON.LV end

    return true
end

-- 现在是否能够成为学徒
function ApprenticeshipModel:isAbleToApprentice()
    local mentor = self:getMentor()
    if (mentor) then
        return false, ApprenticeshipModel.APPRENTICE_UNABLE_REASON.ALREADY_IS
    end

    -- 检查学徒条件
    local isReqMet, reason = self:isApprenticeReqMet()
    if (not isReqMet) then return false, reason end

    -- 检查导师条件
    local isMentorReqMet, reason = self:isMentorReqMet()
    if (isMentorReqMet) then return false, ApprenticeshipModel.APPRENTICE_UNABLE_REASON.OVER_LV end

    -- 每日次数限制
    local underDailyNumLimit
    if (self._generalInfo.dailyReqNum ~= nil) then
        underDailyNumLimit = self._generalInfo.dailyReqNum < self._configInfo.applyLimit
    else
        underDailyNumLimit = true
    end
    if (not underDailyNumLimit) then return false, ApprenticeshipModel.APPRENTICE_UNABLE_REASON.DAILY_NUM end

    -- CD限制
    local isTimeLimitMet
    if (self._generalInfo.nextTutorTime ~= nil) then
        local timeNow = GameManager:getNormalServerTime()
        isTimeLimitMet = timeNow >= self._generalInfo.nextTutorTime
    else
        isTimeLimitMet = true
    end
    if (not isTimeLimitMet) then return false, ApprenticeshipModel.APPRENTICE_UNABLE_REASON.CD end


    return true
end

-- 清除导师
function ApprenticeshipModel:removeMentor()
    self._mentor = nil
end

-- 清除学徒
function ApprenticeshipModel:removeApprentice(pk)
    self._apprenticeTable[pk] = nil
    for i=#self._apprenticeArr,1,-1 do
        local entry = self._apprenticeArr[i]
        if (entry.PK == pk) then
            table.remove(self._apprenticeArr, i)
        end
    end
end

-- 学徒获取导师是否在线
function ApprenticeshipModel:apprenticeIsMentorOnline()
    local mentor = self:getMentor()
    if (not mentor) then return false end
    return mentor.userID ~= nil and mentor.userID ~= 0 or false
end

-- 导师通过下标获取学徒是否在线
function ApprenticeshipModel:mentorIsApprenticeOnlineByIndex(idx)
    local apprentice = self:getApprenticeByIndex(idx)
    if (not apprentice) then return false end
    return apprentice.userID ~= nil and apprentice.userID ~= 0 or false
end

-- 学徒是否显示导师头像红点
function ApprenticeshipModel:apprenticeIsMentorShowRedpoint()
    local isAbleToGetDailyReward = self:apprenticeIsAbleToGetQuestReward()
    local isAlreadyGotDailyReward = self:apprenticeIsAlreadyGotReward()
    local isAbleToConfirm = self:apprenticeIsSelfQuestDone()
    local isSelfComfirmed = self:apprenticeIsQuestCommitted()
    return (not isAlreadyGotDailyReward and isAbleToGetDailyReward) or 
           (isAbleToConfirm and not isSelfComfirmed)
end

-- 学徒是否显示住按钮红点
function ApprenticeshipModel:apprenticeIsMainButtonShowRedpoint()
    return self:apprenticeIsGraduationRewardExist()
end

-- 导师是否显示学徒头像红点
function ApprenticeshipModel:mentorIsApprenticeShowRedpointByIndex(idx)
    local isAbleToGetDailyReward = self:mentorIsApprenticeAbleToGetQuestRewardByIndex(idx)
    local isAbleToGetStageReward = self:mentorIsAbleToGetResultReward(idx)
    local isAbleToConfirm = self:mentorIsApprenticeQuestDoneByIndex(idx)
    local isSelfComfirmed = self:mentorIsSelfQuestCommittedByIndex(idx)
    return isAbleToGetDailyReward or 
           (isAbleToConfirm and not isSelfComfirmed) or
           isAbleToGetStageReward
end

-- 导师是否显示主按钮红点
function ApprenticeshipModel:mentorIsMainButtonShowRedpoint()
    return self:getApprenticeApplyCount() > 0
end











--------------------------- 任务数据
-- 网络设置任务
function ApprenticeshipModel:netSetQuestProgress(data)
    if (ProtobufUtil:checkFieldIsInit(data, "changeTask")) then
        self:setQuestProgress(data.tarPk, data.changeTask)
    end
    self:setQuestStats(data.tarPk, data)
end

-- 为一个PK设置任务状态
function ApprenticeshipModel:setQuestStats(PK, data)
    local statEntry = {}
    self._pkQuestStatTable[PK] = statEntry

    -- 总完成状态
    if (ProtobufUtil:checkFieldIsInit(data, "taskStat")) then
        statEntry.taskStat = data.taskStat
    end

    -- 学生确认日
    if (ProtobufUtil:checkFieldIsInit(data, "taskStudentConfirmDay")) then
        statEntry.taskStudentConfirmDay = data.taskStudentConfirmDay
    end

    -- 导师确认日
    if (ProtobufUtil:checkFieldIsInit(data, "taskTutorConfirmDay")) then
        statEntry.taskTutorConfirmDay = data.taskTutorConfirmDay
    end

    -- 任务刷新日
    if (ProtobufUtil:checkFieldIsInit(data, "taskRefreshDay")) then
        statEntry.taskRefreshDay = data.taskRefreshDay
    end

    -- 任务完成日
    if (ProtobufUtil:checkFieldIsInit(data, "taskLastFinishDay")) then
        statEntry.taskLastFinishDay = data.taskLastFinishDay
    end
end

-- 为一个PK设置任务数据
function ApprenticeshipModel:setQuestProgress(PK, taskProgressWrapper)
    local questEntry = {}
    questEntry.arr, questEntry.table, questEntry.count = getOriginalQuestConfig()
    self._pkQuestTable[PK] = questEntry
    
    if (taskProgressWrapper and ProtobufUtil:checkFieldIsInit(taskProgressWrapper, "taskList")) then
        for i,taskProgress in ipairs(taskProgressWrapper.taskList) do
            local taskInfo = questEntry.table[taskProgress.id]
            if (taskInfo) then
                if (ProtobufUtil:checkFieldIsInit(taskProgress, "num")) then
                    taskInfo.num = taskProgress.num
                else
                    taskInfo.num = 0
                end

                if (ProtobufUtil:checkFieldIsInit(taskProgress, "stat")) then
                    taskInfo.stat = taskProgress.stat
                else
                    taskInfo.stat = 0
                end

                if (ProtobufUtil:checkFieldIsInit(taskProgress, "isInValid")) then
                    taskInfo.isInValid = taskProgress.isInValid
                else
                    taskInfo.isInValid = false
                end
            end
        end
    end

    self:updateStageQuestForDisplay(PK)
end

-- 更新任务显示列表
function ApprenticeshipModel:updateStageQuestForDisplay()
    for PK,questEntry in pairs(self._pkQuestTable) do
        -- 创建一个展示用的列表
        questEntry.arrForDisplay = clone(questEntry.arr)
        for i=questEntry.count,1,-1 do
            local taskInfo = questEntry.arrForDisplay[i]
            if (taskInfo.isInValid) then
                table.remove(questEntry.arrForDisplay, i)
            end
        end
        questEntry.countForDisplay = #questEntry.arrForDisplay

        -- 注意: 特殊处理 -- 根据外层标记去掉活跃度任务
        local roleInfo = self._apprenticeTable[PK]
        if (not roleInfo and self._mentor and self._mentor.PK == PK) then
            roleInfo = self._mentor
        end
        if (roleInfo) then
            local rewardStat = self._pkRewardStatTable[roleInfo.PK]   
            if (rewardStat) then
                if (not rewardStat.activityUnlock and #questEntry.arrForDisplay >= 3) then
                    table.remove(questEntry.arrForDisplay, 3)
                    questEntry.countForDisplay = #questEntry.arrForDisplay
                end
            end
        end
    end
end

-- 学徒获取自己任务数量
function ApprenticeshipModel:apprenticeGetQuestNum()
    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    local apprenticeQuestEntry = self._pkQuestTable[masterPK]
    if (not apprenticeQuestEntry) then return 0 end
    return apprenticeQuestEntry.countForDisplay
end

-- 学徒从下标获取任务数据
function ApprenticeshipModel:apprenticeGetQuestInfoByIndex(idx)
    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    local apprenticeQuestEntry = self._pkQuestTable[masterPK]
    if (not apprenticeQuestEntry) then return end
    return apprenticeQuestEntry.arrForDisplay[idx]
end

-- 导师获取学徒的任务数量
function ApprenticeshipModel:mentorGetApprenticeQuestNumByIndex(idx)
    local apprentice = self._apprenticeArr[idx]
    if (not apprentice) then return 0 end
    local questEntry = self._pkQuestTable[apprentice.PK]
    if (not questEntry) then return 0 end
    return questEntry.countForDisplay
end

-- 导师获取学徒的任务
function ApprenticeshipModel:mentorGetApprenticeQuestInfoByIndex(apprenticeIdx, questIdx)
    local apprentice = self._apprenticeArr[apprenticeIdx]
    if (not apprentice) then return end
    local questEntry = self._pkQuestTable[apprentice.PK]
    if (not questEntry) then return end
    return questEntry.arrForDisplay[questIdx]
end

----------任务状态
-- 统一获取学徒任务状态
function ApprenticeshipModel:apprenticeGetSelfQuestStat()
    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    if (not masterPK) then return end
    local questStat = self._pkQuestStatTable[masterPK]
    if (not questStat) then return end
    return questStat
end

-- 学徒获取是任务是否已完成
function ApprenticeshipModel:apprenticeIsSelfQuestDone()
    local questStat = self:apprenticeGetSelfQuestStat()
    if (not questStat) then return false end
    return questStat.taskStat and questStat.taskStat > 0 or false
end

-- 学徒判断是否已经上报过
function ApprenticeshipModel:apprenticeIsQuestCommitted()
    local questStat = self:apprenticeGetSelfQuestStat()
    if (not questStat) then return false end
    if (questStat.taskStudentConfirmDay == questStat.taskRefreshDay) then
        return true
    end
    return false
end

-- 学徒判断是否导师已经上报过
function ApprenticeshipModel:apprenticeIsMentorQuestCommitted()
    local questStat = self:apprenticeGetSelfQuestStat()
    if (not questStat) then return false end
    if (questStat.taskTutorConfirmDay == questStat.taskRefreshDay) then
        return true
    end
    return false
end

-- 学徒判断是否都上报完了
function ApprenticeshipModel:apprenticeIsAllCommitted()
    return self:apprenticeIsQuestCommitted() and self:apprenticeIsMentorQuestCommitted()
end

-- 学徒判断是否可以领奖
function ApprenticeshipModel:apprenticeIsAbleToGetQuestReward()
    local masterPK = RoleDataManager:getMasterPK()
    if (not masterPK) then return false end
    local questStat = self._pkQuestStatTable[masterPK]
    if (not questStat or questStat.taskLastFinishDay == 0) then return false end
    local rewardStat = self._pkRewardStatTable[masterPK]
    if (not rewardStat) then rewardStat = {} end
    if (not rewardStat.taskRewardDay) then rewardStat.taskRewardDay = 0 end
    return questStat.taskLastFinishDay and rewardStat.taskRewardDay ~= questStat.taskLastFinishDay or false
end

-- 学徒已经领奖过了
function ApprenticeshipModel:apprenticeIsAlreadyGotReward()
    if (self._generalInfo.studentDailyReward and self._generalInfo.studentDailyReward > 0) then
        return true
    end
    return false
end

-- 统一导师通过下标获取学徒任务信息
function ApprenticeshipModel:mentorGetApprenticeQuestStatByIndex(idx)
    local apprentice = self:getApprenticeByIndex(idx)
    if (not apprentice) then return end
    local questStat = self._pkQuestStatTable[apprentice.PK]
    if (not questStat) then return end
    return questStat
end

-- 导师通过下标检查学徒是否完成 改: 现在导师可以直接确认任务了
function ApprenticeshipModel:mentorIsApprenticeQuestDoneByIndex(idx)
    -- local questStat = self:mentorGetApprenticeQuestStatByIndex(idx)
    -- if (not questStat) then return false end
    -- return questStat.taskStat and questStat.taskStat > 0 or false
    return true
end

-- 导师通过下标检查是否已经上报过
function ApprenticeshipModel:mentorIsSelfQuestCommittedByIndex(idx)
    local questStat = self:mentorGetApprenticeQuestStatByIndex(idx)
    if (not questStat) then return false end
    if (questStat.taskTutorConfirmDay == questStat.taskRefreshDay) then
        return true
    end
end

-- 导师通过下标检查是否学生已经上报
function ApprenticeshipModel:mentorIsApprenticeQuestCommittedByIndex(idx)
    local questStat = self:mentorGetApprenticeQuestStatByIndex(idx)
    if (not questStat) then return false end
    if (questStat.taskStudentConfirmDay == questStat.taskRefreshDay) then
        return true
    end
end

-- 导师通过下标判断是否都上报了
function ApprenticeshipModel:mentorIsAllCommittedByIndex(idx)
    return self:mentorIsApprenticeQuestCommittedByIndex(idx) and self:mentorIsSelfQuestCommittedByIndex(idx)
end

-- 导师通过下标检查是否可以领奖
function ApprenticeshipModel:mentorIsApprenticeAbleToGetQuestRewardByIndex(idx)
    local questStat = self:mentorGetApprenticeQuestStatByIndex(idx)
    if (not questStat or questStat.taskLastFinishDay == 0) then return false end
    local rewardStat = self:mentorGetApprenticeRewardStatByIndex(idx)
    if (not rewardStat) then rewardStat = {} end
    if (not rewardStat.taskRewardDay) then rewardStat.taskRewardDay = 0 end
    return questStat.taskLastFinishDay and rewardStat.taskRewardDay ~= questStat.taskLastFinishDay or false
end

-- 导师获取是否拒绝收徒
function ApprenticeshipModel:mentorIsRejectMentoring()
    return self._generalInfo.isReject == true
end









--------------------------- 奖励数据


-- 导师获取奖励配置数量
function ApprenticeshipModel:mentorGetResultRewardCount()
    return #self._rewardConfigArr
end

-- 导师根据下标获取阶段奖励列表
function ApprenticeshipModel:mentorGetResultRewardByIndex(idx)
    return self._rewardConfigArr[idx]
end

-- 统一导师获取奖励信息
function ApprenticeshipModel:mentorGetApprenticeRewardStatByIndex(idx)
    local apprentice = self:getApprenticeByIndex(idx)
    if (not apprentice) then return end
    local rewardStat = self._pkRewardStatTable[apprentice.PK]   
    if (not rewardStat) then return end
    return rewardStat
end

-- 导师根据下标获取是否有阶段奖励可以领取
function ApprenticeshipModel:mentorIsAbleToGetResultReward(apprenticeIdx)
    local rewardStat = self:mentorGetApprenticeRewardStatByIndex(apprenticeIdx)
    if (not rewardStat) then return false end
    local result = 0
    if (rewardStat.stageStat) then
        result = bit.bxor(rewardStat.stageStat, rewardStat.stageRewardStat or 0)
    end
    return result > 0
end

-- 导师根据进度下标获取进度奖励是否可用
function ApprenticeshipModel:mentorIsResultRewardValidByIndex(apprenticeIdx, stageIdx)
    local rewardStat = self:mentorGetApprenticeRewardStatByIndex(apprenticeIdx)
    if (not rewardStat) then return false end
    local mask = bit.lshift(1, stageIdx)
    local result = bit.band(rewardStat.stageStat, mask)
    return result > 0
end

-- 导师根据进度下标获取进度奖励是否已经领取
function ApprenticeshipModel:mentorIsResultRewardReceivedByIndex(apprenticeIdx, stageIdx)
    local rewardStat = self:mentorGetApprenticeRewardStatByIndex(apprenticeIdx)
    if (not rewardStat) then return false end
    local mask = bit.lshift(1, stageIdx)
    local result = bit.band(rewardStat.stageRewardStat, mask)
    return result > 0
end

-- 导师根据下标获取学生交互数据
function ApprenticeshipModel:mentorGetApprenticeInteractStatByIndex(idx)
    local apprentice = self:getApprenticeByIndex(idx)
    if (not apprentice) then return end
    local interactStat = self._pkInteractTable[apprentice.PK]   
    if (not interactStat) then return end
    return interactStat
end

-- 导师根据下标获取交互奖励是否可以领取
function ApprenticeshipModel:mentorIsAbleToGetInteractRewardByIndex(idx)
    local rewardStat = self:mentorGetApprenticeRewardStatByIndex(idx)
    if (not rewardStat) then return false end
    local interactStat = self:mentorGetApprenticeInteractStatByIndex(idx)
    if (not interactStat) then return false end
    local interactNum = interactStat.Praise and interactStat.Criticize and interactStat.Praise + interactStat.Criticize or 0
    local rewardNum = rewardStat.interactRewardNum or 0

    if (not interactStat.lastInteract) then
        require "app.datas.RoleDataManager"
        local masterPK = RoleDataManager:getMasterPK()
        if (masterPK) then
            interactStat.lastInteract = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.mentorLastInteraction .. masterPK, ApprenticeshipModel.INTERACT_TYPE.PRAISE) 
        end
    end
    return rewardNum < interactNum, interactStat.lastInteract
end

-- 学徒获取是否能够毕业
function ApprenticeshipModel:apprenticeIsGraduated()
    if (self._generalInfo.isOutTutor) then
        return true
    else
        return false
    end
end

-- 学徒获取是否已经领取毕业奖励
function ApprenticeshipModel:apprenticeIsGraduationRewardExist()
    if (self._generalInfo.isOutTutorReward) then
        return true
    else
        return false
    end
end

-- 统一获得奖励配置
function ApprenticeshipModel:getRewardConfigByID(ID)
    local config = self._rewardConfig[ID]
    if (not config) then return end
    return clone(config)
end

-- 学徒获取出师奖励道具列表
function ApprenticeshipModel:apprenticeGetGraduateRewardItemArr()
    local graduateRewardConfig = self:getRewardConfigByID(8) -- 8 = 出师奖励
    if (not graduateRewardConfig) then return end
    return graduateRewardConfig.goodsID, graduateRewardConfig.goodsNum
end

-- 导师获取每日建立列表
function ApprenticeshipModel:mentorGetDailyRewardItemArr()
    local dailyRewardConfig = self:getRewardConfigByID(1)
    if (not dailyRewardConfig) then return end
    return dailyRewardConfig.goodsID, dailyRewardConfig.goodsNum
end

-- 导师获取点赞礼物
function ApprenticeshipModel:mentorGetInteractRewardItemArr()
    local praiseRewardConfig = self:getRewardConfigByID(6) -- 6 = 交互奖励
    if (not praiseRewardConfig) then return end
    return praiseRewardConfig.goodsID, praiseRewardConfig.goodsNum
end

-- 导师根据下标获取阶段奖励列表
function ApprenticeshipModel:mentorGetStageRewardItemArrByIndex(idx)
    local stageRewardConfig = self:getRewardConfigByID(idx + 2)
    if (not stageRewardConfig) then return end
    return stageRewardConfig.goodsID, stageRewardConfig.goodsNum
end

-- 学徒是否能够点踩赞
function ApprenticeshipModel:apprenticeIsAbleToInteract()
   if (not self._generalInfo) then return false end
   if (not self._generalInfo.dailyInteractNum) then return true end
   if (not self._generalInfo.nextInteractTime) then return true end
   if (self._generalInfo.dailyInteractNum >= self._configInfo.interactiveLimit) then return false end
   local timeToAble = self._generalInfo.nextInteractTime - GameManager:getNormalServerTime()
   if (timeToAble > 0) then return false, timeToAble end
   return true
end

return ApprenticeshipModel