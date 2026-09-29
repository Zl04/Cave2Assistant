--[[--
控制器GuildInfoController，view已经注入,可以通过mvc.guildInfoProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: 
-- date	: 2019/10/08
-- desc	: 
------------------------------------------------------------------------------
local GuildInfoController = class("GuildInfoController", mvc.GameController)

-- 申请获取公会信息
function GuildInfoController:requestInfo(guildID)
    Net.NetGuildSystem:requestGuildInfo(guildID)
end

-- 申请入会
function GuildInfoController:requestJoinGuild(guildID)
    local masterPK = RoleDataManager:getMasterPK()
    if (not masterPK) then return end
    Net.NetGuildSystem:reqJoinGuild(masterPK, guildID)
end

-- mvc.events.GUILD_ASW_SIMPLE_GUILD_INFO_MESSAGE 处理函数
function GuildInfoController:noticeGUILDASWSIMPLEGUILDINFOMESSAGE(notification, data)
    mvc.guildInfoModel:initDataNet(data)
    if (self.guildInfoView) then
        self.guildInfoView:updateView()
    end
end

-- mvc.events.GuildApplySuccessful 处理函数
function GuildInfoController:noticeGuildApplySuccessful(notification)
    mvc.guildInfoModel:updateApplyStatus(true)
    if (self.guildInfoView) then
        self.guildInfoView:updateView()
    end
end



-- mvc.events.GuildJoinSuccessful 处理函数
function GuildInfoController:noticeGuildJoinSuccessful(notification, joinGuildID)
    if (self.guildInfoView) then
        local currentGuildID = mvc.guildInfoModel:getCurrentGuildID()
        if (currentGuildID == joinGuildID) then
            mvc.closePanel("GuildInfo", "GuildInfo")
        end
    end
end



return GuildInfoController