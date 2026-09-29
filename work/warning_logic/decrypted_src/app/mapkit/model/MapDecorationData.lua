local MapDefine = require "app.mapkit.MapDefine"
local MapDecorationData = class("MapDecorationData")

function MapDecorationData:ctor(config, spawnConfig)
	self.direction = MapDefine.DirectionType.West -- decoration has default direction west
	self.ZOrderBasePoint = MapDefine.BoundingPoint.BottomLeft
	self:setConfig(config)
	if spawnConfig ~= nil then
		self:setSpawnConfig(spawnConfig)
	end

	self.clickNum = 0
end

function MapDecorationData:setConfig(config)
	self.ID = config.ID
	self.effectColorID = config.effectColorID
	self.radiationRadius = config.effectColorRadiationRadius
	self.skin = config.skin
	self.occupySize = {width = config.occupySize[1], height = config.occupySize[2]}
	self.offset = {x = config.offset[1], y = config.offset[2]}
	self.reachable = config.reachable == 1
	self.onGround = config.onGround == 1
	self.flipAtX = config.flipAtX == 1
	self.ZOrderBasePoint = config.ZOrderBasePoint
	self.destructible = config.destructible == 1

	self.nodeOfPath = self.reachable
	self.endOfPath = self.reachable
	self.light = config.light

	self.type = config.type
	self.tapNum = config.tapNum

	self.rotate = config.rotate
	self.ExtraMethod = config.ExtraMethod
end

function MapDecorationData:setSpawnConfig(config)
	self.generateTerrainType = config.generateTerrainType
	self.finalTerrainType = config.finalTerrainType
	self.separate = config.separate == 1
end

function MapDecorationData:adjustForDirection()
	-- All elemnents are designed to face west in default
	if self.direction == MapDefine.DirectionType.South then
		self.offset = ({x = self.offset.x * - 1, y = self.offset.y})
		self.occupySize = ({width = self.occupySize.height, height = self.occupySize.width})
	end
end

function MapDecorationData:setDirection(direction)
	self.direction = direction
	self:adjustForDirection()
end

function MapDecorationData:isSkinPNG() 
	return self.skin:find(".png") ~= nil
end

function MapDecorationData:getID()
	return self.ID
end

function MapDecorationData:getEffectColorID()
	return self.effectColorID
end

function MapDecorationData:setEffectColor(effectColor)
	self.effectColor = effectColor
end

function MapDecorationData:getEffectColor()
	return self.effectColor
end

function MapDecorationData:setClickNum(clickNum)
	self.clickNum = clickNum
end

function MapDecorationData:getClickNum()
	return self.clickNum
end

function MapDecorationData:getIsTrap()
	if(self.type == 1) then
		return true
	else 
		return false
	end
end

function MapDecorationData:getTapNum()
	return self.tapNum
end

function MapDecorationData:getSkin()
	return self.skin
end

function MapDecorationData:setSkin(skin)
	self.skin = skin
end

function MapDecorationData:getOccupySize()
	return self.occupySize
end

function MapDecorationData:getRadiationRadius()
	return self.radiationRadius
end

function MapDecorationData:getGenerateTerrainType()
	return self.generateTerrainType
end

function MapDecorationData:getFinalTerrainType()
	return self.finalTerrainType
end

function MapDecorationData:isReachable()
	-- print ("reachable: ", self.reachable)
	return self.reachable
end

function MapDecorationData:isDestructible()
	return self.destructible
end

function MapDecorationData:canBeNodeOfPath()
	return self.nodeOfPath
end

function MapDecorationData:canBeEndOfPath()
	return self.endOfPath
end

function MapDecorationData:GetHasRandomDirection()
	return self.hasRandomDirection
end

function MapDecorationData:isSeparate()
	return self.separate
end

function MapDecorationData:isOnGround()
	return self.onGround
end

return MapDecorationData