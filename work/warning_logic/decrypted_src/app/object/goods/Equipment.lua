--[[
    物品 - 装备
]]--

require "app.object.goods.Goods"

Model = Model or {}

local Equipment = class("Equipment", Model.Goods)
Model.Equipment = Equipment

-- private:
-- 构造函数
function Equipment:ctor()
    Equipment.super.ctor(self, PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
end

-- public:
-- 创建对象
local EquipmentPool = nil
function Equipment:create(reused, ...)
    if (reused) then
        if (not EquipmentPool) then
            EquipmentPool = Pool.Pool:create(Equipment)
        end
        return EquipmentPool:applyObject()
    else
        return Equipment.new(...)
    end
end

-- 初始化
function Equipment:init(equipmentData)
    Equipment.super.init(self, equipmentData)
end