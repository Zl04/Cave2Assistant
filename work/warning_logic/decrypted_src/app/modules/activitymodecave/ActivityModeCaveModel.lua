--[[--
数据模型ActivityModeCaveModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/10/28
--desc	: ActivityModeCaveModel
------------------------------------------------------------------------------

local ActivityModeCaveModel = class("ActivityModeCaveModel",mvc.GameModel)

function ActivityModeCaveModel:initData()
    self.activityCaveData = {}
    self.selctedEntryList = {}
    self.selctedEntryStatList = {}
    self.show = false
    self.trialLandSettleData = {}
    self.trialLandCaveData = {}
end

function ActivityModeCaveModel:initModeCaveData(data)
    self.activityCaveData = {}
    local modeCaveData = {}
    for k, v in pairs(data) do
        for _, caveData in pairs(v.modeData) do
            if caveData then
                modeCaveData[caveData.modeId]  = caveData
                self.activityCaveData[v.activityId] = modeCaveData
            end
        end
    end    
end

function ActivityModeCaveModel:getModeCaveData(activityId)
    return self.activityCaveData[activityId] or {}
end

function ActivityModeCaveModel:setSelctedEntryList(entryID)
    self.selctedEntryStatList[entryID] = true
    table.insert(self.selctedEntryList, entryID)
end

function ActivityModeCaveModel:removeEntryFromSelctedEntryList(entryID)
    self.selctedEntryStatList[entryID] = false
    for k, v in pairs(self.selctedEntryList) do
        if v == entryID then
            table.remove(self.selctedEntryList, k)
            break
        end
    end
end

function ActivityModeCaveModel:clearSelctedEntryList()
    self.selctedEntryStatList = {}
    self.selctedEntryList = {}
end

function ActivityModeCaveModel:getSelctedEntryList()
    return self.selctedEntryList
end

function ActivityModeCaveModel:getSelctedEntryStatList()
    return self.selctedEntryStatList
end

-- 活动是否在开启时间内
function ActivityModeCaveModel:getActivityIsOpening(nowTime)
    -- Net.NetPlaySystem:requestDungeonActivityData()
    local SceneManager = require("app.game.SceneManager")
    if not SceneManager:getInstance():isInTown() then
        return false
    end
    local tradeActivityConfig = ConfigManager:getAllActiveDuplicationDataByID(PublicDefine.ActivityModeCaveType.TrialLand)
    local nowTime = nowTime or GameManager:getNormalServerTime()

    local startTime = GameManager:getUnixTimeByConfigTimeStr(tradeActivityConfig.activityStartTime)
    local endTime = GameManager:getUnixTimeByConfigTimeStr(tradeActivityConfig.activityEndTime)
    -- 比较时间为标准时间
    if nowTime >= startTime and nowTime <= endTime then
        Net.NetPlaySystem:requestDungeonActivityData()
        return true
    else
        return false
    end
end

-- 模式是否在开启时间内
function ActivityModeCaveModel:getCaveModeIsOpening(config)
    -- local tradeActivityConfig = ConfigManager:getAllActiveDuplicationDataByID(PublicDefine.ActivityModeCaveType.TrialLand)
    local nowTime = nowTime or GameManager:getNormalServerTime()

    local startTime = GameManager:getUnixTimeByConfigTimeStr(config.startTime)
    local endTime = GameManager:getUnixTimeByConfigTimeStr(config.endTime)
    -- 比较时间为标准时间
    if nowTime >= startTime and nowTime <= endTime then
        return true
    else
        return false
    end
end

-- 是否预显示红点
function ActivityModeCaveModel:isShowRedPoint()
    local isShow = false
    -- local modeID = 1
    local activityCaveData = self:getModeCaveData(PublicDefine.ActivityModeCaveType.TrialLand)
    if not next(activityCaveData) then
        return
    end
    -- local modeCaveData = activityCaveData[modeID]
    for _, v in pairs(activityCaveData) do
        modeCaveData = v
    end
    if modeCaveData.trialLand.dailyRewardFlag == 1 then
        isShow = true
    end

    if mvc.activityModeCaveLeaderboardModel:needShowRedPoint(modeCaveData.modeId) then
        isShow = true
    end

    return isShow
end

function ActivityModeCaveModel:setTrialLandSettleData(data)
    self.trialLandSettleData = data
end

function ActivityModeCaveModel:getTrialLandSettleData()
    return self.trialLandSettleData
end

function ActivityModeCaveModel:clearTrialLandSettleData()
    self.trialLandSettleData = {}
end

function ActivityModeCaveModel:setIsShowTrialLandRewardLayer(show)
    self.show = show
end

function ActivityModeCaveModel:getIsShowTrialLandRewardLayer()
    return self.show
end

function ActivityModeCaveModel:getTrialLandRewardData()
    return {}
end

function ActivityModeCaveModel:setTrialLandCaveData(data)
    self.trialLandCaveData = data
end

function ActivityModeCaveModel:getTrialLandCaveData()
    return self.trialLandCaveData
end


return ActivityModeCaveModel