--[[--
数据模型ActivityPointModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: CMonk
--date	: 2019/06/26
--desc	: ActivityPointModel
------------------------------------------------------------------------------

local ActivityPointModel = class("ActivityPointModel",mvc.GameModel)

ActivityPointModel.NOT_RUNNING_TYPE = {
    RUNNING = 0,
    BEFORE = 1, 
    AFTER = 2
}

local function updateActivityPoint(activity)
    if (activity.actNum) then
        activity.activityPointNum = activity.actNum * activity.rewardpoints
    else
        activity.activityPointNum = 0
    end
end

local function convertTimeStrToSecondsInDay(timeStr)
    local secondsInDay = 0
    local hourString = timeStr:sub(1, -3)
    local hour = tonumber(hourString)
    secondsInDay = secondsInDay + hour * 3600
    local minString = timeStr:sub(-2, -1)
    local min = tonumber(minString)
    secondsInDay = secondsInDay + min * 60
    return secondsInDay
end

function ActivityPointModel:initData()
    self._totalActivityPoint = 0
    self._rewardStat = 0
    self._count = 0

    -- 解析阶段点数
    local stageConfigStrArr = string.split(ConfigManager:getGeneralForKey("ActivePointsNumber"), ";")
    self._stagePointArr = {}
    for i,v in ipairs(stageConfigStrArr) do
        table.insert(self._stagePointArr, tonumber(v))
    end
    
    -- 解析奖励
    local stageRewardStrArr = string.split(ConfigManager:getGeneralForKey("ActivePointsReward"), ";")
    self._stageRewardArrTable = {}
    for i,v in ipairs(stageRewardStrArr) do
        local rewardInfo = {}
        local rewardInfoStrArr = string.split(v, ",")
        rewardInfo.ID = tonumber(rewardInfoStrArr[1])
        rewardInfo.goodsID = tonumber(rewardInfoStrArr[2])
        rewardInfo.goodsNum = tonumber(rewardInfoStrArr[3])

        if (not self._stageRewardArrTable[rewardInfo.ID]) then
            self._stageRewardArrTable[rewardInfo.ID] = {}
        end
        table.insert(self._stageRewardArrTable[rewardInfo.ID], rewardInfo)
    end

    -- 解析一些参数
    self._allActivityDataTable = clone(ConfigManager:getAllActivityPointConfig())
    self._allActivityDataArr = {}
    for k,v in pairs(self._allActivityDataTable) do
        -- 解析奖励总量
        v.activityPointLimit = v.rewardtimes * v.rewardpoints

        -- 解析时间限制
        if (v.limittime == 1 and v.opentime and v.opentime ~= "" and v.endtime and v.endtime ~= "") then
            v.openArr = {}
            local openStrArr = string.split(v.opentime, ";")
            for i,openStr in ipairs(openStrArr) do
                local secondsInDay = convertTimeStrToSecondsInDay(openStr)
                table.insert(v.openArr, secondsInDay)
            end
            v.endArr = {}
            local endStrArr = string.split(v.endtime, ";")
            for i,endStr in ipairs(endStrArr) do
                local secondsInDay = convertTimeStrToSecondsInDay(endStr)
                table.insert(v.endArr, secondsInDay)
            end
        end

        -- 初始化完成次数
        v.actNum = 0

        table.insert(self._allActivityDataArr, v)
        self._count = self._count + 1
    end
    self:sortActivityArr()
end

-- 转换一下
function ActivityPointModel:mapIdxToFunType(idx)
    local FUNCTION_TYPE = PublicDefine.FUNCTION_TYPE
    if (idx == 1) then                      -- 每日登陆
    elseif (idx == 2) then                  -- 洞窟探索
        return FUNCTION_TYPE.GENERAL_ENTRANCE
    elseif (idx == 3) then                  -- 日常任务
        return FUNCTION_TYPE.TASK
    elseif (idx == 4) then                  -- 公会任务
        return FUNCTION_TYPE.GUILD_TASK
    elseif (idx == 5) then                  -- 梦境
        return FUNCTION_TYPE.FUNCTION_TYPE_DREAM
    elseif (idx == 6) then                  -- 深渊
        return FUNCTION_TYPE.SPECIFIC_ENTRANCE
    elseif (idx == 7) then                  -- 首领入侵
        return FUNCTION_TYPE.ACTIVITY 
    elseif (idx == 8) then                  -- 公会BOSS
        return FUNCTION_TYPE.FUNCTION_TYPE_GUILDBOSS
    elseif (idx == 9) then                  -- 转盘抽奖
        return FUNCTION_TYPE.LUCKYWHEEL_TURN
    elseif (idx == 10) then                 -- 符文探索
        return FUNCTION_TYPE.GEMSTONE_BUY
    elseif (idx == 11) then                 -- 金矿
        return FUNCTION_TYPE.HOME_SYSTEM_MINE
    elseif (idx == 12) then                 -- 符文工坊
        return FUNCTION_TYPE.HOME_SYSTEM_GEM 
    elseif (idx == 13) then                 -- 占星
        return FUNCTION_TYPE.FUNCTION_TYPE_STARPRAY_GET
    elseif (idx == 14) then                 -- 团队协作
        local GameDataManager = require("app.game.GameDataManager")
        local checkPoint = GameDataManager:getInstance():getMaxCheckPoint()
        local functionType = FUNCTION_TYPE.GENERAL_ENTRANCE
        if(checkPoint) then 
            local caveMode = checkPoint:getMode()
            if caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
                functionType = FUNCTION_TYPE.GENERAL_ENTRANCE
            elseif caveMode == PublicDefine.CAVE_MODE.MODE_HERO or 
            caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                functionType = FUNCTION_TYPE.SPECIFIC_ENTRANCE    
            elseif caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
                functionType = FUNCTION_TYPE.DESERT_EYE    
            elseif caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE then
                functionType = FUNCTION_TYPE.DISTORTED_SPACE    
            elseif caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then
                functionType = FUNCTION_TYPE.FUNCTION_INFERNO    
            elseif caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
                functionType = FUNCTION_TYPE.FUNCTION_VOID_RIFT
            elseif caveMode == PublicDefine.CAVE_MODE.MODE_VIKING then
                functionType = FUNCTION_TYPE.FUNCTION_VIKING
            elseif caveMode == PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT then
                functionType = FUNCTION_TYPE.FUNCTION_EVER_WINTER
            elseif caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
                functionType = FUNCTION_TYPE.GENERAL_ENTRANCE    
            elseif caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS then
                functionType = FUNCTION_TYPE.FUNCTION_CHAOS    
            elseif caveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE then
                functionType = FUNCTION_TYPE.FUNCTION_WORMHOLE
            end
        end
        return functionType
    elseif (idx == 16) then                 -- 冬泳裂缝
        return FUNCTION_TYPE.FUNCTION_EVER_WINTER
    elseif (idx == 18) then                 -- 幽灵深渊
        return FUNCTION_TYPE.FUNCTION_GHOST_LEVELSELECT
    end
end

function ActivityPointModel:initNet(data)
    -- 如果都为0则清空所有数据
    if (data.curActions == 0 and data.rewardStat == 0) then
        self:clear()
        self:initData()
        return
    end

    -- 更新总量和阶段
    self._totalActivityPoint = data.curActions
    self._rewardStat = data.rewardStat
    
    -- 更新列表
    for i,v in ipairs(data.actList) do
        local activityID = v.id
        local activity = self._allActivityDataTable[activityID]
        if (activity) then
            activity.actNum = v.actNum
            updateActivityPoint(activity)
        end
    end

    -- 重新排序
    self:sortActivityArr()
end

-- 设置已领奖的阶段
function ActivityPointModel:setStage(stage)
    self._rewardStat = stage
end

-- 获取已领奖的阶段
function ActivityPointModel:getStage()
    return self._rewardStat
end

-- 进度已到的阶段
function ActivityPointModel:getProgressStage()
    local totalPoint = self:getTotalPoint()
    local progressStage = 0
    for i,v in ipairs(self._stagePointArr) do
        if (totalPoint >= v) then
            progressStage = i
        else
            break
        end
    end
    return progressStage
end

-- 获取阶段点数数组
function ActivityPointModel:getProgressPointArr()
    return self._stagePointArr
end

-- 获取总数量
function ActivityPointModel:getTotalPoint()
    return self._totalActivityPoint
end

-- 获取可以领取数量
function ActivityPointModel:getRewardNum()
    local currentStage = self:getStage()
    local progressStage = self:getProgressStage()
    local rewardNum = progressStage - currentStage
    return rewardNum > 0 and rewardNum or 0
end

-- 获取所有的互动数据
function ActivityPointModel:getActivityDataTable()
    return self._allActivityDataTable
end

-- 从阶段获得奖励信息
function ActivityPointModel:getRewardArrFromID(idx)
    return self._stageRewardArrTable[idx]
end

-- 数量
function ActivityPointModel:getActivityNum()
    return self._count
end

-- 根据指针获取活动数据
function ActivityPointModel:getActivityFromIdx(idx)
    local activity = self._allActivityDataArr[idx]
    self:updateUnlockStatusForActivity(activity)
    return activity
end

-- 获取所有活动数据
function ActivityPointModel:getAllActivity()
    for i,v in ipairs(self._allActivityDataArr) do
        self:updateUnlockStatusForActivity(v)
    end
    self:sortActivityArr()
    return self._allActivityDataArr
end

-- 更新解锁状态
function ActivityPointModel:updateUnlockStatusForActivity(activity)
    local idx = activity.ID
    local funType = self:mapIdxToFunType(idx)
    if (not funType) then
        activity.isUnlocked = true
        return
    end

    local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")
    activity.isUnlocked = FunctionUnlockManager:getInstance():isUnlockByNpcLockType(funType)
end

local function joinArrs(...)
    local result = { }
    for _,t in ipairs({...}) do
        if type(t) == "table" then
            for _,v in ipairs(t) do
                table.insert(result, v)
            end
        else
            table.insert(result, t)
        end
    end
    return result
end

-- 排序列表
function ActivityPointModel:sortActivityArr()
    -- 未解锁
    local locked = {}
    for i=#self._allActivityDataArr,1,-1 do
        local v = self._allActivityDataArr[i]
        if (not v.isUnlocked) then
            table.insert(locked, v)
            table.remove(self._allActivityDataArr, i)
        end
    end
    table.sort(locked, function(a, b) return a.ID < b.ID end)

    -- 未完成
    local unfinished = {}
    for i=#self._allActivityDataArr,1,-1 do
        local v = self._allActivityDataArr[i]
        if (v.actNum < v.rewardtimes) then
            table.insert(unfinished, v)
            table.remove(self._allActivityDataArr, i)
        end
    end
    local alreadyFinished = self._allActivityDataArr
    table.sort(unfinished, function(a, b) return a.ID < b.ID end)
    table.sort(alreadyFinished, function(a, b) return a.ID < b.ID end)

    -- 未完成且在限时时区内
    local timeLimitRunningArr = {}
    for i=#unfinished,1,-1 do
        local v = unfinished[i]
        if (v.limittime == 1 and self:isInTimeLimit(v)) then
            table.insert(timeLimitRunningArr, v)
            table.remove(unfinished, i)
        end
    end
    table.sort(timeLimitRunningArr, function(a, b) return a.ID < b.ID end)

    -- 未完成且未在开启时间内
    local notYetOpenArr = {}
    local alreadyExpiredArr = {}
    for i=#unfinished,1,-1 do
        local v = unfinished[i]
        local isInRunningTime, notRunningType = self:isInTimeLimit(v)
        if (not isInRunningTime) then
            if (notRunningType == ActivityPointModel.NOT_RUNNING_TYPE.BEFORE) then
                table.insert(notYetOpenArr, v)
            elseif (notRunningType == ActivityPointModel.NOT_RUNNING_TYPE.AFTER) then
                table.insert(alreadyExpiredArr, v)
            end 
            table.remove(unfinished, i)
        end
    end
    table.sort(notYetOpenArr, function(a, b) return a.ID < b.ID end)
    table.sort(alreadyExpiredArr, function(a, b) return a.ID < b.ID end)

    -- 已经有积累点数的开启中的限时任务
    local havePointsLimitedArr = {}
    for i=#timeLimitRunningArr,1,-1 do
        local v = timeLimitRunningArr[i]
        if (v.actNum >0) then
            table.insert(havePointsLimitedArr, v)
            table.remove(timeLimitRunningArr, i)
        end
    end

    -- 已经有积累点数的普通任务
    local havePointsUnfinishedArr = {}
    for i=#unfinished,1,-1 do
        local v = unfinished[i]
        if (v.actNum >0) then
            table.insert(havePointsUnfinishedArr, v)
            table.remove(unfinished, i)
        end
    end
    table.sort(havePointsUnfinishedArr, function(a, b) return a.ID < b.ID end)

    self._allActivityDataArr = joinArrs(
        havePointsLimitedArr,
        timeLimitRunningArr,
        havePointsUnfinishedArr,
        unfinished,
        notYetOpenArr,
        alreadyExpiredArr,
        locked,
        alreadyFinished)
end

-- 检查某个活动是否在时限内
function ActivityPointModel:isInTimeLimit(activity)
    if (not activity) then return false end
    if (activity.limittime ~= 1 or 
        not activity.openArr or 
        #activity.openArr == 0 or 
        not activity.endArr or
        #activity.endArr == 0) 
    then 
        return true, ActivityPointModel.NOT_RUNNING_TYPE.RUNNING
    end
    
    local isInLimit = true
    local notRunningType = ActivityPointModel.NOT_RUNNING_TYPE.RUNNING
    for i,v in ipairs(activity.openArr) do
        local openTime = v
        local closeTime = activity.endArr[i]
        if (openTime and closeTime) then
            local timeNow = GameManager:getNormalServerTime()
            local timeInDay = timeNow % (24 * 3600)
            if (timeInDay > openTime and timeInDay < closeTime) then
                isInLimit = true
                notRunningType = ActivityPointModel.NOT_RUNNING_TYPE.RUNNING
                break -- 找到在时间内就不找下面的了
            elseif (timeInDay < openTime) then
                notRunningType = ActivityPointModel.NOT_RUNNING_TYPE.BEFORE
                isInLimit = false
                break -- 找到打开之前就不找下面的了
            elseif (timeInDay > closeTime) then
                notRunningType = ActivityPointModel.NOT_RUNNING_TYPE.AFTER
                isInLimit = false
            end
        end
    end
    return isInLimit, notRunningType
end

-- 检查是否有限时任务在时间以内
function ActivityPointModel:isAnyLimitTimeActivityRunning()
    for i,v in ipairs(self._allActivityDataArr) do
        if (v.limittime == 1 and self:isInTimeLimit(v) and v.actNum < v.rewardtimes) then
            return true
        end
    end
    return false
end

-- 重置
function ActivityPointModel:clear()
    self._totalActivityPoint = 0
    self._rewardStat = 0
    self._count = 0
    self._stageRewardArrTable = {}
    self._allActivityDataArr = {}
    self._allActivityDataTable = {}
end

return ActivityPointModel