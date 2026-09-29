-- StoryManager.lua
-- Author:ODEI
-- 2017年3月31日
-- Using:新手引导管理
require "utils.reload"
require "utils.Scheduler"
require "app.datas.PublicDefine"
require "app.config.ConfigManager"
require "app.game.GameManager"
require "app.game.GameDefine"
require "app.ui.UIManager"
local MachineManager = require("app.game.MachineManager")
local GameDataManager = require("app.game.GameDataManager")
local PlotManager = require("app.game.PlotManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local SdkManager = require"app.game.SdkManager"

local StoryManager = class("StoryManager")
g_StoryManager = nil;

local ATTR_TYPE_ID_KEY = PublicDefine.ATTR_TYPE_ID_KEY
local scheduler = cc.Director:getInstance():getScheduler()
local DEBUG = false


local StoryStepState = {
	START = 1,--未准备好
    BEGIN = 2,	--可以开始
    RUNING = 3,	--进行中
    END = 4,	--已结束
}



function StoryManager:ctor()
	--新手引导玩家数据
	self.storyStepData = {}

	--标记需要标记的UI
	self.UIEvent = {}

	self.postBattleEvents = {}

	self.storyRunningStep = nil

	self.storyRunningStepList = {}

	self.killer = nil

	self.masterDiedInBattle = false

	-- self.forceToRunInBattle = false

	self.isSceneEntered = false

	--新手引导原始数据
	self.storyData = ConfigManager:getAllStoryConfig()

	self:checkStoryStepState()

	self:registerListener()
end


function StoryManager:dtor()
	self:unRegisterListener()
end


function StoryManager:getInstance()
	if g_StoryManager == nil then
		g_StoryManager = StoryManager.new()
		g_StoryManager:init()
	end
	return g_StoryManager;
end


function StoryManager:purgeInstance()
	if g_StoryManager ~= nil then
		g_StoryManager:dtor();
		g_StoryManager = nil;
	end
end

function StoryManager:init()
	if(DEBUG) then
		printInfo("StoryManager:init")
	end
end

function StoryManager:initData(data)
    self.storyStepData = {}
    for j = 1,#data do
        local _b = tonumber(string.byte(data,j))
        for k = 1,8 do
            local t = bit.band(_b,1)
            if t == 1 then
                -- self.storyStepData[data[(j - 1) * 8 + k] = true
                table.insert(self.storyStepData,(#data - j) * 8 + k)
				--self.storyStepData[(#data - j) * 8 + k] = true
            end
            _b = bit.rshift(_b,1)
        end
    end

	self:checkStoryStepState()
end

--[[
	判断是否在运行中
]]
function StoryManager:isInRun()
	if(self.storyRunningStep) then 
		return true
	end

	if(self.storyRunningStepList and #self.storyRunningStepList > 0) then 
		return true
	end
	
	return false
end

function StoryManager:printData()
	if(DEBUG) then
		printInfo("StoryManager:printData, 保存数据")
	end

	table.sort(self.storyStepData)

	local _data = {}

	local max = 0
	local mark = 0
	for i = 1,#self.storyStepData do
		local _n = math.ceil(self.storyStepData[i]/8.0)
		if _data[_n] == nil then
			_data[_n] = 0
		end 
		_data[_n] = bit._or(_data[_n], math.pow(2,(self.storyStepData[i] - 1)%8))
		if _n >= max then
			max = _n
		end
	end

    local data = ""
    for i = 1,max do
        if _data[i] == nil then
            _data[i] = 0
        end
        data = string.char(_data[i])..data
    end

	Net.NetRoleSystem:netStoryData(data)
end

--检测
function StoryManager:checkStoryStepState()
	if(DEBUG) then
		printInfo("StoryManager:checkStoryStepState")
	end
	
	--判断各个步骤状态
	for k,v in pairs(self.storyData) do
		for i = 1,#(self.storyStepData) do
			if self.storyStepData[i] == v.ID then
				v.state = StoryStepState.END
			end
		end
	end

	-- dump(self.storyStepData)
	for k,v in pairs(self.storyData) do
		if v.state ~= StoryStepState.END then
			local mark = false
			for k1,condition in pairs(v._conditionList) do
				--判断上一步骤是否完成(复合可能)
				if condition.triggerType == 11 then
					for i = 1,#(self.storyStepData) do
						if self.storyStepData[i] == condition.stepID then
							condition.mark = true
							break
						end
					end

					if (not condition.mark) then
						mark = true
						break
					end
				end
			end

			if mark == false then
				v.state = StoryStepState.BEGIN
			end
		end
	end

	-- 添加UI动作, 包括箭头动画
	for k,v in pairs(self.storyData) do
			local mark = false
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 12 then
					if self.UIEvent[condition.uiID] == nil then
						self.UIEvent[condition.uiID] = {}
					end
					table.insert(self.UIEvent[condition.uiID] ,v)
					mark = true
				end
			end

			if mark == false and v._expression and  v._expression.manifestationType == 3 then
				if self.UIEvent[v._expression.typeID] == nil then
					self.UIEvent[v._expression.typeID] = {}
				end
				table.insert(self.UIEvent[v._expression.typeID] ,v)
			end
		--end
	end
end

--进入场景后开始第一次检测
function StoryManager:enterSceneAndStartStory()
	self.isSceneEntered = true
	local master = RoleDataManager:getMaster()
	if (master and master:getCoord()) then
		self:onRoleMoveHandler(
			master:getCoord(),
			master:isMasterHero(),
			master:getSpriteID(),
			master:getDirection()
		)
	end
	return self:checkAllNextStep()
end

function StoryManager:leaveScene()
	self.isSceneEntered = false
end


function StoryManager:checkNPCDisappeared(npcId)
	local machine = MachineManager:getInstance():getMachine()
	if machine and machine._model then
		if (npcId == 0 or npcId == "0") then npcId = nil end
		local npcArr = {}
		npcArr = machine._model:getNpcsForTemplateID(npcId)
		if (#npcArr == 0) then
			return true
		else
			return false
		end
	end
	return false
end

--新UI被加载
function StoryManager:addUICondition(widget)
	
	local mark = false

	if self.UIEvent[widget:getType()] ~= nil and #self.UIEvent[widget:getType()] > 0 then
		for k,v in pairs(self.UIEvent[widget:getType()]) do
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 12 and condition.uiID == widget:getType() then
					condition.widget = widget
					mark = true
				end
			end 
			if v._expression.manifestationType == 3 and v._expression.typeID == widget:getType() then
				v._expression.widget = widget
				mark = true
			end
		end
	end

	if mark then
		self:checkAllNextStep()
	end
end

--UI被移除
function StoryManager:removeUICondition(widget)

	local mark = false

	if self.UIEvent[widget:getType()] ~= nil and #self.UIEvent[widget:getType()] > 0 then
		for k,v in pairs(self.UIEvent[widget:getType()]) do
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 12 and condition.uiID == widget:getType() then
					condition.widget = nil
					mark = true
				end
			end

			if v._expression.manifestationType == 3 and v._expression.typeID == widget:getType() then
				v._expression.widget = nil
				mark = true
			end
		end
	end

	if mark then
		self:checkAllNextStep()
	end
end

--更新角色位置
function StoryManager:onRoleMoveHandler(coord, isMaster, spriteID, direction)
	if (DEBUG) then
		printInfo("StoryManager:onRoleMoveHandler",coord.x,coord.y)
	end

	local mark = false
	
	if not isMaster then
		return
	end

	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 3 then
					local GameMapManager = require("app.game.GameMapManager")
					local conditionMapLevel = checkint(condition.mapLevel)
					if (coord.x >= condition.minX and 
						coord.x <= condition.maxX and 
						coord.y >= condition.minY and 
						coord.y <= condition.maxY and
						   (conditionMapLevel == 0 or
							conditionMapLevel == GameMapManager:getInstance():getLevel()))
					then	
						condition.mark = true
						mark = true
					else
						condition.mark = false
					end
				elseif condition.triggerType == 4 then
					-- 处理
					if not (GameManager:getIsNewTownType() and
						(SceneManager:getInstance():isHome())) then 
						local _machine = MachineManager:getInstance():getMachine()
						if _machine and _machine._model then
							local triggerNPCID = condition.triggerNPCID
							if (triggerNPCID == 0 or triggerNPCID == "0") then triggerNPCID = nil end
							local npcArr = {}
							if (condition.rarity == 1) then
								npcArr = _machine._model:getElitesForTemplateID(triggerNPCID)
							elseif (condition.rarity == 2) then
								npcArr = _machine._model:getSmallBossesForTemplateID(triggerNPCID)
							else
								npcArr = _machine._model:getNpcsForTemplateID(triggerNPCID)
							end

							local isCloseToAny = false
							for i = 1,#npcArr do
								local npcCoord = npcArr[i]:getCoord()
								if coord.x >= npcCoord.x - condition.range and coord.x <= npcCoord.x + condition.range and coord.y >= npcCoord.y - condition.range and coord.y <= npcCoord.y + condition.range then
									isCloseToAny = true
									break
								end
							end

							if (isCloseToAny) then
								mark = true
								condition.mark = true
							else
								-- 在没满足其他条件并且远离了NPC的情况下需要设定条件为未满足, 否则会在满足其他条件过后立马触发
								condition.mark = false
							end
						end
					end
				elseif condition.triggerType == 22 then
					if (condition.stepNow == nil) then
						condition.stepNow = 0
					else
						condition.stepNow = condition.stepNow + 1
					end
					
					if (condition.stepNow >= condition.stepCondition) then
						mark = true
						condition.mark = true
					else
						condition.mark = false
					end
				end
			end
		end
	end

	if mark then
		self:checkAllNextStep()
	end
end

--触发陷阱
function StoryManager:onTriggerTrap(triggerNPCSpine)
	local mark = false
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 16 and condition.triggerNPCSpine == triggerNPCSpine then
					condition.mark = true
					mark = true
				end
			end
		end
	end
	if mark then
		self:checkAllNextStep()
	end
end

--杀死某个怪物
function StoryManager:onKillMonster(monsterID)
	local mark = false
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 7 and condition.monsterID == monsterID then
					condition.mark = true
					mark = true
				end
			end
		end
	end
	if mark then
		self:checkAllNextStep()
	end
end

function StoryManager:onMapLoaded(mapdata)
	if (DEBUG) then
		printInfo("StoryManager:onMapLoaded maplevel:", mapdata:getLevel())
	end

	local mark = false
	local level = -1
	if(mapdata) then 
		level = mapdata:getLevel()
	end
	for k,v in pairs(self.storyData) do
		for k1,condition in pairs(v._conditionList) do
			if condition.triggerType == 17 then
				if condition.mapLevel == level and not SceneManager:getInstance():isInStory() then
					condition.mark = true
					mark = true
				else
					condition.mark = false
				end
			end
		end

		if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 14 and level ~= 9001 then
					condition.mark = false
				end
			end
		end
	end

	if mark then
		self:checkAllNextStep()
	end

	for i,v in ipairs(self.storyRunningStepList) do
		if (v._expression.manifestationType == 11) then
			if (self:checkNextStep(v)) then
				self:showExpression(v)
			end
		end
	end
end

--返回城镇
function StoryManager:onBlackTown()
	if (DEBUG) then
		printInfo("StoryManager:onBlackTown()")
	end

	local mark = false
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 14 then
					condition.mark = true
					mark = true
				end
			end
		end
	end
	if mark then
		self:checkAllNextStep()
	end
end

--显示UI各模块
function StoryManager:onShowMainUILayer(duration)
	local mainUILayer = UI.UIManager.mMainUILayer
	if (mainUILayer and not tolua.isnull(mainUILayer)) then
		performWithDelay(mainUILayer, function()
			self:checkAllNextStep()
		end, duration)
	end
end

--角色数据改变
function StoryManager:onUpdateHeroDataHandler(roleData)
    if roleData:getType() == RoleType.Hero and roleData:getState() ~= FSMState.BATTLE then
        local _pk = roleData:getPK()
        if (DEBUG) then
        	printInfo("StoryManager:onUpdateHeroDataHandler, 角色信息更新, id", _pk)
    	end
        
        if RoleDataManager:getMasterPK() == _pk then
            self:checkAllNextStep()
        end
    end
end


--获得碎片
function StoryManager:onGetFragment(goodsData)
	local mark = false
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 19 then
					condition.mark = true
					mark = true
				end
			end
		end
	end
	if mark then
		self:checkAllNextStep()
	end
end

--完成任务
function StoryManager:onTaskComplete(completeData)
	local mark = false
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 20 and (not condition.taskId or condition.taskId == 0 or condition.taskId == completeData:getId()) then
					condition.mark = true
					mark = true
				end
			end
		end
	end
	if mark then
		self:checkAllNextStep()
	end
end


--操作方式改变
function StoryManager:onControlChange()
	if (DEBUG) then
		printInfo("StoryManager:onControlChange()")
	end
	self:checkAllNextStep()
end

--获得某个物品
function StoryManager:onUpdateItemListHandler()
	if (DEBUG) then
		printInfo("StoryManager:onUpdateItemListHandler")
	end
	self:checkAllNextStep()
end


function StoryManager:runOnceWhenLeaveBattle(target, func)
	assert(type(func) == "function")
	table.insert(self.postBattleEvents, {target = target, func = func})
end

--进入战斗
function StoryManager:onEnterBattle(target)
	self:checkAllNextStep()
end

--退出战斗
function StoryManager:onLeaveBattle()
	-- self.forceToRunInBattle = true
	local mark = false
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 25 then
					condition.mark = true
					mark = true
				end
			end
		end
	end

	if (mark and not self.masterDiedInBattle) then
		self:checkAllNextStep()
	end

	for i,v in ipairs(self.postBattleEvents) do
	 	v.func(v.target)
	end 
	self.postBattleEvents = {}

	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 25 then
					condition.mark = false
				end
			end
		end
	end
end

--英雄在战斗中死亡
function StoryManager:onMasterDiedInBattle(killer)
	if (killer) then cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.InStoryLastKillerIsBoss, killer:isBigBoss()) end

	self.killer = killer
	self.masterDiedInBattle = true
end

--快捷面板打开关闭
function StoryManager:onQuickPackShowHide(isShow)
	local mark = false
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if (condition.triggerType == 24) then
					mark = true
					if ((isShow and condition.isShow == 1) or (not isShow and condition.isShow == 0)) then
						condition.mark = true
					else
						condition.mark = false
					end
				end
			end
		end
	end
	if mark then
		self:checkAllNextStep()
	end
end

--快捷面板内容变化
function StoryManager:onQuickBarContentUpdate(dataArr)
	local mark = false
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if (condition.triggerType == 26) then
					mark = true
					local foundTarget = false
					for i,v in ipairs(dataArr) do
						local test = v:getId()
						if (condition.targetID == v:getId()) then
							foundTarget = true
							break
						end
					end
					if ((condition.isExist == 1 and foundTarget) or (condition.isExist == 0 and not foundTarget)) then
						condition.mark = true
					else
						condition.mark = false
					end
				end
			end
		end
	end
	if mark then
		self:checkAllNextStep()
	end
end


--检测是否可以进行下一步
function StoryManager:checkNextStep(stepData)
	if (DEBUG) then
		printInfo("StoryManager:checkNextStep, stepData = ", stepData)
	end

	--城镇检查开关
	local masterInTown = SceneManager:getInstance():isInTown()
	local notInTown = false
	if (stepData._notInTown and stepData._notInTown == 1) then notInTown = true end
	if (notInTown and masterInTown) then return false end

	--检查新手引导开关
	local masterInStory = SceneManager:getInstance():isInStory()
	local inStoryOnly = false
	if (stepData._inStoryOnly and stepData._inStoryOnly == 1) then inStoryOnly = true end
	if (inStoryOnly and not masterInStory) then return false end

	--检查UI是否隐藏
	local mainUILayer = UI.UIManager.mMainUILayer
	if (stepData._isOnMainUI and stepData._isOnMainUI == 1 and mainUILayer and not tolua.isnull(mainUILayer) and not mainUILayer:isMainUIVisible()) then
		return false
	end

	--检查引导评论开关
	if (stepData._expression.manifestationType == 9 and not CONFIG_COMMENT) then
		return false
	end



	--mark 是否满足条件
	local mark = true


	-- TODO: 整理condition.mark有些没有设置, 会导致conditionType = "OR"失效
	for k,condition in pairs(stepData._conditionList) do
		
		
		-- 1.身上持有一定数量的物品:{triggerType = 1,itemID = 4001,itemNum = 100,rarity = 5,exclusions = {11111},boundaries={2173952, 2197012}}
		if condition.triggerType == 1 then
			local rarity = condition.rarity or 1
			local goodsId = condition.itemID
			if (not goodsId or goodsId == 0 or goodsId == "0") then goodsId = nil end

			local num = GameDataManager:getInstance():getGoodsDataNumInRarityForGoodsID(goodsId, rarity, condition.exclusions, condition.boundaries, true)
			if num >= condition.itemNum then
				condition.mark = true
			else
				condition.mark = false
				mark = false
			end

		-- 2.角色装备某ID的装备:{triggerType = 2,equipID = 21080080,notWearing = 1}
		elseif condition.triggerType == 2 then
			local findEquip = false
			local wearEquipmentDataArr = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
            if (wearEquipmentDataArr) then
                for i = 1, #wearEquipmentDataArr do
                	if wearEquipmentDataArr[i]:getId() == condition.equipID then
                		findEquip = true
                	end
                end
            end


            if ((findEquip == false and tonumber(condition.notWearing) ~= 1) or 
            	(findEquip == true and tonumber(condition.notWearing) == 1)) 
			then
				condition.mark = false
				mark = false
			else
				condition.mark = true
            end
		-- 3.角色走到该地图的某一范围:{triggerType = 3,minX = 1,maxX = 10,minY = 1,maxY = 5,mapLevel=999}
		elseif condition.triggerType == 3 then
			if condition.mark ~= true then
				mark = false
			end
		-- 4.角色走到某NPC附近:{triggerType = 4,triggerNPCID = 10301001,range = 2,rarity = 2}
		elseif condition.triggerType == 4 then
			if condition.mark ~= true then
				mark = false
			end
		-- 5.属性低于某一比例:{triggerType = 5,attrID = 5,maxAttrID = 51,value = 300}
		elseif condition.triggerType == 5 then
			local roleData = RoleDataManager:getMaster()
			if roleData and ATTR_TYPE_ID_KEY[condition.attrID] and ATTR_TYPE_ID_KEY[condition.maxAttrID] and roleData[ATTR_TYPE_ID_KEY[condition.attrID]]/roleData[ATTR_TYPE_ID_KEY[condition.maxAttrID]] < condition.value/1000 and (condition.value == 0 or roleData[ATTR_TYPE_ID_KEY[condition.attrID]]/roleData[ATTR_TYPE_ID_KEY[condition.maxAttrID]] > 0)then
				condition.mark = true
			else
				condition.mark = false
				mark = false
			end
			
		-- 6.属性达到一定数量:{triggerType = 6,attrID = 51,value = 800}
		elseif condition.triggerType == 6 then
			local roleData = RoleDataManager:getMaster()
			if roleData and ATTR_TYPE_ID_KEY[condition.attrID] and roleData[ATTR_TYPE_ID_KEY[condition.attrID]] > condition.value then
				condition.mark = true
			else
				condition.mark = false
				mark = false
			end
		-- 7.击杀某ID的敌人:{triggerType = 7,monsterID = 1001}
		elseif condition.triggerType == 7 then
			if condition.mark ~= true then
				mark = false
			end
		-- -- 8.播放完某个对话以后:{triggerType = 8,dialogue = 1}
		-- elseif condition.triggerType == 8 then
		-- -- 9.播发完某个剧情以后:{triggerType = 9,plot = 1}
		-- elseif condition.triggerType == 9 then

		-- 10.进入战斗:{triggerType=10}
		elseif condition.triggerType == 10 then
			if RoleDataManager:getMaster():getState() ~= FSMState.BATTLE then
				condition.mark = false
				mark = false
			else
				condition.mark = true
			end
		-- 11.上一步骤:{triggerType = 11,stepID = 1}
		elseif condition.triggerType == 11 then
			local _find = false
			for i = 1,#self.storyStepData do
				if self.storyStepData[i] == condition.stepID then
					_find = true
					break
				end
			end
			if _find == false then
				mark = false
				condition.mark = false
			else
				condition.mark = true
			end
		-- 12.打开某一界面:{triggerType = 12,uiID = "8001",notOpen = 1}
		elseif condition.triggerType == 12 then
			if (condition.notOpen == 1) then
				if (condition.widget) then
					mark = false
				end
			else
				if condition.widget == nil then
					mark = false
				end
			end
		-- 13.学习了某个技能{triggerType = 13,skillGroupID = 1001}
		elseif condition.triggerType == 13 then
			local skillID,lv,skillList,skillTreeData = SkillDataManager:getSkillIDBySkillGropuID(condition.skillGroupID)
			if skillID and lv > 0 then
				condition.mark = true
			else
				condition.mark = false
				mark = false
			end
		-- 14.回城{triggerType = 14}
		elseif condition.triggerType == 14 then
			if condition.mark ~= true then
				mark = false
			end
		-- 15.功能解锁{triggerType = 15,functionType = 1}
		elseif condition.triggerType == 15 then
			if RoleDataManager:isUnlockByFunctionType(condition.functionType) ~= true then
				condition.mark = false
				mark = false
			else
				condition.mark = true
			end
		-- 16.陷阱触发{triggerType = 16,triggerNPCSpine = "role_npc_trap_spike"}
		elseif condition.triggerType == 16 then
			if condition.mark ~= true then
				mark = false
			end
		-- 17.地图加载完毕{triggerType = 17,mapLevel = 1}
		elseif condition.triggerType == 17 then
			if condition.mark ~= true then
				mark = false
			end
		-- -- 18.操作模式{triggerType = 18,controlStyle = 1} --1是摇杆, 2是点击
		-- elseif condition.triggerType == 18 then
		-- 	if (GameManager:getMoveType() ~= condition.controlStyle) then
		-- 		mark = false
		-- 	end
		-- 19.获得藏宝碎片{triggerType = 19} 
		elseif condition.triggerType == 19 then
			if condition.mark ~= true then
				mark = false
			end
		-- 20.完成任意任务{triggerType = 20, taskId = 11111} 
		elseif condition.triggerType == 20 then
			if condition.mark ~= true then
				mark = false
			end
		-- 21.检测NPC不存在{triggerType = 21,checkNPCDisappear = 123123123}
		elseif condition.triggerType == 21 then
			if (not self:checkNPCDisappeared(condition.checkNPCDisappear)) then
				mark = false
				condition.mark = false
			else
				condition.mark = true
			end
		-- 22.检测角色步数{triggerType = 22,stepCondition = 5}
		elseif condition.triggerType == 22 then
			local otherConditions = true
			for k, condition in pairs(stepData._conditionList) do
				if (condition.triggerType ~= 22 and not condition.mark) then
					otherConditions = false
					break 
				end
			end
			if (otherConditions == false or condition.mark == true) then
				condition.stepNow = 0
			end
			if (otherConditions == false or not condition.mark) then
				mark = false
			end
		-- 23.检测是否引导评论{triggerType = 23}
		elseif condition.triggerType == 23 then
			-- 调用引导评论是否引导接口
		-- 24.检查快捷道具栏扩展是否打开了{triggerType = 24, isShow = 1}
		elseif condition.triggerType == 24 then
			if condition.mark ~= true then
				mark = false
			end
		-- 25.检查是否刚刚退出了战斗(检测完一次后会被立马设置为false){triggerType = 25}
		elseif condition.triggerType == 25 then
			if condition.mark ~= true then
				mark = false
			end
		-- 26.检查快捷道具栏内容是否满足条件{triggerType = 26, targetID = 21101115, isExist = 1}
		elseif condition.triggerType == 26 then
			if condition.mark ~= true then
				mark = false
			end
		-- 27.检查现在正在运行的步骤{triggerType = 27, runningStepID = 1}
		elseif condition.triggerType == 27 then
			if (not self.storyRunningStep or self.storyRunningStep.ID ~= condition.runningStepID) then
				mark = false
				condition.mark = false
			else
				condition.mark = true
			end
		elseif condition.triggerType == 28 then
			if condition.mark ~= true then
				mark = false
			end
		-- 进入有自动战斗的场景
		elseif condition.triggerType == 29 then
			if condition.mark ~= true then
				mark = false
			end
		-- 检测 背包是否有宠物宝石
		elseif condition.triggerType == 30 then
			local master = RoleDataManager:getMaster()
			if master then 
				local stoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_PET_GEMSTONE,PublicDefine.GOODS_TYPE.GOODS_PET_STONE)
				if stoneArr and #stoneArr > 0 then
					condition.mark = true
				else
					condition.mark = false
					mark = false
				end
			end
		end
		
	end

	if (mark == false and stepData._conditionType == "OR") then
		for k, condition in pairs(stepData._conditionList) do
			if (condition.mark == true) then
				mark = true
				break 
			end
		end
	end

	return mark
end


--检测所有的步骤
function StoryManager:checkAllNextStep()
	if (DEBUG) then
		printInfo("StoryManager:checkAllNextStep storyrunningstep",self.storyRunningStep,SceneManager:getInstance():getIsInLoading())
	end

	if SceneManager:getInstance():getIsInLoading() or not self.isSceneEntered then
		return false
	end

	-- 有些表现形式同时和其他步骤进行的特殊处理一下, 目前有
	-- 12=消除对话框和聚焦指示
	for k,v in pairs(self.storyData) do
		if v._expression and v._expression.manifestationType == 12 and v.state == StoryStepState.BEGIN then
			local mark = self:checkNextStep(v)
			if mark then
				local expressionData = v._expression
				if (RoleDataManager:getMaster():getState() == FSMState.BATTLE) and (not expressionData.forceToRunInBattle or expressionData.forceToRunInBattle == 0) then
					self:runOnceWhenLeaveBattle(self, function() 
						self:doShowExpression(v)
					end)
				else
					self:doShowExpression(v) 
				end
				self:doFinishStep(v)
				break
			end
		end
	end

	-- 一般只会有一个步骤在进行
	if self.storyRunningStep ~= nil then
		return false
	end

	-- 实际检查条件和执行
	local isShowExpression = false
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.BEGIN then
			local mark = self:checkNextStep(v)
			if mark then
				local expressionData = v._expression
				if RoleDataManager:getMaster():getState() == FSMState.BATTLE and (not expressionData.forceToRunInBattle or expressionData.forceToRunInBattle == 0) then
					self:runOnceWhenLeaveBattle(self, function() 
						self:showExpression(v)
					end)
				else
					self:showExpression(v) 
				end
				isShowExpression = true
				break
			end
		end
	end
	return isShowExpression
end


function StoryManager:showExpression(stepData)
	if(stepData.isNewTown == 1 and not GameManager:getIsNewTownType()) then 
		return 
	end

	printInfo("StoryManager:showExpression showing expression", stepData)
	self.storyRunningStep = stepData
	
	local isForceCheckAllNextStep = self:doShowExpression(stepData)
	local expressionData = stepData._expression
	

	--同时执行下一步
	if stepData.type == 1 or 
		expressionData.manifestationType == 4 or 
		expressionData.manifestationType == 6 or 
		expressionData.manifestationType == 7 or
		expressionData.manifestationType == 8 or
		expressionData.manifestationType == 11 or 
		expressionData.manifestationType == 12 
	then
		self:finishStep(stepData)
	end

	if (isForceCheckAllNextStep) then
		self:checkAllNextStep()
	end
end

function StoryManager:doShowExpression(stepData)
	if(stepData.isNewTown == 1 and not GameManager:getIsNewTownType()) then 
		return 
	end

	stepData.state = StoryStepState.RUNING
	local isForceCheckAllNextStep = false
	local expressionData = stepData._expression
	printInfo("StoryManager:showExpression", stepData.ID, expressionData.manifestationType, expressionData.id)
	-- dump(stepData)
	if expressionData.manifestationType == 1 then
		--剧情对话, 显示的同时
		local _, handled = Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, expressionData.id, nil, expressionData.isSwallowTouch)
		if (not handled) then
			printInfo("StoryManager, 没有找到表现处理器", stepData.ID)
			self:finishStep(stepData)
		end
	elseif expressionData.manifestationType == 2 then
		--说明
		-- local pic = "ui_guide_banner_tutorial_"..expressionData.pic..".png"
		-- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_EXPLAIN,pic,LanguageManager:getInstance():getLocalString(expressionData.txt))

	elseif expressionData.manifestationType == 3 then
		--UI中的箭头
		local _, handled = Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_INDICATE_UI,expressionData.widget,expressionData,stepData,expressionData.style,nil,expressionData.isSwallowTouch)
		if (not handled) then
			printInfo("StoryManager, 没有找到表现处理器", stepData.ID)
			self:finishStep(stepData)
		end
	elseif expressionData.manifestationType == 4 then
		--场景中的箭头被替换成了黑圈
		Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_INDICATE_UI,nil,expressionData,stepData,nil,true)
		table.insert(self.storyRunningStepList,stepData)
	elseif expressionData.manifestationType == 5 then
		--plot剧情
		PlotManager:getInstance():runPlotByID(expressionData.id)
	elseif expressionData.manifestationType == 6 then
		--其他
		Avalon.MessageCenter:notice(tonumber(expressionData.param1),expressionData.param2,expressionData.param3,expressionData.param4)
	elseif expressionData.manifestationType == 7 then
		--发送奖励
		if (expressionData.giftID) then
			Net.NetRoleSystem:giftRequst(expressionData.giftID)
			UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111452))
		end
	elseif expressionData.manifestationType == 8 then
		--激活引导评论
		SdkManager:getInstance():checkCommentEvent(COMMENT_TYPE.NOVICE_GUID)
	elseif expressionData.manifestationType == 9 then
		--引导评论剧情对话框(和引导评论一起屏蔽)
		if (CONFIG_COMMENT) then
			Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, expressionData.id)
		end
	elseif expressionData.manifestationType == 10 then
		--移动摄像头
		local duration = expressionData.duration and tonumber(expressionData.duration) / 1000 or 1
		if (expressionData.toMaster and tonumber(expressionData.toMaster) == 1) then
			AvalonUtil:moveCameraToMaster(duration, function()
				self:finishMovingCamera()
			end)
		elseif (expressionData.x and expressionData.y) then
			AvalonUtil:moveCameraToCoord(tonumber(expressionData.x), tonumber(expressionData.y), duration, nil, function()
				self:finishMovingCamera()
			end)
		end
	elseif expressionData.manifestationType == 11 then
		local isShow = tonumber(expressionData.isShow) == 1 and true or false
		local title = LanguageManager:getInstance():getLocalString(tonumber(expressionData.title))
		local x = tonumber(expressionData.x)
		local y = tonumber(expressionData.y)

		-- 处理引导状态
		if (isShow) then
			local exist = false
			for i,v in ipairs(self.storyRunningStepList) do
				if (v.ID == stepData.ID) then exist = true end
			end
			if (not exist) then
				table.insert(self.storyRunningStepList, stepData)
			end
			self.storyRunningStep = nil
			isForceCheckAllNextStep = true
		else
			for i,v in ipairs(self.storyRunningStepList) do
				if (v._expression.manifestationType == 11) then 
					self:doFinishStep(v)
				end
			end
		end

		require "app.command.ControlCommand"
        local data = {
            heroData = RoleDataManager:getMaster(),
            isShow = isShow,
            guideTitle = title,
            x = x,
            y = y
        }
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SET_GUIDE_POINTER, data)
		SceneManager:getInstance():pushCommand(command)
	elseif expressionData.manifestationType == 12 then
		Avalon.MessageCenter:notice(AvalonMessage.MC_UI_FORCE_REMOVE_NPC_DIALOG)
		Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REMOVE_INDICATE_UI)
	else

	end

	return isForceCheckAllNextStep
end


--完成步骤
function StoryManager:finishStep(StoryStepData, isSaveToServer)
	if(StoryStepData.isNewTown == 1 and not GameManager:getIsNewTownType()) then 
		return 
	end

	if (DEBUG) then
		printInfo("StoryManager:finishStep", StoryStepData.ID, self.storyRunningStep.ID)
	end

	if StoryStepData == nil or self.storyRunningStep == nil or StoryStepData.ID ~= self.storyRunningStep.ID then
		return
	end

	for k,v in pairs(self.storyRunningStepList) do
		if v._expression.manifestationType == 4 then
			v.state = StoryStepState.END
		end
	end

	--处理有检测条件的自定义表现事件
	local expressionData = StoryStepData._expression
	if (expressionData.manifestationType == 6) then
		if (expressionData.isCheckingCondition == true) then return end
		expressionData.isCheckingCondition = true

		--有NPC检测条件的表现, NPC消失后才算步骤完成
		if (expressionData.checkNPCDisappear and not self:checkNPCDisappeared(expressionData.checkNPCDisappear)) then
			Avalon.Scheduler:scheduleUpdateOnce(self, function()
				expressionData.isCheckingCondition = false
				--延迟完后再检测一次确认以免重复发送激活NPC消息给服务器
				if (self:checkNPCDisappeared(expressionData.checkNPCDisappear)) then 
					self:doFinishStep(StoryStepData, isSaveToServer)
					return 
				end
				--延迟完毕后检测条件还不通过, 重新做表现
				self:showExpression(StoryStepData)
			end, 0.5)
			return
		end
	end

	--其他种类的表现默认直接完成
	self:doFinishStep(StoryStepData, isSaveToServer)
end

function StoryManager:doFinishStep(StoryStepData, isSaveToServer)
	if (isSaveToServer == nil) then isSaveToServer = true end

	-- 处理正在进行的步骤
	if (self.storyRunningStep and self.storyRunningStep.ID == StoryStepData.ID) then
		self.storyRunningStep.state = StoryStepState.END
		self.storyRunningStep = nil
	else
		StoryStepData.state = StoryStepState.END
	end

	-- 修改本地完成状态
	table.insert(self.storyStepData, StoryStepData.ID)

	if (isSaveToServer) then
		-- 记录步骤
		SdkManager:getInstance():recordStoryModeStep(StoryStepData.ID)

		-- 存储进服务器
		self:printData()
	end

	-- 检查下一步
	self:checkStoryStepState()
	self:checkAllNextStep()
end

function StoryManager:showHeroReviveDialog()
	if(SceneManager:getInstance():isInStory()) then
		
		local function localShowHeroReviveDialog(isBigBoss)
			if (isBigBoss) then
	       		Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, 100024)
	       	else
	       		Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, 100072)
	       	end
		end

		if (self.killer) then
			localShowHeroReviveDialog(self.killer:isBigBoss())
	    else
	    	localShowHeroReviveDialog(cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.InStoryLastKillerIsBoss, false))
       	end
    end
    self.killer = nil
    self.masterDiedInBattle = false
end

--完成镜头移动
function StoryManager:finishMovingCamera()
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.RUNING then
			if v._expression.manifestationType == 10 then
				self:finishStep(v)
			end
		end
	end
end

--完成NPC对话
function StoryManager:finishNPCDialog(NPCDialogID)
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.RUNING then
			if (v._expression.manifestationType == 1 or v._expression.manifestationType == 9) and v._expression.id == NPCDialogID then
				self:finishStep(v)
			end
		end
	end

	-- add by zp 这里就是一个糊涂账，需要在这里和沙之眼的门互动
	-- print("StoryManager:finishNPCDialog(", NPCDialogID)
	if(NPCDialogID == 100301) then 
		-- 这里伪造一个触发事件
		Avalon.MessageCenter:notice(GameMessage.MC_RENDERER_PLOT_NOTICE, "map8_trigger_dialog_half")
	elseif (NPCDialogID == 100304) then 
		Avalon.MessageCenter:notice(GameMessage.MC_RENDERER_PLOT_NOTICE, "map8_trigger_dialog_end")
	end
end


--完成剧情
function StoryManager:finishPlot(plotID)
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.RUNING then
			if v._expression.manifestationType == 5 and v._expression.id == plotID then
				self:finishStep(v)
			end
		end
	end
end

--完成图片展示
function StoryManager:finishExplain()
	for k,v in pairs(self.storyData) do
		if v.state == StoryStepState.RUNING then
			if v._expression.manifestationType == 2 then
				self:finishStep(v)
			end
		end
	end
end

--重置服务器新手引导进度(只有GM工具使用)
function StoryManager:resetProgress()
	Net.NetRoleSystem:netStoryData("")
end

--设置所有新手引导已通过
function StoryManager:setProgressAllFinished(isToSaveDataToServer)
	local storyData = ""
	for i=1, PublicDefine.CONST_DEFINITION.MAX_STORY_DATA_BYTE do
		storyData = storyData .. string.char(255)
	end
	self:initData(storyData)

	if (isToSaveDataToServer) then
		Net.NetRoleSystem:netStoryData(storyData)
	end
end

-- 活动触发设置技能
function StoryManager:onFestivalSettingSkill()
	-- print("StoryManager:onFestivalSettingSkill()")
	local mark = false
	for k,v in pairs(self.storyData) do
		-- if v.state == StoryStepState.BEGIN then
			for k1,condition in pairs(v._conditionList) do
				if condition.triggerType == 28 then
					condition.mark = true
					mark = true
				end
			end
		-- end
	end
	-- print("StoryManager:onFestivalSettingSkill()", mark)
	if mark then
		self:checkAllNextStep()
	end
end

-- 进入战斗场景触发
function StoryManager:onEnterAutoFightScene()
	local mark = false
	for k,v in pairs(self.storyData) do
		for k1,condition in pairs(v._conditionList) do
			if condition.triggerType == 29 then
				condition.mark = true
				mark = true
			end
		end
	end
	if mark then
		self:checkAllNextStep()
	end
end

-- 注册监听事件(可选)
function StoryManager:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_NOVICE_GUIDE_FINISH, self, self.finishStep)

    --完成剧情
    Avalon.MessageCenter:bind(AvalonMessage.MC_FINISH_PLOT, self, self.finishPlot)

    --显示主UI
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_MAINLAYER, self, self.onShowMainUILayer)

    --完成npc对话框
    Avalon.MessageCenter:bind(AvalonMessage.MC_FINISH_NPC_DIALOG, self, self.finishNPCDialog)

    --完成提示框
    Avalon.MessageCenter:bind(AvalonMessage.MC_FINISH_EXPLAIN, self, self.finishExplain)

    --更新角色位置
    Avalon.MessageCenter:bind(GameMessage.MC_ROLE_UPDATE_COORD, self, self.onRoleMoveHandler)

    --杀死某个怪物
    Avalon.MessageCenter:bind(GameMessage.MC_ROLE_KILL_MONSTER, self, self.onKillMonster)

    --触发某个陷阱
    Avalon.MessageCenter:bind(GameMessage.MC_NOVICE_GUIDE_TRIGGER_TRAP, self, self.onTriggerTrap)
    

    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)

    --道具装备变化
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE, self, self.onUpdateItemListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_ITEM_CHANGE, self, self.onUpdateItemListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_MATERIAL_CHANGE, self, self.onUpdateItemListHandler)
	Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_GEM_STONE_CHANGE, self, self.onUpdateItemListHandler)
	Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_TREASURE_CHANGE, self, self.onUpdateItemListHandler)
	

    --人物战斗死亡
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_MASTER_DIED_IN_BATTLE, self, self.onMasterDiedInBattle)

    -- 角色进入战斗
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ENTER_BATTLE, self, self.onEnterBattle)
    -- 角色退出战斗
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, self, self.onLeaveBattle)

    --技能学习
    Avalon.MessageCenter:bind(AvalonMessage.MC_STUDY_SKILL, self, self.checkAllNextStep)

    --功能解锁
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.checkAllNextStep)

	--复活对话框显示
    Avalon.MessageCenter:bind(AvalonMessage.MC_STORY_SHOW_HERO_REVIVE_DIALOG, self, self.showHeroReviveDialog)

    --地图加载完毕
    Avalon.MessageCenter:bind(AvalonMessage.MC_MAP_LOADED, self, self.onMapLoaded)

    --操作改变
    Avalon.MessageCenter:bind(AvalonMessage.MC_SETTING_CONTROL_CHANGE, self, self.onControlChange)

    --获得宝藏图
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_CLOSE_FRAGMENT_DROP, self, self.onGetFragment)

    --完成任务
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.onTaskComplete)
	-- 葫芦娃触发选择技能配置
	Avalon.MessageCenter:bind(AvalonMessage.MC_FEASTIVAL_SETTING_SKILL, self, self.onFestivalSettingSkill)
	Avalon.MessageCenter:bind(AvalonMessage.MC_ENTER_AUTO_FIGHT_SCENE, self, self.onEnterAutoFightScene)
end


-- 注销监听事件(可选)
function StoryManager:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NOVICE_GUIDE_FINISH, self, self.finishStep)

    --完成剧情
    Avalon.MessageCenter:unbind(AvalonMessage.MC_FINISH_PLOT, self, self.finishPlot)

    --完成npc对话框
    Avalon.MessageCenter:unbind(AvalonMessage.MC_FINISH_NPC_DIALOG, self, self.finishNPCDialog)

    --完成提示框
    Avalon.MessageCenter:unbind(AvalonMessage.MC_FINISH_EXPLAIN, self, self.finishExplain)

    --更新角色位置
    Avalon.MessageCenter:unbind(GameMessage.MC_ROLE_UPDATE_COORD, self, self.onRoleMoveHandler)

    --杀死某个怪物
    Avalon.MessageCenter:unbind(GameMessage.MC_ROLE_KILL_MONSTER, self, self.onKillMonster)

    --触发某个陷阱
    Avalon.MessageCenter:unbind(GameMessage.MC_NOVICE_GUIDE_TRIGGER_TRAP, self, self.onTriggerTrap)

    --角色信息更新，其他的英雄
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
	Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)

	--道具装备变化
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE, self, self.onUpdateItemListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_ITEM_CHANGE, self, self.onUpdateItemListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_MATERIAL_CHANGE, self, self.onUpdateItemListHandler)
	Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_GEM_STONE_CHANGE, self, self.onUpdateItemListHandler)
	Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_TREASURE_CHANGE, self, self.onUpdateItemListHandler)
	
   	--人物战斗死亡
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_MASTER_DIED_IN_BATTLE, self, self.onMasterDiedInBattle)

    --技能学习
    Avalon.MessageCenter:unbind(AvalonMessage.MC_STUDY_SKILL, self, self.checkAllNextStep)

    --角色进入战斗
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ENTER_BATTLE, self, self.onEnterBattle)
    --角色退出战斗
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, self, self.onLeaveBattle)

    --功能解锁
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.checkAllNextStep)
    --复活对话框显示
    Avalon.MessageCenter:unbind(AvalonMessage.MC_STORY_SHOW_HERO_REVIVE_DIALOG, self, self.showHeroReviveDialog)

    --复活对话框显示
    Avalon.MessageCenter:unbind(AvalonMessage.MC_MAP_LOADED, self, self.onMapLoaded)

    --操作改变
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SETTING_CONTROL_CHANGE, self, self.onControlChange)

    --获得宝藏图
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CLOSE_FRAGMENT_DROP, self, self.onGetFragment)

    --完成任务
	Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.onTaskComplete)
	-- 葫芦娃触发选择技能配置
	Avalon.MessageCenter:unbind(AvalonMessage.MC_FEASTIVAL_SETTING_SKILL, self, self.onFestivalSettingSkill)
	Avalon.MessageCenter:unbind(AvalonMessage.MC_ENTER_AUTO_FIGHT_SCENE, self, self.onEnterAutoFightScene)
	
end


return StoryManager;













