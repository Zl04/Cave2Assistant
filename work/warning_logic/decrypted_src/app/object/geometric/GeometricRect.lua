--[[
    角色的矩形几何模型
]]--

require "app.object.geometric.Geometric"

Geome = Geome or {}

local GeometricRect = class("GeometricRect", Geome.Base)
Geome.GeometricRect = GeometricRect

-- 初始化
function GeometricRect:init(x, y, z, width, height, direction)
    x = x or 0
    y = y or 0
    z = z or 0
    width = width or 0
    height = height or 0
    direction = direction or DirectionType.NONE

    local coord = Geome.Coord:create(x, y, z)
    local size = Geome.RectSize:create(width, height)

    if self._dataModel then
        local dataCoord = Geome.Coord:create(x, y, z) 
        self._dataModel:setCoord(dataCoord)
    end

    self.super.init(self, coord, direction, size, nil)
end

-- 设置坐标
function GeometricRect:setCoord(coordX, coordY, coordZ)
    self._coord:setValue(coordX, coordY, coordZ)
    if self._dataModel then
        local dataCoord = self._dataModel:getCoord()
        dataCoord:setValue(coordX,coordY,coordZ)
    end
end

-- 设置z坐标
function GeometricRect:setCoordZ(coordZ)
    self._coord:setZ(coordZ)
    if self._dataModel then
        local dataCoord = self._dataModel:getCoord()
        dataCoord:setZ(coordZ)
    end
end

-- 设置朝向
function GeometricRect:setDirection(direction)
    self._direction = direction
    if self._dataModel then
        self._dataModel:setDirection(direction)
    end
end

-- 设置尺寸
function GeometricRect:setSize(width, height)
    self._size.width = width
    self._size.height = height
end