--[[
    几何模型
]]--

Geome = Geome or {}

---------------------------------------------
--[[包围盒类型]]--
Geome.BoundingboxType = {
    NONE = 0,
    RECTANGLE = 1, -- 矩形包围盒
    CIRCULAR = 2,  -- 圆形包围盒
    CUBE = 3       -- 立方体包围盒
}
BoundingboxType = Geome.BoundingboxType
---------------------------------------------

---------------------------------------------
--[[坐标]]--
local Coord = class("GeomeCoord")
Geome.Coord = Coord

function Coord:ctor(x, y, z)
    self.x = (x == nil) and 0 or x
    self.y = (y == nil) and 0 or y
    self.z = (z == nil) and 0 or z 
end

function Coord:copy()
    return Coord:create(self.x, self.y, self.z)
end

function Coord:addValue(x, y, z)
    if( x == nil or y == nil) then
        return
    end
    self.x = self.x + x
    self.y = self.y + y
    self.z = self.z + ((z == nil) and 0 or z)
end

function Coord:subValue(x, y, z)
    if( x == nil or y == nil) then
        return
    end
    self.x = self.x - x
    self.y = self.y - y
    self.z = self.z - ((z == nil) and 0 or z)
end

function Coord:setValue(x, y, z)
    if( x == nil or y == nil) then
        print("Coord:setValue ", x, y, z)
        return
    end
    self.x = x
    self.y = y
    if (z ~= nil) then 
        self.z = z 
    end
end

function Coord:setCoord(coord)
    if(coord == nil or coord.x == nil or coord.y == nil) then
        return
    end

    self.x = coord.x
    self.y = coord.y
    if (coord.z ~= nil) then
        self.z = coord.z
    end
end

function Coord:setZ(z)
    if (z ~= nil) then
        self.z = z
    end
end

function Coord:addCoord(coord)
    if(coord == nil or coord.x == nil or coord.y == nil or coord.z == nil) then
        return
    end

    self.x = self.x + coord.x
    self.y = self.y + coord.y
    self.z = self.z + coord.z
end

function Coord:subCoord(coord)
    if(coord == nil or coord.x == nil or coord.y == nil or coord.z == nil) then
        return
    end
    self.x = self.x - coord.x
    self.y = self.y - coord.y
    self.z = self.z - coord.z
end

function Coord:distance(dstCoord)
    if(dstCoord == nil or dstCoord.x == nil or dstCoord.y == nil or dstCoord.z == nil) then
        return 0
    end
    local dx = self.x - dstCoord.x
    local dy = self.y - dstCoord.y
    local dz = self.z - dstCoord.z

    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

function Coord:reset()
    self.x = 0
    self.y = 0
    self.z = 0
end
---------------------------------------------

---------------------------------------------
--[[矩形尺寸]]--
local RectSize = class("GeomeRectSize")
Geome.RectSize = RectSize

function RectSize:ctor(width, height)
    self.width = width
    self.height = height
end

function RectSize:reset()
    self.width = 0
    self.height = 0
end
---------------------------------------------

---------------------------------------------
--[[矩形包围盒]]--
local RectBoundingbox = class("GeomeRectBoundingbox")
Geome.RectBoundingbox = RectBoundingbox

function RectBoundingbox:ctor(x, y, width, height, achorX, achorY)
    self.type = BoundingboxType.RECTANGLE
    self:set(x, y, width, height, achorX, achorY)
end

function RectBoundingbox:set(x, y, width, height, achorX, achorY)
    self.left = x - width * achorX
    self.right = self.left + width
    self.bottom = y - height * achorY
    self.top = self.bottom + height
end

function RectBoundingbox:reset()
    self:set(0, 0, 0, 0, 0, 0)
end
---------------------------------------------

---------------------------------------------
--[[方向]]--
local Direction = {}
Geome.Direction = Direction

Geome.Direction.Type = {
    NONE = 0,
    NORTH = 1,
    EAST = 2,
    SOUTH = 3,
    WEAST = 4
}
DirectionType = Geome.Direction.Type
---------------------------------------------

---------------------------------------------
-- 计算两点之间的距离
Geome.computeDistance = function(srcCoord, dstCoord)
    if(srcCoord == nil or dstCoord == nil) then 
        return 0,0,0
    end

    local distance = srcCoord:distance(dstCoord)

    return distance
end

-- 计算两点之间的速度分量
Geome.computeSpeedComp = function(srcCoord, dstCoord, speed)
    if(srcCoord == nil or dstCoord == nil or speed == nil) then 
        return 0,0,0
    end

    local normal = Geome.computeNormal(srcCoord, dstCoord)

    return speed * normal.x, speed * normal.y, speed * normal.z
end
Geome.computeSpeedComp2 = function(srcCoord, dstCoord, duration)
    if(srcCoord == nil or dstCoord == nil or duration == nil) then 
        return 0,0,0
    end

    local speed = 0
    if(srcCoord) then
        if (duration > 0) then
            local distance = srcCoord:distance(dstCoord)
            speed = distance / duration
        end
    end

    local normal = Geome.computeNormal(srcCoord, dstCoord)
    return speed * normal.x, speed * normal.y, speed * normal.z 
end

-- 计算移动时长
Geome.computeMoveDuration = function(srcCoord, dstCoord, speed)
    if(srcCoord == nil or dstCoord == nil or speed == nil) then 
        return 0
    end

    if (speed <= 0) then
        return 0
    else
        local distance = srcCoord:distance(dstCoord)
        return distance / speed
    end
end

-- 根据两个坐标点计算法线
Geome.computeNormal = function(srcCoord, dstCoord)
    if(srcCoord == nil or dstCoord == nil) then
        return {
            x = 0,
            y = 0,
            z = 0
        }
    end

    local dx = dstCoord.x - srcCoord.x
    local dy = dstCoord.y - srcCoord.y
    local dz = dstCoord.z - srcCoord.z

    local dis = math.sqrt(dx * dx + dy * dy + dz * dz)
    if (dis == 0) then
        return {
            x = 0,
            y = 0,
            z = 0
        }
    else
        return {
            x = dx / dis,
            y = dy / dis,
            z = dz / dis
        }
    end
end

-- 计算反向
Geome.reverseDirection = function(currentDirection)
    if (currentDirection == DirectionType.EAST) then
        return DirectionType.WEAST
    elseif (currentDirection == DirectionType.WEAST) then
        return DirectionType.EAST
    elseif (currentDirection == DirectionType.NORTH) then
        return DirectionType.SOUTH
    elseif (currentDirection == DirectionType.SOUTH) then
        return DirectionType.NORTH
    end
    return DirectionType.NONE
end

-- 根据坐标计算方向
Geome.computeDirection = function(srcCoord, dstCoord)
    if (srcCoord.x == dstCoord.x and
        srcCoord.y == dstCoord.y) then
        return DirectionType.NONE
    else
        if (srcCoord.y == dstCoord.y) then
            if (srcCoord.x < dstCoord.x) then
                return DirectionType.EAST
            elseif (srcCoord.x > dstCoord.x) then
                return DirectionType.WEAST
            end
        elseif (srcCoord.x == dstCoord.x) then
            if (srcCoord.y < dstCoord.y) then
                return DirectionType.NORTH
            elseif (srcCoord.y > dstCoord.y) then
                return DirectionType.SOUTH
            end
        else
            if (dstCoord.x < srcCoord.x and dstCoord.y < srcCoord.y) then
                return DirectionType.SOUTH
            elseif (dstCoord.x < srcCoord.x and dstCoord.y > srcCoord.y) then
                if dstCoord.y - srcCoord.y > srcCoord.x - dstCoord.x then
                    return DirectionType.NORTH
                else
                    return DirectionType.WEAST
                end
            elseif (dstCoord.x > srcCoord.x and dstCoord.y < srcCoord.y) then
                if srcCoord.y - dstCoord.y > dstCoord.x - srcCoord.x then
                    return DirectionType.SOUTH
                else
                    return DirectionType.EAST
                end
            else
                return DirectionType.NORTH
            end
        end
        return DirectionType.NONE
    end
end
---------------------------------------------


