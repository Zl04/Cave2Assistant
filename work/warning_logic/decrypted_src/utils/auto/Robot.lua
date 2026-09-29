--[[
    机器人模块 2017/12/14
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.game.GameDefine"
require "utils.message.MessageCenter"

local Responder = nil
local Helper = nil
local RobotConfig = nil

-- 引用UI命名空间
Auto = Auto or {}

-- 模块声明， 素子
local Robot = Auto.Robot or class("Robot")
Auto.Robot = Robot

-- 私有变量

---------------------------------------
-- eo 模块初始化 --











-- 程序逻辑 --
---------------------------------------
-- 城里的脚本入口
function Robot:mainInTown()
	Helper:clearRoleManagerData()

	Helper:getInCave()

	--目前在城里走动不稳定, 会出发不存在的NPC事件. 需要检查修复, 暂时屏蔽
	-- Helper:wanderAround(function() 
		
	-- end)
end

-- 洞里的脚本入口
function Robot:mainInCave()
	self._monsters = Helper:getMonsterDataMap()
	self:killAllMonsters(function(killSucceed) if (killSucceed) then
		-- 清怪成功, 下楼
		self:gotoNextLevel(function(goSucceed) if (not goSucceed) then
			-- 下楼失败回城
			Helper:getBackTown()
		end end)
	else
		-- 清怪失败, 回城
		Helper:getBackTown()
	end end)
end

-- 去下一层
function Robot:gotoNextLevel(callback)
	local entrance = Helper:getEntrence()
	if (not entrance) then callback(false) return end
	local eCoord = entrance:getCoord()
	local mCoord = Helper:getMasterCoord()

	Helper:runAndWait(
		self,
		-- 1. 尝试执行: 移动到下层入口
		function() Helper:moveToAndTrigger(eCoord.x, eCoord.y) end,
		-- 2. 等待条件: 检查移动到入口旁并且人物待机
		function() return Helper:isMasterIdle() and Helper:isAroundCoord(mCoord.x, mCoord.y, eCoord.x, eCoord.y) end,
		-- 3. 完成回调: 
		function(self, succeed) 
			-- 目前服务器不检查下楼时的坐标, 不管成功失败都直接下楼
			Helper:triggerNPC(entrance:getSpriteID())
			if (callback) then callback(succeed) end 
		end,
		RobotConfig.GOTO_NEXT_LEVEL_TIMEOUT,
		RobotConfig.GOTO_NEXT_LEVEL_TRY_NUM
	)
end



-- 回溯清怪(急需一个简单的PromiseKit *捂脸苦笑*)
-- 先查找怪物, 没有可以接触到的怪物就算清怪成功.
-- 有可以接触到的怪物就尝试接近怪物, 如果接近成功就打, 接近失败就返回失败.
-- 打怪成功就继续回溯打怪, 打怪失败就判断是否还在战斗中.
--    如果打怪失败后已经不在战斗中, 就视为卡怪, 标记怪死亡, 换怪打
--    如果打怪失败还在战斗中, 就进入长等待.
--        如果长等待成功, 继续清怪
--        如果长等待失败, 返回失败
function Robot:killAllMonsters(callback)
	-- 获取怪物列表
	local monsters = Helper:getMonsterDataMap()
	-- 获取一个能走到的怪物
	local target = Helper:getAPathableMonster(monsters, self._triedMonsters)

	if (target) then 
		-- A. 如果有怪就打, 然后等待行动完成后回调传入打怪成功
		self:approachAMonster(target, function(apSucceed) if (apSucceed) then
			-- 1. 如果接近怪物成功, 杀怪
			self:killAMonster(target, function(killSucceed) if (killSucceed) then
				-- I. 如果杀怪成功, 继续杀怪
				Helper:waitSecondsThenRun(RobotConfig.WAIT_AFTER_KILLING_MONSTER, function() 
					self:killAllMonsters(callback)
				end)
			else
				-- II. 如果杀怪失败, 检查是否为空闲状态
				if (Helper:isMasterIdle()) then
					-- 一. 如果为空闲状态, 换怪继续尝试
					self._triedMonsters[target] = -1
					self:killAllMonsters(callback)
				else
					-- 二. 如果不为空闲状态, 继续长等待打怪
					Helper:waitForMasterIdle(function(wSucceed) if (wSucceed) then
						-- 壹. 长等待成功, 继续打其他怪
						self:killAllMonsters(callback)
					else
						-- 貳. 长等待失败, 清怪失败
						callback(false)
					end end)
				end
			end end)
		else
			-- 2. 如果接近怪物失败, 返回失败
			if (callback) then callback(false) end
		end end)
	else
		-- B. 如果没有怪, 就直接调用回调传回清怪成功
		if (callback) then callback(true) end
	end
end

-- 接近一个怪(然后开始打)
function Robot:approachAMonster(target, callback)
	assert(target ~= nil)
	local mCoord = Helper:getMasterCoord()
	local tCoord = target:getCoord()
	Helper:runAndWait(
		self, 
		-- 1. 尝试 接近一个怪
		function() Helper:moveToAndTrigger(tCoord.x, tCoord.y) end,
		-- 2. 等待条件: 到达指定坐标周围
		function() return Helper:isAroundCoord(mCoord.x, mCoord.y, tCoord.x, tCoord.y) end,
		-- 3. 完成回调: 成功回溯继续打, 失败回调并返回
		function(self, succeed) if (callback) then callback(succeed) end end,
		RobotConfig.APPROACH_A_MONSTER_TIMEOUT,
		RobotConfig.APPROACH_A_MONSTER_TRY_NUM)
end

-- 杀一个怪
function Robot:killAMonster(target, callback)
	assert(target ~= nil)
	Helper:runAndWait(
		self, 
		-- 1. 尝试执行杀一个怪
		function()
			-- 打怪
			Helper:moveToAndTrigger(target:getCoord().x, target:getCoord().y)
			-- 累计怪物尝试次数, 默认高于3 getAPathableMonster就会放弃怪物
			self._triedMonsters[target] = (self._triedMonsters[target] or 0) + 1
		end,
		-- 2. 等待条件: 指定怪死掉,并且动作完成
		function() return target:getIsDead() and Helper:isMasterIdle() end,
		-- 3. 完成回调: 成功设置杀怪开关, 然后回调成功, 失败回调失败
		function(self, succeed)
			if (succeed) then
				self._triedMonsters[target] = -1
				callback(true)
			else
				callback(false)
			end
		end,
		RobotConfig.KILL_A_MONSTER_TIMEOUT,
		RobotConfig.KILL_A_MONSTER_TRY_NUM)
end

-- 清空尝试击杀怪物列表
function Robot:resetTriedMonsters()
	self._triedMonsters = {}
end

-- 渲染优化开关
function Robot:isOp()
	if (self._isOp ~= nil) then return self._isOp end
	if (self:on() and cc.FileUtils:getInstance():isFileExist("RobotOpOn")) then
		self._isOp = true
	else
		self._isOp = false
	end
	return self._isOp
end

-- 检查总开关
function Robot:on()
	if (self._isOn ~= nil) then return self._isOn end
	if (cc.FileUtils:getInstance():isFileExist("RobotOn")) then
		self._isOn = true
		self:start()
	else
		self._isOn = false
	end
	return self._isOn
end
---------------------------------------
-- eo 程序逻辑 --











-- 生命周期 --
---------------------------------------
function Robot:start()
	Responder = require("utils.auto.RobotAutoResponder")
	Helper = require("utils.auto.RobotHelper")
	RobotConfig = require("utils.auto.RobotConfig")

	-- 初始化自己
	self:robotInit()

	-- 初始化固定消息处理
	Responder:init()

	-- 设置最大路径搜索范围
	Helper:setMaxPathFindRange(100)
        
	-- 开始连接服务器
    Helper:connectToServer()
end

function Robot:robotInit()
	-- 设置帧率
	if (self:isOp()) then
		cc.Director:getInstance():setAnimationInterval(1/RobotConfig.FPS)
	end

	-- 清怪列表
	self._triedMonsters = {}

	-- 注册回调
	self:registerCallbacks()
end
---------------------------------------
-- oe 生命周期 --











-- 事件处理 --
---------------------------------------
function Robot:registerCallbacks()
	Avalon.MessageCenter:bind(AvalonMessage.MC_ROBOT_CONTROL_ENTER_SCENE, self, Robot.onEnterScene)
end

function Robot:onEnterScene()
	-- 清理等待执行列表
	Helper:clearWaitLists()

	-- 设置GM状态
	if (RobotConfig.GMSTATUS_SWTICH) then Helper:setGMStatus() end

	-- 设置1级状态
	Helper:setLV1Status()

	-- 清空已杀死怪物
	self:resetTriedMonsters()

	-- 设置自动使用技能
	Responder:setupAutoSkillsInBattle()


	-- 切换场景后延迟运行脚本
	Helper:waitSecondsThenRun(RobotConfig.WAIT_AFTER_SCENE_CHANGE, function() 
		-- 分场景运行脚本
		if (Helper:isInFightScene()) then
			self:mainInCave()
		else
			self:mainInTown()
		end

	end)
end
---------------------------------------
-- eo 事件处理 --





return Robot