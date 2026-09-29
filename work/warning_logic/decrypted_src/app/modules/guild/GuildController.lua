--[[--
控制器GuildController，view已经注入,可以通过mvc.guildProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: ping.zhengping.zhengping.zheng
-- date	: 2019/05/28
-- desc	: 
------------------------------------------------------------------------------
local GuildController = class("GuildController", mvc.GameController)
local ProtobufUtil = require "utils.ProtobufUtil"






-- mvc.events.Guild_SelectFloor_Buy_Buff 处理函数
function GuildController:noticeGuildSelectFloorBuyBuff(notification)
    print("GuildController:noticeGuildSelectFloorBuyBuff")
    Net.NetGuildSystem:reqGuildBuyBuff()
end



-- mvc.events.Guild_SelectFloor_Challenge 处理函数
function GuildController:noticeGuildSelectFloorChallenge(notification)
    local data = notification.params[1]
    print("GuildController:noticeGuildSelectFloorChallenge", data)
    Net.NetGuildSystem:reqGuildFight(data)
end



-- mvc.events.Guild_SelectFloor_Buy_Buff_Result 处理函数
function GuildController:noticeGuildSelectFloorBuyBuffResult(notification)
    local data = notification.params[1]
    if data.err == "GuildBossErr_OK" then
        UI.ScrollBar:createByTextID(1110688)
    else
        GameErrorManager:showError(ProtobufUtil:enum_id("GuildSystem.GuildBossErr", data.err))
    end
    if(not tolua.isnull(self.guildSelectFloorView)) then 
        self.guildSelectFloorView:controllerBuyBuffResult(data)
    end
end



-- mvc.events.Guild_SelectFloor_Challenge_Result 处理函数
function GuildController:noticeGuildSelectFloorChallengeResult(notification)
    local data = notification.params[1]
    GameErrorManager:showError(ProtobufUtil:enum_id("GuildSystem.GuildBossErr", data.err))
    if(not tolua.isnull(self.guildSelectFloorView)) then 
        self.guildSelectFloorView:controllerChallengeResult(data)
    end
end



-- mvc.events.Guild_SelectFloor_Get_Data 处理函数
function GuildController:noticeGuildSelectFloorGetData(notification)

end



-- mvc.events.Guild_SelectFloor_Get_Data_Result 处理函数
function GuildController:noticeGuildSelectFloorGetDataResult(notification)
    local data = notification.params[1]
    if(not tolua.isnull(self.guildSelectFloorView)) then 
        self.guildSelectFloorView:controllerDataUpdate(data)
    end
end



-- mvc.events.Guild_SelectFloor_Data_Update 处理函数
function GuildController:noticeGuildSelectFloorDataUpdate(notification)
    if(not tolua.isnull(self.guildSelectFloorView)) then 
        self.guildSelectFloorView:controllerDataUpdate()
    end
end



-- mvc.events.Guild_SelectFloor_Log_Add 处理函数
function GuildController:noticeGuildSelectFloorLogAdd(notification)
    local data = notification.params[1]
    if(not tolua.isnull(self.guildSelectFloorView)) then 
        self.guildSelectFloorView:controllerAddLog(data)
    end
end



-- mvc.events.GuildTechOrSkill_GuildTechResult 处理函数
function GuildController:noticeGuildTechOrSkillGuildTechResult(notification)
    UI.WaitingLayer:hideWaiting()
    if(not tolua.isnull(self.guildTechOrSkillView)) then 
        self.guildTechOrSkillView:guildTechResult()
    end
end



-- mvc.events.GuildTechOrSkill_GuildSkillResult 处理函数
function GuildController:noticeGuildTechOrSkillGuildSkillResult(notification)
    UI.WaitingLayer:hideWaiting()
end



-- mvc.events.GuildTechOrSkill_GuildTechRequest 处理函数
function GuildController:noticeGuildTechOrSkillGuildTechRequest(notification)
    local data = notification.params[1]
    if(data) then 
        print("GuildTechOrSkill_GuildTechRequest=", data)
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetNPCSystem:sendGuildTech(data.guildId, data.ID, data.number, data.spriteID)
    end
end



-- mvc.events.GuildTechOrSkill_GuildSkillRequest 处理函数
function GuildController:noticeGuildTechOrSkillGuildSkillRequest(notification)
    local data = notification.params[1]
    if(data) then 
        print("GuildTechOrSkill_GuildSkillRequest=", data)
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetGuildSystem:studyGuildSkill(data.spriteID, data.skillID, data.addExp)
    end 
end



-- mvc.events.Guild_SelectFloor_Buy_Personal_Buff 处理函数
function GuildController:noticeGuildSelectFloorBuyPersonalBuff(notification)
    Net.NetGuildSystem:reqGuildBuyPersonalBuff()
end



-- mvc.events.Guild_SelectFloor_Buy_Personal_Buff_Result 处理函数
function GuildController:noticeGuildSelectFloorBuyPersonalBuffResult(notification)
    local data = notification.params[1]
    if data.err == "GuildBossErr_OK" then
        UI.ScrollBar:createByTextID(1110688)
    else
        GameErrorManager:showError(ProtobufUtil:enum_id("GuildSystem.GuildBossErr", data.err))
    end
    if(not tolua.isnull(self.guildSelectFloorView)) then 
        self.guildSelectFloorView:controllerBuyPersonBuffResult(data)
    end
end



return GuildController