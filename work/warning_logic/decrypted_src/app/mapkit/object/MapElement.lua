local MapDefine = require "app.mapkit.MapDefine"
local MapElement = class("MapElement")

function MapElement:ctor(x, y)

 --    self:registerScriptHandler(function (event)
	--     if event == "enter" then
	--         self:onEnter()
	--     end
	-- end)
	self:setCoordinate(x, y)
	self.hasEffectColor = false
	self.offset = {x = 0, y = 0}
	self.direction = MapDefine.DirectionType.West
end

-- function MapElement:onEnter()

-- end

-- 销毁
function MapElement:destroy()
	error("MapElement destroy: should be overrided.")
end

-- Accessories
function MapElement:setDirection(direction)
	self.direction = direction
end

function MapElement:getDirection()
	return self.direction
end

function MapElement:setCoordinate(x, y)
	if type(x) == "table" then
		local coord = x;
		self.x = coord.x
		self.y = coord.y
	elseif type(x) == "number" and type(y) == "number" then
		self.x = x;
		self.y = y;
	end
end

function MapElement:getCoordinate()
	return self.x, self.y
end

function MapElement:setTileSize(tileWidth, tileHeight)
	self.tileWidth = tileWidth
	self.tileHeight = tileHeight
end

function MapElement:getTileSize()
	return self.tileWidth, self.tileHeight
end

function MapElement:setOccupySize(size)
	self.occupySize = size
end

function MapElement:getOccupySize()
	return self.occupySize
end

function MapElement:setEffectColor(color)
	self.effectColor = color
	if self.effectColor ~= nil and self.effectColor.a == nil then
		self.effectColor.a = 255
	end
end

function MapElement:getEffectColor()
	return self.effectColor
end

function MapElement:setRadiationRadius(radius)
	self.radiationRadius = radius
end

function MapElement:getRadiationRadius()
	return self.radiationRadius
end

function MapElement:setOffset(offset)
	self.offset = offset
end

function MapElement:getOffset()
	return self.offset
end

function MapElement:addToMap(map, position, zorder)
	local pos = { x = position.x, y = position.y}
	if self.offset ~= nil then
		pos = {x = pos.x + self.offset.x, y = pos.y + self.offset.y}
	end
	if self.sprite ~= nil then
		map:addChild(self.sprite, zorder)
		self.sprite:setPosition(pos)
	elseif self.spine ~= nil then
		map:addChild(self.spine, zorder)
		self.spine:setPosition(pos)
	end
end

return MapElement

