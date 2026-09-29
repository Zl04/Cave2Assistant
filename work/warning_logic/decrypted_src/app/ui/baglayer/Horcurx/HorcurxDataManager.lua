-- HorcurxDataManager.lua
HorcurxDataManager = HorcurxDataManager or {}
require "app.datas.SkillDataManager"
local GameDataManager = require("app.game.GameDataManager")
local Config

function HorcurxDataManager:init()
	require "app.config.ConfigManager"
	Config = ConfigManager:getHorcurxConfig()
	self.exp = 0
	self.lv = 1
	self.curEvolutionLv = 1
	self.curDailyUpLvCount = {0,0,0}
	self.curIllusionHorcurxId = 1

	self.costConfig1 = Config:getCultureConfigById(1)
	self.costConfig2 = Config:getCultureConfigById(2)
	self.costConfig3 = Config:getCultureConfigById(3)
end


-- message HorcruxInfo
-- {
--     required uint32 lv = 1;                 // 等级
--     required uint32 curLvExp = 2;           // 当前等级后获得的经验
--     required uint32 evolutionLv = 3;        // 进化等级
--     required uint32 exteriorID = 4;         // 外观ID
--     repeated uint32 dailyUpLvCount = 5;     // 每日升级次数
-- }
function HorcurxDataManager:initHorcurxNet(data)

	if data.info then
		self.exp = data.info.curLvExp
		self.lv = data.info.lv
		self.curEvolutionLv = data.info.evolutionLv
		self.curDailyUpLvCount = data.info.dailyUpLvCount
		self.curIllusionHorcurxId = data.info.exteriorID
	end

end



function HorcurxDataManager:updateHorcurxLvUpNet(data)
	local oldLv = self.lv
	self.lv = data.lv
	local addExp = data.curLvExp - self.exp
	if addExp < 0 then
		addExp = data.curLvExp
	end
	self.exp = data.curLvExp
	self.curDailyUpLvCount = data.dailyUpLvCount
	local addCount = data.addCount
	UI.WaitingLayer:hideWaiting()
	Avalon.MessageCenter:notice(GameMessage.MC_UI_HORCURX_INFO_UPDATE, 
		{isUpLv = true, isLevelChanged = oldLv < self.lv, isCritical = data.isCritical, addExp = addExp,addCount = addCount})

	if oldLv < self.lv then
		--提示  魂器等级提升，停止升级，返回剩余魂之神灯
		UI.ScrollBar:createByText(UI.TEXT_1325800)
	end
	
end

function HorcurxDataManager:updateHorcurxEvolutionUpNet(data)
    self.lv = data.lv
    self.exp = data.curLvExp
    self.curEvolutionLv = data.evolutionLv
	Avalon.MessageCenter:notice(GameMessage.MC_UI_HORCURX_INFO_UPDATE, {isEvolution = true})
end

function HorcurxDataManager:updateHorcurxSetEquipHorcurxNet(data)
	self.curIllusionHorcurxId = data.exteriorID
	Avalon.MessageCenter:notice(GameMessage.MC_UI_HORCURX_INFO_UPDATE, {isIllusion = true})
	RoleDataManager:getMaster():setHorcruxExteriorId(self.curIllusionHorcurxId)
end

function HorcurxDataManager:getHorcurxIllusionId()
	return self.curIllusionHorcurxId
end

function HorcurxDataManager:getHorcurxIllusionDefaultId()
	if self:isCanEvolutionToNext() then
		return self.curEvolutionLv + 1
	end
	return self.curIllusionHorcurxId
end


function HorcurxDataManager:getCurHorcurxCurrency()
	
	return RoleDataManager:getMaster():getHorcruxCoin()
end

function HorcurxDataManager:getCurLevel()
	return self.lv
end

function HorcurxDataManager:getCurExp()
	return self.exp
end

function HorcurxDataManager:getTodayCanUpgradeRemindAndMaxTime()
	local upConfig = self:getUpgradeConfigByLevel(self.lv)
	local moneyTab = string.split(upConfig.money, ";")
	local moneyConfig = {}
	for i = 1, #moneyTab do
		moneyConfig[i] = string.split(moneyTab[i], ",")
	end


	return {
	{self.curDailyUpLvCount[1],self.costConfig1.limit,moneyConfig[1][2]},
	{self.curDailyUpLvCount[2],self.costConfig2.limit,moneyConfig[2][2]},
	{self.curDailyUpLvCount[3],self.costConfig3.limit == 0 and 999 or self.costConfig3.limit,moneyConfig[3][2]}
}
end

function HorcurxDataManager:getMaxLevelCurEvolution(lv)
    local config = self:getUpgradeConfigByLevel(lv)
	local curEvolution = config.evolution
	for i = 1, 100 do
		local nextConfig = self:getUpgradeConfigByLevel(lv + i)
		if nextConfig then
			if nextConfig.evolution > curEvolution then
				return lv + i - 1
			end
		else
			return lv + i - 1
		end
	end
end



function HorcurxDataManager:getExpPercent(lv)
    local config = self:getUpgradeConfigByLevel(lv)
	return self.exp/config.expToNextLV
end



function HorcurxDataManager:getUpgradeConfigByLevel(lv)
	return Config:getUpdateConfigById(lv)
end

function HorcurxDataManager:getEvolutionConfigByGradeLevel(lv)
	for i = lv, 1, -1 do
		local config = self:getUpgradeConfigByLevel(i)
		if config.evolution > 0 then
			return Config:getEvolutionConfigById(config.evolution)
		end
	end
	return Config:getEvolutionConfigById(1)
end



function HorcurxDataManager:getHorcurxScore(lv)
    local config = HorcurxDataManager:getUpgradeConfigByLevel(lv)
	local attrName = {
		"atkMin",  
		"atkMax", 
		"magic",
		"hp",
		"physicDef",
		"magicDef",
		"atkFire",
		"defFire",
		"atkWater",
		"defWater",
		"atkWood",
		"defWood",
		"atkLight",
		"defLight",
		"atkDark",
		"defDark",
	}
    local attrVal = {}
    local attrType = {}
    for i = 1, #attrName do
        attrVal[i] = config[attrName[i]]
		attrType[i] = PublicDefine.ATTR_TYPE[attrName[i]]
    end


    local combatScoreRate = GameDataManager:getInstance():getCombatScoreRate()
    local combatScore = 0
    for idx,aType in pairs(attrType) do
        combatScore = combatScore + 
        	math.floor(combatScoreRate[aType] * attrVal[idx]/RATIO_NUMBER)
    end

	return combatScore
end


function HorcurxDataManager:isCanEvolutionTo(toEvolutionLv)
	local curEvolutionLv = self:getHorcurxEvolutionLv(self.lv)
	if toEvolutionLv - curEvolutionLv == 1 then
		return self:isCanEvolutionToNext()
	end
	return false
end

function HorcurxDataManager:isCanEvolutionToNext()
	local curEvolutionLv = self:getHorcurxEvolutionLv(self.lv)
	local nextEvolutionLv = self:getHorcurxEvolutionLv(self.lv + 1)
	if nextEvolutionLv > 0 and nextEvolutionLv - curEvolutionLv == 1 then
    	local config = self:getUpgradeConfigByLevel(self.lv)
		if self.exp >= config.expToNextLV then
			return true, nextEvolutionLv
		end
	end

	return false, nextEvolutionLv
end


function HorcurxDataManager:getSkillInfosByEvolutionLv(evolutionLv)
	local skillId = Config:getEvolutionConfigById(evolutionLv).NewSetSkill
	return {{skillId,1}}
end

function HorcurxDataManager:getSkillData(skillID)
	return SkillDataManager:createSkillForSkillId(skillID)
end



--------------Evolation
function HorcurxDataManager:getHorcurxEvolutionLv(lv)
	local config
	for i = 0, 100 do
    	local config = self:getUpgradeConfigByLevel(lv - i)
    	if not config then
    		return 1
    	end
    	if config.evolution and config.evolution > 0 then
	    	return config.evolution
	    end
	end

	return 1
end

function HorcurxDataManager:getHorcurxEvolutionConfig(evolutionLv)
    return Config:getEvolutionConfigById(evolutionLv)
end

function HorcurxDataManager:getHocruxLooks()
	local config = self:getHorcurxEvolutionConfig(self:getHorcurxIllusionId())
	if config then
		return config.appearance
	end
	return -1	
end

function HorcurxDataManager:getHocruxLooksAnimation(idx)
	local config = self:getHorcurxEvolutionConfig(idx or self:getHorcurxIllusionId())
	return "role_npc_" .. config.position .. ".json", "role_npc_" .. config.position .. ".atlas", 1
end


function HorcurxDataManager:getCurTransformSkillIds()
	local config = self:getHorcurxEvolutionConfig(self:getHorcurxIllusionId())
	local skillIds = {}
	if config then
		local skillStr = config.changeSkill
		skillIds = string.split(skillStr, ";")
	end
	return skillIds
end

function HorcurxDataManager:isHocruxEnergyFull()
	if self:getHorcurxIllusionId() <= 0 then
		return false
	end
	local master = RoleDataManager:getMaster()
	return (master.horcruxEnergy or 0) >= PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE 
end


function HorcurxDataManager:getHorcurxName(evolutionLv)
    return Config:getEvolutionConfigById(evolutionLv).name
end

function HorcurxDataManager:isMaxEvolationLv(lv)
	return Config:getEvolutionConfig().size == lv
end


HorcurxDataManager:init()