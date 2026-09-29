require "app.ui.iapshop.IapShopBoxDetailsCell"
local SdkBox = require("utils.sdkbox.SdkBox")
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local IapShopBoxDetails = class("IapShopBoxDetails",UI.HWBtnComponent)
UI.IapShopBoxDetails = IapShopBoxDetails

local RES_LIST = {
}

local SPRITE_GAMING_DIAMOND = "symbol_gaming_diamond.png"
local SPRITE_NUMBER_FORMAT = "ui_number_%d.png"
local DES_WIDTH = 353
local DES_HEIGHT = 523
local MAX_COUNT = 9 -- 单次购买最大数量
local MIN_COUNT = 1 -- 单次购买最小数量

function IapShopBoxDetails:ctor(type,multiplePay)
    IapShopBoxDetails.super.ctor(self,type,RES_LIST,DES_WIDTH,DES_HEIGHT)
    self._countLabel = nil
    self._count  = 1
    self._list = {}
    self._maxBuy = 0
    if(multiplePay == nil) then 
        multiplePay = true
    end
    self._multiplePay = multiplePay
    self._buyLimit = MAX_COUNT
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
end

function IapShopBoxDetails:dtor()
	self:unRegisterListener()
end


function IapShopBoxDetails:onInitView()
    -- 背板
    local bg = UI.Image:create()
    bg:init("ui_shopping_banner_box1.png")
    bg:center()
    bg:showLucencyLight()
    self:addChild(bg)

    -- 名字
    self._nameLabel = UI.Text:create()
    self._nameLabel:init("",UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_194_194_194)
    self._nameLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(2, -2))
    self._nameLabel:centerUp(10)
    bg:addChild(self._nameLabel)

    -- 限购条件文字
    self._selfLimitLabel = UI.Text:create()
    self._selfLimitLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._selfLimitLabel:rightUp(48, 65)
    bg:addChild(self._selfLimitLabel)
    
    -- 装备滚动栏
    self._tableView = UI.TableView:create({},261, 315)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:centerBottom(116)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:setScrollBarEnabled(false)
    self._tableView:onUpdateCellSize(function ()
        return 1000, 88
    end) 
    self._tableView:onUpdateCells(function (tableview, idx)
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.IapShopBoxDetailsCell.new()
        end
        xpcall(function()
            -- cell:onUpdateView(self._list[idx * 2 + 1], self._list[(idx + 1) * 2])
            cell:onUpdateView(self._list[idx + 1])
        end, 
        function(e) 
            printInfo("IapShopBoxDetails:tableCellAtIndex-----------------error")
        end, 1) 
        return cell
    end)
    self._tableView:onUpdateCellNumbers(function ()
        return math.ceil(table.nums(self._list))
    end)
    self:addChild(self._tableView)

    
    -- 货币标签
    local botCover = UI.Image:create()
    botCover:init("ui_shopping_banner_box1_mask.png")
    botCover:leftBottom(29, 97)
    self:addChild(botCover)

    -- 购买按钮
    self._buyBtn = UI.Button:create()
    self._buyBtn:init("ui_btn_yellow8_0.png", "ui_btn_yellow8_1.png", "ui_btn_yellow8_2.png")
    self._buyBtn:centerBottom(28)
    self._buyBtn:closeClickScale()
    self._buyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onBuyButton)
    self._buyBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, self.onBuyButton)
    self:addChild(self._buyBtn)

    -- 价钱排版
    self._priceLayout = UI.Layout:create()
    self._priceLayout:init()
    self._priceLayout:center()
    self._priceLayout:enableAutoHeight()
    self._priceLayout:enableAutoWidth()
    self._buyBtn:addChild(self._priceLayout, 100)

    -- 货币标签
    self._currencyIcon = UI.Image:create();
    self._currencyIcon:init(SPRITE_GAMING_DIAMOND)
    self._currencyIcon:floatLeft(0)
    self._priceLayout:addComponent(self._currencyIcon)

    -- 价钱文字
    self._priceLabel = UI.Text:create()
    self._priceLabel:init("",UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self._priceLabel:floatLeft(5)
    self._priceLayout:addComponent(self._priceLabel)

    -- 合并支付数量排版
    self._countLayout = UI.Layout:create()
    self._countLayout:init()
    self._countLayout:floatLeft(0)
    self._priceLayout:addComponent(self._countLayout)

    -- 合并支付数量前面的X
    local xImage = UI.Image:create()
    xImage:init("ui_number_x.png")
    xImage:leftBottom(0, 7)
    self._countLayout:addChild(xImage)

    --  合并支付数量
    self._countLabel = UI.Image:create()
    self._countLabel:init(string.format(SPRITE_NUMBER_FORMAT, 0))
    self._countLabel:leftBottom(10, 7)
    self._countLayout:addChild(self._countLabel)

    local mergePay = SdkBox:getInstance():isSupportMergePay()
    if (mergePay or DEVELOPMENT_MODE) and self._multiplePay and not ServerConfigUtil:isInReview() then
        -- 加按钮
        self._addBtn = UI.Button:create()
        self._addBtn:init("ui_btn_add_white_0.png","ui_btn_add_1.png","ui_btn_add_white_2.png")
        self._addBtn:rightBottom(44, 31)
        self._addBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onAddButton)
        self._buyBtn:setSwallowTouches(false)
        bg:addChild(self._addBtn, 1000)

        -- 减按钮
        self._subBtn = UI.Button:create()
        self._subBtn:init("ui_btn_minus_white_0.png","ui_btn_minus_1.png","ui_btn_minus_white_2.png")
        self._subBtn:leftBottom(44, 31)
        self._subBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onSubButton)
        self._buyBtn:setSwallowTouches(false)
        bg:addChild(self._subBtn, 1000)
    end
end

function IapShopBoxDetails:onUpdateView()
    if not self._data then return end

    -- 更新已经购买信息
    local purchaseData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.PURCHASE, GameDataManager:getInstance():getSaveUserKey())
    local products = purchaseData:getProducts()
    local limitedType = self._data.limitedType
    local limitedNum = self._data.limitedNum
    local buyNum = 0
    for i,v in ipairs(products) do
        if v.productID == self._data.productID then
            print("找到了")
            
            buyNum = v.boughtNum
            print("limitedNum",self._data.productID, limitedNum,buyNum, self._data.currencyType)
            break
        end
    end
    
    -- if data.boughtNum then
    --  buyNum = data.boughtNum
    -- else
    --  print("数据异常 ",data.name)
    -- end
    -- 每日限购
    if limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Daily  then
        if limitedNum - buyNum > 0 then
            self._selfLimitLabel:setText(UI.TEXT_1170823..": "..(limitedNum - buyNum))
        else
            self._selfLimitLabel:setText(UI.TEXT_1170854)
        end
    -- 每周限购
    elseif limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Weekly  then
        if limitedNum - buyNum > 0 then
            self._selfLimitLabel:setText(UI.TEXT_1170822..": "..(limitedNum - buyNum))
        else
            self._selfLimitLabel:setText(UI.TEXT_1170824)
        end
    -- 角色限购
    elseif limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Total  then
        if limitedNum - buyNum > 0 then
            self._selfLimitLabel:setText(LanguageManager:getInstance():getLocalString(1111561)..": "..(limitedNum - buyNum))
        else
            self._selfLimitLabel:setText(UI.TEXT_1170826)
        end
    end
end

function IapShopBoxDetails:onBuyButton()
    -- 判断是否在城镇
	if not SceneManager:getInstance():isNotInFightScene() then
		UI.ScrollBar:createByText(UI.TEXT_1170842)
		return
	end
    -- 判断是否条件满足
      -- 判断是否条件满足
    local allDone = false
    local ProtobufUtil = require "utils.ProtobufUtil"
    if ProtobufUtil:checkFieldIsInit(self._data, "allDone") then
        allDone = self._data.allDone
    else
        allDone = false
    end
    if not allDone then
        UI.ScrollBar:createByText(UI.TEXT_1170848)
        return
    end
    -- 判断还能不能购买
    if self._buyLimit <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1170826)
        return
    end

    -- 如果是水晶宝箱，判断水晶是否足够
    local allPrice = self._data.price * self._count
    if self.isDiamondPrice and not Avalon.MathUtil:checkDiamonEnough(allPrice, GameDataManager:getInstance():getDiamond()) then
        UI.ScrollBar:createByTextID(1170016)
        return
    end
    -- 如果是水晶宝箱，判断背包是否足够
    if self.isDiamondPrice and self:checkBagIsFull() then
        UI.ScrollBar:createByTextID(1170081)
        return
    end


    local curTime = GameManager:getNormalServerTime()
    local startTime = self._data.startTimeSec
    -- 判断是否开放购买
    if startTime > curTime then
        UI.ScrollBar:createByText(UI.TEXT_1170846)
        return;
    end
	-- UI.ScrollBar:createByText("暂未开放")
    -- print("点击购买按钮 ")
    
	local mergePay = SdkBox:getInstance():isSupportMergePay()
	printInfo("IapShopBoxDetails:onBuyButton(), 是否支持合并支付  ", mergePay)
	local count = 1;
	if mergePay or DEVELOPMENT_MODE then
		count = self._count
	else
		count = 1
	end
	Avalon.MessageCenter:notice(GameMessage.MC_GET_ORDER_REQ, self._data,count)
end

function IapShopBoxDetails:checkBagIsFull()
    local full = false
    local goodsArr = {}
    local goodsDataList = {}
    for k, v in pairs(self._list) do
        local data = {}
        data.goodsID = checkint(v.id)
        data.num = v.num
        data.isGolden = true
        table.insert(goodsArr, data)
    end

    -- 判断背包是否满了
    if not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) == true then 
        full = true
    end
    return full
end

-- 刷新价格和数量
function IapShopBoxDetails:refreshCountAndPrice()
	if not self._data then return end
    if self._count <= 1 then
        self._priceLabel:center()
        self._countLabel:setSpriteName(string.format(SPRITE_NUMBER_FORMAT, 0))
        self._countLayout:hide()
    else
        self._countLabel:setSpriteName(string.format(SPRITE_NUMBER_FORMAT, self._count))
        self._countLayout:show()
        self._countLayout:setScale(2)
        self._countLayout:runAction(cc.EaseIn:create(cc.ScaleTo:create(0.1, 1), 3))
    end
    self._priceLayout:updateView()

    -- 判断是否条件满足
    local allDone = false
    local ProtobufUtil = require "utils.ProtobufUtil"
    if ProtobufUtil:checkFieldIsInit(self._data, "allDone") then
        allDone = self._data.allDone
    else
        allDone = false
    end
    if not allDone then 
        self._buyBtn:disable()
        if not self._subBtn or not self._addBtn then return end
        self._subBtn:disable()
        self._addBtn:disable()
        return
    end

    if not self._subBtn or not  self._addBtn then return end
	if self._count <= 1 then
		self._subBtn:disable()
	else
		self._subBtn:enable()
	end

	if self._count >= math.min(self._buyLimit,MAX_COUNT) then
		self._addBtn:disable()
	else
		self._addBtn:enable()
	end
    self._priceLayout:updateView()
end

-- 减
function IapShopBoxDetails:onSubButton()
	if self._count <= MIN_COUNT then
		return
	end
	self._count = self._count - 1
	self:refreshCountAndPrice()
end

-- 加
function IapShopBoxDetails:onAddButton()
	if self._count >=  math.min(self._buyLimit,MAX_COUNT) then
		return
	end
	self._count = self._count + 1
	self:refreshCountAndPrice()
end

function IapShopBoxDetails:refreshData(data)
    if not data then
        return
    end


    print(debug.traceback())
    print("IapShopBoxDetails:refreshData(data) ====== ")
    dump(data)

    -- 清空名字
    self._nameLabel:setText(data.name or "")

    -- 更新价标
    local isDiamondPrice = data.currencyType == PublicDefine.PurchaseCurrencyType.PurchaseCurrencyType_Diamond
    if isDiamondPrice then
        self._currencyIcon:show()
        self._priceLabel:floatLeft(5)
        self._priceLabel:setText(tostring(data.price))
        self._currencyIcon:setSpriteName(SPRITE_GAMING_DIAMOND)
    else
        local SdkManager = require "app.game.SdkManager"
        local priceString = SdkManager:getInstance():getPriceStringFromIapID(data.iapId)
        if(priceString) then 
            -- 使用SKU信息
            self._currencyIcon:hide()
            self._priceLabel:setText(priceString)
            self._priceLabel:floatLeft(0)
        else
            self._currencyIcon:show()
            self._priceLabel:floatLeft(5)
            price = UIUtil:getMoneyPriceStr(data.price / 100)
            self._priceLabel:setText(tostring(price))
            self._currencyIcon:setSpriteName(UIUtil:getMoneyPng())
        end
    end
    self._priceLayout:updateView()

    self._data = data
    self._list = {}
	for i,v in ipairs(data.products or {}) do
		table.insert(self._list, v)
	end
    self._tableView:reload()
    self:refreshLimit()
    self:refreshCountAndPrice()
end

function IapShopBoxDetails:hideAllBtn()
    if(not tolua.isnull(self._buyBtn)) then 
        self._buyBtn:hide()
    end
    if(not tolua.isnull(self._subBtn)) then 
        self._subBtn:hide()
    end
    if(not tolua.isnull(self._addBtn)) then 
        self._addBtn:hide()
    end
end

function IapShopBoxDetails:refreshLimit()
    local purchaseData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.PURCHASE, GameDataManager:getInstance():getSaveUserKey())
    local products = purchaseData:getProducts()

    local buyNum = 0;
	for i,v in ipairs(products) do
		if v.productID == self._data.productID then
            buyNum = v.boughtNum
            break;
		end
    end
    local limitedType = self._data.limitedType
    local limitedNum = self._data.limitedNum
    local canBuy = MAX_COUNT

    if limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Daily  then
		canBuy = limitedNum - buyNum
	-- 每周限购
	elseif limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Weekly  then
		canBuy = limitedNum - buyNum
	-- 角色限购
	elseif limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Total  then
		canBuy = limitedNum - buyNum
    end

    if self._data.saleNum > 0 then
        canBuy = math.min(self._data.saleNum - self._data.buyNum,canBuy)
    end

    if canBuy <= 0 then
        canBuy = 0
    end

    self._buyLimit = canBuy

    self:onUpdateView()
    printInfo("IapShopBoxDetails:refreshLimit, 可以购买的数量  ", canBuy)
end

function IapShopBoxDetails:onPaySucc(needRefresh)
    if needRefresh then
        self:refreshLimit()
    end
end


function IapShopBoxDetails:onTouchDialogOutsizeHandler()
    -- print("-----------IapShopBoxDetails:onTouchDialogOutsizeHandler()")
    self:close()
end

function IapShopBoxDetails:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_SDK_PURCHASE_SUCC, self,self.onPaySucc)
end

function IapShopBoxDetails:unRegisterListener()
    Avalon.MessageCenter:unbind(GameMessage.MC_SDK_PURCHASE_SUCC, self,self.onPaySucc)
end

return IapShopBoxDetails