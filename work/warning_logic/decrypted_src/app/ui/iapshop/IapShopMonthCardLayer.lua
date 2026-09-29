--
-- Author: yueyingsong
-- Date: 2017-11-20 17:44:38
-- Using: 内购商城界面内的砖石购买界面
require "app.ui.iapshop.IapShopDiamondCell"
require "app.ui.common.Dialog.ScrollBar" 

local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require "utils.ProtobufUtil"
local SdkManager = require "app.game.SdkManager"
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local IapShopMonthCardLayer = class("IapShopMonthCardLayer",UI.HWBtnComponent)
UI.IapShopMonthCardLayer = IapShopMonthCardLayer

local SPRITE_GAMING_DIAMOND = "symbol_gaming_diamond.png"

local RES_LIST = {
}

local DES_WIDTH = 1136
local DES_HEIGHT = 574
local BG_MIDDLE_POS = 153.5

function IapShopMonthCardLayer:ctor(sourceType)
	self._buyOnceData = nil
	self._subData = nil
	self._lifeTimeMemberData = nil
	self._globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
	self._sourceType = sourceType
	IapShopMonthCardLayer.super.ctor(self, UIType.IAP_SHOP_MONTH_CARD_LAYER, RES_LIST, DES_WIDTH, DES_HEIGHT)
	self:registerListener()
	Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 3, nil, nil, self._sourceType)
end

function IapShopMonthCardLayer:dtor()
	self:unRegisterListener()
	reload_script_file("app.ui.iapshop.IapShopMonthCardLayer")
end

function IapShopMonthCardLayer:onInitView()
	self:initLeftNode()
	self:initRightNode()
	self:supplyStatusRefresh()
end

function IapShopMonthCardLayer:initLeftNode()
	if self._leftBg ~= nil then
		self._leftBg:removeFromParent()
	end

	--月卡背景
	self._leftBg = UI.Image:create();
	self._leftBg:init("ui_shopping_banner_box2.png")
	self._leftBg:leftBottom(199, 200)
	self:addChild(self._leftBg)

	--标题
	local title = UI.Text:create()
	title:init(UI.TEXT_1212004, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
	title:centerUp(12)
	self._leftBg:addChild(title)

	--月卡特效
	self._monthlySFX = UI.Animation:create()
	self._monthlySFX:init("effect_ui_common_settlement_jinbi.json", "effect_ui_common_settlement_jinbi.atlas")
	self._monthlySFX:center(10, -40)
	self._monthlySFX:setScale(5)
	self._leftBg:addChild(self._monthlySFX)

	--月卡图标
	self._monthlyIcon = UI.Image:create()
	self._monthlyIcon:init("ui_shopping_icon_month.png")
	self._monthlyIcon:centerUp(60)
	self._leftBg:addChild(self._monthlyIcon)

	-- 领取按钮
	self._monthlyGetSupplyButton = UI.Button:create()
	self._monthlyGetSupplyButton:init("ui_btn_yellow10_0.png", "ui_btn_yellow10_1.png", "ui_btn_yellow10_2.png", cc.p(0, -2))
	self._monthlyGetSupplyButton:centerUp(115)
	self._monthlyGetSupplyButton:setTextFont(UI.FONT_STANDARD, 18, {r = 41, g = 41, b = 45})
	self._monthlyGetSupplyButton:setText(LanguageManager:getInstance():getLocalString(1112117) --[["领取"]])
	self._monthlyGetSupplyButton:setTextOffset(0, 5)
	self._monthlyGetSupplyButton:setInterval(1)
	self._monthlyGetSupplyButton:hide()
	self._monthlyGetSupplyButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.monthlySupplyButtonClick)
	self._leftBg:addChild(self._monthlyGetSupplyButton, 10000)

	-- 月卡领取红点
	self._monthCardStatus = AvalonUtil.createRedPoint(self._monthlyGetSupplyButton, -5, 20)
	self:refreshRedPoint()

	--描述
	local detailLayout = UI.Layout:create()
	detailLayout:init()

	local width = 220
	local maxHeight = 86
	local height = 0
	local initStartX = 22
	local paddingY = 5

	-- 获取的钻石
	local startX = initStartX
	local getDiamondLayout = self:createOneCell()
	getDiamondLayout:centerUp(height)
	detailLayout:addChild(getDiamondLayout)

	local info = UI.Text:create()
	info:init(UI.TEXT_1212600, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:centerLeft(startX)
	getDiamondLayout:addChild(info)
	startX = startX + info:getContentSize().width + 14

	local image = UI.Image:create()
	image:init(SPRITE_GAMING_DIAMOND)
	image:centerLeft(startX)
	getDiamondLayout:addChild(image)
	startX = startX + image:getContentSize().width + 4

	local info = UI.Text:create()
	info:init(string.format("%s", ConfigManager:getMonthCardReward()), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:centerLeft(startX)
	getDiamondLayout:addChild(info)
	getDiamondLayout:setSize(width, info:getContentSize().height)
	height = info:getContentSize().height + paddingY

	-- 每日领取
	startX = initStartX
	local everyDayLayout = self:createOneCell()
	everyDayLayout:centerUp(height)
	detailLayout:addChild(everyDayLayout)

	local info = UI.Text:create()
	info:init(UI.TEXT_1212601, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:centerLeft(startX)
	everyDayLayout:addChild(info)
	startX = startX + info:getContentSize().width + 14

	local image = UI.Image:create()
	image:init(SPRITE_GAMING_DIAMOND)
	image:centerLeft(startX)
	everyDayLayout:addChild(image)
	startX = startX + image:getContentSize().width + 4

	local info = UI.Text:create()
	info:init(string.format("%s", ConfigManager:getMonthCardBonus()), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:centerLeft(startX)
	everyDayLayout:addChild(info)
	height = height + info:getContentSize().height  + paddingY
	everyDayLayout:setSize(width, info:getContentSize().height)

	-- 下洞效果
	startX = initStartX
	local offsetY = 0
	local expeditionLayout = self:createOneCell()
	expeditionLayout:centerUp(height)
	detailLayout:addChild(expeditionLayout)

	local info = UI.Text:create()
	info:init(LanguageManager:getInstance():getLocalString(1113266), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:leftUp(startX, 0)
	expeditionLayout:addChild(info)
	offsetY = info:getContentSize().height + 3

	-- 下洞效果详细文字
	startX = 15
	local monthlyCardExplorationtips = ConfigManager:getGeneralForKey("monthlyCardExplorationtips")
	local monthlyCardExplorationtipsArr = string.split(monthlyCardExplorationtips, ";")
	if(monthlyCardExplorationtipsArr and #monthlyCardExplorationtipsArr == 2) then
		local image = UI.Image:create()
		image:init("symbol_gaming_money.png")
		image:leftUp(startX, offsetY)
		expeditionLayout:addChild(image)
		startX = startX + image:getContentSize().width + 4

		local info = UI.Text:create()
		info:init(string.format("+%s", string.format("%.1f", (tonumber(monthlyCardExplorationtipsArr[1])*100)/RATIO_NUMBER) .."%" ), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_15_85_71);
		info:leftUp(startX, offsetY)
		expeditionLayout:addChild(info)
		startX = startX + info:getContentSize().width + 20

		local image = UI.Image:create()
		image:init("symbol_gaming_xp.png")
		image:leftUp(startX, offsetY)
		expeditionLayout:addChild(image)
		startX = startX + image:getContentSize().width + 4

		local info = UI.Text:create()
		info:init(string.format("+%s", string.format("%.1f", (tonumber(monthlyCardExplorationtipsArr[2])*100)/RATIO_NUMBER) .."%" ), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_15_85_71);
		info:leftUp(startX, offsetY)
		expeditionLayout:addChild(info)
		startX = startX + info:getContentSize().width + 20
		offsetY = offsetY + info:getContentSize().height + 3
		expeditionLayout:setSize(width, offsetY)

		height = height + offsetY
	else
		expeditionLayout:hide()
	end

	-- 探险效果
	startX = initStartX
	local offsetY = 0
	local expeditionLayout = self:createOneCell()
	expeditionLayout:centerUp(height)
	detailLayout:addChild(expeditionLayout)

	local info = UI.Text:create()
	info:init(UI.TEXT_1212602, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:leftUp(startX, 0)
	expeditionLayout:addChild(info)
	offsetY = info:getContentSize().height + 3

	-- 探险效果详细文字
	startX = 15
	local expeditionCoinincome = ConfigManager:getGeneralForKey("ExpeditionCoinincome")
	local rewardArr = string.split(expeditionCoinincome, ";")

	if(rewardArr and #rewardArr) then
		local image = UI.Image:create()
		image:init("symbol_gaming_money.png")
		image:leftUp(startX, offsetY)
		expeditionLayout:addChild(image)
		startX = startX + image:getContentSize().width + 4

		local info = UI.Text:create()
		info:init(string.format("+%s", string.format("%.1f", (tonumber(rewardArr[1])*100)/RATIO_NUMBER) .."%" ), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_15_85_71);
		info:leftUp(startX, offsetY)
		expeditionLayout:addChild(info)
		startX = startX + info:getContentSize().width + 20

		local image = UI.Image:create()
		image:init("symbol_gaming_xp.png")
		image:leftUp(startX, offsetY)
		expeditionLayout:addChild(image)
		startX = startX + image:getContentSize().width + 4

		local info = UI.Text:create()
		info:init(string.format("+%s", string.format("%.1f", (tonumber(rewardArr[2])*100)/RATIO_NUMBER) .."%" ), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_15_85_71);
		info:leftUp(startX, offsetY)
		expeditionLayout:addChild(info)
		startX = startX + info:getContentSize().width + 20
		offsetY = offsetY + info:getContentSize().height + 3
		expeditionLayout:setSize(width, offsetY)
	end
	height = height + offsetY
	detailLayout:setSize(220, height)


	if(height < 110) then 
		detailLayout:centerUp(185)
		self._leftBg:addChild(detailLayout)
	else 
		local scrollView = UI.ScrollView:create()
		scrollView:setSize(width, 100)
		scrollView:init()
		scrollView:centerUp(185)
		scrollView:addInnerNode(detailLayout)
		scrollView:setScrollBarEnabled(true)
		scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
		scrollView:setCircleVisible(false)
		scrollView:setScrollBarWidth(5)
		self._leftBg:addChild(scrollView)

		-- 首次标签
		local mask = UI.Image:create()
		mask:init("ui_shopping_banner_shelter.png")
		mask:centerBottom(0)
		scrollView:addChild(mask, 1000)
	end

	-- 公会宝箱图标
	self._guildBoxIcon = UI.Button:create()
	self._guildBoxIcon:init("ui_btn_giftpackage_0.png", "ui_btn_giftpackage_1.png", "ui_btn_giftpackage_0.png")
	self._guildBoxIcon:leftBottom(26,137)
	self._guildBoxIcon:setSwallowTouches(false)
	self._guildBoxIcon:hide()
	self._guildBoxIcon:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
		self._guildBoxTipsBg:show()
	end)
	self._guildBoxIcon:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
		self._guildBoxTipsBg:hide()
	end)
	self._leftBg:addChild(self._guildBoxIcon, 10)

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

	-- 按钮排版
	self._buttonLayout = UI.Layout:create()
	self._buttonLayout:init(0, 0, -3, 0)
	self._buttonLayout:leftUp(52, 318)
	self._buttonLayout:setSize(188, 0)
	self._buttonLayout:enableAutoHeight()
	self._leftBg:addChild(self._buttonLayout)

	-- 可取消提示
	self._cancelAnytimeLabel = UI.Text:create()
	self._cancelAnytimeLabel:init(LanguageManager:getInstance():getLocalString(1113271) --[["可随时取消"]],UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 155, g = 155, b = 155})
	self._cancelAnytimeLabel:floatUp(3)
	self._buttonLayout:addComponent(self._cancelAnytimeLabel)

	-- 购买订阅按钮
	self._subButton = UI.Button:create()
	self._subButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png", cc.p(0, -2))
	self._subButton:floatUp(3)
	self._subButton:setInterval(1)
	self._subButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.buySubButtonClick)
	self._buttonLayout:addComponent(self._subButton)

	-- 首次标签
	self._firstTimeSubFlag = UI.Image:create()
	self._firstTimeSubFlag:init("ui_shopping_banner_ribbon_5.png")
	self._firstTimeSubFlag:leftUp(0, 0)
	self._subButton:addChild(self._firstTimeSubFlag, 1000)

	-- 首次文字
	local firstTimeSubText = UI.Text:create()
	firstTimeSubText:init(LanguageManager:getInstance():getLocalString(1113265) --[[首次!]],UI.FONT_BOLD, UI.FONT_SIZE_216PX, {r = 255, g = 186, b = 96})
	firstTimeSubText:center(-7, -7)
	firstTimeSubText:setRotation(-45)
	self._firstTimeSubFlag:addChild(firstTimeSubText)

    -- 价钱排版
	self._subPriceLayout = UI.Layout:create()
	self._subPriceLayout:init()
	self._subPriceLayout:center()
	self._subPriceLayout:enableAutoHeight()
	self._subPriceLayout:enableAutoWidth()
	self._subButton:addChild(self._subPriceLayout, 100)

	-- 描述文字
	local subPriceLabel = UI.Text:create()
	subPriceLabel:init(LanguageManager:getInstance():getLocalString(1113262)--[["连续包月"]],UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	subPriceLabel:floatLeft(0)
	self._subPriceLayout:addComponent(subPriceLabel)

	-- 货币图标
	self._subCurrencyIcon = UI.Image:create()
	self._subCurrencyIcon:init(SPRITE_GAMING_RMB)
	self._subCurrencyIcon:floatLeft(15)
	self._subPriceLayout:addComponent(self._subCurrencyIcon)

	-- 价钱文字排版
	self._subPriceTextLayout = UI.Layout:create()
	self._subPriceTextLayout:init(0, 0, 2, 0)
	self._subPriceTextLayout:floatLeft(5)
	self._subPriceTextLayout:enableAutoHeight()
	self._subPriceTextLayout:enableAutoWidth()
	self._subPriceLayout:addComponent(self._subPriceTextLayout)
	
	-- 原价文字
	self._subOriPriceLabel = UI.Text:create()
	self._subOriPriceLabel:init("0",UI.SYS_FONT, UI.FONT_SIZE_16PX, {r = 106, g = 80, b = 32})
	self._subOriPriceLabel:floatUp(-2)
	self._subPriceTextLayout:addComponent(self._subOriPriceLabel)
	
	-- 红线
	self._oriPriceRedLine = UI.Image9:create()
	self._oriPriceRedLine:init("ui_scale9image_red.png", CCRectMake(0,0,1,1), cc.size(self._subOriPriceLabel._width + 5, 2.5))
	self._oriPriceRedLine:setRotation(-7)
	self._oriPriceRedLine:center()
	self._subOriPriceLabel:addChild(self._oriPriceRedLine)

	-- 价钱文字
	self._subPriceLabel = UI.Text:create()
	self._subPriceLabel:init("",UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	self._subPriceLabel:floatUp(-2)
	self._subPriceTextLayout:addComponent(self._subPriceLabel)

	-- 剩余时间提示
	self._timeLeftLabel = UI.Text:create()
	self._timeLeftLabel:init("",UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 155, g = 155, b = 155})
	self._timeLeftLabel:floatUp(3)
	self._buttonLayout:addComponent(self._timeLeftLabel)

	-- 购买一次按钮
	self._buyOnceButton = UI.Button:create()
    self._buyOnceButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png", cc.p(0, -2))
	self._buyOnceButton:floatUp(3)
	self._buyOnceButton:setInterval(1)
	self._buyOnceButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.buyOnceButtonClick)
	self._buttonLayout:addComponent(self._buyOnceButton)
    
    -- 购买一次价钱排版
	self._buyOncePriceLayout = UI.Layout:create()
	self._buyOncePriceLayout:init()
	self._buyOncePriceLayout:center()
	self._buyOncePriceLayout:enableAutoHeight()
	self._buyOncePriceLayout:enableAutoWidth()
	self._buyOnceButton:addChild(self._buyOncePriceLayout, 100)

	-- 描述文字
	local buyOncePriceLabel = UI.Text:create()
	buyOncePriceLabel:init(LanguageManager:getInstance():getLocalString(1113263)--[["单月购买"]],UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	buyOncePriceLabel:floatLeft(0)
	self._buyOncePriceLayout:addComponent(buyOncePriceLabel)

	-- 购买一次货币图标
	self._buyOnceCurrencyIcon = UI.Image:create()
	self._buyOnceCurrencyIcon:init(SPRITE_GAMING_RMB)
	self._buyOnceCurrencyIcon:floatLeft(15)
	self._buyOncePriceLayout:addComponent(self._buyOnceCurrencyIcon)

	-- 购买一次价钱文字
	self._buyOncePriceLabel = UI.Text:create()
	self._buyOncePriceLabel:init("",UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	self._buyOncePriceLabel:floatLeft(5)
	self._buyOncePriceLayout:addComponent(self._buyOncePriceLabel)

	-- 更新一次按钮
	self:updateBuyOnceButton()
	self:updateSubButton()
end

function IapShopMonthCardLayer:createOneCell()
	local cell = UI.Layout:create()
	cell:init()    
	cell:setSize(220, 0)
	local picDes = UI.Image:create()
	picDes:init("ui_shopping_banner_spot.png")
	picDes:leftUp(4, 4)
	cell:addChild(picDes, 10)

    return cell
end

function IapShopMonthCardLayer:initRightNode(reward)
	self:tryShowReward(reward)

	if self.rightBg ~= nil then
		self.rightBg:removeFromParent()
	end

	--背景
	self.rightBg = UI.Image:create();
	self.rightBg:init("ui_shopping_banner_box3.png")
	self.rightBg:leftBottom(617, 200)
	self:addChild(self.rightBg)

	--标题
	local title = UI.Text:create()
	title:init(UI.TEXT_1212005, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	title:centerUp(12)
	self.rightBg:addChild(title)

	--月卡特效
	self._lifeTimeMembershipSFX = UI.Animation:create()
	self._lifeTimeMembershipSFX:init("effect_ui_common_settlement_jinbi.json", "effect_ui_common_settlement_jinbi.atlas")
	self._lifeTimeMembershipSFX:center(10, -40)
	self._lifeTimeMembershipSFX:setScale(5)
	self.rightBg:addChild(self._lifeTimeMembershipSFX)

	--补给图标
	self._lifeTimeMembershipIcon = UI.Image:create();
	self._lifeTimeMembershipIcon:init("ui_shopping_icon_month.png")
	self._lifeTimeMembershipIcon:centerUp(66)
	self.rightBg:addChild(self._lifeTimeMembershipIcon)

	-- 领取按钮
	self._lifeTimeGetSupplyButton = UI.Button:create()
	self._lifeTimeGetSupplyButton:init("ui_btn_yellow10_0.png", "ui_btn_yellow10_1.png", "ui_btn_yellow10_2.png", cc.p(0, -2))
	self._lifeTimeGetSupplyButton:centerUp(115)
	self._lifeTimeGetSupplyButton:setTextFont(UI.FONT_STANDARD, 18, {r = 41, g = 41, b = 45})
	self._lifeTimeGetSupplyButton:setText(LanguageManager:getInstance():getLocalString(1112117) --[["领取"]])
	self._lifeTimeGetSupplyButton:setTextOffset(0, 5)
	self._lifeTimeGetSupplyButton:setInterval(1)
	self._lifeTimeGetSupplyButton:hide()
	self._lifeTimeGetSupplyButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.lifeTimeMemberRewardButtonClick)
	self.rightBg:addChild(self._lifeTimeGetSupplyButton, 10000)

	-- 终生会员领取红点
	self._lifeTimeMembmerRedpoint = AvalonUtil.createRedPoint(self._lifeTimeGetSupplyButton, -5, 20)
	self:refreshRedPoint()

	--描述
	local detailLayout = UI.Layout:create()
	detailLayout:init()
	detailLayout:centerUp(200)
	self.rightBg:addChild(detailLayout)

	local width = 220
	local maxHeight = 86
	local height = 0
	local initStartX = 22
	local paddingY = 5
	
	-- 获取的钻石
	local startX = initStartX
	local getDiamondLayout = self:createOneCell()
	getDiamondLayout:centerUp(height)
	detailLayout:addChild(getDiamondLayout)

	local info = UI.Text:create()
	info:init(UI.TEXT_1212600, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:centerLeft(startX)
	getDiamondLayout:addChild(info)
	startX = startX + info:getContentSize().width + 14

	local image = UI.Image:create()
	image:init(SPRITE_GAMING_DIAMOND)
	image:centerLeft(startX)
	getDiamondLayout:addChild(image)
	startX = startX + image:getContentSize().width + 4

	local info = UI.Text:create()
	info:init(string.format("%s", ConfigManager:getLifeCardReward() or 0), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:centerLeft(startX)
	getDiamondLayout:addChild(info)
	getDiamondLayout:setSize(width, info:getContentSize().height)
	height = info:getContentSize().height + paddingY

	-- 每日领取
	startX = initStartX
	local everyDayLayout = self:createOneCell()
	everyDayLayout:centerUp(height)
	detailLayout:addChild(everyDayLayout)

	local info = UI.Text:create()
	info:init(UI.TEXT_1212601, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:centerLeft(startX)
	everyDayLayout:addChild(info)
	startX = startX + info:getContentSize().width + 14

	local image = UI.Image:create()
	image:init(SPRITE_GAMING_DIAMOND)
	image:centerLeft(startX)
	everyDayLayout:addChild(image)
	startX = startX + image:getContentSize().width + 4

	local info = UI.Text:create()
	info:init(string.format("%s", ConfigManager:getLifeCardDaily()), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:centerLeft(startX)
	everyDayLayout:addChild(info)
	everyDayLayout:setSize(width, info:getContentSize().height)
	height = height + info:getContentSize().height  + paddingY

	-- 可与月卡叠加标签
	startX = initStartX
	local labelLayout = self:createOneCell()
	labelLayout:centerUp(height)
	detailLayout:addChild(labelLayout)

	local info = UI.Text:create()
	info:init(LanguageManager:getInstance():getLocalString(1113273) --[["可与月卡叠加"]], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:centerLeft(startX)
	info:setWidth(180)
	info:autoAdapt()
	labelLayout:addChild(info)
	startX = startX + info:getContentSize().width + 14
	height = height + info:getContentSize().height  + paddingY
	labelLayout:setSize(width, info:getContentSize().height)
	detailLayout:setSize(220, height)

	-- 永久购买
	self._buyForeverLabel = UI.Text:create()
	self._buyForeverLabel:init(LanguageManager:getInstance():getLocalString(1113272) --[["永久购买"]], UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 155, g = 155, b = 155})
	self._buyForeverLabel:leftBottom(BG_MIDDLE_POS - self._buyForeverLabel._width / 2, -31)
	self.rightBg:addChild(self._buyForeverLabel)

	-- 购买按钮
	self._lifeTimeMemberButton = UI.Button:create()
	self._lifeTimeMemberButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png", cc.p(0, -2))
	self._lifeTimeMemberButton:leftBottom(BG_MIDDLE_POS - self._lifeTimeMemberButton._width / 2, -79)
	self._lifeTimeMemberButton:setInterval(1)
	self._lifeTimeMemberButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.buyLifeTimeMembership)
	self.rightBg:addChild(self._lifeTimeMemberButton)
	
	-- 推荐标签
	self._recoomandationFlag = UI.Image:create()
	self._recoomandationFlag:init("ui_shopping_banner_ribbon_5.png")
	self._recoomandationFlag:leftUp(0, 0)
	self._lifeTimeMemberButton:addChild(self._recoomandationFlag, 1000)

	-- 推荐文字
	local recoomandationText = UI.Text:create()
	recoomandationText:init(LanguageManager:getInstance():getLocalString(1110877),UI.FONT_BOLD, UI.FONT_SIZE_216PX, {r = 255, g = 186, b = 96})
	recoomandationText:center(-7, -7)
	recoomandationText:setRotation(-45)
	self._recoomandationFlag:addChild(recoomandationText)

	-- 购买一次价钱排版
	self._lifeTimeMemberPriceLayout = UI.Layout:create()
	self._lifeTimeMemberPriceLayout:init()
	self._lifeTimeMemberPriceLayout:center()
	self._lifeTimeMemberPriceLayout:enableAutoHeight()
	self._lifeTimeMemberPriceLayout:enableAutoWidth()
	self._lifeTimeMemberButton:addChild(self._lifeTimeMemberPriceLayout, 100)

	-- 购买一次货币图标
	self._lifeTimeMemberCurrencyIcon = UI.Image:create()
	self._lifeTimeMemberCurrencyIcon:init(SPRITE_GAMING_RMB)
	self._lifeTimeMemberCurrencyIcon:floatLeft(15)
	self._lifeTimeMemberPriceLayout:addComponent(self._lifeTimeMemberCurrencyIcon)

	-- 购买一次价钱文字
	self._lifeTimeMemberPriceLabel = UI.Text:create()
	self._lifeTimeMemberPriceLabel:init("",UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	self._lifeTimeMemberPriceLabel:floatLeft(5)
	self._lifeTimeMemberPriceLayout:addComponent(self._lifeTimeMemberPriceLabel)
	
	Avalon.MessageCenter:notice(GameMessage.MC_REFRESH_IAPSHOP_NEW_FLAG)
end

function IapShopMonthCardLayer:refreshRedPoint()
    if self._monthCardStatus then
        self._monthCardStatus:setVisible(UI.IapShopMonthCardLayer.haveMonthCardReward())
	end
	
	if self._lifeTimeMembmerRedpoint then
		self._lifeTimeMembmerRedpoint:setVisible(UI.IapShopMonthCardLayer.haveLifeTimeMembershipReward())
	end
end

function IapShopMonthCardLayer:onUpdateView(datas)
	local deal = false;
	if datas then
		for i,v in ipairs(datas) do
			if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_MONTH_CARD then
				self._buyOnceData = v
				deal = true
			end

			if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.MonthlySubscription then
				self._subData = v
				deal = true
			end

			if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.LifeTimeMembership then
				self._lifeTimeMemberData = v
				deal = true
			end
		end	
		self:updateMontlyNodeShow()
		self:updateBuyOnceButton()
		self:updateMonthlyTimeLeft()
		self:updateSubButton()
		self:updateLifeTimeMembershipButton()

		-- 更新图标
		self:updateIcons()

		-- 检查公会宝箱
		local guildBoxes = {}
		if(self._buyOnceData) then
			for i,item in ipairs(self._buyOnceData.products) do
				if (math.floor(item.id / 10000) == 2315) then
					local virtualGoodConfig = ConfigManager:getVirtualItemConfigByID(item.id)
					table.insert(guildBoxes, virtualGoodConfig)
				end
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
	end
	if datas and not deal then
		printError("month card config not existed")
	end
end

-- 更新图标
function IapShopMonthCardLayer:updateIcons()
	if (self.haveMonthCardReward()) then
		self._monthlyIcon:setOpacity(255)
		self._monthlySFX:show()
		self._monthlySFX:setAnimation("begin", false)
		self._monthlySFX:addAnimation("idle", true)
	else
		self._monthlyIcon:setOpacity(76.5)
		self._monthlySFX:hide()
	end

	if (self.haveLifeTimeMembershipReward()) then
		self._lifeTimeMembershipIcon:setOpacity(255)
		self._lifeTimeMembershipSFX:show()
		self._lifeTimeMembershipSFX:setAnimation("begin", false)
		self._lifeTimeMembershipSFX:addAnimation("idle", true)
	else
		self._lifeTimeMembershipIcon:setOpacity(76.5)
		self._lifeTimeMembershipSFX:hide()
	end
end

-- 更新终生按钮
function IapShopMonthCardLayer:updateLifeTimeMembershipButton()
	if (self._lifeTimeMemberData) then
		self.rightBg:show()
		self._lifeTimeMemberButton:enable()
		local heroData = GameDataManager:getInstance():getMaster()
		if (heroData and heroData:getIsLifeTimeMember()) then
			self._lifeTimeMemberButton:hide()
			self._buyForeverLabel:hide()
			if (self.haveLifeTimeMembershipReward()) then
				self._lifeTimeGetSupplyButton:show()
			else
				self._lifeTimeGetSupplyButton:hide()
			end
		else
			self._lifeTimeMemberButton:show()
			self._buyForeverLabel:show()
			self._lifeTimeGetSupplyButton:hide()

			-- 检测如果有指定价格字符串就使用, 没有就是用默认的
			local SdkManager = require "app.game.SdkManager"
			local priceString = SdkManager:getInstance():getPriceStringFromIapID(self._lifeTimeMemberData.iapId)
			if (priceString) then
				-- 使用SKU信息
				self._lifeTimeMemberCurrencyIcon:hide()
				self._lifeTimeMemberPriceLabel:setText(priceString)
			else
				-- 货币图标
				self._lifeTimeMemberCurrencyIcon:show()
				self._lifeTimeMemberCurrencyIcon:setSpriteName(UIUtil:getMoneyPng())
				
				-- 设置价钱
				local price = UIUtil:getMoneyPriceStr(self._lifeTimeMemberData.price / 100)
				self._lifeTimeMemberPriceLabel:setText(price)
			end
		end
		self._lifeTimeMemberPriceLayout:updateView()
	else
		self.rightBg:hide()
	end
end

-- 更新订阅按钮
function IapShopMonthCardLayer:updateSubButton()
	local heroData = GameDataManager:getInstance():getMaster()
	if (heroData and heroData:getSubDaysLeft() <= 0 and self._subData) then
		-- 如果已经过了订阅结束时间
		self._subButton:show()
		self._cancelAnytimeLabel:show()

		-- 检查首次是否打折
		local SdkManager = require "app.game.SdkManager"
		local priceString = SdkManager:getInstance():getPriceStringFromIapID(self._subData.iapId)
		local initialPrice = tonumber(SdkManager:getInstance():getPriceInitial(self._subData.iapId) or "")
		if (heroData:isFirstSub() and initialPrice) then
			self._firstTimeSubFlag:show()
			self._subOriPriceLabel:show()

			local sign = AvalonUtil.getCurrencySignFromPriceString(priceString)
			self._subOriPriceLabel:setText(sign .. string.format("%.2f", initialPrice))
			self._oriPriceRedLine:setSize(self._subOriPriceLabel._width + 5, 2.5)
		else
			self._subOriPriceLabel:hide()
			self._firstTimeSubFlag:hide()
		end

		-- 检测如果有指定价格字符串就使用, 没有就是用默认的
		if (priceString) then
			-- 使用SKU信息
			self._subCurrencyIcon:hide()
			self._subPriceLabel:setText(priceString)
		else
			-- 货币图标
			self._subCurrencyIcon:show()
			self._subCurrencyIcon:setSpriteName(UIUtil:getMoneyPng())
			
			-- 设置价钱
			local price = UIUtil:getMoneyPriceStr(self._subData.price / 100)
			self._subPriceLabel:setText(price)
		end
		self._subPriceTextLayout:updateView()
		self._subPriceLayout:updateView()
	else
		self._subButton:hide()
		self._cancelAnytimeLabel:hide()
	end
	self._buttonLayout:updateView()
end

-- 更新购买一次按钮
function IapShopMonthCardLayer:updateBuyOnceButton()
	if self._buyOnceData then
		-- 有数据, 展示按钮
		self._buyOnceButton:show()

		-- 如果可以领取, 显示领取, 有月卡剩余天数, 显示剩余天数
		local monthCardRestDay = self.getMonthCardRestDay()
		local freeDiamondReward = tonumber(ConfigManager:getMonthCardDaily())

		-- 有月卡/订阅或者有免费还没领
		if (monthCardRestDay > 0 or (freeDiamondReward > 0 and not self.AlreayGotSupply()))then 
			-- 更新领取按钮显示
			if (not self.AlreayGotSupply()) then
				self._monthlyGetSupplyButton:show()
			else
				self._monthlyGetSupplyButton:hide()
			end
		else
			self._monthlyGetSupplyButton:hide()
		end
		
		-- 检测如果有指定价格字符串就使用, 没有就是用默认的
		local SdkManager = require "app.game.SdkManager"
		local priceString = SdkManager:getInstance():getPriceStringFromIapID(self._buyOnceData.iapId)
		if (priceString) then
			-- 用SKU信息
			self._buyOnceCurrencyIcon:hide()
			self._buyOncePriceLabel:setText(priceString)
		else
			-- 货币图标
			self._buyOnceCurrencyIcon:show()
			self._buyOnceCurrencyIcon:setSpriteName(UIUtil:getMoneyPng())

			-- 设置价钱
			local price = UIUtil:getMoneyPriceStr(self._buyOnceData.price / 100)
			self._buyOncePriceLabel:setText(price)
		end
		self._buyOncePriceLayout:updateView()
	else
		self._buyOnceButton:hide()
	end
	self._buttonLayout:updateView()
end

function IapShopMonthCardLayer:updateMontlyNodeShow()
	if (self._subData or self._buyOnceData) then
		self._leftBg:show()
	else
		self._leftBg:hide()
	end
end

function IapShopMonthCardLayer:updateMonthlyTimeLeft()
	-- 如果可以领取, 显示领取, 有月卡剩余天数, 显示剩余天数
	local monthCardRestDay = self.getMonthCardRestDay()
	local freeDiamondReward = tonumber(ConfigManager:getMonthCardDaily())

	-- 有月卡/订阅或者有免费还没领
	if (monthCardRestDay > 0 or (freeDiamondReward > 0 and not self.AlreayGotSupply()))then 
		-- 更新剩余天数
		local formatString = LanguageManager:getInstance():getLocalString(1113264) --[["剩余天数 %s天"]]
		self._timeLeftLabel:setText(string.format(formatString, monthCardRestDay))
	else
		self._timeLeftLabel:setText(" ")
	end
end

function IapShopMonthCardLayer.haveLifeTimeMembershipReward()
	local have = false
	local heroData = GameDataManager:getInstance():getMaster()
	if (heroData and heroData:getIsLifeTimeMember() and not heroData:getIsLifeTimeGiftReceivedToday()) then
		have = true
	end
	return have
end

function IapShopMonthCardLayer.haveMonthCardReward()
	local have = false
	if (IapShopMonthCardLayer.getMonthCardRestDay() > 0) and not IapShopMonthCardLayer.AlreayGotSupply() then
		have = true
	end
	return have
end

function IapShopMonthCardLayer.getMonthCardRestDay()
	local heroData = GameDataManager:getInstance():getMaster()
	local currentDay = heroData:getRefreshDay() or 0
	local monthCardDay = heroData:getMonthCardDay() or 0
	return monthCardDay - currentDay 
end

function IapShopMonthCardLayer.AlreayGotSupply()
	local heroData = GameDataManager:getInstance():getMaster()
	local currentDay = heroData:getRefreshDay() or 0
	local getSupplyData = heroData:getSupplyReceiveDay() or 0
	local already = false
	if currentDay == getSupplyData then
		already = true
	end
	return already
end

-- 领取终生卡补给
function IapShopMonthCardLayer:lifeTimeMemberRewardButtonClick()
	local heroData = GameDataManager:getInstance():getMaster()
	if (not heroData:getIsLifeTimeMember()) then
		return
	end
	Net.Helper:sendMessage(NetMessageType.REQ_LIFETIME_REWARD_MESSAGE)
end

-- 领取月卡补给
function IapShopMonthCardLayer:monthlySupplyButtonClick()
	if (not RoleBehaviorManager:monthCardCheck()) then 
		return
	end
	
	Net.Helper:sendMessage(NetMessageType.RECHARGE_REQUEST_SUPPLY);
	Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 8, nil, nil, self._sourceType)
	-- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_IapShop_PageOp,
	-- 	0,
	-- 	PublicDefine.WebLogType_IapShop_PageOp_Type.WebLogType_IapShop_PageOp_Type_Get,
	-- 	PublicDefine.WebLogType_IapShop_Page_Type.WebLogType_IapShop_Page_Type_MonthCard,0)
end

-- 购买终生卡
function IapShopMonthCardLayer:buyLifeTimeMembership()
	local heroData = GameDataManager:getInstance():getMaster()
	if (heroData:getIsLifeTimeMember()) then
		return
	end
	if self._lifeTimeMemberData then
		Avalon.MessageCenter:notice(GameMessage.MC_GET_ORDER_REQ, self._lifeTimeMemberData, 1)
		self._globalUserData:markDiamondIap(self._lifeTimeMemberData.productID)
		Avalon.UserDataManager:saveDataToFile(self._globalUserData:getType())
	else
		printError("error : life time membership config not found")
	end
end

-- 购买订阅月卡
function IapShopMonthCardLayer:buySubButtonClick()
	local heroData = GameDataManager:getInstance():getMaster()
	if (heroData and heroData:getSubDaysLeft() > 0) then
		return
	end
	if self._subData then
		Avalon.MessageCenter:notice(GameMessage.MC_GET_ORDER_REQ, self._subData, 1)
		self._globalUserData:markDiamondIap(self._subData.productID)
		Avalon.UserDataManager:saveDataToFile(self._globalUserData:getType())
	else
		printError("error : subscription config not found")
	end
end

-- 购买一次月卡
function IapShopMonthCardLayer:buyOnceButtonClick()
	if (not RoleBehaviorManager:monthCardCheck()) then 
		return
	end
	
	if self._buyOnceData then
		Avalon.MessageCenter:notice(GameMessage.MC_GET_ORDER_REQ, self._buyOnceData, 1)
		self._globalUserData:markDiamondIap(self._buyOnceData.productID)
		Avalon.UserDataManager:saveDataToFile(self._globalUserData:getType());
	else
		printError("error : month card config not found")
	end
end

-- 展示奖励内容，如果收到领取奖励的通知
function IapShopMonthCardLayer:tryShowReward(reward)
	if reward ~= nil then
		if reward.result == ProtobufUtil:enum_id("PurchaseSystem.ReqSupplyReceiveResult", "ReqSupplyReceiveResult_Succeed") then
			if reward.rewardDiamond > 0 then
				local rewardGoodsArr = {}
				local goodsData = GoodsDataManager:createLocalGoodsData(Game.ConstGoods.Diamond)
				if (goodsData) then
					goodsData:setNum(reward.rewardDiamond)
					goodsData:setIsGolden(true)
					table.insert(rewardGoodsArr, goodsData)
				    Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, rewardGoodsArr, nil, UI.TEXT_111030, nil)
				end
			else
				printError("error : suppply diamond count is zero")
			end
		elseif reward.result == ProtobufUtil:enum_id("PurchaseSystem.ReqSupplyReceiveResult", "ReqSupplyReceiveResult_SystemError") then
			UI.ScrollBar:createByTextID(1170002)
		elseif reward.result == ProtobufUtil:enum_id("PurchaseSystem.ReqSupplyReceiveResult", "ReqSupplyReceiveResult_HasReveived") then
			UI.ScrollBar:createByText(UI.TEXT_1212008)
		end
	end
end

function IapShopMonthCardLayer:supplyStatusRefresh()
	self:updateMontlyNodeShow()
	self:updateBuyOnceButton()
	self:updateMonthlyTimeLeft()
	self:updateSubButton()
	self:updateLifeTimeMembershipButton()
	self:updateIcons()
end

function IapShopMonthCardLayer:registerListener()
	Avalon.MessageCenter:bind(GameMessage.MC_SUPPLY_STATUS_REFRESH, self, self.supplyStatusRefresh) 

	-- 领取月卡状态刷新
    Avalon.MessageCenter:bind(AvalonMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshRedPoint)
end

function IapShopMonthCardLayer:unRegisterListener()
	Avalon.MessageCenter:unbind(GameMessage.MC_SUPPLY_STATUS_REFRESH, self, self.supplyStatusRefresh) 

	-- 领取月卡状态刷新
    Avalon.MessageCenter:unbind(AvalonMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshRedPoint)
end

return IapShopMonthCardLayer
