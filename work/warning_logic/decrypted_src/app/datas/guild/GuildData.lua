-- GuildData.lua
-- Author:zp
-- 2017年9月18日
-- Using:公会数据

require "app.datas.GameData"
require "app.datas.guild.GuildMemberData"
require "app.config.ConfigManager"

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")

local GuildData = class("GuildData",GameData.Base)

Data = Data or {}
Data.GuildData = GuildData

function GuildData:ctor()
	GuildData.super.ctor(self, Category.GUILD, nil)

    self:init()
end

function GuildData:init()
    self.ID = 0                 --公会的ID
    self.iconID = 0             --公会图标ID
    self.name = ""               --公会名字
    self.notice = ""             --公会公告
    self.boughtIconID = {}       --购买的图标ID
    self.members = {}            --公会成员
    self.techTotalLv = 0        --公会科技总等级
    self.isOpenJoinAudit = false    --是否开启加入审批
    self.joinEquipScoreLmt = 100      --加入公会装备积分限制
    self.version = 0           --本次加载的数据的版本
    self.hasJoinReq = false    -- 是否有加入请求
    self.rank = 0              -- 公会排名，要显示的时候单独获取
    self.contib = 0            -- 本周贡献度
    self.guildTeamMedal = 0     -- 公会持有的公会贡献
    self.customTitles = {}      -- 职级名称自定义
    self.writList = {}          --令状列表
    self.applyJoinList = {}        -- 申请加入公会的列表
    self.treasureList = nil     --公会鉴宝数据
    self.treasureUseCount = 0
end

function GuildData:initNet(data)
    self.ID = data.ID                
    self.iconID = data.iconID            
    self.name = data.name              
    self.notice = data.notice             
    self.boughtIconID = data.boughtIconID     
    self.techTotalLv = data.techTotalLv       
    self.isOpenJoinAudit = data.isOpenJoinAudit    
    self.joinEquipScoreLmt = data.joinEquipScoreLmt      
    self.version = data.version          
    self.hasJoinReq = data.hasJoinReq
    self.contib = data.contib
    self.guildTeamMedal = data.guildTeamMedal
    self.createTime = data.createTime

    -- 发起罢免的时间点
    self.overthrowLeaderTime = 0
    local ProtobufUtil = require "utils.ProtobufUtil"
    if(ProtobufUtil:checkFieldIsInit(data, "overthrowLeaderTime")) then
        self.overthrowLeaderTime = data.overthrowLeaderTime
    end

    -- 自己是否已经投票了
    self.isSelfVoteOverthrow = false
    if(ProtobufUtil:checkFieldIsInit(data, "isSelfVoteOverthrow")) then
        self.isSelfVoteOverthrow = data.isSelfVoteOverthrow
    end

    -- 加入公会的时间, 0是很久之前加入的
    self.joinTime = -1
    if(ProtobufUtil:checkFieldIsInit(data, "joinTime")) then
        self.joinTime = data.joinTime
    end

    -- 职级名称自定义
    if(ProtobufUtil:checkFieldIsInit(data, "titles")) then
        self.customTitles = data.titles
    end

    --公会令状
    if(ProtobufUtil:checkFieldIsInit(data, "writInfo")) then
        local writInfo = data.writInfo
        local list = writInfo.writs
        local cfgList = NewConfig.GuildWrit:getAllDatas()
        for k, v in ipairs(cfgList) do
            local data = clone(v)
            data.actTime = 0
            for k2, v2 in pairs(list) do
                if v2.id == v.ID then
                    data.actTime = v2.actTime
                end
            end
            table.insert(self.writList, data)
        end
    end

    -- 处理初始化成员数据
    self:addMembers(data.members)

    self.name = ToolsUtil:replaceShowNickNameStr(self.name)
end

function GuildData:initTreasures(data)
    self.treasureList = {}
    for k, v in ipairs(data.treasures) do
        local cfg = NewConfig.GAuctionPool:getDataById(v)
        table.insert(self.treasureList, cfg)
    end
    self.treasureUseCount = data.useCount
    self.treaCloseTime = data.closeTime              --当前阶段结束时间
    local ProtobufUtil = require "utils.ProtobufUtil"
    mvc.guildAuctionModel:setCurStatus(data.auctionState)
end

function GuildData:setCreateTime(createTime)
    self.createTime = createTime
end

function GuildData:getCreateTime()
    return self.createTime
end

--[[获取限制时间 新创建的公会 和 新加入的公会都会触发cd限制]]
function GuildData:getCreateCdTime()
    local cdTime = tonumber(ConfigManager:getGuildConfigForKey("guildAuctionPrepareTime"))
    local createLftime = self.createTime + cdTime - GameManager:getNormalServerTime()  
    return math.ceil(createLftime / SECONDS_ONE_DAY), createLftime
end


function GuildData:isInJoinCdTime()
    local joinWeek = AvalonUtil:getWeekNum(self.joinTime)
    local curWeek = AvalonUtil:getWeekNum(GameManager:getNormalServerTime())
    if joinWeek < curWeek then
        return false
    else
        return true
    end
end

function GuildData:setTreasure(data)
    self.treasureList = self.treasureList or {}
    local cfg = NewConfig.GAuctionPool:getDataById(data.treasureIndex)
    table.insert(self.treasureList, cfg)
    self.treasureUseCount = self.treasureUseCount + 1
end

function GuildData:getAllTreasures()
    return self.treasureList, self.treasureUseCount, self.treaCloseTime or 0
end

-- 设置自己是否已经投票了
function GuildData:setIsVotedOverthrow(b)
    self.isSelfVoteOverthrow = b
end

-- 自己是否已经投票了
function GuildData:checkIsVotedOverthrow()
    return self.isSelfVoteOverthrow
end

-- 返回是否在罢免中
function GuildData:isInOverthrow()
    local leaderData = self:getLeaderData()
    local isOnline = false
    if (leaderData) then
        isOnline = leaderData:getLoginStatus() ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE
    end
    return self:getOverthrowStartTime() ~= 0 and not isOnline
end

-- 发起罢免的时间点
function GuildData:setOverthrowStartTime(t)
    self.overthrowLeaderTime = t
end

-- 发起罢免的时间点
function GuildData:getOverthrowStartTime()
    return self.overthrowLeaderTime
end

function GuildData:getCustomTitles()
    return self.customTitles
end

function GuildData:updateCustomTitles(guildID, names)
    if guildID ~= self.ID then
        return
    end

    for _, new in ipairs(names) do
        local found = false
        for _, old in ipairs(self.customTitles) do
            if new.title == old.title then
                old.titleName = new.titleName
                found = true
                break
            end
        end

        if not found then
            table.insert(self.customTitles, new)
        end
    end
end

-- 罢免剩余时间
function GuildData:getOverthrowTimeRemaining()
    require "app.game.GameManager"
    local timeNow = GameManager:getNormalServerTime()
    local totalDuration = ConfigManager:getOverthrowVoteDuration() * 60
    local pastTime = timeNow - self:getOverthrowStartTime()
    local timeRemaining = totalDuration - pastTime
    return timeRemaining > 0 and timeRemaining or 0
end

-- 检查是否能够罢免
function GuildData:isAbleToOverthrow()
    if (self:checkIsVotedOverthrow()) then return false end

    local timeNow = GameManager:getNormalServerTime()
    local timeThresholdForNewMember = ConfigManager:getOverthrowOpenTimeForNewMember() * 60
    if (self.joinTime == nil or (self.joinTime ~= 0 and (timeNow - self.joinTime) < timeThresholdForNewMember)) then return false end

    -- 团长不能罢免自己
    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if (masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader) then 
        return false
    end

    -- 没有团长数据不能罢免
    local leaderData = self:getLeaderData()
    if (not leaderData) then return false end

    -- 根据角色决定团长里先后能罢免的规则
    local OverthrowConfigTime = 0
    if (masterTitle == PublicDefine.GuildTitle.GuildTitle_CoLeader or 
        masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader) then
        OverthrowConfigTime = ConfigManager:getOverthrowOfflineDurationForCoLeader() * 60
    else
        OverthrowConfigTime = ConfigManager:getOverthrowOfflineDurationForMemeber() * 60
    end
    if (leaderData:getLoginStatus() == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE and 
        timeNow - leaderData:getOfflineTime() >= OverthrowConfigTime) 
    then
        return true
    else
        return false
    end
end

function GuildData:changeLeader(oldLeaderPK, newLeaderPK)
    local oldLeaderData = self:getMemberDataForPK(oldLeaderPK)
    if (oldLeaderData) then
        oldLeaderData:setTitle(PublicDefine.GuildTitle.GuildTitle_ViceLeader)
    end
    local newLeaderData = self:getMemberDataForPK(newLeaderPK)
    if (newLeaderData) then
        newLeaderData:setTitle(PublicDefine.GuildTitle.GuildTitle_Leader)
    end
end

function GuildData:getLeaderData()
    for k, memberData in pairs(self.members) do 
        if(memberData.title == PublicDefine.GuildTitle.GuildTitle_Leader) then
            return memberData
        end
    end

    return nil
end

function GuildData:checkCanChangeTitle(isUp, oldTitle)
    local newTitle = 0
    if isUp then
        if oldTitle == PublicDefine.GuildTitle.GuildTitle_Member then
            newTitle = PublicDefine.GuildTitle.GuildTitle_CoLeader
        elseif oldTitle == PublicDefine.GuildTitle.GuildTitle_CoLeader then
            newTitle = PublicDefine.GuildTitle.GuildTitle_ViceLeader
        elseif oldTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader then
            newTitle = PublicDefine.GuildTitle.GuildTitle_Leader
        else
            return false, 0
        end
    else
        if oldTitle == PublicDefine.GuildTitle.GuildTitle_Member then
            return false, 0
        elseif oldTitle == PublicDefine.GuildTitle.GuildTitle_CoLeader then
            newTitle = PublicDefine.GuildTitle.GuildTitle_Member
        elseif oldTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader then
            newTitle = PublicDefine.GuildTitle.GuildTitle_CoLeader
        elseif oldTitle == PublicDefine.GuildTitle.GuildTitle_Leader then
            newTitle = PublicDefine.GuildTitle.GuildTitle_ViceLeader
        end
    end

    if newTitle == PublicDefine.GuildTitle.GuildTitle_Leader then
        return oldTitle ~= PublicDefine.GuildTitle.GuildTitle_Leader, 0
    elseif newTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader then
        local count = 0
        for k, v in ipairs(self.members) do
            if v.title == PublicDefine.GuildTitle.GuildTitle_ViceLeader then
                count = count + 1
            end
        end

        return count < 2, 2
    elseif newTitle == PublicDefine.GuildTitle.GuildTitle_CoLeader then
        local count = 0
        for k, v in ipairs(self.members) do
            if v.title == PublicDefine.GuildTitle.GuildTitle_CoLeader then
                count = count + 1
            end
        end

        local GameDataManager = require "app.game.GameDataManager"
        local totalNum = GameDataManager:getInstance():getGuildMemberConfigForLevel(self.techTotalLv)
        local maxNum = math.floor(totalNum/10)
        return count < maxNum, maxNum
    end

    return true, 0
end

-- 根据PK获取成员信息
function GuildData:getMemberDataForPK(PK)
    for k, memberData in pairs(self.members) do 
        if(memberData.PK == PK) then
            return memberData
        end
    end

    return nil
end

-- 获取头衔
function GuildData:getTitleForPK(PK)
    for k, memberData in pairs(self.members) do 
        if(memberData.PK == PK) then
            return memberData.title
        end
    end

    return PublicDefine.GuildTitle.GuildTitle_Member
end


--工会ID
function GuildData:getID()
    return self.ID
end

-- 获取成员数量
function GuildData:getMemberNum()
    return #self.members
end

--获取公会成员
function GuildData:getMember()
    return self.members
end

-- 获取公会排行
function GuildData:getRank()
    return self.rank
end

-- 获取公会名字
function GuildData:getName()
    if(self.name) then 
        -- add by zp CO-14453【改名】IOS玩家可以改名将名字换行竖名显示
        return ToolsUtil:replaceShowNickNameStr(self.name)
        -- return self.name
    else 
        return ""
    end
end

-- 修改公会排行
function GuildData:changeRank(data)
    if(self.ID == data.id) then
        self.rank = data.ranking
    end
end

-- 修改公告
function GuildData:changeNotice(data)
    self.notice = data.notice
end

function GuildData:getIconID()
    return self.iconID
end

-- 修改公会图标
function GuildData:changeIconID(iconID)
    self.iconID = iconID
end

-- 修改审核开关
function GuildData:changeJoinAudit(isOpen)
    self.isOpenJoinAudit = isOpen
end

-- 修改加入积分限制
function GuildData:changeScoreLmt(index)
    self.joinEquipScoreLmt = index
end

-- 修改公会贡献度
function GuildData:changeContib(contib)
    self.contib = contib
end

-- 更新新公会的公会贡献值
function GuildData:updateGuildTeamMedal(data)
    self.guildTeamMedal = data
end

-- 修改公会贡献度
function GuildData:changeName(name)
    self.name = name
    self.name = ToolsUtil:replaceShowNickNameStr(self.name)
    local str = LanguageManager:getInstance():getLocalString(1111113)
    Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_GUILD, str)
end

function GuildData:getContib()
    return self.contib 
end

function GuildData:getHasJoinReq()
    return self.hasJoinReq
end

-- 修改是否有新的申请加入
function GuildData:changeHasJoinReq(hasJoinReq)
    self.hasJoinReq = hasJoinReq
    if(hasJoinReq) then
        if(GameDataManager:getInstance():getMasterGuildTitle() == PublicDefine.GuildTitle.GuildTitle_Leader or 
           GameDataManager:getInstance():getMasterGuildTitle() == PublicDefine.GuildTitle.GuildTitle_CoLeader or
           GameDataManager:getInstance():getMasterGuildTitle() == PublicDefine.GuildTitle.GuildTitle_ViceLeader
        ) then
            local str = LanguageManager:getInstance():getLocalString(1110628)
            Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_GUILD, str)
        end
    end
end

-- 获取版本号
function GuildData:getVersion()
    return self.version
end

-- 修改版本号
function GuildData:changeVersion(version)
    self.version = version
end

-- 修改公会科技总等级
function GuildData:changeTotalTechLv(lv)
    self.techTotalLv = lv
end

-- 获取公会科技总等级
function GuildData:getTotalTechLv()
    return self.techTotalLv
end

-- 初始化申请列表
function GuildData:initApplyJoinList(data)
    self.applyJoinList = {}
    if(data and data.roles) then
        for _,v in pairs(data.roles) do 
            local joinData = {}
            joinData.PK = v.PK 
            joinData.lv = v.lv 
            joinData.faceDecodeID = v.faceDecodeID
            joinData.sex = v.sex 
            joinData.name = ToolsUtil:replaceShowNickNameStr(v.name)
            joinData.equipScore = v.equipScore
            joinData.reincarntionLv = v.reincarntionLv

            table.insert(self.applyJoinList, joinData)
        end
    end
end

-- 清空申请列表
function GuildData:clearApplyJoinList()
    self.applyJoinList = {}
end

-- 根据PK获取申请列表
function GuildData:getApplyJoinDataForPK(PK)
    for k,v in pairs(self.applyJoinList) do 
        if(v.PK == PK) then
            return v
        end
    end
    return nil
end

-- 移除申请加入列表
function GuildData:removeApplyJoinList(PK)
    for k,v in pairs(self.applyJoinList) do 
        if(v.PK == PK) then
            table.remove(self.applyJoinList, k)
            break
        end
    end
end

-- 修改成员权限
function GuildData:changeMemberTitle(data)
    local changeTitle = data.title

    local masterGuildTitle = GameDataManager:getInstance():getMasterGuildTitle()

    -- 如果新修改的为会长，就会把前面的会长状态修改为管理
    if(changeTitle == PublicDefine.GuildTitle.GuildTitle_Leader) then
        for k, memberData in pairs(self.members) do 
            if(memberData.title == PublicDefine.GuildTitle.GuildTitle_Leader) then
                memberData:setTitle(PublicDefine.GuildTitle.GuildTitle_ViceLeader)
                break
            end
        end
    end

    for k, memberData in pairs(self.members) do 
        if(tonumber(memberData.PK) == tonumber(data.targPK)) then
            memberData:setTitle(data.title)
            
            if(masterGuildTitle == PublicDefine.GuildTitle.GuildTitle_Leader
                or (data.PK == RoleDataManager:getMasterPK() and masterGuildTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader)) then
                local languageID = nil
                if(data.title == PublicDefine.GuildTitle.GuildTitle_Leader) then
                    languageID = 1110663   -- 你已将将公会转让给%s
                elseif(data.title == PublicDefine.GuildTitle.GuildTitle_ViceLeader) then
                    languageID = 1112901   -- 
                elseif(data.title == PublicDefine.GuildTitle.GuildTitle_CoLeader) then
                    languageID = 1110615   -- 
                elseif(data.title == PublicDefine.GuildTitle.GuildTitle_Member) then
                    languageID = 1110616
                end

                if(languageID) then
                    local you = nil
                    if(data.PK == RoleDataManager:getMasterPK()) then
                        UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(languageID), UI.TEXT_1170328, memberData.name))
                    else 
                        local targetMemberData = self:getMemberDataForPK(data.PK)
                        if(targetMemberData) then
                            you = AvalonUtil:serializeText("["..GameDataManager:getTitleStrForTitle(targetMemberData:getTitle()).."]"..targetMemberData:getName(), UI.FONT_COLOR_BLUE)
                        end
                    end

                    local chatMessageType = ChatMessageType.SYSTEM_GUILD
                    local link = LanguageManager:getInstance():getLocalString(languageID)
                    local content = MasterDataManager:makeNameLinkForGuildMemberData(memberData, chatMessageType)
                    if(you == nil)then
                        you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                    end
                    Game.ChatManager:getInstance():formartAndSendSystemMsg(chatMessageType, link, you, content)
                end
            else 
                -- 处理相关的表现需求
                local languageID = nil
                if(data.title == PublicDefine.GuildTitle.GuildTitle_Leader) then
                    languageID = 1110662   -- %s升职为会长
                    local changeData = self:getMemberDataForPK(data.PK)
                    if(changeData) then
                        local chatMessageType = ChatMessageType.SYSTEM_GUILD_MEMBER
                        local link = LanguageManager:getInstance():getLocalString(1110702)
                        local content1 = MasterDataManager:makeNameLinkForGuildMemberData(changeData, chatMessageType)
                        local content2 = MasterDataManager:makeNameLinkForGuildMemberData(memberData, chatMessageType)
                        Game.ChatManager:getInstance():formartAndSendSystemMsg(chatMessageType, link, content1, content2)
                    end
                    return
                elseif(data.title == PublicDefine.GuildTitle.GuildTitle_ViceLeader) then
                    languageID = 1112902   -- %s成为副会长
                elseif(data.title == PublicDefine.GuildTitle.GuildTitle_CoLeader) then
                    languageID = 1110660   -- %s升职为管理
                elseif(data.title == PublicDefine.GuildTitle.GuildTitle_Member) then
                    languageID = 1110661  --  %s降职为成员
                end

                if(languageID) then
                    local chatMessageType = ChatMessageType.SYSTEM_GUILD_MEMBER
                    local link = LanguageManager:getInstance():getLocalString(languageID)
                    local content2 = MasterDataManager:makeNameLinkForGuildMemberData(memberData, chatMessageType)
                    Game.ChatManager:getInstance():formartAndSendSystemMsg(chatMessageType, link, content2)
                end
            end
            break
        end
    end
end

-- 更新成员头衔
function GuildData:updateMemberData(data)
    for k, v in ipairs(data.datas) do 
        for k, memberData in pairs(self.members) do 
            if(tonumber(memberData.PK) == tonumber(v.PK)) then
                memberData:updateMember(v)
                print("GuildData:updateMemberData ", memberData.PK)
                break
            end
        end
    end
end

-- 添加购买图标
function GuildData:addBuyIconID(boughtIconID)
    if self.boughtIconID == nil then
        self.boughtIconID = {}
    end

    local found = false
    for k,v in pairs(self.boughtIconID) do
        if(v == boughtIconID) then 
            found = true
            break
        end
    end 

    if(found == false) then
        table.insert(self.boughtIconID, boughtIconID)
    end
end

-- 添加多个成员数据
function GuildData:addMembers(datas)    
    for k,v in ipairs(datas) do 
        local memberData = Data.GuildMemberData:create()
        memberData:initNet(v)
        table.insert(self.members, memberData)
    end
end

-- 添加单个成员
function GuildData:addMember(data)
    local memberData = Data.GuildMemberData:create()
    memberData:initNet(data.member)
    table.insert(self.members, memberData)

    return memberData
end

-- 踢出成员
function GuildData:kickMember(PK, targPK)
    local handleMemberData = self:getMemberDataForPK(PK)

    for k, memberData in pairs(self.members) do 
        if(memberData.PK == targPK) then
            if(handleMemberData) then
                if(GameDataManager:getInstance():getMasterPK() == PK) then
                    UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(1110618), memberData.name))
                end

                local handleTitleName = GameDataManager:getInstance():getTitleStrForTitle(handleMemberData.title)

                if(GameDataManager:getInstance():getMasterPK() == targPK) then
                    -- 你被 [会长]%s 踢出了公会%s
                    local chatMessageType = ChatMessageType.SYSTEM_GUILD
                    local link = LanguageManager:getInstance():getLocalString(1110582)
                    local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                    local content1 = Game.ChatManager:serializeTextByMessageType(handleTitleName, chatMessageType)
                    local content2 = MasterDataManager:makeNameLinkForGuildMemberData(handleMemberData, chatMessageType)
                    local content3 = Game.ChatManager:serializeTextByMessageType(self.name, chatMessageType)
                    Game.ChatManager:getInstance():formartAndSendSystemMsg(chatMessageType, link, you, content1, content2, content3)
                else 
                    local chatMessageType = ChatMessageType.SYSTEM_GUILD_MEMBER
                    local link = LanguageManager:getInstance():getLocalString(1110627)
                    local content1 = Game.ChatManager:serializeTextByMessageType(handleTitleName, chatMessageType)
                    local content2 = MasterDataManager:makeNameLinkForGuildMemberData(memberData, chatMessageType)
                    local content3 = MasterDataManager:makeNameLinkForGuildMemberData(handleMemberData, chatMessageType)
                    Game.ChatManager:getInstance():formartAndSendSystemMsg(chatMessageType, link, content2, content1, content3)
                end  
            end
            table.remove(self.members, k)
            break
        end
    end
end

function GuildData:getTitleByPk(PK)
    local handleMemberData = self:getMemberDataForPK(PK)
    if handleMemberData == nil then
        return
    end
    local handleTitleName = GameDataManager:getInstance():getTitleStrForTitle(handleMemberData.title)
    return handleTitleName
end

-- 退会成员
function GuildData:quitGuildMember(PK)
    for k, memberData in pairs(self.members) do 
        if(memberData.PK == PK) then
            if(GameDataManager:getInstance():getMasterPK() == PK) then
                -- local str = string.format(LanguageManager:getInstance():getLocalString(1110581), memberData.name)
                local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                local str =  UI.TEXT_1170328..string.format(LanguageManager:getInstance():getLocalString(1110626), self.name)
                UI.ScrollBar:createByText(str)
                
                local strxml = "%s "..string.format(LanguageManager:getInstance():getLocalString(1110626), self.name)               
                local chatMessageType = ChatMessageType.SYSTEM_GUILD
                Game.ChatManager:getInstance():formartAndSendSystemMsg(chatMessageType,strxml, you)
            else 

                local chatMessageType = ChatMessageType.SYSTEM_GUILD_MEMBER                
                local link = LanguageManager:getInstance():getLocalString(1110581)
                local content2 = MasterDataManager:makeNameLinkForGuildMemberData(memberData, chatMessageType)
                Game.ChatManager:getInstance():formartAndSendSystemMsg(chatMessageType, link, content2)
            end
            table.remove(self.members,k)
            break
        end
    end
end

function GuildData:refreshOneWrit(data)
    for k, v in ipairs(self.writList) do
        if v.ID == data.id then
            v.actTime = data.actTime
            break
        end
    end
end

function GuildData:getWritList()
    return self.writList
end

function GuildData:getWritListById(id)
    for k, v in ipairs(self.writList) do
        if v.ID == id then
            return v
        end
    end
end


function GuildData:isActiveWrit(writId)
    for k, v in ipairs(self.writList) do
        if v.ID == writId then
            local isActive = v.actTime + v.duration > GameManager:getNormalServerTime()
            return isActive, v
        end
    end
end