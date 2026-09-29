--[[
    子弹类的飞行道具
]]--

require "app.object.aircraft.Aircraft"
require "app.object.fsm.BulletFSM"
require "app.object.geometric.GeometricRect"

Model = Model or {}

local Bullet = class("Bullet", Model.Aircraft)
Model.Bullet = Bullet

-- private:
-- 构造函数
function Bullet:ctor()
    Bullet.super.ctor(self, AircraftType.BULLET)

    self._inited = false
    -- 子弹飞行时间
    self._flyTime = 0
    -- spine配置
    self._skeletonName = ""
    self._atlasName = ""
    self._scale = 1.0
end

-- 析构函数
function Bullet:dtor()
    Bullet.super.dtor(self)
end

-- public:
-- 创建对象
local BulletPool = nil
function Bullet:create(reused, ...)
    if (reused) then
        if (not BulletPool) then
            BulletPool = Pool.Pool:create(Bullet)
        end
        return BulletPool:applyObject()
    else
        return Bullet.new(...)
    end
end

-- 初始化
function Bullet:init(flyTime, animName)
    if (not self._inited) then
        local fsm = FSM.BulletFSM:create()
        local geometric = Geome.GeometricRect:create()
        geometric:init(0, 0, 0, 0, 0, DirectionType.NONE)

        Bullet.super.init(self, nil, fsm, geometric)
    else
        self._fsm:init()
        self._geometric:init(0, 0, 0, 0, 0, DirectionType.NONE)
    end

    self._flyTime = flyTime
    self._skeletonName = animName..".json"
    self._atlasName = animName..".atlas"
    self._scale = Game.AIRCRAFT_ANIMATION_SCALE
end

-- 清理
function Bullet:clear()
    Bullet.super.clear(self)

    self._flyTime = 0
    self._skeletonName = ""
    self._atlasName = ""
    self._scale = 1.0
end

-- 获取飞行时间
function Bullet:getFlyTime()
    return self._flyTime
end

-- 获取动画数据
function Bullet:getAnimationData()
    return self._skeletonName, self._atlasName, self._scale
end