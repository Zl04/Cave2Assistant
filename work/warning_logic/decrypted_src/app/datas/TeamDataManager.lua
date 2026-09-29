--[[
    队伍信息
]]

require "app.config.ConfigManager"
require "app.datas.team.TeamRoleData"
require "utils.ObserverVariable"

local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local DEBUG = true

TeamDataManager = TeamDataManager or {}

function TeamDataManager:init()
    -- 团队信息
    self._teamList = {} 
    self._teamID = 0;      --队伍ID
    self._addDtTime = 0
    self._teamType = Game.TeamType.FromLevelSelect
    local _teamData = {}
    self._readyTeamData = ConcreteObserver:create(_teamData)    --准备数据
    self._autoTipsDismiss = true

    self.beKickPlayerPk = 0;            --被踢得人
    self.isMercenaryTeam = false        -- 是否为雇佣队伍，如果为雇佣队伍，就不是真的组队

    --刷新匹配时间
    self._lastDtTime = AvalonUtil.getCurrentTime()
    local scheduler=cc.Director:getInstance():getScheduler()
    scheduler:scheduleScriptFunc(handler(self,self.refreshKickTime), 1,false)


    self._readyState = false;       --是不是准备状态

     --惩罚状态,0正常,1一次不匹配,2二次不匹配,惩罚禁止匹配
    self.punishmentState = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.PunishmentState, 0)  
    --惩罚时间  时间搓 
    self.mPunishmentTime = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.PunishmentTime, 0)    
    --匹配最大时间
    self:setMatchTime(PublicDefine.CONST_DEFINITION.COUNTDOWN_CANCEL_MATCH/1000)

    --邀请队友的时候使用用于判断关卡信息
    self.inviteTeamDataList = {}

    self._lastDtTime = 0
end

function TeamDataManager:clear()
    table.clear(self._teamList)

    self._teamID = 0
    self._lastDtTime = 0

    local _teamData = {}
    self._readyTeamData:set(_teamData)
    self:setReadyState(false)
    self.inviteTeamDataList = {}
    self._autoTipsDismiss = true
    self.isMercenaryTeam = false
end

-- 回档（恢复）清理数据
function TeamDataManager:restoreClear()
    -- TODO 回档（恢复）清理数据
    self._teamID = 0
    self._teamList = {}
    
    local _teamData = {}
    self._readyTeamData:set(_teamData)

    self:setReadyState(false)
    self.inviteTeamDataList = {}
    self._autoTipsDismiss = true
    self.isMercenaryTeam = false
end

function TeamDataManager:setIgnorAutoTipsDismiss(flag)
    self._autoTipsDismiss = flag
end

--添加队友
function TeamDataManager:addTeamRole(data)
    local teamRoleData = Data.TeamRoleData:create()
    teamRoleData:initNet(data)
    self._teamList[data.pk] = teamRoleData;

    --需要从待准备的队伍中移除掉角色数据
    local _readyTeamData = self._readyTeamData:get()
    if table.nums(_readyTeamData) > 0 then
        for i = 1,3 do
            if _readyTeamData[i] and _readyTeamData[i].pk == data.pk then
                _readyTeamData[i] = nil
                break
            end
        end
        self._readyTeamData:set(_readyTeamData)
    end

    local chatPlayer = {}
    chatPlayer.pk = data.pk
    chatPlayer.userID = data.userID
    chatPlayer.nickName = ToolsUtil:replaceShowNickNameStr(data.nickName)
    Game.ChatManager:getInstance():refreshPersonalUserID(chatPlayer)

    Avalon.MessageCenter:notice(GameMessage.MC_TEAM_JOIN, teamRoleData)
end

-- 获取队伍信息
function TeamDataManager:getTeamDataForPK(pk)
    if(pk) then
        return self._teamList[pk]
    else 
        return nil
    end
end

--移除队伍中某个队友
function TeamDataManager:removeTeamRole(pk, isDismiss)
    GameDataManager:getInstance():clearHeroDataForPK(pk)
    if(isDismiss == nil) then 
        isDismiss = false
    end
    if self._teamList[pk] then
        self._teamList[pk] = nil;
    end
    if pk ~= RoleDataManager:getMasterPK() and self._autoTipsDismiss and isDismiss and SceneManager:getInstance():isInFightScene() then
        local teamNum = 0
        for k,v in pairs(self._teamList) do
            teamNum = teamNum + 1
        end
        if(teamNum == 1 and not SceneManager:getInstance():isInWormhole()) then       
            local LanguageManager = require "app.game.LanguageManager"
            -- print("TeamDataManager:removeTeamRole", debug.traceback())

            local tips = UI.Tips:createTips(LanguageManager:getInstance():getLocalString(1111688), UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
            tips:setContentFontName(UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
            -- 确定和取消事件监听
            tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()

                Net.NetTeamSystem:reqDismissTeam()
            end)
            tips:leftBottom(0,20)
            tips.touchDialogOutsizeClose = false
            tips:setInterceptTouches(false);
            tips:leftBottom(0,20)
            tips:setName("dismissTeam")
            tips:enableIrregularShapeScreenAdjustment(true)
        end
    end

    Avalon.MessageCenter:notice(GameMessage.MC_TEAM_LEAVE, pk)
end

--离开队伍
function TeamDataManager:levelTeam(pk)   
    if self._teamList[pk] then
        if pk == RoleDataManager:getMasterPK() then
            self:dismissTeam(1)
        else
            self:removeTeamRole(pk, true)
        end
    elseif not self:hasTeam() then
        Avalon.MessageCenter:notice(GameMessage.MC_TEAM_LEAVE, pk)
    end
    self:refreshTeamGuild(true)
end

--踢出队伍
function TeamDataManager:kickTeam(pk)
    if self._teamList[pk] then
        if pk == RoleDataManager:getMasterPK() then
            self:dismissTeam(2)
        else
            self:removeTeamRole(pk, true)
        end
    end
    self:refreshTeamGuild(true)
end

--创建队伍
function TeamDataManager:createTeam(data)
    self._teamID = data.teamID
    self._teamList = {}
    for k,v in pairs(data.teamMemberData) do
        self:addTeamRole(v)
    end
    self.isMercenaryTeam = data.isMercenaryTeam
end


--解散队伍
function TeamDataManager:dismissTeam(data)
    self._teamID = 0
    for k,v in pairs(self._teamList) do
        if(data == 2 or data == 1) then 
            self:removeTeamRole(k, false)
        else 
            self:removeTeamRole(k, true)
        end 
    end

    self:setReadyState(false)
    -- print("TeamDataManager:dismissTeam",data)
    Avalon.MessageCenter:notice(GameMessage.MC_TEAM_DISMISS_TEAM,data)
    self:refreshTeamGuild(true)
end

--加入队伍
function TeamDataManager:joinTeam(data)
    self._teamID = data.teamID
    self:addTeamRole(data.teamMemberData)
    self:refreshTeamGuild()
end

--获取TeamID
function TeamDataManager:getTeamID()
    return self._teamID
end

--获取团队信息
function TeamDataManager:getTeamData()
    return self._teamList
end

--是否有团队
function TeamDataManager:hasTeam()
    if(self.isMercenaryTeam) then 
        return false
    end
    if self._teamID == 0 then
        return false
    end
    return true;
end

--是否为雇佣团队
function TeamDataManager:hasMercenaryTeam()
    return self.isMercenaryTeam
end

-- 判断是否在队伍中
function TeamDataManager:judgeIsInTeam(pk)
    if(self._teamID ~= 0) then
        for k,v in pairs(self._teamList) do
            if(k == pk) then
                return true
            end
        end
    end

    return false
end

--更改队伍在线状态
function TeamDataManager:updateOnLineState(pk,onlineState,userID)
    print("TeamDataManager:updateOnLineState")
    if(onlineState == false) then
        GameDataManager:getInstance():clearHeroDataForPK(pk)
    end
    print(pk)

    if self._teamList[pk] ~= nil then
        self._teamList[pk]:setState(onlineState)
        if userID ~= 0 then
            self._teamList[pk]:setUserID(userID)
        end
    end

    local chatPlayer = {}
    chatPlayer.pk = pk
    chatPlayer.userID = userID
    Game.ChatManager:getInstance():refreshPersonalUserID(chatPlayer)

    Avalon.MessageCenter:notice(GameMessage.MC_TEAM_UPDATE_ONLINE, pk,onlineState)
end

--
function TeamDataManager:printTeam()
    print("TeamDataManager:printTeam")
    for k,v in pairs(self._teamList) do
        print(k,v.nickName)
    end
end

--玩家信息转换为队伍信息
function TeamDataManager:transformTeamData(data,wearEquipmentArr)
    local teamData = {}

    teamData.pk = data:getPK() or -1
    teamData.headID = {}
    for k,v in pairs(wearEquipmentArr) do
        table.insert(teamData.headID,v:getGoodsID())
    end

    if data.nickName and data.nickName ~= "" then
        teamData.nickName = data.nickName
    else
        teamData.nickName = "pk:"..teamData.pk;
    end
    teamData.memberStatus = data.memberStatus or PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE;
    teamData.sex = data:getSex()
    teamData.faceDecodeID = data:getFaceDecodeID()
    

    local teamRoleData = Data.TeamRoleData:create()
    teamRoleData:initNet(teamData)
    return teamRoleData
end

--设置准备队伍信息
function TeamDataManager:setReadyTeamData(readyTeamData)
    self._readyTeamData:set(readyTeamData)
end

--获取准备队伍信息
function TeamDataManager:getReadyTeamData()
    return self._readyTeamData:get()
end

--dt 在登录进度条时不准确
function TeamDataManager:refreshKickTime(dt)
    local cutTime = 0
    local currentTime = AvalonUtil.getCurrentTime()
    if self._lastDtTime == 0 then
        cutTime = 0
    else
        cutTime = currentTime - self._lastDtTime 
    end
    self._lastDtTime = currentTime

    for k,teamData in pairs(self._teamList) do
        if teamData.kickTime > 0 then
            teamData.kickTime = teamData.kickTime - cutTime / 1000
        end
        if(teamData.dismissTime and teamData.dismissTime > 0) then
            teamData.dismissTime = teamData.dismissTime - cutTime / 1000
        end
    end
    
    if self.punishmentState ~= 0 then
        -- self.mPunishmentTime = self.mPunishmentTime - cutTime / 1000
        if self.mPunishmentTime < GameManager:getNowServerTime() then
            self.punishmentState = 0
        end
    end
end

function TeamDataManager:setPunishmentState(count)
    self.punishmentState = count
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.PunishmentState, self.punishmentState)
end

function TeamDataManager:getPunishmentState()
    return self.punishmentState
end

function TeamDataManager:setPunishmentTime(time)
    self.mPunishmentTime = time
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.PunishmentTime, self.mPunishmentTime)
end

function TeamDataManager:getPunishmentTime()
    return self.mPunishmentTime
end

--服务器 给的是 倒计时差值   客户端得存成时间搓
function TeamDataManager:setMatchTime(time)
    self.matchTime = os.time() + time
end

function TeamDataManager:getMatchTime ()
    return self.matchTime - os.time()
end

--通知队长改变
function TeamDataManager:notifyCaptainChange(pk)
    print("TeamDataManager:notifyCaptainChange",pk)
    for k,v in pairs(self._teamList) do
        if(k == pk) then
            v:setCaptain(true)
        else
            v:setCaptain(false)
        end
    end


    local _readyTeamData = self._readyTeamData:get()
    for k,v in pairs(_readyTeamData) do
        if v.pk == pk then
            v.captain = true
        else
            v.captain = false
        end
    end

    self._readyTeamData:set(_readyTeamData)

    Avalon.MessageCenter:notice(GameMessage.MC_TEAM_CAPTAIN_CHANGE,pk)
end

--设置匹配中状态(只有匹配中)
function TeamDataManager:setReadyState(var)
    self._readyState = var
    if not SceneManager:getInstance():isInFightScene() then
        if self._readyState then
            GameDataManager:getInstance():setLockDungeonKey(LevelSelectUtil:getInstance().mCaveMode, LevelSelectUtil:getInstance().mSelectLevel)
        else
            GameDataManager:getInstance():removeLockDungeonKey()
        end
    end
end

--获取匹配中状态
function TeamDataManager:getReadyState()
    return self._readyState
end

--设置匹配中状态(匹配中和匹配成功)
function TeamDataManager:setIsMatching(var)
    self._isMatching = var
end

--获取匹配状态
function TeamDataManager:getIsMatching()
    return self._isMatching
end

--获取队伍人数
function TeamDataManager:getTeamMemberNum()
    local counter = 0
    for k,v in pairs(self._teamList) do
        counter = counter + 1
    end
    return counter == 0 and 1 or counter
end

function TeamDataManager:setTeamType(teamType)
    self._teamType = teamType
end

function TeamDataManager:getTeamType()
    return self._teamType
end

function TeamDataManager:getSameGuildBuf()
    local sameGuildNum, sameGuildId, buffID = 0
    local teamDataList = TeamDataManager:getReadyTeamData()
    if table.nums(teamDataList) > 0 then
        for k1, v1 in pairs(teamDataList) do
            if v1.guildID ~= nil and v1.guildID ~= 0 and sameGuildNum == 0 then
                for k2, v2 in pairs(teamDataList) do
                    if v1.pk ~= v2.pk and v1.guildID == v2.guildID then
                        sameGuildNum = sameGuildNum + 1
                        sameGuildId = v1.guildID
                    end
                end
            end
        end
    else
        local guildData = MasterDataManager:getGuildData()
        if guildData then
            sameGuildId = guildData:getID()
        end
        local pk = RoleDataManager:getMaster():getPK()
        for k1, v1 in pairs(self._teamList) do
            if v1.guildID ~= nil and v1.guildID ~= 0 and sameGuildId == v1.guildID and v1.pk ~= pk then
                sameGuildNum = sameGuildNum + 1
            end
        end
    end
    sameGuildNum = sameGuildNum + 1
    local param = ConfigManager:getGuildConfigForKey("guildTeamBuff")
    if sameGuildNum == 2 then
        buffID = param[1]
    elseif sameGuildNum == 3 then
        buffID = param[2]
    end
    return sameGuildNum, sameGuildId, buffID
end

--[[
组队公会buf刷新情况：
1、组队界面 进出队伍，刷新组队界面
2、组队界面 进出公会，刷新组队界面
3、战斗场景 进出队伍，刷新小地图  
4、战斗场景 进出公会，刷新小地图  
]]
function TeamDataManager:refreshTeamGuild(isForceRefresh)
    local guildData = MasterDataManager:getGuildData()
    local teamDataList = TeamDataManager:getReadyTeamData()
    local pk = RoleDataManager:getMaster():getPK()
    local isDirty = false
    if guildData == nil then
        for k1, v1 in pairs(teamDataList) do
            if pk == v1.pk and v1.guildID ~= 0 then
                v1.guildID = 0
                isDirty = true
                break
            end
        end

        for k1, v1 in pairs(self._teamList) do
            if pk == v1.pk and v1.guildID ~= 0 then
                v1.guildID = 0
                isDirty = true
                break
            end
        end
        if isDirty or isForceRefresh then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_GUILD_TEAM_BUF)
        end
        return
    end

    
    local selfGuildId = guildData:getID()
    for k1, v1 in pairs(teamDataList) do
        if pk == v1.pk then
            if v1.guildID ~= selfGuildId then
                v1.guildID = selfGuildId
                isDirty = true
            end
        elseif v1.guildID == selfGuildId then
            local data = guildData:getMemberDataForPK(v1.pk)
            if data == nil and v1.guildID ~= 0 then
                v1.guildID = 0 
                isDirty = true
            end
        else
            local data = guildData:getMemberDataForPK(v1.pk)
            if data and v1.guildID ~= selfGuildId then
                v1.guildID = selfGuildId 
                isDirty = true
            end
        end
    end

    for k1, v1 in pairs(self._teamList) do
        if pk == v1.pk then
            if v1.guildID ~= selfGuildId then
                v1.guildID = selfGuildId
                isDirty = true
            end
        elseif v1.guildID == selfGuildId then
            local data = guildData:getMemberDataForPK(v1.pk)
            if data == nil and v1.guildID ~= 0 then
                v1.guildID = 0 
                isDirty = true
            end
        else
            local data = guildData:getMemberDataForPK(v1.pk)
            if data and v1.guildID ~= selfGuildId then
                v1.guildID = selfGuildId 
                isDirty = true
            end
        end
    end
    if isDirty or isForceRefresh then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_GUILD_TEAM_BUF)
    end
end
--默认初始化
TeamDataManager:init()







