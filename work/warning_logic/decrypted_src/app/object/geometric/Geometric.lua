--[[
    数学模型
]]--

require "app.object.geometric.GeometricModel"

Geome = Geome or {}

local Base = class("GeometricBase")
Geome.Base = Base

-- public:
-- 构造函数
function Base:ctor(dataModel)
    self._coord = nil
    self._direction = DirectionType.NONE
    self._size = nil
    self._boundingbox = nil
    self._dataModel = dataModel
end

-- 销毁
function Base:destroy()
    self._coord = nil
    self._size = nil
    self._boundingbox = nil
    self._dataModel = nil
end

-- 初始化
function Base:init(coord, direction, size, boundingbox)
    self._coord = coord
    self._direction = direction
    self._size = size
    self._boundingbox = boundingbox
end

-- 清理
function Base:clear()
    if (self._coord) then self._coord:reset() end
    self._direction = DirectionType.NONE
    if (self._size) then self._size:reset() end
    if (self._boundingbox) then self._boundingbox:reset() end
    self._dataModel = nil
end

-- 获取包围盒类型
function Base:getBBType()
    if (self._boundingbox) then
        return self._boundingbox.type
    end
    return BoundingboxType.NONE
end

-- 获取坐标
function Base:getCoord()
    return self._coord
end

-- 设置坐标
function Base:setCoord(...)
    assert(false, "[ERROR] Geometric setCoord: this method should be overrided by sub class.")
end

-- 获取包围盒
function Base:getBoundingbox()
    return self._boundingbox
end

-- 获取朝向
function Base:getDirection()
    return self._direction
end

-- 设置朝向
function Base:setDirection(...)
    assert(false, "[ERROR] Geometric setDirection: this method should be overrided by sub class.")
end

-- 获取尺寸
function Base:getSize()
    return self._size
end

-- 设置尺寸
function Base:setSize(...)
    assert(false, "[ERROR] Geometric setSize: this method should be overrided by sub class.")
end

-- 碰撞检测
function Base:checkCollision(geome)
    assert(false, "[ERROR] Geometric:checkCollision this method should be overrided by sub class.")
    return false
end