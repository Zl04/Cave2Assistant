------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/21
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityAnnivesaryLotteryGiftPackView = class("ActivityAnnivesaryLotteryGiftPackView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local SdkManager = require "app.game.SdkManager"

-- 资源
local COM_RES_LIST = {
}

local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = 593
local COM_HEIGHT = 475

function ActivityAnnivesaryLotteryGiftPackView:ctor(data)
    ActivityAnnivesaryLotteryGiftPackView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self._iapData = data
    self:bindModel()
end

function ActivityAnnivesaryLotteryGiftPackView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activityannivesarylottery", "ActivityAnnivesaryLottery", false)
    ActivityAnnivesaryLotteryGiftPackView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:close()
    end)
    
end

function ActivityAnnivesaryLotteryGiftPackView:dtor()
    ActivityAnnivesaryLotteryGiftPackView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activityannivesarylottery.ActivityAnnivesaryLotteryGiftPackView")
end


function ActivityAnnivesaryLotteryGiftPackView:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_anniversary_bg_7.png")
    bg:center()
    contentLayout:addChild(bg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_223619, UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(60, 10)
    contentLayout:addChild(titleText)

    local boxBtn = UI.Button:create();
    boxBtn:init("ui_anniversary_giftpackage.png","ui_anniversary_giftpackage.png","ui_anniversary_giftpackage.png")
    boxBtn:centerUp(120, 10)
    boxBtn:closeClickScale()
    contentLayout:addChild(boxBtn)
    boxBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:openIapShopBoxDetails()
    end)
    self.boxBtn = boxBtn

    local des = UI.Text:create()
    des:init(UI.TEXT_223618, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    des:setSize(275, 75)
    des:setTextLeft()
    des:centerBottom(115, 10)
    contentLayout:addChild(des)

    local openBtn = UI.Button:create();
    openBtn:init("ui_anniversary_btn_2.png","ui_anniversary_btn_2.png","ui_anniversary_btn_2.png")
    openBtn:center(10, 210)
    openBtn:closeClickScale()
    openBtn:setText(UI.TEXT_111014)
    openBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_50_50_44)
    contentLayout:addChild(openBtn)
    openBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:openIapShopBoxDetails()
    end)
    self.openBtn = openBtn
end

function ActivityAnnivesaryLotteryGiftPackView:openIapShopBoxDetails()
    if not tolua.isnull(self._detailView) then
        self._detailView:removeSelf()
    end
    self._detailView = UI.IapShopBoxDetails:create()
    self._detailView:init()
    self._detailView:center()
    self._detailView:refreshData(self._iapData)
    self._detailView:center(300, 0)

    self.contentLayout:addChild(self._detailView, 999)
end

function ActivityAnnivesaryLotteryGiftPackView:getOrder(data,count)
    printInfo("ActivityAnnivesaryLotteryGiftPackView:getOrder")
    if data.currencyType == PublicDefine.PurchaseCurrencyType.PurchaseCurrencyType_Diamond then
        if not Avalon.MathUtil:checkDiamonEnough(count * data.price, GameDataManager:getInstance():getDiamond()) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170045))
            return;
        end
        
    end
    
    if not SceneManager:getInstance():isNotInFightScene() then--不在城镇
        if data.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_TREASURE then
            printError("can not get order of box in other scene")
            return
        end
    end
    SdkManager:getInstance():getOrder(data,count)
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 5, data.productID, nil, self._sourceType)
end

function ActivityAnnivesaryLotteryGiftPackView:addGiftPack()
    
end

function ActivityAnnivesaryLotteryGiftPackView:bindModel()
    Avalon.MessageCenter:bind(GameMessage.MC_GET_ORDER_REQ, self,self.getOrder)
end


function ActivityAnnivesaryLotteryGiftPackView:unbindModel()
    Avalon.MessageCenter:unbind(GameMessage.MC_GET_ORDER_REQ, self,self.getOrder)

end





return ActivityAnnivesaryLotteryGiftPackView












