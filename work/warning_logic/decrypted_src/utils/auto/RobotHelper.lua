--[[
    机器人帮助模块 2017/12/16
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.game.GameDefine"
require "app.game.GameMapManager"
require "app.net.NetInnerSystem"
require "app.net.NetNPCSystem"
require "app.net.NetRoleSystem"
require "app.datas.PublicDefine"
require "app.datas.RoleDataManager"
require "app.datas.SkillDataManager"
require "utils.AvalonUtil"

local GMExecutor = require("app.ui.gmUtil.GMUtilExecutor")
local MapDataManager = require("app.mapkit.model.MapDataManager")
local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")
local RobotConfig = require("utils.auto.RobotConfig")


-- 引用UI命名空间
Auto = Auto or {}

-- 模块声明， 素子
local RobotHelper = Auto.RobotHelper or class("RobotHelper")
Auto.RobotHelper = RobotHelper

-- 私有变量

---------------------------------------
-- eo 模块初始化 --











-- 数据结构 --
---------------------------------------
-- 等待项
-- 应该单独写一个类, 为了简便先用一个很潦草的约定
-- local waitListEntry = {
-- 	target = --[[table]],
-- 	condition = --[[function]],
-- 	run = --[[function]],
--  isOnce = --[[bool]]
-- }
---------------------------------------
-- eo 数据结构 --











-- 程序逻辑 --
---------------------------------------
-- 等待方法 --
--------------------------------------------------
-- 等待检查方法
function RobotHelper:clearWaitLists()
	self._runAndWaitList = {}
	self._waitAndRunList = {}
end

-- 每一帧检测跑->等循环
function RobotHelper:checkRunAndWaitList()
	local now = AvalonUtil:getCurrentTime()
	for i = #self._runAndWaitList, 1, -1 do
		local entry = self._runAndWaitList[i]
		if (entry.condition()) then 
			-- 如果满足等待条件了, 调用回调传回true
			if (entry.callback) then entry.callback(entry.target, true) end
			-- 如果设置了只运行一次开关, 就从列队中把这项去除
			if (entry.isOnce) then table.remove(self._runAndWaitList, i) end
		elseif(entry.timeoutTarget < now) then
			-- 如果不满足条件并且超时, 检测尝试次数
			if(entry.tried <= entry.tryNum) then
				-- 如果未超过尝试次数, 增加舱室次数并添加超时时间
				entry.tried = entry.tried + 1
				entry.timeoutTarget = now + entry.timeout * 1000
				-- 再次尝试运行, 传入尝试目前次数
				entry.run(entry.target, entry.tried)
			else
				-- 如果超过尝试次数, 调用回调传回false
				if (entry.callback) then entry.callback(entry.target, false) end
				-- 如果设置了只运行一次开关, 就从列队中把这项去除
			if (entry.isOnce) then table.remove(self._runAndWaitList, i) end
			end
		end
		-- 如果没有达成条件并且没有超时, 无动作
	end
end

-- 每一帧检测等->跑循环
function RobotHelper:checkWaitAndRunList()
	for i = #self._waitAndRunList, 1, -1 do
		local v = self._waitAndRunList[i]
		if (v.condition(v.target)) then 
			v.run(target)
			if (v.isOnce) then table.remove(self._waitAndRunList, i) end
		end
		
	end
end

-- 检查技能CD列表
function RobotHelper:checkAndRemoveDueSkillCD()
	local now = AvalonUtil:getCurrentTime()
	for skillData, due in pairs(self._cdSkills) do
		if due < now then self._cdSkills[skillData] = nil end
	end
end

-- 等待回调方法
function RobotHelper:waitAndRun(condition, run, isOnce)
	assert(type(condition) == "function")
	assert(type(run) == "function")
	if (isOnce == nil) then isOnce = true end

	local entry = {}
	entry.target = self
	entry.condition = condition
	entry.run = run
	entry.isOnce = isOnce
	table.insert(self._waitAndRunList, entry)
end

function RobotHelper:runAndWait(target, run, condition, callback, timeout, tryNum, isOnce)
	assert(type(condition) == "function")
	assert(type(run) == "function")
	assert(type(callback) == "function")
	assert(type(timeout) == "number" or timeout == nil)
	assert(type(tryNum) == "number" or tryNum == nil)
	timeout	= timeout or 11
	tryNum = tryNum or 6
	if (isOnce == nil) then isOnce = true end

	local entry = {}
	entry.target = target
	entry.run = run
	entry.condition = condition
	entry.callback = callback
	entry.timeout = timeout
	entry.timeoutTarget = 0
	entry.tryNum = tryNum
	entry.tried = 0
	entry.isOnce = isOnce

	table.insert(self._runAndWaitList, entry)
end

function RobotHelper:waitSecondsThenRun(sec, run)
	self:runAndWait(
		self,
		function() end,
		function() return false end,
		run,
		sec,
		1)
end





-- 场景内容数据获取--
----------------------------------------------------
function RobotHelper:getEntrence()
	local npcList = self:getNPCDataMap()
    for k,v in pairs(npcList) do
    	if (v:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then return v end
    end
end

function RobotHelper:getMasterData()
	return RoleDataManager:getMaster()
end

function RobotHelper:getMasterCoord()
	local master = self:getMasterData()
	if (not master) then return nil end
	return master:getCoord()
end

function RobotHelper:isMasterIdle()
	local master = self:getMasterData()
	if (not master) then return false end
	return master:getState() == FSMState.IDLE
end

function RobotHelper:isMasterInBattle()
	local master = self:getMasterData()
	if (not master) then return false end
	return master:getState() == FSMState.BATTLE
end

function RobotHelper:getMapData()
	return g_GameMapManager:getInstance():getMapData()
end

function RobotHelper:getMonsterDataMap()
	return RoleDataManager._monsterMap
end

function RobotHelper:getMonsterCount()
	local monsters = self:getMonsterDataMap()
	local counter = 0
	for k,v in pairs(monsters) do counter = counter + 1 end
	return counter
end

function RobotHelper:getNPCDataMap()
	return RoleDataManager._npcMap
end

-- function RobotHelper:sortMonsterDataMap(list)
-- 	-- TODO: 从近往远排序, 需不需要?
-- 	return list
-- end

function RobotHelper:getAPathableMonster(monsters, filter, maxTryNum)
	filter = filter or {}
	maxTryNum = maxTryNum or RobotConfig.FIND_A_MONSTER_DEFAULT_MAX_TRY
	if (monsters == nil) then return end
	for k,v in pairs(monsters) do
		local tryCount = filter[v] or 0
		if(tryCount ~= -1 and tryCount < maxTryNum and self:isPathable(v.coordX, v.coordY)) then
			return v
		end
	end
	return nil
end

function RobotHelper:getPath(x, y)
	return MachineManager:getInstance():getMachine():GetMapPath(x, y)
end

function RobotHelper:isPathable(x, y)
	return self:getPath(x, y) and true or false
end

function RobotHelper:isInFightScene()
	return SceneManager:getInstance():isInFightScene()
end

function RobotHelper:isAroundCoord(sx, sy, tx, ty)
	if ((math.abs(sx - tx) <= 1 and math.abs(sy - ty) <= 1)) then return true end
	return false
end

function RobotHelper:getAvailableSkillList()
	local activeSkills = SkillDataManager:getMasterLearnActiveSkillList()
	for i=#activeSkills,1,-1 do
		local skillToCheck = activeSkills[i]
		if (self._cdSkills[skillToCheck]) then
			table.remove(self._cdSkills, i)
		end
	end
	return activeSkills
end

function RobotHelper:runSkillCD(skillData)
	self._cdSkills[skillData] = AvalonUtil:getCurrentTime() + skillData:getCooldown()
end

function RobotHelper:getRandAvailCoordNear(x, y, range)
	assert(type(x) == "number")
	assert(type(y) == "number")
	assert(type(range) == "number")

	local mapData = self:getMapData()
	if (not mapData) then return x, y end

	local ok = false
	local counter = 0
	local tx, ty = x, y
	while (not ok and counter < 300) do
		counter = counter + 1
		local randXOffset = math.random(1, range) - (range / 2)
		local randYOffset = math.random(1, range) - (range / 2)
		if ( not (randXOffset == 0 and randYOffset == 0)) then 
			 tx, ty = x + randXOffset, y + randYOffset
			local tileData = mapData:getTileDataAtCoord(tx, ty)
			if (tileData) then ok = tileData:canBeEndOfPath() end
		end
	end
	if (not ok) then tx = x; ty = y end
	return tx, ty
end


-- 主动动作 --
----------------------------------------------------
function RobotHelper:connectToServer()
	local gameLoginManager = require("app.game.GameLoginManager")
	Net.NetInnerSystem:connect(Net.MAIN_SERVER, gameLoginManager:getInstance():getServerUrl(), gameLoginManager:getInstance():getServerPort())
end

function RobotHelper:moveToAndTrigger(x, y)
	MachineManager:getInstance():getMachine():_triggerMasterMove(x, y)
end

function RobotHelper:waitForMasterIdle(callback)
	self:runAndWait(
		self,
		function() end,
		function() return self:isMasterIdle() end,
		function(succeed) callback(succeed) end,
		RobotConfig.KILL_A_MONSTER_WAIT_INTERVAL,
		RobotConfig.KILL_A_MONSTER_WAIT_NUM)
end

function RobotHelper:triggerNPC(spriteID)
	-- 552272273 下一层
	Net.NetNPCSystem:openTriggerNpcRequest(spriteID)
end

function RobotHelper:getBackTown()
	Net.NetRoleSystem:heroGiveUpSaveBackTown()
end

function RobotHelper:getInCave()
	Net.NetRoleSystem:heroEnterCaveSceneRequest(1, 1, 1, 2001,0)
end

-- TODO: 目前在城里走动不稳定, 会出发不存在的NPC事件.
--       需要检查修复, 暂时屏蔽
-- function RobotHelper:wander(callback)
-- 	local master = self:getMasterData()
-- 	if (not master) then return end
-- 	local mCoord = master:getCoord()

-- 	local tx, ty = self:getRandAvailCoordNear(mCoord.x, mCoord.y, RobotConfig.WANDER_RANGE)
-- 	for i=1,10 do
-- 		print("==================", tx, ty, mCoord.x, mCoord.y)
-- 	end
-- 	self:runAndWait(
-- 		self,
-- 		function() self:moveToAndTrigger(tx, ty) end,
-- 		function()
-- 			local curCoord = master:getCoord()
-- 			return self:isAroundCoord(curCoord.x, curCoord.y, tx, ty) and self:isMasterIdle()
-- 		end,
-- 		function(self, succeed) if (callback) then callback(succeed) end end,
-- 		RobotConfig.WANDER_TIMEOUT,
-- 		1)
-- end

-- function RobotHelper:wanderAround(callback)
-- 	self:waitSecondsThenRun(0.5, function() 
-- 		self:wander(function() 
-- 			local wanderFactor = math.random(0, 9)
-- 			if (wanderFactor <= 8) then
-- 				self:wanderAround(callback)
-- 			else
-- 				if (callback) then callback() end
-- 			end
-- 		end)
-- 	end)
-- end

function RobotHelper:useARandomSkill()
	local availableSkillList = self:getAvailableSkillList()
	if (#availableSkillList <= 0) then return end
	local randomIdx = math.random(1, #availableSkillList)
	self:useSkill(availableSkillList[randomIdx])
end

function RobotHelper:useSkill(skillData, target)
	self:runSkillCD(skillData)
	local data = {
		skillData = skillData,
		targetSpriteID = target and target:getSpriteID() or nil
	}
	-- MachineManager:getInstance():getMachine()._battleUseSkill(data)
	test = test or 0 + 1
	for i=1,40 do
		print(test)
	end
	local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initForTypeAndData(CommandType.BATTLE_USE_SKILL,data)
    MachineManager:getInstance():executeCommand(battleCMD)
end


-- 参数设置和获取 --
----------------------------------------------------
function RobotHelper:setGMStatus()
	GMExecutor:heroIsGod(true)
	GMExecutor:atkMax()
end

function RobotHelper:setMaxPathFindRange(range)
	MapDataManager:getInstance():setPathFindRange(range)
end

function RobotHelper:clearRoleManagerData()
	RoleDataManager:clearOtherData()
end

function RobotHelper:setLV1Status()
	if (self._isLV1Set) then return end
	self._isLV1Set = true

	-- 穿戴武器
	local master = self:getMasterData()
	local eqtest = GoodsDataManager:getGoodsArrForPK(
		master:getPK(), PublicDefine.PACKET_TYPE.PACKET_BAG, PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
	Net.NetGoodsSystem:equipEquipmentRequest(eqtest[2]:getEntityID(), 8)

	-- 增加经验
	GMExecutor:addExp(1000)

	self:waitSecondsThenRun(RobotConfig.WAIT_AFTER_LVLUP_TO_LEARN_SKILL, function() 
		-- 学习技能
		Net.NetRoleSystem:heroStudySkill(101001)
	end)
	
end
---------------------------------------
-- eo 程序逻辑 --












-- 生命周期 --
---------------------------------------
local function update(dt)
	Auto.RobotHelper:checkRunAndWaitList()
	Auto.RobotHelper:checkWaitAndRunList()
	Auto.RobotHelper:checkAndRemoveDueSkillCD()
end

function RobotHelper:singletonInit()
	-- 初始化列表
	self._runAndWaitList = {}
	self._waitAndRunList = {}
	self._cdSkills = {}

	-- 初始化状态
	self._isLV1Set = false

	-- 初始化随机数
	math.randomseed(os.time())
	-- 修复初始随机数一样的BUG
	math.random()
	math.random()
	math.random()
	math.random()

	-- 开始等待检测循环
	local scheduler = cc.Director:getInstance():getScheduler()
    updateHandler = scheduler:scheduleScriptFunc(update, 0.0, false)
end
RobotHelper:singletonInit()
---------------------------------------
-- oe 生命周期 --





return RobotHelper