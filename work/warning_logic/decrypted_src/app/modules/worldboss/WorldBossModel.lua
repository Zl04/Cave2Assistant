--[[--
数据模型WorldBossModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/05/16
--desc	: WorldBossModel
------------------------------------------------------------------------------

local WorldBossModel = class("WorldBossModel",mvc.GameModel)
local GameDataManager = require("app.game.GameDataManager")
local GameMapManager = require("app.game.GameMapManager")
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require "app.game.LanguageManager"

function WorldBossModel:initData()
    self.cfgData = nil
    self.townNotify = false  -- 城镇是否需要显示topbar
    self.switchRoomCD = tonumber(Config.General:getValueForKey("WorldBossSwitchCD"))
    self.timeList = {}
    self.curReviveTime = 0
    self.buyBuffNum = 0
    self.wordbossCfgID = 1
	
    self.stateData = {}
    self.roomData = {}
    self.myHurtRankInfo = nil
    self.startTime = 0
    self.initFightStageStateInfo = nil
    local timeStr = Config.General:getValueForKey("WorldBossPhase")
    local times = string.split(timeStr, ";")
    for k, v in ipairs(times) do
        local oneTime = {}
        local list = string.split(v, ",")
        for m, n in ipairs(list) do
            local timeObj = {}
            timeObj.hour = tonumber(string.sub(n, 1, 2))
            timeObj.min = tonumber(string.sub(n, 3, 4))
            
            table.insert(oneTime, timeObj)
        end

        table.insert(self.timeList, oneTime)
    end
end


function WorldBossModel:initBossDataFromNet(data)
    self:set("buyBuffNum",data.buyBuffNum)
    self:set("curReviveTime",data.reviveNum)
    self:set("wordbossCfgID",data.wordbossCfgID)
end


function WorldBossModel:getCfgData()
    local cfgData = NewConfig.WorldBoss:getAllDatas()
    if not cfgData then
        print("WorldBoss config nil, ERROR!")
        return
    end

    table.sort(cfgData, function(a, b) return a.mapConfig < b.mapConfig end)

    local cfgIndex = cfgData[1].mapConfig
    if self.stateData.sceneLv and self.stateData.sceneLv > 0 then
        cfgIndex = self.stateData.sceneLv
    else
        local lv = RoleDataManager:getMaster():getLevel()
        for k, v in pairs(cfgData) do
            if lv >= v.minLevel and cfgIndex <= v.mapConfig then
                cfgIndex = v.mapConfig
            end
        end
    end

    self.cfgData = NewConfig.WorldBoss:getDataById(cfgIndex)
    return self.cfgData
end

function WorldBossModel:checkCanEnterOther()
    local stateBox = mvc.worldBossModel:getStateBox()
    local roomData = mvc.worldBossModel:getRoomData()
    if stateBox.stateType == 4 and roomData.roomNo and roomData.roomNo > 0 then
        return false
    end
    return true
end

function WorldBossModel:getSwitchRoomCD()
    local nowTime = GameManager:getNowServerTime()
    return self.switchRoomCD - nowTime
end

function WorldBossModel:updateSwitchRoomCD()
    self.switchRoomCD = GameManager:getNowServerTime()
end

function WorldBossModel:resetSwitchRoomCD()
    local totalCD = tonumber(Config.General:getValueForKey("WorldBossSwitchCD"))
    self.switchRoomCD = GameManager:getNowServerTime() + totalCD
end

function WorldBossModel:getStateData()
    return self.stateData
end

function WorldBossModel:updateStateData(data)
    local canJoin = false
    local canFight = true
    local fightBegin = false
    if (self.stateData.isApplying == false or self.stateData.isApplying == nil) and data.isApplying == true then
        -- 可以开始报名
        canJoin = true
    end

    if (self.stateData.isApplying == true or self.stateData.isApplying == nil) and data.isApplying == false then
        -- 不可报名
        canJoin = false
    end

    if self.stateData.isFighting == true and data.isFighting == false then
        -- 不可战斗，战斗结束了
        canFight = false
    end

    if self.roomData and self.roomData.roomNo and self.roomData.roomNo > 0 then
        if self.stateData.isFighting == false and data.isFighting == true then
            -- 开战了
            fightBegin = true
        end
    end

    for k, v in pairs(data) do
        self.stateData[k]  = v
    end

    self.townNotify = canJoin

    if canFight == false then
        if self.roomData and self.roomData.roomNo and self.roomData.roomNo > 0 then
            self.roomData.roomNo = 0
        end

        self.stateData.curRoomNo = 0
        self.stateData.isBossDead = true
        self.stateData.sceneLv = 0

        self.townNotify = false
    end

    self:checkNeedTownNotify()

    if fightBegin then
        if SceneManager:getInstance():isNotInFightScene() then
            mvc.closePanel('WorldBoss', 'WorldBoss')
            mvc.closePanel('WorldBoss', 'WorldBossRoom')

            Avalon.MessageCenter:notice(GameMessage.MC_UI_WORLDBOSS_HIDE_TOPBAR)
        
            mvc.openPanel('WorldBoss', 'WorldBossComfirm')
        end
    end
end

function WorldBossModel:checkNeedTownNotify()
    if self.townNotify == true and self.stateData.isApplying == true then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_WORLDBOSS_SHOW_TOPBAR)
        return
    end

    if self.townNotify == false and self.stateData.isApplying == false then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_WORLDBOSS_HIDE_TOPBAR)
        return
    end

    local stateBox = self:getStateBox()
    if stateBox.stateType == 2 or stateBox.stateType == 4 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_WORLDBOSS_SHOW_TOPBAR)
    end
end

function WorldBossModel:updatePersonalStateData(data)
    local bossDead = false
    if (not self.stateData["isBossDead"]) and data["isBossDead"] then
        bossDead = true
    end

    for k, v in pairs(data) do
        self.stateData[k]  = v
    end

    if data.curRoomNo then
        self.roomData.roomNo = data.curRoomNo
    end

    if bossDead then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_WORLDBOSS_BOSS_DEAD)
    end
end

function WorldBossModel:getBuffText()
    if not self.stateData.battleNo then
        return ""
    end

    local battleNo = self.stateData.battleNo
    local buffStr = Config.General:getValueForKey("WorldBossCareerBuff")
    local buffIDs = string.split(buffStr, ",")
    local buffIndex = math.floor((#self.timeList * math.floor(battleNo/100) + (battleNo%100)) % #buffIDs)+1;
    local buffID = tonumber(buffIDs[buffIndex])
    local cfg = ConfigManager:getBufferConfigById(buffID)
    if cfg then
        return LanguageManager:getInstance():getLocalString(cfg.description)
    end
    return ""
end

function WorldBossModel:checkBattleAvailable()
    local limitCount = tonumber(Config.General:getValueForKey("WorldBossLimitTimes")) or 0
    local fightedCount = self.stateData.fightedToday or 0
    if not self.roomData and fightedCount >= limitCount then
        return false
    elseif self.roomData and not self.roomData.roomNo and fightedCount >= limitCount then
        return false
    elseif self.roomData and self.roomData.roomNo and self.roomData.roomNo == 0 and fightedCount >= limitCount then
        return false
    end
    return true
end

function WorldBossModel:resetChallengeTime()
    if self.stateData then
        self.stateData.fightedToday = 0
    end
end

function WorldBossModel:getRoomData()
    return self.roomData
end

function WorldBossModel:initRoomData(data)
    self.roomData = clone(data)
end

function WorldBossModel:rmRoomData()
    self.roomData = {}
    self.roomData.roomNo = 0
    self.roomData.members = {}
end

function WorldBossModel:updateRoomData(data)
    if self.roomData.members == nil then
        self.roomData.members = {}
    end

    if data.add then
        -- 新增成员
        for k, v in ipairs(data.add) do
            table.insert(self.roomData.members, v)
        end
    end

    if data.del then
        -- 删除成员
        for k, v in ipairs(data.del) do
            for m, n in ipairs(self.roomData.members) do
                if n.pk == v then
                    table.remove(self.roomData.members, m)
                    break
                end
            end
        end
    end
end

function WorldBossModel:initFightStageState()
    self.initFightStageStateInfo = nil
    local nowDate = os.date("*t", GameManager:getNowServerTime() - GameManager:get_timezone_offset())
    local index = 0
    local stateBox = {}
    stateBox.stateType = 0
    stateBox.joinAvailable = true
    stateBox.countDown = -1
    stateBox.btnTxt = ""
    stateBox.tipTxt = ""
    stateBox.nextTime = -1

    if not nowDate then
        return stateBox
    end

    for k, v in ipairs(self.timeList) do
        local lastTime = v[#v]
        if nowDate.hour < lastTime.hour or (nowDate.hour == lastTime.hour and nowDate.min <= lastTime.min) then
            index = k
            break
        end
    end

    if index == 0 then
        return stateBox
    end

    self.initFightStageStateInfo = self.timeList[index]
end
function WorldBossModel:getFightStageCountDown()
    if not self.initFightStageStateInfo then
        return 0
    end
    local nowDate = os.date("*t", GameManager:getNowServerTime() - GameManager:get_timezone_offset())
    local curTimeStep = self.initFightStageStateInfo
    return ((curTimeStep[4].hour - nowDate.hour) * 60 
        + (curTimeStep[4].min - nowDate.min - 1)) * 60 + (60 - nowDate.sec)
end
function WorldBossModel:getStateBox()
    local nowDate = os.date("*t", GameManager:getNowServerTime() - GameManager:get_timezone_offset())
    local index = 0
    local stateBox = {}
    stateBox.stateType = 0
    stateBox.joinAvailable = true
    stateBox.countDown = -1
    stateBox.btnTxt = ""
    stateBox.tipTxt = ""
    stateBox.nextTime = -1

    if not nowDate then
        return stateBox
    end

    for k, v in ipairs(self.timeList) do
        local lastTime = v[#v]
        if nowDate.hour < lastTime.hour or (nowDate.hour == lastTime.hour and nowDate.min <= lastTime.min) then
            index = k
            break
        end
    end

    if index == 0 then
        return stateBox
    end

    local curTimeStep = self.timeList[index]
    -- [1] 活动开始时间（可以报名）
    -- [2] 战斗开始时间
    -- [3] 截止报名时间
    -- [4] 活动结束时间

    -- stateType:
    -- 1: 未报名，报名已截止，无法加入
    -- 2: 未报名，可报名，报名作战
    -- 3: 未报名，已开战，立即加入战斗
    -- 4: 已报名，未开战
    -- 5: 已报名，战斗结束，boss已死
    -- 6: 已报名，已开战，返回战场

    if not self.roomData.roomNo or self.roomData.roomNo == 0 then
        -- 未报名
        if self.stateData.isApplying == false then
            -- 活动报名已截止
            stateBox.stateType = 1
            stateBox.joinAvailable = false
            stateBox.countDown = -1
            stateBox.btnTxt = UI.TEXT_1212637
            stateBox.tipTxt = UI.TEXT_1212638
            stateBox.nextTime = ((curTimeStep[4].hour - nowDate.hour) * 60 + (curTimeStep[4].min - nowDate.min - 1)) * 60 + (60 - nowDate.sec)
            return stateBox
        end

        if self.stateData.isFighting == false then
            -- 未开战，报名作战
            stateBox.stateType = 2
            stateBox.joinAvailable = true
            stateBox.countDown = ((curTimeStep[2].hour - nowDate.hour) * 60 + (curTimeStep[2].min - nowDate.min - 1)) * 60 + (60 - nowDate.sec)
            stateBox.btnTxt = UI.TEXT_1212639
            stateBox.tipTxt = UI.TEXT_1212640
        else
            -- 已开战，立即加入
            stateBox.stateType = 3
            stateBox.joinAvailable = true
            stateBox.countDown = ((curTimeStep[3].hour - nowDate.hour) * 60 + (curTimeStep[3].min - nowDate.min - 1)) * 60 + (60 - nowDate.sec)
            stateBox.btnTxt = UI.TEXT_1212637
            stateBox.tipTxt = UI.TEXT_1212641
            stateBox.nextTime = ((curTimeStep[4].hour - nowDate.hour) * 60 + (curTimeStep[4].min - nowDate.min - 1)) * 60 + (60 - nowDate.sec)
        end
    else
        -- 已报名
        if self.stateData.isFighting == false then
            -- 未开战
            stateBox.stateType = 4
            stateBox.joinAvailable = true
            stateBox.countDown = ((curTimeStep[2].hour - nowDate.hour) * 60 + (curTimeStep[2].min - nowDate.min - 1)) * 60 + (60 - nowDate.sec)
            stateBox.btnTxt = UI.TEXT_1212637
            stateBox.tipTxt = UI.TEXT_1212640
            stateBox.nextTime = ((curTimeStep[4].hour - nowDate.hour) * 60 + (curTimeStep[4].min - nowDate.min - 1)) * 60 + (60 - nowDate.sec)
            return stateBox
        end

        if self.stateData.isBossDead == true then
            -- 战斗结束，boss已死
            stateBox.stateType = 5
            stateBox.joinAvailable = false
            stateBox.countDown = -1
            stateBox.btnTxt = UI.TEXT_1212642
            stateBox.tipTxt = UI.TEXT_1212643
            stateBox.nextTime = ((curTimeStep[4].hour - nowDate.hour) * 60 + (curTimeStep[4].min - nowDate.min - 1)) * 60 + (60 - nowDate.sec)
        else
            -- 返回战场
            stateBox.stateType = 6
            stateBox.joinAvailable = true
            stateBox.countDown = ((curTimeStep[4].hour - nowDate.hour) * 60 + (curTimeStep[4].min - nowDate.min - 1)) * 60 + (60 - nowDate.sec)
            stateBox.btnTxt = UI.TEXT_1212642
            stateBox.tipTxt = UI.TEXT_1212644
            stateBox.nextTime = ((curTimeStep[4].hour - nowDate.hour) * 60 + (curTimeStep[4].min - nowDate.min - 1)) * 60 + (60 - nowDate.sec)
        end
    end

    return stateBox
end

function WorldBossModel:showActivityBanner()
    local nowDate = os.date("*t", GameManager:getNowServerTime() - GameManager:get_timezone_offset())
    local ret = false
    if not nowDate then
        return ret
    end

    for k, v in ipairs(self.timeList) do
        local firstTime = v[1]
        local lastTime = v[#v]
        if (nowDate.hour > firstTime.hour or (nowDate.hour == firstTime.hour and nowDate.min >= firstTime.min)) 
        and (nowDate.hour < lastTime.hour or (nowDate.hour == lastTime.hour and nowDate.min <= lastTime.min)) then
            ret = true
            break
        end
    end

    return ret
end

function WorldBossModel:getReviveCostDiamond()
    local config = self:getConfig()
    local reviveInfo = config.reviveCost
    local num = self.curReviveTime + 1
    if num > #reviveInfo then
        num = #reviveInfo
    end
    return reviveInfo[num]
end

function WorldBossModel:getReviveCD()
    local config = self:getConfig()
    if not config then
        return -1
    end
    return config.autoRevive
end

function WorldBossModel:handleFightMyRank(datas)

end

function WorldBossModel:getConfig()
    local cfgId = GameMapManager:getInstance():getLevel()
    return NewConfig.WorldBoss:getDataById(cfgId)
end

function WorldBossModel:getBuffCost()
    local config = self:getConfig()
    local buffPrice = config.buffPrice
    local prices = string.split(buffPrice, ";")
    local ret = {}
    for i = 1, #prices do
        local t = string.split(prices[i], ",")
        table.insert(ret,t)
    end

    return ret
end

function WorldBossModel:isMaxBuyBuff()
    local config = self:getConfig()
    return self.buyBuffNum + 1 > config.buyBuffLimit
end

function WorldBossModel:checkCostEnough(idx)
    local costs = self:getBuffCost()
    local cost = costs[idx]
    if cost then
        local hasNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(cost[1]), true)
        return  Avalon.MathUtil:checkEnough(tonumber(cost[2]), hasNum),tonumber(cost[1]), tonumber(cost[2])
    end
    return false
end

function WorldBossModel:getCurBuyBuffNum()
    return self.buyBuffNum
end
function WorldBossModel:getNextBuffData()
    local config = self:getConfig()
    local buffIds = config.buffID
    local nextNum = self.buyBuffNum + 1
    local isMaxBuffMore = nextNum > #buffIds
    if isMaxBuffMore then
        nextNum = #buffIds
    end
    local nextBuffId = buffIds[nextNum]
    return ConfigManager:getBufferConfigById(nextBuffId), isMaxBuffMore
end

function WorldBossModel:setMyHurtRank(dspData)
    self.myHurtRankInfo = dspData or {damage = 0, rank=0}
end

function WorldBossModel:getMyHurtRank()
    return self.myHurtRankInfo or {damage = 0, rank=0}
end

function WorldBossModel:setStartCDTime(cdStart)
   self:set("startTime",cdStart)
end

function WorldBossModel:getFightRemindCD()
    local nowTime = GameManager:getNormalServerTime()
    local config = self:getConfig()
    local freezeTime = config.freezeTime or 30

    -- print("现在时间:",GameManager:getNowServerDate(nil, nowTime + GameManager:getEPOCHTime()))
    -- print("现在时间:",GameManager:getNowServerDate(nil, nowTime + GameManager:getEPOCHTime()))
    -- print("现在时间:",GameManager:getNowServerDate(nil, nowTime + GameManager:getEPOCHTime()))
    -- print("服务器通知副本开启时间:",GameManager:getNowServerDate(nil, self.startTime + GameManager:getEPOCHTime()))
    -- print("服务器通知副本开启时间:",GameManager:getNowServerDate(nil, self.startTime + GameManager:getEPOCHTime()))
    -- print("服务器通知副本开启时间:",GameManager:getNowServerDate(nil, self.startTime + GameManager:getEPOCHTime()))

    return self.startTime + freezeTime - nowTime
end



return WorldBossModel