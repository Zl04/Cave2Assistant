-- GuildBossData.lua
-- Author:zp
-- 2019年6月10日
-- Using:公会数据

require "app.datas.GameData"
require "app.config.ConfigManager"

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")

local GuildBossData = class("GuildBossData",GameData.Base)

Data = Data or {}
Data.GuildBossData = GuildBossData

function GuildBossData:ctor()
	GuildBossData.super.ctor(self, Category.GUILD, nil)

    self:init()
end

function GuildBossData:init()
    self.bossIndex = -1
    self.bossID = 0              -- bossID
    self.isFighting = false      -- 是否处于战斗中
    self.buffIDs = {}            -- buff
    self.isKilled = false        -- boss是否被击杀
    self.lossHp = 0              -- boss损失血量  
    -- print("GuildBossData  init" )

    -- required uint32 lossHp = 1;             // boss损失血量
    -- required bool isKilled = 2;             // boss是否被击杀
    -- required uint32 phaseAward = 3;         // 阶段奖励   
    -- // 不一定存库   
    -- optional bool isFighting = 50;          // 是否被挑战
    -- optional uint32 bossID = 51;            // bossID
    -- repeated uint32 buffIDs = 52;           // buff
end

function GuildBossData:initNet(data, bossIndex)
    self.bossIndex = bossIndex
    self.bossID = data.bossID              -- bossID
    self.isFighting = data.isFighting      -- 是否处于战斗中
    self.isKilled = data.isKilled        -- boss是否被击杀
    self.lossHp = data.lossHp              -- boss损失血量  
    -- print("GuildBossData  initNet", self.lossHp)
    -- print(debug.traceback())
    self.buffIDs = {}            -- buff
    if(data.buffIDs) then 
        for k,v in ipairs(data.buffIDs) do 
            table.insert(self.buffIDs, v)
        end
    end
end

function GuildBossData:setIsFighting(isFighting)
    self.isFighting = isFighting
end

function GuildBossData:getBossIndex()
    return self.bossIndex
end

function GuildBossData:getBossID()
    return self.bossID
end

function GuildBossData:getBuffIDS()
    return self.buffIDs
end

function GuildBossData:getLoseHP()
    return self.lossHp
end

function GuildBossData:getIsFighting()
    return self.isFighting
end

function GuildBossData:getIsKilled()
    return self.isKilled
end

function GuildBossData:getIsChallenge()
    if(self:getIsFighting() or self:getIsKilled()) then 
        return false
    end

    return true
end



