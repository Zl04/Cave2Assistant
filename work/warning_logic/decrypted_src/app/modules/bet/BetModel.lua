--[[--
数据模型BetModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2023/12/25
--desc	: BetModel
------------------------------------------------------------------------------

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

local scheduler = cc.Director:getInstance():getScheduler()

-- ProfileNavigationRacingEvent 里面的eventObject字段对应
UI.BET_EVENT_TARGET_TYPE = {
    RANDOM = 0,  -- 随机事件触发船只 ——随机事件对象都为0，其他事件对象如下——
    RANDOM_NO_BET = 1,     -- 1 随机任意一只未投注船只作为事件对象
    CHOICE_NO_BET = 2,     -- 2 手动选择一只未投注船只作为事件对象
    RANDOM_BET = 3,     -- 3 随机任意一只投注船只作为事件对象
    CHOICE_BET = 4,        -- 4 手动选择一只投注船只作为事件对象
}

-- 提示类型
UI.BET_BAR_TYPE = {
    BET = 0,            -- 投注
    RALLY_GAME = 1,     -- 拉力赛比赛
}

-- event 效果 ProfileNavigationRacingEvent的字段eventEffectType对应
UI.EventEffectType = {
    reduceSpeed = 1, -- 1 永久速度变化
    speedChange = 2, -- 2 持续速度变化
    stop = 3,        -- 3 原地停止时间
    reverse = 4,     -- 4 反向行驶时间
}

UI.NM_DEFINE = 1852.0

local BetModel = class("BetModel",mvc.GameModel)

function BetModel:initData()
    --[[
    {
        infos = {
            {   
                boatid = 船只ID
                BetBoatInfo 基础信息
                BetBoatSailInfo 航行数据
            }
        }
        betPoolNum 奖池道具数量
    }
    ]]
    -- 当前是否显示
    self.betBarStatus = true
    self.rallyGameBarStatus = true
    -- 当前显示状态
    self.betBarShowStatus = false
    self.rallyGameBarShowStatus = false
    
    self.lastInfos = nil
    self.myLastInfos = nil
    
    self.baseInfo = {}
    self.baseInfo.infos = {}
    self.baseInfo.betPoolNum = 0
    print("BetModel:initData")
    
    self.boatEvents = nil
    self.skillInfos = nil
    self.settleResult = nil
    
    self:initBetRunTime()
    
    if(self.schedulerID == nil) then 
        self.schedulerID = 0
    end
    if(self.schedulerID == 0) then 
        self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), 5, false)
    end
end

function BetModel:update()
    if Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_BET) then
        self:checkNeedTownNotify()
    end    
end

function BetModel:UpdateBetPoolNum(betPoolNum)
    self.baseInfo.betPoolNum = betPoolNum
    self:SorAndSendEvent()
end

function BetModel:UpdateBetBoatInfo(infos)
    if(self.baseInfo ~= nil) then 
        self.baseInfo.infos = self.baseInfo.infos or {}
    end
    
    for i=1, #infos do
        local oneInfo = infos[i]
        local found = false
        
        for j=1, #self.baseInfo.infos do
            local oneBaseInfo = self.baseInfo.infos[j]
            if(oneBaseInfo.boatid == oneInfo.boatid) then 
                oneBaseInfo.BetBoatInfo = oneInfo
                found = true
                break
            end
        end
        
        if(found == false) then 
            table.insert(self.baseInfo.infos, {boatid = oneInfo.boatid, BetBoatInfo = oneInfo})
        end
    end
    self:SorAndSendEvent()
end

--[[
更新投注信息
]]
function BetModel:UpdateBetBoatInfoOne(boatid, betItemNum)
    if(self.baseInfo ~= nil) then 
        self.baseInfo.infos = self.baseInfo.infos or {}
    end
    
    for j=1, #self.baseInfo.infos do
        local oneBaseInfo = self.baseInfo.infos[j]
        if(oneBaseInfo.boatid == boatid) then 
            
            oneBaseInfo.BetBoatInfo.myBet = oneBaseInfo.BetBoatInfo.myBet + betItemNum
            -- print("boatid="..boatid.."   myBet="..oneBaseInfo.BetBoatInfo.myBet.."  ".. betItemNum)
            break
        end
    end
    
    self:SorAndSendEvent()
end

function BetModel:UpdateBetBoatSailInfo(sailInfos)
    if(self.baseInfo ~= nil) then 
        self.baseInfo.infos = self.baseInfo.infos or {}
    end
    
    for i=1, #sailInfos do
        local sailInfo = sailInfos[i]
        local found = false
        for j=1, #self.baseInfo.infos do
            local oneBaseInfo = self.baseInfo.infos[j]
            if(oneBaseInfo.boatid == sailInfo.boatid) then 
                oneBaseInfo.BetBoatSailInfo = sailInfo
                oneBaseInfo.BetBoatSailInfo.simstarttime = AvalonUtil:getCurrentTime()
                found = true
                break
            end
        end
        
        if(found == false) then 
            local data = {boatid = sailInfo.boatid, BetBoatSailInfo = sailInfo}
            data.BetBoatSailInfo.simstarttime = AvalonUtil:getCurrentTime()
            table.insert(self.baseInfo.infos, data)
        end
    end
    
    self:SorAndSendEvent()
end

function BetModel:SorAndSendEvent()
    -- 排序
    if(#self.baseInfo.infos > 0) then 
        if(self.baseInfo.infos[1].BetBoatSailInfo ~= nil) then 
            table.sort(self.baseInfo.infos, function(a, b)
                if(a.BetBoatSailInfo == nil or b.BetBoatSailInfo == nil) then 
                    return true
                end
                
                if(a.BetBoatSailInfo.finishSailMs > 0) then 
                    if(a.BetBoatSailInfo.finishSailMs == b.BetBoatSailInfo.finishSailMs) then 
                        if(a.BetBoatSailInfo.speed == b.BetBoatSailInfo.speed) then 
                            return a.BetBoatSailInfo.boatid < b.BetBoatSailInfo.boatid
                        else
                            return a.BetBoatSailInfo.speed > b.BetBoatSailInfo.speed
                        end
                    else
                        return a.BetBoatSailInfo.finishSailMs < b.BetBoatSailInfo.finishSailMs
                    end
                else
                    if(a.BetBoatSailInfo.travelNum == b.BetBoatSailInfo.travelNum) then 
                        if(a.BetBoatSailInfo.speed == b.BetBoatSailInfo.speed) then 
                            return a.BetBoatSailInfo.boatid < b.BetBoatSailInfo.boatid
                        else
                            return a.BetBoatSailInfo.speed > b.BetBoatSailInfo.speed
                        end
                    else
                        return a.BetBoatSailInfo.travelNum > b.BetBoatSailInfo.travelNum
                    end
                end
            end)
        end
    end
    
    for i=1, #self.baseInfo.infos do
        self.baseInfo.infos[i].rank = i
    end
    
    mvc.send("BetBaseInfo_Refresh")
end

-- 更新往期信息数据
function BetModel:UpdateLastInfo(data)
    self.lastInfos = data
    self.lastInfos = self.lastInfos or {}
    table.sort( self.lastInfos, function(a, b) return a.gametime > b.gametime end )
end

-- 获取往期信息数据
function BetModel:GetLastInfo()
    return self.lastInfos or {}
end

-- 更新玩家往期信息数据
function BetModel:UpdateMyLastInfo(data)
    self.myLastInfos = data
    self.myLastInfos = self.myLastInfos or {}
    table.sort(self.myLastInfos, function(a, b) return a.gametime > b.gametime end )
end

-- 获取玩家往期信息数据
function BetModel:GetMyLastInfo()
    return self.myLastInfos or {}
end

-- 更新使用技能返回信息
function BetModel:UpdateUseSkillResp(data)
    self:UpdateSkillInfoForOne(data.info)
    
    local boatid = data.boatid
    local eventData = self:getEventDataForSkillID(data.info.skillid)
    
    mvc.send(mvc.events.Bet_ShowUseEffect, boatid, eventData)
end

-- 更新使用道具返回信息
function BetModel:UpdateUseItemResp(data)
    local boatid = data.boatid
    local itemID = data.itemid
    local eventData = self:getEventDataForItemID(itemID)
    
    mvc.send(mvc.events.Bet_ShowUseEffect, boatid, eventData)
end

-- 更新结算信息
function BetModel:UpdateSettlegResult(data)
    self.settleResult = data
    
    -- 清空配置信息
    for j=1, #self.baseInfo.infos do
        local oneBaseInfo = self.baseInfo.infos[j]
        oneBaseInfo.BetBoatSailInfo = nil
    end
    
    mvc.send(mvc.events.Bet_SettleResult)
end

-- 获取结算信息
function BetModel:getSettleResult()
    return self.settleResult
end

function BetModel:UpdateSkillInfoForOne(data)
    local found = false
    local baseData = mvc.bigSailPortModel:getBaseData()
    if(baseData.betSkillinfo == nil) then 
        baseData.betSkillinfo = {}
    end
    
    for i=1, #baseData.betSkillinfo do
        local oneInfo = baseData.betSkillinfo[i]
        if(oneInfo ~= nil and oneInfo.skillid == data.skillid) then
            oneInfo.skillid = data.skillid
            oneInfo.lastUseTime = data.lastUseTime
            found = true
            break
        end
    end
    
    if(found == false) then 
        table.insert(baseData.betSkillinfo, {skillid = data.skillid, lastUseTime = data.lastUseTime})
    end
    
    mvc.send("Bet_SkillUpdate")
end

-- 更新游戏技能信息
function BetModel:UpdateSkillInfo(data)
    local baseData = mvc.bigSailPortModel:getBaseData()
    if(baseData ~= nil) then 
        baseData.betSkillinfo = data
    end
    
    mvc.send("Bet_SkillUpdate")
end

-- 获取制定技能ID的进度信息
function BetModel:getSkillInfo(skillID)
    
    local baseData = mvc.bigSailPortModel:getBaseData()
    if(baseData ~= nil and baseData.betSkillinfo == nil) then 
        baseData.betSkillinfo = {}
    end
    
    for i=1, #baseData.betSkillinfo do
        local oneInfo = baseData.betSkillinfo[i]
        if(oneInfo ~= nil and oneInfo.skillid == skillID) then
            return oneInfo
        end
    end
    
    return nil
end

-- 更新船只事件
function BetModel:UpdateBoatEvents(events)
    self.boatEvents = events
    
    local changeTimeStatus = false
    for i=1, #self.boatEvents do
        local oneEvent = self.boatEvents[i]
        if(oneEvent.eventid ~= nil or oneEvent.eventid > 0) then 
            local betInfo = self:getBetInfo(oneEvent.boatid)
            if(betInfo ~= nil and betInfo.BetBoatSailInfo ~= nil and #betInfo.BetBoatSailInfo.eventinfos ~= 0) then 
                local update = false
                for j=1, #betInfo.BetBoatSailInfo.eventinfos do
                    local oneEventInfo = betInfo.BetBoatSailInfo.eventinfos[j]
                    if(oneEventInfo.eventid == oneEvent.eventid) then 
                        -- print("wwwwwwwwww oneEventInfo.expireTTL pre=" .. oneEventInfo.expireTTL .. "  oneEvent.expireTTL=" .. oneEvent.expireTTL)
                        oneEventInfo.expireTTL = oneEvent.expireTTL
                        changeTimeStatus = true
                        update = true
                        break
                    end
                end
                if(update == false) then 
                    -- 把时间添加到航行数据中
                    changeTimeStatus = true
                    table.insert(betInfo.BetBoatSailInfo.eventinfos, {eventid = oneEvent.eventid, expireTTL = oneEvent.expireTTL})
                end
            end
        end
    end
    if(changeTimeStatus) then 
        mvc.send("BetBaseInfo_Refresh")
    end
    
    mvc.send("BetBoatInfo_EventUpdate", self.boatEvents)
end

-- 获取本次投注总竞猜币
function BetModel:getTotalBetNum()
    if(self.baseInfo ~= nil) then 
        local totalNum = 0
        for i=1, #self.baseInfo.infos do
            local oneInfo = self.baseInfo.infos[i]
            if(oneInfo.BetBoatInfo ~= nil) then
                totalNum = totalNum + oneInfo.BetBoatInfo.totalBetItemNum
            end
        end
        
        return totalNum + self.baseInfo.betPoolNum
    end
    
    return 0
end

-- 清理旧数据(在切换活动次数的变化)
function BetModel:clearOldData()
    -- self.baseInfo = {}
    -- self.baseInfo.infos = {}
    -- self.baseInfo.betPoolNum = 0
    
    self.boatEvents = nil
    self.skillInfos = nil
    
    Net.NetBigSailSystem:reqBetLastResult()
    Net.NetBigSailSystem:reqMyLastbet()
end

function BetModel:getBetInfoList()
    if(self.baseInfo == nil) then 
        return nil
    end
    return self.baseInfo.infos
end

--[[
获取当前投注的船只信息
]]
function BetModel:getBetBoatInfo()
    if(self.baseInfo == nil) then 
        return nil
    end
    for i=1, #self.baseInfo.infos do
        local oneInfo = self.baseInfo.infos[i]
        if(oneInfo ~= nil and oneInfo.BetBoatInfo.myBet > 0) then
            return oneInfo
        end
    end
    
    return nil
end

--[[
获取当前投注的船只信息
]]
function BetModel:getBetInfo(boatID)
    if(self.baseInfo ~= nil) then 
        for i=1, #self.baseInfo.infos do
            local oneInfo = self.baseInfo.infos[i]
            if(oneInfo ~= nil and oneInfo.boatid == boatID) then
                return oneInfo
            end
        end
    end
    
    return nil
end

--[[
获取当前投注的船ID
]]
function BetModel:getBetBoatID()
    if(self.baseInfo ~= nil) then 
        for i=1, #self.baseInfo.infos do
            local oneInfo = self.baseInfo.infos[i]
            if(oneInfo ~= nil and oneInfo.BetBoatInfo ~= nil and oneInfo.BetBoatInfo.myBet > 0) then
                return oneInfo.boatid
            end
        end
    end
    
    return -1
end

-- 获取已经使用的技能点
function BetModel:getUseSkillPointNum()
    local baseData = mvc.bigSailPortModel:getBaseData()
    if(baseData ~= nil) then
        return baseData.betUseSkillPoint
    end
    
    return 0
end

--[[
判断当前是否可以领取奖励
]]
function BetModel:checkRewardBet()
    if(self:getInBetTime() > 0) then 
        local baseData = mvc.bigSailPortModel:getBaseData()
        if(baseData ~= nil) then 
            local rewardBetID = self:getCurBetID()
            print("BetModel:checkRewardBet", rewardBetID, baseData.dailyRewardBetId)
            for i=1, #baseData.dailyRewardBetId do
                local oneRewardBetID = baseData.dailyRewardBetId[i]
                if(oneRewardBetID == rewardBetID) then 
                    return false
                end
            end
        end
        
        return true
    end
    
    return false
end

-- 获取竞猜币的数量
function BetModel:getBetItemNum()
    local baseData = mvc.bigSailPortModel:getBaseData()
    if(baseData ~= nil) then
        return baseData.betItemNum
    end
    
    return 0
end

-- 设置bar的状态, false 为主动关闭了，就不在显示
function BetModel:getBetBarStatus(betBarType)
    if(betBarType == UI.BET_BAR_TYPE.BET) then 
        return self.betBarStatus
    end
    
    if betBarType == UI.BET_BAR_TYPE.RALLY_GAME then
        return self.rallyGameBarStatus
    end
    
    return true
end

-- 设置bar的状态, false 为主动关闭了，就不在显示
function BetModel:setBetBarStatus(betBarType, showFlag)
    -- print("BetModel:setBetBarStatus", betBarType, showFlag)
    if(betBarType == UI.BET_BAR_TYPE.BET) then 
        self.betBarStatus = showFlag
    end
    
    if betBarType == UI.BET_BAR_TYPE.RALLY_GAME then
        self.rallyGameBarStatus = showFlag
    end
    --print("BetModel:setBetBarStatus", self.betBarStatus, self.rallyGameBarStatus, betBarType, showFlag)
end

-- 设置bar的状态, false 当前没有显示，true 当前正在显示
function BetModel:setBetBarShowStatus(betBarType, showFlag)
    -- print("BetModel:setBetBarShowStatus", betBarType, showFlag)
    -- 这里不在根据外界来做相关显示，完全由显示逻辑来做相关的控制
    -- if(betBarType == UI.BET_BAR_TYPE.BET) then 
    --     self.betBarShowStatus = showFlag
    -- end
    
    -- if betBarType == UI.BET_BAR_TYPE.RALLY_GAME then
    --     self.rallyGameBarShowStatus = showFlag
    -- end
end

function BetModel:checkNeedTownNotify()
    -- print("getInBetTime=" .. self:getInBetTime() .. "  getInGameTime=" .. self:getInGameTime() .. "  betBarStatus=" .. tostring(self.betBarStatus) .. "  rallyGameBarStatus=" .. tostring(self.rallyGameBarStatus) .. "  betBarShowStatus=" .. tostring(self.betBarShowStatus) .. "  rallyGameBarShowStatus=" .. tostring(self.rallyGameBarShowStatus) .. "")
    if (self:getInBetTime() >0) then
        if(self.betBarStatus == true) then 
            if(self.betBarShowStatus == false) then 
                Avalon.MessageCenter:notice(GameMessage.MC_UI_BET_SHOW_OR_CLOSE, UI.BET_BAR_TYPE.BET, true)
                self.betBarShowStatus = true
            end
        else
            if(self.rallyGameBarShowStatus == true or self.betBarShowStatus == true) then 
                Avalon.MessageCenter:notice(GameMessage.MC_UI_BET_SHOW_OR_CLOSE, UI.BET_BAR_TYPE.BET, false)
            end
        end
    elseif (self:getInGameTime() > 0) then
        if(self.rallyGameBarStatus == true ) then 
            if(self.rallyGameBarShowStatus == false) then 
                Net.NetBigSailSystem:reqBetBaseInfo(0)
                Avalon.MessageCenter:notice(GameMessage.MC_UI_BET_SHOW_OR_CLOSE, UI.BET_BAR_TYPE.RALLY_GAME, true)
                self.rallyGameBarShowStatus = true
            end
        else
            if(self.rallyGameBarShowStatus == true or self.betBarShowStatus == true) then 
                Avalon.MessageCenter:notice(GameMessage.MC_UI_BET_SHOW_OR_CLOSE, UI.BET_BAR_TYPE.RALLY_GAME, false)
            end
        end
    else
        if(self.rallyGameBarShowStatus == true or self.betBarShowStatus == true) then 
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BET_SHOW_OR_CLOSE, UI.BET_BAR_TYPE.RALLY_GAME, false)
        end
        self.betBarStatus = true
        self.rallyGameBarStatus = true

        self.betBarShowStatus = false
        self.rallyGameBarShowStatus = false
    end
end

-- 获取奖池数量
function BetModel:getBetPoolNum()
    if(self.baseInfo ~= nil) then
        local betPoolTotal = self.baseInfo.betPoolNum
        
        for i=1, #self.baseInfo.infos do
            local oneInfo = self.baseInfo.infos[i]
            if(oneInfo.BetBoatInfo ~= nil) then
                betPoolTotal = betPoolTotal + oneInfo.BetBoatInfo.totalBetItemNum
            end
        end
        
        return betPoolTotal
    end
    
    return 0
end

--[[
获取当前能够投注的ID
0 标识不在投注时间
【1-n]投注的ID
]]
function BetModel:getCurBetID()
    if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Bet) then
        return 0
    end
    
    local daySeceonds = (GameManager:getNowServerTime()) %(3600*24)
    
    for i= 1, #self._betRunTime do
        local oneRunTime = self._betRunTime[i]
        if(daySeceonds >= oneRunTime[1] and daySeceonds <= oneRunTime[2]) then
            return i
        end
    end
    
    return 0
end

--[[
获取到投注结束时间
-1 标识不在投注期间或无法进行投注
【0-n】距离投注的结束时间
]]
function BetModel:getInBetTime()
    if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Bet) then
        return -1
    end
    
    local daySeceonds = (GameManager:getNowServerTime()) %(3600*24)
    for i= 1, #self._betRunTime do
        local oneRunTime = self._betRunTime[i]
        if(daySeceonds >= oneRunTime[1] and daySeceonds <= oneRunTime[2]) then
            return oneRunTime[2] - daySeceonds
        end
    end
    
    return -1
end

--[[
获取到比赛结束的时间
-1 标识不在比赛期间或无法进行比赛
【0-n】距离比赛的结束时间
]]
function BetModel:getInGameTime()
    if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Bet) then
        return -1
    end
    -- print("BetModel:getInGameTime", GameManager:get_timezone_offset())
    local daySeceonds = (GameManager:getNowServerTime()) %(3600*24)
    
    for i= 1, #self._betRunTime do
        local oneRunTime = self._betRunTime[i]
        if(daySeceonds >= oneRunTime[2] and daySeceonds <= oneRunTime[3]) then
            -- 这里为了解决在刚进入比赛的时候，还没有比赛数据的时候提示异常问题
            if(daySeceonds - oneRunTime[2] > 30) then 
                if self:getRallyGameFinish() then 
                    return -1
                end
            end
            
            return oneRunTime[3] - daySeceonds
        end
    end
    
    return -1
end

--[[
获取到休赛结束的时间
-1 标识当前不在修赛期间
【0-n】距离休赛的结束时间
]]
function BetModel:getInGameRestTime()
    if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Bet) then
        return -1
    end
    
    local daySeceonds = (GameManager:getNowServerTime()) %(3600*24)
    
    local preTimeArr = nil
    local totalTime = 0
    for i= 1, #self._betRunTime do
        local oneRunTime = self._betRunTime[i]
        if(preTimeArr ~= nil) then 
            if(daySeceonds >= preTimeArr[3] and daySeceonds <= oneRunTime[1]) then
                return oneRunTime[1] - daySeceonds
            end
            
            preTimeArr = oneRunTime
        else
            preTimeArr = oneRunTime
            if(daySeceonds < oneRunTime[1]) then
                totalTime = oneRunTime[1] - daySeceonds
                break
            end
        end
    end
    
    if(preTimeArr ~= nil and preTimeArr[3] == self._betRunTime[#self._betRunTime][3]) then 
        local oneRunTime = self._betRunTime[1]
        
        totalTime = oneRunTime[1] + 24*3600 - daySeceonds
    end
    
    if(totalTime > 0) then 
        return totalTime
    else
        return -1
    end
end

-- 获取比赛是否已经结束
function BetModel:getRallyGameFinish()
    if(self.baseInfo ~= nil) then 
        for i=1, #self.baseInfo.infos do
            local oneInfo = self.baseInfo.infos[i]
            if(oneInfo.BetBoatSailInfo == nil) then
                return true
            end
        end
    end
    
    return false
end

--[[
获取到比赛时间串
eg:12:25-15:34
]]
function BetModel:getGameTimeStr()
    if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_BigSail) then
        return "00:00-00:00"
    end
    
    local daySeceonds = (GameManager:getNowServerTime()) %(3600*24)
    
    local timeStamp2 = os.date("!*t", os.time())

    for i= 1, #self._betRunTime do
        local oneRunTime = self._betRunTime[i]
        if(daySeceonds >= oneRunTime[1] and daySeceonds <= oneRunTime[3]) then
            local startTime = oneRunTime[2]
            local endTime = oneRunTime[3]

            local startS = string.format("%s,%d,%d,%d", timeStamp2.year..","..timeStamp2.month..","..timeStamp2.day, startTime/3600, startTime%3600/60, 0)
            local endS = string.format("%s,%d,%d,%d", timeStamp2.year..","..timeStamp2.month..","..timeStamp2.day, endTime/3600, endTime%3600/60, 0)
            --print("startS="..startS.."  endS="..endS)
            local startStr = GameManager:getClientDateByConfigTimeStr(startS, "%H:%M")
            local endStr = GameManager:getClientDateByConfigTimeStr(endS, "%H:%M")

            -- print("startStr="..startStr.."  endStr="..endStr)
            -- local startStr = GameManager:getNowServerDate("%H:%M", startTime) -- tostring(startTime / 3600)..":"..tostring((startTime % 3600)/60)
            -- local endStr = GameManager:getNowServerDate("%H:%M", endTime)   --tostring(endTime / 3600)..":"..tostring((endTime % 3600)/60)
            
            return  startStr.."-"..endStr
        end
    end
    
    return "00:00-00:00"
end


function BetModel:initBetRunTime()
    local config = ConfigManager:getNavigationGeneralConfigByID(1)
    -- print("BetModel:initBetRunTime " .. config.sailingRallyTime .. "")
    local timeArr = string.split(config.sailingRallyTime,";")
    
    self._betRunTime = {}
    for i = 1, #timeArr do
        local oneConfig = timeArr[i]
        
        local arr = string.split(oneConfig,",")
        -- print("BetModel:oneConfig " .. #arr .. "  ".. i.." oneConfig="..oneConfig)
        if(#arr == 3) then
            local oneRunTime = {}
            for j = 1, #arr do
                local time = arr[j]
                local minutes = time % 100
                local hours = math.floor(time/100)
                
                local oneTime = hours * 3600 + minutes * 60
                
                oneRunTime[j] = oneTime
            end
            
            self._betRunTime[i] = oneRunTime
        end
    end
    
end

function BetModel:getPeiLvStr(totalBetItemNum, isHistory)
    local totalNum = self:getTotalBetNum()
    local odds = 1
    odds = math.min(totalNum*1.0/totalBetItemNum, 5)
    
    if(totalNum > 2000 or isHistory == true) then 
        return string.format(UI.TEXT_227605, string.format( "%.2f", odds))
    else
        return string.format(UI.TEXT_227605, "?")
    end
end

function BetModel:getHistoryDate(gameTime)
    --print("date="..gameTime)
    return GameManager:getNowServerDate("%Y.%m.%d %H:%M", gameTime + GameManager:getEPOCHTime())
end

function BetModel:getBoatName(boatID)
    local boatConfig = ConfigManager:getNavigationRacingBoatsDatayID(boatID)
    
    return LanguageManager:getInstance():getLocalString(boatConfig.name)
end

function BetModel:getBoatIcon(boatID)
    local boatConfig = ConfigManager:getNavigationRacingBoatsDatayID(boatID)
    
    return boatConfig.boatIcon
end

function BetModel:getBoatPictureSmall(boatID)
    local boatConfig = ConfigManager:getNavigationRacingBoatsDatayID(boatID)
    
    return boatConfig.boatPictureSmall
end

function BetModel:getBoatPictureBig(boatID)
    local boatConfig = ConfigManager:getNavigationRacingBoatsDatayID(boatID)
    
    return boatConfig.boatPictureBig
end

function BetModel:getBoatDescription(boatID)
    local boatConfig = ConfigManager:getNavigationRacingBoatsDatayID(boatID)
    
    return LanguageManager:getInstance():getLocalString(boatConfig.des)
end

-- 获取船只的速度的字符串
function BetModel:getBoatSpeedStr(boatInfo)
    -- if(boatInfo.BetBoatSailInfo == nil) then 
    --     return ""
    -- end

    local config = ConfigManager:getNavigationRacingBoatsDatayID(boatInfo.boatid)
    local speed = config.initialSpeed
    
    local pilvStr = ""
    local color = UI.FONT_COLOR_GREEN

    if(boatInfo.BetBoatSailInfo ~= nil and boatInfo.BetBoatSailInfo.finishSailMs <=0) then 
        speed = boatInfo.BetBoatSailInfo.speed or 0
        local stop = false
        local reverse = false
        for i=1, #boatInfo.BetBoatSailInfo.eventinfos do
            local oneEventInfo = boatInfo.BetBoatSailInfo.eventinfos[i]
            if(oneEventInfo ~= nil and oneEventInfo.eventid ~= nil and oneEventInfo.eventid > 0) then 
                local eventData = ConfigManager:getNavigationRacingEventDataByID(oneEventInfo.eventid)
                if(eventData ~= nil and eventData.eventEffectType == UI.EventEffectType.stop) then 
                    stop = true
                elseif(eventData ~= nil and eventData.eventEffectType == UI.EventEffectType.reverse) then 
                    reverse = true
                end
            end
        end
        if(stop) then 
            pilvStr = string.format("(%s)", UI.TEXT_227645)
            color = UI.FONT_COLOR_RED
        elseif reverse then 
            pilvStr = string.format("(%s)", UI.TEXT_227646)
            color = UI.FONT_COLOR_RED
        end
    end
    if(pilvStr == "") then 
        if(speed <= config.initialSpeed) then 
            color = UI.FONT_COLOR_RED
            pilvStr = string.format("(%.1f%%)", ((speed - config.initialSpeed)*100.0/(config.initialSpeed)))
        else
            pilvStr = string.format("(+%.1f%%)", ((speed - config.initialSpeed)*100.0/(config.initialSpeed)))
        end
    end
    
    local chaStr = AvalonUtil:serializeText(pilvStr, AvalonUtil:colorRGB2Str(color))
    
    local speedStr = AvalonUtil:serializeText(string.format(UI.TEXT_227635, string.format("%d", speed*60*1000/UI.NM_DEFINE), AvalonUtil:colorRGB2Str({r = 217, g = 217, b = 217})))
    -- print("speedStr=" .. speedStr..chaStr)
    if(speed == config.initialSpeed) then
        return speedStr
    end
    return speedStr..chaStr
end

-- 获取船只的位置的字符串
function BetModel:getBoatPathStr(boatInfo)
    -- if(boatInfo.BetBoatSailInfo == nil) then 
    --     return ""
    -- end
    local travelNum = 0
    if(boatInfo.BetBoatSailInfo ~= nil) then 
        travelNum = boatInfo.BetBoatSailInfo.travelNum or 0
    end
    
    local travelStr = string.format(UI.TEXT_227636, string.format("%.1f", travelNum/UI.NM_DEFINE))
    
    return travelStr
end

--[[
获取拉力赛的总里程
]]
function BetModel:getRallyTotalMileage()
    return ConfigManager:getNavigationGeneralConfigByID(1).totalMileage
end

--[[
根据道具ID获取事件数据
]]
function BetModel:getEventDataForItemID(itemID)
    local itemStr = ConfigManager:getNavigationGeneralConfigByID(1).racingItemId
    local btnInitDatasList = {}
    
    local btnIndex = 1
    -- 添加技能按钮
    btnIndex = 1
    local itemStrList = string.split(itemStr, ";")
    for k, v in pairs(itemStrList) do
        local itemStrList2 = string.split(v, ",")
        local ID = tonumber(itemStrList2[1])
        local eventID = tonumber(itemStrList2[2])
        if(ID == itemID) then 
            return ConfigManager:getNavigationRacingEventDataByID(eventID)
        end
    end
    
    return nil
end

--[[
获取技能ID获取事件数据
]]
function BetModel:getEventDataForSkillID(skillID)
    local skillStr = ConfigManager:getNavigationGeneralConfigByID(1).racingSkillId
    
    -- 添加技能按钮
    btnIndex = 1
    local skillStrList = string.split(skillStr, ";")
    for k, v in pairs(skillStrList) do
        local skillStrList2 = string.split(v, ",")
        local id = tonumber(skillStrList2[1])
        local eventID = tonumber(skillStrList2[2])
        if(id == skillID) then
            return ConfigManager:getNavigationRacingEventDataByID(eventID)
        end
    end
    
    return nil
end

-- 获取指定事件ID的效果时间
function BetModel:getEventEffectTimeForEventID(eventID)
    local eventData = ConfigManager:getNavigationRacingEventDataByID(eventID)
    if(eventData ~= nil) then 
        return eventData.eventEffectPara2
    end
    
    return 0
end

-- 获取投注的单位
function BetModel:getBetUnitNum()
    return ConfigManager:getNavigationGeneralConfigByID(1).betItem
end

-- 获取当前能够投注的数量
function BetModel:getCurBetNum()
    local curBoatID = self:getBetBoatID()
    local useBetNum = 0
    if(curBoatID ~= nil) then 
        local boatInfo = self:getBetInfo(curBoatID)
        if(boatInfo ~= nil) then 
            useBetNum = boatInfo.BetBoatInfo.myBet
        end
    end
    
    return self:getBetMaxNum() - useBetNum
end

-- 获取投注的最大值
function BetModel:getBetMaxNum()
    return ConfigManager:getNavigationGeneralConfigByID(1).bettingLimit
end

-- 获取可以使用道具的ID
function BetModel:getUseItemIDArr()
    local betBoatInfo = self:getBetBoatInfo()
    if(betBoatInfo == nil or betBoatInfo.BetBoatSailInfo == nil or #betBoatInfo.BetBoatSailInfo.eventinfos == 0) then 
        return {}
    end
    
    local totalEvents = betBoatInfo.BetBoatSailInfo.eventinfos
    
    local useItemArr = {}
    
    local itemStr = ConfigManager:getNavigationGeneralConfigByID(1).racingItemId
    local itemStrList = string.split(itemStr, ";")
    for k, v in pairs(itemStrList) do
        local itemStrList2 = string.split(v, ",")
        local ID = tonumber(itemStrList2[1])
        local eventID = tonumber(itemStrList2[2])
        
        local eventData = ConfigManager:getNavigationRacingEventDataByID(eventID)
        if(eventData.eventRestraintObject > 0) then 
            for i=1, #totalEvents do
                if(totalEvents[i].eventid == eventData.eventRestraintObject) then 
                    table.insert(useItemArr, ID)
                    break
                end
            end
        end
    end
    
    return useItemArr
end

--[[
获取每次使用技能花费的技能点
]]
function BetModel:getRallySkillPointNumForUseSkill()
    return 1
end

--[[
获取拉力赛每场技能点
]]
function BetModel:getRallyInitializeSkillPointNum()
    return ConfigManager:getNavigationGeneralConfigByID(1).skillPoints
end

-- --[[
-- 获取拉力赛使用技能的总的次数
-- ]]
-- function BetModel:getRallyTotalUseSkillNum()
--     return self:getRallyInitializeSkillPointNum() + #ConfigManager:getNavigationGeneralConfigByID(1).goldNum
-- end

-- 获取道具的价格
function BetModel:getRallyItemBuyPrice()
    return ConfigManager:getNavigationGeneralConfigByID(1).buyPrice
end

-- 获取使用技能的价格
function BetModel:getRallySkillBuyPrice()
    local usePointNum = mvc.betModel:getUseSkillPointNum()
    if(usePointNum < self:getRallyInitializeSkillPointNum()) then 
        return 0
    end
    
    return ConfigManager:getNavigationGeneralConfigByID(1).goldNum
end



return BetModel