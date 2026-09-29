------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/09/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local TradeActivityDailyGiftBagView = class("TradeActivityDailyGiftBagView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_pay.plist"
}

local COM_WIDTH = 681
local COM_HEIGHT = 470

local GIFT_ITEM_WIDTH = 230
local GIFT_ITEM_HEIGHT = 300

local GIFT_POS_LIST = {
    {x = -216, y = 70},
    {x = 0, y = 70},
    {x = 216, y = 70},
}

function TradeActivityDailyGiftBagView:ctor()
    TradeActivityDailyGiftBagView.super.ctor(
    	self,
    	UI.Type.TRADE_ACTIVITY_DAILY_GIFT,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self:bindModel()
end

function TradeActivityDailyGiftBagView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    TradeActivityDailyGiftBagView.super.init(self, ... )
end

function TradeActivityDailyGiftBagView:dtor()
    TradeActivityDailyGiftBagView.super.dtor(self)

    self:unbindModel()
    reload_script_file_mvc("app.modules.tradeactivity.TradeActivityDailyGiftBagView")
end


function TradeActivityDailyGiftBagView:bindModel()
    mvc.tradeActivityModel:bind("dailyGiftData", self, self.updateGiftLayer)
    mvc.tradeActivityModel:bind("_targetList", self, self.updateGiftLayer)
end


function TradeActivityDailyGiftBagView:unbindModel()
    mvc.tradeActivityModel:unbind("dailyGiftData", self, self.updateGiftLayer)
    mvc.tradeActivityModel:unbind("_targetList", self, self.updateGiftLayer)
end


function TradeActivityDailyGiftBagView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 右侧底图
    local innerBg = UI.Image:create()
    innerBg:init("ui_businessactivities_bg_02.png")
    innerBg:center()
    contentLayout:addChild(innerBg)

    -- 内部背景图片
    local topImg  = UI.Image:create()
    topImg:init("ui_businessactivities_illustration.png")
    topImg:centerUp(12)
    self:addChild(topImg)

    -- 描述
    local desc = UI.Text:create()
    desc:init(UI.TEXT_1324518, UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_225_225_225)
    desc:setSize(280, 40)
    if LanguageManager:getInstance():getLanguage() ~= cc.LANGUAGE_CHINESE then
        desc:setFontSize(UI.FONT_SIZE_22PX)
        desc:setLineSpacing(-10)
    end
    desc:setTextLeft()
    -- desc:enableDebugDraw()
    desc:leftUp(10, 76)
    topImg:addChild(desc)

    local prompt = UI.Text:create()
    prompt:init(UI.TEXT_1324519, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_69_227_154)
    prompt:setSize(300, 30)
    if LanguageManager:getInstance():getLanguage() ~= cc.LANGUAGE_CHINESE then
        prompt:setFontSize(UI.FONT_SIZE_14PX)
        prompt:setLineSpacing(-5)
    end
    prompt:setTextLeft()
    prompt:leftUp(10, 116)
    -- prompt:enableDebugDraw()
    topImg:addChild(prompt)

    local updatePrompt = UI.Text:create()
    updatePrompt:init(UI.TEXT_1324520, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_225_225_225)
    updatePrompt:setSize(180, 30)
    if LanguageManager:getInstance():getLanguage() ~= cc.LANGUAGE_CHINESE then
        updatePrompt:setFontSize(UI.FONT_SIZE_14PX)
        updatePrompt:setLineSpacing(-5)
    end
    updatePrompt:setTextCenter()
    -- updatePrompt:enableDebugDraw()
    updatePrompt:rightUp(2, 116)
    topImg:addChild(updatePrompt)

    self:updateGiftLayer()
end

function TradeActivityDailyGiftBagView:updateGiftLayer()
    UI.WaitingLayer:hideWaiting()

    local oldSpeicialData = self.specialFreeData

    self.specialFreeData = mvc.tradeActivityModel:getSpecialFreeDailyGiftData()
    print("updateGiftLayer=", self.specialFreeData)
    self.giftBagData = mvc.tradeActivityModel:getDailyGiftData()
    -- printInfo(self.giftBagData)
    -- printWarn(mvc.limitTimePackageModel.iapProducts)
    print("updateGiftLayer self.giftBagData.slotData=", self.giftBagData.slotData)

    if self.freeItemLayout and not tolua.isnull(self.freeItemLayout) then
        self.freeItemLayout:removeFromParent()
        self.freeItemLayout = nil
    end

    if self.giftItemLayout and not tolua.isnull(self.giftItemLayout) then
        self.giftItemLayout:removeFromParent()
        self.giftItemLayout = nil
    end

    self.itemList = {}
    self.buyBtnList = {}
    local globalIndex = 1
    if(self.specialFreeData) then 
        self:createSpecialFreeGiftBagItme(globalIndex)
        globalIndex = globalIndex + 1
    else

        if(self.getSpecial and oldSpeicialData) then 
            self:showGetAwards(oldSpeicialData)
        end 
    end

    if self.giftBagData.slotData then
        for index = 1, #self.giftBagData.slotData do
            self:createGiftBagItme(globalIndex, index)
            
            globalIndex = globalIndex + 1
            if(globalIndex > 3) then 
                break
            end
        end
    end
end

function TradeActivityDailyGiftBagView:showGetAwards(oldSpeicialData)
    if not oldSpeicialData or table.nums(oldSpeicialData) <= 0 then
        return
    end

    local targetInfo = oldSpeicialData[1]
    if not targetInfo or not targetInfo.rewardid or table.nums(targetInfo.rewardid) <= 0 then
        return
    end

    local rewardid = targetInfo.rewardid
    local rewardnum = targetInfo.rewardnum
    local awardsList = {}
    for index = 1, #rewardid do
        local awarObj = GoodsDataManager:createLocalGoodsData(rewardid[index])
        awarObj:setNum(rewardnum[index])
        if rewardnum[index] > 0 then
            table.insert(awardsList, awarObj)
        end
    end
    if #awardsList > 0 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
    end
end


function TradeActivityDailyGiftBagView:createSpecialFreeGiftBagItme(index)
    local itemPos = GIFT_POS_LIST[index]

    if self.itemList[index] and not tolua.isnull(self.itemList[index]) then
        self.itemList[index]:removeFromParent()
        self.itemList[index] = nil
    end

    local itemLayout = UI.Layout:create()
    itemLayout:init()
    itemLayout:setSize(GIFT_ITEM_WIDTH, GIFT_ITEM_HEIGHT)
    itemLayout:center(itemPos.x, itemPos.y)
    -- itemLayout:enableDebugDraw()
    self.contentLayout:addChild(itemLayout)
    self.itemList[index] = itemLayout
    self.freeItemLayout = itemLayout

    local infoBg = UI.Image:create()
    infoBg:init("ui_businessactivities_background.png")
    infoBg:centerUp(8)
    itemLayout:addChild(infoBg)

    local awards = {}
    local freeData = self.specialFreeData[1]
    if(freeData) then
        print("freeData=", freeData)
        for k, v in ipairs(freeData.rewardnum) do 
            local oneData = {}
            oneData.id = freeData.rewardid[k]
            oneData.num = freeData.rewardnum[k]

            table.insert(awards, oneData)
        end
    end

    local awardsLayout = self:createAwardsLayoutForGoodsArr(awards)
    -- local awardsLayout = self:createAwardsLayout(productInfo, self.giftBagData.slotData[index].treasureIndex)
    awardsLayout:centerUp(52)
    -- awardsLayout:enableDebugDraw()
    itemLayout:addChild(awardsLayout)

    -- local _, _, _, percentStr = self:getGiftBagPrice(productInfo)
    local giftName = UI.Text:create()
    giftName:init(LanguageManager:getInstance():getLocalString(1113967), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    giftName:centerUp(4)
    infoBg:addChild(giftName)

    -- 购买按钮
    local buyButton = UI.Button:create()
    buyButton:init('ui_businessactivities_btn_01.png', 'ui_businessactivities_btn_01.png', 'ui_businessactivities_btn_gray_01.png')
    buyButton:centerBottom(0)
    buyButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    buyButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local SceneManager = require("app.game.SceneManager")
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end
        self.getSpecial = true
        Net.NetRoleSystem:sendActivityTargetGetAwards(freeData.sudId, freeData.groupId)
        -- mvc.send(mvc.events.TradeActivity_Send_Buy_DailyGiftBag, productInfo, slotID)
    end)
    itemLayout:addChild(buyButton)
    buyButton:setText(UI.TEXT_1172013)

    self.buyBtnList[index] = buyButton
    -- self:updateBuyButton(index)
end

function TradeActivityDailyGiftBagView:createGiftBagItme(index, dataIndex)
    local slotID = self.giftBagData.slotData[dataIndex].treasureSlot
    local treasureID = self.giftBagData.slotData[dataIndex].treasureId
    local productInfo = mvc.limitTimePackageModel.iapProducts[treasureID]
    local itemPos = GIFT_POS_LIST[index]
    if self.itemList[index] and not tolua.isnull(self.itemList[index]) then
        self.itemList[index]:removeFromParent()
        self.itemList[index] = nil
    end

    if not productInfo then
        return
    end

    local itemLayout = UI.Layout:create()
    itemLayout:init()
    itemLayout:setSize(GIFT_ITEM_WIDTH, GIFT_ITEM_HEIGHT)
    itemLayout:center(itemPos.x, itemPos.y)
    -- itemLayout:enableDebugDraw()
    self.contentLayout:addChild(itemLayout)
    self.giftItemLayout = itemLayout
    self.itemList[index] = itemLayout

    local infoBg = UI.Image:create()
    infoBg:init("ui_businessactivities_background.png")
    infoBg:centerUp(8)
    itemLayout:addChild(infoBg)

    local desc = self:createGiftItemDesc(productInfo)
    desc:centerUp(186)
    itemLayout:addChild(desc)

    local awardsLayout = self:createAwardsLayout(productInfo, self.giftBagData.slotData[dataIndex].treasureIndex)
    awardsLayout:centerUp(52)
    -- awardsLayout:enableDebugDraw()
    itemLayout:addChild(awardsLayout)

    local _, _, _, percentStr = self:getGiftBagPrice(productInfo)
    local giftName = UI.Text:create()
    giftName:init(percentStr, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    giftName:centerUp(4)
    infoBg:addChild(giftName)

    -- 购买按钮
    local buyButton = UI.Button:create()
    buyButton:init('ui_businessactivities_btn_01.png', 'ui_businessactivities_btn_01.png', 'ui_businessactivities_btn_gray_01.png')
    buyButton:centerBottom(0)
    buyButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    buyButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local SceneManager = require("app.game.SceneManager")
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end
        
        mvc.send(mvc.events.TradeActivity_Send_Buy_DailyGiftBag, productInfo, slotID)
    end)
    itemLayout:addChild(buyButton)

    self.buyBtnList[index] = buyButton
    self:updateBuyButton(index, dataIndex)
end

function TradeActivityDailyGiftBagView:createGiftItemDesc(productInfo)
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(200, 52)

    local originLayout = UI.Layout:create()
    originLayout:init()
    originLayout:center(0, -12)
    originLayout:enableAutoWidth()
    originLayout:enableAutoHeight()
    layout:addChild(originLayout)

    local text = UI.Text:create()
    text:init(UIUtil:lang(1112047), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_213_157_70)
    text:setOutline(UI.FONT_COLOR_BLACK)
    text:floatLeft(0)
    originLayout:addComponent(text)

    local priceIcon = UI.Image:create()
    priceIcon:init(UIUtil:getMoneyPng())
    priceIcon:floatLeft(2)
    originLayout:addComponent(priceIcon)

    local priceText = UI.Text:create()
    priceText:init("688", UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_213_157_70)
    priceText:setOutline(UI.FONT_COLOR_BLACK)
    priceText:floatLeft(0)
    originLayout:addComponent(priceText)

    local curLayout = UI.Layout:create()
    curLayout:init()
    curLayout:center(0, 12)
    curLayout:enableAutoWidth()
    curLayout:enableAutoHeight()
    layout:addChild(curLayout)

    local text = UI.Text:create()
    text:init(UIUtil:lang(1112048), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_213_157_70)
    text:setOutline(UI.FONT_COLOR_BLACK)
    text:floatLeft(0)
    curLayout:addComponent(text)

    local curPriceIcon = UI.Image:create()
    curPriceIcon:init(UIUtil:getMoneyPng())
    curPriceIcon:floatLeft(2)
    curLayout:addComponent(curPriceIcon)

    local curPriceText = UI.Text:create()
    curPriceText:init("68", UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_192_75_75)
    curPriceText:floatLeft(0)
    curPriceText:setOutline(UI.FONT_COLOR_BLACK)
    curLayout:addComponent(curPriceText)

    -- 获取售卖价格
    local isHaveInitStr, originPrice, curPrice, _ = self:getGiftBagPrice(productInfo)
	if (isHaveInitStr) then
		curPriceIcon:hide()
        priceIcon:hide()
        curPriceText:setText(curPrice)
        priceText:setText(originPrice)
    else
        curPriceIcon:show()
        priceIcon:show()
        priceText:setText(originPrice)
        curPriceText:setText(curPrice)
    end

    originLayout:updateView()
    local size = originLayout:getContentSize()
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("pay_limitbag_line.png")
    lineUpImage:setContentSize(size.width+4, 2)
    lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    lineUpImage:setPosition(cc.p(size.width/2, size.height/2))
    lineUpImage:setName("redline")
    originLayout:addChild(lineUpImage, 1001)

    return layout
end


function TradeActivityDailyGiftBagView:getGiftBagPrice(productInfo)
    -- 获取售卖价格
    local info = productInfo
    local ext = info.extDec

    -- 检测如果有指定价格字符串就使用, 没有就是用默认的
    local SdkManager = require "app.game.SdkManager"
    local iapId
    if (info.IAPList and #info.IAPList > 0 and info.IAPList[1] and info.IAPList[1].iapId) then
        iapId = info.IAPList[1].iapId
    end

    -- 检测如果有指定价格字符串
    local isHaveInitStr = false

    local curPrice = nil
    local originPrice = nil
    local percentStr = tostring(ext[1]/100) .. "%"..UIUtil:lang(1112050)

	local priceString = SdkManager:getInstance():getPriceStringFromIapID(iapId)
	if (priceString) then
        local priceValue = SdkManager:getInstance():getPriceValueFromIapID(iapId)
        local postOffPrice = ext[3]/100
        local factor = priceValue / postOffPrice
        local preOffPrice = ext[2]/100
        local oriPriceInLocalCurrency = preOffPrice * factor
        local sign = AvalonUtil.getCurrencySignFromPriceString(priceString)

        isHaveInitStr = true
        originPrice = sign .. string.format("%.2f", oriPriceInLocalCurrency)
        curPrice = priceString
    else
        isHaveInitStr = false
        originPrice = UIUtil:getMoneyPriceStr(ext[2]/100)
		curPrice = UIUtil:getMoneyPriceStr(ext[3]/100)
    end

    return isHaveInitStr, originPrice, curPrice, percentStr
end


function TradeActivityDailyGiftBagView:createAwardsLayout(productInfo, treasureIndex)
    local awards = {}
    local haveTreasureId = false
    for _, v in ipairs(productInfo.products) do
        if v.index == treasureIndex then
            table.insert(awards, v)
            haveTreasureId = true
        end
    end
    -- 如果礼包奖励id超出礼包奖励中有的id，则id自动归位0
    if not haveTreasureId then
        for _, v in ipairs(productInfo.products) do
            if v.index == 0 then
                table.insert(awards, v)
            end
        end
    end

    return self:createAwardsLayoutForGoodsArr(awards)
end

function TradeActivityDailyGiftBagView:createAwardsLayoutForGoodsArr(awards)
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(200, 126)

    -- 每三个奖励一个layout
    local firstLayout = nil
    local secondLaout = nil

    firstLayout = UI.Layout:create()
    firstLayout:init()
    -- firstLayout:enableDebugDraw()
    firstLayout:enableAutoWidth()
    firstLayout:enableAutoHeight()
    -- firstLayout:enableDebugDraw()
    layout:addChild(firstLayout)

    local iconScale = 1
    if #awards > 2 then
        iconScale = 0.8
    end
    local oneWidth = 80 * iconScale
    local padindX = 8 * iconScale

    -- 根据奖励数量决定位置
    if #awards <= 3 then
        firstLayout:center(-2, 0)
    else
        secondLaout = UI.Layout:create()
        secondLaout:init()
        -- secondLaout:enableDebugDraw()
        -- secondLaout:enableAutoWidth()
        -- secondLaout:enableAutoHeight()
        -- secondLaout:enableDebugDraw()
        if(#awards > 6) then
            local scrollView = UI.ScrollView:create()
            scrollView:setSize(198, 124)
            scrollView:init(0, 0, 0, 0)
            scrollView:centerUp(0)
            layout:addChild(scrollView)
            scrollView:setScrollType(UI.ScrollType.VERTICAL)

            scrollView:addInnerNode(secondLaout)
        else
            layout:addChild(secondLaout)

            firstLayout:center(-2, -30)
            secondLaout:centerLeft(0, 16)

            secondLaout:enableAutoWidth()
            secondLaout:enableAutoHeight()
        end
    end

    for index = 1, #awards do
        local goodData = GoodsDataManager:createLocalGoodsData(tonumber(awards[index].id))
        if goodData then
            goodData:setNum(tonumber(awards[index].num))
            goodData:setIsNew(false)
            goodData.isHaveGet = false

            local rewardGrid = UI.GoodsGrid:create()
            rewardGrid:init(goodData)
            rewardGrid:hideNewIcon()
            rewardGrid:setScale(iconScale)
            rewardGrid:setTouchEnable(true)
            rewardGrid:setSwallowTouches(false)
            rewardGrid:setTouchClipNode(layout)
            rewardGrid:showInfoArea(true, false)

            local int , yu = math.modf((index -1)/3)
            if(#awards > 6) then
                rewardGrid:leftUp((index -(int* 3) - 1) * oneWidth, int * oneWidth)
                secondLaout:addChild(rewardGrid)
            else
                if index == int * 3 + 1 then
                    rewardGrid:floatLeft(0)
                elseif #awards == 2 then
                    rewardGrid:floatLeft(10)
                else
                    rewardGrid:floatLeft(-4)
                end

                if index <= 3 then
                    firstLayout:addComponent(rewardGrid)
                else
                    secondLaout:addComponent(rewardGrid)
                end
            end
        end
    end

    if(#awards > 6) then
        local int , yu = math.modf((#awards-1)/3)
        if #awards > int * 3 then
            int = int + 1
        end
        -- print("198, int* oneWidth + (int-1) * padindX=", 198, int* oneWidth + (int-1) * padindX)
        secondLaout:setSize(198, int* oneWidth + (int-1) * padindX)
        -- secondLaout:setSize(100, 300)
    end

    return layout
end

function TradeActivityDailyGiftBagView:updateBuyButton(index, dataIndex)
    local buyButton = self.buyBtnList[index]

    if not buyButton or tolua.isnull(buyButton) then
        return
    end

    local priceLayout = buyButton._text:getChildByName("priceLayout")
    if priceLayout and not tolua.isnull(priceLayout) then
        priceLayout:removeFromParent(false)
    end

    -- 购买时间为0则为未购买
    if self.giftBagData.slotData[dataIndex].purchaseTime ~= 0 then
        buyButton:disable()
        buyButton:setText(UI.TEXT_1324509)
    else
        local productInfo = mvc.limitTimePackageModel.iapProducts[self.giftBagData.slotData[dataIndex].treasureId]
        local isHaveInitStr, _, curPrice, _ = self:getGiftBagPrice(productInfo)

        buyButton:enable()
        buyButton:setText("")
        -- 价钱排版
        priceLayout = UI.Layout:create()
        priceLayout:init()
        priceLayout:center()
        priceLayout:enableAutoHeight()
        priceLayout:enableAutoWidth()
        priceLayout:setName("priceLayout")
        buyButton._text:addChild(priceLayout, 100)

        -- 货币图标
        local currencyIcon = UI.Image:create()
        currencyIcon:init(UIUtil:getMoneyPng())
        currencyIcon:floatLeft(0)
        priceLayout:addComponent(currencyIcon)
        
        -- 价钱文字
        local priceLabel = UI.Text:create()
        priceLabel:init(curPrice, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        priceLabel:floatLeft(8)
        priceLayout:addComponent(priceLabel)

        if (isHaveInitStr) then
            currencyIcon:hide()
        else
            currencyIcon:show()
        end
    end
end

return TradeActivityDailyGiftBagView












