------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/05/26
--desc	: 
------------------------------------------------------------------------------

require "app.ui.common.Text"
require "utils.AvalonUtil"

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
local SdkManager = require "app.game.SdkManager"

UI = UI or {}

local ComebackPackageCell = class("ComebackPackageCell", UI.TableViewCell)
UI.ComebackPackageCell = ComebackPackageCell

ComebackPackageCell.CELL_WIDTH = 153 + 10
ComebackPackageCell.CELL_HEIGHT = 211

local SPRITE_GAMING_DIAMOND = "symbol_gaming_diamond.png"

function ComebackPackageCell:updateOncePerSecond()

end

function ComebackPackageCell:ctor(iapData, parentTable)
    ComebackPackageCell.super.ctor(self)

    self._iapData = iapData
    self._parentTable = parentTable
    self._detailView = nil
    self:onInitView()

    Avalon.MessageCenter:bind(GameMessage.MC_ON_TIPS_CLOSE_BUTTON, self,self.onCloseDetails)
end

function ComebackPackageCell:dtor()
    ComebackPackageCell.super.dtor(self)

    Avalon.MessageCenter:unbind(GameMessage.MC_ON_TIPS_CLOSE_BUTTON, self,self.onCloseDetails)
end

function ComebackPackageCell:updateView(data)
    self._iapData = data

    self._title:setText(self._iapData.name)
end

function ComebackPackageCell:onInitView()
    -- 内容运载层
    self._rootLayer = UI.Layout:create()
    self._rootLayer:init()
    self._rootLayer:setSize(UI.ComebackPackageCell.CELL_WIDTH, UI.ComebackPackageCell.CELL_HEIGHT)
    self._rootLayer:leftBottom(0, 0)
    self:addChild(self._rootLayer)

    local cellBg  = UI.Image:create()
    cellBg:init("ui_limitedtimestore_list.png")
    cellBg:leftBottom(0, 0)
    self._rootLayer:addChild(cellBg)

    -- print("self._iapData ===== ",self._iapData.name,self._iapData.products[1].id)
    -- dump(self._iapData)
    -- 名称
    local title = UI.Text:create()
    title:init(self._iapData.name, UI.FONT_BOLD, UI.FONT_SIZE_17PX, {r = 41, g = 41, b = 45})
    title:center(0, -87)
    title:setTextCenter()
    self._title = title
    cellBg:addChild(title)


    

    -- --限购
    -- local purchaseData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.PURCHASE, GameDataManager:getInstance():getSaveUserKey())
	-- local products = purchaseData:getProducts()
	-- local limitedNum = self._iapData.limitedNum
	-- local buyNum = 0;
	-- for i,v in ipairs(products) do
	-- 	if v.productID == self._iapData.productID then
	-- 		buyNum = v.boughtNum
	-- 		break
	-- 	end
	-- end

    local desText = UI.Text:create()
    desText:init("", UI.FONT_BOLD, UI.FONT_SIZE_15PX, {r = 41, g = 41, b = 45})
    desText:center(0, 40)
    desText:setTextCenter()
    cellBg:addChild(desText)
    self.desText = desText


    -- if (limitedNum - buyNum > 0) then
        -- local goodData = GoodsDataManager:createLocalGoodsData(tonumber(self._iapData.products[1].id))
        -- if goodData then
        --     goodData:setNum(tonumber(self._iapData.products[1].num))
        --     goodData:setIsNew(false)
        --     goodData.isHaveGet = false

        --     local rewardGrid = UI.GoodsGrid:create()
        --     rewardGrid:init(goodData)
        --     rewardGrid:hideNewIcon()
        --     -- rewardGrid:setScale(iconScale)
        --     rewardGrid:setTouchEnable(true)
        --     rewardGrid:setSwallowTouches(false)
        --     -- rewardGrid:setTouchClipNode(layout)
        --     rewardGrid:showInfoArea(true, false)
        --     rewardGrid:setTouchClipNode(self._parentTable)
        --     rewardGrid:centerUp(55)
        --     cellBg:addChild(rewardGrid)
        -- end

        local boxBtn = UI.Button:create();
        boxBtn:init(self._iapData.icon,self._iapData.icon,self._iapData.icon)
        boxBtn:centerUp(55)
        boxBtn:setTouchClipNode(self._parentTable)
        boxBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_50_50_44)
        boxBtn:closeClickScale()
        cellBg:addChild(boxBtn)
        boxBtn:setSwallowTouches(false)
        boxBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)

            -- UI.WaitingLayer:showWaiting(true, nil, 2)
            -- SdkManager:getInstance():getOrder(self._iapData, 1)
            self:openIapShopBoxDetails()
        end)
        self.boxBtn = boxBtn


        local getBtn = UI.Button:create();
        getBtn:init("ui_limitedtimestore_btn_1.png","ui_limitedtimestore_btn_1.png","ui_limitedtimestore_btn_1.png",cc.p(10, 0))
        getBtn:centerBottom(13)
        getBtn:setText("99.99")
        getBtn:setTouchClipNode(self._parentTable)
        getBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_50_50_44)
        getBtn:closeClickScale()
        cellBg:addChild(getBtn)
        getBtn:setSwallowTouches(false)
        getBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)

            -- UI.WaitingLayer:showWaiting(true, nil, 2)
            -- SdkManager:getInstance():getOrder(self._iapData, 1)
            self:openIapShopBoxDetails()
        end)
        self.getBtn = getBtn

        -- 货币标签
        self._currencyIcon = UI.Image:create();
        self._currencyIcon:init(SPRITE_GAMING_DIAMOND)
        self._currencyIcon:centerBottom(22,-30)
        cellBg:addChild(self._currencyIcon)


        local isDiamondPrice = self._iapData.currencyType == PublicDefine.PurchaseCurrencyType.PurchaseCurrencyType_Diamond
        if isDiamondPrice then
            self._currencyIcon:show()
            -- self._priceLabel:floatLeft(5)
            -- getBtn:setTextOffset(0,0)
            getBtn:setText(tostring(self._iapData.price))
            -- self._priceLabel:setText(tostring(self._iapData.price))
            self._currencyIcon:setSpriteName(SPRITE_GAMING_DIAMOND)
        else
            local SdkManager = require "app.game.SdkManager"
            local priceString = SdkManager:getInstance():getPriceStringFromIapID(self._iapData.iapId)
            if(priceString) then 
                -- 使用SKU信息
                self._currencyIcon:hide()
                -- self._priceLabel:setText(priceString)
                -- self._priceLabel:floatLeft(0)
                getBtn:setTextOffset(0,0)
                getBtn:setText(priceString)
            else
                self._currencyIcon:show()
                price = UIUtil:getMoneyPriceStr(self._iapData.price / 100)
                getBtn:setText(tostring(price))
                self._currencyIcon:setSpriteName(UIUtil:getMoneyPng())
            end
        end
    


    -- else
        local sealImg  = UI.Image:create()
        sealImg:init("ui_limitedtimestore_seal.png")
        sealImg:centerUp(45)
        cellBg:addChild(sealImg)
        self.sealImg = sealImg

        local sealDesText = UI.Text:create()
        sealDesText:init(LanguageManager:getInstance():getLocalString(1110909), UI.FONT_BOLD, UI.FONT_SIZE_17PX, {r = 155, g = 20, b = 30})
        sealDesText:center()
        sealDesText:setTextCenter()
        sealDesText:setRotation(15)
        sealImg:addChild(sealDesText)
        self.sealDesText = sealDesText
    -- end

    self:onCloseDetails()
end

function ComebackPackageCell:openIapShopBoxDetails()
    if not tolua.isnull(self._detailView) then
        self._detailView:removeSelf()
    end
    self._detailView = UI.IapShopBoxDetails:create()
    self._detailView:init()
    self._detailView:center()
    self._detailView:refreshData(self._iapData)
    
    local point = self:convertToWorldSpace(self:getAnchorPoint())
    -- print("point ====== ",point.x,point.y)
    
    -- local pointSelfCenter = self:convertToWorldSpace(cc.p(988/2,494/2))
    local viewSizeW,viewSizeH = self._detailView:getSize()
    
    -- local point1 = self:convertToNodeSpace(cc.p(point.x - 45, pointSelfCenter.y - viewSizeH/2))
    local point1 = cc.p(point.x -(viewSizeW -  UI.ComebackPackageCell.CELL_WIDTH) / 2 , point.y - (viewSizeH - ComebackPackageCell.CELL_HEIGHT) /2)
    local comebackPackageView = mvc.comebackPackageController:getComebackPackageView()
    point1 = comebackPackageView:convertToNodeSpace(point1)
    self._detailView:leftBottom(point1.x,point1.y )

    comebackPackageView.contentLayout:addChild(self._detailView, 9999)
    -- cc.Director:getInstance():getRunningScene():addChild(self._detailView)
end

function ComebackPackageCell:onCloseDetails()
    if not tolua.isnull(self._detailView) then
        self._detailView:removeSelf()
    end

    if not self._iapData then
        return
    end

    --限购
    local purchaseData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.PURCHASE, GameDataManager:getInstance():getSaveUserKey())
	local products = purchaseData:getProducts()
	local limitedNum = self._iapData.limitedNum
	local buyNum = 0;
	for i,v in ipairs(products) do
		if v.productID == self._iapData.productID then
			buyNum = v.boughtNum
			break
		end
	end

    -- print("limitedNum   buyNum ====== ",limitedNum,buyNum ,self._iapData.productID)
    -- dump(products)

    local limitedType = self._iapData.limitedType
    local needLimited = false
    if self.desText then
        if limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Daily  then
            if limitedNum - buyNum > 0 then
                self.desText:setText(UI.TEXT_1170823..": "..(limitedNum - buyNum))
            else
                self.desText:setText(UI.TEXT_1170854)
            end
            needLimited = true
        -- 每周限购
        elseif limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Weekly  then
            if limitedNum - buyNum > 0 then
                self.desText:setText(UI.TEXT_1170822..": "..(limitedNum - buyNum))
            else
                self.desText:setText(UI.TEXT_1170824)
            end
            needLimited = true
        -- 角色限购
        elseif limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Total  then
            if limitedNum - buyNum > 0 then
                self.desText:setText(LanguageManager:getInstance():getLocalString(1111561)..": "..(limitedNum - buyNum))
            else
                self.desText:setText(UI.TEXT_1170826)
            end
            needLimited = true
        end


        -- self.desText:setText(string.format("@@@@ 限购:%d", limitedNum - buyNum))
    end

    if (limitedNum - buyNum <= 0) and needLimited then
        self.boxBtn:hide()
        self.getBtn:hide()
        self._currencyIcon:hide()

        self.sealImg:show()
        self.sealDesText:show()
    else
        self.boxBtn:show()
        self.getBtn:show()
        self._currencyIcon:show()

        self.sealImg:hide()
        self.sealDesText:hide()
    end
end

