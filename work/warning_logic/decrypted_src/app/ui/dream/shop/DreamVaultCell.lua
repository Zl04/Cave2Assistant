require "app.ui.common.Text"
require "utils.AvalonUtil"

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local DreamVaultCell = class("DreamVaultCell", UI.Component)
UI.DreamVaultCell = DreamVaultCell

function DreamVaultCell:ctor(data, parent)
    DreamVaultCell.super.ctor(self, 1, {}, 700, 206)
    self.contentLayout = parent
    self.goodsGridPanels = {}
    self.data = data
    self.curLevel = MasterDataManager:getDreamData().maxLv or 0 
    self:init()
end

function DreamVaultCell:dtor()
    DreamVaultCell.super.dtor(self)
end

function DreamVaultCell:onInitView()   
    --titlebg
    local titlebg = UI.Image9:create()
    titlebg:init("ui_dreamword_shop_banner_1.png", CCRectMake(66,18,1,1), cc.size(184, 38))
    titlebg:leftUp(10, 1)
    self:addChild(titlebg, 10)
    self.titlebg = titlebg

    --title
    local title = UI.Text:create()
    title:init(self.data.name, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_WHITE)
    title:centerLeft(20)
    titlebg:addChild(title)
    if title:getContentSize().width > 110 then
        titlebg:setSize(184 + (title:getContentSize().width - 110), 38)
    end

    local lockBg = UI.Image9:create()
    lockBg:init("ui_dreamword_shop_banner_0_2.png", CCRectMake(75,15,1,1), cc.size(125, 29))
    lockBg:leftUp(titlebg:getContentSize().width - 36, 10)
    self:addChild(lockBg, 5)

    local locktip = UI.Text:create()
    locktip:init(string.format(UI.TEXT_1212338, self.data.dreamLV), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_WHITE)
    locktip:leftBottom(40, 6)
    lockBg:addChild(locktip)
    self.lockBg = lockBg
    if locktip:getContentSize().width > 62 then
        lockBg:setSize(130 + (locktip:getContentSize().width - 62), 29)
    end

    --itemBg
    local itemBg = UI.Image:create()
    itemBg:init("ui_purple_item_bg.png")
    itemBg:leftBottom(10, 30)
    self:addChild(itemBg)
    
  
    for k, v in ipairs(self.data.equipContent) do
       local panel, goodsGrid = self:createItem(v, self.data.equipNum[k], self.data.equipValue[k], k) 
       panel:leftBottom(10 + 140 * (k - 1), 0)
       self:addChild(panel)
       table.insert(self.goodsGridPanels, panel)
    end
end

function DreamVaultCell:createItem(itemId, number, price, index)
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(132, 132)

    local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
    goodsData:setIsNew(false)
    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:init(goodsData)
    goodsGrid:centerBottom(84)
    panel:addChild(goodsGrid, 1)
    goodsGrid:showInfoArea(false, true)
    goodsGrid:setName("GoodsGrid")
    -- goodsGrid:setTouchEnable(true)

    if number > 1 then
        local numberText = UI.Text:create()
        numberText:init(string.format("%s",number), UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_227_214_172)
        numberText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
        numberText:rightBottom(4, 0)
        goodsGrid:addChild(numberText, 20)
    end

    local lock = UI.Image:create()
    lock:init("ui_btn_purple_lock.png")
    lock:centerBottom(18)
    panel:addChild(lock)
    lock:setName("Lock")

    local btn = UI.Button:create();
    btn:init("ui_btn_purple_0.png","ui_btn_purple_1.png","ui_btn_purple_2.png");
    btn:centerBottom(28);
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:onBuyClick(index)
    end)
    panel:addChild(btn)
    btn:setName("BuyButton")

    local buyIcon = UI.Image:create()
    buyIcon:init("symbol_dreamword.png")
    btn:addChild(buyIcon, 10)

    local buyNumber = UI.Text:create()
    buyNumber:init(price.."", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    buyNumber:centerLeft(20)
    btn:addChild(buyNumber, 10)

    local left = (btn:getContentSize().width - buyIcon:getContentSize().width - buyNumber:getContentSize().width - 10) / 2
    buyIcon:centerLeft(left)
    buyNumber:centerLeft(left + buyIcon:getContentSize().width  + 5)

    return panel, goodsGrid
end

function DreamVaultCell:onUpdateView()
    if self.curLevel < self.data.dreamLV then 
        self.titlebg:useShader(UI.COMPONENT_PURPLE_SHADER)
        self.lockBg:useShader(UI.COMPONENT_PURPLE_SHADER)
        for k, panel in ipairs(self.goodsGridPanels) do
            local goodsGrid = panel:getChildByName("GoodsGrid")
            local buyBtn = panel:getChildByName("BuyButton")
            local lock = panel:getChildByName("Lock")
            goodsGrid:useShader(UI.COMPONENT_PURPLE_SHADER)
            goodsGrid:hideFlagIcon()
            buyBtn:hide()
            lock:show()
        end
    else
        for k, panel in ipairs(self.goodsGridPanels) do
            local buyBtn = panel:getChildByName("BuyButton")
            local lock = panel:getChildByName("Lock")
            buyBtn:show()
            lock:hide()
        end
        self.lockBg:hide()
    end
end

function DreamVaultCell:onBuyClick(index)
    local cur = RoleDataManager:getMaster():getDreamChip()
    if self.data.equipValue[index] > cur then
        UI.ScrollBar:createByText(UI.TEXT_1212305)
        return
    end

    local itemId = self.data.equipContent[index]
    local goodsArr = {}
    local data = {}
    data.goodsID = itemId
    data.num = self.data.equipNum[index]
    data.isGolden = true
    table.insert(goodsArr, data)
   
    local GameDataManager = require("app.game.GameDataManager")
    local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
    if not enough then
        UI.ScrollBar:createByTextID(1110793)
        return
    end

    local dreamShopConfirmLayer = UI.DreamShopConfirmLayer:create()
    dreamShopConfirmLayer:center(0)
    dreamShopConfirmLayer:init(self.data.equipValue[index])
    dreamShopConfirmLayer:setName("DreamShopConfirmLayer")
    dreamShopConfirmLayer:openShow()
    dreamShopConfirmLayer:setCallback(handler(self, function()
        if (GameDataManager:getFreePacketBoxNum() <= 0) then
            UI.ScrollBar:createByTextID(1110793)
            return
        end
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetNPCSystem:reqBuyDreamValut(self.data.ID, index - 1)
    end))
    self.contentLayout:addChild(dreamShopConfirmLayer, 20);
end