-- RandomShopGrid.lua
-- Author:zp
-- 2018年10月18日
-- Using:随机商店格子

local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE
local GameDataManager = require("app.game.GameDataManager")

local RandomShopGrid = class("RandomShopGrid", UI.ListGrid)
UI.RandomShopGrid = RandomShopGrid


function RandomShopGrid:ctor()
    RandomShopGrid.super.ctor(self)

    self._iconBg = UI.Image:create()
    self._iconBg:init("ui_shop_lattice1.png")
    self._iconBg:centerUp(0)
    self:addChild(self._iconBg)

    self._goodsGrid = UI.GoodsGrid:create()
    self._goodsGrid:centerUp(0)
    self:addChild(self._goodsGrid,1)
end

function RandomShopGrid:dtor()
    RandomShopGrid.super.dtor(self)
    if(self._goodsGrid) then
        self._goodsGrid = nil
    end
end

function RandomShopGrid:init(data)
    RandomShopGrid.super.init(self, data)
    self._goodsGrid:init(data)
end

function RandomShopGrid:onInitView()
    -- RandomShopGrid.super.onInitView(self)
    -- self._goodsGrid:onInitView()

    -- TODO 添加背景框
end

-- 更新视图
function RandomShopGrid:onUpdateView()
    -- RandomShopGrid.super.onUpdateView(self)
    self._goodsGrid:onUpdateView()
    --TODO 更新价格显示
    if(self._data and self._costIcon == nil) then
        -- 处理价格显示
        local costType = self._data:getCostType()
        local buyPrice = self._data:getBuyPrice()
        buyPrice, wasSale = GameDataManager:getInstance():calculationShopGoldPriceSale(buyPrice, costType)

        local costIcon = UI.Image:create()
        if(costType == GOODS_COST_TYPE.GOLD) then
            costIcon:init("symbol_gaming_money.png")
            
        elseif (costType == GOODS_COST_TYPE.GEM) then
            costIcon:init("symbol_gaming_diamond.png")
        end
        -- costIcon:fill()
        -- costIcon:setSize(28*0.7,28*0.7)

        local costLabel = UI.Text:create()
        costLabel:init(costLabel:numformat(string.format("%s",buyPrice)), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        costLabel:setFontSize(16)

        if(wasSale) then
            costLabel:setFontColor(UI.FONT_COLOR_60_171_35)
        else 
            costLabel:setFontColor(UI.FONT_COLOR_155_155_155)
        end
        -- 
        self:addChild(costIcon)

        costLabel:centerLeft(costIcon:getContentSize().width + 4)
        costIcon:addChild(costLabel)

        -- costLabel:getSize()

        costIcon:leftBottom(75/2 - costIcon:getSize()/2 - costLabel:getSize()/2 -2,27 - costIcon:getContentSize().height/2)
        -- costLabel:leftBottom(75/2 -costLabel:getSize()/2 + costIcon:getSize()/2 + 2,37 - cos)

        self._costIcon = costIcon
        self._costLabel = costLabel
    end

    self:refreshIcon(true)
end

function RandomShopGrid:refreshIcon(isShow)
    if(self._costIcon) then
        if(isShow) then
            if(self._data) then
                if self._data:getNum() - self._data:getUseNum() <= 0 then
                    self._iconBg:setVisible(false)
                    self._questionmark:setVisible(false)
                else 
                    self._iconBg:setVisible(true)
                    self._questionmark:setVisible(true)
                end
            end
        else 
            self._iconBg:setVisible(false)
            self._questionmark:setVisible(false)
        end
    end
    self:hideBG()
end

function RandomShopGrid:onSizeChanged(originalWidth, originalHeight)
    RandomShopGrid.super.onSizeChanged(self, originalWidth, originalHeight)

end

function RandomShopGrid:setData(data)
    RandomShopGrid.super.setData(self, data)
    self._goodsGrid:setData(data)
end

function RandomShopGrid:getData()
    return self._data
end

function RandomShopGrid:showIcon()
    if(self._goodsGrid) then
        self._goodsGrid:showIcon()
    end
    self:refreshIcon(true)
end

-- 隐藏所有图标
function RandomShopGrid:hideIcon()
    if(self._goodsGrid) then
        self._goodsGrid:hideIcon()
    end

    self:refreshIcon(false)
end

function RandomShopGrid:hideBG()
    if(self._goodsGrid) then
        self._goodsGrid:hideBG()
    end
end

function RandomShopGrid:showSelect()
    if(self._goodsGrid) then
        self._goodsGrid:showSelect()
    end
end

function RandomShopGrid:hideSelect()
    if(self._goodsGrid) then
        self._goodsGrid:hideSelect()
    end
end

function RandomShopGrid:isClickShowInfo()
    if(self._goodsGrid) then
        return self._goodsGrid:isClickShowInfo()
    end

    return false
end

-- 克隆
function RandomShopGrid:createDraggedView()
    local newGoodsGrid = UI.GoodsGrid:create()
    newGoodsGrid:init(self._data)
    newGoodsGrid:setSize(self._goodsGrid._width, self._goodsGrid._height)
    newGoodsGrid:setIndex(self._index)
    newGoodsGrid:hideBG()

    local iconBg = UI.Image:create()
    iconBg:init("ui_shop_lattice1.png")
    iconBg:center(0)
    iconBg:setSize(70, 70)
    newGoodsGrid:addChild(iconBg)

    local questionmark = UI.Image:create()
    questionmark:init("ui_shop_questionmark.png")
    questionmark:rightUp(-1, 0)
    newGoodsGrid:addChild(questionmark, 100)

    return newGoodsGrid
end




