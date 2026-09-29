--[[--
数据模型MonthlySignModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/06/17
--desc	: MonthlySignModel
------------------------------------------------------------------------------

local MonthlySignModel = class("MonthlySignModel",mvc.GameModel)

function MonthlySignModel:initData()
	self.monthlySignData = nil
    -- self.gameMonth = nil
    self.signCliamReward = nil
    self.cumulativeReward = nil
    self.signDays = {}
    self.monthlySignConfig = {}
    self.useDiamondMaxCount = nil
end

function MonthlySignModel:setMonthlySignData(data)
	self.monthlySignData = data
    self:setSignDays(data.signInDays)
    self:setMonthlyConfig()
end

function MonthlySignModel:setMonthlyConfig()
	local flag, _ = self:getFlagByGameMonth()
    self.monthlySignConfig = ConfigManager:getAllMonthlySignDataByID(flag)
    self.useDiamondMaxCount = tonumber(ConfigManager:getGeneralForKey("refillTime"))
end

function MonthlySignModel:getMonthlyConfig()
	return self.monthlySignConfig
end

function MonthlySignModel:getUseDiamondMaxCount()
	return self.useDiamondMaxCount
end

function MonthlySignModel:getUseDiamondCount()
	return self.monthlySignData.useDiamondCount
end

function MonthlySignModel:getGameMonth()
	return self.monthlySignData.gameMonth
end

function MonthlySignModel:setSignDays(data)
    self.signDays = {}
    if #data > 0 then
        for k, v in pairs(data) do
            self.signDays[v] = true
        end
    end
end

function MonthlySignModel:getSignDays()
    return self.signDays
end

function MonthlySignModel:getCumulativeData()
	return self.monthlySignData.cumulativeRewards or {}
end

function MonthlySignModel:getSignInDay()
	return self.monthlySignData.signInDay or {}
end

function MonthlySignModel:getNowServerDay()
	local timestamp  = GameManager:getNormalServerTime()
    return GameManager:getNowCurDayByTimestamp(timestamp)
end

function MonthlySignModel:getLastSignInDay()
	return self.monthlySignData.lastSignInTime and math.floor(self.monthlySignData.lastSignInTime / 86400) or 0
end

function MonthlySignModel:getFlagByGameMonth()
    -- local curGameMonth = self.gameMonth == gameMonth and self.gameMonth or gameMonth
    if not self.monthlySignData then
        printError("gameMonth has not synced")
    end
    local gameMonth = self.monthlySignData.gameMonth
	local year = math.floor(PublicDefine.CONST_DEFINITION.GAME_EPOCH_YEAR + gameMonth / 12)
    local month = math.floor(gameMonth % 12 + 1)
    return math.floor(year*100+month), month
end

function MonthlySignModel:getCurDate()
    local nowDay = GameManager:getNowServerDate("%m.%d", GameManager:getNowServerTime())
    local nowDayList = string.split(nowDay, ".")
    return nowDayList[1], tonumber(nowDayList[2])
end

function MonthlySignModel:setSignRewardData(data)
    self.signCliamReward = data
end

function MonthlySignModel:getSignRewardData()
    return self.signCliamReward
end

function MonthlySignModel:setcumulativeRewardData(data)
    self.cumulativeReward = data
end

function MonthlySignModel:getcumulativeRewardData()
    return self.cumulativeReward
end

function MonthlySignModel:isShowMonthlySignBtn()
    local show = false
    if self.monthlySignConfig then
        show = true
    end
    return show
end

function MonthlySignModel:isShowMonthlySignRedPoint()
    local show = false
    local dailyRewardList = string.split(self.monthlySignConfig.consecutiveSignRewards, ";")
    local _, day = self:getCurDate()
    if not self.signDays[day] and day <= #dailyRewardList then
        show = true 
    end

    local cumulativeConfigList = string.split(self.monthlySignConfig.accumulativeSignRewards, ";")
    local dayList = {}
    for k, v in pairs(cumulativeConfigList) do
        local day = string.split(v, ",")
        table.insert(dayList, tonumber(day[1]))
    end

    for k, v in pairs(dayList) do
        if table.nums(self.signDays) >= v then
            if not self:checkCumulativeRewardsHasTaken(v) then
                show = true 
            end
        end
    end
    return show
end

function MonthlySignModel:checkCumulativeRewardsHasTaken(day)
    local take = false
    if #self.monthlySignData.cumulativeRewards == 0 then
        return take
    end
    for k, v in pairs(self.monthlySignData.cumulativeRewards) do
        if tonumber(v) == day then
            take = true
        end
    end
    return take
end

function MonthlySignModel:checkCanSignIn(index)
    local can = false
    local _, day = self:getCurDate()
    if index < day and not self.signDays[index] then
        can = true
    end
    return can
end

return MonthlySignModel