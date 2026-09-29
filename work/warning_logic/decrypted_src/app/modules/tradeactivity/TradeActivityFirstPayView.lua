------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/09/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SdkManager = require "app.game.SdkManager"
local SceneManager = require("app.game.SceneManager")
local TradeActivityFirstPayView = class("TradeActivityFirstPayView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_businessactivities_special_giftbag.plist",
    "ui_town_businessactivities.plist",
}

local COM_WIDTH = 753
local COM_HEIGHT = 562

function TradeActivityFirstPayView:ctor()
    TradeActivityFirstPayView.super.ctor(
    	self,
    	UI.Type.TRADE_ACTIVITY_FIRST,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    mvc.tradeActivityModel:setCurActivityID(PublicDefine.TradeActivityIDList.TradeActivityFirstPay)
    self:bindModel()
end

function TradeActivityFirstPayView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    TradeActivityFirstPayView.super.init(self, ... )
end

function TradeActivityFirstPayView:dtor()
    TradeActivityFirstPayView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.tradeactivity.TradeActivityFirstPayView")
end

function TradeActivityFirstPayView:bindModel()
    mvc.tradeActivityModel:bind("firstGiftGrade", self, self.updateLevelShow)
    mvc.tradeActivityModel:bind("giftBoughtList", self, self.updateLevelShow)
end


function TradeActivityFirstPayView:unbindModel()
    mvc.tradeActivityModel:unbind("firstGiftGrade", self, self.updateLevelShow)
    mvc.tradeActivityModel:unbind("giftBoughtList", self, self.updateLevelShow)
end


function TradeActivityFirstPayView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 内部背景图片
    local innerBG  = UI.Image:create()
    innerBG:init("ui_specialpackage_bg.png")
    innerBG:leftUp(28, 16)
    -- innerBG:enableDebugDraw()
    contentLayout:addChild(innerBG)
    self.innerBG = innerBG

    local title = UI.Text:create()
    title:init(UI.TEXT_1324511, UI.FONT_BOLD, UI.FONT_SIZE_48PX, UI.FONT_COLOR_255_255_255)
    title:center(108, -188)
    title:setSize(340, 88)
    title:setTextCenter()
    title:setRotation(-7)
    if LanguageManager:getInstance():getLanguage() ~= cc.LANGUAGE_CHINESE then
        title:setFontSize(UI.FONT_SIZE_38PX)
        title:setLineSpacing(-10)

        local titleShadow = UI.Text:create()
        titleShadow:init(UI.TEXT_1324511, UI.FONT_BOLD, UI.FONT_SIZE_38PX, UI.FONT_COLOR_0_0_0)
        titleShadow:center(112, -184)
        titleShadow:setSize(340, 88)
        titleShadow:setTextCenter()
        titleShadow:setRotation(-7)
        titleShadow:setFontSize(UI.FONT_SIZE_38PX)
        titleShadow:setLineSpacing(-10)
        self.contentLayout:addChild(titleShadow)
    else
        title:setFontSize(UI.FONT_SIZE_48PX)
        title:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(4, -4))
    end
    self.contentLayout:addChild(title)

    -- 左侧人物
    local leftImg = UI.Image:create()
    leftImg:init("ui_specialpackage_illustration.png")
    leftImg:center(-234, -20)
    contentLayout:addChild(leftImg)
    self.leftImg = leftImg

    -- 正中发光
    local lightImg = UI.Image:create()
    lightImg:init("ui_specialpackage_light.png")
    lightImg:center(108, -36)
    contentLayout:addChild(lightImg)

    -- 购买按钮
    local buyButton = UI.Button:create()
    buyButton:init('ui_specialpackage_btn.png', 'ui_specialpackage_btn.png')
    buyButton:center(110, 200)
    buyButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    buyButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end
        
        UI.WaitingLayer:showWaiting(true, nil, 2)
        SdkManager:getInstance():getOrder(self.showGiftData, 1, PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_EXTRA_GIFT)
    end)
    contentLayout:addChild(buyButton)
    self.buyButton = buyButton

    self:updateLevelShow()

    -- 关闭按钮
    local closeBtn = UI.Button:create()
    closeBtn:init('ui_specialpackage_close.png', 'ui_specialpackage_close.png')
    closeBtn:rightUp(0, 90)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.closePanel("TradeActivity", "TradeActivityFirstPay")
    end)
    contentLayout:addChild(closeBtn)
end


function TradeActivityFirstPayView:updateAwardsLayer()
    if self.awardsLayout and not tolua.isnull(self.awardsLayout) then
        self.awardsLayout:removeFromParent()
    end

    if self.centerFrameImg and not tolua.isnull(self.centerFrameImg) then
        self.centerFrameImg:removeFromParent()
    end

    self.awardsLayout = UI.Layout:create()
    self.awardsLayout:init()
    self.awardsLayout:enableAutoWidth()
    self.awardsLayout:enableAutoHeight()
    -- self.awardsLayout:enableDebugDraw()
    self.awardsLayout:center(108, 100)
    self.contentLayout:addChild(self.awardsLayout)

    local awardsList = self.showGiftData.products

    for k, v in ipairs(awardsList) do
        local goodData = GoodsDataManager:createLocalGoodsData(tonumber(v.id))
        if goodData then
            goodData:setNum(0)
            goodData:setIsNew(false)
            goodData.isHaveGet = false

            -- 创建边框
            local frameImg = nil
            if k == 1 then
                -- 正中金色框
                frameImg = UI.Image:create()
                frameImg:init("ui_specialpackage_box.png")
                frameImg:center(108, -36)
                self.contentLayout:addChild(frameImg)
                self.centerFrameImg = frameImg
            else
                frameImg = UI.Image:create()
                frameImg:init("ui_specialpackage_box_02.png")
                if k == 2 then
                    frameImg:floatLeft(0)
                else
                    frameImg:floatLeft(20)
                end
                self.awardsLayout:addComponent(frameImg)
            end

            local rewardGrid = UI.GoodsGrid:create()
            rewardGrid:init(goodData)
            if k ~= 1 then
                rewardGrid:setScale(0.8)
            end
            rewardGrid:hideNewIcon()
            rewardGrid:hideBG()
            rewardGrid:hideRare()
            rewardGrid:center()
            rewardGrid:setTouchEnable(true)
            rewardGrid:setSwallowTouches(false)
            rewardGrid:setTouchClipNode(frameImg)
            rewardGrid:showInfoArea(true, false)
            frameImg:addChild(rewardGrid)

            -- 创建数量文本
            local numText = UI.NumberText:create(v.num, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_227_214_172, 5)
            if k ~= 1 then
                numText:rightBottom(8, 4)
            else
                numText:rightBottom(8, 6)
            end
            frameImg:addChild(numText)
        end
    end

end


function TradeActivityFirstPayView:updateBuyBtn()
    local nowPrice = UIUtil:getMoneyPriceStr(self.showGiftData.price/100)

    if self.currencyIcon and not tolua.isnull(self.currencyIcon) then
        self.currencyIcon:setSpriteName(UIUtil:getMoneyPng())
    end

    if self.priceLabel and not tolua.isnull(self.priceLabel) then
        self.priceLabel:setText(nowPrice)
        return
    end

    -- 价钱排版
    local priceLayout = UI.Layout:create()
    priceLayout:init()
    priceLayout:center()
    priceLayout:enableAutoHeight()
    priceLayout:enableAutoWidth()
    priceLayout:setName("priceLayout")
    self.buyButton._text:addChild(priceLayout, 100)

    -- 货币图标
    local currencyIcon = UI.Image:create()
    currencyIcon:init(UIUtil:getMoneyPng())
    currencyIcon:floatLeft(0)
    priceLayout:addComponent(currencyIcon)
    self.currencyIcon = currencyIcon

    -- 价钱文字
    local priceLabel = UI.Text:create()
    priceLabel:init(nowPrice, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    priceLabel:floatLeft(8)
    priceLayout:addComponent(priceLabel)
    self.priceLabel = priceLabel
end

-- 优惠描述文本
function TradeActivityFirstPayView:updateDesc()

    if self.descLayout and not tolua.isnull(self.descLayout) then
        self.descLayout:removeFromParent()
    end

    local discountStr = ConfigManager:getGeneralForKey("specialdiscount")
    local nowPrice = string.split(discountStr, ",")[self.showGiftLevel]

    local descLayout = UI.Layout:create()
    descLayout:init()
    descLayout:setSize(280, 80)
    descLayout:setRotation(22)
    -- descLayout:enableDebugDraw()
    descLayout:center(270, -90)
    self.contentLayout:addChild(descLayout)
    self.descLayout = descLayout

    local priceText = UI.Text:create()
    priceText:init(tostring(nowPrice), UI.FONT_BOLD, UI.FONT_SIZE_34PX, UI.FONT_COLOR_181_32_32)
    priceText:center(0, -22)
    priceText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(3, -3))
    descLayout:addChild(priceText)

    local descShadow = UI.Text:create()
    descShadow:init(UI.TEXT_1324521, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_0_0_0)
    descShadow:center(3, 23)
    descShadow:setTextHorizontalCenter()
    descShadow:setSize(280, 58)
    descShadow:setLineSpacing(-12)
    descLayout:addChild(descShadow)

    local descText = UI.Text:create()
    descText:init(UI.TEXT_1324521, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_181_32_32)
    descText:center(0, 20)
    descText:setTextHorizontalCenter()
    descText:setSize(280, 58)
    descText:setLineSpacing(-12)
    descLayout:addChild(descText)

end

function TradeActivityFirstPayView:updateLevelShow()

    -- 先判断首充是否领完，需要关闭
    if mvc.tradeActivityModel:getFirstPayIsOver() then
        mvc.closePanel("TradeActivity", "TradeActivityFirstPay")
        return
    end

    local firstPayGiftData = mvc.tradeActivityModel:getFirstPayGiftData()
    local giftGrade = mvc.tradeActivityModel:getFirstGrade()

    self.showGiftLevel = giftGrade
    self.showGiftData = firstPayGiftData[giftGrade]

    self:updateAwardsLayer()
    self:updateBuyBtn()
    self:updateDesc()
end

return TradeActivityFirstPayView












