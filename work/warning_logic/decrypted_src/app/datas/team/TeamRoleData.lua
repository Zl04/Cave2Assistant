
--[[
    处理团队成员 数据定义
]]

require "app.datas.GameData"

local TeamRoleData = class("TeamRoleData",GameData.Base)

Data = Data or {}
Data.TeamRoleData = TeamRoleData

-- 构造函数(会自动调用)  
function TeamRoleData:ctor()
    self.super.ctor(self,Category.TEAM)
    self.kickTime = 0
    self.dismissTime = 0
    self.position = 1
    self.headID = {}
    self.captain = false
    self.userID = 0
    self.guildID = nil
    self.schemeIDs = {}
end

function TeamRoleData:getPK()

    return self.pk
end

function TeamRoleData:getHeadID()
    return self.headID
end

function TeamRoleData:getNickName()
    return ToolsUtil:replaceShowNickNameStr(self.nickName)
end

function TeamRoleData:getState()
	return self.memberStatus
end

function TeamRoleData:setState(value)
    self.memberStatus = value
end

function TeamRoleData:getUserID()
    return self.userID
end

function TeamRoleData:setUserID(value)
    self.userID = value
end

function TeamRoleData:getSex()
    return self.sex
end

function TeamRoleData:getFaceDecodeID()
    return self.faceDecodeID
end

function TeamRoleData:getCaptain()
    return self.captain
end

function TeamRoleData:setCaptain(var)
    self.captain = var
end


function TeamRoleData:getPosition()
    return self.position
end

function TeamRoleData:setGuildId(guildID)
    self.guildID = guildID
end

function TeamRoleData:getGuildId()
    return self.guildID
end

function TeamRoleData:initNet(mesData)
    -- 根据网络数据初始化
    self.pk = mesData.pk or -1
    self.headID = {}
    for k,v in pairs(mesData.headID or {}) do
        table.insert(self.headID,v)
    end

    if mesData.nickName and mesData.nickName ~= "" then
        self.nickName = ToolsUtil:replaceShowNickNameStr(mesData.nickName)
    else
        self.nickName = "pk:"..self.pk;
    end
    self.memberStatus = mesData.memberStatus or 2;

    self.sex = mesData.sex or PublicDefine.HERO_SEX.MALE;

    if mesData.faceDecodeID == nil or mesData.faceDecodeID == 0 then
        self.faceDecodeID = 3010101
    else
        self.faceDecodeID = mesData.faceDecodeID
    end

    -- print("TeamRoleData:initNet",self.faceDecodeID,mesData.faceDecodeID)
    self.captain = mesData.isCaptain or false
    self.position = mesData.position or 1
    self.userID = mesData.userID or 0
    self.schemeIDs = mesData.schemeIDs or {}
    self.guildID = mesData.guildID
end




