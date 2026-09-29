-- GuildSkillData.lua
-- Author:zp
-- 2019年9月29日
-- Using:公会数据

require "app.datas.GameData"
local ProtobufUtil = require "utils.ProtobufUtil"

local GuildSkillData = class("GuildSkillData",GameData.Base)

Data = Data or {}
Data.GuildMemberData = GuildMemberData

function GuildSkillData:ctor(guildSkillID)
	GuildSkillData.super.ctor(self, Category.GUILD, nil)

    self.guildSkillID = guildSkillID
    self:init()
end

function GuildSkillData:init()
    
end

function GuildSkillData:initNet(data)
    
end

function GuildSkillData:conbinationLocalData()
    if (self.guildSkillID ~= -1) then
        local localData = ConfigManager:getGuildSkillByType(self.guildSkillID)
        if localData then
            self:initLocalData(localData)
        else
            assert(false, string.format("GuildSkillData:conbinationLocalData  guildSkillID=%d no found local data ",self.guildSkillID))
        end
    end
end