-- GuildMemberData.lua
-- Author:zp
-- 2017年9月18日
-- Using:公会数据

require "app.datas.GameData"
local ProtobufUtil = require "utils.ProtobufUtil"

local GuildMemberData = class("GuildMemberData",GameData.Base)

Data = Data or {}
Data.GuildMemberData = GuildMemberData

function GuildMemberData:ctor()
	GuildMemberData.super.ctor(self, Category.GUILD, nil)

    self:init()
end

function GuildMemberData:init()
    self.PK = 0
    -- 角色等级
    self.lv = 0
    -- 个人本周贡献的公会贡献度
    self.contib = 0
    -- PublicDefine::GuildTitle
    self.title = 0
    -- PublicDefine::HERO_LOGIN_STATUS
    self.loginStatus = 0
    -- 脸ID
    self.faceDecodeID = 0
    -- 性别
    self.sex = 0
    -- 名称
    self.name = ""
    -- 用于ID
    self.userID = 0
    -- 是否显示头盔
    self.isShowHelmet = true
    -- 是否在洞穴
    self.isInCave = false
    -- 离线时间(相对于游戏元年的秒数)
    self.offlineTime = 0
    -- 个人公会生涯总贡献
    self.totalContrib = 0
    -- 头盔信息
    self.headID = {}
    -- 武器类型
    self.weaponType = 1
    --转生等级
    self.reincarnationLevel = 0         
end

function GuildMemberData:initNet(data)
    self.PK = data.PK
    self.lv = data.lv
    self.contib = data.contib
    self.title = data.title
    self.loginStatus = data.loginStatus
    self.faceDecodeID = data.faceDecodeID
    self.sex = data.sex
    self.userID = data.userID
    self.name = data.name
    self.isInCave = data.isInCave
    self.offlineTime = data.offlineTime
    self.totalContrib = data.totalContrib
    self.headID = data.headID
    self.weaponType = data.weaponType
    self.reincarnationLevel = data.reincarnationLevel    

    self.name = ToolsUtil:replaceShowNickNameStr(self.name)
    Game.ChatManager:getInstance():refreshPersonalUserID({pk=self.PK, userID=self.userID, nickName = self.name})
end

function GuildMemberData:updateMember(data) 
    if(ProtobufUtil:checkFieldIsInit(data, "lv")) then
        self.lv = data.lv
    end
    if(ProtobufUtil:checkFieldIsInit(data, "contib")) then
        self.contib =data.contib
    end
    if(ProtobufUtil:checkFieldIsInit(data, "userID")) then
        self.userID = data.userID
    end
    if(ProtobufUtil:checkFieldIsInit(data, "loginStatus")) then
        self.loginStatus = data.loginStatus
    end
    if(ProtobufUtil:checkFieldIsInit(data, "faceDecodeID")) then
        self.faceDecodeID = data.faceDecodeID
    end
    if(ProtobufUtil:checkFieldIsInit(data, "offlineTime")) then
        self.offlineTime = data.offlineTime
    end
    if(ProtobufUtil:checkFieldIsInit(data, "isShowHelmet")) then
        self.isShowHelmet = data.isShowHelmet
    end
    if(ProtobufUtil:checkFieldIsInit(data, "nickName")) then
        self.name = data.nickName
        self.name = ToolsUtil:replaceShowNickNameStr(self.name)
    end
    if(ProtobufUtil:checkFieldIsInit(data, "sex")) then
        self.sex = data.sex
    end
    if(ProtobufUtil:checkFieldIsInit(data, "isInCave")) then
        self.isInCave = data.isInCave
    end
    if(ProtobufUtil:checkFieldIsInit(data, "totalContrib")) then
        self.totalContrib = data.totalContrib
    end
    if(ProtobufUtil:checkFieldIsInit(data, "weaponType")) then
        self.weaponType = data.weaponType
    end
    if(ProtobufUtil:checkFieldIsInit(data, "reincarnationLevel")) then
        self.reincarnationLevel = data.reincarnationLevel
    end
    -- TODO 修改相关的逻辑数据

    Game.ChatManager:getInstance():refreshPersonalUserID({pk=self.PK, userID=self.userID, nickName = self.name})
end

-- 获取离线时间
function GuildMemberData:getOfflineTime()
    return self.offlineTime
end

-- 获取登录状态
function GuildMemberData:getLoginStatus()
    return self.loginStatus
end

-- 获取名字
function GuildMemberData:getName()
    return self.name
end

-- 设置头衔
function GuildMemberData:setTitle(title)
    self.title = title
end

-- 获取头衔
function GuildMemberData:getTitle()
    return self.title
end

-- 获取个人公会生涯总贡献
function GuildMemberData:getTotalContrib()
    return self.totalContrib
end

-- 获取成员转生等级
function GuildMemberData:getMemberReinLv()
    return self.reincarnationLevel
end