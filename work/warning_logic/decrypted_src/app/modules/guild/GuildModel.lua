--[[--
数据模型GuildModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/05/28
--desc	: GuildModel
------------------------------------------------------------------------------
require "app.datas.guild.GuildBossData"
local ProtobufUtil = require "utils.ProtobufUtil"

local GuildModel = class("GuildModel",mvc.GameModel)

-- 公会日志类型
GUILD_LOG_TYPE = {
    GUILD_LOG_TYPE_FIGHT = 1,
    GUILD_LOG_TYPE_BOX = 2;
}

function GuildModel:initData()
    self.logArr = nil
    self.logStrArr = nil
    self.bossDataArr = {}
    self.buffActTime = 0   -- buff激活时间
    self.fightNum = 0
    self.hardLv = 0    -- 难度等级
    self.heroInTime = 0
    self.isPersonalBuffAct = false
end

function GuildModel:getBossDataArr()
    return self.bossDataArr
end

function GuildModel:getLogStrArr()
    return self.logStrArr
end

function GuildModel:getFightStageCountDown()
    local guildCfg = ConfigManager:getGuildBossCfgByID(self.hardLv)
    if(guildCfg == nil) then
        print("GuildModel:getFightStageCountDown", self.hardLv)
        return 0
    end
    -- print("GuildModel:getFightStageCountDown 2", guildCfg.timeLimit, self.heroInTime)
    local time = guildCfg.timeLimit - (GameManager:getNormalServerTime() - self.heroInTime)
    if(time < 0) then 
        time = 0
    end

    return time
end

function GuildModel:initGuildBossData(bossData)
    if(ProtobufUtil:checkFieldIsInit(bossData, "data")) then
        local data = bossData.data
        self:set("buffActTime", data.buffActTime)
        self:set("hardLv", data.hardLv)
        self.logArr = {}
        self.logStrArr = {}
        if(data.log) then 
            self:_addLogArr(data.log)
        end
        
        self.bossDataArr = {}
        -- print("data.boss=", data.boss)
        if(data.boss) then 
            for k,v in ipairs(data.boss) do 
                -- print("data.boss v=", v)
                local guildBossData = Data.GuildBossData:create()
                guildBossData:initNet(v, k-1)
                table.insert(self.bossDataArr, guildBossData)
            end
        end
        table.sort(self.bossDataArr, function(a, b)
            if(a:getBossIndex()< b:getBossIndex()) then 
                return true
            end
            return false
        end)
    end
    if(ProtobufUtil:checkFieldIsInit(bossData, "isPersonalBuffAct")) then
        self:set("isPersonalBuffAct", bossData.isPersonalBuffAct)
    end
    if(ProtobufUtil:checkFieldIsInit(bossData, "guildBossFightNum")) then 
        self:set("fightNum", bossData.guildBossFightNum)
    end
end

function GuildModel:handleBuyBuff(data)
    self:set("buffActTime", data.buffActTime)
end

function GuildModel:handleBuyPersonalBuff(isPersonalBuffAct)
    self:set("isPersonalBuffAct", isPersonalBuffAct)
end

function GuildModel:handleFightNum(data)
    self:set("fightNum", data.fightNum)
end

function GuildModel:getFightNum()
    return self.fightNum
end

function GuildModel:getHardLv()
    return self.hardLv
end

function GuildModel:getBuyBuff()
    if math.floor(GameManager:getNormalServerTime()/SECONDS_ONE_DAY) == math.floor(self.buffActTime/SECONDS_ONE_DAY) then 
        return true
    end

    return false
end

function GuildModel:getIsPersonalBuffAct()
    return self.isPersonalBuffAct, tonumber(ConfigManager:getGuildConfigForKey("guildBossPersonalPrice"))
end

function GuildModel:handleGuildBossFight(data)
    for k, guildBossData in ipairs(self.bossDataArr) do 
        if guildBossData:getBossIndex() == data.bossIndex then 
            guildBossData:initNet(data.oneBoss, data.bossIndex)
            break
        end
    end
end

function GuildModel:handleOneBossData(data)
    -- 更新数据信息
    for k, guildBossData in ipairs(self.bossDataArr) do 
        if guildBossData:getBossIndex() == data.bossIndex then 
            guildBossData:initNet(data.oneBoss, data.bossIndex)
            break
        end
    end

    -- 可能会有多份
    if(self.logArr) then 
        if(data.log) then 
            self:_addLogArr(data.log)
        end
    end
end

function GuildModel:handleBeforeMsg(data)
    if(data and data.heroInTime) then 
        self.heroInTime = data.heroInTime
    end
end

function GuildModel:handleUpdataFighting(data)
    for k, guildBossData in ipairs(self.bossDataArr) do 
        if guildBossData:getBossIndex() == data.bossIndex then 
            guildBossData:setIsFighting(data.isfighting)
            break
        end
    end
end

function GuildModel:checkGuildTechUnlock(data)
    local isUnlock = true
    for index,v in ipairs(data.techIDBeforeLearn) do 
        local id = data.techIDBeforeLearn[index]
        local lv = data.techLevelBeforeLearn[index]
        if(id ~= 0) then
            -- 判断是否解锁了
            local learnData = MasterDataManager:getGuildTechForTechID(id)
            if(learnData) then 
                if learnData.curLv < lv then 
                    isUnlock = false
                end
            else 
                isUnlock = false
            end
        end
    end

    local masterData = RoleDataManager:getMaster()
    local roleLv = masterData:getLevel()
    if data.unlockLevel > roleLv then
        isUnlock = false
    end

    return isUnlock
end

function GuildModel:_addLogArr(log)
    if(log == nil) then 
        return 
    end

    local guildData = MasterDataManager:getGuildData()
    local addLogArr = {}
    if(guildData) then
        for k,v in ipairs(log) do 
            local oneLog = {}
            oneLog.pk = v.pk
            oneLog.opt = v.opt  -- 操作类型 GuildBossFightLogOpt
            oneLog.extend = v.extend   -- 扩展参数 根据操作类型
            oneLog.monsterID = v.bossID

            table.insert(self.logArr, oneLog)
            local oneStrLog = {}
            oneStrLog.type = self:_calculationLogType(v.opt)
            -- print("_calculationLogType", v.opt,  oneStrLog.type)

            local monsterData = RoleDataManager:createLocalMonsterDataForModeAndDiff(oneLog.monsterID, PublicDefine.CAVE_MODE.MODE_GUILD_BOSS, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
            local monsterName = ""
            local heroName = UI.TEXT_1212707
            if(monsterData) then 
                monsterName = monsterData:getName()
            end

            local guildMemberData = guildData:getMemberDataForPK(oneLog.pk)
            if(guildMemberData) then 
                heroName = guildMemberData:getName()
            end

            if(oneStrLog.type ==  GUILD_LOG_TYPE.GUILD_LOG_TYPE_FIGHT) then 
                oneStrLog.str = string.format(UI.TEXT_1212705, heroName, monsterName, string.format("%.2f", oneLog.extend*100.0/RATIO_NUMBER))
            elseif(oneStrLog.type ==  GUILD_LOG_TYPE.GUILD_LOG_TYPE_BOX) then 
                oneStrLog.str = string.format(UI.TEXT_1212706, heroName, monsterName, oneLog.extend)
            end

            table.insert(self.logStrArr, oneStrLog)
            -- table.insert(addLogArr, oneStrLog)
        end
    end
    if(self.logStrArr and #self.logStrArr > 0) then 
        mvc.send(mvc.events.Guild_SelectFloor_Log_Add, self.logStrArr)
    end
end

function GuildModel:_calculationLogType(opt)
    if(opt == "GuildBossFightLogOpt_Fight") then 
        return GUILD_LOG_TYPE.GUILD_LOG_TYPE_FIGHT
    elseif(opt == "GuildBossFightLogOpt_Box") then
        return GUILD_LOG_TYPE.GUILD_LOG_TYPE_BOX
    end

    return -1
end

return GuildModel