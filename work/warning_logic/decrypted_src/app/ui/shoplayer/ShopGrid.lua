-- ShopGrid.lua
-- Author:zp
-- 2017年5月17日
-- Using:商店格子

local GameDataManager = require("app.game.GameDataManager")

local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE

local ShopGrid = class("ShopGrid", UI.ListGrid)
UI.ShopGrid = ShopGrid


function ShopGrid:ctor()
    ShopGrid.super.ctor(self)

    self._iconBg = UI.Image:create()
    self._iconBg:init("ui_shop_lattice.png")
    self._iconBg:centerUp(0)
    self:addChild(self._iconBg)

    self._goodsGrid = UI.GoodsGrid:create()
    self._goodsGrid:centerUp(0)
    self:addChild(self._goodsGrid)
end

function ShopGrid:dtor()
    ShopGrid.super.dtor(self)
    if(self._goodsGrid) then
        self._goodsGrid = nil
    end
end

function ShopGrid:init(data)
    ShopGrid.super.init(self, data)
    self._goodsGrid:init(data)
end

function ShopGrid:onInitView()
    -- ShopGrid.super.onInitView(self)
    -- self._goodsGrid:onInitView()
    -- self._goodsGrid:hideBG()
end

-- 更新视图
function ShopGrid:onUpdateView()
    -- ShopGrid.super.onUpdateView(self)
    self._goodsGrid:onUpdateView()
    -- 更新价格显示
    if(self._data and self._costIcon == nil) then
        -- 处理价格显示
        local costType = self._data:getCostType()
        local oldBuyPrice = self._data:getBuyPrice()
        local buyPrice, wasSale = GameDataManager:getInstance():calculationShopGoldPriceSale(oldBuyPrice, costType)
        local iconName = "symbol_gaming_diamond.png"
        if(costType == GOODS_COST_TYPE.GOLD) then
            iconName = "symbol_gaming_money.png"
        elseif (costType == GOODS_COST_TYPE.GEM) then
            iconName = "symbol_gaming_diamond.png"
        else 
            printError("ShopGrid:onUpdateView   costType is error=", costType)
        end

        if(oldBuyPrice == 0) then 
            local costLabel = UI.Text:create()
            costLabel:init(UI.TEXT_1172013,  UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_36_181_118)
            self:addChild(costLabel)
            costLabel:centerUp(88 - costLabel:getContentSize().height/2)
        else 
            local costIcon = UI.Image:create()
            costIcon:init(iconName)
            self:addChild(costIcon)
            
            local costLabel = UI.Text:create()
            costLabel:init(string.format("%s",buyPrice),  UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
            self:addChild(costLabel)

            local discountCostLabel  = UI.Text:create()
            -- 修改字体颜色
            discountCostLabel:init(tostring(self._data.diamondCost), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_50_50_44)    
            discountCostLabel:centerLeft(55)
            discountCostLabel:setOpacity(255*0.8)
            self:addChild(discountCostLabel, 10)  

            -- 划掉的线
            local bannelLine =  cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_red.png", CCRectMake(0,0,1,1))
            bannelLine:setPosition(discountCostLabel:getContentSize().width/2, discountCostLabel:getContentSize().height/2)
            bannelLine:setContentSize(discountCostLabel:getContentSize().width + 20, 2)
            discountCostLabel:addChild(bannelLine)

            local offsetX = 7
            if(wasSale) then
                -- discountCostIcon:show()
                discountCostLabel:setVisible(true)
                bannelLine:setVisible(true)

                costLabel:setText(buyPrice)
                discountCostLabel:setText(oldBuyPrice)
                bannelLine:setContentSize(discountCostLabel:getContentSize().width + 10, 2)
                bannelLine:setPosition(discountCostLabel:getContentSize().width/2, discountCostLabel:getContentSize().height/2)

                local centerY = 88
                local startX = self:getContentSize().width /2 - (costIcon:getContentSize().width + costLabel:getContentSize().width +offsetX) / 2
                
                costIcon:leftUp(startX ,centerY - costIcon:getContentSize().height/2)
                discountCostLabel:leftUp(startX + costIcon:getContentSize().width + offsetX, centerY - discountCostLabel:getContentSize().height +2)
                costLabel:leftUp(startX + costIcon:getContentSize().width + offsetX,centerY -2)
            else
                local centerY = 82
                local startX = self:getContentSize().width /2 - (costIcon:getContentSize().width + costLabel:getContentSize().width +offsetX) / 2
                costIcon:leftUp(startX, centerY - costIcon:getContentSize().height/2)
                costLabel:leftUp(startX + costIcon:getContentSize().width + offsetX, centerY - costLabel:getContentSize().height/2)
                discountCostLabel:setVisible(false)
                bannelLine:setVisible(false)
            end

            self._costIcon = costIcon
            self._costLabel = costLabel
        end
    end

    self:refreshIcon(true)
end

function ShopGrid:onSizeChanged(originalWidth, originalHeight)
    ShopGrid.super.onSizeChanged(self, originalWidth, originalHeight)

end

function ShopGrid:refreshIcon(isShow)
    if(self._iconBg) then
        if(isShow) then
            if(self._data) then
                if self._data:getNum() - self._data:getUseNum() <= 0 then
                    self._iconBg:setVisible(false)
                else 
                    self._iconBg:setVisible(true)
                end
            end
        else 
            self._iconBg:setVisible(false)
        end
    end
    self:hideBG()
end

function ShopGrid:setData(data)
    ShopGrid.super.setData(self, data)
    self._goodsGrid:setData(data)
end

function ShopGrid:getData()
    return self._data
end

function ShopGrid:showIcon()
    if(self._goodsGrid) then
        self._goodsGrid:showIcon()
    end

    self:refreshIcon(true)
end

function ShopGrid:isClickShowInfo()
    if(self._goodsGrid) then
        return self._goodsGrid:isClickShowInfo()
    end

    return false
end

function ShopGrid:hideBG()
    if(self._goodsGrid) then
        self._goodsGrid:hideBG()
    end
end

-- 隐藏所有图标
function ShopGrid:hideIcon()
    if(self._goodsGrid) then
        self._goodsGrid:hideIcon()
    end
    self:refreshIcon(false)
end

function ShopGrid:showSelect()
    if(self._goodsGrid) then
        self._goodsGrid:showSelect()
    end
end

function ShopGrid:hideSelect()
    if(self._goodsGrid) then
        self._goodsGrid:hideSelect()
    end
end

-- 克隆
function ShopGrid:createDraggedView()
    local newGoodsGrid = UI.GoodsGrid:create()
    newGoodsGrid:init(self._data)
    newGoodsGrid:setSize(self._goodsGrid._width, self._goodsGrid._height)
    newGoodsGrid:setIndex(self._index)
    newGoodsGrid:hideBG()

    return newGoodsGrid
end




