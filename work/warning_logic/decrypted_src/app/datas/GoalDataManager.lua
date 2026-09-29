--[[
    目标管理器
]]
------------------------------------------------------
require "app.config.ConfigManager"
require "app.config.TargetActivityConfig"
require "app.config.TargetConfig"

local ProtobufUtil = require("utils.ProtobufUtil")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local DEBUG = false

GoalDataManager = GoalDataManager or {}

-- 初始化
function GoalDataManager:init()
    -- 配置表名字写反了
    local targetConfig = clone(Config.TargetActivityConfig:getAllTargetActivityConfig())

    -- 新建目标
    self._goalTable = {}
    self._allActivityArr = {}
    for k,v in pairs(targetConfig) do
        if (k ~= "size") then
            local goal = clone(v)
            goal.stageArr = {}
            goal.activityArr = {}
            self._goalTable[k] = goal
            
            -- 新建阶段
            local stageStrings = goal.targetID:split(";")
            goal.stageSize = #stageStrings
            for i,v in ipairs(stageStrings) do
                local stage = {}
                stage.ID = i
                stage.goalID = goal.ID
                stage.activityArr = {} 
                stage.nameLocal = LanguageManager:getInstance():getLocalString(goal.stageName[i])
                table.insert(goal.stageArr, stage)

                -- 新建任务
                local activityStrings = v:split(",")
                for i,v in ipairs(activityStrings) do
                    local activity = clone(Config.TargetConfig:getTargetConfigById(tonumber(v)))
                    activity.stageID = stage.ID
                    activity.goalID = goal.ID
                    self:parseActivity(activity)
                    
                    table.insert(stage.activityArr, activity)
                    table.insert(goal.activityArr, activity)
                    table.insert(self._allActivityArr, activity)
                end
            end
        end
    end
end

-- 网络初始化
function GoalDataManager:initNet(goalStats)
    for i,goalStat in ipairs(goalStats) do
        local goal = self._goalTable[goalStat.id]
        if (goal) then
            -- 循环设置目标状态
            goal.curStage = goalStat.curStage
            if (ProtobufUtil:checkFieldIsInit(goalStat, "openDay")) then
                goal.openDay = goalStat.openDay
            end
            if (ProtobufUtil:checkFieldIsInit(goalStat, "endTime")) then
                goal.endTimeStamp = goalStat.endTime
            end
            goal.openDay = goalStat.openDay
            goal.openTimeStamp = goal.openDay * 3600 * 24

            -- 计算结束时间
            if (not goal.endTimeStamp) then
                local startTime = os.time{year=goal.startTime[1], month=goal.startTime[2], day=goal.startTime[3]}
                local endTime = os.time{year=goal.endTime[1], month=goal.endTime[2], day=goal.endTime[3]}
                local durationInSecond = os.difftime(endTime, startTime)
                goal.endTimeStamp = goal.openTimeStamp + durationInSecond + goal.extraTime
            end
            goal.closeTimeStamp = goal.endTimeStamp

            -- 循环设置阶段状态
            for i,stage in ipairs(goal.stageArr) do
                if (stage.ID <= goal.curStage) then
                    stage.isLocked = false
                else
                    stage.isLocked = true
                end
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
                            activity.stat = activityStat.stat
                            activity.count = activityStat.count
                            if (ProtobufUtil:checkFieldIsInit(activityStat, "overTime")) then
                                activity.overTime = activityStat.overTime
                            end
                        end
                    end
                end
            end
        end
    end
    self:updateFinishStat()
end

-- 网络更新完成状态
function GoalDataManager:updateActivityFinish(activityFinishData)
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
function GoalDataManager:updateActivityStats(activityStats)
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
function GoalDataManager:updateFinishStat()
    for i,goal in pairs(self._goalTable) do
        goal.finNum = 0
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

--[[
enum TargetType {
    TargetType_Login = 1;//登录
    TargetType_MaxPoint = 2;//最大层数
    TargetType_BlackMargetCost = 3;//黑市消费
    TargetType_HeroLv = 4;//角色等级
    TargetType_StrengthLv = 5;//装备强化等级
    TargetType_EquipScore = 6;//装备星级
    TargetType_HomeLv = 7;//家园等级(TargetHomeLvType)
    TargetType_MonsterKill = 8;//怪物击杀(MonsterID)
    TargetType_CoinCost = 9;//货币消耗(GOODS_COST_TYPE)
    TargetType_JoinGuild = 10;//加入公会
    TargetType_FriendNum = 11;//好友数量
    TargetType_EquipRare = 12;//装备品质
    TargetType_BoxNum = 13;//背包格子(Box_TYPE)
    TargetType_Function = 14;//功能操作(FUNCTION_TYPE)
    TargetType_Special = 99;//特供
    TargetType_FirstRecharge = 100;//首充跳转
}
enum TargetHomeLvType {
    TargetHomeLvType_Gold = 1;  //金矿
    TargetHomeLvType_Gem = 2;   //符文矿
}

enum Goods_Cost_Type{
    Goods_Cost_Type_Gold = 1; //金币
    Goods_Cost_Type_Diamond = 2; //钻石

} 

背包格子Box_Type ， 1 背包 2仓库
]]
-- 通过配置类型判断目标数量
function GoalDataManager:parseActivity(activityData)
    activityData.targetAmount = activityData.param[2]
    activityData.descLocal = LanguageManager:getInstance():getLocalString(activityData.desc)
    activityData.buttonText = UI.TEXT_111035
    
    local subType = activityData.param[1]
    if (activityData.type == 1) then
        -- 登录
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
    elseif (activityData.type == 2) then
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
    elseif (activityData.type == 3) then
        -- 黑市消费
        local typeString = LanguageManager:getInstance():getLocalString(1111965) --"金币"
        if (subType == 2) then
            typeString = LanguageManager:getInstance():getLocalString(1092002) --水晶
        end
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount, typeString)
    elseif (activityData.type == 4) then
        -- 角色等级
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
    elseif (activityData.type == 5) then
        -- 装备强化等级
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), subType) -- 强化特殊处理, subType表示+X
    elseif (activityData.type == 6) then
        -- 装备星级
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
    elseif (activityData.type == 7) then
        -- 家园等级
        local typeString = LanguageManager:getInstance():getLocalString(1111517) --金矿
        if (subType == 2) then
            typeString = LanguageManager:getInstance():getLocalString(1111516) --符文工坊
        end
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), typeString, activityData.targetAmount)
    elseif (activityData.type == 8) then
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
    elseif (activityData.type == 9) then
        -- 货币消耗
        local typeString = LanguageManager:getInstance():getLocalString(1111965) --"金币"
        if (subType == 2) then
            typeString = LanguageManager:getInstance():getLocalString(1092002) --水晶
        end
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount, typeString)
    elseif (activityData.type == 10) then
        -- 加入公会
    elseif (activityData.type == 11) then
        -- 好友数量
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount)
    elseif (activityData.type == 12) then
        -- 装备品质
        require "app.datas.PublicDefine"
        local typeString = ToolsUtil:getGoodsRareStr(subType)
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), activityData.targetAmount, typeString)
    elseif (activityData.type == 13) then
        -- 背包格子
        local typeString = LanguageManager:getInstance():getLocalString(1111967) --"背包"
        if (subType == 2) then
            typeString = LanguageManager:getInstance():getLocalString(1111968) --"仓库"
        end
        activityData.descLocal = string.format(LanguageManager:getInstance():getLocalString(activityData.desc), typeString, activityData.targetAmount)
    elseif (activityData.type == 14) then
        -- 功能操作
    elseif (activityData.type == 99) then
        -- 议会特供
        activityData.buttonText = LanguageManager:getInstance():getLocalString(1110147) --购买
    elseif (activityData.type == 100) then
        -- 首充跳转
        activityData.buttonText = LanguageManager:getInstance():getLocalString(1111969) --"跳转"
    end
end

-- 获取目标是否有可完成事项
function GoalDataManager:checkGoalFinishExist(goalID)
    local goal = self._goalTable[goalID]
    if (not goal) then return false end
    return goal.isFinishStatExist or false
end

-- 获取目标的阶段是否有可完成事项
function GoalDataManager:checkStageFinishExist(goalID, stageID)
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
function GoalDataManager:checkActivityFinishExist(goalID, stageID, activityID)
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

function GoalDataManager:getGoalTable()
    return self._goalTable or {}
end

-- 清空管理器
function GoalDataManager:clear()
    self._sevenDayActiveStage = nil
    self:init()
end

-- 回档（恢复）清理数据
function GoalDataManager:restoreClear()
    self:clear()
end

















--- 七日 ---------------------------------------

-- 获取完成数量
function GoalDataManager:getSevenDayGoalFinNum()
    local finNum = 0
    local sevenDayGoal = self._goalTable[1]
    if (sevenDayGoal and sevenDayGoal.finNum) then
        finNum = sevenDayGoal.finNum
    end
    return finNum
end

-- 获取显示信息
function GoalDataManager:getGoalData(goalID)
    return self._goalTable[goalID] or {}
end

-- 获取阶段数组
function GoalDataManager:getStageArr(goalID)
    local goalData = self:getGoalData(goalID)
    if (not goalData or not goalData.stageArr) then return {} end
    return goalData.stageArr
end

-- 获取任务数组
function GoalDataManager:getActiveStageActivityArr(goalID)
    local stageArr = self:getStageArr(goalID)
    if (not stageArr) then return {} end

    -- 从缓存中检查激活的阶段, 如果没有缓存或者缓存已经不是激活的阶段, 更新缓存
    local activeStage = nil
    if (self._sevenDayActiveStage ~= nil and self._sevenDayActiveStage.isActive) then
        activeStage = self._sevenDayActiveStage
    else
        for i,stage in ipairs(stageArr) do
            if (stage.isActive) then
                activeStage = stage
                self._sevenDayActiveStage = activeStage
                break
            end
        end
    end
    
    if (not activeStage or not activeStage.activityArr) then return {} end
    return activeStage.activityArr
end

-- 获取是否展示界面
function GoalDataManager:isOpenGoal(goalID)
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
function GoalDataManager:isAbleToGetReward()
    if (not SceneManager:getInstance():isInFightScene()) then
        return true
    end
    return false
end

-- 获取七日目标状态
function GoalDataManager:getFinishStat(isUpdateStat, stageID, activityID)
    if (isUpdateStat == nil) then isUpdateStat = true end
    if (isUpdateStat) then
        self:updateFinishStat()
    end
    local goalFinishStat = self:checkGoalFinishExist(1)
    local stageFinishStat = nil
    local activityFinishStat = nil
    if (stageID) then
        stageFinishStat = self:checkStageFinishExist(1, stageID)
    end
    if (activityID) then 
        activityFinishStat = self:checkActivityFinishExist(1, stageID, activityID)
    end
    return goalFinishStat, stageFinishStat, activityFinishStat
end

--默认初始化
GoalDataManager:init()