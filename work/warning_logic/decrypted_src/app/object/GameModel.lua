--[[
    游戏模型系统：游戏场景中的所有游戏对象的模型，包括英雄，怪物，npc，路灯等
    子系统包括：状态机系统，渲染系统，几何系统（坐标系统，包围盒系统）
]]--

require "app.pool.PoolObject"

Model = Model or {}

local computeDirection = Geome.computeDirection

-- 用于生成每个角色实例的唯一id
Model.InstanceCount = 0

local Base = class("GameModel", Pool.PoolObject)
Model.Base = Base

-- public:
-- 构造函数
function Base:ctor(category, type)
    -- 唯一id和类型
    Model.InstanceCount = Model.InstanceCount + 1
    self._id = Model.InstanceCount

    self._category = category
    self._type = type or 0

    -- 状态机
    self._fsm = nil
    -- 几何系统
    self._geometric = nil

    -- 添加次数
    self._addNum = 1
end

-- 销毁
function Base:dtor()
    if self._fsm then
        self._fsm:destroy()
        self._fsm = nil
    end
    if self._geometric then
        self._geometric:destroy()
        self._geometric = nil
    end

    self._addNum = 1
end

-- 初始化
function Base:init(fsm, gemo)
    -- [fix] 修复模型id重复的问题
    Model.InstanceCount = Model.InstanceCount + 1
    self._id = Model.InstanceCount

    self._fsm = fsm
    self._geometric = gemo
end

-- 清理
function Base:clear()
    if self._fsm then
        self._fsm:clear()
        self._fsm = nil
    end
    if self._geometric then
        self._geometric:clear()
        self._geometric = nil
    end
    
    self._addNum = 1
end

-- 获取添加次数
function Base:getAddNum()
    return self._addNum
end

-- 增加一次添加数量
function Base:increaseAddNum()
    self._addNum = self._addNum + 1
end

-- 减少一次添加数量
function Base:reduceAddNum()
    self._addNum = self._addNum - 1
end

-- 获取唯一id
function Base:getId()
    return self._id
end

-- 获取分类
function Base:getCategory()
    return self._category
end

-- 设置类型
function Base:setType(type)
    self._type = type
end

-- 获取类型
function Base:getType()
    return self._type
end

-- 获取当前地图坐标
function Base:getCoord()
    if (self._geometric) then
        return self._geometric:getCoord()
    end
    return  {x = 0, y = 0, z = 0}
end

-- 获取上一次的坐标
function Base:getLastCoord()
    return {x = self._lastCoordX, y = self._lastCoordY, z = self._lastCoordZ}
end

-- 设置地图坐标
function Base:setCoord(coordX, coordY, coordZ)
    if (self._geometric) then
        local coord = self._geometric:getCoord()
        if Avalon.MathUtil:getInt(coord.x) ~= Avalon.MathUtil:getInt(coordX) or Avalon.MathUtil:getInt(coord.y) ~= Avalon.MathUtil:getInt(coordY) then
            self._lastCoordX, self._lastCoordY, self._lastCoordZ = coord.x, coord.y, coord.z
        end
        self._geometric:setCoord(coordX, coordY, coordZ)
    end
end

-- 设置z坐标
function Base:setCoordZ(coordZ)
    if (self._geometric) then
         local coord = self._geometric:getCoord()
        if self._lastCoordZ ~= coord.z then
            self._lastCoordZ = coord.z 
        end
        self._geometric:setCoordZ(coordZ)
    end
end

-- 获取朝向
function Base:getDirection()
    if (self._geometric) then
        return self._geometric:getDirection()
    end
    return 0
end

-- 设置朝向
function Base:setDirection(direction)
    if (self._geometric) then
        self._geometric:setDirection(direction)
    end
end

-- 通过目标坐标设置朝向
function Base:setDirectionByTargetCoord(coord)
    if (self._geometric) then
        if (coord) then
            local oriCoord = self._geometric:getCoord()
            local direction = computeDirection(oriCoord, coord)
            if (direction ~= DirectionType.NONE) then
                self._geometric:setDirection(direction)
            end
        end
        return self._geometric:getDirection()
    end
    return DirectionType.NONE
end

-- 添加渲染命令
function Base:pushRendererCommand(command)
    if (self._renderer) then
        return self._renderer:pushCommand(command)
    end
end

-- 获取当前状态
function Base:getState()
    if (self._fsm) then
        return self._fsm:getState()
    end
    return 0
end

-- 检测状态是否可以切换
function Base:canSwitchState(state)
    if (self._fsm) then
        return self._fsm:canSwitch(state)
    end
    return false
end

-- 切换状态
function Base:switchState(state)
    if (self._fsm) then
        return self._fsm:switch(state)
    end
    return false
end

-- 获取动画配置数据
function Base:getAnimationData()
    assert(false, "[ERROR] GameModel getAnimationData: this method should be overrided by sub class.")
end

-- 更新逻辑
function Base:update(dt)
    -- TODO
end