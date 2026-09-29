--[[
    物品 - 道具
]]--

require "app.object.goods.Goods"

Model = Model or {}

local Prop = class("Prop", Model.Goods)
Model.Prop = Prop

-- private:
-- 构造函数
function Prop:ctor()
    Prop.super.ctor(self, PublicDefine.GOODS_TYPE.GOODS_ITEM)
end

-- public:
-- 创建对象
local PropPool = nil
function Prop:create(reused, ...)
    if (reused) then
        if (not PropPool) then
            PropPool = Pool.Pool:create(Prop)
        end
        return PropPool:applyObject()
    else
        return Prop.new(...)
    end
end

-- 初始化
function Prop:init(propData)
    Prop.super.init(self, propData)
end