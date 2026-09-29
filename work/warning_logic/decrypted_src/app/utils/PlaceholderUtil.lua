-- 模块初始化 --
--------------------------------------------
require "app.datas.RoleDataManager"
local LanguageManager = require("app.game.LanguageManager")

local monsterMatchModel = '#(%d+)_(%d+)_monster'
local monsterSceneMatchModel = '#scene_(%d+)_(%d+)_monster'

PlaceholderUtil = PlaceholderUtil or {}
--------------------------------------------
-- 模块初始化 --







-- 替换#equip 为装备名字
function PlaceholderUtil:parseEquip(txt,templateID)
	-- 替换#equip
	local equipName = "..."
	local equip = GoodsDataManager:createLocalGoodsData(templateID)
	if equip then
		equipName = LanguageManager:getInstance():getLocalString(equip.name)
	end
	txt = string.gsub(txt, "#equip", equipName)

	return txt
end

-- 替换#1_1_monster 为怪物名字 任务名字里面ID前两位为模式 需要截掉
function PlaceholderUtil:parseMonsterForModeAndDiffcult(txt,templateID, mode, difficult)
	-- 替换#monster
	local monsterName = "..."
	local newId = templateID
	if(templateID >= MONSTER_MAX_ID) then 
		newId = string.sub(templateID, 3)
	elseif(templateID >= 1000000) then 
		newId = string.sub(templateID, 1)
	end
	-- print("PlaceholderUtil:parseMonster =",newId, templateID)
	local monsterData = ConfigManager:getMonsterConfig(checkint(newId), mode, difficult)
	if(monsterData == nil) then 
		local newMode, newDifficult = ConfigManager:getMonsterModeAndDiffcultFromMonsterID(checkint(newId))
		if(newMode and newDifficult) then 
			monsterData = ConfigManager:getMonsterConfig(checkint(newId), newMode, newDifficult)
		end
	end
	if monsterData then
		monsterName = LanguageManager:getInstance():getLocalString(monsterData.name)
	end
	txt = string.gsub(txt, monsterMatchModel, monsterName)

	return txt
end

-- 替换#sence_1_1_monster 为怪物名字 任务名字里面ID前两位为模式 需要截掉
function PlaceholderUtil:parseMonsterSceneForModeAndDiffcult(txt,templateID, mode, difficult)
	-- 替换#monster
	local monsterScene = "..."
	local newId = templateID
	if(templateID >= MONSTER_MAX_ID) then 
		newId = string.sub(templateID, 3)
	elseif(templateID >= 1000000) then 
		newId = string.sub(templateID, 1)
	end
	-- print("PlaceholderUtil:parseMonster =",newId, templateID)
	local monsterData = ConfigManager:getMonsterConfig(checkint(newId), mode, difficult)
	if(monsterData == nil) then 
		local newMode, newDifficult = ConfigManager:getMonsterModeAndDiffcultFromMonsterID(checkint(newId))
		if(newMode and newDifficult) then 
			monsterData = ConfigManager:getMonsterConfig(checkint(newId), newMode, newDifficult)
		end
	end
	if monsterData then
		monsterScene = ToolsUtil:getSenceName(monsterData.scenesID)
	end
	txt = string.gsub(txt, monsterSceneMatchModel, monsterScene)

	return txt
end

-- 替换#monster 为怪物名字 任务名字里面ID前两位为模式 需要截掉
function PlaceholderUtil:parseMonster(txt,templateID, mode, difficult)
	-- 替换#monster
	local monsterName = "..."
	local newId = templateID
	if(templateID >= MONSTER_MAX_ID) then 
		newId = string.sub(templateID, 3)
	elseif(templateID >= 1000000) then 
		newId = string.sub(templateID, 1)
	end

	-- print("PlaceholderUtil:parseMonster =",newId, templateID)
	local monsterData = ConfigManager:getMonsterConfig(checkint(newId), mode, difficult)
	if(monsterData == nil) then 
		local newMode, newDifficult = ConfigManager:getMonsterModeAndDiffcultFromMonsterID(checkint(newId))
		if(newMode and newDifficult) then 
			monsterData = ConfigManager:getMonsterConfig(checkint(newId), newMode, newDifficult)
		end
	end
	if monsterData then
		monsterName = LanguageManager:getInstance():getLocalString(monsterData.name)
	end
	txt = string.gsub(txt, "#monster", monsterName)

	return txt
end


-- 替换#monster 为怪物名字 任务名字里面ID前两位为模式 需要截掉
function PlaceholderUtil:parseMonsterById(templateID)
	local monsterName = "..."
	local newId = templateID
	if(templateID >= MONSTER_MAX_ID) then 
		newId = string.sub(templateID, 3)
	elseif(templateID >= 1000000) then 
		newId = string.sub(templateID, 1)
	end

    local difficult = 1
    for mode = PublicDefine.CAVE_MODE.MODE_NORMAL, PublicDefine.CAVE_MODE.MODE_MAX -1, 1 do 
    	local monsterData = ConfigManager:getMonsterConfig(checkint(newId), mode, difficult)
		if monsterData then
			monsterName = LanguageManager:getInstance():getLocalString(monsterData.name)
			break
		end
       
    end
	return monsterName
end


function PlaceholderUtil:parseGoodsName(txt,templateID)
	-- 替换#item
	local itemName = "..."
	local item = GoodsDataManager:createLocalGoodsData(templateID)
	if item then
		itemName = LanguageManager:getInstance():getLocalString(item.name)
	end
	txt = string.gsub(txt, "#goodsname", itemName)

	return txt
end


-- 替换#item 为道具名字
function PlaceholderUtil:parseItem(txt,templateID)
	-- 替换#item
	local itemName = "..."
	local item = GoodsDataManager:createLocalGoodsData(templateID)
	if item then
		itemName = LanguageManager:getInstance():getLocalString(item.name)
	end
	txt = string.gsub(txt, "#item", itemName)

	return txt
end


-- 替换#material 为道具名字
function PlaceholderUtil:parseMaterial(txt,templateID)
	-- 替换#material
	local materialName = "..."
	local material = GoodsDataManager:createLocalGoodsData(templateID)
	if material then
		materialName = LanguageManager:getInstance():getLocalString(material.name)
	end
	txt = string.gsub(txt, "#material", materialName)

	return txt
end
-- 替换#equipset 为套装名字
function PlaceholderUtil:parseEquipset(txt,templateID)
	-- 替换#equipset
	local equipsetName = "..."
	local equipset = ConfigManager:getEquipmentSetBySetMark(templateID)
	if equipset then
		equipsetName = LanguageManager:getInstance():getLocalString(equipset.equipSetName)
	end
	txt = string.gsub(txt, "#equipset", equipsetName)

	return txt
end

-- 替换#treasuremap 为藏宝图名字
function PlaceholderUtil:parseTreasuremap(txt,templateID)
	-- 替换#treasuremap
	local treasuremapName = "..."
	local treasuremap = ConfigManager:getTreasuremapConfigByID(checkint(templateID))
	if treasuremap then
		treasuremapName = LanguageManager:getInstance():getLocalString(treasuremap.name)
	end
	txt = string.gsub(txt, "#treasuremap", treasuremapName)

	return txt
end

-- 替换 #skill 为技能名字
function PlaceholderUtil:parseSkillName(txt,templateID)
	-- 替换#skill
	local skillName = "..."
	local skillData = ConfigManager:getSkillConfigById(checkint(templateID))
	if skillData then
		if tonumber(skillData.name) then 
			skillName = LanguageManager:getInstance():getLocalString(skillData.name)
		else 
			skillName = skillData.name 
		end
	end
	txt = string.gsub(txt, "#skill", skillName)

	return txt
end

-- 替换#mastername为名字
function PlaceholderUtil:parseMasterName(txt)
	-- 替换#name
	local nickName = "..."
    if RoleDataManager:getMaster() ~= nil then
        nickName = RoleDataManager:getMaster():getNickName()
    end
	txt = string.gsub(txt, "#name", nickName)

	return txt
end

--[[
	mode: 只有为替换 ”#monster“ 的时候有效
	difficult: 只有为替换 ”#monster“ 的时候有效
]]
function PlaceholderUtil:formatName(txt,templateID, mode, difficult)
	if(txt) then
		if string.find( txt, "#material") then
			return PlaceholderUtil:parseMaterial(txt,templateID);
		elseif string.find( txt, "#item") then
			return PlaceholderUtil:parseItem(txt,templateID)
		elseif string.find( txt, "#equipset") then
			return PlaceholderUtil:parseEquipset(txt,templateID)
		elseif string.find( txt, "#equip") then
			return PlaceholderUtil:parseEquip(txt,templateID)
		elseif string.find( txt, "#treasuremap") then
			return PlaceholderUtil:parseTreasuremap(txt,templateID)
		elseif string.find( txt, "#goodsname") then
			return PlaceholderUtil:parseGoodsName(txt, templateID)
		elseif string.find( txt, "#skill") then
			return PlaceholderUtil:parseSkillName(txt, templateID)
		elseif string.find( txt, "#monster") then
			return PlaceholderUtil:parseMonster(txt, templateID, mode, difficult)
		elseif string.find( txt, "#name") then
			return PlaceholderUtil:parseMasterName(txt)
		else
			-- 判断是否有怪物场景表现
			local haveOne = false
			local _mode = nil
			local _difficult = nil

			for mode,diff in string.gmatch(txt, monsterSceneMatchModel) do 
				_mode = mode 
				_difficult = diff
				haveOne = true 
				break
			end

			if(haveOne and _mode and _difficult) then 
				txt = PlaceholderUtil:parseMonsterSceneForModeAndDiffcult(txt,templateID, checkint(_mode), checkint(_difficult))
			end 			

			-- 判断是否有怪物名字需要替换
			local haveOne = false
			local _mode = nil
			local _difficult = nil

			for mode,diff in string.gmatch(txt, monsterMatchModel) do 
				_mode = mode 
				_difficult = diff
				haveOne = true 
				break
			end

			if(haveOne and _mode and _difficult) then 
				return PlaceholderUtil:parseMonsterForModeAndDiffcult(txt,templateID, checkint(_mode), checkint(_difficult))
			end 
		end
	end 
	
	return txt;
end
return PlaceholderUtil
