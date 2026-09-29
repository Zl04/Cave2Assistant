-- GuildAuctionSellCell.lua
-- Author:lzm
-- Using:world boss reward cell

UI = UI or {}

local GameDataManager = require("app.game.GameDataManager")

local GuildAuctionSellCell = class("GuildAuctionSellCell", UI.TableViewCell)
UI.GuildAuctionSellCell = GuildAuctionSellCell

local CELL_W = 814
local CELL_H = 84

require "app.modules.guildauction.GuildAuctionSellLayer"
require "app.modules.guildauction.GuildAuctionSellOnePriceLayer"

local StateDefine = {
    CLOSE = 1,
    PROMO = 2,
    OPEN = 3,
    RESULT = 4,
}

function GuildAuctionSellCell:ctor()

end

function GuildAuctionSellCell:onEnter()
    GuildAuctionSellCell.super.onEnter(self);
end

function GuildAuctionSellCell:onExit()
    GuildAuctionSellCell.super.onExit(self);
end

function GuildAuctionSellCell:init(spriteID, data, viewType, parentLayer)
    self.spriteID = spriteID
    self._data = data;
    self.viewType = viewType
    self.parentLayer = parentLayer

    self.errMsg = {UI.TEXT_1213898, UI.TEXT_1213899}
    self:onInitView();
end

function GuildAuctionSellCell:onInitView()
    self._cellLayout = cc.Layer:create();
    self._cellLayout:setPosition(cc.p(0,0));
    self._cellLayout:setContentSize(cc.size(CELL_W, CELL_H));
    self:addChild(self._cellLayout);

    self:initCellData();
end

function GuildAuctionSellCell:initCellData()
    local contentLayout = UI.Layout:create();
    contentLayout:init();
    contentLayout:setSize(CELL_W, CELL_H);
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self._cellLayout:addChild(contentLayout, 1)

    if self.viewType == 1 or self.viewType == 2 then
        self:initCellItemBg(contentLayout)
    else
        self:initCellLogBg(contentLayout)
    end

    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:center()

    local goodsData = GoodsDataManager:createLocalGoodsData(self._data.id)
    goodsData:setNum(self._data.num)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(false, false)
    self.itembg:addChild(goodsGrid, 1)
    if self._data.isSold then
        goodsGrid:setIsGray()
    else
        goodsGrid._isGray = false
    end

    if self.viewType == 1 or self.viewType == 2 then
        self:initCellItemDetail(contentLayout)
    else
        self:initCellLogDetail(contentLayout)
    end
end

function GuildAuctionSellCell:initCellItemBg(rootLayer)
    if self._data.isSold then
        local bg = UI.Image:create()
        bg:init("ui_guild_auction_banner_0.png")
        bg:centerLeft(8)
        rootLayer:addChild(bg)

        local itembg = UI.Image:create()
        itembg:init("ui_guild_auction_box_0.png")
        itembg:centerLeft(4)
        rootLayer:addChild(itembg)
        self.itembg = itembg

        local soldout = UI.Image:create()
        soldout:init("ui_guild_auction_sold.png")
        soldout:center()
        self.itembg:addChild(soldout, 2)
    else
        local bg = UI.Image:create()
        bg:init("ui_guild_auction_banner_1.png")
        bg:centerLeft(8)
        rootLayer:addChild(bg)

        local itembg = UI.Image:create()
        itembg:init("ui_guild_auction_box_1.png")
        itembg:centerLeft(4)
        rootLayer:addChild(itembg)
        self.itembg = itembg
    end
end

function GuildAuctionSellCell:initCellLogBg(rootLayer)
    local bg = UI.Image:create()
    bg:init("ui_guild_auction_record_banner.png")
    bg:centerLeft(8)
    rootLayer:addChild(bg)

    local itembg = UI.Image:create()
    itembg:init("ui_guild_auction_box_1.png")
    itembg:centerLeft(4)
    rootLayer:addChild(itembg)
    self.itembg = itembg
end

function GuildAuctionSellCell:initCellItemDetail(rootLayer)
    -- 名字
    local nameTxt = UI.Text:create()
    nameTxt:init(self._data.nickName, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_BLACK)
    nameTxt:setSize(200, 20)
    nameTxt:setTextCenter()
    nameTxt:centerLeft(110)
    -- nameTxt:enableDebugDraw()
    rootLayer:addChild(nameTxt)

    -- 竞价价格
    local priceLayout1 = UI.Layout:create();
    priceLayout1:init();
    priceLayout1:setSize(254, 46);
    priceLayout1:centerLeft(304)
    -- priceLayout1:enableDebugDraw()
    rootLayer:addChild(priceLayout1)

    local priceBg1 = UI.Image:create()
    priceBg1:init("ui_guild_auction_price_banner.png")
    priceBg1:centerLeft(0)
    priceLayout1:addChild(priceBg1)
    
    -- 钻石
    local diamondImage1 = UI.Image:create()
    diamondImage1:init("symbol_gaming_diamond.png")
    diamondImage1:centerLeft(6)
    priceBg1:addChild(diamondImage1, 1)

    -- 当前价格
    local priceNum1 = UI.Text:create()
    priceNum1:init(tostring(self._data.curPrice), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_230_190_120)
    priceNum1:setSize(116, 20)
    priceNum1:setTextCenter()
    priceNum1:centerLeft(26)
    -- priceNum1:enableDebugDraw()
    priceBg1:addChild(priceNum1)

    -- 当前出价
    local buyBtn1 = UI.Button:create();
    buyBtn1:init("ui_btn_yellow7_0.png","ui_btn_yellow7_1.png","ui_btn_yellow7_0.png");
    buyBtn1:centerLeft(148);
    buyBtn1:setText(UI.TEXT_1213892)
    buyBtn1:closeClickScale()
    buyBtn1:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    buyBtn1:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local ret = mvc.guildAuctionModel:checkCanBuyItem(1, self._data)
        if ret > 0 then
            UI.ScrollBar:createByTextID(self.errMsg[ret])
            return
        end

        self:showSellLayer()
    end)
    priceLayout1:addChild(buyBtn1)

    -- 一口价价格
    local priceLayout2 = UI.Layout:create();
    priceLayout2:init();
    priceLayout2:setSize(254, 46);
    priceLayout2:centerRight(4)
    -- priceLayout2:enableDebugDraw()
    rootLayer:addChild(priceLayout2)

    local priceBg2 = UI.Image:create()
    priceBg2:init("ui_guild_auction_price_banner.png")
    priceBg2:centerLeft(0)
    priceLayout2:addChild(priceBg2)
    
    -- 钻石
    local diamondImage2 = UI.Image:create()
    diamondImage2:init("symbol_gaming_diamond.png")
    diamondImage2:centerLeft(6)
    priceBg2:addChild(diamondImage2, 1)

    local priceNum2 = UI.Text:create()
    priceNum2:init(tostring(self._data.onePrice), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_230_190_120)
    priceNum2:setSize(116, 20)
    priceNum2:setTextCenter()
    priceNum2:centerLeft(26)
    -- priceNum2:enableDebugDraw()
    priceBg2:addChild(priceNum2)

    local buyBtn2 = UI.Button:create();
    buyBtn2:init("ui_btn_yellow7_0.png","ui_btn_yellow7_1.png","ui_btn_yellow7_0.png");
    buyBtn2:centerLeft(148);
    buyBtn2:setText(UI.TEXT_1213892)
    buyBtn2:closeClickScale()
    buyBtn2:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    buyBtn2:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local ret = mvc.guildAuctionModel:checkCanBuyItem(2, self._data)
        if ret > 0 then
            UI.ScrollBar:createByTextID(self.errMsg[ret])
            return
        end

        if self.viewType == 1 then
            self:showOnePriceSellLayer()
        elseif self.viewType == 2 then
            self:showSellLayer()
        end
    end)
    priceLayout2:addChild(buyBtn2)

    if self._data.isSelf then
        nameTxt:setFontColor(UI.FONT_COLOR_210_185_150)
    end

    -- 更新显示状态
    if self.viewType == 1 then
        if self._data.selfPrice >= self._data.curPrice then
            buyBtn1:hide()
            buyBtn1:disable()
        end

        if self._data.isSold then
            priceLayout1:hide()
            buyBtn1:disable()

            priceNum2:setFontColor(UI.FONT_COLOR_190_190_190)
            buyBtn2:hide()
            buyBtn2:disable()
        end
    elseif self.viewType == 2 then
        buyBtn1:hide()
        buyBtn1:disable()
        priceNum2:setText(tostring(self._data.selfPrice))

        if self._data.selfPrice >= self._data.curPrice then
            priceNum2:setFontColor(UI.FONT_COLOR_250_80_60)
            buyBtn2:hide()
            buyBtn2:disable()
        end

        if self._data.isSold then
            buyBtn2:hide()
            buyBtn2:disable()
        else
            buyBtn2:setText(UI.TEXT_1213893)
        end
    end

    local status = mvc.guildAuctionModel:getClientCurStatus()
    if status == StateDefine.RESULT then
        buyBtn1:hide()
        buyBtn1:disable()
        buyBtn2:hide()
        buyBtn2:disable()
    end
end

function GuildAuctionSellCell:showSellLayer()
    if self.parentLayer:getChildByName("GuildAuctionSellLayer") ~= nil then
        self.parentLayer.removeChildByName("GuildAuctionSellLayer")
    end

    local guildAuctionSellLayer = UI.GuildAuctionSellLayer:create(self.spriteID, self._data)
    guildAuctionSellLayer:init()
    guildAuctionSellLayer:center()
    guildAuctionSellLayer:setName("GuildAuctionSellLayer")
    self.parentLayer:addChild(guildAuctionSellLayer, 999)
end

function GuildAuctionSellCell:showOnePriceSellLayer()
    if self.parentLayer:getChildByName("GuildAuctionSellOnePriceLayer") ~= nil then
        self.parentLayer.removeChildByName("GuildAuctionSellOnePriceLayer")
    end

    local guildAuctionSellLayer = UI.GuildAuctionSellOnePriceLayer:create(self.spriteID, self._data)
    guildAuctionSellLayer:init()
    guildAuctionSellLayer:center()
    guildAuctionSellLayer:setName("GuildAuctionSellOnePriceLayer")
    self.parentLayer:addChild(guildAuctionSellLayer, 999)
end

function GuildAuctionSellCell:initCellLogDetail(rootLayer)
    local logTxt = UI.Text:create()
    logTxt:init(self._data.log, UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_BLACK)
    logTxt:setSize(564, 74)
    logTxt:setTextLeft()
    logTxt:centerLeft(96)
    -- logTxt:enableDebugDraw()
    rootLayer:addChild(logTxt)

    local tiemTxt = UI.Text:create()
    tiemTxt:init(string.format("%s\n%s", self._data.date, self._data.time), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_BLACK)
    tiemTxt:setSize(145, 74)
    tiemTxt:setTextCenter()
    tiemTxt:centerRight(5)
    -- tiemTxt:enableDebugDraw()
    rootLayer:addChild(tiemTxt)
end
