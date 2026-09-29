
--[[
    技能进阶数据
]]
require "app.datas.GameData"

local LanguageManager = require("app.game.LanguageManager")

local SkillBlessingData = class("SkillBlessingData",GameData.Base)

Data = Data or {}
Data.SkillBlessingData = SkillBlessingData

-- 构造函数(会自动调用)  
function SkillBlessingData:ctor()
    SkillBlessingData.super.ctor(self, nil)

    self._name = nil
    self._description = nil
end

function SkillBlessingData:getID()
    return self.ID
end

function SkillBlessingData:getAttrType()
    return self.attrType
end

function SkillBlessingData:getName()
    if(self._name == nil) then
        self._name = LanguageManager:getInstance():getLocalString(self.name)
    end 

    return self._name
end

function SkillBlessingData:getAttrValue()
    return self.attrValue
end

function SkillBlessingData:getSkillBlessing()
    return self.skillBlessing
end

function SkillBlessingData:getDescription()
    if(self._description == nil) then
        self._description = LanguageManager:getInstance():getLocalString(self.description)
    end 

    return self._description
end

function SkillBlessingData:initLocal(data)
    if not data then
        return 
    end

    if(data) then 
        self:setLocalConfigData(data)
    end
end

