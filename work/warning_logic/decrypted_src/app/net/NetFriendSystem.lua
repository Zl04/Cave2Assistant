
--[[
    好友相关的网络消息处理
]]--

Net = Net or {}
local NetFriendSystem = {}
Net.NetFriendSystem = NetFriendSystem
local ProtobufUtil = require("utils.ProtobufUtil")

function NetFriendSystem:getFriendList(pk, updateTimestamp)
    print("-----NetFriendSystem:getFriendList")
    Net.Helper:sendMessage(NetMessageType.FRIEND_REQUEST_ALL_LIST, {
        PK = pk,
        updateTimestamp = updateTimestamp
    })
end


function NetFriendSystem:deleteFriend(pk, tagerPk)
    print("-----NetFriendSystem:deleteFriend")
    Net.Helper:sendMessage(NetMessageType.FRIEND_DELETE_REQUEST, {
        PK = pk,
        targetPK = tagerPk
    })
end

function NetFriendSystem:inviteFriend(pk, tagerPk)
    print("-----NetFriendSystem:inviteFriend")
    Net.Helper:sendMessage(NetMessageType.FRIEND_INVITE_REQUEST, {
        PK = pk,
        targetPK = tagerPk
    })
end

function NetFriendSystem:handleFriendInvition(pk, tagerPk, isAgree)
    print("-----NetFriendSystem:handleFriendInvition")
    Net.Helper:sendMessage(NetMessageType.FRIEND_HANDLE_INVITE_REQUEST, {
        PK = pk,
        targetPK = tagerPk,
        isAgree = isAgree
    })
end

function NetFriendSystem:deleteBatchFriend(pks)
    print("-----NetFriendSystem:deleteBatchFriend ", pks)
    Net.Helper:sendMessage(NetMessageType.FRIENT_REQ_BATCH_REMOVE, {
        pks = pks
    })
end

-- 消息处理
function NetFriendSystem:onFriendMessageHandler(no, data)
    -- print (" -------------")print (" -------------")print (" -------------")print (" -------------")
    -- print (" -------------Net.NetFriendSystem:onNetMessageHandler :no, data  :",no,data)
    -- dump(data, "data")
    --好友列表
    if (no == NetMessageType.FRIEND_REPONSE_ALL_LIST.NO) then  
        -- dump(data)
        -- print("----------NetMessageType.FRIEND_REPONSE_ALL_LIST", data)

        Game.FriendManager:getInstance():checkAndRefreshFriend(data)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FRIENDLAYER)
    --删除好友响应
    elseif (no == NetMessageType.FRIEND_DELETE_REPONSE.NO) then
        if (data.result == "DeleteFriendResult_success") then
            Game.FriendManager:getInstance():deleteFriend(data.targetPK)
            MasterDataManager:removeRepeatHandleData(RepeatHandleType.FRIEDN_DELETE, data.targetPK)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FRIENDLAYER)
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("FriendSystem.DeleteFriendResult", data.result))
        end
    --发送好友申请响应
    elseif (no == NetMessageType.FRIEND_INVITE_REPONSE.NO) then
        if (data.result == "InviteFriendResult_success") then
            UI.ScrollBar:createByText(UI.TEXT_1170413 )
        elseif (data.result == "InviteFriendResult_targetIsInInviting") then
            UI.ScrollBar:createByText(UI.TEXT_1170414)
        --no tips
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("FriendSystem.InviteFriendResult", data.result))
        end
    --同意 or 拒绝 好友请求响应
    elseif (no == NetMessageType.FRIEND_HANDLE_INVITE_REPONSE.NO) then
        MasterDataManager:removeRepeatHandleData(RepeatHandleType.FRIEDN_INVITE, data.targetPK)
        if (data.result == "ConfirmFriendInviteResult_success") then
            Game.FriendManager:getInstance():deleteInvition(data.targetPK)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FRIENDLAYER)
        elseif (data.result == "ConfirmFriendInviteResult_error") then
            GameErrorManager:showError(ProtobufUtil:enum_id("FriendSystem.ConfirmFriendInviteResult", data.result))
        else
            Game.FriendManager:getInstance():deleteInvition(data.targetPK)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FRIENDLAYER)
            GameErrorManager:showError(ProtobufUtil:enum_id("FriendSystem.ConfirmFriendInviteResult", data.result))
        end
    --notify  好友邀请通知
    elseif (no == NetMessageType.FRIEND_INVITE_NOTIYF.NO) then
        Game.FriendManager:getInstance():addInvition(data.friend)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FRIENDLAYER)
        --XXX 
        -- local str = data.friend.nickName..UI.TEXT_1170409
        -- Game.ChatManager:getInstance():sendSystemMsg(str, ChatMessageType.SYSTEM_FRIEND)
        local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
        local linkStr = Game.ChatManager:getInstance():getNickNameLinkStr(ChatMessageType.SYSTEM_MESSAGE, data.friend.PK, data.friend.userID, data.friend.nickName)
        Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, UI.TEXT_1170409, linkStr, you)
    --notify  添加新好友
    elseif (no == NetMessageType.FRIEND_NEW_FRIEND_NOTIYF.NO) then
        Game.FriendManager:getInstance():addFriend(data.friend)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FRIENDLAYER)
        -- local str = data.friend.nickName..UI.TEXT_1170410
        -- Game.ChatManager:getInstance():sendSystemMsg(str, ChatMessageType.SYSTEM_FRIEND)
        local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
        local linkStr = Game.ChatManager:getInstance():getNickNameLinkStr(ChatMessageType.SYSTEM_MESSAGE, data.friend.PK, data.friend.userID, data.friend.nickName)
        Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, UI.TEXT_1170410, linkStr, you)
    --响应批量删除好友
    elseif (no == NetMessageType.FRIENT_RSP_BATCH_REMOVE.NO) then
        UI.WaitingLayer:hideWaiting()
        if (data.result == "DeleteFriendResult_success") then
            Game.FriendManager:getInstance():deleteBatchFriend(data.pks)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_DELETE_BATCH_FRIEND_CALLBACK, data.pks)
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("FriendSystem.DeleteFriendResult", data.result))
        end
        
    else
        -- assert(false, string.format("LoginManager:onNetMessageHandler no %d is invaild.", no))
    end
end
