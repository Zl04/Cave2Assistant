--[[
   邮件相关的网络消息处理
]]--

Net = Net or {}
local NetMailSystem = {}
Net.NetMailSystem = NetMailSystem
local ProtobufUtil = require("utils.ProtobufUtil")


function NetMailSystem:sendAcceptAward(list, pk)
    local mailList = {}
    for k, v in ipairs(list) do
        local mailData = Game.MailManager:getInstance():getOneMail(v)
        local data = {}
        data.mailID = checkint(mailData.mailID)
        data.mailStrID = mailData.mailID 
        data.subType = mailData.subType
        table.insert(mailList, data)
    end

    Net.Helper:sendMessage(NetMessageType.MAIL_REQUEST_ACCEPT_AWARD, {
        pk = pk,
        mailList = mailList
    })
end

function NetMailSystem:deleteSelectListMail(list, pk)
    -- local msgMailId = math.floor(mailId / 10)
    local mailList = {}
    for k, v in ipairs(list) do
        local mailData = Game.MailManager:getInstance():getOneMail(v)
        local data = {}
        data.mailID = checkint(mailData.mailID)
        data.mailStrID = mailData.mailID 
        data.subType = mailData.subType
        table.insert(mailList, data)
    end

    Net.Helper:sendMessage(NetMessageType.MAIL_DELETE_REQUEST, {
        pk = pk,
        mailList = mailList
    })
end


-- 登录消息处理
function NetMailSystem:onMailMessageHandler(no, data)
    if (no == NetMessageType.MAIL_LOAD_LIST_MESSAGE.NO) then 
        Game.MailManager:getInstance():refreshMailList(data, false, true)
    elseif (no == NetMessageType.MAIL_NOTIFY_LIST_MESSAGE.NO) then  
        Game.MailManager:getInstance():refreshMailList(data, false, false)
        Game.ChatManager:getInstance():sendSystemMsg(UI.TEXT_1170709, ChatMessageType.SYSTEM_MESSAGE)
        Game.MailManager:getInstance():checkLimitAndRemove()
    elseif (no == NetMessageType.MAIL_RESPONSE_ACCEPT_AWARD.NO) then
        UI.WaitingLayer:hideWaiting()
        if data.result == "AcceptAwardResult_success" then
            UI.ScrollBar:createByText(UI.TEXT_1212026)
            Game.MailManager:getInstance():setMailRewardState(data.mailStrID, PublicDefine.MAIL_REWARD_STATE.MailRewardStat_Rewarded)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_RETFRESH_ONE_MAIL_INFO, data.mailStrID)
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("MailSystem.AcceptAwardResult", data.result))
        end
    elseif (no == NetMessageType.MAIL_DELETE_RESPONSE.NO) then
        UI.WaitingLayer:hideWaiting()
        for k, mailData in ipairs(data.mailList) do
            Game.MailManager:getInstance():removeMail(mailData.mailStrID)
        end
        local mailList = Game.MailManager:getInstance():getMailList()
        Avalon.MessageCenter:notice(GameMessage.MC_UI_RETFRESH_MAIL_LIST, mailList)
        UI.ScrollBar:createByText(UI.TEXT_1212047)
        Game.MailManager:getInstance():clearDelMailList()
    else
        assert(false, string.format("NetMailSystem:onMailMessageHandler no %d is invaild.", no))
    end
end

