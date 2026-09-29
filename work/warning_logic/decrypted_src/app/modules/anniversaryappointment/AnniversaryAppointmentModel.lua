--[[--
数据模型AnniversaryAppointmentModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/10/17
--desc	: AnniversaryAppointmentModel
------------------------------------------------------------------------------

local AnniversaryAppointmentModel = class("AnniversaryAppointmentModel",mvc.GameModel)

function AnniversaryAppointmentModel:initData()
	self.serverRewardConfig = {}
    self.serverRewardData = {}
end

function AnniversaryAppointmentModel:packServerRewardConfig()
	local taskConfig = clone(ConfigManager:getAllFullServerScheduleData())
    -- local coinID = 23360001
    -- local pk = RoleDataManager:getMaster():getPK()
    -- local coinNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, coinID) or 0
    for k, v in pairs(taskConfig) do
        local rewardIdList = {}
        local rewardNumList = {}
        local awardList = string.split(v.award, ";")
        for k, v in pairs(awardList) do
            local awardData = string.split(v, ",")
            rewardIdList[k] = tonumber(awardData[1])
            rewardNumList[k] = tonumber(awardData[2])
        end
        v.count = self.serverRewardData.totalCount or 0
        v.rewardid = rewardIdList
        v.rewardnum = rewardNumList
    end
    
    self.serverRewardConfig = taskConfig
end

function AnniversaryAppointmentModel:getServerRewardConfig()
	return self.serverRewardConfig
end

-- 获取服务器发送的活动目标信息
function AnniversaryAppointmentModel:initServerRewardTarget(data)
    self.serverRewardData = data
    self:packServerRewardConfig()
end

function AnniversaryAppointmentModel:getServerRewardData()
    return self.serverRewardData
end

function AnniversaryAppointmentModel:checkRewardHasTaken(id)
    local taken = false
    if self.serverRewardData.data.claimedSchedules then
        for k, v in pairs(self.serverRewardData.data.claimedSchedules) do
            if id == v then
                taken = true
                break
            end
        end
    end
    return taken
end

-- 活动是否在开启时间内
function AnniversaryAppointmentModel:getActivityIsShow(nowTime)
    local tradeActivityConfig = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityAppointmentTask)
    local nowTime = nowTime or GameManager:getNormalServerTime()
    if not tradeActivityConfig then
        return false
    end
    -- 永久开启
    if tradeActivityConfig.timeType == -1 then
        return true
    -- 根据配置决定开启和关闭时间
    elseif tradeActivityConfig.timeType == 0 and tradeActivityConfig.preShow == 1 then
        local startTime = GameManager:getUnixTimeByConfigTimeStr(tradeActivityConfig.showStartTime)
        local endTime = GameManager:getUnixTimeByConfigTimeStr(tradeActivityConfig.showEndTime)
        -- 比较时间为标准时间
        if nowTime >= startTime and nowTime <= endTime then
            return true
        else
            return false
        end
    -- 以玩家在服建号时间为准的开启时间
    elseif tradeActivityConfig.timeType == 1 then
        local createTime = RoleDataManager:getMaster():getHeroCreateTime()
        -- 配置表玩家建号时间初始基准为当日服务器0时
        createTime = math.floor(createTime/86400) * 86400
        local startTime = (tonumber(tradeActivityConfig.startTime) -1) * 86400 + createTime
        local endTime = tonumber(tradeActivityConfig.endTime) * 86400 + createTime

        if (nowTime >= startTime or tonumber(tradeActivityConfig.startTime) == 0) 
            and (nowTime <= endTime or tonumber(tradeActivityConfig.endTime) == 0) then
                return true
        else
            return false
        end
    end
end

-- 活动是否预展示
function AnniversaryAppointmentModel:getActivityIsOpening(activityId)
    local tradeActivityConfig = ConfigManager:getTradeActivityDataByID(activityId)
    local startTime = GameManager:getUnixTimeByConfigTimeStr(tradeActivityConfig.startTime)
    local endTime = GameManager:getUnixTimeByConfigTimeStr(tradeActivityConfig.endTime)
    
    local nowTime = nowTime or GameManager:getNormalServerTime()

    -- 比较时间为标准时间
    if nowTime >= startTime and nowTime <= endTime then
        return true
    else
        return false
    end
end

-- 是否预显示红点
function AnniversaryAppointmentModel:isShowRedPoint()
    local hasClicked = cc.UserDefault:getInstance():getBoolForKey("anniversaryAppointment", false)
    if not hasClicked then
        return true
    end
    local isShow = false
    local taskGroupInfo = mvc.tradeActivityModel:getActivityTargetByID(PublicDefine.TradeActivityIDList.TradeActivityAppointmentTask)
    local coinGroupInfo = mvc.tradeActivityModel:getActivityTargetByID(PublicDefine.TradeActivityIDList.TradeActivityAppointmentCoinReward)
    local serverGroupInfo = self:getServerRewardConfig()
    -- local curInfo = groupInfo[self.index]
    for k, v in pairs(taskGroupInfo) do
        if v.stat == 2 then
            isShow = true
            return isShow
        end
    end

    for k, v in pairs(coinGroupInfo) do
        if v.stat == 2 then
            isShow = true
            return isShow
        end
    end

    for k, v in pairs(serverGroupInfo) do
        if v.count >= v.target and not self:checkRewardHasTaken(v.ID) then
            isShow = true
            return isShow
        end
    end

    return isShow
end

return AnniversaryAppointmentModel