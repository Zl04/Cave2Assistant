UI = UI or {}
local IapShopBoxDetailsCell = class("IapShopBoxDetailsCell",UI.TableViewCell)
UI.IapShopBoxDetailsCell = IapShopBoxDetailsCell
local Scheduler = Avalon.Scheduler
local winSize = cc.Director:getInstance():getWinSize()

-- 弹出详情页面的时间间隔
local TIME_SPACED = 0.2

function IapShopBoxDetailsCell:ctor()
    IapShopBoxDetailsCell.super.ctor(self)
    self._nameLabel1 = nil
    self._goodsGrid1 = nil
    self._countLabel1 = nil
    -- self._nameLabel2 = nil
    -- self._goodsGrid2 = nil
    -- self._countLabel2 = nil
    self:onInitView()
end

function IapShopBoxDetailsCell:dtor()
    IapShopBoxDetailsCell.super.dtor(self)
end

function IapShopBoxDetailsCell:onInitView( ... )
    self:setContentSize(cc.size(1000, 88))

    self._itemHost1, self._goodsGrid1, self._countLabel1, self._nameLabel1  = self:createItem()
    self._itemHost1:leftUp(0, 0)
    self:addChild(self._itemHost1)

    -- self._itemHost2, self._goodsGrid2, self._countLabel2, self._nameLabel2 = self:createItem()
    -- self._itemHost2:leftUp(136, 0)
    -- self:addChild(self._itemHost2)
end

function IapShopBoxDetailsCell:createItem()
    -- 单元背景
    local itemBg = UI.Image:create()
    itemBg:init("ui_shopping_banner_box1_paper.png")

    -- 物品栏
    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:init(GoodsDataManager:createLocalGoodsData(20050010))
    goodsGrid:centerLeft(15)
    goodsGrid:showInfoArea(true, false)
    goodsGrid:setSwallowTouches(false)
    itemBg:addChild(goodsGrid)

    -- 名字
    local nameLabel = UI.Text:create()
    nameLabel:init("" , UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    nameLabel:leftBottom(107, 31)
    nameLabel:setDimensions(145, 54)
    nameLabel:setTextVerticalCenterAndHLeft()
    itemBg:addChild(nameLabel)

    -- 数量
    local countLabel = UI.Text:create()
    countLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    countLabel:leftBottom(107, 7)
    itemBg:addChild(countLabel)

    return itemBg, goodsGrid, countLabel, nameLabel
end

function IapShopBoxDetailsCell:onUpdateView(data1, data2)
    if not data1 and not data2 then
        return
    end

    -- 一行里面第一个物品
    if (data1) then
        local goods1 = GoodsDataManager:createLocalGoodsData(checkint(data1.id))
        if(goods1) then
            goods1:setIsNew(false)
            self._goodsGrid1:setData(goods1)
            self._goodsGrid1:updateView()
            self._goodsGrid1:hideNewIcon()
            self._countLabel1:setText("X"..(data1.num or "1"))
            self._nameLabel1:setText(goods1:getName())
            self._itemHost1:setVisible(true)
            self._goodsGrid1:setTouchEnable(true)
        else
            self._itemHost1:setVisible(false)
            self._goodsGrid1:setTouchEnable(false)
        end
    else
        self._itemHost1:setVisible(false)
        self._goodsGrid1:setTouchEnable(false)
    end

    -- -- 一行里面第二个物品
    -- if (data2) then
    --     local goods2 = GoodsDataManager:createLocalGoodsData(checkint(data2.id))
    --     if(goods2) then
    --         goods2:setIsNew(false)
    --         self._goodsGrid2:setData(goods2)
    --         self._goodsGrid2:updateView()
    --         self._goodsGrid2:hideNewIcon()
    --         self._countLabel2:setText("X"..(data1.num or "1"))
    --         self._nameLabel2:setText(goods2:getName())
    --         self._itemHost2:setVisible(true)
    --         self._goodsGrid2:setTouchEnable(true)
    --     else
    --         self._itemHost2:setVisible(false)
    --         self._goodsGrid2:setTouchEnable(false)
    --     end
    -- else
    --     self._itemHost2:setVisible(false)
    --     self._goodsGrid2:setTouchEnable(false)
    -- end
end
return IapShopBoxDetailsCell