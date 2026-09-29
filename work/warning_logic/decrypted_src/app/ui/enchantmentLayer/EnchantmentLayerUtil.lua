-- EnchantmentLayerUtil.lua
-- Author:ODEI
-- 2017年5月23日
-- Using:附魔数据

require("app.utils.ToolsUtil")
local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")

local EnchantmentLayerUtil = class("EnchantmentLayerUtil")
g_EnchantmentLayerUtil = nil;

function EnchantmentLayerUtil:getInstance()
	if g_EnchantmentLayerUtil == nil then
		g_EnchantmentLayerUtil = EnchantmentLayerUtil.new()
	end
	return g_EnchantmentLayerUtil;
end


function EnchantmentLayerUtil:purgeInstance()
	if g_EnchantmentLayerUtil ~= nil then
		g_EnchantmentLayerUtil = nil;
	end
end

function EnchantmentLayerUtil:ctor()
	--在这里写数据
	self.mEquipData = nil;	--装备
	self.mMPCost = 0;	--需要消耗的魔法值
	self.mMaterialDatas = {}
end

function EnchantmentLayerUtil:init()
	self.mEquipData = nil;	--装备
	self.mMPCost = 0;	--需要消耗的魔法值
	self.mMaterialDatas = {}
end


--获取当前材料的成功率,名字,对应的数据
function EnchantmentLayerUtil:getEnchantmentProbability()
	local attributeDatas = {}
	self.mMPCost = 0;

	for k,v in pairs (self.mMaterialDatas) do
		local materialID = v:getGoodsID()
		if materialID ~= 0 then
			local materialConfigData = ConfigManager:getMaterialConfigByID(materialID)
			local enchantingAttributeTypeList = string.split(materialConfigData.value1,",")
			local enchantingAttributeLVList = string.split(materialConfigData.value2,",")
			local enchantingSuccessProbList = string.split(materialConfigData.value3,",")


			for j = 1,#enchantingAttributeTypeList do
				local attributeData = {}
				local id = tonumber(enchantingAttributeTypeList[j])
				local mark = false;
				for k = 1,#attributeDatas do
					if attributeDatas[k].id == id and attributeDatas[k].level == tonumber(enchantingAttributeLVList[j]) then
						attributeData = attributeDatas[k]
						mark = true;
						break;
					end
				end

				if mark == false then
					attributeData.id = id;		--属性ID
					attributeData.name = ToolsUtil:getNameByAttrType(id)	--属性对应的名字
					attributeData.probability = tonumber(enchantingSuccessProbList[j]);	--概率
					attributeData.level = tonumber(enchantingAttributeLVList[j]);

					local randAttributeConfigData = ConfigManager:getRandAttributeByID(id)
					attributeData.min = randAttributeConfigData.minValuesByLV[tonumber(enchantingAttributeLVList[j])]
					attributeData.max = randAttributeConfigData.maxValuesByLV[tonumber(enchantingAttributeLVList[j])]

					table.insert(attributeDatas,attributeData)
				else
					attributeData.probability = attributeData.probability + tonumber(enchantingSuccessProbList[j]);	--概率
				end
			end
			local tmpValue = materialConfigData.value4
			if SceneManager:getInstance():isInTownOrInHome() then
				tmpValue = materialConfigData.value5
			end
			self.mMPCost = self.mMPCost + tonumber(tmpValue)
		end
	end

	table.sort(attributeDatas,function(a,b)
		if a.probability == b.probability then
			return a.id > b.id
		else
			return a.probability > b.probability
		end
	end)

	return attributeDatas,self.mMPCost;
end

return EnchantmentLayerUtil;