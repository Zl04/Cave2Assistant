------------------------------------------------------------------------------
--author: 
--date	: 2019/08/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BattlePassChargeView = class("BattlePassChargeView", UI.HWBtnComponent)
local SdkManager = require"app.game.SdkManager"
-- 资源
local COM_RES_LIST = {
}

local CHARGE_CELL_TYPE = {
    GLOD = 1,
    SPECIAL = 2,
}

local COM_WIDTH = 775
local COM_HEIGHT = 410
local winSize = cc.Director:getInstance():getWinSize()
local layoutUU
function BattlePassChargeView:ctor()
    BattlePassChargeView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    layoutUU = UIUtil:createAutoUILayout("BattlePassChargeView","app.modules.battlepass.BattlePassPosConfig", false)

    local  sourceType = PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_None
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_BattlePass, 2, nil, nil, sourceType)
end

function BattlePassChargeView:dtor()
    BattlePassChargeView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.battlepass.BattlePassChargeView")
end


function BattlePassChargeView:onInitView()
    local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,150))
    colorLayer:setPosition((COM_WIDTH - winSize.width) / 2, (COM_HEIGHT - winSize.height) / 2)
    colorLayer:setContentSize(winSize.width, winSize.height)
    self:addChild(colorLayer, -1) 

    local bg = UI.Image:create()
    bg:init("ui_passcheck_banner_purchase.png")
    bg:leftUp(-38, 20)
    self:addChild(bg)

    local flag = UI.Animation:create()
    flag:init("effect_ui_twon_passcheck_goumai.json", "effect_ui_twon_passcheck_goumai.atlas", 1);
    flag:leftBottom(412, 232)
    bg:addChild(flag, 10)
    flag:setAnimation("idle", true)
    flag:enableDebugDraw()

    local content = UI.Text:create()
    content:init(languageManagerInstance:getLocalString(1112726), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    content:setWidth(128)
    content:autoAdapt()
    content:leftBottom(-358, -100 - content:getContentSize().height / 2)
    content:setTextCenter()
    flag:addChild(content, 10)


    local goldPanel = self:createChargeCell(CHARGE_CELL_TYPE.GLOD)
    goldPanel:leftBottom(205, 42)
    bg:addChild(goldPanel)

    local specialPanel = self:createChargeCell(CHARGE_CELL_TYPE.SPECIAL)
    specialPanel:leftBottom(480, 42)
    bg:addChild(specialPanel)
    self.goldPanel = goldPanel
    self.specialPanel = specialPanel
    self:refreshView()
end

function BattlePassChargeView:createChargeCell(cType)
    local bgImageName = ""
    local nameText = ""
    if CHARGE_CELL_TYPE.GLOD == cType then
        bgImageName = "ui_passcheck_banner_box1.png"
        nameText = UI.TEXT_1212907
    elseif CHARGE_CELL_TYPE.SPECIAL == cType then
        bgImageName = "ui_passcheck_banner_box2.png"
        nameText = UI.TEXT_1212908
    end

    local bg =  UI.Image:create()
    bg:init(bgImageName)
    
    local title = UI.Text:create()
    title:init(nameText, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    title:centerUp(12)
    bg:addChild(title, 10)

    local buyButton = UI.Button:create()
    buyButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    buyButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        self:buyClick(cType)
    end)
    buyButton:centerBottom(20)
    bg:addChild(buyButton)
    buyButton:setText(LanguageManager:getInstance():getLocalString(1111581))
    buyButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    buyButton:setName("BuyButton")
    buyButton:disable()
    buyButton:hide()
    return bg
end

function BattlePassChargeView:refreshView()
    self:refreshCell(self.goldPanel, CHARGE_CELL_TYPE.GLOD)
    self:refreshCell(self.specialPanel, CHARGE_CELL_TYPE.SPECIAL)
end 

function BattlePassChargeView:refreshCell(panel, cType)
    local data = nil
    if CHARGE_CELL_TYPE.GLOD == cType then
        data = mvc.battlePassModel:getIapDataByType(PublicDefine.BattlePassIndex.BattlePassIndex_Noraml)
    elseif CHARGE_CELL_TYPE.SPECIAL == cType then
        local normaLData = mvc.battlePassModel:getIapDataByType(PublicDefine.BattlePassIndex.BattlePassIndex_Noraml)
        local luxurydDta = mvc.battlePassModel:getIapDataByType(PublicDefine.BattlePassIndex.BattlePassIndex_Luxury)
        local luxuryDisData = mvc.battlePassModel:getIapDataByType(PublicDefine.BattlePassIndex.BattlePassIndex_LuxuryDiscount)
        if luxuryDisData and luxuryDisData.isBought and normaLData and normaLData.isBought then
            data = luxurydDta
            data.isBought = true
        elseif normaLData and normaLData.isBought then
            data = luxuryDisData
        else
            data = luxurydDta
        end
    end

    if data == nil then
        return
    end
    -- data.goods = {{itemId = 22040340, num = 2}, {itemId = 22040340, num = 2}, {itemId = 22040340, num = 2}, {itemId = 22040340, num = 2}}

    --item
    panel:removeChildByName("Item")
    local itemPanel = self:createItemPanel(data.goods)
    panel:addChild(itemPanel, 10)

    --button
    local buyButton = panel:getChildByName("BuyButton")
    buyButton:show()
    buyButton:removeChildByName("OldPrice")
    buyButton:removeChildByName("NewPrice")
    if data and data.isBought then
        buyButton:setText(LanguageManager:getInstance():getLocalString(1111581))
        buyButton:disable()
    else
        buyButton:enable()
        buyButton:setText("")

        local SdkManager = require "app.game.SdkManager"
        local iapId
        if (data.IAPList and #data.IAPList > 0 and data.IAPList[1] and data.IAPList[1].iapId) then
            iapId = data.IAPList[1].iapId
        end
        local priceString = SdkManager:getInstance():getPriceStringFromIapID(iapId)

        if data and data.origPrice ~= nil and data.origPrice ~= 0 and checkint(data.origPrice) > checkint(data.price) then
            local oriPriceStr = UIUtil:getMoneyPriceStr(data.origPrice / 100)
            if (priceString) then
                local sign = AvalonUtil.getCurrencySignFromPriceString(priceString)
                local priceValue = SdkManager:getInstance():getPriceValueFromIapID(iapId)
                local postOffPrice = data.price / 100
                local factor = priceValue / postOffPrice
                local preOffPrice = data.origPrice / 100
                local oriPriceInLocalCurrency = preOffPrice * factor
                oriPriceStr = sign .. string.format("%.2f", oriPriceInLocalCurrency)
            end

            local oldPrice = UI.Text:create()
            oldPrice:init(oriPriceStr, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
            buyButton:addChild(oldPrice, 10)
            oldPrice:setName("OldPrice")

            if (not priceString) then
                local currencyIcon = UI.Image:create()
                currencyIcon:init(UIUtil:getMoneyPng())
                currencyIcon:centerLeft(-currencyIcon:getContentSize().width - 3)
                oldPrice:addChild(currencyIcon)
            end

            local size = oldPrice:getContentSize()
            local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_Infomation_discount_line.png")
            lineUpImage:setContentSize(size.width, 2)
            lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
            lineUpImage:setPosition(cc.p(size.width/2, size.height/2))
            lineUpImage:setName("redline")
            oldPrice:addChild(lineUpImage, 1001)

            local proccessedPriceString = priceString or UIUtil:getMoneyPriceStr(data.price / 100)
            local newPrice = UI.Text:create()
            newPrice:init(proccessedPriceString, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
            buyButton:addChild(newPrice, 10)
            newPrice:setName("NewPrice")

            local currencyIconWidth = 10
            if (not priceString) then
                currencyIconWidth = 30
                local currencyIcon = UI.Image:create()
                currencyIcon:init(UIUtil:getMoneyPng())
                currencyIcon:centerLeft(-currencyIcon:getContentSize().width - 3)
                newPrice:addChild(currencyIcon)
            end

            local left = (buyButton:getContentSize().width - oldPrice:getContentSize().width - newPrice:getContentSize().width - 30) / 2
            oldPrice:centerLeft(left + 10)
            newPrice:centerLeft(oldPrice:getLeft() + oldPrice:getContentSize().width + currencyIconWidth)
        else
            local proccessedPriceString = priceString or UIUtil:getMoneyPriceStr(data.price / 100)
            local price = UI.Text:create()
            price:init(proccessedPriceString, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
            buyButton:addChild(price, 10)
            price:setName("NewPrice")
            price:center(10)

            if (not priceString) then
                local currencyIcon = UI.Image:create()
                currencyIcon:init(UIUtil:getMoneyPng())
                currencyIcon:centerLeft(-currencyIcon:getContentSize().width - 3)
                price:addChild(currencyIcon)
            end
        end
    end
end 

function BattlePassChargeView:createItemPanel(goods)
    local function createGride(data, isNameCenter)
        local goodsData = GoodsDataManager:createLocalGoodsData(data.itemId)
        if goodsData == nil then
            return
        end
        goodsData:setNum(data.num)
        goodsData:setIsNew(false)

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init(goodsData)
        goodsGrid:showInfoArea(true, false)
        -- goodsGrid:addEventListener(UIEvent.COMPONENT_CLICK, self, function( ... )
        --     local info = goodsGrid:onShowInfoAreaHandler()
        --     info:setZOrder(100000)
        -- end)

        local name = UI.Text:create()
        name:init(goodsData:getName(), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
        goodsGrid:addChild(name, 100)
        if isNameCenter then
            name:setWidth(150)
            name:centerUp(95)
            name:setTextCenter()
        else
            name:setWidth(110)
            name:centerLeft(80)
        end
        name:autoAdapt()
        return goodsGrid
    end

    local itemPanel = UI.Layout:create()
    itemPanel:init()
    itemPanel:setSize(210, 260)
    itemPanel:setName("Item")
    itemPanel:center()
    local size = #goods
    --1个布局
    if size == 1 then
        for k, data in ipairs(goods) do
            local goodsGrid = createGride(data, true)
            if goodsGrid then
                goodsGrid:centerUp(60)
                itemPanel:addChild(goodsGrid, 10)
            end
        end
    elseif size == 2 then
        local begin = 35
        for k, data in ipairs(goods) do
            local goodsGrid = createGride(data, false)
            if goodsGrid then
                goodsGrid:leftUp(15, begin)
                itemPanel:addChild(goodsGrid, 10)
                begin = begin + 100
            end
        end
    elseif size <= 3 then
        local begin = 10
        for k, data in ipairs(goods) do
            local goodsGrid = createGride(data, false)
            if goodsGrid then
                goodsGrid:leftUp(15, begin)
                itemPanel:addChild(goodsGrid, 10)
                begin = begin + 85
            end
        end
    else
        itemPanel:setSize(210, 85 * size + 10)
        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        detailedScrollView:setSize(210, 260)
        detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
        detailedScrollView:addInnerNode(itemPanel)
        detailedScrollView:setScrollBarEnabled(true)
        detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        detailedScrollView:setCircleVisible(false)
        detailedScrollView:setScrollBarWidth(5)
        detailedScrollView:setScrollBarPositionFromCornerForVertical(cc.p(2, 0))
        detailedScrollView:setName("Item")
        detailedScrollView:center()
        local begin = 10
        for k, data in ipairs(goods) do
            local goodsGrid = createGride(data, false)
            if goodsGrid then
                goodsGrid:leftUp(20, begin)
                itemPanel:addChild(goodsGrid, 10)
                begin = begin + 85
            end
        end
        return detailedScrollView
    end
    return itemPanel
end

function BattlePassChargeView:bindModel()
    mvc.battlePassModel:bind("PassRewardData", self, self.refreshView)
end


function BattlePassChargeView:unbindModel()
    mvc.battlePassModel:unbind("PassRewardData", self, self.refreshView)
end

function BattlePassChargeView:buyClick(cType)
    local data = nil
    if CHARGE_CELL_TYPE.GLOD == cType then
        data = mvc.battlePassModel:getIapDataByType(PublicDefine.BattlePassIndex.BattlePassIndex_Noraml)
    elseif CHARGE_CELL_TYPE.SPECIAL == cType then
        local normaLData = mvc.battlePassModel:getIapDataByType(PublicDefine.BattlePassIndex.BattlePassIndex_Noraml)
        if normaLData and normaLData.isBought then
            data = mvc.battlePassModel:getIapDataByType(PublicDefine.BattlePassIndex.BattlePassIndex_LuxuryDiscount)
        else
            data = mvc.battlePassModel:getIapDataByType(PublicDefine.BattlePassIndex.BattlePassIndex_Luxury)
        end
    end
    if data then
        print("---buyClick----", cType, data)
        SdkManager:getInstance():getOrder(data, 1)
    end
end


return BattlePassChargeView












