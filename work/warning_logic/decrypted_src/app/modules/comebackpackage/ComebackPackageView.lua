------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/05/26
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ComebackPackageView = class("ComebackPackageView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

local SdkManager = require "app.game.SdkManager"
require "app.modules.comebackpackage.ComebackPackageCell"

local winSize = cc.Director:getInstance():getWinSize()
-- 资源
local COM_RES_LIST = {
    "ui_town_limitedtimestore.plist",
    "ui_general_shopping.plist"
}

local COM_WIDTH = 988
local COM_HEIGHT = 494

function ComebackPackageView:ctor()
    ComebackPackageView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ComebackPackageView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.comebackpackage", "ComebackPackage", false)
    ComebackPackageView.super.init(self, ... )
end

function ComebackPackageView:dtor()
    ComebackPackageView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.comebackpackage.ComebackPackageView")
    reload_script_file("app.modules.comebackpackage.ComebackPackageCell")
end

function ComebackPackageView:onInitView()

    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local innerImg  = UI.Image:create()
    innerImg:init("ui_limitedtimestore_bg.png")
    innerImg:center(50)
    contentLayout:addChild(innerImg)
    self._bg = innerImg

    -- local beautyImg  = UI.Image:create()
    -- beautyImg:init("ui_limitedtimestore_illustration.png")
    -- beautyImg:center(-350, -15)
    -- contentLayout:addChild(beautyImg,999)
    local beautySpine = UI.Animation:create()
    beautySpine:init("effect_ui_town_summershop_princess.json", "effect_ui_town_summershop_princess.atlas", 1);
    beautySpine:centerBottom(56, -375)
    contentLayout:addChild(beautySpine,10)
    beautySpine:setAnimation("idle", true)

    local beachSpine = UI.Animation:create()
    beachSpine:init("effect_ui_town_summershop_beach.json", "effect_ui_town_summershop_beach.atlas", 1);
    beachSpine:center(0,185)
    contentLayout:addChild(beachSpine,-1)
    beachSpine:setAnimation("idle1", true)

    local umbrellaSpine = UI.Animation:create()
    umbrellaSpine:init("effect_ui_town_summershop_umbrella.json", "effect_ui_town_summershop_umbrella.atlas", 1);
    umbrellaSpine:rightUp(175,370)
    contentLayout:addChild(umbrellaSpine,11)
    umbrellaSpine:setAnimation("idle", true)

    local decorateImg = UI.Image:create()
    decorateImg:init("ui_limitedtimestore_decorate.png")
    decorateImg:rightUp(143,353)
    contentLayout:addChild(decorateImg,12)


    --理性娱乐，适度消费
    local toastImg = UI.Image:create()
    toastImg:init("ui_shopping_banner_prompt.png")
    toastImg:leftBottom(595, 30)
    contentLayout:addComponent(toastImg)

    local toastText = UI.Text:create()
	toastText:init(UI.TEXT_221301, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r = 200, g = 200, b = 200})
	toastText:leftBottom(610, 30)
    contentLayout:addComponent(toastText)

    local timeDes = mvc.comebackPackageModel:getActivityOpeningStrByID(PublicDefine.TradeActivityIDList.TradeActivityComeback)
    local timeText = UI.Text:create()
    timeText:init(timeDes, UI.FONT_BOLD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_225_225_225)
    timeText:centerBottom(0,185)
    timeText:setTextCenter()
    contentLayout:addChild(timeText,10)

    -- local configData = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityComeback)
    -- local title = UI.Text:create()
    -- title:init(configData.name, UI.FONT_BOLD, UI.FONT_SIZE_48PX, {r = 254, g = 175, b = 27})
    -- title:center(-76, -145)
    -- title:setSize(280, 88)
    -- title:setTextCenter()
    -- contentLayout:addChild(title)
    local titleImg = UI.Image:create()
    titleImg:init("ui_limitedtimestore_title.png")
    titleImg:centerUp(60,-85)
    contentLayout:addChild(titleImg)


    --关闭
    local closeBtn = UI.Button:create()
    closeBtn:init('ui_limitedtimestore_btn_close.png', 'ui_limitedtimestore_btn_close.png', 'ui_limitedtimestore_btn_close.png')
    closeBtn:rightUp(120,105)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.comebackPackageController:closeSelectLayer()
    end)
    contentLayout:addChild(closeBtn,999)


    local packageLayout = UI.Layout:create()
    packageLayout:init()
    packageLayout:setSize(COM_WIDTH, COM_HEIGHT)
    packageLayout:center()
    contentLayout:addChild(packageLayout)
    self.packageLayout = packageLayout

    -- local iapDatas = mvc.comebackPackageModel:getPackageData()

    -- self:updatePackageView(iapDatas)

    local SdkBox = require("utils.sdkbox.SdkBox")
    local myChannel = SdkBox:getInstance():getVersionChannel()
    Net.NetPurchaseSystem:reqProducts(nil,nil,myChannel)
end

function ComebackPackageView:refreshProducts()
    printInfo("ComebackPackageView:refreshProducts   refreshProductsrefreshProducts")
	local iapDatas = mvc.comebackPackageModel:getPackageData()
    self:updatePackageView(iapDatas)
end

function ComebackPackageView:updatePackageView(iapDatas)
    self.packageLayout:removeAllChildren()
    self._iapDatas = iapDatas

    self._tableView = UI.TableView:create({}, 517, 212)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    self._tableView:leftBottom(270, 110)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:onUpdateCellSize(function ()
        return UI.ComebackPackageCell.CELL_WIDTH, UI.ComebackPackageCell.CELL_HEIGHT
    end) 
    self._tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        -- 更新单元
        xpcall(function()
            if cell then
                cell:removeFromParent()
                cell = nil
            end
            if cell == nil then
                cell = UI.ComebackPackageCell.new(iapDatas[luaIdx] ,self._tableView)
            end
        end, 
        function(e) 
            printInfo("ActivityPointView:tableCellAtIndex, error")
        end, 1) 

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return #iapDatas
    end)
    self.packageLayout:addChild(self._tableView)
    self._tableView:reloadData()

end

function ComebackPackageView:onGetBoughtResp()
    if self._tableView then
        self._tableView:reloadData()
    end
end

function ComebackPackageView:onPaySucc()
    local iapDatas = mvc.comebackPackageModel:getPackageData()
    self:updatePackageView(iapDatas)
end


function ComebackPackageView:getOrder(data,count)
    printInfo("IapShopMainLayer:getOrder")
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
    SdkManager:getInstance():getOrder(data,count,self._curIdx)
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 5, data.productID, nil, self._sourceType)
end

function ComebackPackageView:bindModel()
    mvc.tradeActivityModel:bind("comebackPackageUpdateView", self, self.UpdatePackageView)
    Avalon.MessageCenter:bind(GameMessage.MC_GET_ORDER_REQ, self,self.getOrder)
    Avalon.MessageCenter:bind(GameMessage.MC_GET_BOUGHT_RESP, self, self.onGetBoughtResp)
    Avalon.MessageCenter:bind(GameMessage.MC_SDK_PURCHASE_SUCC, self,self.onPaySucc)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.refreshProducts)
end


function ComebackPackageView:unbindModel()
    mvc.tradeActivityModel:unbind("comebackPackageUpdateView", self, self.UpdatePackageView)
    Avalon.MessageCenter:unbind(GameMessage.MC_GET_ORDER_REQ, self,self.getOrder)
    Avalon.MessageCenter:unbind(GameMessage.MC_GET_BOUGHT_RESP, self, self.onGetBoughtResp)
    Avalon.MessageCenter:unbind(GameMessage.MC_SDK_PURCHASE_SUCC, self,self.onPaySucc)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.refreshProducts)
end





return ComebackPackageView












