--[[
    获取物品类的飞行道具
]]--

require "app.object.aircraft.Aircraft"
require "app.object.geometric.GeometricRect"

Model = Model or {}

local GetGoods = class("GetGoods", Model.Aircraft)
Model.GetGoods = GetGoods

-- private:
-- 构造函数
function GetGoods:ctor()
    GetGoods.super.ctor(self, AircraftType.GETGOODS)

    self._inited = false
    self._iconName = nil
end

-- 析构函数
function GetGoods:dtor()
    GetGoods.super.dtor(self)
end

-- public:
-- 创建对象
local GetGoodsPool = nil
function GetGoods:create(reused, ...)
    if (reused) then
        if (not GetGoodsPool) then
            GetGoodsPool = Pool.Pool:create(GetGoods)
        end
        return GetGoodsPool:applyObject()
    else
        return GetGoods.new(...)
    end
end

-- 初始化
function GetGoods:init(iconName)
    assert(iconName,"GetGoods:init  iconName is nil")
    if (not self._inited) then
        local geometric = Geome.GeometricRect:create()
        geometric:init(0, 0, 0, 0, 0, DirectionType.NONE)

        GetGoods.super.init(self, nil, nil, geometric)
    else
        self._geometric:init(0, 0, 0, 0, 0, DirectionType.NONE)
    end

    self._iconName = iconName
end

-- 清理
function GetGoods:clear()
    GetGoods.super.clear(self)

    self._iconName = nil
end

-- 获取图标名字
function GetGoods:getIconName()
    return self._iconName
end