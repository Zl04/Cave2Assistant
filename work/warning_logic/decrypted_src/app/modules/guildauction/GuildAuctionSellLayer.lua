-- GuildAuctionSellLayer.lua
-- Author:luozhiming

require "app.ui.UIDefine"

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local GuildAuctionSellLayer = class("GuildAuctionSellLayer", UI.CenterWin)
UI.GuildAuctionSellLayer = GuildAuctionSellLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local COM_WIDTH = 390;
local COM_HEIGHT = 342;
local ZOrder = 1

--资源列表(必备)
local COM_RES_LIST = {
    
}

--构造函数(必备)
function GuildAuctionSellLayer:ctor(npcSpriteID, itemData)
     GuildAuctionSellLayer.super.ctor(
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
function GuildAuctionSellLayer:dtor()
    GuildAuctionSellLayer.super.dtor(self)
    self:unregisterListener()

    reload_script_file("app.modules.guildauction.GuildAuctionSellLayer")
end

-- 初始化(必备)
function GuildAuctionSellLayer:init()
    GuildAuctionSellLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function GuildAuctionSellLayer:onInitView()
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

    local curPriceLayout = UI.Layout:create();
    curPriceLayout:init()
    curPriceLayout:setSize(200, 22)
    curPriceLayout:centerUp(140)
    -- curPriceLayout:enableDebugDraw()
    self.bg:addChild(curPriceLayout, 1)

    local itemName = UI.Text:create()
    itemName:init(UI.TEXT_1213894, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
	itemName:floatLeft(0)
    curPriceLayout:addComponent(itemName)

    local diamondIcon1 = UI.Image:create()
    diamondIcon1:init("symbol_gaming_diamond.png")
    diamondIcon1:floatLeft(4)
    curPriceLayout:addComponent(diamondIcon1)

    local diamondTxt = UI.Text:create()
    diamondTxt:init(tostring(self._data.curPrice), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
	diamondTxt:floatLeft(4)
    curPriceLayout:addComponent(diamondTxt)

    curPriceLayout:setSize(
        itemName:getContentSize().width+diamondIcon1:getContentSize().width+diamondTxt:getContentSize().width+8, 22)


    local minePriceTxt = UI.Text:create()
    minePriceTxt:init(UI.TEXT_1213895, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    minePriceTxt:centerUp(180)
    self.bg:addChild(minePriceTxt)

    local priceBg = UI.Image:create()
    priceBg:init("ui_guild_auction_modify_banner.png")
    priceBg:centerUp(206)
    self.bg:addChild(priceBg)

    local diamondIcon2 = UI.Image:create()
    diamondIcon2:init("symbol_gaming_diamond.png")
    diamondIcon2:centerLeft(30)
    priceBg:addChild(diamondIcon2)

    self.minPrice = self._data.curPrice + PublicDefine.GuildAuctionConfig.AddPrice
    -- 服务器数据“当前最高出价”，初始为0
    if self._data.bigBoss.price == 0 then
        self.minPrice = self._data.startPrice
    end
    self.maxPrice = self._data.onePrice
    self.finalPrice = self.minPrice

    -- 文本输入框
    local priceEdit = UI.EditBox:create(160, 30)
    self.guildNameHolderTxt = tostring(self.minPrice)
    priceEdit:init(self.guildNameHolderTxt, cc.EDITBOX_INPUT_MODE_SINGLELINE, nil, 84, 0)
    priceEdit:centerLeft(50)
    priceBg:addChild(priceEdit)
    priceEdit:setFontSize(18)
    priceEdit:setFontColor(UI.FONT_COLOR_230_190_120)
    priceEdit:setPlaceholderFontSize(18)
    priceEdit:setPlaceholderFontColor(UI.FONT_COLOR_230_190_120)
    priceEdit:setChangeCallback(function()
        local message = priceEdit:getText() or ""
        local isHave = string.find(message, "\n")
        if isHave ~= nil then
            message = string.gsub(message, "\n", "")
            priceEdit:setText(message)
            AvalonUtil.closeKeyBoard(priceEdit)
            return
        end
    end)

    priceEdit:setReturnCallback(function()
        -- 表情
        local message = priceEdit:getText() or ""
        if AvalonUtil:isEmoji(message) then
            UI.ScrollBar:createByText(UI.TEXT_1170936)
            priceEdit:setText(self.guildNameHolderTxt)
            priceEdit:setPlaceHolder(self.guildNameHolderTxt)
            return
        end

        -- 处理敏感字
        -- local mark = false
        -- message,mark = ToolsUtil:checkMaskword(message)
        -- if mark then
        --     UI.ScrollBar:createByText(UI.TEXT_1170415)
        --     priceEdit:setText(self.guildNameHolderTxt)
        --     priceEdit:setPlaceHolder(self.guildNameHolderTxt)
        --     return
        -- end

        -- 回车
        local isHave = string.find(message, "\n")
        if isHave ~= nil then
            message = string.gsub(message, "\n", "")
        end

        -- 小数点
        isHave = string.find(message, "%p")
        if isHave ~= nil then
            UI.ScrollBar:createByText(UI.TEXT_1213911)
            priceEdit:setText(self.guildNameHolderTxt)
            priceEdit:setPlaceHolder(self.guildNameHolderTxt)
            return
        end

        local priceNum = tonumber(message)
        if priceNum == nil then
            UI.ScrollBar:createByText(UI.TEXT_1170415)
            priceEdit:setText(self.guildNameHolderTxt)
            priceEdit:setPlaceHolder(self.guildNameHolderTxt)
            return
        end

        if priceNum < 0 then
            UI.ScrollBar:createByText(UI.TEXT_1170415)
            priceEdit:setText(self.guildNameHolderTxt)
            priceEdit:setPlaceHolder(self.guildNameHolderTxt)
            return
        end

        if priceNum < self.minPrice or priceNum > self.maxPrice then
            UI.ScrollBar:createByText(UI.TEXT_1170415)
            priceEdit:setText(self.guildNameHolderTxt)
            priceEdit:setPlaceHolder(self.guildNameHolderTxt)
            return
        end

        -- 设置表现
        priceEdit:setText(tostring(priceNum))
        priceEdit:setPlaceHolder(tostring(priceNum))

        self.finalPrice = priceNum
    end)
    self.priceEdit = priceEdit


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
        finalData.bidPrice = self.finalPrice
        Net.NetNPCSystem:requestGuildAuctionBuy(finalData, self.spriteID)
        self:closeWin()
    end)
    yes:rightBottom(51, 20)
    yes:closeClickScale()
    self.bg:addChild(yes)
end

function GuildAuctionSellLayer:registerListener()
    -- Avalon.MessageCenter:bind(GameMessage.MC_UI_GUILD_REFRESH_NAME, self,self.renameOver)
    -- Avalon.MessageCenter:bind(GameMessage.MC_UI_GUILD_CHANGE_TITLE_NAME, self,self.renameOver)
end

function GuildAuctionSellLayer:unregisterListener()
    -- Avalon.MessageCenter:unbind(GameMessage.MC_UI_GUILD_REFRESH_NAME, self,self.renameOver)
    -- Avalon.MessageCenter:unbind(GameMessage.MC_UI_GUILD_CHANGE_TITLE_NAME, self,self.renameOver)
end
---------------------------------------
-- eo 事件处理 --
