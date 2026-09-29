-- AdvGiftLayer.lua
-- Author:lzm
-- 2019年4月18日
-- Using:进阶礼包

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"
local SceneManager = require("app.game.SceneManager")
local SdkManager = require "app.game.SdkManager"
local SdkBox = require("utils.sdkbox.SdkBox")
local scheduler = cc.Director:getInstance():getScheduler()

UI = UI or {}

local AdvGiftLayer = class("AdvGiftLayer", UI.DownShowWin)
UI.AdvGiftLayer = AdvGiftLayer

local winSize = cc.Director:getInstance():getWinSize()
local VIEW_WIDTH = 700;
local VIEW_HEIGHT = 400;

local ZOrder = 1

local progressImg = {
    --  灰，亮
    [1] = {"pay_recharge_level_1_2.png", "pay_recharge_level_1_1.png"},
    [2] = {"pay_recharge_level_2_2.png", "pay_recharge_level_2_1.png"},
    [3] = {"pay_recharge_level_3_2.png", "pay_recharge_level_3_1.png"},
    [4] = {"pay_recharge_level_4_2.png", "pay_recharge_level_4_1.png"},
    [5] = {"pay_recharge_level_5_2.png", "pay_recharge_level_5_1.png"},
    [6] = {"pay_recharge_level_6_2.png", "pay_recharge_level_6_1.png"},
}

local progressBarW = {10, 40, 80, 120, 160, 200}
local progressPos = {0, 35, 70, 105, 140, 175}

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_pay.plist",
    "ui_general_shopping.plist",
}

--构造函数(必备)
function AdvGiftLayer:ctor()
    AdvGiftLayer.super.ctor(self, UIType.ADV_GIFT, COM_RES_LIST, VIEW_WIDTH, VIEW_HEIGHT)
    self:registerListener()
    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_AdvGift,0,0,0,0)
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_SpecialGift, 2, nil, nil)
    self.lastTouch1 = nil
    self.lastTouch2 = nil
    self.blockTouch = false

    self:initGiftData()

    self:init()
    self:open()
end

--虚构函数,destroy时调用(必备)
function AdvGiftLayer:dtor()
    AdvGiftLayer.super.dtor(self)
    self:unRegisterListener()

    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

function AdvGiftLayer:scheduleUpdateTime()
    -- 进阶礼包重置检查
    local masterData = RoleDataManager:getMaster()
    local advStageRefreshTime = masterData.stageRefreshTime

    local nowTime = GameManager:getNormalServerTime()
    if advStageRefreshTime > 0 and advStageRefreshTime <= nowTime then
        -- 如果已经跨过刷新时间，则需要重置进度，直接关闭界面
        self:closeWin()
    end
end

-- 初始化(必备)
function AdvGiftLayer:init(npcID)
    AdvGiftLayer.super.init(self)

    self:setInterceptTouches(true)
    self:setTouchEnable(true)
end

function AdvGiftLayer:initGiftData()
    self.giftData = {}
    local giftIdx = 1
    local giftData = SdkManager:getInstance():getIapDatas()
    for k, v in pairs(giftData) do
        if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_ADV_GIFT then
            self.giftData[giftIdx] = v
            giftIdx = giftIdx + 1
        end
    end

    table.sort(self.giftData, function(a, b)
        return a.stage < b.stage
    end)

    local masterData = RoleDataManager:getMaster()
    self.advStageRefreshTime = masterData.stageRefreshTime

    for k, v in ipairs(self.giftData) do
        if v.stage == masterData.stage then
            self.advStage = k
            break
        end
    end

    local nowTime = GameManager:getNormalServerTime()
    if nowTime >= self.advStageRefreshTime then
        self.advStage = 0
    else
        -- 如果进入界面时，礼包还在有效期内，则开启监听重置时间点
        self.schedulerID = scheduler:scheduleScriptFunc(handler(self, self.scheduleUpdateTime), 1, false)
    end
end

-- 模版函数：初始化组建的视图(必备)
function AdvGiftLayer:onInitView()
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

    -- 背景图片
    local bg  = UI.Image:create();
    bg:init("pay_recharge_bg.png");
    bg:center();
    contentLayout:addChild(bg, ZOrder);
    -- bg:enableDebugDraw()
    ZOrder = ZOrder + 1
    self.bg = bg

    self:initPanel()
end

function AdvGiftLayer:initPanel()
    -- 关闭按钮
    local closeBtn = UI.Button:create()
    closeBtn:init("ui_btn_button_cancel_0.png","ui_btn_button_cancel_1.png","ui_btn_button_cancel_2.png")
    closeBtn:rightUp(101, 65)
    closeBtn:closeClickScale()
    self.bg:addChild(closeBtn)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:closeWin()
    end)

    -- 充值XXX
    local layout1 = UI.Layout:create();
    layout1:init();
    layout1:setSize(200, 40)
    layout1:leftUp(225, 40);
    self.bg:addChild(layout1)
    layout1:runAction(cc.RotateTo:create(0, -35))

    local text1 = UI.Text:create()
    text1:init(UI.TEXT_1212431, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_192_192_192)
    text1:centerLeft(0)
    layout1:addChild(text1)

    local w,h = text1:getSize()

	local SdkManager = require "app.game.SdkManager"
    local iapId
    local iapInfo = self.giftData[self.advStage+1]
    if (iapInfo and iapInfo.IAPList and #iapInfo.IAPList > 0 and iapInfo.IAPList[1] and iapInfo.IAPList[1].iapId) then
        iapId = iapInfo.IAPList[1].iapId
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
    
        local price = self.giftData[self.advStage+1].price/100 or 0
        price= UIUtil:getMoneyPriceStr(price)
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
    layout2:leftUp(170, 130);
    self.bg:addChild(layout2)
    layout2:runAction(cc.RotateTo:create(0, -35))

    local text3 = UI.Text:create()
    text3:init(UI.TEXT_1212432, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_81_49_89)
    text3:setWidth(200);
    text3:rightUp(0, 0)
    text3:floatRight(0)
    text3:setTextRight()
    text3:autoAdapt()
    layout2:addChild(text3)

    -- 进阶礼包
    local layout3 = UI.Layout:create();
    layout3:init();
    layout3:setSize(200, 40)
    layout3:leftUp(360, 60);
    self.bg:addChild(layout3)
    layout3:runAction(cc.RotateTo:create(0, -15))

    local text4 = UI.Text:create()
    text4:init(UI.TEXT_1212435, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_192_192_192)
    text4:centerLeft(0)
    text4:floatLeft(0)
    layout3:addChild(text4)

    -- 进度
    local layout4 = UI.Layout:create();
    layout4:init();
    layout4:setSize(200, 30)
    layout4:leftUp(180, 290)
    self.bg:addChild(layout4)
    layout4:runAction(cc.RotateTo:create(0, 18))

    local progressIndex = self.advStage

    local w1, h1 = layout4:getSize()
    local splitLin1 = cc.Scale9Sprite:createWithSpriteFrameName("pay_recharge_level_line_2.png")
    splitLin1:setContentSize(w1, 3)
    splitLin1:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLin1:setPosition(w1/2, h1/2)
    layout4:addChild(splitLin1)

    local splitLin2 = cc.Scale9Sprite:createWithSpriteFrameName("pay_recharge_level_line_1.png")
    splitLin2:setContentSize(progressBarW[1], 3)
    splitLin2:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLin2:setPosition(progressBarW[1]/2, h1/2)
    layout4:addChild(splitLin2)

    for k, v in ipairs(progressImg) do
        local icon = UI.Image:create()
        if k > progressIndex then
            -- 置灰
            icon:init(v[1])
        else
            -- 点亮
            icon:init(v[2])
            splitLin2:setContentSize(progressBarW[k], 3)
            splitLin2:setPosition(progressBarW[k]/2, h1/2)
        end
        icon:centerLeft(progressPos[k])
        layout4:addChild(icon)
    end

    -- 立即领取
    local getBtn = UI.Button:create();
    getBtn:init("ui_btn_yellow14_0.png","ui_btn_yellow14_1.png","ui_btn_yellow14_2.png")
    getBtn:rightBottom(112, 35)
    getBtn:setText(UI.TEXT_1212430)
    getBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    getBtn:closeClickScale()
    self.bg:addChild(getBtn)
    getBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        if self.blockTouch then
            return
        end

        self.blockTouch = true

        SdkManager:getInstance():getOrder(self.giftData[self.advStage+1], 1)
    end)

    -- up rewards
    local layout5 = UI.Layout:create()
    layout5:init()
    layout5:setSize(190, 50)
    layout5:rightUp(132, 136)
    self.bg:addChild(layout5)

    local kuangIndex = 1
    local allRewards = self.giftData[self.advStage+1].products
    local offset1 = {0, 50, 100, 150}
    for k, v in ipairs(offset1) do
        local reward = allRewards[kuangIndex]
        if not reward then
            break
        end

        local innerLayout = UI.Layout:create()
        innerLayout:init()
        innerLayout:setSize(42, 42)
        innerLayout:centerLeft(offset1[k])

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

        kuangIndex = kuangIndex + 1

        layout5:addChild(innerLayout)
    end

    -- down rewards
    local layout6 = UI.Layout:create()
    layout6:init()
    layout6:setSize(256, 61)
    layout6:rightBottom(165, 125)
    self.bg:addChild(layout6)

    local offset2 = {0, 90, 180}
    for k, v in ipairs(offset2) do
        local reward = allRewards[kuangIndex]
        if not reward then
            break
        end

        local innerLayout = UI.Layout:create()
        innerLayout:init()
        innerLayout:setSize(76, 61)
        innerLayout:centerLeft(offset2[k])

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

        local numText = UI.Text:create()
        numText:init(AvalonUtil:getTargetFormatedNum(reward.num), UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_WHITE)
        numText:rightBottom(14, 0)
        numText:floatRight(0)
        innerLayout:addChild(numText)

        kuangIndex = kuangIndex + 1

        layout6:addChild(innerLayout)
    end
end

function AdvGiftLayer:onPurchaseResult(data)
    RoleDataManager:setAdvGiftProgress(data.stage)
    RoleDataManager:setAdvGiftRefreshTime(data.stageRefreshTime)

    self.blockTouch = false

    -- 这里必须再强制通知主界面刷新一次礼包入口，因为主界面注册的MC_PURCHASE_SUCCESS事件先收到，那个时候数据还没有更新
    Avalon.MessageCenter:notice(GameMessage.MC_ADV_GIFT_DATA_UPDATE)

    self:closeWin()
end

-- 注册监听事件(可选)
function AdvGiftLayer:registerListener()
    Avalon.MessageCenter:bind(GameMessage.MC_PURCHASE_SUCCESS, self,self.onPurchaseResult)
end

-- 注销监听事件(可选)
function AdvGiftLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(GameMessage.MC_PURCHASE_SUCCESS, self,self.onPurchaseResult)
end
