-- NetTeamSystem.lua
-- Author: zp
-- 

require "utils.MathUtil"
Net = Net or {}
local NetTeamSystem = {}
Net.NetTeamSystem = NetTeamSystem
local ProtobufUtil = require("utils.ProtobufUtil")
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
require "app.datas.TeamDataManager"
require "app.net.NetGuildSystem"
local DEBUG = false


--创建队伍请求
function NetTeamSystem:createTeam(caveMode,difficulty,level)
    if DEBUG then
        print ("[Net.NetTeamSystem] createTeam  mode,caveMode,difficulty,level=",caveMode,difficulty,level)
    end

    local messageData = {}
    if difficulty then
        messageData.caveDifficulty = difficulty
    else
        messageData.caveDifficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
    end
    if level then
        messageData.level = level
    else
        messageData.level = 2001
    end
    messageData.caveMode = caveMode or PublicDefine.CAVE_MODE.MODE_NORMAL
    messageData.pk = RoleDataManager:getMasterPK()
    messageData.useSchemeInHero = LevelSelectUtil:getInstance().mUseSpecialEvent

    -- local selectExtraPara = selectExtraPara or 1

    if caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS and difficulty > 1 then
        messageData.chooseLevel = mvc.chaosWormholeModel.selectExtraPara or 1
        local stageList = string.split(ConfigManager:getGeneralForKey("levelSegmentationClient"), ";")
        if messageData.chooseLevel <= #stageList and stageList[messageData.chooseLevel] ~= "" then
            local lvStrs = string.split(stageList[messageData.chooseLevel], ",")
            if #lvStrs > 0 and lvStrs[1] ~= "" then
                messageData.level = tonumber(lvStrs[1])
                print("   tonumber(lvStrs[1]) ===   ", tonumber(lvStrs[1]))
            end
        end
    end

    print("messageData  ===== ")
    dump(messageData)

    if RoleBehaviorManager:createTeamCheck() then
        printWarn(" been blocked when create team!")
        return
    end
    Net.Helper:sendMessage(NetMessageType.TEAM_REQUEST_CREATE_TEAM, messageData)
end

--开始匹配请求
function NetTeamSystem:requestMatch()
    if DEBUG then
        print ("[Net.NetTeamSystem] requestMatch  ")
    end

    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()
    dump(messageData)

    if RoleBehaviorManager:teamSysCheck() then
        printWarn(" been blocked when request match team!")
        return
    end
    Net.Helper:sendMessage(NetMessageType.TEAM_REQUEST_MATCH, messageData)
end

--请求立即进洞
function NetTeamSystem:requestImmediatelyGo()
    if DEBUG then
        print ("[Net.NetTeamSystem] requestImmediatelyGo  ")
    end

    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()

    if RoleBehaviorManager:teamSysCheck() then
        printWarn(" been blocked when request match team!")
        return
    end
    Net.Helper:sendMessage(NetMessageType.TEAM_REQUEST_IMMEDIATE_GO, messageData)
end

--取消搜索匹配的通知
function NetTeamSystem:requestCancelMatch()
    if DEBUG then
        print ("[Net.NetTeamSystem] requestCancelMatch  ")
    end

    if RoleBehaviorManager:teamChoiceCheck() then
        printWarn(" been blocked when request cancle match team!")
        return
    end
    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()
    
    Net.Helper:sendMessage(NetMessageType.TEAM_REQUEST_CANCEL_MATCH,messageData)
end


--确认匹配的请求
function NetTeamSystem:requestConfirmMatch(confirmID)
    if DEBUG then
        print ("[Net.NetTeamSystem] requestConfirmMatch  ")
    end
    if RoleBehaviorManager:teamChoiceCheck() then
        printWarn(" been blocked when request confirm match team!")
        return
    end
    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()
    messageData.confirmID = confirmID

    Net.Helper:sendMessage(NetMessageType.TEAM_REQUEST_CONFIRM_MATCH,messageData)
end

--离开队伍
function NetTeamSystem:leaveTeam(pk,teamID)
    if DEBUG then
        print ("[Net.NetTeamSystem] leaveTeam  ",pk,teamID)
    end
    if RoleBehaviorManager:teamChoiceCheck() then
        printWarn(" been blocked when request confirm match team!")
        return
    end
    local messageData = {}
    messageData.pk = pk

    Net.Helper:sendMessage(NetMessageType.TEAM_CO_Leave_Team,messageData)
end

--确认踢出队伍,投票
function NetTeamSystem:confirmKickTeam(isConfirm)
    if DEBUG then
        print ("[Net.NetTeamSystem] confirmKickTeam  ")
    end
    if RoleBehaviorManager:teamSysCheck() then
        printWarn(" been blocked when request confirm kick team!")
        return
    end
    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()
    messageData.isConfirm = isConfirm

    Net.Helper:sendMessage(NetMessageType.TEAM_REQUEST_KICK_CONFIRM,messageData)
end

--请求踢出队伍
function NetTeamSystem:kickTeam(pk)
    if DEBUG then
        print ("[Net.NetTeamSystem] kickTeam  ")
    end
    if RoleBehaviorManager:teamSysCheck() then
        printWarn(" been blocked when request kick team!")
        return
    end
    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()
    messageData.beKickPlayerPk = pk

    Net.Helper:sendMessage(NetMessageType.TEAM_REQUEST_KICK_HERO,messageData)
end


--请求确认下楼
function NetTeamSystem:confirmEnterNextLevel(isConfirm)
    if DEBUG then
        print ("[Net.NetTeamSystem] confirmEnterNextLevel  ")
    end

    if RoleBehaviorManager:teamSysCheck() then
        printWarn(" been blocked when request confirm enter next level!")
        return
    end
    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()
    messageData.isConfirm = isConfirm


    Net.Helper:sendMessage(NetMessageType.TEAM_REQUEST_CONFIRM_ENTER_NEXT_LEVEL,messageData)
end


--请求邀请好友和工会加入队伍
function NetTeamSystem:requestInviteFriendJoinTeam(targetUserID,targetPK,caveMode,caveDifficulty,level)
    if DEBUG then
        print ("[Net.NetTeamSystem] requestInviteFriendJoinTeam  ",targetUserID,targetPK,caveMode,caveDifficulty,level)
    end
    if RoleBehaviorManager:teamSysCheck() then
        printWarn(" been blocked when request invite friend join team!")
        return
    end
    local messageData = {}
    messageData.startPK = RoleDataManager:getMasterPK()
    messageData.targetUserID = targetUserID
    messageData.targetPK = targetPK
    messageData.caveMode = caveMode
    messageData.caveDifficulty = caveDifficulty
    messageData.level = level
    messageData.useSchemeInHero = LevelSelectUtil:getInstance().mUseSpecialEvent

    if caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS and caveDifficulty > 1 then
        local chooseLevel = mvc.chaosWormholeModel.selectExtraPara or 1
        local stageList = string.split(ConfigManager:getGeneralForKey("levelSegmentationClient"), ";")
        if chooseLevel <= #stageList and stageList[chooseLevel] ~= "" then
            local lvStrs = string.split(stageList[chooseLevel], ",")
            if #lvStrs > 0 and lvStrs[1] ~= "" then
                messageData.level = tonumber(lvStrs[1])
                print("   tonumber(lvStrs[1]) 222===   ", tonumber(lvStrs[1]))
            end
        end
    end

    Net.Helper:sendMessage(NetMessageType.TEAM_REQUEST_INVITE_FRIEND_JOIN_TEAM,messageData)
end


--客户端同意邀请好友和工会加入队伍
function NetTeamSystem:agreeInviteFriendJoinTeam(startPK,startUserID,targetUserID,targetPK,caveMode,caveDifficulty,level)
    if DEBUG then
        print ("[Net.NetTeamSystem] agreeInviteFriendJoinTeam  ",startPK,startUserID,targetUserID,targetPK,caveMode,caveDifficulty,level)
    end
    if RoleBehaviorManager:teamChoiceCheck() then
        printWarn(" been blocked when agree invite friend join team!")
        return
    end
    local messageData = {}
    messageData.startPK = startPK
    messageData.startUserID = startUserID
    messageData.targetUserID = targetUserID
    messageData.targetPK = targetPK
    messageData.caveMode = caveMode
    messageData.caveDifficulty = caveDifficulty
    messageData.level = level
    messageData.useSchemeInHero = LevelSelectUtil:getInstance().mUseSpecialEvent
    Net.Helper:sendMessage(NetMessageType.TEAM_AGREE_INVITE_FRIEND_JOIN_TEAM,messageData)
end


--客户端拒绝邀请好友和工会加入队伍
function NetTeamSystem:rejectInviteFriendJoinTeam(startPK,startUserID,targetPK)
    if DEBUG then
        print ("[Net.NetTeamSystem] rejectInviteFriendJoinTeam  ",startUserID)
    end
    if RoleBehaviorManager:teamChoiceCheck() then
        printWarn(" been blocked when reject invite friend join team!")
        return
    end
    local messageData = {}
    messageData.targetPK = targetPK
    messageData.startUserID = startUserID
    messageData.startPK = startPK

    Net.Helper:sendMessage(NetMessageType.TEAM_REJECT_INVITE_FRIEND_JOIN_TEAM,messageData)
end


--反馈邀请好友和工会加入队伍处理结果
function NetTeamSystem:responseInviteFriendJoinTeam(startPK,startUserID,targetUserID,targetPK,result)
    if DEBUG then
        print ("[Net.NetTeamSystem] responseInviteFriendJoinTeam  ",targetUserID,result)
    end

    local messageData = {}
    messageData.startPK = startPK
    messageData.startUserID = startUserID
    messageData.targetUserID = targetUserID
    messageData.targetPK = targetPK
    messageData.result = tostring(result)

    Net.Helper:sendMessage(NetMessageType.TEAM_RESPONSE_INVITE_FRIEND_JOIN_TEAM,messageData)
end

function NetTeamSystem:reqDismissTeam()
    if DEBUG then
        print ("[Net.NetTeamSystem] reqDismissTeam  ")
    end

    local messageData = {}

    Net.Helper:sendMessage(NetMessageType.TEAM_REQ_DISMISS_TEAM, messageData)
end

function NetTeamSystem:aswDismissTeam(isAgree)
    if DEBUG then
        print ("[Net.NetTeamSystem] aswDismissTeam  ",isAgree)
    end

    local messageData = {}
    messageData.isAgree = isAgree

    Net.Helper:sendMessage(NetMessageType.TEAM_ASW_DISMISS_TEAM, messageData)
end

-- team消息处理
function NetTeamSystem:onTeamMessageHandler(no, data)
    print(string.format("[Net.NetTeamSystem] onTeamMessageHandler no:%d.", no))

    -- if (DEBUG) then
    --     if data and type(data) == "table" then
    --         for k,v in pairs(data) do 
    --             if type(v) == "table" then
    --                 print("[Net.NetTeamSystem] onTeamMessageHandler  k="..k.."  v=")
    --             end
    --         end
    --     end
    -- end

    -- 开始搜索匹配的通知
    if (no == NetMessageType.TEAM_NOTIFY_SEARCH_MATCH.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_NOTIFY_SEARCH_MATCH ")
        end
        TeamDataManager:setTeamType(Game.TeamType.FromLevelSelect)
        --准备状态
        TeamDataManager:setReadyState(true)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_SEARCH_MATCH)
        TeamDataManager:setReadyTeamData({})
        if (not SceneManager:getInstance():isInFightScene()) then
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_SHOW_MATCH_TEAM, Game.TeamType.FromLevelSelect)
            SceneManager:getInstance():pushCommand(command)
        end
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.DUNGEON_GUARD)
    --匹配的响应
    elseif (no == NetMessageType.TEAM_RESPONSE_MATCH.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_RESPONSE_MATCH ")
             print("-------------------- os.time() = "..os.time())

        end
        dump(data,"1",5)
        TeamDataManager:setReadyState(false)
        TeamDataManager:setIsMatching(true)
        LevelSelectUtil:getInstance():responseMatch(data)
    --取消匹配的通知
    elseif (no == NetMessageType.TEAM_NotifyCancelMatch.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_NotifyCancelMatch ")
            dump(data)
        end
        
        if data.pk and data.pk ~= 0 and data.pk ~= RoleDataManager:getMasterPK() then
            if TeamDataManager:hasTeam() then
               for k,v in pairs(TeamDataManager:getTeamData()) do
                    if v:getPK() == data.pk then
                        print("[Net.NetTeamSystem]  TEAM_NotifyCancelMatch 555")
                        UI.ScrollBar:createByText(string.format(UI.TEXT_111105,v:getNickName()))
                        break
                    end
                end
            end
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH)
        if not SceneManager:getInstance():isInFightScene() then
            if TeamDataManager:getReadyState() == true then
                TeamDataManager:setReadyState(false)
                print("[Net.NetTeamSystem]  TEAM_NotifyCancelMatch ",TeamDataManager:hasTeam() , table.nums(TeamDataManager:getTeamData()))
                if TeamDataManager:hasTeam() and table.nums(TeamDataManager:getTeamData()) > 1 then
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM,1)
                end

                -- Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM,1)
            end
        end

        TeamDataManager:setReadyState(false)
    --玩家确认的广播消息
    elseif (no == NetMessageType.TEAM_NOTIFY_PLAYER_CONFIRM.NO) then
        -- if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_NOTIFY_PLAYER_CONFIRM ")
        -- end
        local mark = true;     --是否有玩家没有匹配
        local _teamData = TeamDataManager:getReadyTeamData()
        for k,v in pairs(_teamData) do
            if data.pk == v.pk then
                v.state = true
                break;
            end
        end

        for k,v in pairs(_teamData) do
            if v.state == false then
                mark = false;
                break;
            end
        end

        if data.pk == RoleDataManager:getMasterPK() then
            TeamDataManager:setPunishmentState(0)    --惩罚状态,0正常,1一次不匹配,2二次不匹配,惩罚禁止匹配
            TeamDataManager:setPunishmentTime(0)
        end

        if mark == false then
            TeamDataManager:setReadyTeamData(_teamData)
        else
            TeamDataManager:setIsMatching(false)
            Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_ALL_CONFIRM)
            _teamData = {}
            TeamDataManager:setReadyTeamData(_teamData)
        end
    --倒计时结束取消匹配  
    elseif (no == NetMessageType.TEAM_COUNTDOWN_CANCEL_MATCH.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_COUNTDOWN_CANCEL_MATCH ")
            dump(data)
        end

        TeamDataManager:setIsMatching(false)
        
        for i = 1,3 do
            local _teamData = TeamDataManager:getReadyTeamData()[i]
            if _teamData and RoleDataManager:getMasterPK() == _teamData.pk and _teamData.state == false then
                TeamDataManager:setPunishmentState(TeamDataManager:getPunishmentState() + 1)    --惩罚状态,0正常,1一次不匹配,2二次不匹配,惩罚禁止匹配
                TeamDataManager:setPunishmentTime(GameManager:getNowServerTime() + ConfigManager:getPunishmentTime())
                break;
            end
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH)
        UI.ScrollBar:createByText(UI.TEXT_1110378)
        if(data.pk and type(data.pk) == "table") then
            local isHaveSelf = false
            for i = 1,#data.pk do
                if data.pk[i] == RoleDataManager:getMasterPK() then
                    UI.ScrollBar:createByText(UI.TEXT_111108)
                    isHaveSelf = true
                    break
                end
            end
            if not isHaveSelf then
                if not SceneManager:getInstance():isInFightScene() then
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM,1)
                end
            end
        else 
            if not SceneManager:getInstance():isInFightScene() then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM,1)
            end
            UI.ScrollBar:createByText(UI.TEXT_111108)
            printError("NetMessageType.TEAM_COUNTDOWN_CANCEL_MATCH  data.pk is not table or is nil.")
        end

        local _teamData = {}
        TeamDataManager:setReadyTeamData(_teamData)
        -- LevelSelectUtil:getInstance():initTeamData(TEAM_STATE.MATCHING);--1: 匹配阶段
        
    --创建队伍消息
    elseif (no == NetMessageType.TEAM_CREATE_TEAM.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_CREATE_TEAM ")
        end
        dump(data)
        TeamDataManager:setReadyState(data.isMatching)
        TeamDataManager:createTeam(data)


        LevelSelectUtil:getInstance().mPattern = PublicDefine.GAME_MODE.MODE_TEAM
        if data.caveMode ~= 0 then
            LevelSelectUtil:getInstance():setCaveMode(data.caveMode)
        end
        
        if data.caveDifficulty ~= 0 then
            LevelSelectUtil:getInstance().mDifficulty:set(data.caveDifficulty)
        end

        if data.level ~= 0 then
            if data.caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then
                LevelSelectUtil:getInstance().mSelectLevel = data.level
            else
                LevelSelectUtil:getInstance().mSelectLevel = LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level)
            end
        end
        LevelSelectUtil:getInstance().mUseSpecialEvent = false
        if data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO or data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            LevelSelectUtil:getInstance().mUseSpecialEvent = data.useSchemeInHero
        end
        print("[Net.NetTeamSystem]  TEAM_CREATE_TEAM mSelectLevel",LevelSelectUtil:getInstance().mSelectLevel)


        for k,v in pairs(data.teamMemberData) do
            if v.pk ~= pk then
                if v.pk == RoleDataManager:getMasterPK() then
                    local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                    Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_TEAM, UI.TEXT_110099, you)
                else
                    local content = Game.ChatManager:getInstance():getNickNameLinkStr(ChatMessageType.SYSTEM_TEAM_MEMBER, v.pk, 0, v.nickName)
                    Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_TEAM_MEMBER, UI.TEXT_110099, content)
                end
            end
        end
        Avalon.MessageCenter:notice(GameMessage.MC_CHAT_REFRESH_TIPS)
    --解散队伍消息
    elseif (no == NetMessageType.TEAM_DISMISS_TEAM.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_DISMISS_TEAM ")
        end
        dump(data)
        TeamDataManager:dismissTeam(data,UI.TEXT_1110375)
        local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
        Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_TEAM, UI.TEXT_111102, you)
        Avalon.MessageCenter:notice(GameMessage.MC_CHAT_REFRESH_TIPS)
    --加入队伍消息
    elseif (no == NetMessageType.TEAM_JOIN_TEAM.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_JOIN_TEAM ")
        end
        dump(data)
        TeamDataManager:joinTeam(data)


        if data.teamMemberData.pk ~= pk then
            if data.teamMemberData.pk == RoleDataManager:getMasterPK() then
                local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_TEAM, UI.TEXT_110099, you)
            else
                local content = Game.ChatManager:getInstance():getNickNameLinkStr(ChatMessageType.SYSTEM_TEAM_MEMBER, data.teamMemberData.pk, 0, ToolsUtil:replaceShowNickNameStr(data.teamMemberData.nickName))
                Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_TEAM_MEMBER, UI.TEXT_110099, content)
            end
        end
        Avalon.MessageCenter:notice(GameMessage.MC_CHAT_REFRESH_TIPS)
    --通知玩家状态改变
    elseif (no == NetMessageType.TEAM_NOTIFY_TEAM_MEMBER_STATUS_CHANGE.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_NOTIFY_TEAM_MEMBER_STATUS_CHANGE ")
        end
        dump(data)
        TeamDataManager:updateOnLineState(data.pk,data.teamMemberStatus,data.userID)
    --离开队伍消息
    elseif (no == NetMessageType.TEAM_OC_Leave_Team.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_OC_Leave_Team ")
        end
        -- dump(data)

        if data.pk == RoleDataManager:getMasterPK() then
            local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
            Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_TEAM, UI.TEXT_111102, you)
        else
            local captainName = "test"
            local pk = 0
            for k,v in pairs(TeamDataManager:getTeamData()) do
                if v:getPK() == data.pk then
                    captainName = v:getNickName()
                    pk = v:getPK()
                    break
                end
            end
            local content = Game.ChatManager:getInstance():getNickNameLinkStr(ChatMessageType.SYSTEM_TEAM_MEMBER, pk, 0, captainName)
            Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_TEAM_MEMBER, UI.TEXT_111102, content)
        end
        TeamDataManager:levelTeam(data.pk)
        Avalon.MessageCenter:notice(GameMessage.MC_CHAT_REFRESH_TIPS)

        -- $$$$$$ 剥离声网sdk
        --关闭语音
        -- Avalon.VoiceChatManager:closeVoiceSettings()
    --踢人消息
    elseif (no == NetMessageType.TEAM_OC_KICK_HERO.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_OC_KICK_HERO .. = "..data.pk)
        end
        -- dump(data)

        if data.pk == RoleDataManager:getMasterPK() then
            Game.ChatManager:getInstance():sendSystemMsg(UI.TEXT_111103, ChatMessageType.SYSTEM_TEAM)
        else
            local captainName = "test"
            local pk = 0
            for k,v in pairs(TeamDataManager:getTeamData()) do
                if v:getPK() == data.pk then
                    captainName = v:getNickName()
                    pk = v:getPK()
                    break
                end
            end
            local content = Game.ChatManager:getInstance():getNickNameLinkStr(ChatMessageType.SYSTEM_TEAM_MEMBER, pk, 0, captainName)
            Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_TEAM_MEMBER, UI.TEXT_111104, content)
        end
        TeamDataManager:kickTeam(data.pk)
    --请求踢人消息
    elseif (no == NetMessageType.TEAM_RESPONSE_KICK_HERO.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_RESPONSE_KICK_HERO ")
        end
        -- dump(data)
        --TeamDataManager:kickTeam(data.beKickPlayerPk)
        --弹出提示框

        if data.result == "KickSuccess" then
            if data.pk ~= RoleDataManager:getMasterPK() and data.beKickPlayerPk ~= RoleDataManager:getMasterPK() then
                local teamData = TeamDataManager:getTeamData()
                txt = UI.TEXT_110021
                if teamData[data.pk] and teamData[data.beKickPlayerPk] then
                    txt = string.format(UI.TEXT_110021,teamData[data.pk]:getNickName(),teamData[data.beKickPlayerPk]:getNickName())
                end
                require "app.ui.tips.TimeBarTips"
                local tips = UI.TimeBarTips:create(txt, PublicDefine.CONST_DEFINITION.COUNTDOWN_KICK_MEMBER/1000)
                tips:addEventListener(UIEvent.DIALOG_CONFIRM,tips, function()
                    Net.NetTeamSystem:confirmKickTeam(true)
                end)
                tips:addEventListener(UIEvent.DIALOG_CANCEL,tips, function()
                    Net.NetTeamSystem:confirmKickTeam(false)
                end)
                tips:addEventListener(UIEvent.DIALOG_TIMEOUT,tips, function()
                    tips:close()
                end)
                tips:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
                tips.touchDialogOutsizeClose = false
                tips:setInterceptTouches(false);
                tips:leftBottom(0,20)
                tips:setName("kickHero")
                tips:enableIrregularShapeScreenAdjustment(true)
                require "app.ui.tips.TipsLayer"
                UI.UIManager:getRootNode():addChild(tips, UI_ZORDER.TIPS)
            end
            TeamDataManager.beKickPlayerPk = data.beKickPlayerPk
        else
            --错误处理,这里要飘窗
            print(data.result)
            GameErrorManager:showError(ProtobufUtil:enum_id("TeamSystem.KickHeroResult",data.result))
        end

    --倒计时结束,踢人失败 
    elseif (no == NetMessageType.TEAM_CANCEL_KICK_HERO.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_CANCEL_KICK_HERO ")
        end
        --踢人失败
        
        UI.ScrollBar:createByText(UI.TEXT_1110380)

        local teamData = TeamDataManager:getTeamData()
        if teamData[TeamDataManager.beKickPlayerPk] then
            teamData[TeamDataManager.beKickPlayerPk].kickTime = tonumber(ConfigManager:getGeneralForKey("kickTime")/1000);
        end
        
    --踢人确认消息
    elseif (no == NetMessageType.TEAM_RESPONSE_KICK_CONFIRM.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_RESPONSE_KICK_CONFIRM ")
        end
        -- dump(data)
        if data.result ~= "ConfirmSuccess" then
            --错误处理,这里要飘窗
            print(data.result)
            GameErrorManager:showError(ProtobufUtil:enum_id("TeamSystem.KickConfirmResult",data.result))
        else
            if not data.isConfirm then
                local teamData = TeamDataManager:getTeamData()
                if teamData[TeamDataManager.beKickPlayerPk] then
                    teamData[TeamDataManager.beKickPlayerPk].kickTime = tonumber(ConfigManager:getGeneralForKey("kickTime")/1000);
                end
                local txt = string.format(UI.TEXT_110051,TeamDataManager:getTeamData()[data.pk]:getNickName())
                UI.ScrollBar:createByText(txt)
            end
        end
    --通知全队请求下楼
    elseif (no == NetMessageType.TEAM_RESPONSE_ENTER_NEXT_LEVEL.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_RESPONSE_ENTER_NEXT_LEVEL ")
        end
        -- dump(data)
        if data.result == "RequestNextLevelSuccess" then
            if data.originatorPk ~= RoleDataManager:getMasterPK() then
                require "app.ui.tips.TimeBarTips"
                local tips =  UI.TimeBarTips:create(UI.TEXT_1110384, PublicDefine.CONST_DEFINITION.COUNTDOWN_KICK_MEMBER/1000)
                tips:setName("nextLevel")

                tips:addEventListener(UIEvent.DIALOG_CONFIRM,tips, function()
                    Net.NetTeamSystem:confirmEnterNextLevel(true)
                end)
                tips:addEventListener(UIEvent.DIALOG_CANCEL,tips, function()
                    Net.NetTeamSystem:confirmEnterNextLevel(false)
                end)
                tips:addEventListener(UIEvent.DIALOG_TIMEOUT,tips, function()
                    tips:close()
                end)
                tips:center()
                require "app.ui.tips.TipsLayer"
                UI.UIManager:getRootNode():addChild(tips, UI_ZORDER.TIPS)
            end
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("TeamSystem.EnterNextLevelResult",data.result))
        end
    -- 通知确认队伍解散消息
    elseif (no == NetMessageType.TEAM_REQ_DISMISS_TEAM.NO) then
        if data.pk ~= RoleDataManager:getMasterPK() then
            local nickName = ""
            local heroData = RoleDataManager:getHeroDataForPK(data.pk)
            if(heroData) then 
                nickName = heroData:getNickName()
            end
            require "app.ui.tips.TimeBarTips"
            local tips =  UI.TimeBarTips:create(string.format(UI.TEXT_1212222, nickName), PublicDefine.CONST_DEFINITION.COUNTDOWN_ENTER_NEXT_FLOOR/1000)
            tips:setName("dismissTeam")

            tips:addEventListener(UIEvent.DIALOG_CONFIRM,tips, function()
                Net.NetTeamSystem:aswDismissTeam(true)
            end)
            tips:addEventListener(UIEvent.DIALOG_CANCEL,tips, function()
                Net.NetTeamSystem:aswDismissTeam(false)
            end)
            tips:addEventListener(UIEvent.DIALOG_TIMEOUT,tips, function()
                tips:close()
            end)
            tips:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
            tips.touchDialogOutsizeClose = false
            tips:setInterceptTouches(false);
            tips:leftBottom(0,20)
            tips:enableIrregularShapeScreenAdjustment(true)
            require "app.ui.tips.TipsLayer"
            UI.UIManager:getRootNode():addChild(tips, UI_ZORDER.TIPS)
        end
    elseif (no == NetMessageType.TEAM_DISMISS_TEAM_RESULT.NO) then
        if(data.isDis == false) then 
            TeamDataManager:setIgnorAutoTipsDismiss(true)
            if UI.UIManager:getRootNode() then
                local tipLayer = UI.UIManager:getRootNode():getChildByName("tipLayer")
                if tipLayer ~= nil then
                    local tips = tipLayer:getChildByName("dismissTeam");
                    if tips then
                        tips:removeSelf()
                    end
                end
            end
            -- 提示解散队伍失败
            UI.ScrollBar:createByText(UI.TEXT_1212223)

            local captainName = ""
            local pk = 0
            for k,v in pairs(TeamDataManager:getTeamData()) do
                if v:getPK() == data.pk then
                    captainName = v:getNickName()
                    pk = v:getPK()
                    break
                end
            end
            local content = Game.ChatManager:getInstance():getNickNameLinkStr(ChatMessageType.SYSTEM_TEAM_MEMBER, pk, 0, captainName)
            Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_TEAM_MEMBER, LanguageManager:getInstance():getLocalString(1111689), content)
        else 
            TeamDataManager:setIgnorAutoTipsDismiss(false)
        end
    elseif (no == NetMessageType.TEAM_DISMISS_OP_REQ_TEAM.NO) then
        -- print("TEAM_DISMISS_OP_REQ_TEAM=", data)
        if (data.type == ProtobufUtil:enum_id("TeamSystem.TEAM_SYSTEM_MESSAGE_TYPE", "Type_ReqDismissTeamMeesage")) then
            if data.result ~= ProtobufUtil:enum_id("TeamSystem.DismissOpReqResult", "DismissOpReqResult_Ok") then
                local masterPK = RoleDataManager:getMasterPK()
                local teamData = TeamDataManager:getTeamData()
                if teamData[masterPK] then
                    teamData[masterPK].dismissTime = 0
                end
            end
        end
        
        GameErrorManager:showError(data.result)
    --通知确认下楼的最终结果
    elseif (no == NetMessageType.TEAM_NOTIFY_CONFIRM_ENTER_NEXT_LEVEL.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_NOTIFY_CONFIRM_ENTER_NEXT_LEVEL ")
        end
        -- dump(data)
        if UI.UIManager:getRootNode() then
            local tipLayer = UI.UIManager:getRootNode():getChildByName("tipLayer")
            if tipLayer ~= nil then
                local tips = tipLayer:getChildByName("nextLevel");
                if tips then
                    tips:removeSelf()
                end
            end
        end
        if data.isAllConfirm == false then
            if(ProtobufUtil:checkFieldIsInit(data, "checkPointLmted")) then
                local GameDataManager = require("app.game.GameDataManager")
                local GameMapManager = require("app.game.GameMapManager")
                if GameDataManager:getInstance():willOpenNewNormalCheckPoint() and GameMapManager:getInstance():getUpdateCheckPT() == false then
                    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112014))
                else 
                    if(data.checkPointLmted == RoleDataManager:getMasterPK()) then 
                        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112014))
                    else 
                        local teamData = TeamDataManager:getTeamDataForPK(data.checkPointLmted)
                        if(teamData) then
                            UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(1112013), teamData:getNickName()))
                        else 
                            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112014))
                        end 
                    end
                end
            else
                UI.ScrollBar:createByText(UI.TEXT_1110388)
            end
        end

        mvc.greedySelectModel:clearAllGreedySelectInfo()

    --取消投票下楼
    elseif (no == NetMessageType.TEAM_CANCEL_ENTER_NEXT_LEVEL.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_CANCEL_ENTER_NEXT_LEVEL ")
        end
        -- dump(data)
        if UI.UIManager:getRootNode() then
            local tipLayer = UI.UIManager:getRootNode():getChildByName("tipLayer")
            if tipLayer ~= nil then
                local tips = tipLayer:getChildByName("nextLevel");
                if tips then
                    tips:removeSelf()
                end
            end
        end
        if(data.OperatorPK ~= RoleDataManager:getMasterPK()) then
            GameErrorManager:showError(ProtobufUtil:enum_id("TeamSystem.CancelEnterNextLevelReason",data.reason))
        end
        mvc.greedySelectModel:clearAllGreedySelectInfo()
    --请求邀请好友和工会加入队伍
    elseif (no == NetMessageType.TEAM_REQUEST_INVITE_FRIEND_JOIN_TEAM.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_REQUEST_INVITE_FRIEND_JOIN_TEAM ")
            dump(data)
        end
        
        if data.startPK ~= RoleDataManager:getMasterPK() then
            --功能未解锁
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
                Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_targetLockFunction")
                return
            end

            if data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO and not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave) then
                Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_targetLockFunction")
                return
            end

            if data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO and not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then
                Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_targetLockFunction")
                return
            end
            
            --正在副本匹配中
            if TeamDataManager:getTeamType() == Game.TeamType.FromActivity and TeamDataManager:getReadyState() then
                Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_IsInActivityMatch")
                return
            end

            --已有队伍
            if TeamDataManager:hasTeam() then
                Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_targetIsInTeam")
                return
            end


            if UI.UIManager.mMainUILayer and (not tolua.isnull(UI.UIManager.mMainUILayer)) then
                local pLevelSelectTeam1 = UI.UIManager.mMainUILayer.rootLayer:getChildByName("LevelSelectTeam1")
                if pLevelSelectTeam1 and (not tolua.isnull(pLevelSelectTeam1)) then
                    Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_targetIsInCave")
                    return
                end

                local pLevelSelectTeam2 = UI.UIManager.mMainUILayer.rootLayer:getChildByName("LevelSelectTeam2")
                if pLevelSelectTeam2 and (not tolua.isnull(pLevelSelectTeam2)) then
                    Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_targetIsInCave")
                    return
                end
            end

            --在洞窟中
            if SceneManager:getInstance():isInFightScene() then
                Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_targetIsInCave")
                return
            end

            --目标玩家不满足进入洞窟的要求
            if data.caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then
                -- if not GameDataManager:judgeHaveDungeonKey(data.level) then
                if not GameDataManager:judgeHaveDungeonKey(1) then
                    Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_isNotMatch")
                    return
                end

                local keyData = GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, DUNGEON_ITEM_KEY, false, 0)
                if keyData == nil or keyData:getIsLock() then
                    Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_AcceptJoinLackDungeonKey")
                    return
                end
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
                if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave) then
                    Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_isNotMatch")
                    return
                end
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then
                    Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_isNotMatch")
                    return
                end
            else
                local checkpointData = RoleDataManager:getCheckpointData(data.caveMode,data.caveDifficulty)
                if checkpointData:getCheckpoint() then
                    if data.level > checkpointData:getCheckpoint() then
                        print("InviteFriendJoinTeamResult_isNotMatch",data.level, checkpointData:getCheckpoint())
                        Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_isNotMatch")
                        return
                    end
                else
                    print("InviteFriendJoinTeamResult_isNotMatch111")
                    Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_isNotMatch")
                    return
                end
            end

            --在惩罚阶段
            if TeamDataManager:getPunishmentState() >= 2 then
                Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_targetIsInPunish")
                return
            end

            require "app.datas.AnswerDataManager"
                -- 检查答题限制,如果返回true 说明是属于小黑屋,不能进入战斗
            if not AnswerDataManager:canEnterCave() then
                Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_AnswerWrongPunish")
                return
            end

            if data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO and data.useSchemeInHero and MasterDataManager:getHeroCaveSchemeExploreCount() <= 0 then
                Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_NotEnoughExplorationCount")
                return
            end

            if data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO and data.useSchemeInHero and MasterDataManager:getTitanHeroCaveSchemeExploreCount() <= 0 then
                Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_NotEnoughExplorationCount")
                return
            end

            local mark = false
            for k,v in pairs(Game.FriendManager:getInstance():getFriendData()) do
                if v.PK == data.startPK then
                    mark = true
                    break
                end
            end

            if mark == false then
                if MasterDataManager:getGuildData() ~= nil then 
                    for k,v in pairs(MasterDataManager:getGuildData():getMember()) do
                        if v.PK == data.startPK then
                            mark = true
                            break
                        end
                    end
                end
            end

            if mark == false then
                Net.NetTeamSystem:responseInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,"InviteFriendJoinTeamResult_targetIsStranger")
                return
            end

            local inviteTeamData = {}
            LevelSelectUtil:getInstance().mPattern = PublicDefine.GAME_MODE.MODE_TEAM
            inviteTeamData.caveMode = data.caveMode
            inviteTeamData.caveDifficulty = data.caveDifficulty
            if data.caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then
                inviteTeamData.level = data.level
            else
                inviteTeamData.level = data.level - 2000
            end
            
            inviteTeamData.nickName = data.nickName
            inviteTeamData.pk = data.startPK
            inviteTeamData.targetUserID = data.targetUserID
            table.insert(TeamDataManager.inviteTeamDataList,inviteTeamData) 
            local txt = UI.TEXT_110076
            local checkExpedition = false
            LevelSelectUtil:getInstance().mUseSpecialEvent = false
            if data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
                -- txt = string.format(UI.TEXT_110076,
                --     data.nickName,
                --     UI.TEXT_110101,
                --     LevelSelectUtil:getInstance():getDifficultyText(data.caveDifficulty),
                --     LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                 txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    UI.TEXT_110101,
                    LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                checkExpedition = true
            elseif  data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then 
                LevelSelectUtil:getInstance().mUseSpecialEvent = data.useSchemeInHero
                if data.useSchemeInHero then
                    txt = string.format(UI.TEXT_1110689,
                        data.nickName,
                        UI.TEXT_1212059,
                        ConfigManager:getHeroCaveNameByLevel(data.level, PublicDefine.CAVE_MODE.MODE_HERO))
                else
                    txt = string.format(UI.TEXT_1110689,
                        data.nickName,
                        UI.TEXT_1212070,
                        ConfigManager:getHeroCaveNameByLevel(data.level, PublicDefine.CAVE_MODE.MODE_HERO))
                end
                checkExpedition = true
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_DREAM then 
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_WORLD_BOSS then 
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_GUILD_BOSS then 
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then 
                txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    UI.TEXT_1212801,
                    LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                checkExpedition = true
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE then 
                txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    UI.TEXT_1212803,
                    LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                checkExpedition = true
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then 
                txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    UI.TEXT_1325500,
                    LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                checkExpedition = true
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then
                checkExpedition = true
                txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    languageManagerInstance:getLocalString(1110531),
                    tostring(data.level))
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then 
                txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    UI.TEXT_222100,
                    LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                checkExpedition = true
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_VIKING then 
                txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    UI.TEXT_223800,
                    LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                checkExpedition = true
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT then 
                txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    UI.TEXT_224200,
                    LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                checkExpedition = true
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then 
                txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    UI.TEXT_224400,
                    LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                checkExpedition = true
            elseif  data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then 
                LevelSelectUtil:getInstance().mUseSpecialEvent = data.useSchemeInHero
                if data.useSchemeInHero then
                    txt = string.format(UI.TEXT_1110689,
                        data.nickName,
                        UI.TEXT_224401,
                        ConfigManager:getHeroCaveNameByLevel(data.level, PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO))
                else
                    txt = string.format(UI.TEXT_1110689,
                        data.nickName,
                        UI.TEXT_224401,
                        ConfigManager:getHeroCaveNameByLevel(data.level, PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO))
                end
                checkExpedition = true
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then 
                txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    UI.TEXT_225000,
                    LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                checkExpedition = true
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS then 
                txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    UI.TEXT_226500,
                    LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                checkExpedition = true
            elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE then 
                txt = string.format(UI.TEXT_110077,
                    data.nickName,
                    UI.TEXT_227200,
                    LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(data.level))
                checkExpedition = true
            end
            require "app.ui.tips.TimeBarTips"
            local tips = UI.TimeBarTips:create(txt, PublicDefine.CONST_DEFINITION.AGREE_INVITE_JOIN_TEAM_TIME/1000)
            tips:setName("INVITE_FRIEND_JOIN_TEAM")
            tips:addEventListener(UIEvent.DIALOG_CONFIRM,tips, function()
                -- 如果 worldboss 已报名，提醒一次
                if mvc.worldBossModel:checkCanEnterOther() then
                    -- if(mvc.expeditionModel:getExpeditionStatus() and checkExpedition) then
                    --     UI.ConfirmDialog.show(UI.TEXT_1212587, function()
                    --         Net.NetNPCSystem:reqStopExpedition()
                    --         Net.NetTeamSystem:agreeInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,data.caveMode,data.caveDifficulty,data.level)              
                    --     end,
                    --     function()
                    --         Net.NetTeamSystem:rejectInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetPK)
                    --     end)
                    -- else 
                        Net.NetTeamSystem:agreeInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,data.caveMode,data.caveDifficulty,data.level) 
                    -- end
                else
                    UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                        UI.TEXT_1212663,
                        function()
                            Net.NetActivitySystem:requestWorldbossQuitRoom()
                            -- if(mvc.expeditionModel:getExpeditionStatus() and checkExpedition) then
                            --     UI.ConfirmDialog.show(UI.TEXT_1212587, function()
                            --         Net.NetNPCSystem:reqStopExpedition()
                            --         Net.NetTeamSystem:agreeInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,data.caveMode,data.caveDifficulty,data.level)              
                            --     end,
                            --     function()
                            --         Net.NetTeamSystem:rejectInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetPK)
                            --     end)
                            -- else 
                                Net.NetTeamSystem:agreeInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetUserID,data.targetPK,data.caveMode,data.caveDifficulty,data.level) 
                            -- end
                        end,
                        function()
                            Net.NetTeamSystem:rejectInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetPK)
                        end
                    )
                end
            end)
            tips:addEventListener(UIEvent.DIALOG_CANCEL,tips, function()
                Net.NetTeamSystem:rejectInviteFriendJoinTeam(data.startPK,data.startUserID,data.targetPK)
            end)
            tips:addEventListener(UIEvent.DIALOG_TIMEOUT,tips, function()
                 tips:close()
            end)
            tips:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
            tips:center()  
            UI.UIManager:getRootNode():addChild(tips, UI_ZORDER.TIPS)
        end

    --反馈邀请好友和工会加入队伍处理结果
    elseif (no == NetMessageType.TEAM_RESPONSE_INVITE_FRIEND_JOIN_TEAM.NO) then
        -- if DEBUG then
            print("++++++++++++++++++[Net.NetTeamSystem] TEAM_RESPONSE_INVITE_FRIEND_JOIN_TEAM ", data)
            -- dump(data)
        -- end
        
        if(data.result == "InviteFriendJoinTeamResult_success") then
            if data.targetPK == RoleDataManager:getMasterPK() then

                for i = 1,#TeamDataManager.inviteTeamDataList do
                    if TeamDataManager.inviteTeamDataList[i].targetUserID == data.startUserID then
                        LevelSelectUtil:getInstance().mPattern = PublicDefine.GAME_MODE.MODE_TEAM
                        LevelSelectUtil:getInstance():setCaveMode(TeamDataManager.inviteTeamDataList[i].caveMode)
                        LevelSelectUtil:getInstance().mDifficulty:set(TeamDataManager.inviteTeamDataList[i].caveDifficulty)
                        LevelSelectUtil:getInstance().mSelectLevel = TeamDataManager.inviteTeamDataList[i].level
                        break
                    end
                end

                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM,1)
            end
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("TeamSystem.InviteFriendJoinTeamResult",data.result))
            for i = 1,#TeamDataManager.inviteTeamDataList do
                if TeamDataManager.inviteTeamDataList[i] and TeamDataManager.inviteTeamDataList[i].targetUserID == data.startUserID then
                    table.remove(TeamDataManager.inviteTeamDataList,i)
                end
            end

            if data.result == "InviteFriendJoinTeamResult_targetIsInCave" or 
                data.result == "InviteFriendJoinTeamResult_isNotMatch" or 
                data.result == "InviteFriendJoinTeamResult_targetIsStranger" then

                GameManager:getFriendList(GameDataManager:getInstance():getMasterPK(), Game.FriendManager:getInstance():getUpdateTimestamp())
                if MasterDataManager:getGuildData() ~= nil then
                    Net.NetGuildSystem:reqGuild(MasterDataManager:getGuildData().version)
                end
            end
        end
    --客户端同意邀请好友和工会加入队伍
    elseif (no == NetMessageType.TEAM_AGREE_INVITE_FRIEND_JOIN_TEAM.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_AGREE_INVITE_FRIEND_JOIN_TEAM ")
            dump(data)
        end
    --客户端拒绝邀请好友和工会加入队伍
    elseif (no == NetMessageType.TEAM_REJECT_INVITE_FRIEND_JOIN_TEAM.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_REJECT_INVITE_FRIEND_JOIN_TEAM ")
            dump(data)
        end

        for k,v in pairs(Game.FriendManager:getInstance():getFriendData()) do
            if v.PK == data.targetPK then
                UI.ScrollBar:createByText(string.format(UI.TEXT_110097,v.nickName))
                return
            end
        end 

        if MasterDataManager:getGuildData() == nil then
            for k,v in pairs(MasterDataManager:getGuildData():getMember()) do
                if v.PK == data.targetPK then
                    UI.ScrollBar:createByText(string.format(UI.TEXT_110097,v.name))
                    return
                end 
            end
        end
    --队长改变通知
    elseif (no == NetMessageType.TEAM_NOTIFY_CAPTAIN_CHANGE.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_NOTIFY_CAPTAIN_CHANGE ")
            dump(data)
        end
        TeamDataManager:notifyCaptainChange(data.newCaptainPK)
    elseif (no == NetMessageType.TEAM_NTF_GREEDY_SELECT_MESSAGE.NO) then
        print(data)
        mvc.greedySelectModel:setGreedySelectInfo(data.pk, data.greedyGoodsID) 
    elseif (no == NetMessageType.TEAM_RESPONSE_SYSTEM_ERROR.NO) then
        if DEBUG then
            print("[Net.NetTeamSystem]  TEAM_RESPONSE_SYSTEM_ERROR ")
            dump(data)
        end
        if data.requestType == NetMessageType.TEAM_REQUEST_CREATE_TEAM.NO then--请求组队
            --也是 走匹配失败通知
            Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_REFRESH_TEAM_VIEW)
        elseif data.requestType == NetMessageType.TEAM_REQUEST_MATCH.NO then--请求匹配;
            --也是 走匹配失败通知
            Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_REFRESH_TEAM_VIEW)
        elseif data.requestType == NetMessageType.TEAM_REQUEST_CANCEL_MATCH.NO then--请求取消匹配; --关闭
            -- Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_CLINE_NOTIFY_CANCEL_MATCH)
        elseif data.requestType == NetMessageType.TEAM_REJECT_INVITE_FRIEND_JOIN_TEAM.NO then--拒绝邀请组队; --不处理 界面会自动关闭
        
        elseif data.requestType == NetMessageType.TEAM_REQUEST_INVITE_FRIEND_JOIN_TEAM.NO then--请求邀请好友组队;-- 不处理

        elseif data.requestType == NetMessageType.TEAM_REQUEST_CONFIRM_MATCH.NO then--确认匹配的请求
            Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_REFRESH_TEAM_VIEW)
        end

        if(data.result and data.result > 0) then 
            GameErrorManager:showError(data.result)
        else
            GameErrorManager:showError(2) 
        end 
     else
        assert(false, string.format("[Net.NetTeamSystem] onTeamMessageHandler no %d is invaild.", no))
    end    
end