--
-- Author: yueyingsong
-- Date: 2017-11-21 11:35:56
--

local SdkBox = require("utils.sdkbox.SdkBox")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")

require("app.utils.ServerConfigUtil")
UI = UI or {}
local IapShopDiamondItem = class("IapShopDiamondItem",UI.HWBtnComponent)
UI.IapShopDiamondItem = IapShopDiamondItem

local SPRITE_GAMING_DIAMOND = "symbol_gaming_diamond.png"
local SPRITE_NUMBER_FORMAT = "ui_number_%d.png"

local DES_WIDTH = 306
local DES_HEIGHT = 210
local MAX_COUNT = 9 -- 单次购买最大数量
local MIN_COUNT = 1 -- 单次购买最小数量

function IapShopDiamondItem:ctor()
	IapShopDiamondItem.super.ctor(self, UIType.IAP_SHOP_DIAMOND_ITEM, {}, DES_WIDTH,DES_HEIGHT)
	self._count  = 1
	self._nameLabel = nil
	self._buyBtn = nil
	self._data = nil
	self._globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
	self:registerListener()
end

function IapShopDiamondItem:dtor()
	self:unRegisterListener()
end

function IapShopDiamondItem:onInitView()
	-- 背景
	local itemBG = UI.Image:create()
	itemBG:init("ui_shopping_paper.png")
	itemBG:centerUp(0)
	self:addChild(itemBG)

	-- 合并支付数量排版
	self._countLayout = UI.Layout:create()
	self._countLayout:init()
	self._countLayout:enableAutoHeight()
	self._countLayout:enableAutoWidth()
	self._countLayout:rightUp(-5, -3)
	self:addChild(self._countLayout)

	--  合并支付数量
	self._countLabel = UI.Image:create()
	self._countLabel:init(string.format(SPRITE_NUMBER_FORMAT, 0))
	self._countLabel:floatRight(1)
	self._countLayout:addComponent(self._countLabel)

	-- 合并支付数量前面的X
	local xImage = UI.Image:create()
	xImage:init("ui_number_x.png")
	xImage:floatRight(0)
	self._countLayout:addComponent(xImage)

	-- 推荐
    self._recommendIcon = UI.Image:create()
    self._recommendIcon:init("ui_shopping_banner_ribbon_3.png")
    self._recommendIcon:leftUp(-1, 0)
    self:addChild(self._recommendIcon)

    -- 推荐文字
    local recommendText = UI.Text:create()
	recommendText:init(UI.TEXT_1170818, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_IAP_DIAMOND_HOT)
	recommendText:leftBottom(-17, 24)
	recommendText:setRotation(-35)
	recommendText:setSize(90, 30)
	recommendText:setTextCenter()
	recommendText:setLineSpacing(-10)
	self._recommendIcon:addChild(recommendText)

	-- new
	self._newIcon = UI.Image:create()
    self._newIcon:init("ui_information_banner_new2.png")
    self._newIcon:leftBottom(257, 183)
    itemBG:addChild(self._newIcon)

	-- 名字
	self._nameLabel = UI.Text:create()
	self._nameLabel:init("",UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	self._nameLabel:rightUp(31, 23)
	self._nameLabel:setWidth(127)
	self._nameLabel:setLineSpacing(-8)
	self._nameLabel:setTextCenter()
	itemBG:addChild(self._nameLabel)

	-- 主图标锚点
	local mainIconAnchor = UI.Component:create()
	mainIconAnchor:init()
	mainIconAnchor:leftBottom(80, 136)
	itemBG:addChild(mainIconAnchor)

	-- 主图标
	self._iconImage = UI.Image:create()
	self._iconImage:init("ui_shopping_icon_diamonds_1.png")
	self._iconImage:center()
	mainIconAnchor:addChild(self._iconImage)

	-- 双倍排版
	self._doubleLayout = UI.Layout:create()
	self._doubleLayout:init()
	self._doubleLayout:enableAutoHeight()
	self._doubleLayout:enableAutoWidth()
	self._doubleLayout:rightBottom(25, 113)
	itemBG:addChild(self._doubleLayout)

	-- 首冲双倍数字
	self._double = UI.Text:create()
	self._double:init("",UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_IAP_DIAMOND_DOUBLE)
	self._double:setTextRight()
	self._double:floatRight(0)
	self._double:setAdditionalKerning(-1)
	self._doubleLayout:addComponent(self._double)

	-- 钻石背景
	local diamondNumLayout = UI.Layout:create()
    diamondNumLayout:init()
    diamondNumLayout:enableAutoWidth()
    diamondNumLayout:enableAutoHeight()
    diamondNumLayout:rightBottom(56, 87)
    itemBG:addChild(diamondNumLayout)

    -- 钻石数量
    self._diamond = UI.Text:create()
    self._diamond:init("0", UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_255_255_255)
    self._diamond:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
    self._diamond:floatRight(0)
    self._diamond:setAdditionalKerning(-1)
    diamondNumLayout:addComponent(self._diamond)

    -- 钻石
    local diamondImage = UI.Image:create()
    diamondImage:init(SPRITE_GAMING_DIAMOND)
    diamondImage:floatRight(5)
    diamondNumLayout:addComponent(diamondImage)

    -- 分割线
    local splitter = UI.Image9:create()
  	splitter:init("ui_scale9image_banner_line_dark.png", CCRectMake(1,0,1,1), cc.size(271, 1))
  	splitter:centerBottom(68)
	self:addChild(splitter)
	  
	-- 公会宝箱图标
	self._guildBoxIcon = UI.Button:create()
	self._guildBoxIcon:init("ui_btn_giftpackage_0.png", "ui_btn_giftpackage_1.png", "ui_btn_giftpackage_0.png")
	self._guildBoxIcon:leftBottom(0, 70)
	self._guildBoxIcon:setSwallowTouches(false)
	self._guildBoxIcon:hide()
	self._guildBoxIcon:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
		self._guildBoxTipsBg:show()
	end)
	self._guildBoxIcon:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
		self._guildBoxTipsBg:hide()
	end)
	self:addChild(self._guildBoxIcon, 10)

	-- 点击图标的标签背景
	self._guildBoxTipsBg = UI.Image9:create()
	self._guildBoxTipsBg:init("ui_scale9image_banner_character2.png", CCRectMake(7, 7, 1, 1), cc.size(0, 0))
	self._guildBoxTipsBg:leftBottom(50, 5)
	self._guildBoxTipsBg:hide()
	self._guildBoxIcon:addChild(self._guildBoxTipsBg)

	-- 点击图标的标签文字
	self._guildBoxTipsText = UI.Text:create()
	self._guildBoxTipsText:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
	self._guildBoxTipsText:setWidth(140)
	self._guildBoxTipsText:setTextHorizontalCenter()
	self._guildBoxTipsText:setTextVerticalCenter()
	self._guildBoxTipsText:center()
    self._guildBoxTipsBg:addChild(self._guildBoxTipsText)
	
	-- 购买按钮
	self._buyBtn = UI.Button:create()
	self._buyBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_2.png")
	self._buyBtn:centerBottom(13)
	self._buyBtn:closeClickScale()
	self._buyBtn:setSwallowTouches(false)
	self._buyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onBuyButton)
	self:addChild(self._buyBtn)

	-- 价钱排版
	self._priceLayout = UI.Layout:create()
	self._priceLayout:init()
	self._priceLayout:center()
	self._priceLayout:enableAutoHeight()
	self._priceLayout:enableAutoWidth()
	self._buyBtn:addChild(self._priceLayout, 100)

	-- 货币图标
	self._currencyIcon = UI.Image:create()
	self._currencyIcon:init(UIUtil:getMoneyPng())
	self._currencyIcon:floatLeft(0)
	self._priceLayout:addComponent(self._currencyIcon)

	-- 价钱文字
	self._priceLabel = UI.Text:create()
	self._priceLabel:init("",UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	self._priceLabel:floatLeft(8)
	self._priceLayout:addComponent(self._priceLabel)

	local mergePay = SdkBox:getInstance():isSupportMergePay()
	if (mergePay or DEVELOPMENT_MODE) and not ServerConfigUtil:isInReview() then
		-- 加按钮
		self._addBtn = UI.Button:create()
		self._addBtn:init("ui_btn_add_0.png","ui_btn_add_1.png","ui_btn_add_2.png")
		self._addBtn:rightBottom(20, 16)
		self._addBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onAddButton)
		self._buyBtn:setSwallowTouches(false)
		self:addChild(self._addBtn, 1000)

		-- 减按钮
		self._subBtn = UI.Button:create()
		self._subBtn:init("ui_btn_minus_0.png","ui_btn_minus_1.png","ui_btn_minus_2.png")
		self._subBtn:leftBottom(20, 16)
		self._subBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onSubButton)
		self._buyBtn:setSwallowTouches(false)
		self:addChild(self._subBtn, 1000)
	end
end

function IapShopDiamondItem:onUpdateView(data)
	if not data then return end
	self._data = data

	-- 设置名字
	self._nameLabel:setText(data.name)

	-- 检查公会宝箱
	local guildBoxes = {}
	for i,item in ipairs(self._data.products) do
		if (math.floor(item.id / 10000) == 2315) then
			local virtualGoodConfig = ConfigManager:getVirtualItemConfigByID(item.id)
			table.insert(guildBoxes, virtualGoodConfig)
		end
	end
	if (#guildBoxes > 0) then
		-- 获取pointValue最大的盒子来展现
		table.sort(guildBoxes, function(a, b) 
			local guildBoxA = ConfigManager:getGuildBoxByID(tonumber(a.value1))
			local guildBoxB = ConfigManager:getGuildBoxByID(tonumber(b.value1))
			if (guildBoxA.pointValue ~= guildBoxB.pointValue) then
				return guildBoxA.pointValue > guildBoxB.pointValue
			end
			return guildBoxA.ID > guildBoxB.ID
		end)
		local guildBoxToShow = guildBoxes[1]

		-- 展现盒子
		self._guildBoxIcon:show()

		-- 更改提示
		local descFormat = LanguageManager:getInstance():getLocalString(1112991) --[["购买本商品将获得%s"]]
		self._guildBoxTipsText:setText(string.format(descFormat, guildBoxToShow.name))
		self._guildBoxTipsText:autoAdapt()

		-- 根据提示更改背景大小
		local textW, textH = self._guildBoxTipsText:getSize()
		self._guildBoxTipsBg:setSize(textW + 10, textH + 10)
	else
		self._guildBoxIcon:hide()
	end

	-- 检测如果有指定价格字符串就使用, 没有就是用默认的
	local SdkManager = require "app.game.SdkManager"
	local priceString = SdkManager:getInstance():getPriceStringFromIapID(data.iapId)
	if (priceString) then
		self._currencyIcon:hide()
		self._priceLabel:setText(priceString)
	else
		-- 货币图标
		self._currencyIcon:show()
		self._currencyIcon:setSpriteName(UIUtil:getMoneyPng())
		-- 设置价钱
		local price = UIUtil:getMoneyPriceStr(data.price / 100)
		self._priceLabel:setText(price)
	end

	-- 是否推荐
	self._recommendIcon:setVisible(data.isHot)
	
	-- 是否新
	self._newIcon:setVisible(self._globalUserData:isNewDiamondIap(data.productID))

	-- 设置主图标
	self._iconImage:setSpriteName(data.icon)

	-- 设置钻石价值
	self._diamond:setText(data.diamond or "")

	-- 处理首充双倍
	local purchased = RoleDataManager:getMaster():getDiamondPurchased() or {}
	local buyNum = 0
	for i,v in ipairs(purchased) do
		if v.productID == data.productID then
			buyNum = v.buyNum
			break
		end
	end
	local givenDiamond = data.givenDiamond or {}
	local given = 0
	local nextNum = 0
	if buyNum + 1 >= table.nums(givenDiamond) then
		nextNum = table.nums(givenDiamond)
	else
		nextNum = buyNum + 1 
	end
	given = checkint(givenDiamond[nextNum])
	self._double:setText(given and "+" .. tostring(given) or "")
	self._doubleLayout:setVisible(given > 0 and not ServerConfigUtil:isInReview())

	-- 刷新价格
	self:refreshCountAndPrice()
end

-- 减去
function IapShopDiamondItem:onSubButton( ... )
	if not self._data then return end
	if self._count <= MIN_COUNT then
		return
	end

	self._newIcon:setVisible(false)
	self._globalUserData:markDiamondIap(self._data.productID)

	self._count = self._count - 1
	self:refreshCountAndPrice()
end

-- 加
function IapShopDiamondItem:onAddButton( ... )
	if not self._data then return end
	if self._count >= MAX_COUNT then
		printInfo("IapShopDiamondItem:onAddButton, 数量已达上限")
		return
	end

	self._newIcon:setVisible(false)
	self._globalUserData:markDiamondIap(self._data.productID)

	self._count = self._count + 1
	self:refreshCountAndPrice()
end

function IapShopDiamondItem:onBuyButton( ... )
	if not self._data then return end

	local mergePay = SdkBox:getInstance():isSupportMergePay()
	printInfo("IapShopDiamondItem:onBuyButton, 是否支持合并支付", mergePay)
	local count = 1;
	if mergePay or DEVELOPMENT_MODE then
		count = self._count
	else
		count = 1
	end
	Avalon.MessageCenter:notice(GameMessage.MC_GET_ORDER_REQ, self._data,count)
	self._newIcon:setVisible(false)
	self._globalUserData:markDiamondIap(self._data.productID)
	Avalon.UserDataManager:saveDataToFile(self._globalUserData:getType())
end

-- 刷新价格和数量
function IapShopDiamondItem:refreshCountAndPrice( ... )
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
	
	
	if not self._subBtn or not self._addBtn then return end
	if self._count <= 1 then
		self._subBtn:disable()
	else
		self._subBtn:enable()
	end
	if self._count >= MAX_COUNT then
		self._addBtn:disable()
	else
		self._addBtn:enable()
	end
end

function IapShopDiamondItem:onPurchaseResult(data)
	if not self._data then return end
	if data.productID == self._data.productID then
		self:onUpdateView(self._data)
	end
end

function IapShopDiamondItem:registerListener( ... )
	Avalon.MessageCenter:bind(GameMessage.MC_PURCHASE_SUCCESS, self,self.onPurchaseResult)
end

function IapShopDiamondItem:unRegisterListener( ... )
	Avalon.MessageCenter:unbind(GameMessage.MC_PURCHASE_SUCCESS, self,self.onPurchaseResult)
end

return IapShopDiamondItem