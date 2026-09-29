

require "app.datas.GameData"

local NpcData = class("NpcData",GameData.Base)

Data = Data or {}
Data.NpcData = NpcData

function NpcData:ctor(NPCType,type)
	NpcData.super.ctor(self, NPCType, type)

	self.spriteID = 0
end

function NpcData:getId()
	printError("[ERROR] NpcData:getId this method should be overrided by sub class.")
	-- return self.id
end

-- 获取精灵ID
function NpcData:getSpriteID()
	return self.spriteID
end

-- 获取状态
function NpcData:getState()
    return self._state
end

-- 设置状态
function NpcData:setState(state)
    self._state = state
end

-- 获取位置
function NpcData:getCoord()
    return self._coord
end

-- 设置位置
function NpcData:setCoord(coord)
	self._coord = coord
end

-- 设置方向 
function NpcData:setDirection(direction)
    self._direction = direction
end
-- 获取方向
function NpcData:getDirection()
    return self._direction
end

-- 获取NPC打开状态
function NpcData:getIsOpen()
	if self.isOpened then
		return self.isOpened
	else
		return false
	end
end

-- 设置为开启状态
function NpcData:open()
	if not self.isOpened then
		self.isOpened = true
	end
end

-- 判断是否可以通行
function NpcData:isReachable()
	error("[ERROR] NpcData:isReachable     this method should be overrided by sub class.")
	-- return self.reachable
end

-- 可否被当做寻路节点
function NpcData:canBeNodeOfPath()
	error("[ERROR] NpcData:canBeNodeOfPath     this method should be overrided by sub class.")
end

-- 可否被当做寻路终点
function NpcData:canBeEndOfPath()
	error("[ERROR] NpcData:canBeEndOfPath     this method should be overrided by sub class.")
end

function NpcData:changeInit(data)
	error("[ERROR] NpcData:changeInit     this method should be overrided by sub class.")
end

function NpcData:attrChange(data)
	error("[ERROR] NpcData:attrChange     this method should be overrided by sub class.")
end