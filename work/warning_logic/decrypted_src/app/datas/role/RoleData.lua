

require "app.datas.GameData"

local MapDefine = require "app.mapkit.MapDefine"
local SceneManager = require("app.game.SceneManager")

local RoleData = class("RoleData",GameData.Base)

local FunctionFlag = PublicDefine.FunctionFlag

Data = Data or {}
Data.RoleData = RoleData

function RoleData:ctor(type)
	RoleData.super.ctor(self, Category.ROLE,type)

	self.spriteID = 0
	self.isDead = false	
	-- 用于记录是否处于复活中
	self.isInRevive = false

	self.skillRelatedFlag = 0
    self.functionFlag = 0
	self._functionFlagArr = {}
	self._serverDiamond = nil
end

function RoleData:getId()
	assert(false, "[ERROR] RoleData:getId     this method should be overrided by sub class.")
	-- return self.id
end

-- 获取精灵ID
function RoleData:getSpriteID()
	return self.spriteID
end

-- 获取状态
function RoleData:getState()
    return self._state
end

-- 设置状态
function RoleData:setState(state)
    self._state = state
end

-- 获取位置
function RoleData:getCoord()
    return self._coord
end

-- 设置位置
function RoleData:setCoord(coord)
	self._coord = coord
end

-- 设置方向 
function RoleData:setDirection(direction)
    self._direction = direction
end
-- 获取方向
function RoleData:getDirection()
    return self._direction
end

-- 设置死亡状态
function RoleData:setIsDead(isDead)
	self.deadTime = AvalonUtil.getCurrentTime()
	if (isDead == nil) then
		self.isDead = false
	else
		self.isDead = isDead
	end
	if(self.isDead == false) then 
		self.isInRevive = false
	end
	if(self.isDead == false) then 
		self._serverDiamond = nil
	end
end

function RoleData:getDeadTime()
    return self.deadTime
end

-- 是否死亡
function RoleData:getIsDead()
    return self.isDead
end

-- 设置是否处于复活状态
function RoleData:setIsInRevive(isInRevive)
	if (isRevive == nil) then
		self.isInRevive = false
	else
		self.isInRevive = isInRevive
	end
end

-- 设置死亡状态
function RoleData:getIsInRevive()
	if(self.isInRevive ~= nil) then 
		return self.isInRevive
	end

	return false
end

function RoleData:getHp()
	return self.hp
end

function RoleData:getMp()
	return self.mp
end

-- 设置当前血量
function RoleData:setCurHp(curHp)
    self.curHp = curHp
end

-- 设置当前魔法值
function RoleData:setCurMp(curMp)
    self.curMp = curMp
end

-- 获取当前魔法值
function RoleData:getCurMp()
    return self.curMp or 0
end
-- 获取当前生命值
function RoleData:getCurHp()
    return self.curHp or 0
end
-- 是否处于封印状态
function RoleData:getIsSeal( )
	if(self:haveFunctionFlag(FunctionFlag.FunctionFlag_Seal)) then
		return true
	end

	return false
end

-- 获取是否可以开始战斗
function RoleData:getIsStartAttack()
	if(self:getIsFrozen() or self:getIsStun() or self:getIsConstraint()) then
        return false
    end

	return true
end



-- 判断是否处于冻结
function RoleData:getIsConstraint()
	if(self:haveFunctionFlag(FunctionFlag.FunctionFlag_Constraint)) then
		return true
	end

	return false
end

-- 判断是否处于冻结
function RoleData:getIsFrozen()
	if(self:haveFunctionFlag(FunctionFlag.FunctionFlag_Frozen)) then
		return true
	end

	return false
end

-- 获取是否沉默
function RoleData:getIsSilence()
    if(self:haveFunctionFlag(FunctionFlag.FunctionFlag_Silence) == false) then
        return false
    else
        return true
    end
end

-- 是否处于眩晕
function RoleData:getIsStun()
    if(self:haveFunctionFlag(FunctionFlag.FunctionFlag_Stun) == false) then
        return false
    else
        return true
    end
end

-- 判断是否处于不能使用道具
function RoleData:getIsNOUSEITEM()
	if(self:haveFunctionFlag(FunctionFlag.FunctionFlag_NOUSEITEM)) then
		return true
	end

	return false
end

-- 判断是否可以使用物品
function RoleData:judgeToUseGoods()
	if(self:getState() == FSMState.WAITING) then
		return false
	end

	if(self:getIsDead()) then
		return false
	end

	if(self:getIsStun()) then
		return false
	end

	if(self:getIsFrozen()) then
		return false
	end

	if(self:getIsNOUSEITEM()) then
		return false
	end

	if(self:getIsConstraint()) then
		return false
	end

	return true
end

-- 判断是否可以使用技能
function RoleData:judgeToUseSkill()
	if(self:getIsDead()) then
		return false
	end

	if(self:getIsSilence()) then
		return false
	end

	if(self:getIsStun()) then
		return false
	end

	if(self:getIsFrozen()) then
		return false
	end
	-- if (self:getIsSeal()) then
	-- 	return false
	-- end
	if(self:getIsConstraint()) then
		return false
	end

	return true
end

-- 判断是否可以逃跑
function RoleData:judgeEscape()
	if(self:getIsStun()) then
		return false
	end

	if(self:getIsFrozen()) then
		return false
	end

	if self:getIsDead() then
		return false
	end

	if(self:getIsConstraint()) then
		return false
	end

	return true
end

function RoleData:haveFunctionFlag(functionFlag)
	if(self._functionFlagArr) then
		for k,v in pairs(self._functionFlagArr) do 
			if(v == functionFlag) then
				return true
			end
		end
	end

	return false
end

-- 获取相关的状态
function RoleData:getFunctionFlagArr()
	return self._functionFlagArr
end

-- 开始刷新属性
function RoleData:startUpdateAttr()

end

-- 刷新最终属性
function RoleData:endUpdateAttr()

end

-- 清理战斗状态
function RoleData:clearBattleStatus()
	-- local functionFlagOld = self.functionFlag

	-- -- TODO 这里清理掉了一些不应该清理的数据
    self.skillRelatedFlag = 0
    -- self.functionFlag = 0

	-- self:handleFunctionFlag(functionFlagOld)
end

-- function RoleData:resetData()
-- 	local functionFlagOld = self.functionFlag

--     self.skillRelatedFlag = 0
--     self.functionFlag = 0

-- 	self:handleFunctionFlag(functionFlagOld)
-- end

function RoleData:changeFunctionFlag(functionFlag)
	self:startUpdateAttr()
	self.functionFlag = functionFlag
	self:endUpdateAttr()
end

function RoleData:changeSkillRelatedFlag(skillRelatedFlag)
	local skillRelatedFlagOld = self.skillRelatedFlag
	self.skillRelatedFlag = skillRelatedFlag

	self:handleSkillRelatedFlag(skillRelatedFlagOld)
end

function RoleData:handleSkillRelatedFlag(skillRelatedFlagOld)
	print("RoleData:handleSkillRelatedFlag ", self.spriteID, skillRelatedFlagOld, self.skillRelatedFlag)
    if(skillRelatedFlagOld ~= self.skillRelatedFlag) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SKILL_RELATED_FLAG_CHANGE, self.spriteID, self.skillRelatedFlag)
    end
end

function RoleData:handleFunctionFlag(functionFlagOld)
	-- print("RoleData:handleFunctionFlag ", self.spriteID, functionFlagOld, self.functionFlag)
	if(functionFlagOld ~= self.functionFlag or (self.functionFlag ==0 and self._functionFlagArr ~= nil and #self._functionFlagArr == 0)) then
		-- 处理那些战斗标记被修改了
		local functionFlagArr = self._functionFlagArr
		if(functionFlagArr == nil) then
			functionFlagArr = {}
		end
		self._functionFlagArr = ToolsUtil:splitPositionForValue(self.functionFlag)

		local changeArr = {}
		for k,v in pairs(self._functionFlagArr) do 
			if(functionFlagArr[k] == nil) then
				changeArr[k] = true
			else
				functionFlagArr[k] = nil
			end
		end
		
		for k,v in pairs(functionFlagArr) do
			changeArr[k] = false
		end

		for k,v in pairs(changeArr) do 
			local battleCMD = Command.BattleCommand:create(true)
			battleCMD:initForBattleChange(self.spriteID, k, v)
			SceneManager:getInstance():pushCommand(battleCMD)

			if(self:getType() == RoleType.Hero) then
				if(self:isMasterHero()) then
					-- 发送功能改变
					Avalon.MessageCenter:notice(AvalonMessage.MC_UI_FUNCTION_FLAG_CHANGE_FOR_SKILL, k, v)
					if(k == FunctionFlag.FunctionFlag_Reverse) then
						Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REVERSE_CHANGE, self:haveFunctionFlag(FunctionFlag.FunctionFlag_Reverse))
					elseif(k == FunctionFlag.FunctionFlag_Frozen) then
						GameManager:stopMoveHandler()
					elseif(k == FunctionFlag.FunctionFlag_Constraint) then
						--展现束缚UI
						Avalon.MessageCenter:notice(AvalonMessage.MC_UI_STATUS_CONSTRAINT, v)
						GameManager:stopMoveHandler()
					end
				end

			elseif (self:getType() == RoleType.Pet) then
				-- 改变技能状态
				Avalon.MessageCenter:notice(AvalonMessage.MC_UI_FUNCTION_FLAG_CHANGE_FOR_SKILL_PET, k, v)
			end
		end

		Avalon.MessageCenter:notice(AvalonMessage.MC_UI_FUNCTION_FLAG_CHANGE, self.spriteID)
	end
end

-- 刷新当前数值
function RoleData:refreshCurInitData()
	assert(false, "[ERROR] RoleData:refreshCurData     this method should be overrided by sub class.")
end

-- 判断是否可以通行
function RoleData:isReachable()
	assert(false, "[ERROR] RoleData:getId     this method should be overrided by sub class.")
	-- return self.reachable
end

-- 可否被当做寻路节点
function RoleData:canBeNodeOfPath()
	assert(false, "[ERROR] RoleData:canBeNodeOfPath     this method should be overrided by sub class.")
end

-- 可否被当做寻路终点
function RoleData:canBeEndOfPath()
	assert(false, "[ERROR] RoleData:canBeEndOfPath     this method should be overrided by sub class.")
end

function RoleData:changeInit(data)
	assert(false, "[ERROR] RoleData:changeInit     this method should be overrided by sub class.")
end

function RoleData:attrChange(data)
	assert(false, "[ERROR] RoleData:attrChange     this method should be overrided by sub class.")
end

function RoleData:getIsEnemy()
	return self.isEnemy
end

function RoleData:setIsEnemy(isEnemy)
	self.isEnemy = isEnemy
end
