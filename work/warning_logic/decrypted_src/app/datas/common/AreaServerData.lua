
--[[
    区服服务器定义
]]

require("app.config.ConfigManager")
require "app.datas.GameData"
require "app.game.GameDefine"
local LanguageManager = require "app.game.LanguageManager"

local AreaServerData = class("AreaServerData")  

Data = Data or {}
Data.AreaServerData = AreaServerData

function AreaServerData:ctor(data)
    self.areaId = data.areaId
    self.targetAreaId = data.targetAreaId
    self.langId = data.langId                   -- 逻辑分区多语言ID
    self.areaName = ""                          -- 用于langId 获取到的web 多语言
    self.property = data.property               -- 逻辑区属性（位或）， AreaProperty
    self.status = data.status                   -- 逻辑区状态（状态互斥）

    self.pk = nil                     -- 英雄 pk
    self.nickname = nil               -- 英雄昵称
    self.lv = 0                       -- 角色等级
    if(self.areaId == 0) then
        self.areaName = LanguageManager:getInstance():getLocalString(1113831)
    end
    self._propertyArr = ToolsUtil:splitPositionForValue(self.property)
end

function AreaServerData:setHeroInfo(pk, nickName, lv)
    self.pk = pk
    self.nickName = nickName
    self.lv = lv or 0
end

function AreaServerData:isNowServer()
    if(RoleDataManager:getMaster()) then 
        if(self.areaId == RoleDataManager:getMaster():getAreaID()) then 
            return true
        end
    end

    return false
end

function AreaServerData:getSaveData()
    return {
        areaId = self.areaId,
        areaName = self.areaName
    }
end

function AreaServerData:getAreaID()
    return self.areaId
end

function AreaServerData:getAreaName()
    return self.areaName
end

function AreaServerData:getLangId()
    if(self.langId ~= 0) then 
        return self.langId
    end
    
    return nil
end

function AreaServerData:getLv()
    
    return self.lv
end

function AreaServerData:setAreaName(name)
    name = name or ""
    self.areaName = name 
end

-- 服务器是否有对应状态
function AreaServerData:havePropertyFlag(property)
    if(self._propertyArr) then
		for k,v in pairs(self._propertyArr) do 
			if(v == property) then
				return true
			end
		end
    end
    
    return false
end
-- 是否推荐区
function AreaServerData:getWasRecommenServer()
    if(self._propertyArr) then
		for k,v in pairs(self._propertyArr) do 
			if(v == PublicDefine.AreaProperty.AreaProperty_Recommend) then
				return true
			end
		end
    end
    
    return false
end

function AreaServerData:getStatus()
    return self.status
end

function AreaServerData:getIsRole()
    if self.pk ~= nil then 
        return true
    end

    return false
end

function AreaServerData:getPK()
    return self.pk
end

function AreaServerData:getNickName()
    return self.nickname
end

function AreaServerData:getRoleStr()
    local str = "◆".."Lv" .. self.lv .." "
    if(self.lv == 0) then
        str = "◆".."Lv1 "
    end
    
    if(self.nickName) then
        str = str..self.nickName
    end

    return str
end


