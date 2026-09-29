--
-- Author: yueyingsong
-- Date: 2017-11-22 11:21:33
--
local SdkBox = require("utils.sdkbox.SdkBox")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}
local IapShopBoxItem = class("IapShopBoxItem",UI.HWBtnComponent)
UI.IapShopBoxItem = IapShopBoxItem

local SPRITE_GAMING_DIAMOND = "symbol_gaming_diamond.png"

local DES_WIDTH = 202
local DES_HEIGHT = 288
local MAX_COUNT = 9 -- 单次购买最大数量
local MIN_COUNT = 1 -- 单次购买最小数量

function IapShopBoxItem:ctor(sourceType)
	IapShopBoxItem.super.ctor(self, UIType.IAP_SHOP_BOX_ITEM, {}, DES_WIDTH, DES_HEIGHT)
	self._count  = 1
	self._nameLabel = nil
	self._countLabel = nil
	self._buyBtn = nil
	self._data = nil
	self._isOpen = true
	self._isClose = false
	self._sourceType = sourceType
	self._globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
	self:registerListener()
	
end

function IapShopBoxItem:dtor()
	self:unRegisterListener()
end

function IapShopBoxItem:onInitView()
	-- 背景
	self._itemBG = UI.Image:create()
	self._itemBG:init("ui_shopping_banner_box.png")
	self._itemBG:centerUp(0)
	self._itemBG:setTouchEnable(true)
	self._itemBG:setInterceptTouches(false)
	self._itemBG:setSwallowTouches(false)
	self._itemBG:addEventListener(UI.Event.COMPONENT_CLICK, self, self.onShowDetails)
	self:addChild(self._itemBG)

	-- 推荐
    self._recommendIcon = UI.Image:create()
    self._recommendIcon:init("ui_shopping_banner_ribbon_4.png")
    self._recommendIcon:leftUp(2, 1.5)
    self:addChild(self._recommendIcon)

    -- 推荐文字
    local recommendText = UI.Text:create()
	recommendText:init(UI.TEXT_1170818,UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_IAP_BOX_HOT)
	recommendText:leftBottom(-24, 13)
	recommendText:setRotation(-35)
	recommendText:setSize(90, 30)
	recommendText:setLineSpacing(-10)
	recommendText:setTextCenter()
	self._recommendIcon:addChild(recommendText)

	-- new
	self._newIcon = UI.Image:create()
    self._newIcon:init("ui_information_banner_new2.png")
    self._newIcon:leftBottom(120, 139)
    self._itemBG:addChild(self._newIcon, 2)

	-- 名字
	self._nameLabel = UI.Text:create()
	self._nameLabel:init("",UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	self._nameLabel:centerUp(6)
	self._nameLabel:setLineSpacing(-8)
	self._nameLabel:setWidth(153)
	self._nameLabel:setTextCenter()
	self._itemBG:addChild(self._nameLabel)

	-- 限购文字
	self._litmitSaleText = UI.Text:create()
	self._litmitSaleText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
	self._litmitSaleText:setTextCenter()
	self._litmitSaleText:centerUp(42)
	self._itemBG:addChild(self._litmitSaleText)

	-- 主图标
	self._iconImage = UI.Image:create()
	self._iconImage:init("ui_shopping_icon_giftbox_2.png")
	self._iconImage:centerBottom(54)
	self._itemBG:addChild(self._iconImage)

	-- 公会宝箱图标
	self._guildBoxIcon = UI.Button:create()
	self._guildBoxIcon:init("ui_btn_giftpackage_0.png", "ui_btn_giftpackage_1.png", "ui_btn_giftpackage_0.png")
	self._guildBoxIcon:leftBottom(0, 52)
	-- self._guildBoxIcon:setSwallowTouches(false)
	self._guildBoxIcon:hide()
	self._guildBoxIcon:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
		self._guildBoxTipsBg:show()
	end)
	self._guildBoxIcon:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
		self._guildBoxTipsBg:hide()
	end)
	self._itemBG:addChild(self._guildBoxIcon, 10)

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

    -- 剩余数量
	self._maxNumLabel = UI.Text:create()
	self._maxNumLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
	self._maxNumLabel:setTextCenter()
	self._maxNumLabel:centerUp(194)
	self._itemBG:addChild(self._maxNumLabel)

	-- 购买按钮
	self._buyBtn = UI.Button:create()
	self._buyBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
	self._buyBtn:leftBottom(-1.5, 0)
	self._buyBtn:closeClickScale()
	self._buyBtn:setSwallowTouches(false)
	self._buyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onShowDetails)
	-- self._buyBtn:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, self.onTouchEnded) 
	self:addChild(self._buyBtn)

	-- 价钱排版
	self._priceLayout = UI.Layout:create()
	self._priceLayout:init()
	self._priceLayout:center()
	self._priceLayout:enableAutoHeight()
	self._priceLayout:enableAutoWidth()
	self._buyBtn:addChild(self._priceLayout, 100)

	-- 货币标签
	self._currencyIcon = UI.Image:create()
	self._currencyIcon:init(SPRITE_GAMING_DIAMOND)
    self._currencyIcon:floatLeft(0)
	self._priceLayout:addComponent(self._currencyIcon)

	-- 价钱文字
	self._priceLabel = UI.Text:create()
	self._priceLabel:init("",UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	self._priceLabel:floatLeft(8)
	self._priceLayout:addComponent(self._priceLabel)

	-- 倒计时图标
	local clockLayout = UI.Layout:create()
	clockLayout:init()
	clockLayout:enableAutoWidth()
	clockLayout:enableAutoHeight()
	clockLayout:centerBottom(-2)
	self._itemBG:addChild(clockLayout)

	-- 倒计时标签
	self._clock = AvalonUtil.createClockAnimation()
    self._clock:floatLeft(-5)
    clockLayout:addComponent(self._clock)

	-- 倒计时
	self._countDownLabel = UI.Text:create()
	self._countDownLabel:init("00:00:00",UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
	self._countDownLabel:floatLeft(-4)
	clockLayout:addComponent(self._countDownLabel)

	-- 限制遮罩(售罄, 时间限购)
	self._mask = UI.Image:create()
    self._mask:init("ui_shopping_banner_box_black.png")
    self._mask:centerUp(0)
    self:addChild(self._mask)

    -- 遮罩倒计时图标
    self._clock2 = AvalonUtil.createClockAnimation()
    self._clock2:center(-35, 10)
    self._clock2:setVisible(false)
    self._mask:addChild(self._clock2)

	-- 遮罩倒计时文字
	self._countDownLabel2 = UI.Text:create()
	self._countDownLabel2:init("00:00:00", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_231_231_231)
	self._countDownLabel2:center(5, 9)
	self._mask:addChild(self._countDownLabel2)

	-- 遮罩限购条件文字
	self._selfLimitLabel = UI.Text:create()
	self._selfLimitLabel:init("",UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_231_231_231)
	self._selfLimitLabel:setDimensions(182, 0)
	self._selfLimitLabel:setTextCenter()
	self._selfLimitLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
	self._selfLimitLabel:center()
	self._mask:addChild(self._selfLimitLabel)
end

function IapShopBoxItem:setInnerItemsTouchEnabled(b)
	self._itemBG:setTouchEnable(b)
	self._buyBtn:setTouchEnable(b)
end

function IapShopBoxItem:onUpdateView(data)
	if not data then return end
	self._data = data

	-- 初始化文字
	self._litmitSaleText:setText("")
	self._maxNumLabel:setText("")
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

	-- 更新价标
	self._priceLabel:setFontColor(UI.FONT_COLOR_50_50_44)
	local isDiamondPrice = data.currencyType == PublicDefine.PurchaseCurrencyType.PurchaseCurrencyType_Diamond
    if isDiamondPrice then
    	local heroData = RoleDataManager:getMaster()
    	if not Avalon.MathUtil:checkDiamonEnough(data.price, heroData:getDiamond()) then
    		self._priceLabel:setFontColor(UI.FONT_COLOR_219_35_45)
    	else
    		self._priceLabel:setFontColor(UI.FONT_COLOR_50_50_44)
    	end
    	self._currencyIcon:show()
    	self._priceLabel:setText(tostring(data.price))
    	self._currencyIcon:setSpriteName(SPRITE_GAMING_DIAMOND)
	else
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
	end
    self._priceLayout:updateView()

	-- 是否推荐
	self._recommendIcon:setVisible(data.isHot)
	self._iconImage:setSpriteName(data.icon)

	-- 是否新
	self._newIcon:setVisible(self._globalUserData:isNewDiamondIap(data.productID))

	-- 更新已经购买信息
	local purchaseData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.PURCHASE, GameDataManager:getInstance():getSaveUserKey())
	local products = purchaseData:getProducts()
	local limitedType = data.limitedType
	local limitedNum = data.limitedNum
	local buyNum = 0;
	for i,v in ipairs(products) do
		if v.productID == data.productID then
			-- printInfo("找到了")
			
			buyNum = v.boughtNum
			-- printInfo("limitedNum",data.productID, limitedNum,buyNum, data.currencyType)
			break
		end
	end
	
	-- if data.boughtNum then
	-- 	buyNum = data.boughtNum
	-- else
	-- 	print("数据异常 ",data.name)
	-- end
	-- 每日限购
	if limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Daily  then
		if limitedNum - buyNum > 0 then
			self._litmitSaleText:setText(UI.TEXT_1170823..": "..(limitedNum - buyNum))
		else
			self._litmitSaleText:setText(UI.TEXT_1170854)
		end
	-- 每周限购
	elseif limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Weekly  then
		if limitedNum - buyNum > 0 then
			self._litmitSaleText:setText(UI.TEXT_1170822..": "..(limitedNum - buyNum))
		else
			self._litmitSaleText:setText(UI.TEXT_1170824)
		end
	-- 角色限购
	elseif limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Total  then
		if limitedNum - buyNum > 0 then
			self._litmitSaleText:setText(LanguageManager:getInstance():getLocalString(1111561)..": "..(limitedNum - buyNum))
		else
			self._litmitSaleText:setText(UI.TEXT_1170826)
		end
	end

	-- print("data.saleNum - data.buyNum",data.productID,limitedType,data.saleNum,data.saleNum - data.buyNum)
	-- print(data.name,data.saleNum,data.buyNum)
	-- 如果大于0  说明有服务器总数限购，显示剩余的
	-- 可购买的 减去 已经卖出去的
	if data.saleNum > 0 then
		if data.saleNum - data.buyNum > 0 then
			self._maxNumLabel:setText(string.format(UI.TEXT_1170825, data.saleNum - data.buyNum))
		else
			self._litmitSaleText:setText(UI.TEXT_1170826)
			self._maxNumLabel:setText("")
		end
	end

	-- 判断条件
	-- 购买限制类型
	local heroData = RoleDataManager:getMaster()
	local buyLimit = data.buyLimit
	local allDone = true;
	local str = ""

	print(" buyLimit =========  ",buyLimit)

	for i,v in ipairs(buyLimit) do
		local conditionValue = v.conditionValue
		--等级限制
		if v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_Level then
			if heroData:getLevel() < conditionValue then
				allDone = false;
				str = str..string.format(UI.TEXT_1170827,conditionValue).."\n"
			end
		--洞窟层数限制
		elseif v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_Cave then
			--到达指定层数(模式难度层数复合字段)
			-- 探索XX难度洞窟YY层：   01:01:1001  模式:难度:层数
			-- 参与大秘境XX层：
			local caveMode = 1
			local diffculty = 1
			local level = 23
			local value = checkint(conditionValue)
			-- caveMode = math.modf(value/1000000)
			-- value = value - 1000000 * caveMode
			-- diffculty = math.modf(value/10000)
			-- value = value - 10000 * diffculty    
			-- level = value

			caveMode = math.modf(value/10000)
			value = value - 10000 * caveMode
			diffculty = math.modf(value/100)
			value = value - 100 * diffculty
			level = value * 10

			print(" conditionValue =========  ",conditionValue, caveMode,diffculty,level)
			

			local modeStr = ToolsUtil:getModeStr(caveMode)
			local levelStr = tostring(level)
			local diffcultyStr = ToolsUtil:getDiffcultyStr(diffculty)
			-- print("UI.TEXT_1170828",UI.TEXT_1170828)
			-- -- titleStr = string.format(LanguageManager:getInstance():getLocalString(1271030), modeStr, levelStr, diffcultyStr)
			-- -- print("titleStr",titleStr)
			-- TODO 这里需要和策划确认一下难度(done 根据服务器传的判断)
			local maxLevelData = heroData:getMaxLevelData(PublicDefine.CAVE_MODE.MODE_NORMAL, diffculty)
			if(maxLevelData == nil or maxLevelData:getMaxLevel() < level) then
				allDone = false;
				str = str..string.format(UI.TEXT_1170828,modeStr,diffcultyStr,levelStr).."\n"
			end 
			
		--装备评分限制
		elseif v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_EquipScore then
			if heroData:getCombatScore() < conditionValue then
				allDone = false;
				str = str..string.format(UI.TEXT_1170829,conditionValue).."\n"
			end
		--大秘境历史最高层数限制
		elseif v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_Dungeon then
			local caveMode = 1
			local diffculty = 1
			local level = 23
			local value = checkint(conditionValue)
			caveMode = math.modf(value/1000000)
			value = value - 1000000 * caveMode
			diffculty = math.modf(value/10000)
			value = value - 10000 * diffculty    
			level = value

			local maxLevelData = heroData:getMaxLevelData(PublicDefine.CAVE_MODE.MODE_DUNGEON, diffculty)
			if(maxLevelData == nil or maxLevelData:getMaxLevel() < level) then
				allDone = false;
				str = str..string.format(UI.TEXT_1170830,level).."\n"
			end
			
		--成就点数限制
		elseif v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_Achievement then
			if heroData:getAchievementPoint() < conditionValue then
				allDone = false;
				str = str..string.format(UI.TEXT_1170831,conditionValue).."\n"
			end
		--公会贡献捐献点数限制 
		elseif v.conditionType == PublicDefine.PurchaseConditionType.PurchaseConditionType_GuildContrib then
			local guildData = MasterDataManager:getGuildData()
			if(guildData == nil or guildData:getContib() < conditionValue) then
				allDone = false;
				str = str..string.format(UI.TEXT_1170832,conditionValue).."\n"
			end
		end
	end
	-- print("data.startTimeSec",data.startTimeSec,GameManager:getNormalServerTime())
	local endTime = data.endTimeSec
	local curTime = GameManager:getNormalServerTime()
	local startTime = data.startTimeSec
	if startTime > curTime then
		self._isOpen = false;
		allDone = false
		self._clock2:setVisible(true)
		self._countDownLabel:setVisible(false)
		self._clock:setVisible(false)
		self._countDownLabel2:setVisible(true)
	else
		self._isOpen = true;
		self._clock2:setVisible(false)
		self._countDownLabel2:setVisible(false)
		-- 说明限时出售
		if endTime > 0 then
			self._countDownLabel:setVisible(true)
			self._clock:setVisible(true)
		else
			self._countDownLabel:setVisible(false)
			self._clock:setVisible(false)
		end
	end

	-- 设置组件状态
	self._mask:setVisible(not allDone)
	self._selfLimitLabel:setText(str)
	if (allDone) then
		self._buyBtn:enable()
	else
		self._buyBtn:disable()
	end

	-- 洞内无法购买
	if (allDone and not SceneManager:getInstance():isNotInFightScene()) then
		-- 暂时不显示遮罩
		self._mask:setVisible(false)
		self._selfLimitLabel:setText(UI.TEXT_1170842)
		self._clock:setVisible(false)
		self._countDownLabel:setVisible(false)
		self._clock2:setVisible(false)
		self._countDownLabel2:setVisible(false)
		self._buyBtn:disable()
		allDone = false
	end

	self._data.allDone = allDone

	self:schedulerCountDown(0)
end

-- 倒计时
function IapShopBoxItem:schedulerCountDown(dt)
	if not self._data then return end
	-- 不在城镇不显示倒计时
	if not SceneManager:getInstance():isNotInFightScene() then
		return
	end
	local endTime = self._data.endTimeSec
	local curTime = GameManager:getNormalServerTime()
	local startTime = self._data.startTimeSec
	if startTime > curTime then
		self._selfLimitLabel:setText(UI.TEXT_1170846.."\n")
		self._countDownLabel2:setText(AvalonUtil:getFullFormatTime(self._data.startTimeSec,true))
	else
		-- 初始化状态如果是还没到开启时间,现在到了。刷新下界面
		if not self._isOpen then
			printInfo("开启售卖时间到,刷新界面")
			self._isOpen = true
			self:onUpdateView(self._data)
		-- 初始化状态如果是已经开启的,需要判断是否已经结束,如果结束,需要删除
		else
			
		end
		-- 说明限时出售
		if endTime > 0 then
			if endTime < curTime then
				if not self._isClose then
					self._isClose = true
					printInfo("售卖结束时间到,通知移除")
					Avalon.MessageCenter:notice(GameMessage.MC_PRODUCT_NEED_REMOVE, self._data.productID,self)
				end
				return
			end
			self._countDownLabel:setText(AvalonUtil:getFullFormatTime(self._data.endTimeSec, true))
		end
	end
	
end

-- 显示详情
function IapShopBoxItem:onShowDetails(_,location)
	--print("onShowDetails:", self._disableShowDetail)
	if not self._data then
		return
	end
	-- print("pos",pos)
	local parent = self:getParent()
	while parent do
		-- print("类型 ",tolua.type(parent))
		if tolua.type(parent) == "cc.TableView" then
			-- local location = touch:getLocation()
			local point = parent:convertToWorldSpace(cc.p(0,0))
			local size = parent:getViewSize()
			local rect = cc.rect(point.x, point.y, size.width, size.height)
			if not AvalonUtil:isRectContainsPoint(parent, location) then
				return
			end 
		end
		parent = parent:getParent()
	end

	self._globalUserData:markDiamondIap(self._data.productID)
	Avalon.MessageCenter:notice(GameMessage.MC_IAPSHOP_SHOW_DETAILS, self._data,self)
	Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 2, self._data.productID, nil, self._sourceType)
	self._newIcon:setVisible(false)
	Avalon.UserDataManager:saveDataToFile(self._globalUserData:getType());
end

function IapShopBoxItem:refreshProducts(params)
	local isSingle = params.isSingle
	if not isSingle then return end
	if not self._data then return end
	local data = params.infos or {}
	local find = false
	for i,v in ipairs(data) do
		if v.productID == self._data.productID then
			find = true
			self._data.saleNum = v.saleNum
			self._data.buyNum = v.buyNum
			break
		end
	end
	if find then
		self:onUpdateView(self._data)
	end
	
end

function IapShopBoxItem:onPaySucc(productID)
	if not self._data then
		return
	end
	if productID == self._data.productID then
		local purchaseData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.PURCHASE, GameDataManager:getInstance():getSaveUserKey())
		local products = purchaseData:getProducts()
		local item = self._data
		local limitedNum = item.limitedNum
		local limitedType = item.limitedType
		local buyNum = 0;
		for i,v in ipairs(products) do
			if v.productID == item.productID then
				buyNum = v.boughtNum
				break
			end
		end
		
		-- 角色个人限购的
		if ((limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Daily  
			or limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Weekly
			or limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Total
			) and limitedNum - buyNum <= 0 and item.hideWhenSoldOut == true) 
		-- 服务器总数量限购 可购买的 减去 已经卖出去的
		or (item.saleNum > 0 and item.saleNum - item.buyNum <= 0 and item.hideWhenSoldOut == true)
			then
				Avalon.MessageCenter:notice(GameMessage.MC_UPDATE_IAPBOX_LAYER,{},self)
			return;
		end
		self:onUpdateView(self._data)
	end
   
end

function IapShopBoxItem:registerListener()
	Avalon.MessageCenter:bind(GameMessage.MC_SDK_PURCHASE_SUCC, self,self.onPaySucc)
	Avalon.MessageCenter:bind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.refreshProducts)
end

function IapShopBoxItem:unRegisterListener()
	Avalon.MessageCenter:unbind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.refreshProducts)
	Avalon.MessageCenter:unbind(GameMessage.MC_SDK_PURCHASE_SUCC, self,self.onPaySucc)
end

return IapShopBoxItem