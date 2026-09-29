------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/05/07
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local LimitTimePackageView = class("LimitTimePackageView", UI.HWBtnComponent)
local LayoutUtil = require "app.ui.UILayoutUtils"
local SdkManager = require "app.game.SdkManager"
local SdkBox = require("utils.sdkbox.SdkBox")

local winSize = cc.Director:getInstance():getWinSize()
-- 资源
local COM_RES_LIST = {
    "ui_general_shopping.plist",
    "ui_town_pay.plist"
}

local COM_WIDTH = 550
local COM_HEIGHT = 390
local layoutUU
function LimitTimePackageView:ctor()
    LimitTimePackageView.super.ctor(self, UI.Type.TIPS, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:bindModel()
    self:center()
    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_LimitGift,0,0,0,0)
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_SpecialGift, 3, nil, nil)
    layoutUU = UIUtil:createAutoUILayout("LimitTimePackageView","app.modules.limittimepackage.LimitTimePackagePosConfig", false)
end

function LimitTimePackageView:dtor()
    LimitTimePackageView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.limittimepackage.LimitTimePackageView")
end

function LimitTimePackageView:getMoneyPng()
    return UIUtil:getMoneyPng()
end

function LimitTimePackageView:onInitView()
    -- 再请求一次商品数据
    local myChannel = SdkBox:getInstance():getVersionChannel()
    Net.NetPurchaseSystem:reqProducts(nil,nil,myChannel)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    
    -- local spr = cc.Sprite:create("xxxx.png")
    -- spr:setOpacity(150)
    -- spr:setPosition(cc.p(COM_WIDTH / 2, COM_HEIGHT / 2))
    -- self:addChild(spr)

    local bg = UI.Image:create()
    bg:init('pay_limitbag_bg.png')
    addChildAuto(layoutUU, self, bg, 'pay_limitbag_bg')

    local text = UI.Text:create()
    text:init(UIUtil:lang(1112049), UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_221_167_76)
    text:setOutline(UI.FONT_COLOR_BLACK)
    text:setRotation(-35)
    addChildAuto(layoutUU, self, text, "text1", "center")

    local width = 205
    local curWidth = text:getContentSize().width
    if width < curWidth then
        text:setScale(width/curWidth)
    end

    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()
    layout:setRotation(-16)
    addChildAuto(layoutUU, self, layout, "layout", "center")

    self.percentLayout = layout
    local text = UI.Text:create()
    text:init("", UI.FONT_BOLD, UI.FONT_SIZE_36PX, UI.FONT_COLOR_255_66_66)
    text:floatLeft(0)
    text:setOutline(UI.FONT_COLOR_BLACK)
    layout:addComponent(text)
    self.percentText = text

    local text = UI.Text:create()
    text:init(UIUtil:lang(1112050), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_66_66)
    text:setOutline(UI.FONT_COLOR_BLACK)
    text:floatLeft(3)
    layout:addComponent(text)
    -- 关闭按钮
    local closeBtn = UI.Button:create()
    closeBtn:init("ui_btn_button_cancel_0.png", "ui_btn_button_cancel_1.png", "ui_btn_button_cancel_2.png")
    closeBtn:closeClickScale()
    addChildAuto(layoutUU, self, closeBtn, "closeBtn")
    closeBtn:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function(self)
            mvc.send("Close_Panel", "LimitTimePackage")
        end
    )

    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()
    layout:setRotation(18)
    addChildAuto(layoutUU, self, layout, "layout2", "center")
    self.leftBottomTextContent = layout
    local text = UI.Text:create()
    text:init(UIUtil:lang(1112047), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_213_157_70)
    text:setOutline(UI.FONT_COLOR_BLACK)
    text:floatLeft(0)
    layout:addComponent(text)

    local bg = UI.Image:create()
    bg:init(self:getMoneyPng())
    bg:floatLeft(2)
    layout:addComponent(bg)
    self.priceIcon = bg

    local text = UI.Text:create()
    text:init("688", UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_213_157_70)
    text:setOutline(UI.FONT_COLOR_BLACK)
    text:floatLeft(0)
    layout:addComponent(text)
    self.priceText = text

    local text = UI.Text:create()
    text:init(UIUtil:lang(1112048), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_213_157_70)
    text:setOutline(UI.FONT_COLOR_BLACK)
    text:floatLeft(9)
    layout:addComponent(text)

    local bg = UI.Image:create()
    bg:init(self:getMoneyPng())
    bg:floatLeft(2)
    layout:addComponent(bg)
    self.curPriceIcon = bg


    local text = UI.Text:create()
    text:init("68", UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_192_75_75)
    text:floatLeft(0)
    text:setOutline(UI.FONT_COLOR_BLACK)
    layout:addComponent(text)
    self.curPriceText = text

    local text = UI.Text:create()
    text:init(UIUtil:lang(1112055), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_213_157_70)
    text:floatLeft(0)
    text:setOutline(UI.FONT_COLOR_BLACK)
    layout:addComponent(text)

    -- 立即领取
    local getBtn = UI.Button:create()
    getBtn:init("ui_btn_yellow14_0.png", "ui_btn_yellow14_1.png", "ui_btn_yellow14_2.png")
    -- getBtn:setText(UIUtil:lang(1112056))
    -- getBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- getBtn:closeClickScale()
    getBtn:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function(self)
            mvc.send(mvc.events.LimitTime_GET_DO)
            mvc.send("Close_Panel", "LimitTimePackage")
        end
    )
    addChildAuto(layoutUU, self, getBtn, "getBtn", "leftBottom")
    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()
    layout:center()
    getBtn:addChild(layout, 100)

    local bg = UI.Image:create()
    bg:init(self:getMoneyPng())
    bg:floatLeft(0)
    layout:addComponent(bg)
    self.getBtnPriceIcon = bg

    local text = UI.Text:create()
    text:init("99", UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    text:floatLeft(2)
    layout:addComponent(text)

    self.getBtnText = text
    
    self:updateGoodsView()
    self:createCdContent()
end


function LimitTimePackageView:createCdContent()
    local endTime = mvc.limitTimePackageModel:getRefreshDay() * 24 * 3600
    local nowTime = GameManager:getNormalServerTime()
    local text = UI.Text:create()
    text:init("", UI.FONT_STANDARD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_78_30_81)
    text:setRotation(-35)
    addChildAuto(layoutUU, self, text, "text2", "center")
    self.cdText = text

    self:scheduleUpdateTime()
end

function LimitTimePackageView:scheduleUpdateTime()
    if tolua.isnull(self) or tolua.isnull(self.cdText) then
        return
    end

    local endTime = mvc.limitTimePackageModel:getRefreshDay() * 24 * 3600
    local nowTime = GameManager:getNormalServerTime()
    local time = endTime - nowTime

    if time > 0 then
        Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.scheduleUpdateTime, 1)
        local showText = AvalonUtil:_getFullFormatTime(time, true, true, false) 
        self.cdText:setText(showText)
    else
        self.cdText:setText("")
    end
end

function LimitTimePackageView:create3ItemView()
    if self.itemContent then
        self.itemContent:removeFromParent()
    end
    self.itemContent = UI.Component:create()
    self.itemContent:init()
    self.itemContent:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(self.itemContent)

    self.goodsGrids = {}
    self.goodsNums = {}
    self.icons = {}

    for i = 1, 3 do
        local icon = UI.Image:create()
        icon:init("pay_limitbag_box_1.png")
        local tag = i
        if i == 1 then
            tag = 2 
        elseif i == 2 then
            tag = 1
        end
        
        addChildAuto(layoutUU, self.itemContent, icon, "icon" .. tag, "leftBottom")
        table.insert(self.icons, icon)
        icon:hide()
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:center()
        -- local goodsData = GoodsDataManager:createLocalGoodsData(21081132);
        -- goodsData:setIsNew(false)
        goodsGrid:init()
        goodsGrid:hide()
        goodsGrid:showInfoArea(true, false)
        goodsGrid:hideBG()
        goodsGrid:hideRare()
        goodsGrid:hideChoiceStatus()
        goodsGrid:hideFlagIcon()
        goodsGrid:hideCountLabel()
        goodsGrid:setTouchClipNode(innerLayout)
        icon:addChild(goodsGrid)
        table.insert(self.goodsGrids, goodsGrid)
        local text = UI.Text:create()
        text:init(i .. "", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_255_255)
        text:rightBottom(9, 2)
        text:hide()
        icon:addChild(text)
        table.insert(self.goodsNums, text)
    end
    local infos = mvc.limitTimePackageModel:getShowInfo() or {}
    local len = #infos > 3 and 3 or #infos
    for i = 1, len do
        local info = infos[i]
        local goodsData = GoodsDataManager:createLocalGoodsData(info.id)
        goodsData:setIsNew(false)
        if not goodsData then
            print(infos)
            print(info, i)
            return
        end
        self.goodsGrids[i]:setData(goodsData)
        self.goodsNums[i]:setText(AvalonUtil:getTargetFormatedNum(info.num))
        self.goodsGrids[i]:show()
        self.goodsGrids[i]:updateView()
        self.goodsNums[i]:show()
        self.icons[i]:show()
    end
end


function LimitTimePackageView:create6ItemView()
    if self.itemContent then
        self.itemContent:removeFromParent()
    end
    self.itemContent = UI.Component:create()
    self.itemContent:init()
    self.itemContent:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(self.itemContent)

    self.goodsGrids = {}
    self.goodsNums = {}
    self.icons = {}

    for i = 1, 6 do
        local icon = UI.Image:create()
        icon:init("pay_limitbag_box_1.png")
        addChildAuto(layoutUU, self.itemContent, icon, "icon6" .. i, "leftBottom")
        icon:setScale(0.8)
        table.insert(self.icons, icon)
        icon:hide()
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:center()
        -- local goodsData = GoodsDataManager:createLocalGoodsData(21081132);
        -- goodsData:setIsNew(false)
        -- goodsGrid:setData(goodsData)
        goodsGrid:init()
        goodsGrid:hide()
        goodsGrid:showInfoArea(true, false)
        goodsGrid:hideBG()
        goodsGrid:hideRare()
        goodsGrid:hideChoiceStatus()
        goodsGrid:hideFlagIcon()
        goodsGrid:hideCountLabel()
        goodsGrid:setTouchClipNode(innerLayout)
        icon:addChild(goodsGrid)
        table.insert(self.goodsGrids, goodsGrid)
        local text = UI.Text:create()
        text:init(i .. "", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_255_255)
        text:rightBottom(9, 2)
        text:hide()
        icon:addChild(text)
        table.insert(self.goodsNums, text)
    end
    local infos = mvc.limitTimePackageModel:getShowInfo() or {}
    local len = #infos > 6 and 6 or #infos
    for i = 1, len do
        local info = infos[i]
        local goodsData = GoodsDataManager:createLocalGoodsData(info.id)
        goodsData:setIsNew(false)
        self.goodsGrids[i]:setData(goodsData)
        self.goodsNums[i]:setText(AvalonUtil:getTargetFormatedNum(info.num))
        self.goodsGrids[i]:show()
        self.goodsGrids[i]:updateView()
        self.goodsNums[i]:show()
        self.icons[i]:show()
    end
end


function LimitTimePackageView:create4ItemView()
    if self.itemContent then
        self.itemContent:removeFromParent()
    end
    self.itemContent = UI.Component:create()
    self.itemContent:init()
    self.itemContent:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(self.itemContent)

    self.goodsGrids = {}
    self.goodsNums = {}
    self.icons = {}

    for i = 1, 4 do
        local icon = UI.Image:create()
        icon:init("pay_limitbag_box_1.png")
        addChildAuto(layoutUU, self.itemContent, icon, "icon4" .. i, "leftBottom")
        icon:setScale(0.9)
        table.insert(self.icons, icon)
        icon:hide()
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:center()
        -- local goodsData = GoodsDataManager:createLocalGoodsData(21081132);
        -- goodsData:setIsNew(false)
        -- goodsGrid:setData(goodsData)
        goodsGrid:init()
        goodsGrid:hide()
        goodsGrid:showInfoArea(true, false)
        goodsGrid:hideBG()
        goodsGrid:hideRare()
        goodsGrid:hideChoiceStatus()
        goodsGrid:hideFlagIcon()
        goodsGrid:hideCountLabel()
        goodsGrid:setTouchClipNode(innerLayout)
        icon:addChild(goodsGrid)
        table.insert(self.goodsGrids, goodsGrid)
        local text = UI.Text:create()
        text:init(i .. "", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_255_255)
        text:rightBottom(9, 2)
        text:hide()
        icon:addChild(text)
        table.insert(self.goodsNums, text)
    end
    local infos = mvc.limitTimePackageModel:getShowInfo() or {}
    local len = #infos > 4 and 4 or #infos
    for i = 1, len do
        local info = infos[i]
        local goodsData = GoodsDataManager:createLocalGoodsData(info.id)
        goodsData:setIsNew(false)
        self.goodsGrids[i]:setData(goodsData)
        self.goodsNums[i]:setText(AvalonUtil:getTargetFormatedNum(info.num))
        self.goodsGrids[i]:show()
        self.goodsGrids[i]:updateView()
        self.goodsNums[i]:show()
        self.icons[i]:show()
    end
end



function LimitTimePackageView:updateGoodsView()
    local infos = mvc.limitTimePackageModel:getShowInfo() or {}
    local len = #infos > 4 and 4 or #infos
    
    if #infos < 4  then
        self:create3ItemView()
    elseif #infos < 5  then
        self:create4ItemView()
    else
        self:create6ItemView()
    end
    
    local info = mvc.limitTimePackageModel:getCurProductionInfo()
    local ext = info.extDec
    -- self.percentText:setText(string.format("%.2f", ext[1]/100))
    self.percentText:setText( tostring(ext[1]/100) .. "%")

    -- 检测如果有指定价格字符串就使用, 没有就是用默认的
    local SdkManager = require "app.game.SdkManager"
    local iapId
    if (info.IAPList and #info.IAPList > 0 and info.IAPList[1] and info.IAPList[1].iapId) then
        iapId = info.IAPList[1].iapId
    end
	local priceString = SdkManager:getInstance():getPriceStringFromIapID(iapId)
	if (priceString) then
		self.curPriceIcon:hide()
        self.priceIcon:hide()
        self.curPriceText:setText(priceString)
        
        local priceValue = SdkManager:getInstance():getPriceValueFromIapID(iapId)
        local postOffPrice = ext[3]/100
        local factor = priceValue / postOffPrice
        local preOffPrice = ext[2]/100
        local oriPriceInLocalCurrency = preOffPrice * factor
        local sign = AvalonUtil.getCurrencySignFromPriceString(priceString)
        self.priceText:setText(sign .. string.format("%.2f", oriPriceInLocalCurrency))
    else
        self.curPriceIcon:show()
        self.priceIcon:show()

		local price = UIUtil:getMoneyPriceStr(ext[2]/100)
        self.priceText:setText(price)
        price = UIUtil:getMoneyPriceStr(ext[3]/100)
        self.curPriceText:setText(price)
    end
    
    

    self.priceText:removeChildByName("redline", true)
    local size = self.priceText:getContentSize()
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("pay_limitbag_line.png")
    lineUpImage:setContentSize(size.width, 2)
    lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    lineUpImage:setPosition(cc.p(size.width/2, size.height/2))
    lineUpImage:setName("redline")
    self.priceText:addChild(lineUpImage, 1001)
    local width = 335
    self.leftBottomTextContent:updateView()
    local curWidth = self.leftBottomTextContent:getContentSize().width
    if width < curWidth then
        self.leftBottomTextContent:setScale(width/curWidth)
    end
    if (priceString) then
        self.getBtnPriceIcon:hide()
        self.getBtnText:setText(priceString)
    else
        self.getBtnPriceIcon:show()
        price= UIUtil:getMoneyPriceStr(info.price/100)
        self.getBtnText:setText(price)
    end

    local width = 160
    self.percentLayout:updateView()
    local curWidth = self.percentLayout:getContentSize().width
    print(curWidth, width/curWidth)
    if width < curWidth then
        self.percentLayout:setScale(width/curWidth)
    end

end

function LimitTimePackageView:bindModel()
    mvc.limitTimePackageModel:bind("iapDatas", self, self.updateGoodsView)
end

function LimitTimePackageView:unbindModel()
    mvc.limitTimePackageModel:unbind("iapDatas", self, self.updateGoodsView)
end

return LimitTimePackageView
