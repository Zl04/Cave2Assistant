--[[--
数据模型GuildLogModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: CMonk
--date  : 2019/10/15
--desc  : GuildLogModel
------------------------------------------------------------------------------
local ProtobufUtil = require "utils.ProtobufUtil"
local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")

local GuildLogModel = class("GuildLogModel",mvc.GameModel)
GuildLogModel.LogContentTypes = {
    TIME = 1,
    TEXT = 2
}


function GuildLogModel:initData()
    self._localVersion = 0
    self._minVersion = 0
    self._logCacheArr = {}
end

function GuildLogModel:initDataNet(data)
    -- add by zp 这里会在切换多语言的时候把缓存的日志数据全部清理掉。清理位置在 
    -- function LanguageManager:setLanguage(language)function LanguageManager:setLanguage(language)

    -- 获取new信息
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if(globalUserData) then
        self._localVersion = globalUserData:getGuildLogVersion()
        self._minVersion = globalUserData:getGuildMinVersion()
        self._logCacheArr = {}
        local stringKeyArr = globalUserData:getGuildLogData()
        for k,v in pairs(stringKeyArr) do
            self._logCacheArr[tonumber(k)] = v
        end
    end

    -- 检查如果服务器清除了消息, 清除本地消息
    if (self._localVersion > data.curVersion) then
        self._logCacheArr = {}
        self._localVersion = 0
        self._minVersion = 0
        -- add by zp 这里一定会出现断线问题，根据逻辑请求的数据一直都满足这里的条件
        -- mvc.guildLogController:requestLog()
        -- return
    end

    -- 移除所有小于最小版本的记录
    if (self._minVersion < data.minVersion) then
        for i=#self._logCacheArr,1,-1 do
            local entry = self._logCacheArr[i]
            if (entry.idx <= data.minVersion) then
                table.remove(self._logCacheArr, i)
            end
        end
    end

    -- 更新基础信息
    local isChanged = self._localVersion ~= data.curVersion or self._minVersion ~= data.minVersion
    self._localVersion = data.curVersion
    self._minVersion = data.minVersion

    -- 添加新的记录
    if (ProtobufUtil:checkFieldIsInit(data, "logs")) then
        local logNum = #data.logs
        for i,log in ipairs(data.logs) do
            local entry = self:parseOneLog(log)
            entry.idx = self._localVersion - logNum + i
            table.insert(self._logCacheArr, entry)
        end
    end

    if (isChanged) then
        local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
        if(globalUserData) then
            globalUserData:setGuildLogVersion(self._localVersion)
            globalUserData:setGuildMinVersion(self._minVersion)
            local stringKeyArr = {}
            for i,v in ipairs(self._logCacheArr) do
                stringKeyArr[tostring(i)] = v
            end
            globalUserData:setGuildLogData(stringKeyArr)
            Avalon.UserDataManager:saveDataToFile(globalUserData:getType())
        end
    end
end

function GuildLogModel:parseOneLog(logContent)
    -- message LogContent {
    --     required uint32 type = 1;               // 类型
    --     required bytes content = 2;             // 内容 参见LogType及Log_XXX
    --     required uint32 gameTime = 3;           // 生成时间
    -- }
    -- enum LogType {
    --     KickHero = 1;
    --     Join = 3;
    --     TitleModify = 4;
    --     Quit = 5;
    --     NoticeModify = 6;
    --     IconModify = 7;
    --     Overthrow = 8;
    --     IncrTechExp = 9;
    --     LvupTech = 10;
    --     KillBoss = 11;
    --     ObtainBox = 12;
    -- }

    local entry = {}

    -- 时间
    entry.gameTime = logContent.gameTime

    -- 内容
    if (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "KickHero")) then
        -- // 踢人日志
        -- message Log_KickHero {
        --     required string beKicker = 1;           // 被踢者名字
        --     required uint32 kickerTitle = 2;        // 踢人者职位
        --     required string kicker = 3;             // 踢人者
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_KickHero", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1112974) --[["踢人：[%s]%s将%s移出了公会"]]
        local GameDataManager = require("app.game.GameDataManager")
        local titleString = GameDataManager:getInstance():getTitleStrForTitle(tonumber(content.kickerTitle))
        entry.content = string.format(
            stringFormat, 
            titleString, 
            tostring(content.kicker), 
            tostring(content.beKicker))
    elseif (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "Join")) then
        -- // 入会
        -- message Log_Join {
        --     required string name = 1;
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_Join", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1112975) --[["入会：%s加入了公会"]]
        entry.content = string.format(
            stringFormat, 
            tostring(content.name))
    elseif (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "TitleModify")) then
        -- // 职位变更
        -- message Log_TitleModify {
        --     required string beModifier = 1;         // 被变更者名字
        --     required uint32 modifierTitle = 2;      // 变更者职位
        --     required string modifier = 3;           // 变更者名字
        --     required uint32 beModifierTitle = 4;    // 被变更者最终职位
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_TitleModify", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1112976) --[["职位变更：[%s]%s将%s更改为[%s]"]]
        local GameDataManager = require("app.game.GameDataManager")
        local modifierTitleString = GameDataManager:getInstance():getTitleStrForTitle(tonumber(content.modifierTitle))
        local beModifierTitleString = GameDataManager:getInstance():getTitleStrForTitle(tonumber(content.beModifierTitle))
        entry.content = string.format(
            stringFormat, 
            modifierTitleString, 
            tostring(content.modifier), 
            tostring(content.beModifier), 
            beModifierTitleString)
    elseif (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "Quit")) then
        -- // 申请退会
        -- message Log_Quit {
        --     required string name = 1;
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_Quit", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1112977) --[["退会：%s离开了公会"]]
        entry.content = string.format(
            stringFormat, 
            tostring(content.name))
    elseif (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "NoticeModify")) then
        -- // 公告变更
        -- message Log_NoticeModify {
        --     required uint32 modifierTitle = 1;          // 变更者职位
        --     required string modifier = 2;               // 变更者名字
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_NoticeModify", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1112978) --[["公告变更：[%s]%s更改了公会公告"]]
        local GameDataManager = require("app.game.GameDataManager")
        local modifierTitleString = GameDataManager:getInstance():getTitleStrForTitle(tonumber(content.modifierTitle))
        entry.content = string.format(
            stringFormat, 
            modifierTitleString, 
            tostring(content.modifier))
    elseif (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "IconModify")) then
        -- // 图表变更
        -- message Log_IconModify {
        --     required uint32 modifierTitle = 1;          // 变更者职位
        --     required string modifier = 2;               // 变更者名字
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_IconModify", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1112979) --[["图标变更：[%s]%s更改了公会图标"]]
        local GameDataManager = require("app.game.GameDataManager")
        local modifierTitleString = GameDataManager:getInstance():getTitleStrForTitle(tonumber(content.modifierTitle))
        entry.content = string.format(
            stringFormat, 
            modifierTitleString, 
            tostring(content.modifier))
    elseif (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "Overthrow")) then
        -- // 会长罢免
        -- message Log_Overthrow {
        --     required string orgLeader = 1;
        --     required string curLeader = 2;
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_Overthrow", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1112980) --[["会长：%s被罢免了%s成为了新的会长"]]
        entry.content = string.format(
            stringFormat, 
            tostring(content.orgLeader), 
            tostring(content.curLeader))
    elseif (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "IncrTechExp")) then
        -- // 增加科技经验
        -- message Log_IncrTechExp {
        --     required string name = 1;
        --     required uint32 val = 2;
        --     required uint32 techID = 3;
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_IncrTechExp", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1112981) --[["科技：%s为[%s]做出了%s点贡献"]]
        local techName = ToolsUtil:getGuildTechText(content.techID)
        entry.content = string.format(
            stringFormat, 
            tostring(content.name),
            techName, 
            tostring(content.val))
    elseif (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "LvupTech")) then
        -- // 科技升级
        -- message Log_LvupTech {
        --     required uint32 techID = 1;
        --     required uint32 lv = 2;
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_LvupTech", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1112982) --[["科技升级：[%s]等级提升至了%s"]]
        local techName = ToolsUtil:getGuildTechText(content.techID)
        entry.content = string.format(
            stringFormat, 
            techName, 
            tostring(content.lv))
    elseif (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "KillBoss")) then
        -- // 击杀BOSS
        -- message Log_KillBoss {
        --     required uint32 bossTemplateID = 1;
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_KillBoss", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1112983) --[["击杀Boss：[%s]已被击败"]]
        local bossName = self:getMonsterNameFromTemplateID(tonumber(content.bossTemplateID))
        entry.content = string.format(
            stringFormat, 
            bossName)
    elseif (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "ObtainBox")) then
        -- // 获得宝箱
        -- message Log_ObtainBox {
        --     required string obtainer = 1;
        --     required uint32 boxID = 2;
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_ObtainBox", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1112984) --[["宝箱增加：%s为公会贡献了一个[%s]"]]
        require "app.datas.GuildBoxDataManager"
        local boxName = GuildBoxDataManager:getGuildBoxNameByID(content.boxID)
        entry.content = string.format(
            stringFormat, 
            tostring(content.obtainer), 
            boxName)
    elseif (logContent.type == ProtobufUtil:enum_id("GuildSystem.LogType", "AuctionProfit")) then
        -- // 拍卖分钱
        -- message Log_AuctionProfit {
        --     required uint32 profit = 1;                 // 公会贡献收益
        -- }
        local content = ProtobufUtil:decode("GuildSystem.Log_AuctionProfit", logContent.content)
        local stringFormat = LanguageManager:getInstance():getLocalString(1113533) --[["拍卖：本次拍卖为公会增加了%d贡献"]]
        entry.content = string.format(
            stringFormat, 
            content.profit)
    end
    return entry
end

function GuildLogModel:getLogVersion()
    return self._localVersion
end

function GuildLogModel:getLog()
    return self._logCacheArr
end

function GuildLogModel:getLogForDisplay()
    local logsToDisplay = {}
    local currentDay = nil

    -- 如果最后一次操作距现在5分钟以上就在最开始显示一个时间
    local logNum = #self._logCacheArr
    if (logNum > 0 and GameManager:getNormalServerTime() - self._logCacheArr[logNum].gameTime > 300) then
        local content, targetDay = self:getLocalTimeStringFromServerTime(self._logCacheArr[logNum].gameTime)
        currentDay = targetDay
        local timeEntry = {
            type = GuildLogModel.LogContentTypes.TIME,
            content = content
        }
        table.insert(logsToDisplay, timeEntry)
    end


    -- 如果有两条消息之间有差5分钟以上就插入一个时间
    for i=logNum,2,-1 do
        local log = self._logCacheArr[i]
        table.insert(logsToDisplay, log)

        -- 判断是否需要插入时间显示
        local nextLog = self._logCacheArr[i - 1]
        if (log.gameTime - nextLog.gameTime > 300) then
            -- 在一天之内的时候, 每个标签都显示
            -- 在第一天以外, 只显示天数的时候一天只显示一个标签
            local timeString, targetDay = self:getLocalTimeStringFromServerTime(nextLog.gameTime)
            if (not targetDay or currentDay ~= targetDay) then
                if (targetDay) then currentDay = targetDay end
                local timeEntry = {
                    type = GuildLogModel.LogContentTypes.TIME,
                    content = timeString
                }
                table.insert(logsToDisplay, timeEntry)
            end
        end
    end
    if (logNum > 0) then
        table.insert(logsToDisplay, self._logCacheArr[1])
    end
    return logsToDisplay
end


function GuildLogModel:getLocalTimeStringFromServerTime(gameTime)
    local serverTime = GameManager:getNormalServerTime()
    local timeDelta = serverTime - gameTime
    local localTime = os.time()
    local localDate = os.date("*t")
    local localTargetTime = localTime - timeDelta
    local localTargetDate = os.date("*t", localTargetTime)
    local deltaDay = localDate.day - localTargetDate.day

    if (deltaDay > 0) then
        local formatString = UI.TEXT_1213961
        return string.format(formatString, tostring(deltaDay)), deltaDay
    else
        local localTargetDateFormated = os.date("%H:%M", localTargetTime)
        return tostring(localTargetDateFormated)
    end
end

function GuildLogModel:getMonsterNameFromTemplateID(templateID)
    local monsterData = RoleDataManager:createLocalMonsterDataForAllConfig(templateID)
    if (monsterData) then
        return monsterData:getName()
    end
    return ""
end

return GuildLogModel