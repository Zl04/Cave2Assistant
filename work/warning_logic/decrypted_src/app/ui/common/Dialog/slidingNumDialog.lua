------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/07
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local slidingNumDialog = class("slidingNumDialog", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_general_shop.plist",
    "ui_shop_article_2.plist",
}

UI.slidingNumDialog = slidingNumDialog

local DIALOG_TYPE = {
    Item = 1,
    Text = 2
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 380
local COM_HEIGHT = 320

function slidingNumDialog:ctor(dialogType)
    slidingNumDialog.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.dialogType = dialogType
end

function slidingNumDialog:initItem(goodData, minNum, maxNum, okCallback, cancelCallback)

    self.goodData = goodData
    self.minNum = minNum
    self.maxNum = maxNum
    self.okCallback = okCallback
    self.cancelCallback = cancelCallback

    slidingNumDialog.super.init(self)
end

function slidingNumDialog:initText(textStr, slidingNum, minNum, maxNum, okCallback, cancelCallback)

    self.textStr = textStr
    self.slidingNum = slidingNum
    self.minNum = minNum
    self.maxNum = maxNum
    self.okCallback = okCallback
    self.cancelCallback = cancelCallback

    slidingNumDialog.super.init(self)
end

function slidingNumDialog:dtor()
    slidingNumDialog.super.dtor(self)
    self:unbindModel()
end

function slidingNumDialog:onInitView()
    self.curCardsSelectNum = self.minNum
    self.lastCardsSelectNum = self.minNum

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout, 1)
    self.contentLayout = contentLayout

    local maskBG  = UI.Layout:create()
    maskBG:init()
    maskBG:center()
    maskBG:setTouchEnable(true)
    maskBG:setSize(winSize.width * 2, winSize.height * 2)
    self:addChild(maskBG, 0)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box3.png")
    bgImage:setCapInsets(CCRectMake(430/2, 288/2, 1, 1))
    bgImage:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT/2))
    self.contentLayout:addChild(bgImage)

    if(self.dialogType == DIALOG_TYPE.Item) then
        self:updateItemShow()
    elseif(self.dialogType == DIALOG_TYPE.Text) then
        self:updateTextShow()
    end

    local numMin = UI.Text:create()
    numMin:init(tostring(self.curCardsSelectNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numMin:leftUp(28, 164)
    self.contentLayout:addChild(numMin)
    self.numMinTxt = numMin

    local numPrgBar = UI.ProgressTimer:create()
    numPrgBar:init("ui_shop_article_1.png", nil, "ui_shop_article_2.png")
    numPrgBar:centerUp(168)
    numPrgBar:setPercent(0)
    self.contentLayout:addChild(numPrgBar)
    self.numPrgBar = numPrgBar

    local maxX = numPrgBar:getContentSize().width

    local numPopPlus  = UI.Image:create();
    numPopPlus:init("ui_shop_article_3.png");
    local offsetX = numPopPlus:getContentSize().width/2
    numPopPlus:centerLeft(-offsetX);
    numPopPlus:setTouchEnable(true)
    numPopPlus:setSwallowTouches(true)
    self.numPopPlus = numPopPlus
    self.originOffsetX = offsetX
    numPopPlus:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, function(self, com, touchpos)
        local deltaX = touchpos.x-com:Local2Global().x

        if com:getPositionX()+deltaX <= -offsetX then
            com:setPosition(-offsetX, com:getPositionY())
        end
        if com:getPositionX()+deltaX >= maxX-offsetX then
            com:setPosition(maxX-offsetX, com:getPositionY())
        end
        if com:getPositionX()+deltaX > -offsetX and com:getPositionX()+deltaX < maxX-offsetX then
            com:setPosition(com:getPositionX()+deltaX, com:getPositionY())
        end

        local curX = com:getPositionX()+offsetX
        if curX == 0 then
            self.numPopTxt:setText("1")
            self.curCardsSelectNum = self.minNum
        else
            local realNum = math.floor((self:getPillShowNum() - self.minNum) * curX/maxX) + self.minNum
            self.numPopTxt:setText(tostring(realNum))
            self.curCardsSelectNum = realNum
        end

        self.numPrgBar:setPercent(curX/maxX)

        if self.curCardsSelectNum ~= self.lastCardsSelectNum then
            self.lastCardsSelectNum = self.curCardsSelectNum
        end
    end)
    numPrgBar:addChild(numPopPlus, 10)

    local numBG  = UI.Image:create()
    numBG:init("ui_shop_article_4.png")
    numBG:leftUp(-15, -60)
    numPopPlus:addChild(numBG)

    local numTxt = UI.Text:create()
    numTxt:init(tostring(self.curCardsSelectNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numTxt:centerUp(2)
    numBG:addChild(numTxt)
    self.numPopTxt = numTxt

    local numMax = UI.Text:create()
    numMax:init(tostring(self:getPillShowNum()), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numMax:leftUp(340, 164)
    self.contentLayout:addChild(numMax)
    self.numMaxTxt = numMax

    -- local maxNumPrompt = UI.Text:create()
    -- maxNumPrompt:init(string.format(UI.TEXT_1212613, self.maxNum), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_181_32_32)
    -- maxNumPrompt:centerBottom(90)
    -- self.contentLayout:addChild(maxNumPrompt)

    -- 取消按钮
    local no = UI.Button:create()
    no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    no:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if self.cancelCallback then
            self.cancelCallback()
        end
        self:removeFromParent()
    end)
    no:leftBottom(51, 32)
    self.contentLayout:addChild(no)

    -- 确认购买按钮
    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if self.okCallback then
            self.okCallback(self.curCardsSelectNum)
        end
        self:removeFromParent()
    end)
    yes:rightBottom(51, 32)
    self.contentLayout:addChild(yes)
end

function slidingNumDialog:updateItemShow()

    local itemData = self.goodData

    local itemLayout = UI.Layout:create()
    itemLayout:init()
    itemLayout:centerUp(70)
    itemLayout:setName("itemLayout")
    self.contentLayout:addChild(itemLayout)

    local ItemBg = UI.Image:create()
    ItemBg:init("ui_setup_banner_box4.png")
    ItemBg:center()
    itemLayout:addChild(ItemBg)

    local itemIcon = UI.Image:create()
    itemIcon:init(self.goodData:getSmallIconName())
    itemIcon:centerLeft(0, 0)
    itemLayout:addChild(itemIcon)

    local itemNum = UI.Text:create()
    itemNum:init(tostring(itemData:getNum()), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    itemNum:centerLeft(0, 0)
    itemLayout:addChild(itemNum)

    local totalLength = itemIcon:getContentSize().width + itemNum:getContentSize().width + 6
    itemIcon:centerLeft(- totalLength / 2, 0)
    itemNum:centerLeft(- totalLength / 2 + itemIcon:getContentSize().width + 6, 0)
end

function slidingNumDialog:getPillShowNum()
    if(self.dialogType == DIALOG_TYPE.Item) then
        if tonumber(self.goodData:getNum()) > self.maxNum then
            return self.maxNum
        else
            return tonumber(self.goodData:getNum())
        end
    elseif(self.dialogType == DIALOG_TYPE.Text) then
        if tonumber(self.slidingNum) > self.maxNum then
            return self.maxNum
        else
            return tonumber(self.slidingNum)
        end
    end

    return 0
end

function slidingNumDialog:updateTextShow()
    local itemLayout = UI.Layout:create()
    itemLayout:init()
    itemLayout:centerUp(70)
    itemLayout:setName("itemLayout")
    self.contentLayout:addChild(itemLayout)

    local ItemBg = UI.Image:create()
    ItemBg:init("ui_setup_banner_box4.png")
    ItemBg:center()
    itemLayout:addChild(ItemBg)

    local textPre = UI.Text:create()
    textPre:init(tostring(self.textStr), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    textPre:centerLeft(0, 0)
    itemLayout:addChild(textPre)

    local textNum = UI.Text:create()
    textNum:init(tostring(self.slidingNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_220_182_80)
    textNum:centerLeft(0, 0)
    itemLayout:addChild(textNum)

    local totalLength = textPre:getContentSize().width + textNum:getContentSize().width + 6
    textPre:centerLeft(- totalLength / 2, 0)
    textNum:centerLeft(- totalLength / 2 + textPre:getContentSize().width + 3, 0)
end

function slidingNumDialog:bindModel()

end

function slidingNumDialog:unbindModel()

end

function slidingNumDialog:showTextTitle(textStr, slidingNum, minNum, maxNum, okCallback, cancelCallback)
    local dialog = slidingNumDialog:create(DIALOG_TYPE.Text)
    dialog:initText(textStr, slidingNum, minNum, maxNum, okCallback, cancelCallback)
    dialog:center()

    return dialog
end

function slidingNumDialog:showItemTile(goodId, minNum, maxNum, okCallback, cancelCallback)
    local dialog = slidingNumDialog:create(DIALOG_TYPE.Item)
    dialog:initItem(goodId, minNum, maxNum, okCallback, cancelCallback)
    dialog:center()

    return dialog
end
