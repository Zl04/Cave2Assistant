--[[--
数据模型SevenDaysModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/08/16
--desc	: SevenDaysModel
------------------------------------------------------------------------------
require "app.config.ConfigManager"
require "app.config.TargetActivityConfig"
require "app.config.TargetConfig"

local ProtobufUtil = require("utils.ProtobufUtil")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local DEBUG = false

local SevenDaysModel = class("SevenDaysModel",mvc.GameModel)

-- 七日的相关ID
SEVEN_DAY_SIGN = 5
SEVEN_DAY_TASK = 6
SEVEN_DAY_OLDBACK = 4 -- 老玩家回归
-- 用来标记礼包的ID
SEVEN_DAY_GIFT = 9999

function SevenDaysModel:initData()
    -- 配置表名字写反了
    local targetConfig = clone(Config.TargetActivityConfig:getAllTargetActivityConfig())

    -- 新建目标
    self.sevenClienArr = nil
    self._goalTable = {}
    self._allActivityArr = {}
    for k,v in pairs(targetConfig) do
        if (k ~= "size") then
            local goal = clone(v)
            self._goalTable[k] = goal

            self:parseGoal(goal, self._allActivityArr)
        end
    end
end


-- 通过目标信息创建内容
-- 本地使用的数据结构, 例子:
-- {
--     stageReward = "22070090,20;20120095,1;20120180,1;20120180,1;23109016,1;20120180,1;25000062,1", 
--     stageName = {1112730, 1112736, 1112737, 1112738, 1112739, 1112740, 1112741}, 
--     finalReward = "23109013,1;23020001,500000", 
--     ID = 3, 
--     targetID = "2,3,4,5,6;7,8,9,10,11;12,13,14,15,16;17,18,19,20,21;22,23,24,25,26;27,28,29,30,31;32,33,34,35,36"
-- }
function SevenDaysModel:parseGoal(goal, allActivityArr)
    -- 新建阶段奖励(下面阶段信息使用)
    local stageRewards = {}
    if (goal.stageReward) then
        local rewardsCfg = goal.stageReward:split(";")
        for k, v in ipairs(rewardsCfg) do
            local reward = {}
            local oneReward = v:split(",")
            reward.id = tonumber(oneReward[1])
            reward.num = tonumber(oneReward[2])
            table.insert(stageRewards, reward)
        end
    end

    -- 获取阶段数量
    local stageStrings = {}
    if (goal.targetID) then
        stageStrings = goal.targetID:split(";")
    end
    goal.stageSize = #stageStrings

    -- 创建阶段
    goal.stageArr = {}
    goal.activityArr = {}
    for i,v in ipairs(stageStrings) do
        -- 阶段信息
        local stage = {}
        stage.ID = i
        stage.goalID = goal.ID
        stage.stageReward = stageRewards[i]
        stage.activityArr = {}
        if (not goal.isFromWeb) then -- 如果是从WEB来的配置, 需要从WEB取多语言, 这里不翻译
            stage.nameLocal = LanguageManager:getInstance():getLocalString(goal.stageName[i])
        end
        table.insert(goal.stageArr, stage)

        -- 新建任务
        local activityStrings = v:split(",")
        if (activityStrings and activityStrings[1] and activityStrings[1] ~= "") then
            for i,v in ipairs(activityStrings) do
                local activity = clone(Config.TargetConfig:getTargetConfigById(tonumber(v)))
                if(activity) then
                    activity.stageID = stage.ID
                    activity.goalID = goal.ID
                    self:parseActivity(activity)
                    
                    table.insert(stage.activityArr, activity)
                    table.insert(goal.activityArr, activity)
                    table.insert(allActivityArr, activity)
                else
                    printError("TargetActivity not found id=", v)
                end
            end
        end
    end

    -- 最终奖励
    local finalRewards = {}
    local rewardsCfg = {}
    if (goal.finalReward) then
        rewardsCfg = goal.finalReward:split(";")
    end
    for k, v in ipairs(rewardsCfg) do
        local reward = {}
        local oneReward = v:split(",")
        reward.id = tonumber(oneReward[1])
        reward.num = tonumber(oneReward[2])
        table.insert(finalRewards, reward)
    end
    goal.finalReward = finalRewards

    -- 从WEB获取多语言
    if (goal.isFromWeb and goal.stageName and #goal.stageName > 0) then
        LanguageManager:getInstance():getLanguageFromWebServer(goal.stageName, function (webLaunguageList, params)
            for i,v in ipairs(goal.stageName) do
                local rawText = webLaunguageList[v]
                if (rawText) then
                    local stage = goal.stageArr[i]
                    if (stage) then
                        local textInfo = json.decode(rawText)
                        if (textInfo and textInfo[1] and textInfo[1].text) then
                            stage.nameLocal = textInfo[1].text
                        else
                            stage.nameLocal = "LoadFailed"
                        end
                    end
                end
            end
            mvc.send(mvc.events.SevenDaysUpdateDataAndView)
        end)
    end
end

-- 通过配置类型判断目标数量
function SevenDaysModel:parseActivity(activityData)
    activityData.targetAmount = activityData.param[2]
    activityData.descLocal = LanguageManager:getInstance():getLocalString(activityData.desc)
    activityData.buttonText = UI.TEXT_111035
    
    local subType = activityData.param[1]
    if (activityData.type == PublicDefine.TargetType.TargetType_Login) then
        -- 登录
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_MaxPoint) then
        -- 最大层数
        activityData.descLocal = ""
        local caveTypeString = LanguageManager:getInstance():getLocalString(1150009)
        if (subType == 1) then
            -- 时光之门
            -- caveTypeString = LanguageManager:getInstance():getLocalString(1150009)
        elseif (subType == 2) then
            -- 深渊
            caveTypeString = LanguageManager:getInstance():getLocalString(1110531)
        elseif (subType == 3) then
            -- 新手引导
            caveTypeString = LanguageManager:getInstance():getLocalString(1112009)
        elseif (subType == 4) then
            -- 英雄模式
            caveTypeString = LanguageManager:getInstance():getLocalString(1111320)
        elseif (subType == 5) then
            -- 梦境
            caveTypeString = LanguageManager:getInstance():getLocalString(1111725)
        end

        -- 策划约定, 目标层数不为0则使用一个要拼装层数的多语言
        if (activityData.targetAmount ~= 0) then
            activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), caveTypeString, activityData.targetAmount)
        else
            activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), caveTypeString)
        end
    elseif (activityData.type == PublicDefine.TargetType.TargetType_BlackMargetCost) then
        -- 黑市消费
        local typeString = LanguageManager:getInstance():getLocalString(1111965) --"金币"
        if (subType == 2) then
            typeString = LanguageManager:getInstance():getLocalString(1092002) --水晶
        end
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount, typeString)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_HeroLv) then
        -- 角色等级
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_StrengthLv) then
        -- 装备强化等级
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), subType) -- 强化特殊处理, subType表示+X
    elseif (activityData.type == PublicDefine.TargetType.TargetType_EquipScore) then
        -- 装备星级
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_HomeLv) then
        -- 家园等级
        local typeString = LanguageManager:getInstance():getLocalString(1111517) --金矿
        if (subType == 2) then
            typeString = LanguageManager:getInstance():getLocalString(1111516) --符文工坊
        end
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), typeString, activityData.targetAmount)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_MonsterKill) then
        -- 怪物击杀
        local typeString = LanguageManager:getInstance():getLocalString(1111966) --"任何怪物"
        if (subType ~= 0) then
            require "app.datas.RoleDataManager"
            local monsterData = RoleDataManager:createLocalMonsterDataForAllConfig(subType)
            if (monsterData) then 
                typeString = monsterData:getName()
            end
        end
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount, typeString)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_CoinCost) then
        -- 货币消耗
        local typeString = LanguageManager:getInstance():getLocalString(1111965) --"金币"
        if (subType == 2) then
            typeString = LanguageManager:getInstance():getLocalString(1092002) --水晶
        end
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount, typeString)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_JoinGuild) then
        -- 加入公会
    elseif (activityData.type == PublicDefine.TargetType.TargetType_FriendNum) then
        -- 好友数量
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_EquipRare) then
        -- 装备品质
        require "app.datas.PublicDefine"
        local typeString = ToolsUtil:getGoodsRareStr(subType)
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount, typeString)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_BoxNum) then
        -- 背包格子
        local typeString = LanguageManager:getInstance():getLocalString(1111967) --"背包"
        if (subType == 2) then
            typeString = LanguageManager:getInstance():getLocalString(1111968) --"仓库"
        end
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), typeString, activityData.targetAmount)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_Function) then
        -- 功能操作
        if subType == PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_STARPRAY_GET then 
            -- 占星次数
            activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
        end

    elseif (activityData.type == PublicDefine.TargetType.TargetType_UpgradeHorcrux) then
    elseif (activityData.type == PublicDefine.TargetType.TargetType_EnterCave) then
    elseif (activityData.type == PublicDefine.TargetType.TargetType_CombinePetFragments) then
    elseif (activityData.type == PublicDefine.TargetType.TargetType_ExploreExpedition) then
        local typeString = ""
        if subType == 1 then 
            -- 免费
            typeString = LanguageManager:getInstance():getLocalString(1111364)
        elseif subType == 2 then 
            -- 使用探险卡
            typeString = UI.TEXT_1213121
        end
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), typeString, activityData.targetAmount)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_RebornPet) then
    elseif (activityData.type == PublicDefine.TargetType.TargetType_HeroEquipScore) then
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_GuildWishCount) then
    elseif (activityData.type == PublicDefine.TargetType.TargetType_EquipmentLevel) then
    elseif (activityData.type == PublicDefine.TargetType.TargetType_UnlockHorcrux) then
    elseif (activityData.type == PublicDefine.TargetType.TargetType_PetLevel) then
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_PetStar) then
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
    elseif (activityData.type == PublicDefine.TargetType.TargetType_OpenPetEgg) then
    elseif (activityData.type == PublicDefine.TargetType.TargetType_DefeatWorldBoss) then
    elseif (activityData.type == PublicDefine.TargetType.TargetType_Special) then
        -- 议会特供
        activityData.buttonText = LanguageManager:getInstance():getLocalString(1110147) --购买
    elseif (activityData.type == PublicDefine.TargetType.TargetType_FirstRecharge) then
        -- 首充跳转
        activityData.buttonText = LanguageManager:getInstance():getLocalString(1111969) --"跳转"
    end
end

-- 获取阶段数组
function SevenDaysModel:getStageArr(goalID)
    local goalData = self:getGoalData(goalID)
    if (not goalData or not goalData.stageArr) then return {} end
    return goalData.stageArr
end

-- 获取显示信息
function SevenDaysModel:getGoalData(goalID)
    return self._goalTable[goalID] or {}
end

-- 有些没有本地配置的目标, 是从服务器发过来的, 从这里格式化
-- 网络输入格式, 例子:
-- {
--     stagenameids = {4334}, 
--     totalReward = 0, 
--     mailSend = true, 
--     id = 4, 
--     curStage = 1, 
--     endTime = 624844800, 
--     targets = {
--         {
--             sudId = 10001, 
--             stage = 1, 
--             awards = {
--                 {
--                     num = 1, 
--                     id = 20010011
--                 }
--             }, 
--             overTime = 0, 
--             count = 1, 
--             stat = 2, 
--             targetID = 4
--         }, {
--             sudId = 10003, 
--             stage = 1, 
--             awards = {
--                 {
--                     num = 2, 
--                     id = 20010021
--                 }
--             }, 
--             overTime = 0, 
--             count = 0, 
--             stat = 1, 
--             targetID = 4
--         }
--     }, 
--     openDay = 7231
-- }
-- 本地格式:
-- {
--     stageReward = "22070090,20;20120095,1;20120180,1;20120180,1;23109016,1;20120180,1;25000062,1", 
--     stageName = {1112730, 1112736, 1112737, 1112738, 1112739, 1112740, 1112741}, 
--     finalReward = "23109013,1;23020001,500000", 
--     ID = 3, 
--     targetID = "2,3,4,5,6;7,8,9,10,11;12,13,14,15,16;17,18,19,20,21;22,23,24,25,26;27,28,29,30,31;32,33,34,35,36"
-- }
function SevenDaysModel:parseGoalFromNet(goalFromNet)
    local dummyGoal = {}

    -- 设置ID
    dummyGoal.ID = goalFromNet.id
    dummyGoal.isFromWeb = true

    -- 如果有阶段名称, 创建名称和数据
    if (ProtobufUtil:checkFieldIsInit(goalFromNet, "stagedatas")) then
        dummyGoal.targetID = ""
        dummyGoal.stageReward = ""
        dummyGoal.finalReward = ""
        dummyGoal.stageName = {}
        for stageID,stageInfo in ipairs(goalFromNet.stagedatas) do
            -- 添加阶段分隔符
            if (stageID > 1) then
                dummyGoal.targetID = dummyGoal.targetID .. ";"
                dummyGoal.stageReward = dummyGoal.stageReward .. ";"
            end

            -- 创建阶段名称
            if (ProtobufUtil:checkFieldIsInit(stageInfo, "nameid")) then
                table.insert(dummyGoal.stageName, stageInfo.nameid)
            end

            -- 添加阶段任务
            local stageActivityCount = 0
            if (ProtobufUtil:checkFieldIsInit(goalFromNet, "targets")) then
                for activityID,activityInfo in ipairs(goalFromNet.targets) do
                    if (activityInfo.stage == stageID) then
                        if (stageActivityCount > 0) then
                            dummyGoal.targetID = dummyGoal.targetID .. ","
                        end
                        dummyGoal.targetID = dummyGoal.targetID .. tostring(activityInfo.sudId)
                        stageActivityCount = stageActivityCount + 1
                    end
                end
            end

            -- 添加阶段奖励
            if (ProtobufUtil:checkFieldIsInit(stageInfo, "rewards")) then
                for rewardId,rewardInfo in ipairs(stageInfo.rewards) do
                    if (rewardId > 1) then
                        dummyGoal.stageReward = dummyGoal.stageReward .. ","
                    end
                    dummyGoal.stageReward = dummyGoal.stageReward .. tostring(rewardInfo.id) .. "," .. tostring(rewardInfo.num)
                end
            else
                dummyGoal.stageReward = "20050010,1"
            end
        end

        -- 添加最终奖励
        if (ProtobufUtil:checkFieldIsInit(goalFromNet, "finalrewards")) then
            for rewardId,rewardInfo in ipairs(goalFromNet.finalrewards) do
                if (rewardId > 1) then
                    dummyGoal.finalReward = dummyGoal.finalReward .. ","
                end
                dummyGoal.finalReward = dummyGoal.finalReward .. tostring(rewardInfo.id) .. "," .. tostring(rewardInfo.num)
            end
        else
            dummyGoal.finalReward = "20050010,1"
        end
    end

    -- 填充其他数据
    self:parseGoal(dummyGoal, self._allActivityArr)

    return dummyGoal
end

-- 网络初始化
function SevenDaysModel:initNet(goalStats)
    for i,goalStat in ipairs(goalStats) do
        local goal = self._goalTable[goalStat.id]

        if (not goal) then
            goal = self:parseGoalFromNet(goalStat)
            self._goalTable[goalStat.id] = goal
        end

        -- 处理扩展数据
        if ProtobufUtil:checkFieldIsInit(goalStat, "extraData") then 
            if ProtobufUtil:checkFieldIsInit(goalStat.extraData, "lastSignInGameDay") then 
                goal.lastSignInGameDay = goalStat.extraData.lastSignInGameDay
            end
        end

        -- 检查是否有名字覆盖
        if (goal.isFromWeb and ProtobufUtil:checkFieldIsInit(goalStat, "targetnameid")) then
            LanguageManager:getInstance():getLanguageFromWebServer({goalStat.targetnameid}, function (webLanList, params)
                local rawText = webLanList[goalStat.targetnameid]
                if (rawText) then
                    local textInfo = json.decode(rawText)
                    if (textInfo and textInfo[1] and textInfo[1].text) then
                        goal.goalNameOverride = textInfo[1].text
                        mvc.send(mvc.events.SevenDaysUpdateTitle)
                    end
                end
            end)
        end

        -- 循环设置目标状态
        goal.curStage = goalStat.curStage
        if (ProtobufUtil:checkFieldIsInit(goalStat, "openDay")) then
            goal.openDay = goalStat.openDay
        end
        if (ProtobufUtil:checkFieldIsInit(goalStat, "endTime")) then
            goal.endTimeStamp = goalStat.endTime
        end
        goal.openTimeStamp = goal.openDay * 3600 * 24

        -- 计算结束时间
        if (not goal.endTimeStamp) then
            local startTime = os.time{year=goal.startTime[1], month=goal.startTime[2], day=goal.startTime[3]}
            local endTime = os.time{year=goal.endTime[1], month=goal.endTime[2], day=goal.endTime[3]}
            local durationInSecond = os.difftime(endTime, startTime)
            goal.endTimeStamp = goal.openTimeStamp + durationInSecond + (goal.extraTime or 0)
        end
        goal.closeTimeStamp = goal.endTimeStamp

        -- 循环设置阶段状态
        for i,stage in ipairs(goal.stageArr) do
            if (stage.ID <= goal.curStage) then
                stage.isLocked = false
            else
                stage.isLocked = true
            end

            -- 设置stageReward状态
            stage.stageRewardState = false
            if goalStat.stageReward then
                for _, stageID in ipairs(goalStat.stageReward) do
                    if stageID == stage.ID then
                        stage.stageRewardState = true
                        break
                    end
                end
            end
        end
        -- print("goalStat.totalReward", goalStat.id, goalStat.totalReward)
        -- 最终奖励状态
        if goalStat.totalReward and goalStat.totalReward == 1 then
            goal.finalRewardState = true
        else
            goal.finalRewardState = false
        end

        -- 循环设置任务状态
        if (goalStat.targets) then
            for i,activityStat in ipairs(goalStat.targets) do
                for i,activity in ipairs(goal.activityArr) do
                    local activityId = activity.id and activity.id or activity.ID
                    if (activityStat.targetID == activity.goalID and 
                        activityStat.stage == activity.stageID and
                        activityStat.sudId == activityId)
                    then
                        -- 任务基本信息
                        activity.stat = activityStat.stat
                        activity.count = activityStat.count
                        if (ProtobufUtil:checkFieldIsInit(activityStat, "overTime")) then
                            activity.overTime = activityStat.overTime
                        end

                        -- 如果要替换奖品, 服务器会添加这个字段
                        if (ProtobufUtil:checkFieldIsInit(activityStat, "awards")) then
                            activity.rewardid = {}
                            activity.rewardnum = {}
                            for i,goodInfo in ipairs(activityStat.awards) do
                                table.insert(activity.rewardid, goodInfo.id)
                                table.insert(activity.rewardnum, goodInfo.num)
                            end
                        elseif (goal.isFromWeb) then
                            activity.rewardid = {20050010}
                            activity.rewardnum = {1}
                        end
                    end
                end
            end
        end
    end
    self:updateFinishStat()
end

-- 网络更新完成状态
function SevenDaysModel:updateActivityFinish(activityFinishData)
    if activityFinishData.stage == 0 and activityFinishData.sudId == 0 then
        -- 最终奖励状态更新
        local goal = self._goalTable[activityFinishData.targetID]
        goal.finalRewardState = true
        return
    end

    if activityFinishData.sudId == 0 then
        -- 是stage reward状态更新
        local goal = self._goalTable[activityFinishData.targetID]
        local stage = goal.stageArr[activityFinishData.stage]
        stage.stageRewardState = true

        -- 处理扩展数据
        if ProtobufUtil:checkFieldIsInit(activityFinishData, "lastSignInGameDay") then 
            goal.lastSignInGameDay = activityFinishData.lastSignInGameDay
        end
        return
    end

    local isUpdated = false
    for i,activity in ipairs(self._allActivityArr) do
        if (activityFinishData.targetID == activity.goalID and 
            activityFinishData.stage == activity.stageID and 
            activityFinishData.sudId == activity.ID)
        then
            isUpdated = true
            activity.stat = 3
        end
    end

    if (isUpdated) then
        self:updateFinishStat()
    end
end

-- 网络状态更新
function SevenDaysModel:updateActivityStats(activityStats)
    -- 循环设置任务状态
    for i,activityStat in ipairs(activityStats) do
        for i,activity in ipairs(self._allActivityArr) do
            local activityId = activity.id and activity.id or activity.ID
            if (activityStat.targetID == activity.goalID and 
                activityStat.stage == activity.stageID and 
                activityStat.sudId == activityId)
            then
                activity.stat = activityStat.stat
                activity.count = activityStat.count
                if (ProtobufUtil:checkFieldIsInit(activityStat, "overTime")) then
                    activity.overTime = activityStat.overTime
                end
            end
        end
    end
    self:updateFinishStat()
end

-- 领取状态更新
function SevenDaysModel:updateFinishStat()
    for i,goal in pairs(self._goalTable) do
        goal.finNum = 0  -- 用于红点显示
        goal.finishTaskNum = 0  -- 用于显示任务完成的总进度
        local curStage = goal.curStage or 0
        local goalFinishExist = false
        for i,stage in ipairs(goal.stageArr) do
            if (stage.ID > curStage) then break end
            local stageFinishExist = false
            for i,activity in ipairs(stage.activityArr) do
                if (activity.stat == 2) then
                    activity.isFinishStatExist = true
                    stageFinishExist = true
                    goalFinishExist = true
                    goal.finNum = goal.finNum + 1
                    goal.finishTaskNum = goal.finishTaskNum + 1
                elseif activity.stat == 3 then
                    goal.finishTaskNum = goal.finishTaskNum + 1
                else
                    activity.isFinishStatExist = false
                end
            end
            if (stageFinishExist) then 
                stage.isFinishStatExist = true 
            else
                stage.isFinishStatExist = false
            end
        end
        if (goalFinishExist) then
            goal.isFinishStatExist = true
        else
            goal.isFinishStatExist = false
        end
    end
end

-- 获取目标是否有可完成事项
function SevenDaysModel:checkGoalFinishExist(goalID)
    local goal = self._goalTable[goalID]
    if (not goal) then return false end
    return goal.isFinishStatExist or false
end

-- 获取目标的阶段是否有可完成事项
function SevenDaysModel:checkStageFinishExist(goalID, stageID)
    local goal = self._goalTable[goalID]
    if (not goal) then return false end
    for i,stage in ipairs(goal.stageArr) do
        if (stage.ID == stageID) then
            return stage.isFinishStatExist or false
        end
    end
    return false
end

-- 获取目标的某个人物是否有可完成事项
function SevenDaysModel:checkActivityFinishExist(goalID, stageID, activityID)
    local goal = self._goalTable[goalID]
    if (not goal) then return false end
    for i,stage in ipairs(goal.stageArr) do
        if (stage.ID == stageID) then
            for i,activity in ipairs(stage.activityArr) do
                if (activity.ID == activityID) then
                    return activity.isFinishStatExist or false
                end
            end
        end
    end
    return false
end

function SevenDaysModel:getGoalTable()
    return self._goalTable or {}
end

-- 清空管理器
function SevenDaysModel:clear()
    self:init()
end

-- 回档（恢复）清理数据
function SevenDaysModel:restoreClear()
    self:clear()
end

-- 获取目标进度
function SevenDaysModel:getTotalPrgForGoal(goalID)
    if goalID == nil or self._goalTable[goalID] == nil then
        return 0
    end
    local finishNum = self._goalTable[goalID].finishTaskNum
    local totalNum = #self._goalTable[goalID].activityArr
    return finishNum/totalNum
end

-- 获取是否展示界面
function SevenDaysModel:isOpenGoal(goalID)
    if (ServerConfigUtil:isInReview()) then return false end
    
    local sevenDayGoalData = self._goalTable[goalID]
    if (not sevenDayGoalData) then return false end
    if (SceneManager:getInstance():isInStory()) then return false end
    if (not sevenDayGoalData.closeTimeStamp or not sevenDayGoalData.openTimeStamp) then return false end

    local timeNow = GameManager:getNormalServerTime()
    if (timeNow > sevenDayGoalData.closeTimeStamp or timeNow < sevenDayGoalData.openTimeStamp) then 
        return false
    else
        return true
    end
end

-- 获取是否能够领奖
function SevenDaysModel:isAbleToGetReward()
    if (not SceneManager:getInstance():isInFightScene()) then
        return true
    end
    return false
end

-- 获取目标的状态
function SevenDaysModel:getFinishStat(goalID, stageID, activityID)
    self:updateFinishStat()

    local goalFinishStat = self:checkGoalFinishExist(goalID)
    local stageFinishStat = nil
    local activityFinishStat = nil
    if (stageID) then
        stageFinishStat = self:checkStageFinishExist(goalID, stageID)
    end
    if (activityID) then 
        activityFinishStat = self:checkActivityFinishExist(goalID, stageID, activityID)
    end
    return goalFinishStat, stageFinishStat, activityFinishStat
end

-- 获取签到的完成状态
function SevenDaysModel:getSignFinishStateForGoal(goalID)
    local goal = self._goalTable[goalID]
    local heroRefreshDay = 0
    if(RoleDataManager and RoleDataManager:getMaster() and RoleDataManager:getMaster():getRefreshDay()) then 
        heroRefreshDay = RoleDataManager:getMaster():getRefreshDay()
    end

    for k, act in ipairs(goal.activityArr) do
        local stage = goal.stageArr[k] -- 一个阶段里头就只有一个任务, 所以这里可以用任务下标取stage信息
        if act.stat == 2 and stage.stageRewardState == false then
            return true
        end

        if act.stat == 1 
            and stage.stageRewardState == false then
            if goal.lastSignInGameDay < heroRefreshDay then 
                return true
            end
        end
    end

    return false
end

function SevenDaysModel:getActDuringTime(index)
    local timeStamp1 = os.date("!*t", self._goalTable[index].openTimeStamp+GameManager:getEPOCHTime())
    -- add by zp CO-13483 新手七日活动持续时间优化  这里由于会导致显示表达的默认意思误差一天(注意这里不需要携带时区)
    local timeStamp2 = os.date("!*t", self._goalTable[index].closeTimeStamp + GameManager:getEPOCHTime())
    local timeStr1 = timeStamp1.year .. "." .. timeStamp1.month .. "." .. timeStamp1.day
    local timeStr2 = timeStamp2.year .. "." .. timeStamp2.month .. "." .. timeStamp2.day
    return timeStr1, timeStr2
end

function SevenDaysModel:checkCanGetFinalReward(index)
    if (not index) then return false end
    
    if(index == SEVEN_DAY_GIFT) then 
        if #self:getSevenGiftBag() >= MasterDataManager:getSpecialOfferIndex() then 
            return true
        end

        return false
    end

    local curGoal = self._goalTable[index]
    if curGoal.finalRewardState then
        return false
    end

    if(index == SEVEN_DAY_SIGN) then 
        local curGoal = self._goalTable[index]
        if(curGoal) then 
            local heroRefreshDay = 0
            if(RoleDataManager and RoleDataManager:getMaster() and RoleDataManager:getMaster():getRefreshDay()) then 
                heroRefreshDay = RoleDataManager:getMaster():getRefreshDay()
            end

            for k, v in ipairs(curGoal.activityArr) do
                if(v.stat == 1) then
                    if curGoal.lastSignInGameDay < heroRefreshDay then 
                        return false
                    end
                end
            end
        end
    end

    local finNum = 0
    for k, v in ipairs(curGoal.activityArr) do
        -- 七日计划，只将开放天数纳入进度完成的判断之中
        if index == SEVEN_DAY_TASK and v.stageID > curGoal.curStage then
            break
        end

        if v.stat == 2 or v.stat == 3 then
            finNum = finNum + 1
        end
    end

    return finNum >= #curGoal.activityArr
end

-- 这里针对七日签到，重新计算一次curStage
function SevenDaysModel:recalculateStageForGoal(goalID)
    if (not goalID) then return end

    local goalData = self:getGoalData(goalID)
    local curStage = 0
    for k, v in ipairs(goalData.activityArr) do
        if v.stat and v.stat > 1 then
            curStage = curStage + 1
        end
    end

    goalData.curStage = curStage
end

-- 判断是否需要从web取多语言
function SevenDaysModel:isNeedToGetStringFromWeb(goalID)
    local goal = self._goalTable[goalID]
    if (goal and goal.isFromWeb) then
        return true
    end
    return false
end

-- 判断是否需要显示签到
function SevenDaysModel:isGoalFromWeb(goalID)
    local goal = self._goalTable[goalID]
    if (goal and goal.isFromWeb) then
        return true
    end
    return false
end

-- 获取7日礼包
function SevenDaysModel:getSevenGiftBag()
    local SdkManager = require "app.game.SdkManager"
    local giftData = SdkManager:getInstance():getIapDatas()
    local giftArr = {}
    for k, v in pairs(giftData) do
        if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.SpecialOfferPack then
            -- print("getSevenGiftBag=", v)
            table.insert(giftArr, v)
        end
    end

    return giftArr
end

-- 获取7日礼包客户端配置
function SevenDaysModel:getSevenGiftClientConfig(specialIndex)
    if(self.sevenClienArr == nil) then
        self.sevenClienArr = {}
        local config = ConfigManager:getGeneralForKey("sevendaysdiscount")
        if(config) then 
            local configArr = string.split(config, ";")
            for k,v in ipairs(configArr) do 
                local oneArr = string.split(v, ",")
                if(oneArr and #oneArr == 2) then 
                    local oneData = {}
                    oneData.sale = oneArr[1]
                    oneData.animation = oneArr[2]

                    table.insert(self.sevenClienArr, oneData)
                end
            end
        end
    end

    return self.sevenClienArr[specialIndex]
end

function SevenDaysModel:getSevenRedStatus(goalID)
    local data = self:getGoalData(goalID)

    local goalID = data.goalIdx
    local stat1 = false
    if(goalID == SEVEN_DAY_GIFT) then 
        local stat2 = mvc.sevenDaysModel:checkCanGetFinalReward(goalID)
        if stat1 or stat2 then
            self.redPoint:show()
        else
            self.redPoint:hide()
        end
    else
        if (data.isSignInGoal) then
            stat1 = mvc.sevenDaysModel:getSignFinishStateForGoal(goalID)
        else
            stat1 = mvc.sevenDaysModel:getFinishStat(goalID)
        end

        local stat2 = mvc.sevenDaysModel:checkCanGetFinalReward(goalID)
        if stat1 or stat2 then
            self.redPoint:show()
        else
            self.redPoint:hide()
        end
    end
end

return SevenDaysModel