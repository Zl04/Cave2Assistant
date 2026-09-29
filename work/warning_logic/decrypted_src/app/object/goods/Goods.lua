--[[
    物品 - 道具
]]--

require "app.object.GameModel"
require "app.object.fsm.GoodsFSM"

Model = Model or {}

local Goods = class("Goods", Model.Base)
Model.Goods = Goods

-- private:
-- 构造函数
function Goods:ctor(goodsType)
    if (goodsType) then
        Goods.super.ctor(self, ModelCategory.GOODS, goodsType)
    else
       assert(false, "[ERROR] Goods constructor: goods type is nil.")
    end

    self._goodsData = nil
end

-- 析构函数
function Goods:dtor()
    Goods.super.dtor(self)

    self._goodsData = nil
end

-- public:
-- 初始化
function Goods:init(goodsData)
    local fsm = FSM.GoodsFSM:create()
    fsm:init(self)
    Prop.super.init(self, fsm, nil)
    
    self._goodsData = goodsData
end

-- 清理
function Goods:clear()
    Goods.super.clear(self)

    self._goodsData = nil
end