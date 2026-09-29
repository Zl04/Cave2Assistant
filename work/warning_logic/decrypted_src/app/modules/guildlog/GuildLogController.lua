--[[--
控制器GuildLogController，view已经注入,可以通过mvc.guildLogProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: 
-- date	: 2019/10/15
-- desc	: 
------------------------------------------------------------------------------
local GuildLogController = class("GuildLogController", mvc.GameController)

function GuildLogController:requestLog()
    local localVersion = mvc.guildLogModel:getLogVersion()
    Net.NetGuildSystem:requestGuildLog(localVersion)
end

-- mvc.events.GUILD_ASW_LOG_MESSAGE 处理函数
function GuildLogController:noticeGUILDASWLOGMESSAGE(notification, data)
    mvc.guildLogModel:initDataNet(data)
    if (self.guildLogView) then
        self.guildLogView:updateView()
    end
end



return GuildLogController