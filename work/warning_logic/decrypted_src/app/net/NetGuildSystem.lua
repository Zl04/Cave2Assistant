--[[
    登录相关的网络消息处理
]]--

Net = Net or {}
local NetGuildSystem = {}
Net.NetGuildSystem = NetGuildSystem

require "app.datas.GuildBoxDataManager"
require("app.datas.TeamDataManager")

local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require "utils.ProtobufUtil"
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

local DEBUG = false

local tempTable = {}

-- 请求公会日志
function NetGuildSystem:requestGuildLog(localVersion)
    -- required uint32 localVersion = 1;      // 客户端本地的版本号
    local messageData = {}
    messageData.localVersion = localVersion
    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_LOG_MESSAGE, messageData)
end

-- 请求公会信息
function NetGuildSystem:requestGuildInfo(guildID)
    -- required uint64 id = 1;                     // 工会ID
    local messageData = {}
    messageData.id = guildID
    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_SIMPLE_GUILD_INFO_MESSAGE, messageData)
end

-- 请求发布招募
function NetGuildSystem:requestPostRecruitment(message, publisher)
    -- required bytes content = 1;             // 聊天内容
    -- required PublicDefine.HeadRoleData publisher = 2;   // 发布者信息
    -- message HeadRoleData {
    --     required uint64 pk = 1;
    --     optional uint32 userID = 2;
    --     optional string nickName = 3;
    --     optional uint32 faceDecodeID = 4;//捏脸数据
    --     optional uint32 templateID = 5;//头盔 遗弃
    --     optional uint32 sex = 6; //性别
    --     optional uint32 roleLV = 7;// 等级
    --     repeated uint32 wearEquipId = 8;           //穿戴的装备ID（头盔肩膀胸甲）
    -- }
    local messageData = {}
    messageData.content = message
    messageData.publisher = publisher
    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_RECRUIT_MEMBER_MESSAGE, messageData)
end

-- 邀请入会
function NetGuildSystem:inviteToJoinGuild(targetPk, guildID, inviter)
    -- required uint64 targetPk = 1;               // 被邀请者
    -- required uint64 guildID = 2;                // 工会ID
    -- optional uint32 tk = 3;                     // 请求的唯一tk  客户端不赋值
    -- required PublicDefine.HeadRoleData inviter = 4; // 邀请者信息
    -- message HeadRoleData {
    --     required uint64 pk = 1;
    --     optional uint32 userID = 2;
    --     optional string nickName = 3;
    --     optional uint32 faceDecodeID = 4;//捏脸数据
    --     optional uint32 templateID = 5;//头盔 遗弃
    --     optional uint32 sex = 6; //性别
    --     optional uint32 roleLV = 7;// 等级
    --     repeated uint32 wearEquipId = 8;           //穿戴的装备ID（头盔肩膀胸甲）
    -- }

    -- 已经申请了就直接
    local guildData = MasterDataManager:getGuildData()
    if (guildData) then
        local applyData = guildData:getApplyJoinDataForPK(targetPk)
        if (applyData) then
            self:dealJoinReq(targetPk, true)
            return
        end
    else
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110668))
        return
    end

    -- 没有申请就发起邀请
    local messageData = {}
    messageData.targetPk = targetPk
    messageData.guildID = guildID
    messageData.inviter = inviter
    
    Net.Helper:sendMessage(NetMessageType.GUILD_INVITE_JOIN_GUILD_MESSAGE, messageData)
end

-- 应答邀请
function NetGuildSystem:replyInviteJoin(invitePk, guildID, tk)
    -- required uint64 invitePk = 2;               // 邀请者
    -- required uint64 guildID = 3;                // 工会ID
    -- required uint32 tk = 1;                     // 请求的唯一tk
    -- required uint32 equipScore = 4;             // 装备积分

    local score = 0
    local master = RoleDataManager:getMaster()
    if (master) then
        score = master:getCombatScore()
    end

    local messageData = {}
    messageData.invitePk = invitePk
    messageData.guildID = guildID
    messageData.tk = tk
    messageData.equipScore = score
    Net.Helper:sendMessage(NetMessageType.GUILD_ASW_INVITE_JOIN_GUILD_MESSAGE, messageData)
end

-- 请求清除已打开的宝箱
function NetGuildSystem:requestToClearAllDroppedBox(guildID, pk)
    if(DEBUG) then
        printInfo("NetGuildSystem:requestToClearAllDroppedBox ", guildID, pk)
    end
    local messageData = {}
    messageData.guildID = guildID
    messageData.pk = pk

    Net.Helper:sendMessage(NetMessageType.GUILD_BOX_REQUEST_CLEAR_DROPPED, messageData) 
end

-- 请求公会宝箱列表
function NetGuildSystem:requestBoxList(localMaxInstID)
    if(DEBUG) then
        printInfo("NetGuildSystem:requestBoxList ", localMaxInstID)
    end
    local messageData = {}
    messageData.localMaxInstID = localMaxInstID

    Net.Helper:sendMessage(NetMessageType.GUILD_BOX_REQUEST_BOX_LIST, messageData)
end

-- 请求打开宝箱
function NetGuildSystem:openGuildBox(guildID, pk, boxs)
    if(DEBUG) then
        printInfo("NetGuildSystem:openGuildBox ", guildID, pk, boxs)
    end
    local messageData = {}
    messageData.guildID = guildID
    messageData.pk = pk
    messageData.boxs = boxs

    Net.Helper:sendMessage(NetMessageType.GUILD_BOX_REQUEST_OPEN_BOX, messageData)
end

-- 创建公会
function NetGuildSystem:createGuild(PK, name, iconID)
    if(DEBUG) then
        printInfo("NetGuildSystem:createGuild ", PK, name, iconID)
    end
    local messageData = {}
    messageData.PK = PK
    messageData.name = name
    messageData.iconID = iconID

    Net.Helper:sendMessage(NetMessageType.GUILD_CREATE_GUILD, messageData)
end

-- 创建公会
function NetGuildSystem:renameGuild(PK, name)
    if(DEBUG) then
        printInfo("NetGuildSystem:renameGuild ", PK, name)
    end
    local messageData = {}
    messageData.PK = PK
    messageData.name = name

    Net.Helper:sendMessage(NetMessageType.GUILD_RENAME_GUILD, messageData)
end

-- 罢免
function NetGuildSystem:reqOverthrowMaster(isParticipatingElection)
    if(DEBUG) then
        printInfo("NetGuildSystem:reqOverthrowMaster ", isParticipatingElection)
    end
    local messageData = {}
    messageData.campaign = isParticipatingElection

    Net.Helper:sendMessage(NetMessageType.GUILD_OVERTHROW_MASTER, messageData)
end

-- 请求公会列表(CO)
function NetGuildSystem:reqGuildList(guildID, equipScore, keyWord, lastMaxGuildID, bucketIdx, bucketDis)
    if(DEBUG) then
        printInfo("NetGuildSystem:reqGuildList equipScore, keyWord, lastMaxGuildID, bucketIdx, bucketDis=", guildID, equipScore, keyWord, lastMaxGuildID, bucketIdx, bucketDis)
    end

    local messageData = {}

    if(equipScore) then
        messageData.equipScore = equipScore
    else
        messageData.equipScore = 0
    end

    if(guildID) then
        messageData.targGuildID = guildID
    end

    if(keyWord) then
        messageData.keyWord = keyWord
    end
    if(lastMaxGuildID) then
        messageData.lastMaxGuildID = lastMaxGuildID
    else
        messageData.lastMaxGuildID = 0
    end

    if(bucketIdx) then
        messageData.bucketIdx = bucketIdx
    end

    if(bucketDis) then
        messageData.bucketDis = bucketDis
    end

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_GUILD_LIST, messageData)
end


-- 请求(切换)进入公会场景(CO OS）
function NetGuildSystem:reqEnterGuildScene()
    if(DEBUG) then
        printInfo("NetGuildSystem:modifyNotice ")
    end

    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.GUILD_ENTER_GUILD_SCENE, messageData)
end

-- 请求自己公会信息(CO)
function NetGuildSystem:reqGuild(localVersion)
    if(DEBUG) then
        printInfo("NetGuildSystem:modifyNotice ", localVersion)
    end
    local messageData = {}
    messageData.localVersion = localVersion

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_GUILD, messageData)
end

-- 请求公会科技(CO)
function NetGuildSystem:reqGuildTech()
    if(DEBUG) then
        printInfo("NetGuildSystem:reqGuildTech ")
    end

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_GUILD_TECH)
end

-- -- 请求公会科技(CO)
-- function NetGuildSystem:addGuildTech(guildId,techID,addExp)
--     printInfo("NetGuildSystem:addGuildTech ",guildId,techID,addExp)

--     Net.Helper:sendMessage(NetMessageType.GUILD_ADD_GUILD_TECH)
-- end

-- 请求公会技能(CO)
function NetGuildSystem:reqGuildSkill()
    if(DEBUG) then
        printInfo("NetGuildSystem:reqGuildSkill ")
    end

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_GUILD_SKILL)
end

-- 修改公会公告(CO)
function NetGuildSystem:modifyNotice(PK, notice)
    if(DEBUG) then
        printInfo("NetGuildSystem:modifyNotice ", PK, notice)
    end

    local messageData = {}
    messageData.PK = PK
    messageData.notice = notice

    Net.Helper:sendMessage(NetMessageType.GUILD_MODIFY_NOTICE, messageData)
end

-- 修改公会加入审核(CO)
function NetGuildSystem:modifyJoinAudit(PK, isOpen)
    if(DEBUG) then
        printInfo("NetGuildSystem:modifyJoinAudit ", PK, isOpen)
    end

    local messageData = {}
    messageData.PK = PK
    messageData.isOpen = isOpen

    Net.Helper:sendMessage(NetMessageType.GUILD_MODIFY_JOIN_AUDIT, messageData)
end

-- 修改公会装备积分限制(CO)
function NetGuildSystem:modifyJoinEquipScoreLMT(PK, index)
    if(DEBUG) then
    printInfo("NetGuildSystem:modifyJoinEquipScoreLMT ", PK, index)
    end

    local messageData = {}
    messageData.PK = PK
    messageData.index = index

    Net.Helper:sendMessage(NetMessageType.GUILD_MODIFY_JOIN_EQUIP_SCORE_LMT, messageData)
end

-- 修改公会图标(CO)
function NetGuildSystem:modifyGuildIcon(PK, iconID)
    if(DEBUG) then
        printInfo("NetGuildSystem:modifyGuildIcon ", PK, iconID)
    end

    local messageData = {}
    messageData.PK = PK
    messageData.iconID = iconID

    Net.Helper:sendMessage(NetMessageType.GUILD_MODIFY_GUILD_ICON, messageData)
end

-- 修改成员头衔
function NetGuildSystem:modifyMemberTitle(PK, targPK, title)
    if(DEBUG) then
        printInfo("NetGuildSystem:modifyMemberTitle ", PK, targPK, title)
    end

    local messageData = {}
    messageData.PK = PK
    messageData.targPK = targPK
    messageData.title = title

    Net.Helper:sendMessage(NetMessageType.GUILD_MODIFY_MEMBER_TITLE, messageData)
end

-- 购买公会图标
function NetGuildSystem:buyGuildIcon(PK, iconID)
    if(DEBUG) then
        printInfo("NetGuildSystem:buyGuildIcon ",PK, iconID)
    end
    local messageData = {}
    messageData.PK = PK
    messageData.iconID = iconID

    Net.Helper:sendMessage(NetMessageType.GUILD_BUY_GUILD_ICON, messageData)
end

--  请求加入公会 （CS） 
function NetGuildSystem:reqJoinGuild(PK, guildID)
    if(DEBUG) then
        printInfo("NetGuildSystem:reqJoinGuild ", PK, guildID)
    end

    -- 检查是否有对应的公会邀请, 有就直接应答邀请并在缓存中去除掉
    local GameDataManager = require("app.game.GameDataManager")    
    local inviteData = GameDataManager:markGuildInviteApplied(guildID)
    if (inviteData) then
        local invitePk = inviteData.invitePk
        local tk = inviteData.tk
        self:replyInviteJoin(invitePk, guildID, tk)
        MasterDataManager:addJoinApply(guildID)
        return
    end

    local messageData = {}
    messageData.PK = PK
    messageData.ID = guildID

    table.insert(tempTable, guildID)

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_JOIN_GUILD, messageData)
end

-- 请求入会申请请求列表(CO) 空协议
function NetGuildSystem:reqJoinReqList()
    if(DEBUG) then
        printInfo("NetGuildSystem:reqJoinReqList ")
    end

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_JOIN_REQ_LIST)
end

-- 处理入会申请(CO)
function NetGuildSystem:dealJoinReq(PK, isAgree)
    if(DEBUG) then
        printInfo("NetGuildSystem:dealJoinReq ", PK, isAgree)
    end
    local messageData = {}
    messageData.PK = PK
    messageData.isAgree = isAgree

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_DEAL_JOIN_REQ, messageData)
    if(isAgree == false) then
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:removeApplyJoinList(PK)
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_JOIN_LIST_CHANGE)
    end 
end

-- 拒绝所有申请(CO)  空协议
function NetGuildSystem:cancelAllReq()
    if(DEBUG) then
        printInfo("NetGuildSystem:cancelAllReq ")
    end
    local guildData = MasterDataManager:getGuildData()
    if(guildData) then
        guildData:clearApplyJoinList()
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_JOIN_LIST_CHANGE)
    end
    Net.Helper:sendMessage(NetMessageType.GUILD_REFUSE_ALL_JOIN_REQ)
end

-- 踢掉会员
function NetGuildSystem:kickMember(PK, targPK)
    if(DEBUG) then
        printInfo("NetGuildSystem:dealJoinReq ", PK, targPK)
    end
    local messageData = {}
    messageData.PK = PK
    messageData.targPK = targPK

    Net.Helper:sendMessage(NetMessageType.GUILD_KICK_MEMBER, messageData)
end

-- 退出公会
function NetGuildSystem:quitGuild(PK)
    if(DEBUG) then
        printInfo("NetGuildSystem:dealJoinReq ", PK)
    end
    local messageData = {}
    messageData.PK = PK

    Net.Helper:sendMessage(NetMessageType.GUILD_QUIT_GUILD, messageData)
end 

-- 学习公会天赋技能
function NetGuildSystem:studyGuildSkill(npcID,skillGroupId,addExp)
    if(DEBUG) then
        printInfo("NetGuildSystem:studyGuildSkill ", npcID,skillGroupId,addExp)
    end

    if(addExp <= 0 ) then
        return
    end
    local messageData = {}
    messageData.npcID = npcID
    messageData.skillGroupId = skillGroupId
    messageData.addExp = addExp

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_STUDY_GUILD_SKILL, messageData)
end 

function NetGuildSystem:reqActivityCount()
    if(DEBUG) then
        printInfo("NetGuildSystem:reqActivityCount ")
    end
    local guildData = MasterDataManager:getGuildData()
    if(guildData == nil) then 
        return 
    end

    if(GameManager:getNowServerTime() - MasterDataManager:getPreGuildAccountSearchTime() > REQUEST_ACTIVITY_GUILD_CD_TIME) then 
        MasterDataManager:setPreGuildAccountSearchTime(GameManager:getNowServerTime())
        local messageData = {}
        messageData.guildID = guildData:getID()

        Net.Helper:sendMessage(NetMessageType.GUILD_REQ_ACTIVITY_COUNT, messageData)
    end
end 

function NetGuildSystem:reqGuildFight(bossIndex)
    if(DEBUG) then
        print("NetGuildSystem:reqGuildFight ", bossIndex)
    end
    local guildData = MasterDataManager:getGuildData()
    if(guildData == nil) then 
        return 
    end

    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()
    messageData.bossIndex = bossIndex

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_GUILD_BOSS_FIGHT, messageData)
end 

function NetGuildSystem:reqGuildBuyBuff()
    if(DEBUG) then
        print("NetGuildSystem:reqGuildBuyBuff ")
    end
    local guildData = MasterDataManager:getGuildData()
    if(guildData == nil) then 
        return 
    end
    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()
    print("NetGuildSystem:reqGuildBuyBuff ", messageData)

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_GUILD_BOSS_BUY_BUFF, messageData)
end 

function NetGuildSystem:reqGuildBossGetData()
    if(DEBUG) then
        print("NetGuildSystem:reqGuildGetData ")
    end
    local guildData = MasterDataManager:getGuildData()
    if(guildData == nil) then 
        return 
    end

    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()
    print("reqGuildBossGetData  messageData=", messageData)

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_GUILD_BOSS_GET_DATA, messageData)
end 

-- 许愿池许愿
function NetGuildSystem:reqGuildWish(type, npcID, content)
    if(DEBUG) then
        print("NetGuildSystem:reqGuildWish ")
    end

    local typeEnum = nil
    if type == 1 then
        typeEnum = "GuildWish_CopperCoin"
    elseif type == 2 then
        typeEnum = "GuildWish_SilverCoin"
    end

    if not typeEnum then
        print("NetGuildSystem:reqGuildWish type error", type)
        return
    end

    local messageData = {}
    messageData.type = typeEnum
    messageData.npcid = npcID
    if content then
        messageData.content = content
    end
    print("reqGuildWish  messageData=", messageData)

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_GUILD_WISH, messageData)
end 

-- 请求许愿总次数
function NetGuildSystem:reqGuildWishTotalTime()
    if(DEBUG) then
        print("NetGuildSystem:reqGuildWishTotalTime ")
    end

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_GUILD_WISH_TOTAL_TIME)
end 

function NetGuildSystem:reqGuildBuyPersonalBuff()
    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()
    print("reqGuildBuyPersonalBuff  messageData=", messageData)
    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_BUY_PERSONAL_BUF_MESSAGE, messageData)
end

-- 请求许愿列表
function NetGuildSystem:reqGuildWishList(listIdx)
    if(DEBUG) then
        print("NetGuildSystem:reqGuildWish ")
    end

    local messageData = {}
    messageData.index = listIdx
    print("reqGuildWish  messageData=", messageData)

    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_GUILD_WISH_LIST, messageData)
end 

-- 新公会的公会贡献请求
function NetGuildSystem:reqGuildTeamMedal()
    if(DEBUG) then
        print("NetGuildSystem:reqGuildTeamMedal ")
    end

    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_GUILD_TEAM_MEDAL, messageData)
end 

-- 公会职级名称自定义请求
function NetGuildSystem:reqGuildChangTitleName(pk, guildID, titles)
    if(DEBUG) then
        print("NetGuildSystem:reqGuildChangTitleName ")
    end

    local messageData = {}
    messageData.PK = pk
    messageData.guildID = guildID
    messageData.titles = titles
    Net.Helper:sendMessage(NetMessageType.GUILD_REQ_CHANGE_TITLE_NAME_MESSAGE, messageData)
end 

-- 请求购买令状
function NetGuildSystem:reqBuyWrit(guildID, writID)
    local messageData = {}
    messageData.writID = writID
    messageData.gid = guildID
    Net.Helper:sendMessage(NetMessageType.GUILD_BUY_WRIT_MESSAGE, messageData)
end

-- 公会消息处理
function NetGuildSystem:onGuildMessageHandler(no, data)
     printInfo("Net.NetGuildSystem:onGuildMessageHandler :no, data:",no)

    -- 创建公会成功返回
    if (no == NetMessageType.GUILD_GUILD_CREATION.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_GUILD_CREATION ")
            dump(data)
        end
        MasterDataManager:clearJoinApply()
        tempTable = {}
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.GUILD_APPLY_JOIN)

        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_CREATE_STATUS, true)

        -- 处理成功创建公会
        UI.TipsLayer:createGuildSuccess(data)
    -- 公会相关的操作反馈消息
    elseif (no == NetMessageType.GUILD_REPLY_OF_OPERATION.NO) then
        -- 公会处理失败的整体反馈操作
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_REPLY_OF_OPERATION ")
            dump(data)
        end

        local showDefaultText = true
        -- 处理自己需要关心的消息，其余都弹一个消息提示
        if(data.type == NetMessageType.GUILD_REQ_JOIN_GUILD.NO) then
            local guildID = tempTable[1]
            table.remove(tempTable, 1)
            -- printInfo("Guild back GUILD_REQ_JOIN_GUILD", guildID, data.result)
            MasterDataManager:removeRepeatHandleData(RepeatHandleType.GUILD_APPLY_JOIN, guildID)
            if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
                -- 申请加入成功
                MasterDataManager:addJoinApply(guildID)
                -- "已发出入会申请"
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110686))
                mvc.send(mvc.events.GuildApplySuccessful)
            end
            -- 发送申请成功
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_APPLY_RESULT, guildID)
        elseif(data.type == NetMessageType.GUILD_REFUSE_ALL_JOIN_REQ.NO) then
            if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
                -- 处理 “你拒绝了所有的入会申请” 文字显示
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110675))
            end
        elseif(data.type == NetMessageType.GUILD_REQ_STUDY_GUILD_SKILL.NO) then
            -- GameErrorManager:showError(data.result)
            
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_STUDY_SKILL_FAILS, data)
            mvc.send(mvc.events.GuildTechOrSkill_GuildSkillResult, data)
        elseif(data.type == NetMessageType.GUILD_KICK_MEMBER.NO) then

            MasterDataManager:removeRepeatHandleData(RepeatHandleType.GUILD_TICK_MEMBER, data.extend)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_TICK_MEMBER_FAILS, data.extend)
        elseif (data.type == NetMessageType.GUILD_CREATE_GUILD.NO) then 

            --  处理创建公会失败的逻辑处理
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_CREATE_STATUS, false)
        elseif (data.type == NetMessageType.GUILD_QUIT_GUILD.NO) then 

            -- 退出公会失败
            MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.GUILD_EXIT)

            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_EXIT_FAILS)
        elseif (data.type == NetMessageType.GUILD_BUY_GUILD_ICON.NO) then 

            -- 购买图标失败
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_BUY_GUILD_ICON, false, nil)
        elseif (data.type == NetMessageType.GUILD_ENTER_GUILD_SCENE.NO) then 
            -- 请求进入场景失败 
            -- printInfo("Guild back GUILD_ENTER_GUILD_SCENE", data.result)
            if(data.result ~= ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
                local command = Command.ControlCommand:create(true)
                command:initForTypeAndData(CommandType.CONTROL_MASTER_IDLE,data)
                SceneManager:getInstance():pushCommand(command)
            end
        elseif(data.type == NetMessageType.GUILD_REQ_GUILD_LIST.NO) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_GUILD_LIST_ERROR)
        elseif(data.type == NetMessageType.GUILD_RENAME_GUILD.NO) then
            if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
                UI.ScrollBar:createByTextID(1111718) -- "公会改名成功"
                MasterDataManager:_handleGuildChange()
            else
                -- 公会改名失败
                if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_RenameInCooldown")) then
                    UI.ScrollBar:createByTextID(1111719) -- "公会改名冷却中"
                    showDefaultText = false
                end
            end
        elseif(data.type == NetMessageType.GUILD_OVERTHROW_MASTER.NO) then
            if(DEBUG) then
                printInfo("NetMessageType.GUILD_OVERTHROW_MASTER", data)
            end
            if (data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
                if (ProtobufUtil:checkFieldIsInit(data, "extend")) then
                    MasterDataManager:setOverthrowStartTime(data.extend)
                end
                MasterDataManager:setIsVotedOverthrow(true)
                Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MEMBER_DATE_UPDATE)
                UI.ScrollBar:createByTextID(1111693) -- "已成功申请罢免会长"
                showDefaultText = false
            elseif (data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_LeaderIsInOverthrowProtect")) then
                local errorMsg = LanguageManager:getInstance():getLocalString(1110382)
                UI.ScrollBar:createByText(errorMsg .. "NGS" .. tostring(ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_LeaderIsInOverthrowProtect"))) -- "未知错误(离线时长不够, 不能罢免, 不应该发生)"
                showDefaultText = false
            end
        elseif(data.type == NetMessageType.GUILD_BOX_REQUEST_CLEAR_DROPPED.NO) then
            if(DEBUG) then
                printInfo("NetMessageType.GUILD_BOX_REQUEST_CLEAR_DROPPED", data)
            end
            if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
                GuildBoxDataManager:removeAllDroppedBox(true)
            end
        elseif(data.type == NetMessageType.GUILD_REQ_SIMPLE_GUILD_INFO_MESSAGE.NO) then
            if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
            else
                mvc.closePanel("GuildInfo", "GuildInfo")
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1113034) --[["获取公会信息失败, 可能公会已经解散"]])
                showDefaultText = false
            end
        elseif(data.type == NetMessageType.GUILD_REQ_RECRUIT_MEMBER_MESSAGE.NO) then
            if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112985) --[["招募信息发布成功"]])
            else
                local errorMsg = LanguageManager:getInstance():getLocalString(1110382)
                UI.ScrollBar:createByText(errorMsg .. "NGS" .. tostring(ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_LeaderIsInOverthrowProtect"))) -- "未知错误(离线时长不够, 不能罢免, 不应该发生)"
                showDefaultText = false
            end
        elseif(data.type == NetMessageType.GUILD_INVITE_JOIN_GUILD_MESSAGE.NO) then
            if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112986) --[["邀请发送成功"]])
                showDefaultText = false
            elseif(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_TargetOffline")) then
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1113027) --[["目标已下线"]])
                showDefaultText = false
            elseif(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_NeedUnlock")) then
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1113029) --[["该玩家还未解锁此功能"]])
                showDefaultText = false
            end
        elseif(data.type == NetMessageType.GUILD_ASW_INVITE_JOIN_GUILD_MESSAGE.NO) then
            local GameDataManager = require("app.game.GameDataManager")
            -- local isAnyRemoved = GameDataManager:removeAllAppliedGuildInvite()
            if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112987) --[["应答发送成功"]])
            else
            end
            MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.GUILD_APPLY_JOIN)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_APPLY_RESUME)
        elseif(data.type == NetMessageType.GUILD_REQ_LOG_MESSAGE.NO) then
            if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
            else
            end
        elseif (data.type == NetMessageType.GUILD_RSP_INDENTIFY_TREASURE_MESSAGE.NO) then
            if data.result ~= "ResultOfOperation_Ok" then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_TREASURE_CHANGE, data)
                if data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation", "ResultOfOperation_GuildAuctionInPrepare") then
                    UI.ScrollBar:createByTextID(UI.TEXT_1213916)
                    showDefaultText = false
                elseif data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation", "ResultOfOperation_DeclineNewbieIdentify") then
                    UI.ScrollBar:createByTextID(UI.TEXT_1213916)
                    showDefaultText = false
                end
            end
            UI.WaitingLayer:hideWaiting()
        elseif (data.type == NetMessageType.GUILD_RSP_AUCTION_BUY_MESSAGE.NO) then
            if data.result == "ResultOfOperation_Ok" then
            elseif data.result == "ResultOfOperation_IsBoughtOut" then
                UI.ScrollBar:createByTextID(UI.TEXT_1213903)
            elseif data.result == "ResultOfOperation_BidPriceIsLow" then
                UI.ScrollBar:createByTextID(UI.TEXT_1213904)
            elseif data.result == "ResultOfOperation_AuctionIsOver" then
                UI.ScrollBar:createByTextID(UI.TEXT_1213912)
            elseif data.result == "ResultOfOperation_GuildAuctionInPrepare" then
                UI.ScrollBar:createByTextID(UI.TEXT_1213914)
            else
                print("GUILD_RSP_AUCTION_BUY_MESSAGE err: " .. data.result)
            end
        end

        if (showDefaultText) then
            GameErrorManager:showError(data.result)
        end
    -- 返回公会列表结果(OC)
    elseif (no == NetMessageType.GUILD_ASW_GUILD_LIST.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_ASW_GUILD_LIST ")
            dump(data)
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_GUILD_LIST, data)
    -- 加载自己公会(SC)
    elseif (no == NetMessageType.GUILD_ASW_GUILD.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_ASW_GUILD ")
            dump(data)
        end
        MasterDataManager:clearJoinApply()
        tempTable = {}
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.GUILD_APPLY_JOIN)
        local oldHaveGuild = GameDataManager:getInstance():getIsJoinGuild()

        -- 处理自己公会的相关信息
        MasterDataManager:handleInitGuild(data)
        if(oldHaveGuild == false) then
            if(RoleDataManager:getMaster()) then
                TaskDataManager:triggerAcceptTask()
            end
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_LOAD_GUILD_END)
    -- 加载自己公会的科技数据(SC)
    elseif (no == NetMessageType.GUILD_ASW_GUILD_TECH.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:GUILD_ASW_GUILD_TECH ")
            dump(data)
        end
        
        local oldGuildTech = MasterDataManager:getGuildTech()
        if(oldGuildTech) then
            for k1,v1 in pairs(data.techs) do
                local isHave = false
                for k, v in pairs(oldGuildTech) do 
                    if(v.techID == v1.techID) then
                        isHave = true
                        if(v.curLv < v1.curLv) then
                            local str = string.format(LanguageManager:getInstance():getLocalString(1110632), ToolsUtil:getGuildTechText(v1.techID), v1.curLv)
                            Game.ChatManager:getInstance():sendSystemMsg(str, ChatMessageType.SYSTEM_GUILD_MEMBER)
                        end
                    end
                end
                if not isHave and v1.curLv > 1 then
                    local str = string.format(LanguageManager:getInstance():getLocalString(1110632), ToolsUtil:getGuildTechText(v1.techID), v1.curLv)
                    Game.ChatManager:getInstance():sendSystemMsg(str, ChatMessageType.SYSTEM_GUILD_MEMBER)
                end
            end
        end

        MasterDataManager:setGuildTech(data.techs)
    -- 加载自己公会天赋技能
    elseif (no == NetMessageType.GUILD_GUILD_SKILL.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:GUILD_GUILD_SKILL ")
            dump(data)
        end
        local skillData= {}
        if data.guildSkillList then
            for i = 1,#data.guildSkillList do
                local guildSkill = {}
                guildSkill.skillGroupId = data.guildSkillList[i].skillGroupId
                guildSkill.curExp = data.guildSkillList[i].curExp
                guildSkill.curLv = data.guildSkillList[i].curLv

                skillData[guildSkill.skillGroupId] = guildSkill
            end
        end
        MasterDataManager:setGuildSkill(skillData)
        Avalon.MessageCenter:notice(GameMessage.MC_DATA_GUILD_SKILL, skillData)
        -- 加载自己公会天赋技能
    elseif (no == NetMessageType.GUILD_RES_STUDY_GUILD_SKILL.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:GUILD_RES_STUDY_GUILD_SKILL ")
            dump(data)
        end
        local guildSkillList= MasterDataManager:getGuildSkill() or {}
        if guildSkillList then
            for i = 1,#data.guildSkillList do
                local guildSkill = {}
                guildSkill.skillGroupId = data.guildSkillList[i].skillGroupId
                guildSkill.curExp = data.guildSkillList[i].curExp
                guildSkill.curLv = data.guildSkillList[i].curLv

                if guildSkillList[guildSkill.skillGroupId] == nil then
                    if guildSkill.curLv >= 1 then
                        UI.ScrollBar:createByTextID(1110696)
                    end
                else
                    if guildSkill.curLv > guildSkillList[guildSkill.skillGroupId].curLv then
                        UI.ScrollBar:createByTextID(1110697)
                    end
                end

                guildSkillList[guildSkill.skillGroupId] = guildSkill
            end
        end
        MasterDataManager:setGuildSkill(guildSkillList)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_STUDY_SKILL, data.guildSkillList)
        mvc.send(mvc.events.GuildTechOrSkill_GuildSkillResult, data)
    -- 自己加入公会成功 （OC）加入公会成功，先收到Type_AswGuildMessage 再收到Type_GuildJoinMessage  空协议
    elseif (no == NetMessageType.GUILD_GUILD_JOIN.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_GUILD_JOIN ")
            dump(data)
        end
        MasterDataManager:clearJoinApply()
        tempTable = {}
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.GUILD_APPLY_JOIN)
        Avalon.MessageCenter:notice(GameMessage.MC_CHAT_REFRESH_TIPS)

        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            local str = LanguageManager:getInstance():getLocalString(1110630).." "..guildData.name
            local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
            Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_GUILD, str, you)
            TeamDataManager:refreshTeamGuild()
        end      

        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_JOIN_SUCCESS)
        mvc.send(mvc.events.GuildJoinSuccessful, guildData.ID)
    -- 他人加入我所在公会成功（OC）
    elseif (no == NetMessageType.GUILD_NEW_MEMBER.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_NEW_MEMBER ")
            dump(data)
        end
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            local memberData = guildData:addMember(data)

            local chatMessageType = ChatMessageType.SYSTEM_GUILD_MEMBER
            local link = LanguageManager:getInstance():getLocalString(1110630)
            local content2 = MasterDataManager:makeNameLinkForGuildMemberData(memberData, chatMessageType)
            Game.ChatManager:getInstance():formartAndSendSystemMsg(chatMessageType, link, content2)
            TeamDataManager:refreshTeamGuild()
        end      

        -- 发送某人加入公会成功的消息
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MEMBER_CHANGE)
    -- 有新的申请请求到公会（OC） 空协议
    elseif (no == NetMessageType.GUILD_NOTIFY_NEW_JOIN_REQ.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_NOTIFY_NEW_JOIN_REQ ")
            dump(data)
        end    
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:changeHasJoinReq(true)

            Net.NetGuildSystem:reqGuild(guildData.version)
        end       

        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_HAVE_JOIN_REQ)
    -- 回复入会申请请求列表(OC)
    elseif (no == NetMessageType.GUILD_ASW_JOIN_REQ_LIST.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_ASW_JOIN_REQ_LIST ")
            dump(data)
        end    
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:initApplyJoinList(data)
        end
        -- dump(guildData)       
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_JOIN_LIST_CHANGE)
    -- 没有加入请求
    elseif (no == NetMessageType.GUILD_NOTIFY_NO_JOIN_REQ.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_NOTIFY_NO_JOIN_REQ ")
            dump(data)
        end           

        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:changeHasJoinReq(false)
            guildData:clearApplyJoinList()
        end       
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_NO_JOIN_REQ)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_JOIN_LIST_CHANGE)
    -- 处理加入申请的反馈
    elseif (no == NetMessageType.GUILD_ASW_DEAL_JOIN_REQ.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_ASW_DEAL_JOIN_REQ ")
            dump(data)
        end
        local guildData = MasterDataManager:getGuildData()
        local joinChange = false
        -- 处理相关的状态
        if(guildData) then
            if(data.isAgree == true) then
                if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
                    local joinApplyData = guildData:getApplyJoinDataForPK(data.PK)
                    if(joinApplyData) then
                        local str = string.format(LanguageManager:getInstance():getLocalString(1110629), joinApplyData.name)
                        UI.ScrollBar:createByText(str)
                    end

                    guildData:removeApplyJoinList(data.PK)
                    joinChange = true
                else
                    GameErrorManager:showError(data.result)
                end
            else 
                if(data.result == ProtobufUtil:enum_id("GuildSystem.ResultOfOperation","ResultOfOperation_Ok")) then
                    local joinApplyData = guildData:getApplyJoinDataForPK(data.PK)
                    if(joinApplyData) then
                        -- 你拒绝了%s的入会申请
                        local str = string.format(LanguageManager:getInstance():getLocalString(1110693), joinApplyData.name)
                        UI.ScrollBar:createByText(str)

                        joinChange = true
                        guildData:removeApplyJoinList(data.PK)
                    end
                else
                    GameErrorManager:showError(data.result)
                end
            end
        end

        if(joinChange) then
            MasterDataManager:removeRepeatHandleData(RepeatHandleType.GUILD_DEAL_JOIN_REQ_OK, data.PK)
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_JOIN_LIST_CHANGE)
    --  加入申请被拒绝(OC)
    elseif (no == NetMessageType.GUILD_JOIN_REQ_REFUSED.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_JOIN_REQ_REFUSED ")
            dump(data)
        end    

        MasterDataManager:removeJoinApply(data.guildID)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_APPLY_RESUME)
    -- 修改公会信息
    elseif (no == NetMessageType.GUILD_MODIFY_NOTICE.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_MODIFY_NOTICE ")
            dump(data)
        end    
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:changeNotice(data)
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MODITY_NOTICE)
    -- 修改加入审核机制
    elseif (no == NetMessageType.GUILD_MODIFY_JOIN_AUDIT.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_MODIFY_JOIN_AUDIT ")
            dump(data)
        end    
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:changeJoinAudit(data.isOpen)
        end   
        
        if(data.PK ~= 0) then
            if(data.isOpen) then
                -- 申请审核打开   
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110689))
            else
                -- 申请审核关闭 
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110690))
            end
        end
        
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MODIFY_JOIN_AUDIT)
    -- 修改加入积分限制
    elseif (no == NetMessageType.GUILD_MODIFY_JOIN_EQUIP_SCORE_LMT.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_MODIFY_JOIN_EQUIP_SCORE_LMT ")
            dump(data)
        end    
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:changeScoreLmt(data.index)

            if(data.PK ~= 0) then
                -- 评分限制修改为%d以上
                local score = tonumber(GameDataManager:getInstance():getGuildEquipScoreForLmt(data.index))
                UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(1110691), score))
            end
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MODIFY_JOIN_EQUIP_SCORE_LMT)
    -- 修改公会图标
    elseif (no == NetMessageType.GUILD_MODIFY_GUILD_ICON.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_MODIFY_GUILD_ICON ")
            dump(data)
        end    
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:changeIconID(data.iconID)
        end
        -- TODO 这里不用刷新，本身都是自己选择的图标
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MODITY_GUILD_ICON)
    -- 更新公会成员数据
    elseif (no == NetMessageType.GUILD_UPDATE_MEMBER_DATA.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_UPDATE_MEMBER_DATA ")
            dump(data)
        end    
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:updateMemberData(data)
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MEMBER_DATE_UPDATE)

        -- 刷新城镇标志
        self:refreshGuildNewJoin()
    -- 修改公会成员权限
    elseif (no == NetMessageType.GUILD_MODIFY_MEMBER_TITLE.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_MODIFY_MEMBER_TITLE ")
            dump(data)
        end

        if((data.title == PublicDefine.GuildTitle.GuildTitle_Leader or 
            data.title == PublicDefine.GuildTitle.GuildTitle_ViceLeader)and 
           data.PK == GameDataManager:getInstance():getMasterPK()
        ) then
            MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.GUILD_LEADER_TILE_TRANSFER)
        end

        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:changeMemberTitle(data)
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MODITY_MEMBER_TITILE)
        self:refreshGuildNewJoin()
    -- 购买公会图标
    elseif (no == NetMessageType.GUILD_BUY_GUILD_ICON.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_BUY_GUILD_ICON ")
            dump(data)
        end    
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:addBuyIconID(data.iconID)
            -- 购买成功
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110688))
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_BUY_GUILD_ICON, true, data)
    -- 踢出成员
    elseif (no == NetMessageType.GUILD_KICK_MEMBER.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_KICK_MEMBER ")
            dump(data)
        end    
        MasterDataManager:removeRepeatHandleData(RepeatHandleType.GUILD_TICK_MEMBER, data.targPK)
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:kickMember(data.PK, data.targPK)
        end

        if(GameDataManager:getInstance():getMasterPK() == data.targPK ) then
            -- 清理公会任务
            TaskDataManager:clearGuildTask()
            MasterDataManager:handleClearActivityGuildCount()
            MasterDataManager:clearGuildData()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_QUIT_GUILD)
        else
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MEMBER_CHANGE)
        end
        TeamDataManager:refreshTeamGuild(true)
    -- 退会
    elseif (no == NetMessageType.GUILD_QUIT_GUILD.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_QUIT_GUILD ")
            dump(data)
        end
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.GUILD_EXIT)
        -- 处理退会逻辑处理
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:quitGuildMember(data.PK)
        end    
        
        if(GameDataManager:getInstance():getMasterPK() == data.PK) then
            Avalon.MessageCenter:notice(GameMessage.MC_CHAT_REFRESH_TIPS)
            -- 清理公会任务
            TaskDataManager:clearGuildTask()
            MasterDataManager:handleClearActivityGuildCount()
            MasterDataManager:clearJoinApply()
            tempTable = {}
            MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.GUILD_APPLY_JOIN)
            MasterDataManager:clearGuildData()
            GuildBoxDataManager:clear()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_QUIT_GUILD)
        else
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MEMBER_CHANGE)
        end
        TeamDataManager:refreshTeamGuild(true)

    --  更新公会图标
    elseif (no == NetMessageType.GUILD_LOAD_GUILD_ICON.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_LOAD_GUILD_ICON ")
            dump(data)
        end 
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            -- 同步购买的图标
            for k,iconID in pairs(data.ids) do
                guildData:addBuyIconID(iconID)
            end
        end

    --  更新公会信息(OC)
    elseif (no == NetMessageType.GUILD_UPDATE_GUILD_DATA.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_UPDATE_GUILD_DATA ")
            dump(data)
        end 
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:changeTotalTechLv(data.techLv)

            if(data.iconID ~= 0 and ProtobufUtil:checkFieldIsInit(data, "iconID")) then
                guildData:changeIconID(data.iconID)

                Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MODITY_GUILD_ICON)
            end

            if(ProtobufUtil:checkFieldIsInit(data, "isOpenJoinAudit")) then
                guildData:changeJoinAudit(data.isOpenJoinAudit)
                Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MODIFY_JOIN_AUDIT)
            end

            if(ProtobufUtil:checkFieldIsInit(data, "joinEquipScoreLmt")) then
                guildData:changeScoreLmt(data.joinEquipScoreLmt)
                Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MODIFY_JOIN_EQUIP_SCORE_LMT)
            end

            -- 修改公会贡献度
            if(ProtobufUtil:checkFieldIsInit(data, "contib")) then
                guildData:changeContib(data.contib)
                Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_CONTIB_CHANGE)
            end

            -- 修改新公会的公会贡献
            if(ProtobufUtil:checkFieldIsInit(data, "guildTeamMedal")) then
                guildData:updateGuildTeamMedal(data.guildTeamMedal)
                Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_CONTIB_CHANGE)
            end

            -- 修改新公会的公会贡献
            if(ProtobufUtil:checkFieldIsInit(data, "createTime")) then
                guildData:setCreateTime(data.createTime)
            end

            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_INFO_UPDATE)
        end       
        
    --  更新版本信息(OC)
    elseif (no == NetMessageType.GUILD_UPDATE_GUILD_DATA_VERSION.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_UPDATE_GUILD_DATA_VERSION ")
            dump(data)
        end 
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            if(guildData:getVersion() ~= data.version) then
                guildData:changeVersion(data.version)
            end
        end        

        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_REFRESH_END)

    elseif (no == NetMessageType.GUILD_UPDATE_GUILD_NAME.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_UPDATE_GUILD_NAME ")
            dump(data)
        end 

        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            guildData:changeName(data.name)
        end    

        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_REFRESH_NAME)
    elseif (no == NetMessageType.GUILD_CHANGE_GUILD_ID.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_CHANGE_GUILD_ID ")
            dump(data)
        end 
        
        RoleDataManager:handleChangeGuild(data)
    -- 通知活动计数信息
    elseif (no == NetMessageType.GUILD_RESPONSE_ACTIVITY_COUNT_INFO.NO) then
        -- 通知活动技术统计
        MasterDataManager:handleActivityGuildCount(data)
        -- if(data.isReq) then 
        --     -- 通知页面有刷新
        -- end

        MasterDataManager:setPreGuildAccountSearchTime(GameManager:getNowServerTime())
        Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_REFRESH, true)
        -- 通知活动计数信息
    elseif (no == NetMessageType.GUILD_OVERTHROW_MASTER_RESP.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_OVERTHROW_MASTER_RESP ")
            dump(data)
        end 

        -- 改变社长并且刷新界面
        local oldLeaderPK = data.orgLeader
        local newLeaderPK = data.curLeader
        local guildData = MasterDataManager:getGuildData()
        if (guildData and oldLeaderPK and newLeaderPK and oldLeaderPK ~= newLeaderPK) then
            guildData:changeLeader(oldLeaderPK, newLeaderPK)
            local oldMemberData = guildData:getMemberDataForPK(oldLeaderPK)
            local newMemberData = guildData:getMemberDataForPK(newLeaderPK)
            if (oldMemberData and newMemberData) then
                local formatString = LanguageManager:getInstance():getLocalString(1111697)
                -- UI.ScrollBar:createByText(string.format(formatString, oldMemberData:getName(), newMemberData:getName()))
                Game.ChatManager:getInstance():sendSystemMsg(string.format(formatString, oldMemberData:getName(), newMemberData:getName()), ChatMessageType.SYSTEM_MESSAGE)
            end
        end
        guildData:setOverthrowStartTime(0) -- 消除罢免状态
        MasterDataManager:setIsVotedOverthrow(false) -- 消除投票状态
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_QUIT_GUILD)
        self:refreshGuildNewJoin()
    elseif (no == NetMessageType.GUILD_OVERTHROW_START.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_OVERTHROW_START ")
            dump(data)
        end
        local guildData = MasterDataManager:getGuildData()
        guildData:setOverthrowStartTime(data.overthrowLeaderTime) -- 更新罢免时间
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_MEMBER_DATE_UPDATE)
    elseif (no == NetMessageType.GUILD_BOX_NEW_BOX.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_BOX_NEW_BOX ")
            dump(data)
        end
        GuildBoxDataManager:newBoxArrive(data, true)
    elseif (no == NetMessageType.GUILD_BOX_RESPONSE_BOX_LIST.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_BOX_RESPONSE_BOX_LIST ")
            dump(data)
        end
        GuildBoxDataManager:initNet(data)
    elseif (no == NetMessageType.GUILD_BOX_RESPONSE_OPEN_BOX.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_BOX_RESPONSE_OPEN_BOX ")
            dump(data)
        end
        GuildBoxDataManager:updateBoxOpenStatus(data)
    elseif (no == NetMessageType.GUILD_BOX_REMOVE_BOX.NO) then
        if(DEBUG) then
            printInfo("NetGuildSystem:onGuildMessageHandler  GUILD_BOX_REMOVE_BOX ")
            dump(data)
        end
        GuildBoxDataManager:removeBoxes(data, true)
    -- OS SC 工会Boss请求战斗
    elseif (no == NetMessageType.GUILD_RESPONSE_GUILD_BOSS_FIGHT.NO) then
        -- print("GUILD_RESPONSE_GUILD_BOSS_FIGHT", data)
        -- if(data.err ~= ProtobufUtil:enum_id("GuildBossErr", "GuildBossErr_OK")) then 
        --     mvc.guildModel:handleGuildBossFight(data)
        -- end
        -- 发送请求战斗的结果
        mvc.send(mvc.events.Guild_SelectFloor_Challenge_Result, data)
    --  OS SC 工会Boss购买Buff
    elseif (no == NetMessageType.GUILD_RESPONSE_GUILD_BOSS_BUY_BUFF.NO) then
        -- print("GUILD_RESPONSE_GUILD_BOSS_BUY_BUFF", data)
        if(data.err == "GuildBossErr_OK") then 
            mvc.guildModel:handleBuyBuff(data)
        end 
        -- 发送请求战斗的结果
        mvc.send(mvc.events.Guild_SelectFloor_Buy_Buff_Result, data)
    --  OS SC 工会Boss获取消息
    elseif (no == NetMessageType.GUILD_RESPONSE_GUILD_BOSS_GET_DATA.NO) then
        -- print("GUILD_RESPONSE_GUILD_BOSS_GET_DATA", data)
        mvc.guildModel:initGuildBossData(data)
        
        -- 处理NPC的刷新处理
  --       local command = Command.ControlCommand:create(true)
  --       command:initForTypeAndData(CommandType.CONTROL_REFRESH_ALL_GUILD_BOSS, data)
		-- SceneManager:getInstance():pushCommand(command)
        
        -- 通知数据信息修改
        mvc.send(mvc.events.Guild_SelectFloor_Get_Data_Result, data)
    --  SC OS SO 通知消息
    elseif (no == NetMessageType.GUILD_NOTICE_GUILD_BOSS.NO) then
        -- print("GUILD_NOTICE_GUILD_BOSS", data)
        -- 结算消息
        if(ProtobufUtil:checkFieldIsInit(data, "settleMsg")) then
            GameDataManager:getInstance():setGuildBossRewardData(data.settleMsg)
        end
        -- 挑战次数
        if(ProtobufUtil:checkFieldIsInit(data, "fightNumMsg")) then
            mvc.guildModel:handleFightNum(data.fightNumMsg)
        end
        -- 单个boss信息的同步 
        if(ProtobufUtil:checkFieldIsInit(data, "oneBossMsg")) then
            mvc.guildModel:handleOneBossData(data.oneBossMsg)

            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_REFRESH_GUILD_BOSS_STATUS)
            SceneManager:getInstance():pushCommand(command)
        end

        if(ProtobufUtil:checkFieldIsInit(data, "beforeSceneMsg")) then
            mvc.guildModel:handleBeforeMsg(data.beforeSceneMsg)
        end

        if(ProtobufUtil:checkFieldIsInit(data, "fightBossMsg")) then
            mvc.guildModel:handleUpdataFighting(data.fightBossMsg)
        end

        if(ProtobufUtil:checkFieldIsInit(data, "actBuffMsg")) then
            mvc.guildModel:handleBuyBuff(data.actBuffMsg)
        end

        mvc.send(mvc.events.Guild_SelectFloor_Data_Update, data)
    elseif (no == NetMessageType.GUILD_RESPONSE_GUILD_WISH.NO) then
        if not data.issuccess then
            print("GUILD_RESPONSE_GUILD_WISH err")
            return
        end

        mvc.wishPoolModel:updateWishData(data)

        if(ProtobufUtil:checkFieldIsInit(data, "iscrit")) then
            data.iscrit = data.iscrit
        else
            data.iscrit = false
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_WISHPOOL_UPDATE_DATA, data)
    elseif (no == NetMessageType.GUILD_RESPONSE_GUILD_WISH_COUNT.NO) then
        mvc.wishPoolModel:updateWishCount(data)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_WISHPOOL_UPDATE_COUNT)
    elseif (no == NetMessageType.GUILD_RESPONSE_GUILD_WISH_LIST.NO) then
        mvc.wishPoolModel:updateWishList(data)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_WISHPOOL_UPDATE_LIST)
    elseif (no == NetMessageType.GUILD_RESPONSE_GUILD_WISH_TOTAL_TIME.NO) then
        mvc.wishPoolModel:updateWishTotalTime(data.totaltimes)
        if(ProtobufUtil:checkFieldIsInit(data, "isreset")) then
            if data.isreset then
                local cfgBoxID = mvc.wishPoolModel:getGuildBoxID()
                local guildBox = ConfigManager:getGuildBoxByID(cfgBoxID)
                local guildBoxName = LanguageManager:getInstance():getLocalString(guildBox.boxName)
                local formatedStr = string.format(UI.TEXT_1213277, guildBoxName)
                Game.ChatManager:getInstance():sendSystemMsg(formatedStr, ChatMessageType.SYSTEM_GUILD)
            end
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_WISHPOOL_UPDATE_TOTAL)
    elseif (no == NetMessageType.GUILD_ASW_SIMPLE_GUILD_INFO_MESSAGE.NO) then
        -- required uint64 id = 1;
        -- required string name = 2;
        -- required string leaderName = 3;
        -- required uint32 curMemberNum = 4;
        -- required uint32 lv = 5;
        -- optional string notice = 6;
        -- required GuildRelationship rs = 7;
        -- required uint32 iconID = 8;

        mvc.send(mvc.events.GUILD_ASW_SIMPLE_GUILD_INFO_MESSAGE, data)
    elseif (no == NetMessageType.GUILD_INVITE_JOIN_GUILD_MESSAGE.NO) then
        -- required uint64 targetPk = 1;               // 被邀请者
        -- required uint64 guildID = 2;                // 工会ID
        -- optional uint32 tk = 3;                     // 请求的唯一tk  客户端不赋值
        -- required PublicDefine.HeadRoleData inviter = 4; // 邀请者信息
        -- optional string guildName = 5;              // 工会名字

        -- 聊天界面展现邀请信息
        local masterPK = RoleDataManager:getMasterPK()
        if (masterPK == data.targetPk and ProtobufUtil:checkFieldIsInit(data, "tk")) then
            local guildName = ""
            if (ProtobufUtil:checkFieldIsInit(data, "guildName")) then
                guildName = data.guildName
            end
            local masterHeadData = MasterDataManager:getMasterHeadData()
            local guildData = {
                guildID = data.guildID,
                tk = data.tk,
                name = guildName
            }
            Game.ChatManager:getInstance():sendGuildInvite(data.inviter, masterHeadData, guildData)
            local GameDataManager = require("app.game.GameDataManager")
            GameDataManager:addGuildInvite({
                invitePk = data.inviter.pk,
                guildID = data.guildID,
                tk = data.tk
            })
        end
    elseif (no == NetMessageType.GUILD_ASW_LOG_MESSAGE.NO) then
        -- required uint32 curVersion = 1;         // 服务器当前版本号
        -- repeated LogContent logs = 2;           // 从客户端本地版本号到服务器当前版本号间的日志
        -- message LogContent {
        --     required uint32 type = 1;               // 类型
        --     required bytes content = 2;             // 内容 参见LogType及Log_XXX
        --     required uint32 gameTime = 3;           // 生成时间
        -- }
        mvc.send(mvc.events.GUILD_ASW_LOG_MESSAGE, data)
    elseif (no == NetMessageType.GUILD_RECRUIT_MEMBER_MESSAGE.NO) then
        -- required string guildName = 1;
        -- required uint64 guildID = 2;
        -- required string content = 3;                        // 内容 (ReqRecruitMemberMessage)
        -- required PublicDefine.HeadRoleData publisher = 4;   // 发布者信息
        Game.ChatManager:getInstance():sendGuildRecruit(data.publisher, data.guildName, data.guildID, data.content)
    elseif (no == NetMessageType.GUILD_INVITE_JOIN_GUILD_FAILED_MESSAGE.NO) then
        -- required uint32 residualCount = 1;          // 剩余次数
        -- required uint32 residualCD = 2;             // 剩余冷却时间(秒)
        if (data.residualCount == 0) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1113035)) --[["招募次数已用光"]]
        elseif (data.residualCD ~= 0) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1113036)) --[["招募还在CD中"]]
        end
    elseif (no == NetMessageType.GUILD_UPDATE_OTHER_HEROS_GUILD_NAME.NO) then
        -- required uint64 heropk = 1;		 	// 玩家PK
        -- required string guildname = 2;		// 公会名字
        local heroData = RoleDataManager:getHeroDataForPK(data.heropk)
        if (heroData) then
            local inputData = {
                PK = heroData:getPK(),
                guildID = heroData:getGuildID(),
                guildName = data.guildname
            }
            RoleDataManager:handleChangeGuild(inputData)
        end
    elseif (no == NetMessageType.GUILD_RESPONSE_GUILD_TEAM_MEDAL.NO) then
        local guildData = MasterDataManager:getGuildData()
        if guildData then
            guildData:updateGuildTeamMedal(data.guildTeamMedal)
            Avalon.MessageCenter:notice(GameMessage.MC_DATA_CHNAGE_GUILD_MEDAL)
        end
    elseif(no ==  NetMessageType.GUILD_BUY_PERSONAL_BUF_RESULT_MESSAGE.NO) then
          -- print("GUILD_RESPONSE_GUILD_BOSS_BUY_BUFF", data)
        if(data.err == "GuildBossErr_OK") then 
            mvc.guildModel:handleBuyPersonalBuff(true)
        end 
        mvc.send(mvc.events.Guild_SelectFloor_Buy_Personal_Buff_Result, data)
    elseif (no == NetMessageType.GUILD_ASW_CHANGE_TITLE_NAME_MESSAGE.NO) then
        -- 其他人公会职级名字自定义之后，在这里同步
        local guildData = MasterDataManager:getGuildData()
        if guildData then
            guildData:updateCustomTitles(data.guildID, data.titles)
        end
    elseif (no == NetMessageType.GUILD_REQ_CHANGE_TITLE_NAME_MESSAGE.NO) then
        -- 接收到广播
        local guildData = MasterDataManager:getGuildData()
        if guildData then
            guildData:updateCustomTitles(data.guildID, data.titles)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_CHANGE_TITLE_NAME, data.guildID, data.titles)
        end
    elseif (no == NetMessageType.GUILD_NTY_WRIT_MESSAGE.NO) then
        -- print("---GUILD_NTY_WRIT_MESSAGE--data------", data)
        UI.WaitingLayer:hideWaiting()
        local guildData = MasterDataManager:getGuildData()
        --单个令状增量数据刷新
        if guildData and data.gid == guildData:getID()then
            guildData:refreshOneWrit(data.writ)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_WRIT_CHANGE, data.writ.id)
            local writData = guildData:getWritListById(data.writ.id)
            local member = guildData:getMemberDataForPK(data.pk)

            local handleTitleName = GameDataManager:getInstance():getTitleStrForTitle(member.title)
            local chatMessageType = ChatMessageType.SYSTEM_GUILD
            local content1 = Game.ChatManager:serializeTextByMessageType(handleTitleName, chatMessageType)
            local content2 = MasterDataManager:makeNameLinkForGuildMemberData(member, chatMessageType)
            local content3 = Game.ChatManager:serializeTextByMessageType(writData.name, chatMessageType)
            Game.ChatManager:getInstance():formartAndSendSystemMsg(chatMessageType, UI.TEXT_1213960, content1, content2, content3)
        end
    elseif (no == NetMessageType.GUILD_RSP_BUY_WRIT_MESSAGE.NO) then
        -- print("---GUILD_RSP_BUY_WRIT_MESSAGE--data------", data)
        UI.WaitingLayer:hideWaiting()
        if data.err == "ResultOfOperation_Ok" then
            UI.ScrollBar:createByText(UI.TEXT_1213950)
            local guildData = MasterDataManager:getGuildData()
            guildData:refreshOneWrit(data.writ)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_WRIT_CHANGE, data.writ.id)
            
            local writData = guildData:getWritListById(data.writ.id)
            local member = guildData:getMemberDataForPK(GameDataManager:getInstance():getMasterPK())

            local handleTitleName = GameDataManager:getInstance():getTitleStrForTitle(member.title)
            local chatMessageType = ChatMessageType.SYSTEM_GUILD
            local content1 = Game.ChatManager:serializeTextByMessageType(handleTitleName, chatMessageType)
            local content2 = MasterDataManager:makeNameLinkForGuildMemberData(member, chatMessageType)
            local content3 = Game.ChatManager:serializeTextByMessageType(writData.name, chatMessageType)
            Game.ChatManager:getInstance():formartAndSendSystemMsg(chatMessageType, UI.TEXT_1213960, content1, content2, content3)
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("GuildSystem.ResultOfOperation", data.err))
        end
    elseif (no == NetMessageType.GUILD_RSP_ALL_TREASURE_MESSAGE.NO) then
        if data.result == "ResultOfOperation_Ok" then
            local guildData = MasterDataManager:getGuildData()
            guildData:initTreasures(data)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_TREASURE_CHANGE)
        end
        UI.WaitingLayer:hideWaiting()
    elseif (no == NetMessageType.GUILD_RSP_INDENTIFY_TREASURE_MESSAGE.NO) then
        if data.result == "ResultOfOperation_Ok" then
            local guildData = MasterDataManager:getGuildData()
            guildData:setTreasure(data)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_TREASURE_CHANGE, data)
        end
        UI.WaitingLayer:hideWaiting()
    elseif (no == NetMessageType.GUILD_RSP_AUCTION_INFO_MESSAGE.NO) then
        -- 公会拍卖主页内容返回
        mvc.guildAuctionModel:updateAuctionInfo(data)

        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_AUCTION_INFO_UPDATE)
        UI.WaitingLayer:hideWaiting()
    elseif (no == NetMessageType.GUILD_RSP_AUCTION_BUY_MESSAGE.NO) then
        -- 公会拍卖出价后数据返回
        -- 这里只处理结果提示，
        -- 如果操作成功，数据同步交由 GUILD_RSP_AUCTION_BUY_SYNC_MESSAGE 中再去同步全量数据
        -- 如果操作失败，并且dataVersion不一致，则直接去同步全量数据
        if data.result == "ResultOfOperation_Ok" then
            UI.ScrollBar:createByTextID(UI.TEXT_1213905)
        elseif data.result == "ResultOfOperation_IsBoughtOut" then
            UI.ScrollBar:createByTextID(UI.TEXT_1213903)
        elseif data.result == "ResultOfOperation_BidPriceIsLow" then
            UI.ScrollBar:createByTextID(UI.TEXT_1213904)
        elseif data.result == "ResultOfOperation_AuctionIsOver" then
            UI.ScrollBar:createByTextID(UI.TEXT_1213912)
        elseif data.result == "ResultOfOperation_GuildAuctionInPrepare" then
            UI.ScrollBar:createByTextID(UI.TEXT_1213914)
        else
            print("GUILD_RSP_AUCTION_BUY_MESSAGE err: " .. data.result)
        end

        local curDataVersion = mvc.guildAuctionModel:getDataVersion()
        if data.result ~= "ResultOfOperation_Ok" and data.dataVersion ~= curDataVersion then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_AUCTION_BUY_UPDATE)
        end

        UI.WaitingLayer:hideWaiting()
    elseif (no == NetMessageType.GUILD_RSP_AUCTION_BUY_SYNC_MESSAGE.NO) then
        -- 公会拍卖其他人出价后数据广播
        local curDataVersion = mvc.guildAuctionModel:getDataVersion()
        if data.dataVersion ~= curDataVersion then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_AUCTION_BUY_SYNC)
        end

        UI.WaitingLayer:hideWaiting()
    elseif (no == NetMessageType.GUILD_RSP_AUCTION_LOG_MESSAGE.NO) then
        -- 公会拍卖记录返回
        mvc.guildAuctionModel:initAuctionLog(data.logs)

        Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_AUCTION_LOG_UPDATE)
        UI.WaitingLayer:hideWaiting()
    else
        assert(false, string.format("NetGuildSystem:onGuildMessageHandler no %d is invaild.", no))
    end
end

function NetGuildSystem:refreshGuildNewJoin()

    Avalon.MessageCenter:notice(GameMessage.MC_UI_GUILD_HAVE_JOIN_REQ)
end
