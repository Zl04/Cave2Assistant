------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/09/15
--desc	: 
------------------------------------------------------------------------------
require "app.ui.iapshop.IapShopDiamondCell"
require "app.ui.common.Dialog.ScrollBar"
local SdkManager = require "app.game.SdkManager"
local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local SdkBox = require("utils.sdkbox.SdkBox")
local ProtobufUtil = require "utils.ProtobufUtil"
local languageManagerInstance = LanguageManager:getInstance()
local TradeActivityPrivilegeCardView = class("TradeActivityPrivilegeCardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
	"ui_general_shopping.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local BG_MIDDLE_POS = 153.5
local SPRITE_GAMING_DIAMOND = "symbol_gaming_diamond.png"
local centerStartY = 50
local shopPadding = 10
local buttonLayoutUp = 350

function TradeActivityPrivilegeCardView:ctor()
	if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
		TradeActivityPrivilegeCardView.super.ctor(
			self,
			UI.Type.TRADE_ACTIVITY_PRIVILEGE_CARD_GLOBAL,
			COM_RES_LIST,
			COM_WIDTH,
			COM_HEIGHT
		)
	else
		TradeActivityPrivilegeCardView.super.ctor(
			self,
			UI.Type.TRADE_ACTIVITY_PRIVILEGE_CARD,
			COM_RES_LIST,
			COM_WIDTH,
			COM_HEIGHT
		)
	end

	self._buyOnceData = nil
	self._subData = nil
	self._lifeTimeMemberData = nil
	self._globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
	self._sourceType = 2
	self:bindModel()
	Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 3, nil, nil, self._sourceType)
end

function TradeActivityPrivilegeCardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    TradeActivityPrivilegeCardView.super.init(self, ... )
end

function TradeActivityPrivilegeCardView:dtor()
    TradeActivityPrivilegeCardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.tradeactivity.TradeActivityPrivilegeCardView")
end


function TradeActivityPrivilegeCardView:onInitView()
	-- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
	self.contentLayout = contentLayout

	local scrollLayout = UI.Layout:create()
	scrollLayout:init()
	scrollLayout:centerLeft(0)
	scrollLayout:setSize(674, 396)
	-- scrollLayout:enableAutoHeight()
	scrollLayout:enableAutoWidth()
	-- scrollLayout:enableDebugDraw()
	self.scrollLayout = scrollLayout

	local scrollView = UI.ScrollView:create()
	scrollView:setSize(674, 396)
	scrollView:init()
	scrollView:setScrollType(UI.ScrollType.HORIZONTAL)
	-- scrollView:centerUp(185)
	scrollView:leftBottom(110, 32)
	scrollView:addInnerNode(scrollLayout)
	scrollView:setScrollBarEnabled(true)
	scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
	scrollView:setCircleVisible(false)
	scrollView:setScrollBarWidth(5)
	-- scrollView:enableDebugDraw()
	self.contentLayout:addChild(scrollView)

	shopStartX = 0

    self:initLeftNode()
	self:initSubDataNode()
	self:initRightNode()
	self:refreshProducts({})
	self:supplyStatusRefresh()
end


function TradeActivityPrivilegeCardView:initLeftNode()
	if self._leftBg ~= nil then
		self._leftBg:removeFromParent()
	end

	local layout = self:createOneShopLayout()
	layout:floatLeft(0)
	self.scrollLayout:addComponent(layout)
	self._leftBg = layout

	--月卡背景
	local bg = UI.Image:create()
	bg:init("ui_shopping_banner_box2.png")
	bg:centerBottom(108)
	bg:setScale(0.9)
	layout:addChild(bg)

	--标题
	local title = UI.Text:create()
	title:init(UI.TEXT_1212004, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
	title:centerUp(12)
	bg:addChild(title)

	--月卡特效
	self._monthlySFX = UI.Animation:create()
	self._monthlySFX:init("effect_ui_common_settlement_jinbi.json", "effect_ui_common_settlement_jinbi.atlas")
	self._monthlySFX:center(10, -40)
	self._monthlySFX:setScale(5)
	bg:addChild(self._monthlySFX)

	--月卡图标
	self._monthlyIcon = UI.Image:create()
	self._monthlyIcon:init("ui_shopping_icon_month.png")
	self._monthlyIcon:centerUp(60)
	bg:addChild(self._monthlyIcon)

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
	bg:addChild(self._monthlyGetSupplyButton, 10000)

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

	--日常任务增加1
	startX = initStartX
	local offsetY = 0
	local expeditionLayout = self:createOneCell()
	expeditionLayout:centerUp(height)
	detailLayout:addChild(expeditionLayout)

	local info = UI.Text:create()
	info:init(LanguageManager:getInstance():getLocalString(1114657), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:leftUp(startX, 0)
	expeditionLayout:addChild(info)
	offsetY = info:getContentSize().height + 3
	expeditionLayout:setSize(width, offsetY)
	height = height + offsetY

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
		bg:addChild(detailLayout)
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
		bg:addChild(scrollView)

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
	bg:addChild(self._guildBoxIcon, 10)

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
	self._buttonLayout:leftUp(52, buttonLayoutUp)
	self._buttonLayout:setSize(188, 0)
	self._buttonLayout:enableAutoHeight()
	bg:addChild(self._buttonLayout)
	
	-- 单月购买
	-- 剩余时间提示
	self._timeLeftLabel = UI.Text:create()
	self._timeLeftLabel:init("",UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 155, g = 155, b = 155})
	self._timeLeftLabel:floatUp(3)
	self._buttonLayout:addComponent(self._timeLeftLabel)

	-- 购买一次按钮
	self._buyOnceButton = UI.Button:create()
    self._buyOnceButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png", cc.p(0, -2))
	self._buyOnceButton:floatUp(1)
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

	-- 订阅购买
	-- -- 可取消提示
	-- self._cancelAnytimeLabel = UI.Text:create()
	-- self._cancelAnytimeLabel:init(LanguageManager:getInstance():getLocalString(1113271) --[["可随时取消"]],UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 155, g = 155, b = 155})
	-- self._cancelAnytimeLabel:floatUp(3)
	-- self._buttonLayout:addComponent(self._cancelAnytimeLabel)
	-- self._subDescribe = self._cancelAnytimeLabel

	-- -- 购买订阅按钮
	-- self._subButton = UI.Button:create()
	-- self._subButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png", cc.p(0, -2))
	-- self._subButton:floatUp(1)
	-- self._subButton:setInterval(1)
	-- self._subButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.buySubButtonClick)
	-- self._buttonLayout:addComponent(self._subButton)

	-- -- 首次标签
	-- self._firstTimeSubFlag = UI.Image:create()
	-- self._firstTimeSubFlag:init("ui_shopping_banner_ribbon_5.png")
	-- self._firstTimeSubFlag:leftUp(0, 0)
	-- self._subButton:addChild(self._firstTimeSubFlag, 1000)

	-- -- 首次文字
	-- local firstTimeSubText = UI.Text:create()
	-- firstTimeSubText:init(LanguageManager:getInstance():getLocalString(1113265) --[[首次!]],UI.FONT_BOLD, UI.FONT_SIZE_216PX, {r = 255, g = 186, b = 96})
	-- firstTimeSubText:center(-7, -7)
	-- firstTimeSubText:setRotation(-45)
	-- self._firstTimeSubFlag:addChild(firstTimeSubText)

    -- -- 价钱排版
	-- self._subPriceLayout = UI.Layout:create()
	-- self._subPriceLayout:init()
	-- self._subPriceLayout:center()
	-- self._subPriceLayout:enableAutoHeight()
	-- self._subPriceLayout:enableAutoWidth()
	-- self._subButton:addChild(self._subPriceLayout, 100)

	-- -- 描述文字
	-- local subPriceLabel = UI.Text:create()
	-- subPriceLabel:init(LanguageManager:getInstance():getLocalString(1113262)--[["连续包月"]],UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	-- subPriceLabel:floatLeft(0)
	-- self._subPriceLayout:addComponent(subPriceLabel)

	-- -- 货币图标
	-- self._subCurrencyIcon = UI.Image:create()
	-- self._subCurrencyIcon:init(SPRITE_GAMING_RMB)
	-- self._subCurrencyIcon:floatLeft(15)
	-- self._subPriceLayout:addComponent(self._subCurrencyIcon)

	-- -- 价钱文字排版
	-- self._subPriceTextLayout = UI.Layout:create()
	-- self._subPriceTextLayout:init(0, 0, 2, 0)
	-- self._subPriceTextLayout:floatLeft(5)
	-- self._subPriceTextLayout:enableAutoHeight()
	-- self._subPriceTextLayout:enableAutoWidth()
	-- self._subPriceLayout:addComponent(self._subPriceTextLayout)
	
	-- -- 原价文字
	-- self._subOriPriceLabel = UI.Text:create()
	-- self._subOriPriceLabel:init("0",UI.SYS_FONT, UI.FONT_SIZE_16PX, {r = 106, g = 80, b = 32})
	-- self._subOriPriceLabel:floatUp(-2)
	-- self._subPriceTextLayout:addComponent(self._subOriPriceLabel)
	
	-- -- 红线
	-- self._oriPriceRedLine = UI.Image9:create()
	-- self._oriPriceRedLine:init("ui_scale9image_red.png", CCRectMake(0,0,1,1), cc.size(self._subOriPriceLabel._width + 5, 2.5))
	-- self._oriPriceRedLine:setRotation(-7)
	-- self._oriPriceRedLine:center()
	-- self._subOriPriceLabel:addChild(self._oriPriceRedLine)

	-- -- 价钱文字
	-- self._subPriceLabel = UI.Text:create()
	-- self._subPriceLabel:init("",UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	-- self._subPriceLabel:floatUp(-2)
	-- self._subPriceTextLayout:addComponent(self._subPriceLabel)



	-- 更新一次按钮
	self:updateBuyOnceButton()
	-- self:updateSubButton()
end

--[[
	初始化订阅的数据
]]
function TradeActivityPrivilegeCardView:initSubDataNode()
	if self._subBg ~= nil then
		self._subBg:removeFromParent()
	end

	local layout = self:createOneShopLayout()
	layout:floatLeft(shopPadding)
	self.scrollLayout:addComponent(layout)
	self._subBg = layout

	--月卡背景
	local bg = UI.Image:create()
	bg:init("ui_shopping_banner_box2.png")
	bg:centerBottom(108)
	bg:setScale(0.9)
	layout:addChild(bg)

	--标题
	local title = UI.Text:create()
	title:init(UI.TEXT_1326005, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
	title:centerUp(12)
	bg:addChild(title)

	--月卡特效
	self._subMonthlySFX = UI.Animation:create()
	self._subMonthlySFX:init("effect_ui_common_settlement_jinbi.json", "effect_ui_common_settlement_jinbi.atlas")
	self._subMonthlySFX:center(10, -40)
	self._subMonthlySFX:setScale(5)
	bg:addChild(self._subMonthlySFX)

	--月卡图标
	self._subMonthlyIcon = UI.Image:create()
	self._subMonthlyIcon:init("ui_shopping_icon_month.png")
	self._subMonthlyIcon:centerUp(60)
	bg:addChild(self._subMonthlyIcon)

	-- 领取按钮
	self._subGetSupplyButton = UI.Button:create()
	self._subGetSupplyButton:init("ui_btn_yellow10_0.png", "ui_btn_yellow10_1.png", "ui_btn_yellow10_2.png", cc.p(0, -2))
	self._subGetSupplyButton:centerUp(115)
	self._subGetSupplyButton:setTextFont(UI.FONT_STANDARD, 18, {r = 41, g = 41, b = 45})
	self._subGetSupplyButton:setText(LanguageManager:getInstance():getLocalString(1112117) --[["领取"]])
	self._subGetSupplyButton:setTextOffset(0, 5)
	self._subGetSupplyButton:setInterval(1)
	self._subGetSupplyButton:hide()
	self._subGetSupplyButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.subsSupplyButtonClick)
	bg:addChild(self._subGetSupplyButton, 10000)

	-- 订阅越开领取红点
	self._subCardStatus = AvalonUtil.createRedPoint(self._subGetSupplyButton, -5, 20)
	self:refreshRedPoint()

	--描述
	local detailLayout = UI.Layout:create()
	detailLayout:init()

	local width = 220
	local maxHeight = 86
	local height = 0
	local initStartX = 22
	local paddingY = 5

	-- -- 获取的钻石
	-- local startX = initStartX
	-- local getDiamondLayout = self:createOneCell()
	-- getDiamondLayout:centerUp(height)
	-- detailLayout:addChild(getDiamondLayout)

	-- local info = UI.Text:create()
	-- info:init(UI.TEXT_1212600, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	-- info:centerLeft(startX)
	-- getDiamondLayout:addChild(info)
	-- startX = startX + info:getContentSize().width + 14

	-- local image = UI.Image:create()
	-- image:init(SPRITE_GAMING_DIAMOND)
	-- image:centerLeft(startX)
	-- getDiamondLayout:addChild(image)
	-- startX = startX + image:getContentSize().width + 4

	-- local info = UI.Text:create()
	-- info:init(string.format("%s", ConfigManager:getMonthCardReward()), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	-- info:centerLeft(startX)
	-- getDiamondLayout:addChild(info)
	-- getDiamondLayout:setSize(width, info:getContentSize().height)
	-- height = info:getContentSize().height + paddingY

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


	-- 月卡同等权限
	startX = initStartX
	local offsetY = 0
	local expeditionLayout = self:createOneCell()
	expeditionLayout:centerUp(height)
	detailLayout:addChild(expeditionLayout)

	local info = UI.Text:create()
	info:init(LanguageManager:getInstance():getLocalString(1114658), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
	info:leftUp(startX, 0)
	expeditionLayout:addChild(info)
	offsetY = info:getContentSize().height + 3
	expeditionLayout:setSize(width, offsetY)
	height = height + offsetY



	detailLayout:setSize(220, height)
	if(height < 110) then 
		detailLayout:centerUp(185)
		bg:addChild(detailLayout)
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
		bg:addChild(scrollView)

		-- 首次标签
		local mask = UI.Image:create()
		mask:init("ui_shopping_banner_shelter.png")
		mask:centerBottom(0)
		scrollView:addChild(mask, 1000)
	end

	-- 按钮排版
	self._buttonSubLayout = UI.Layout:create()
	self._buttonSubLayout:init(0, 0, -3, 0)
	self._buttonSubLayout:leftUp(52, buttonLayoutUp)
	self._buttonSubLayout:setSize(188, 0)
	self._buttonSubLayout:enableAutoHeight()
	bg:addChild(self._buttonSubLayout)
	
	-- 单月购买
	-- -- 剩余时间提示
	-- self._timeLeftLabel = UI.Text:create()
	-- self._timeLeftLabel:init("",UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 155, g = 155, b = 155})
	-- self._timeLeftLabel:floatUp(3)
	-- self._buttonSubLayout:addComponent(self._timeLeftLabel)

	-- -- 购买一次按钮
	-- self._buyOnceButton = UI.Button:create()
    -- self._buyOnceButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png", cc.p(0, -2))
	-- self._buyOnceButton:floatUp(1)
	-- self._buyOnceButton:setInterval(1)
	-- self._buyOnceButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.buyOnceButtonClick)
	-- self._buttonSubLayout:addComponent(self._buyOnceButton)
    
    -- -- 购买一次价钱排版
	-- self._buyOncePriceLayout = UI.Layout:create()
	-- self._buyOncePriceLayout:init()
	-- self._buyOncePriceLayout:center()
	-- self._buyOncePriceLayout:enableAutoHeight()
	-- self._buyOncePriceLayout:enableAutoWidth()
	-- self._buyOnceButton:addChild(self._buyOncePriceLayout, 100)

	-- -- 描述文字
	-- local buyOncePriceLabel = UI.Text:create()
	-- buyOncePriceLabel:init(LanguageManager:getInstance():getLocalString(1113263)--[["单月购买"]],UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	-- buyOncePriceLabel:floatLeft(0)
	-- self._buyOncePriceLayout:addComponent(buyOncePriceLabel)

	-- -- 购买一次货币图标
	-- self._buyOnceCurrencyIcon = UI.Image:create()
	-- self._buyOnceCurrencyIcon:init(SPRITE_GAMING_RMB)
	-- self._buyOnceCurrencyIcon:floatLeft(15)
	-- self._buyOncePriceLayout:addComponent(self._buyOnceCurrencyIcon)

	-- -- 购买一次价钱文字
	-- self._buyOncePriceLabel = UI.Text:create()
	-- self._buyOncePriceLabel:init("",UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	-- self._buyOncePriceLabel:floatLeft(5)
	-- self._buyOncePriceLayout:addComponent(self._buyOncePriceLabel)

	-- 订阅购买
	-- 可取消提示
	self._cancelAnytimeLabel = UI.Text:create()
	self._cancelAnytimeLabel:init(LanguageManager:getInstance():getLocalString(1113271) --[["可随时取消"]],UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 155, g = 155, b = 155})
	self._cancelAnytimeLabel:floatUp(3)
	self._buttonSubLayout:addComponent(self._cancelAnytimeLabel)
	self._subDescribe = self._cancelAnytimeLabel

	-- 购买订阅按钮
	self._subButton = UI.Button:create()
	self._subButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png", cc.p(0, -2))
	self._subButton:floatUp(1)
	self._subButton:setInterval(1)
	self._subButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.buySubButtonClick)
	self._buttonSubLayout:addComponent(self._subButton)

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

	-- -- 更新一次按钮
	-- self:updateBuyOnceButton()
	self:updateSubButton()
end

function TradeActivityPrivilegeCardView:createOneShopLayout()
	local cell = UI.Layout:create()
	cell:init()    
	cell:setSize(270, 396)

    return cell
end

function TradeActivityPrivilegeCardView:createOneCell()
	local cell = UI.Layout:create()
	cell:init()    
	cell:setSize(220, 0)
	local picDes = UI.Image:create()
	picDes:init("ui_shopping_banner_spot.png")
	picDes:leftUp(4, 4)
	cell:addChild(picDes, 10)

    return cell
end

function TradeActivityPrivilegeCardView:initRightNode(reward)
	self:tryShowReward(reward)

	if self.rightBg ~= nil then
		self.rightBg:removeFromParent()
	end

	local layout = self:createOneShopLayout()
	layout:floatLeft(shopPadding)
	self.scrollLayout:addComponent(layout)
	self.rightBg = layout

	--背景
	local bg = UI.Image:create();
	bg:init("ui_shopping_banner_box3.png")
	bg:centerBottom(108)
	bg:setScale(0.9)
	layout:addChild(bg)

	--标题
	local title = UI.Text:create()
	title:init(UI.TEXT_1212005, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	title:centerUp(12)
	bg:addChild(title)

	--月卡特效
	self._lifeTimeMembershipSFX = UI.Animation:create()
	self._lifeTimeMembershipSFX:init("effect_ui_common_settlement_jinbi.json", "effect_ui_common_settlement_jinbi.atlas")
	self._lifeTimeMembershipSFX:center(10, -40)
	self._lifeTimeMembershipSFX:setScale(5)
	bg:addChild(self._lifeTimeMembershipSFX)

	--补给图标
	self._lifeTimeMembershipIcon = UI.Image:create();
	self._lifeTimeMembershipIcon:init("ui_shopping_icon_month.png")
	self._lifeTimeMembershipIcon:centerUp(66)
	bg:addChild(self._lifeTimeMembershipIcon)

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
	bg:addChild(self._lifeTimeGetSupplyButton, 10000)

	-- 终生会员领取红点
	self._lifeTimeMembmerRedpoint = AvalonUtil.createRedPoint(self._lifeTimeGetSupplyButton, -5, 20)
	self:refreshRedPoint()

	--描述
	local detailLayout = UI.Layout:create()
	detailLayout:init()
	detailLayout:centerUp(200)
	bg:addChild(detailLayout)

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


	self._rightButtonLayout = UI.Layout:create()
	self._rightButtonLayout:init(0, 0, -3, 0)
	self._rightButtonLayout:leftUp(52, buttonLayoutUp)
	self._rightButtonLayout:setSize(188, 100)
	self._rightButtonLayout:enableAutoHeight()
	-- self._rightButtonLayout:enableDebugDraw()
	bg:addChild(self._rightButtonLayout)

	-- 永久购买
	self._buyForeverLabel = UI.Text:create()
	self._buyForeverLabel:init(LanguageManager:getInstance():getLocalString(1113272) --[["永久购买"]], UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 155, g = 155, b = 155})
	-- self._buyForeverLabel:leftBottom(BG_MIDDLE_POS - self._buyForeverLabel._width / 2, -31)
	self._buyForeverLabel:floatUp(centerStartY)
	self._buyForeverLabel:floatUp(2)
	self._rightButtonLayout:addComponent(self._buyForeverLabel)

	-- 购买按钮
	self._lifeTimeMemberButton = UI.Button:create()
	self._lifeTimeMemberButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png", cc.p(0, -2))
	-- self._lifeTimeMemberButton:leftBottom(BG_MIDDLE_POS - self._lifeTimeMemberButton._width / 2, -79)
	self._lifeTimeMemberButton:floatUp(1)
	self._lifeTimeMemberButton:setInterval(1)
	self._lifeTimeMemberButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.buyLifeTimeMembership)
	self._rightButtonLayout:addComponent(self._lifeTimeMemberButton)
	
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

function TradeActivityPrivilegeCardView:refreshRedPoint()
    if self._monthCardStatus then
        self._monthCardStatus:setVisible(mvc.tradeActivityModel:haveMonthCardReward())
	end

	if self._subCardStatus then
        self._subCardStatus:setVisible(mvc.tradeActivityModel:haveSubCardReward())
	end
	
	if self._lifeTimeMembmerRedpoint then
		self._lifeTimeMembmerRedpoint:setVisible(mvc.tradeActivityModel:haveLifeTimeMembershipReward())
	end
end

-- 获取货币符号
function TradeActivityPrivilegeCardView:getCurrencySymbol()
    local symbol = "￥"
    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        symbol = "$"
    end
	return symbol
end

function TradeActivityPrivilegeCardView:onUpdateView(datas)
	local deal = false
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

function TradeActivityPrivilegeCardView:refreshProducts(data)
    local isSingle = data.isSingle

    local datas = SdkManager:getInstance():getShowIapDatas()
    
    if not isSingle then
        self._data = clone(datas)
        if self._data then
            for i, v in ipairs(self._data) do
                if (v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_MONTH_CARD or
                    v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.LifeTimeMembership or 
                    v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.MonthlySubscription) 
                    and not ServerConfigUtil:isInReview() 
                then
                    break
                end
            end
        end
        -- 先筛选一次 如果为0 需要删除掉
        for i= table.nums(self._data),1,-1 do
            if checkint(self._data[i].productID) <=0 then
                table.remove( self._data, i )
            end
        end
        table.sort(self._data, function (a,b)
            -- 如果排序ID一样, 用其他方法排序
            if (a.sortId == b.sortId) then
                -- 排序ID一样, 有hot标签的在前面, 都有或者都没有的时候用其他方法排序
                if (a.isHot and not b.isHot) then
                    return true
                elseif (not a.isHot and b.isHot) then
                    return false
                end

                -- 排序ID一样, hot标签一样, 用价格排序
                if (a.price < b.price) then
                    return true
                elseif (a.price > b.price) then
                    return false
                else -- 价钱相等用productID排序
                    return a.productID > b.productID
                end
            end

            -- 默认用排序标签排序
            return a.sortId > b.sortId
        end )
        self:refreshWebLaunguageCallback({})        
        -- SdkManager:getInstance():setIapDatas(datas)

        

        local curTime = GameManager:getNormalServerTime()
        -- 删除已经下架的 和已经售完 并且标示了隐藏的
        local size = table.nums(self._data)
        for i= size,1, -1 do
            local item = self._data[i]
            -- 时间到了下架的
            if (item.endTimeSec > 0 and item.endTimeSec < curTime) then
                print("从本地删除")
                table.remove(self._data,i)
            end
            
        end
        
        local keyList = {}
        for i,v in ipairs(self._data) do
            table.insert( keyList, v.nameID )
            table.insert( keyList, v.desID )
        end

        local lans = SdkManager:getInstance():getProductsLan()
        if lans and table.nums(lans) > 0 then
            local hasOneUpdate = false
            for i,v in ipairs(self._data) do
                local findName = false
                local findDesc = false
                for idx,lan in pairs(lans) do
                    if v.nameID == idx then
                        findName = true;
                    end
                    if v.desID == idx then
                        findDesc = true;
                    end
                    if findDesc and findName then
                        break;
                    end
                end
                if not findDesc or not findName then
                    hasOneUpdate = true ;
                    break;
                end
            end
            if hasOneUpdate then
                SdkManager:getInstance():loadProductsLan( keyList, handler(self, self.refreshWebLaunguageCallback))
            else
                self:refreshWebLaunguageCallback(lans)
            end
            
        else
            -- dump(keyList)
            -- 获取苹果商店的信息
            SdkManager:getInstance():loadProductsLan(keyList, handler(self, self.refreshWebLaunguageCallback))
        end
       
    end
    
 
end

function TradeActivityPrivilegeCardView:refreshWebLaunguageCallback(webLaunguageList)
    if not self._data  then
        return
    end

    
    local infos = SdkManager:getInstance():getProducts()
    local myChannel = SdkBox:getInstance():getVersionChannel()
    -- local iaps = {}
    printInfo("IapShopMainLayer:refreshWebLaunguageCallback, myChannel",myChannel)

    for i,v in ipairs(self._data) do
        v.name = ""
        v.desc = ""
        v.iapId = ""
        for idx,lan in pairs(webLaunguageList) do
            if v.nameID == idx then
                local p = json.decode(lan)
                local str = ""
                if(p) then
                    for i,v in ipairs(p) do
                        str = str .. v.text
                    end
                end
                v.name = str
            end
            if v.desID == idx then
                local p = json.decode(lan)
                local str = ""
                if(p) then
                    for i,v in ipairs(p) do
                        str = str .. v.text
                    end
                end
                v.desc = str
            end
        end
        for i,idAndChannel in ipairs(v.IAPList) do
            if checkint(idAndChannel.channelID) == myChannel then
                -- table.insert( iaps, idAndChannel.iapId)  

                v.iapId = idAndChannel.iapId
                break;      
            end
        end

        v.symbol = self:getCurrencySymbol()
    end
 
    self:onUpdateView(self._data)
end

-- 更新图标
function TradeActivityPrivilegeCardView:updateIcons()
	if (mvc.tradeActivityModel:haveMonthCardReward()) then
		self._monthlyIcon:setOpacity(255)
		self._monthlySFX:show()
		self._monthlySFX:setAnimation("begin", false)
		self._monthlySFX:addAnimation("idle", true)
	else
		self._monthlyIcon:setOpacity(76.5)
		self._monthlySFX:hide()
	end

	if (mvc.tradeActivityModel:haveSubCardReward()) then
		self._subMonthlyIcon:setOpacity(255)
		self._subMonthlySFX:show()
		self._subMonthlySFX:setAnimation("begin", false)
		self._subMonthlySFX:addAnimation("idle", true)
	else
		self._subMonthlyIcon:setOpacity(76.5)
		self._subMonthlySFX:hide()
	end

	if (mvc.tradeActivityModel:haveLifeTimeMembershipReward()) then
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
function TradeActivityPrivilegeCardView:updateLifeTimeMembershipButton()
	if (self._lifeTimeMemberData) then
		self.rightBg:show()
		self._lifeTimeMemberButton:enable()
		local heroData = GameDataManager:getInstance():getMaster()
		if (heroData and heroData:getIsLifeTimeMember()) then
			self._lifeTimeMemberButton:hide()
			self._buyForeverLabel:hide()
			if (mvc.tradeActivityModel:haveLifeTimeMembershipReward()) then
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
function TradeActivityPrivilegeCardView:updateSubButton()
	local heroData = GameDataManager:getInstance():getMaster()

	local subMonthCardRestDay = mvc.tradeActivityModel:getSubsMonthCardRestDay()
	local freeDiamondReward = tonumber(ConfigManager:getMonthCardDaily())
	-- 订阅或者有免费还没领
	if (subMonthCardRestDay > 0 or (freeDiamondReward > 0 and not mvc.tradeActivityModel:subsMonthAlreayGotSupply()))then 
		-- 更新领取按钮显示
		if (not mvc.tradeActivityModel:subsMonthAlreayGotSupply()) then
			self._subGetSupplyButton:show()
		else
			self._subGetSupplyButton:hide()
		end
	else
		self._subGetSupplyButton:hide()
	end

	-- print("TradeActivityPrivilegeCardView:updateSubButton", heroData:getSubDaysLeft(), self._subData)
	local SdkBox = require("utils.sdkbox.SdkBox")
	if (heroData and self._subData 
		and SdkBox:getInstance():isSupportSubscribe()) then
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


		local nextDeductionDateStr =  UI.TEXT_1326002 .. heroData:getSubDeductionDate()
		local xudingStr =  UI.TEXT_1326001
		local nodingStr =  UI.TEXT_1326000
		
		local buyBtnStatus = false
		if(heroData:isFirstSub()) then
			-- 连续包月
			self._subDescribe:setText(nodingStr)
			buyBtnStatus = true
		elseif heroData:getSubDaysLeft() > 0 then 
			if(heroData:isMonthSubscriptionEndAutoRenew()) then 
				self._subDescribe:setText(nextDeductionDateStr)
			else
				self._subDescribe:setText(xudingStr)
				buyBtnStatus = false
			end
		elseif heroData:getSubDaysLeft() <= 0 then 
			self._subDescribe:setText(xudingStr)
			buyBtnStatus = true
		end
		if(buyBtnStatus == true) then 
			self._subButton:enable()
		else
			self._subButton:disable()
		end
	else
		self._subButton:hide()
		self._cancelAnytimeLabel:hide()
	end
	-- self._buttonLayout:updateView()
	self._buttonSubLayout:updateView()
end

-- 更新购买一次按钮
function TradeActivityPrivilegeCardView:updateBuyOnceButton()
	-- 如果可以领取, 显示领取, 有月卡剩余天数, 显示剩余天数
	local monthCardRestDay = mvc.tradeActivityModel:getMonthCardRestDay()
	local freeDiamondReward = tonumber(ConfigManager:getMonthCardDaily())
	-- 有月卡/订阅或者有免费还没领
	if (monthCardRestDay > 0 or (freeDiamondReward > 0 and not mvc.tradeActivityModel:AlreayGotSupply()))then 
		-- 更新领取按钮显示
		if (not mvc.tradeActivityModel:AlreayGotSupply()) then
			self._monthlyGetSupplyButton:show()
		else
			self._monthlyGetSupplyButton:hide()
		end
	else
		self._monthlyGetSupplyButton:hide()
	end

	if self._buyOnceData then
		-- 有数据, 展示按钮
		self._buyOnceButton:show()

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

function TradeActivityPrivilegeCardView:updateMontlyNodeShow()
	if (self._buyOnceData) then
		self._leftBg:show()
	else
		self._leftBg:hide()
	end

	local SdkBox = require("utils.sdkbox.SdkBox")
	if(self._subData) then 
		if (SdkBox:getInstance():isSupportSubscribe()) then
			self._subBg:show()
		else
			self._subBg:hide()
		end
	else
		self._subBg:hide()
	end
end

function TradeActivityPrivilegeCardView:updateMonthlyTimeLeft()
	-- 如果可以领取, 显示领取, 有月卡剩余天数, 显示剩余天数
	local monthCardRestDay = mvc.tradeActivityModel:getMonthCardRestDay()
	local freeDiamondReward = tonumber(ConfigManager:getMonthCardDaily())

	-- 有月卡/订阅或者有免费还没领
	if (monthCardRestDay > 0 or (freeDiamondReward > 0 and not mvc.tradeActivityModel:AlreayGotSupply()))then 
		-- 更新剩余天数
		local formatString = LanguageManager:getInstance():getLocalString(1113264) --[["剩余天数 %s天"]]
		self._timeLeftLabel:setText(string.format(formatString, monthCardRestDay))
		self._timeLeftLabel:setVisible(true)
	else
		self._timeLeftLabel:setText(" ")
		-- if(self._buyOnceData == nil) then
		-- 	self._timeLeftLabel:setVisible(false)
		-- end
	end
end

-- 领取终生卡补给
function TradeActivityPrivilegeCardView:lifeTimeMemberRewardButtonClick()
	local heroData = GameDataManager:getInstance():getMaster()
	if (not heroData:getIsLifeTimeMember()) then
		return
	end
	Net.Helper:sendMessage(NetMessageType.REQ_LIFETIME_REWARD_MESSAGE)
end

-- 领取月卡补给
function TradeActivityPrivilegeCardView:monthlySupplyButtonClick()
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

function TradeActivityPrivilegeCardView:subsSupplyButtonClick()
	if (not RoleBehaviorManager:monthCardCheck()) then 
		return
	end
	
	Net.Helper:sendMessage(NetMessageType.RECHARGE_REQ_CLAIM_MONTH_SUBS);
	Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 8, nil, nil, self._sourceType)
end

-- 购买终生卡
function TradeActivityPrivilegeCardView:buyLifeTimeMembership()
	local heroData = GameDataManager:getInstance():getMaster()
	if (heroData:getIsLifeTimeMember()) then
		return
	end
	if self._lifeTimeMemberData then
		self:getOrder(self._lifeTimeMemberData, 1)
		self._globalUserData:markDiamondIap(self._lifeTimeMemberData.productID)
		Avalon.UserDataManager:saveDataToFile(self._globalUserData:getType())
	else
		printError("error : life time membership config not found")
	end
end

-- 购买订阅月卡
function TradeActivityPrivilegeCardView:buySubButtonClick()
	local heroData = GameDataManager:getInstance():getMaster()
	if (heroData and heroData:isMonthSubscriptionEndAutoRenew()) then
		return
	end

	if self._subData then
		local subPay = function()
			self:getOrder(self._subData, 1)
			self._globalUserData:markDiamondIap(self._subData.productID)
			Avalon.UserDataManager:saveDataToFile(self._globalUserData:getType())
		end

		-- if(monthDay > 0) then 
		-- 	UI.TipsLayer:onShowCommonTextHandler(LanguageManager:getInstance():getLocalString(1114097), function()
		-- 		subPay()
		-- 	end)
		-- else
			subPay()
		-- end
	else
		printError("error : subscription config not found")
	end
end

-- 购买一次月卡
function TradeActivityPrivilegeCardView:buyOnceButtonClick()
	if (not RoleBehaviorManager:monthCardCheck()) then
		return
	end

	if self._buyOnceData then
		self:getOrder(self._buyOnceData, 1)
		self._globalUserData:markDiamondIap(self._buyOnceData.productID)
		Avalon.UserDataManager:saveDataToFile(self._globalUserData:getType());
	else
		printError("error : month card config not found")
	end
end

function TradeActivityPrivilegeCardView:getOrder(data,count)
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

-- 展示奖励内容，如果收到领取奖励的通知
function TradeActivityPrivilegeCardView:tryShowReward(reward)
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

function TradeActivityPrivilegeCardView:supplyStatusRefresh()
	self:updateMontlyNodeShow()
	self:updateBuyOnceButton()
	self:updateMonthlyTimeLeft()
	self:updateSubButton()
	self:updateLifeTimeMembershipButton()
	self:updateIcons()
end

function TradeActivityPrivilegeCardView:bindModel()
	Avalon.MessageCenter:bind(GameMessage.MC_SUPPLY_STATUS_REFRESH, self, self.supplyStatusRefresh)
	Avalon.MessageCenter:bind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.refreshProducts)
	-- 领取月卡状态刷新
    Avalon.MessageCenter:bind(AvalonMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshRedPoint)
end

function TradeActivityPrivilegeCardView:unbindModel()
	Avalon.MessageCenter:unbind(GameMessage.MC_SUPPLY_STATUS_REFRESH, self, self.supplyStatusRefresh)
	Avalon.MessageCenter:unbind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.refreshProducts)
	-- 领取月卡状态刷新
    Avalon.MessageCenter:unbind(AvalonMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshRedPoint)
end





return TradeActivityPrivilegeCardView












