-- GuildAuctionSellOnePriceLayer.lua
-- Author:luozhiming

require "app.ui.UIDefine"

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local GuildAuctionSellOnePriceLayer = class("GuildAuctionSellOnePriceLayer", UI.CenterWin)
UI.GuildAuctionSellOnePriceLayer = GuildAuctionSellOnePriceLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local COM_WIDTH = 390;
local COM_HEIGHT = 342;
local ZOrder = 1

--资源列表(必备)
local COM_RES_LIST = {
    
}

--构造函数(必备)
function GuildAuctionSellOnePriceLayer:ctor(npcSpriteID, itemData)
     GuildAuctionSellOnePriceLayer.super.ctor(
        self, 
        UIType.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.spriteID = npcSpriteID
    self._data = itemData
    self.isNoticeShowMainUI = false
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
    self:open()
end

--虚构函数, destroy时调用(必备)
function GuildAuctionSellOnePriceLayer:dtor()
    GuildAuctionSellOnePriceLayer.super.dtor(self)
    self:unregisterListener()

    reload_script_file("app.modules.guildauction.GuildAuctionSellOnePriceLayer")
end

-- 初始化(必备)
function GuildAuctionSellOnePriceLayer:init()
    GuildAuctionSellOnePriceLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function GuildAuctionSellOnePriceLayer:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0,0,0,128));
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    contentLayout:addChild(mask)

    local maskLayout = UI.Layout:create();
    maskLayout:init()
    maskLayout:setSize(winSize.width * 2, winSize.height * 2)
    maskLayout:center()
    maskLayout:setTouchEnable(true)
    maskLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function() self:closeWin() end)
    contentLayout:addChild(maskLayout, 0)

    -- 背景图片
    local bg = UI.Image9:create()
    bg:init(
        "ui_tips_banner_box2.png",
        CCRectMake(COM_WIDTH/2+40, COM_HEIGHT/2+40, 1, 1),
        cc.size(COM_WIDTH, COM_HEIGHT)
    )
    bg:center()
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;
    self.bg = bg

    local itemName = UI.Text:create()
    itemName:init(self._data.name,UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    itemName:setSize(200, 22)
    itemName:setTextCenter()
	itemName:centerUp(26)
    self.bg:addChild(itemName)

    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:centerUp(62)

    local goodsData = GoodsDataManager:createLocalGoodsData(self._data.id)
    goodsData:setNum(self._data.num)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(false, false)
    self.bg:addChild(goodsGrid, 1)

    local minePriceTxt = UI.Text:create()
    minePriceTxt:init(UI.TEXT_1213882,UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    minePriceTxt:centerUp(180)
    self.bg:addChild(minePriceTxt)

    local priceBg = UI.Image:create()
    priceBg:init("ui_guild_auction_price_banner.png")
    priceBg:centerUp(216)
    self.bg:addChild(priceBg)
    
    -- 钻石
    local diamondImage2 = UI.Image:create()
    diamondImage2:init("symbol_gaming_diamond.png")
    diamondImage2:centerLeft(6)
    priceBg:addChild(diamondImage2, 1)

    local priceNum2 = UI.Text:create()
    priceNum2:init(tostring(self._data.onePrice), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_230_190_120)
    priceNum2:setSize(116, 20)
    priceNum2:setTextCenter()
    priceNum2:centerLeft(26)
    -- priceNum2:enableDebugDraw()
    priceBg:addChild(priceNum2)

    -- 取消按钮
    local no = UI.Button:create()
    no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    no:addEventListener(UIEvent.BUTTON_CLICK, self, function() self:closeWin() end)
    no:leftBottom(51, 20)
    no:closeClickScale()
    self.bg:addChild(no)

    -- 确认购买按钮
    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local finalData = {}
        finalData.dataVersion = mvc.guildAuctionModel:getDataVersion()
        finalData.bidIndex = self._data.idx
        finalData.auctionPoolId = self._data.poolId
        finalData.buyOut = self._data.isSold
        finalData.currentPrice = self._data.selfPrice
        finalData.bidPrice = self._data.onePrice
        Net.NetNPCSystem:requestGuildAuctionBuy(finalData, self.spriteID)
        self:closeWin()
    end)
    yes:rightBottom(51, 20)
    yes:closeClickScale()
    self.bg:addChild(yes)
end

function GuildAuctionSellOnePriceLayer:registerListener()
    -- Avalon.MessageCenter:bind(GameMessage.MC_UI_GUILD_REFRESH_NAME, self,self.renameOver)
    -- Avalon.MessageCenter:bind(GameMessage.MC_UI_GUILD_CHANGE_TITLE_NAME, self,self.renameOver)
end

function GuildAuctionSellOnePriceLayer:unregisterListener()
    -- Avalon.MessageCenter:unbind(GameMessage.MC_UI_GUILD_REFRESH_NAME, self,self.renameOver)
    -- Avalon.MessageCenter:unbind(GameMessage.MC_UI_GUILD_CHANGE_TITLE_NAME, self,self.renameOver)
end
---------------------------------------
-- eo 事件处理 --
