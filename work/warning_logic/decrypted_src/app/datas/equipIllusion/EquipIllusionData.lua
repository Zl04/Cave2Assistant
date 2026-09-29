-- EquipIllusionData.lua
-- Author: CMonk
-- 2019-1-11
-- 幻化数据结构
-- 注意, 这里有用ID关联两张表, 一张是VirtualGooods, 一张是ProfileEquipoIllusion
-- 还由一个字段关联了第三张幻化组表

require "app.datas.goods.VirtualData"
require "app.config.ConfigManager"
require "app.utils.PlaceholderUtil"
local LanguageManager = require("app.game.LanguageManager")

local EquipIllusionData = class("EquipIllusionData", Goods.VirtualData)

Data = Data or {}
Data.EquipIllusionData = EquipIllusionData

local GOODS_RARE = PublicDefine.GOODS_RARE

-- 构造函数
function EquipIllusionData:ctor(illusionID, isBought)
    EquipIllusionData.super.ctor(self, illusionID)

    self._isBought = isBought or false
end

-- 返回购买状态
function EquipIllusionData:isBought()
	return self._isBought
end

-- 设置购买状态
function EquipIllusionData:setIsBought(b)
	self._isBought = b
end

-- 返回幻化ID
function EquipIllusionData:getIllusionId()
    return self:getId()
end

-- 返回幻化名称
function EquipIllusionData:getIllusionName()
	local name = self:getName()
	if(name == nil) then 
		name = ""
	end

    return name
end

-- 返回幻化解释
function EquipIllusionData:getIllusionDescription()
    return self:geteffecDescription()
end

-- 返回配置信息
function EquipIllusionData:getConfigData()
	return ConfigManager:getEquipIllusionByID(self:getIllusionId())
end

-- 返回幻化名称
function EquipIllusionData:getIllusionName()
	local illusionConfig = self:getConfigData()
	if (not illusionConfig) then return end

	return LanguageManager:getInstance():getLocalString(illusionConfig.name)
end

-- 返回幻化价钱
function EquipIllusionData:getIllusionPrice()
	local illusionConfig = self:getConfigData()
	if (not illusionConfig) then return end

	return illusionConfig.money
end

-- 返回组ID
function EquipIllusionData:getIllusionGroupId()
	local illusionConfig = self:getConfigData()
	if (not illusionConfig) then return end

	return illusionConfig.combinationID
end