-- ExtraGiftLayer.lua
-- Author:lzm
-- 2019年4月18日
-- Using:超值礼包

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"
local SceneManager = require("app.game.SceneManager")
local SdkManager = require "app.game.SdkManager"
local SdkBox = require("utils.sdkbox.SdkBox")
local scheduler = cc.Director:getInstance():getScheduler()

UI = UI or {}

local ExtraGiftLayer = class("ExtraGiftLayer", UI.DownShowWin)
UI.ExtraGiftLayer = ExtraGiftLayer

local winSize = cc.Director:getInstance():getWinSize()
local VIEW_WIDTH = 700;
local VIEW_HEIGHT = 400;


local ZOrder = 1

local progressImg = {
    [1] = {"pay_recharge_level_1_2.png", "pay_recharge_level_1_1.png"},
    [2] = {"pay_recharge_level_2_2.png", "pay_recharge_level_2_1.png"},
    [3] = {"pay_recharge_level_3_2.png", "pay_recharge_level_3_1.png"},
    [4] = {"pay_recharge_level_4_2.png", "pay_recharge_level_4_1.png"},
    [5] = {"pay_recharge_level_5_2.png", "pay_recharge_level_5_1.png"},
    [6] = {"pay_recharge_level_6_2.png", "pay_recharge_level_6_1.png"},
}

local progressBarW = {10, 40, 80, 120, 160, 200}
local progressPos = {0, 35, 70, 105, 140, 175}
local PRG_IDX = 3

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_pay.plist",
    "ui_general_shopping.plist",
}

--构造函数(必备)
function ExtraGiftLayer:ctor()
    ExtraGiftLayer.super.ctor(self, UIType.ADV_GIFT, COM_RES_LIST, VIEW_WIDTH, VIEW_HEIGHT)
    self:registerListener()
    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ExtraGift,0,0,0,0)
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_SpecialGift, 1, nil, nil)
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self, self.scheduleUpdateTime), 1, false)

    self.lastTouch1 = nil
    self.lastTouch2 = nil
    self.blockTouch = false

    self:initGiftData()

    self:init()
    self:open()
end

--虚构函数,destroy时调用(必备)
function ExtraGiftLayer:dtor()
    ExtraGiftLayer.super.dtor(self)
    self:unRegisterListener();

    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

function ExtraGiftLayer:scheduleUpdateTime()
    if not self.giftData then
        return
    end

    local continueTime = self.giftData.existTime
    local masterData = RoleDataManager:getMaster()
    local createTime = masterData.createTime
    local nowTime = GameManager:getNormalServerTime()
    local remainTime = createTime + continueTime - nowTime
    if remainTime <= 0 then
        self:closeWin()
    end
end

-- 初始化(必备)
function ExtraGiftLayer:init(npcID)
    ExtraGiftLayer.super.init(self)

    self:setInterceptTouches(true)
    self:setTouchEnable(true)
end

function ExtraGiftLayer:initGiftData()
    self.giftData = nil
    local giftData = SdkManager:getInstance():getIapDatas()
    for k, v in pairs(giftData) do
        if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_EXTRA_GIFT then
            self.giftData = v
            break
        end
    end
end

-- 模版函数：初始化组建的视图(必备)
function ExtraGiftLayer:onInitView()
    -- 再请求一次商品数据
    local myChannel = SdkBox:getInstance():getVersionChannel()
    Net.NetPurchaseSystem:reqProducts(nil,nil,myChannel)

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init();
    contentLayout:setSize(VIEW_WIDTH, VIEW_HEIGHT);
    contentLayout:center();
    self:addChild(contentLayout);
    self.contentLayout = contentLayout;

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    contentLayout:addChild(mask, ZOrder)
    ZOrder = ZOrder + 1;

    local bgSpine = UI.Animation:create()
    bgSpine:init("effect_ui_town_extracharge.json", "effect_ui_town_extracharge.atlas", 1);
    bgSpine:center()
    self.contentLayout:addChild(bgSpine, ZOrder)
    self.bgSpine = bgSpine
    ZOrder = ZOrder + 1

    performWithDelay(self, function()
        bgSpine:setAnimation("begin", false)
        bgSpine:addAnimation("idle", true)
    end, 0.2)

    self:initPanel()

    performWithDelay(self, function()
        self:initBtns()
    end, 0.8)
end

function ExtraGiftLayer:initBtns()
    -- 关闭按钮
    local closeBtn = UI.Button:create()
    closeBtn:init("ui_btn_button_cancel_0.png","ui_btn_button_cancel_1.png","ui_btn_button_cancel_2.png")
    closeBtn:rightUp(90, 60)
    closeBtn:closeClickScale()
    self.contentLayout:addChild(closeBtn, ZOrder)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:closeWin()
    end)
    ZOrder = ZOrder + 1
    closeBtn:runAction(cc.Sequence:create(cc.ScaleTo:create(0, 0.01), cc.ScaleTo:create(0.1, 1)))

    -- 立即购买
    local getBtn = UI.Button:create();
    getBtn:init("ui_btn_yellow14_0.png","ui_btn_yellow14_1.png","ui_btn_yellow14_2.png")
    getBtn:rightBottom(90, 45)
    getBtn:setText(UI.TEXT_1212430)
    getBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    getBtn:closeClickScale()
    self.contentLayout:addChild(getBtn, ZOrder)
    getBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        if self.blockTouch then
            return
        end

        self.blockTouch = true

        SdkManager:getInstance():getOrder(self.giftData,1)
    end)
    ZOrder = ZOrder + 1
    getBtn:runAction(cc.Sequence:create(cc.ScaleTo:create(0, 0.01), cc.ScaleTo:create(0.1, 1)))
end

function ExtraGiftLayer:initPanel()
    -- 充值XXX
    local layout1 = UI.Layout:create();
    layout1:init();
    layout1:setSize(200, 40)
    layout1:leftUp(-60, -20)
    self.bgSpine:addComponent("zi01", layout1)

    local text1 = UI.Text:create()
    text1:init(UI.TEXT_1212431, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_192_192_192)
    text1:centerLeft(0)
    layout1:addChild(text1)

    local w,h = text1:getSize()

    local SdkManager = require "app.game.SdkManager"
    local iapId
    if (self.giftData.IAPList and #self.giftData.IAPList > 0 and self.giftData.IAPList[1] and self.giftData.IAPList[1].iapId) then
        iapId = self.giftData.IAPList[1].iapId
    end
	local priceString = SdkManager:getInstance():getPriceStringFromIapID(iapId)
	if (priceString) then
        local text2 = UI.Text:create()
        text2:init(priceString, UI.SYS_FONT, UI.FONT_SIZE_24PX, UI.FONT_COLOR_192_192_192)
        text2:centerLeft(w+5)
        text2:floatLeft(0)
        layout1:addChild(text2)
    else
        local currencyIcon = UI.Image:create()
        currencyIcon:init(UIUtil:getMoneyPng())
        currencyIcon:centerLeft(w)
        layout1:addChild(currencyIcon)
    
        local price = self.giftData.price/100 or 0
        price = UIUtil:getMoneyPriceStr(price)
        local text2 = UI.Text:create()
        text2:init(tostring(price), UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_192_192_192)
        text2:centerLeft(w+15)
        text2:floatLeft(0)
        layout1:addChild(text2)
	end

    -- 即可获得
    local layout2 = UI.Layout:create();
    layout2:init();
    layout2:setSize(200, 80)
    layout2:leftUp(-160, -15)
    self.bgSpine:addComponent("zi02", layout2)

    local text3 = UI.Text:create()
    text3:init(UI.TEXT_1212432, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_81_49_89)
    text3:setWidth(200);
    text3:rightUp(0, 0)
    text3:floatRight(0)
    text3:setTextRight()
    text3:autoAdapt()
    layout2:addChild(text3)

    -- 超值礼包
    local layout3 = UI.Layout:create();
    layout3:init();
    layout3:setSize(200, 40)
    layout3:leftUp(-30, -20)
    self.bgSpine:addComponent("zi04", layout3)

    local text4 = UI.Text:create()
    text4:init(UI.TEXT_1212429, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_192_192_192)
    text4:centerLeft(0)
    text4:floatLeft(0)
    layout3:addChild(text4)

    -- 暗金装备 祝你快人一步
    local layout4 = UI.Layout:create();
    layout4:init();
    layout4:setSize(200, 30)
    layout4:leftUp(-100, -14)
    self.bgSpine:addComponent("zi03", layout4)

    local text5 = UI.Text:create()
    text5:init(UI.TEXT_1212433, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_192_192_192)
    text5:centerLeft(0)
    text5:floatRight(0)
    layout4:addChild(text5)

    local text6 = UI.Text:create()
    text6:init(UI.TEXT_1212434, UI.FONT_BOLD, UI.FONT_SIZE_13PX, UI.FONT_COLOR_192_192_192)
    local w, h = text5:getSize()
    text6:centerLeft(w+5)
    text6:floatRight(0)
    layout4:addChild(text6)

    local kuangIndex = 1
    local allRewards = self.giftData.products
    -- up rewards
    local offset1 = {0, 50, 100, 150}
    for k, v in ipairs(offset1) do
        local reward = allRewards[kuangIndex]
        if not reward then
            break
        end

        local innerLayout = UI.Layout:create()
        innerLayout:init()
        innerLayout:setSize(42, 42)
        innerLayout:leftUp(-21, -21)

        local icon = UI.Image:create()
        icon:init("ui_pay_box_01_bg.png")
        icon:center()
        innerLayout:addChild(icon)

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:setScale(0.6)
        goodsGrid:center()
        local goodsData = GoodsDataManager:createLocalGoodsData(reward.id)
        goodsData:setIsNew(false)
        goodsGrid:init(goodsData)
        goodsGrid:showInfoArea(true, false)
        goodsGrid:hideBG()
        goodsGrid:hideRare()
        goodsGrid:hideChoiceStatus()
        goodsGrid:hideFlagIcon()
        goodsGrid:hideCountLabel()
        goodsGrid:setTouchClipNode(innerLayout)
        innerLayout:addChild(goodsGrid)

        local touch = UI.CheckBox:create()
        touch.Index = k
        touch:init("ui_pay_box_01_2.png", "ui_pay_box_01_1.png", "ui_pay_box_01_1.png", "ui_pay_box_01_1.png")
        touch:center()
        touch:setSwallowTouches(false)
        innerLayout:addChild(touch)
        touch:addEventListener(UIEvent.CHECKBOX_STATUS_CHANGED,self,function(self)
            if self.lastTouch1 then
                self.lastTouch1:uncheck(false)
            end
            self.lastTouch1 = touch
        end)

        local numText = UI.Text:create()
        numText:init(AvalonUtil:getTargetFormatedNum(reward.num), UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_WHITE)
        numText:rightBottom(4, 0)
        numText:floatRight(0)
        innerLayout:addChild(numText)

        self.bgSpine:addComponent("kuang0"..kuangIndex, innerLayout)
        kuangIndex = kuangIndex + 1
    end

    -- down rewards
    local offset2 = {0, 90, 180}
    for k, v in ipairs(offset2) do
        local reward = allRewards[kuangIndex]
        if not reward then
            break
        end

        local innerLayout = UI.Layout:create()
        innerLayout:init()
        innerLayout:setSize(76, 61)
        innerLayout:leftUp(-38, -30)

        local icon = UI.Image:create()
        icon:init("ui_pay_box_02_bg.png")
        icon:center()
        innerLayout:addChild(icon)

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:setScale(0.85)
        goodsGrid:center()
        local goodsData = GoodsDataManager:createLocalGoodsData(reward.id)
        goodsData:setIsNew(false)
        goodsGrid:init(goodsData)
        goodsGrid:showInfoArea(true, false)
        goodsGrid:hideBG()
        goodsGrid:hideRare()
        goodsGrid:hideChoiceStatus()
        goodsGrid:hideFlagIcon()
        goodsGrid:hideCountLabel()
        goodsGrid:setTouchClipNode(innerLayout)
        innerLayout:addChild(goodsGrid)

        local touch = UI.CheckBox:create()
        touch.Index = k
        touch:init("ui_pay_box_03_2.png", "ui_pay_box_03_1.png", "ui_pay_box_03_1.png", "ui_pay_box_03_1.png")
        touch:center()
        touch:setSwallowTouches(false)
        innerLayout:addChild(touch)
        touch:addEventListener(UIEvent.CHECKBOX_STATUS_CHANGED,self,function(self)
            if self.lastTouch2 then
                self.lastTouch2:uncheck(false)
            end
            self.lastTouch2 = touch
        end)

        self.bgSpine:addComponent("kuang0"..kuangIndex, innerLayout)
        kuangIndex = kuangIndex + 1
    end
end

function ExtraGiftLayer:onPurchaseResult()
    self.blockTouch = false
    self:closeWin()
end

-- 注册监听事件(可选)
function ExtraGiftLayer:registerListener()
    Avalon.MessageCenter:bind(GameMessage.MC_PURCHASE_SUCCESS, self,self.onPurchaseResult)
end

-- 注销监听事件(可选)
function ExtraGiftLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(GameMessage.MC_PURCHASE_SUCCESS, self,self.onPurchaseResult)
end
