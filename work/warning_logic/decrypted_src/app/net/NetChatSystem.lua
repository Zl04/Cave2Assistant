--[[
   聊天相关的网络消息处理
]]--

Net = Net or {}
local NetChatSystem = {}
Net.NetChatSystem = NetChatSystem
local ProtobufUtil = require("utils.ProtobufUtil")
-- 验证
function NetChatSystem:sendMessage(channelType, message, reciverPk, reciverUserId, reciverName, type)
    -- print("sender---------message = ", message)
    local GameDataManager = require("app.game.GameDataManager")
    local sender = {
        pk = RoleDataManager:getMaster():getPK(),
        userID = RoleDataManager:getMaster():getUserID(),
        nickName = RoleDataManager:getMaster():getNickName(),
        faceDecodeID = RoleDataManager:getMaster():getFaceDecodeID(),
        wearEquipId = GameDataManager:getInstance():getWearTempId(),
        sex = RoleDataManager:getMaster():getSex(),
        roleLV = RoleDataManager:getMaster():getLevel(),
        reincarntionLv = RoleDataManager:getMaster():getReincarntionLv(),
    }

    if channelType == ChatChannelType.PERSONAL then
        local personalMsg = {}
        personalMsg.chatFrom = sender
        personalMsg.chatContent = message
        personalMsg.chatTo = {
            pk = reciverPk,
            userID = reciverUserId,
            nickName = reciverName
        }
        personalMsg.type = type
        Net.Helper:sendMessage(NetMessageType.CHAT_PRIVATE_MESSAGE, personalMsg)

    elseif channelType == ChatChannelType.TEAM then
        local teamMessage = {}
        teamMessage.Speaker = sender
        teamMessage.chatContent = message
        teamMessage.type = type
        dump(teamMessage, "teamMessage")
        Net.Helper:sendMessage(NetMessageType.CHAT_TEAM_MESSAGE, teamMessage)
        
    elseif channelType == ChatChannelType.GUILD then
        local guildMessage = {}
        guildMessage.Speaker = sender
        guildMessage.chatContent = message
        guildMessage.type = type
        Net.Helper:sendMessage(NetMessageType.CHAT_GUILD_MESSAGE, guildMessage)
    elseif channelType == ChatChannelType.NEAR then
        local nearMessage = {}
        nearMessage.Speaker = sender
        nearMessage.chatContent = message
        nearMessage.type = type
        Net.Helper:sendMessage(NetMessageType.CHAT_NEAR_MESSAGE, nearMessage)
    elseif channelType == ChatChannelType.WORLD then
        local worldMessage = {}
        worldMessage.Speaker = sender
        worldMessage.chatContent = message
        worldMessage.type = type
        Net.Helper:sendMessage(NetMessageType.CHAT_WORLD_MESSAGE, worldMessage)
    else
        print("---!!!!!!error  print error channelType")
    end
end

function NetChatSystem:sendErrorMessage(chatFrom, chatTo, errorTypeKey)
    local data = {}
    data.chatFrom = chatFrom
    data.chatTo = chatTo
    data.errorType = errorTypeKey
    Net.Helper:sendMessage(NetMessageType.CHAT_ERROR_MESSAGE, data)
end

function  NetChatSystem:requestAllLampDatas()
    Net.Helper:sendMessage(NetMessageType.REQUEST_ALL_RUNNING_LAMP_DATAS)
end

-- 登录消息处理
function NetChatSystem:onChatMessageHandler(no, data)
    -- print (" Net.NetChatSystem:onNetMessageHandler :no, data  :",no,data)
    -- dump(data, "data")
    local msgData = {}
    if (no == NetMessageType.CHAT_PRIVATE_MESSAGE.NO) then  
        if Game.ChatManager:getInstance():isShieldPlayer(data.chatFrom.pk) then
            self:sendErrorMessage(data.chatFrom, data.chatTo, "PrivateChatErrorType_SHIELDED")
            return
        end
        if GameManager:getShieldChat() then
            return
        end
        
        local GameDataManager = require("app.game.GameDataManager")
        local globalData = GameDataManager:getInstance():getSaveGlobalData()
        if globalData and globalData.isReceivePM and not globalData:isReceivePM() then
            print("------globalData isReceivePM is false--")
            return
        end

        msgData.pbBytes = ProtobufUtil:encode("ChatSystem.PrivateChatMessage", data)
        msgData.messageType = ChatMessageType.PERSONAL
        if ProtobufUtil:checkFieldIsInit(data, "type") then
            msgData.messageType = data.type
        end
        msgData.PBType = ChatChannelType.PERSONAL
        if RoleDataManager:getMaster() and data.chatFrom.pk == RoleDataManager:getMaster():getPK() then
            msgData.isSelf = true
        else
            Avalon.AudioManager:playSound("1510")
            Game.ChatManager:getInstance():refreshPersonalUserID(data.chatFrom) 
            Game.ChatManager:getInstance():insertPersonalList(data.chatFrom, true) 
            Game.ChatManager:getInstance():refreshRedPoint(data.chatFrom.pk, true)
            Game.ChatManager:getInstance():refreshRedPoint(msgData.PBType, true)
            Game.ChatManager:getInstance():push(msgData)
        end
    elseif (no == NetMessageType.CHAT_TEAM_MESSAGE.NO) then
        if Game.ChatManager:getInstance():isShieldPlayer(data.Speaker.pk) then
            return
        end
        if GameManager:getShieldChat() then
            return
        end
        Game.ChatManager:getInstance():refreshPersonalUserID(data.Speaker) 
        msgData.pbBytes = ProtobufUtil:encode("ChatSystem.TeamChatMessage", data)
        msgData.messageType = ChatMessageType.TEAM 
        msgData.PBType = ChatChannelType.TEAM
        Game.ChatManager:getInstance():refreshRedPoint(data.Speaker.pk, true)
        Game.ChatManager:getInstance():refreshRedPoint(msgData.PBType, true)
        Game.ChatManager:getInstance():push(msgData)
    elseif (no == NetMessageType.CHAT_GUILD_MESSAGE.NO) then
        if Game.ChatManager:getInstance():isShieldPlayer(data.Speaker.pk) then
            return
        end
        if GameManager:getShieldChat() then
            return
        end
        Game.ChatManager:getInstance():refreshPersonalUserID(data.Speaker) 
        msgData.pbBytes = ProtobufUtil:encode("ChatSystem.GuildChatMessage", data)
        msgData.messageType = ChatMessageType.GUILD 
        
        msgData.PBType = ChatChannelType.GUILD
        Game.ChatManager:getInstance():refreshRedPoint(data.Speaker.pk, true)
        Game.ChatManager:getInstance():refreshRedPoint(msgData.PBType, true)
        Game.ChatManager:getInstance():push(msgData)
    elseif (no == NetMessageType.CHAT_NEAR_MESSAGE.NO) then
        if Game.ChatManager:getInstance():isShieldPlayer(data.Speaker.pk) then
            return
        end
        if GameManager:getShieldChat() then
            return
        end
        Game.ChatManager:getInstance():refreshPersonalUserID(data.Speaker) 
        msgData.pbBytes = ProtobufUtil:encode("ChatSystem.NearChatMessage", data)
        msgData.messageType = ChatMessageType.NEAR 
        msgData.PBType = ChatChannelType.NEAR
        Game.ChatManager:getInstance():refreshRedPoint(data.Speaker.pk, true)
        Game.ChatManager:getInstance():refreshRedPoint(msgData.PBType, true)
        Game.ChatManager:getInstance():push(msgData)
    elseif (no == NetMessageType.CHAT_WORLD_MESSAGE.NO) then
        if Game.ChatManager:getInstance():isShieldPlayer(data.Speaker.pk) then
            return
        end
        if GameManager:getShieldChat() then
            return
        end
        Game.ChatManager:getInstance():refreshPersonalUserID(data.Speaker) 
        msgData.pbBytes = ProtobufUtil:encode("ChatSystem.WorldChatMessage", data)
        msgData.messageType = ChatMessageType.WORLD 
        msgData.PBType = ChatChannelType.WORLD
        if RoleDataManager:getMaster() and data.Speaker.pk == RoleDataManager:getMaster():getPK() then
            msgData.isSelf = true
        else
            Game.ChatManager:getInstance():refreshRedPoint(data.Speaker.pk, true)
            Game.ChatManager:getInstance():refreshRedPoint(msgData.PBType, true)
        end
         Game.ChatManager:getInstance():push(msgData)
    elseif (no == NetMessageType.CHAT_ERROR_MESSAGE.NO) then
        GameErrorManager:showError(ProtobufUtil:enum_id("ChatSystem.PrivateChatErrorType", data.errorType))
    elseif (no == NetMessageType.CHAT_NEW_SYSTEM_BROADCAST.NO) then
        Game.ChatManager:getInstance():checkSystemBroadcast()
    elseif (no == NetMessageType.CHAT_RUNNING_LAMP.NO) then
    elseif (no == NetMessageType.HERO_BAN_CHAT.NO) then
        MasterDataManager:refreshBanChatData(data)
    elseif (no == NetMessageType.NOTIFY_ALL_RUNNING_LAMP_DATAS.NO) then
        Game.ChatManager:getInstance():refreshRunLampDatas(data.lampDatas)
    elseif (no == NetMessageType.CHAT_SYNC_CD_TIME.NO) then
        local channelType = ProtobufUtil:enum_id("PublicDefine.ChatChannelType", data.channelType)
        local lChannelType = ChatChannelType.NEAR
        if channelType == PublicDefine.ChatChannelType.ChatChannelType_Near then
            lChannelType = ChatChannelType.NEAR
        elseif channelType == PublicDefine.ChatChannelType.ChatChannelType_Team then
            lChannelType = ChatChannelType.TEAM
        elseif channelType == PublicDefine.ChatChannelType.ChatChannelType_Guild then
            lChannelType = ChatChannelType.GUILD
        elseif channelType == PublicDefine.ChatChannelType.ChatChannelType_Private then
            lChannelType = ChatChannelType.PERSONAL
        elseif channelType == PublicDefine.ChatChannelType.ChatChannelType_WorldChat then
            lChannelType = ChatChannelType.WORLD
        end
        UI.ScrollBar:createByText(string.format(UI.TEXT_1170332, data.residualTime))
        Game.ChatManager:getInstance():refreshCDTime(lChannelType, GameManager:getNormalServerTime() + data.residualTime)
    else
        -- assert(false, string.format("LoginManager:onNetMessageHandler no %d is invaild.", no))
    end
end

