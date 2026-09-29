-- DspDamageData.lua
-- Author:zp
-- 2019年1月9日
-- Using:DSP 伤害

require "app.datas.GameData"

local DspDamageData = class("DspDamageData")

Data = Data or {}
Data.DspDamageData = DspDamageData

function DspDamageData:ctor()
    self.isMaster = false
    self.nickName = ""
    self.pk = -1;
    self.damage = 0;      -- 伤害
    self.rank = 0
end

function DspDamageData:init(isMaster, nickName, pk)
    self.isMaster = isMaster
    self.nickName = nickName
    self.pk = pk
end

function DspDamageData:updateData(damage)
    self.damage = damage
end

function DspDamageData:setRank(rank)
    self.rank = rank
end

function DspDamageData:getPK()
    return self.pk
end

function DspDamageData:getRank()
    return self.rank
end

function DspDamageData:getIsMaster()
    return self.isMaster
end

function DspDamageData:getNickName()
    return self.nickName
end

function DspDamageData:getDamage()
    return self.damage
end