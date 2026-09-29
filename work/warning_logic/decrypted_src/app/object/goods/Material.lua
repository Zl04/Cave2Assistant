--[[
    物品 - 材料
]]--

require "app.object.goods.Goods"

Model = Model or {}

local Material = class("Material", Model.Goods)
Model.Material = Material

-- private:
-- 构造函数
function Material:ctor()
    Material.super.ctor(self, PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
end

-- public:
-- 创建对象
local MaterialPool = nil
function Material:create(reused, ...)
    if (reused) then
        if (not MaterialPool) then
            MaterialPool = Pool.Pool:create(Material)
        end
        return MaterialPool:applyObject()
    else
        return Material.new(...)
    end
end

-- 初始化
function Material:init(materialData)
    Material.super.init(self, materialData)
end