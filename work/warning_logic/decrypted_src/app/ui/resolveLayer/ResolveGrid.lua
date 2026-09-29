-- ResolveGrid.lua
-- Author:ydli
-- 2018年3月15日
-- Using:分解格子

local GameDataManager = require("app.game.GameDataManager")

local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE

local ResolveGrid = class("ResolveGrid", UI.ListGrid)
UI.ResolveGrid = ResolveGrid

function ResolveGrid:ctor()
    ResolveGrid.super.ctor(self)
    self._goodsGrid = UI.GoodsGrid:create()
    self._goodsGrid:setAvailable(true)
    self._goodsGrid:centerUp(0)
    self:addChild(self._goodsGrid, 1)
end

function ResolveGrid:dtor()
    ResolveGrid.super.dtor(self)
    if(self._goodsGrid) then
        self._goodsGrid = nil
    end
end

function ResolveGrid:init(data)
    ResolveGrid.super.init(self, data)
    self._goodsGrid:init(data)
    self._data = data
end

function ResolveGrid:onInitView()
    -- self._goodsGrid:onInitView()
    self._goodsGrid:hideBG()
end

-- 更新视图
function ResolveGrid:onUpdateView()
    -- self._goodsGrid:onUpdateView()
    self._goodsGrid:hideBG()
    -- self:hideIcon()
end

function ResolveGrid:onSizeChanged(originalWidth, originalHeight)
    ResolveGrid.super.onSizeChanged(self, originalWidth, originalHeight)

end

function ResolveGrid:setData(data)
    if type(data) == "table" then
        ResolveGrid.super.setData(self, data)
        self._goodsGrid:setData(data)
        self._data = data
    end
end

function ResolveGrid:getData()
    return self._data
end

function ResolveGrid:showIcon()
    if (self._goodsGrid) then
        self._goodsGrid:showIcon()
    end
end

function ResolveGrid:isClickShowInfo()
    if(self._goodsGrid) then
        return self._goodsGrid:isClickShowInfo()
    end

    return false
end

-- 隐藏所有图标
function ResolveGrid:hideIcon()
    if(self._goodsGrid) then
        self._goodsGrid:hideIcon()
    end
end

function ResolveGrid:showSelect()
    if(self._goodsGrid) then
        self._goodsGrid:showSelect()
    end
end

function ResolveGrid:hideSelect()
    if(self._goodsGrid) then
        self._goodsGrid:hideSelect()
    end
end

-- 克隆
function ResolveGrid:createDraggedView()
    print("ShopGrid:createDragedView")
    local newGoodsGrid = UI.GoodsGrid:create()
    newGoodsGrid:init(self._data)
    newGoodsGrid:setSize(self._goodsGrid._width, self._goodsGrid._height)
    newGoodsGrid:setIndex(self._index)
    newGoodsGrid:hideBG()

    return newGoodsGrid
end




