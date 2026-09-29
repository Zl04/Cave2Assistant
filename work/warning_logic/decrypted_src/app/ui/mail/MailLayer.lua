-- MailLayer.lua
-- Author:ydli
-- 2017年10月23日
-- Using:邮箱主界面

UI = UI or {}
local MailLayer = class("MailLayer", UI.DownShowWin)
UI.MailLayer = MailLayer
local SceneManager = require("app.game.SceneManager")
require "app.ui.mail.BannerLayer"
require "app.ui.mail.MailCell"
local MailLayerTable = table
local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(760, 530)
local BannerCellSize = cc.size(660, 164)
-- 背包资源
local COM_RES_LIST = {
	"ui_town_mailbox.plist",
}

function MailLayer:ctor(spriteID, sourceType)
	MailLayer.super.ctor(self, UIType.MAIL_LAYER, COM_RES_LIST, layerSize.width, layerSize.height)
	self.rootLayer = nil         --root节点
	self.spriteID = spriteID
	self.clippingRect = nil
	self.isCanAccept = true
	self.cellState = Game.CELL_STATE.NOMAL
	self:init()
	self:setTouchEnable(true)
	self:setInterceptTouches(true)
	self:registerListener()
	Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Mailbanner, 1, nil, nil, sourceType)
	-- self:enableDebugDraw()
end

function MailLayer:dtor()
	MailLayer.super.dtor(self)
	-- self:setInterceptTouches(false)
	self:unRegisterListener()
	self.clippingRect = nil
	self.isCanAccept = true
	Game.MailManager:getInstance():clearDelMailList()
end

function MailLayer:init()
	MailLayer.super.init(self)
end

function MailLayer:onInitView()
	local bannerList, isHasRefresh = ImageDownLoadUtil:getBannerInfoData()
	self.bannerList = bannerList or {}
	-- print("------MailLayer:onInitView() ", isHasRefresh)
	if not isHasRefresh then
		ImageDownLoadUtil:getBannerInfoList()
	end
	-- self.testMail = clone(testMail)
	self.rootLayer = UI.Layout:create()
	self.rootLayer:init(0, 0, 0, 0)
	self.rootLayer:setSize(layerSize.width, layerSize.height)
	self.rootLayer:center()
	self:addChild(self.rootLayer)

	local bg = UI.Image:create()
	bg:init("ui_bg_box1.png")
	bg:center()
	self.rootLayer:addChild(bg)
	self.bg = bg

	-- 添加中间的背景
	local paper = UI.Image:create()
	paper:init("ui_bg_paper1.png")
	paper:leftBottom(44, 40)
	bg:addChild(paper)

	local titleBg = UI.Image:create()
	titleBg:init("ui_bg_title.png")
	-- titleBg:centerUp(-21)
	titleBg:leftUp(bg:getContentSize().width/2 - titleBg:getContentSize().width/2 - 8, -21)
	bg:addChild(titleBg, 10)

	local title = UI.Text:create()
	title:init(UI.TEXT_1170712, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_170_170_170)
	title:centerLeft(56+117 - title:getContentSize().width/2)
	titleBg:addChild(title, 100)

	local noBannerTip = UI.Text:create()
	noBannerTip:init(UI.TEXT_1170701, UI.FONT_ARIAL, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	noBannerTip:centerUp(125)
	self.bg:addChild(noBannerTip)
	self.noBannerTip = noBannerTip

	local noMailTip = UI.Text:create()
	noMailTip:init(UI.TEXT_1170702, UI.FONT_ARIAL, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	noMailTip:centerUp(315)
	self.bg:addChild(noMailTip)
	self.noMailTip = noMailTip
	
	local cap = UI.Image:create()
	cap:init("ui_mailbox_gradually.png")
	cap:centerBottom(106)
	bg:addChild(cap, 100)
	self:refershBanner(self.bannerList)

	local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
	splitLine:setContentSize(650, 2)
	splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
	splitLine:setAnchorPoint(cc.p(0.5, 0))
	splitLine:setPosition(cc.p(cap:getContentSize().width / 2, 0))
	cap:addChild(splitLine)

	local mailList, isNeedWebLaunguage = Game.MailManager:getInstance():getMailList()
	-- dump(mailList, "---------mailList")
	-- dump(isNeedWebLaunguage, "----MailLayer")
	if isNeedWebLaunguage then
		Game.MailManager:getInstance():getLanguageFromWebServer(true)
	end

	local panelNomal = UI.Layout:create()
	panelNomal:init()
	panelNomal:setSize(self.bg:getContentSize().width, 100)
	panelNomal:centerBottom(0)
	self.bg:addChild(panelNomal,1000)

	local panelDel = UI.Layout:create()
	panelDel:init()
	panelDel:setSize(self.bg:getContentSize().width, 100)
	panelDel:centerBottom(0)
	self.bg:addChild(panelDel,1000)

	local readAllButton = UI.Button:create()
	readAllButton:init("ui_btn_yellow2_0.png","ui_btn_yellow2_1.png","ui_btn_yellow2_2.png")
	readAllButton:centerBottom(51)
	readAllButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
		self:acceptAllMail()
	end)
	readAllButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	readAllButton:setText(UI.TEXT_1212045)
	panelNomal:addChild(readAllButton)
	self.readAllButton = readAllButton

	--兑换码  功能开关
	if not ServerConfigUtil:isInReview() then
		local exchangeButton = UI.Button:create()
		exchangeButton:init("ui_btn_yellow2_0.png","ui_btn_yellow2_1.png","ui_btn_yellow2_2.png")
		exchangeButton:leftBottom(97, 51)
		exchangeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
			UI.TipsLayer:createExchangeTipsTips()
		end)

		panelNomal:addChild(exchangeButton)
		exchangeButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
		exchangeButton:setText(UI.TEXT_1150001)
		readAllButton:leftBottom(317, 51)
		self.exchangeButton = exchangeButton
	end

	local delAllButton = UI.Button:create()
	delAllButton:init("ui_btn_delete_0.png","ui_btn_delete_2.png","ui_btn_delete_0.png")
	delAllButton:rightBottom(95, 51)
	delAllButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
		panelNomal:centerBottom(2 * winSize.height)
		panelDel:centerBottom(0)
		self.choiceLogo:hide()
		self.cellState = Game.CELL_STATE.DEL_AND_NO_SELECT
		self.mailTableView:setViewSize(cc.size(655, 365))
		self.mailTableView:reloadData(false)
		self.bannerLayer:hide()
		self.bannerLayer:leftBottom(-winSize.width, 313)
        self.noBannerTip:hide()
	end)
	panelNomal:addChild(delAllButton)
	self.delAllButton = delAllButton

--- 删除模式下的按钮------
	local delConfireButton = UI.Button:create()
	delConfireButton:init("ui_btn_yellow9_0.png","ui_btn_yellow9_1.png","ui_btn_yellow9_2.png")
	delConfireButton:leftBottom(127, 51)
	delConfireButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
		self:deleteAllSelectedMail()
	end)
	delConfireButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	delConfireButton:setText(UI.TEXT_1170717)
	panelDel:addChild(delConfireButton)


	local cancleButton = UI.Button:create()
	cancleButton:init("ui_btn_yellow9_0.png","ui_btn_yellow9_1.png","ui_btn_yellow9_2.png")
	cancleButton:leftBottom(347, 51)
	cancleButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
		self:cancleDelMode()
	end)
	cancleButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	cancleButton:setText(UI.TEXT_110012)
	panelDel:addChild(cancleButton)

	local choiceButton = UI.Button:create()
	choiceButton:init("ui_btn_choice_0.png","ui_btn_choice_0.png","ui_btn_choice_0.png")
	choiceButton:leftBottom(616, 51)
	choiceButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
		self.choiceLogo:setVisible(not self.choiceLogo:isVisible())
		for k, v in ipairs(self.mailList) do
			if self.choiceLogo:isVisible() then
				self.cellState = Game.CELL_STATE.DEL_AND_SELECTED
				Game.MailManager:getInstance():insertDelId(v.mailID)
			else
				self.cellState = Game.CELL_STATE.DEL_AND_NO_SELECT
				Game.MailManager:getInstance():removeDelId(v.mailID)
			end
			Avalon.MessageCenter:notice(GameMessage.MC_UI_RETFRESH_ONE_MAIL_INFO, v.mailID)
		end
	end)
	panelDel:addChild(choiceButton)

	local choiceLogo = UI.Image:create()
	choiceLogo:init("ui_btn_choice_1.png")
	choiceLogo:center()
	choiceButton:addChild(choiceLogo, 10)
	self.choiceLogo = choiceLogo
----
	local stakes = UI.Image:create()
	stakes:init("ui_bg_tree.png")
	stakes:leftBottom(-91, 0)
	bg:addChild(stakes, -1)

 -- 添加了装饰物
	local defomation  = UI.Image:create()
	defomation:init("ui_bg_rattan.png")
	defomation:rightUp(-10, 30)
	bg:addChild(defomation)

	local defomation  = UI.Image:create()
	defomation:init("ui_bg_rattan1.png")
	defomation:rightBottom(-42, 0)
	bg:addChild(defomation)

	local defomation  = UI.Image:create()
	defomation:init("ui_bg_rattan2.png")
	defomation:rightBottom(-4, 143)
	bg:addChild(defomation, 3)

	local defomation  = UI.Image:create()
	defomation:init("ui_bg_railing.png")
	defomation:rightBottom(-12, 25)
	bg:addChild(defomation, 3)

	local flagRight = UI.Animation:create()
	flagRight:init("effect_ui_town_mailbox_right.json", "effect_ui_town_mailbox_right.atlas", 1);
	flagRight:rightBottom(35, 5)
	bg:addChild(flagRight, 110)
	flagRight:setAnimation("idle", true)

	local flagLeft = UI.Animation:create()
	flagLeft:init("effect_ui_town_mailbox_left.json", "effect_ui_town_mailbox_left.atlas", 1);
	flagLeft:leftBottom(-12, 5)
	bg:addChild(flagLeft, 110)
	flagLeft:setAnimation("idle", true)

	panelNomal:centerBottom(0)
	panelDel:centerBottom(2 * winSize.height)
	self.panelNomal = panelNomal
	self.panelDel = panelDel
end

function MailLayer:onUpdateView()
	local mailList, isNeedWebLaunguage = Game.MailManager:getInstance():getMailList()
	-- if not isNeedWebLaunguage then
		self:refershMailList(mailList)
	-- end
end

function MailLayer:cancleDelMode()
    self.panelNomal:centerBottom(0)
    self.panelDel:centerBottom(2 * winSize.height)
    self.choiceLogo:hide()
    self.cellState = Game.CELL_STATE.NOMAL
    self.mailTableView:setViewSize(cc.size(655, 200))
    self.mailTableView:reloadData(false)
    self.bannerLayer:show()
    self.bannerLayer:leftBottom(49, 313)
    Game.MailManager:getInstance():clearDelMailList()
	if #self.bannerList == 0 then
	    self.noBannerTip:show()		
    end
end

-- 注册监听事件(可选)
function MailLayer:registerListener()
	Avalon.MessageCenter:bind(GameMessage.MC_HTTP_BANNER_INFO_REFRESH, self, self.refershBanner)
	Avalon.MessageCenter:bind(GameMessage.MC_UI_RETFRESH_MAIL_LIST, self, self.refershMailList)
	Avalon.MessageCenter:bind(GameMessage.MC_UI_REMOVE_MAIL_IN_LAYER, self, self.revomeMailData)
	Avalon.MessageCenter:bind(GameMessage.MC_UI_CLOSE_MAIN_MAIL_LAYER, self, self.closeCallback)
end

-- 注销监听事件(可选)
function MailLayer:unRegisterListener()
	Avalon.MessageCenter:unbind(GameMessage.MC_HTTP_BANNER_INFO_REFRESH, self, self.refershBanner)
	Avalon.MessageCenter:unbind(GameMessage.MC_UI_RETFRESH_MAIL_LIST, self, self.refershMailList)
	Avalon.MessageCenter:unbind(GameMessage.MC_UI_REMOVE_MAIL_IN_LAYER, self, self.revomeMailData)
	Avalon.MessageCenter:unbind(GameMessage.MC_UI_CLOSE_MAIN_MAIL_LAYER, self, self.closeCallback)
end

function MailLayer:deleteAllSelectedMail()
	local list = Game.MailManager:getInstance():getDelMailList()
	if #list == 0 then
		UI.ScrollBar:createByText(UI.TEXT_1212049)
		return 
	end

	if RoleBehaviorManager:mailNpcCheck() then
		printWarn(" been blocked when using mail npc function !")
		return
	end

	local isHaveGood = false
	for k, v in ipairs(list) do
		if Game.MailManager:getInstance():isHaveAttachmentReward(v) then
			isHaveGood = true
			break
		end
	end

	if isHaveGood then
		UI.ConfirmDialog.show(UI.TEXT_1212046, function()
			UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
			GameManager:deleteSelectListMail(list)
		end)
		return
	end

	UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
	GameManager:deleteSelectListMail(list)
end

--[[
1、领取所有带附件的邮件
2、把所有未读邮件置为已读邮件
]]
function MailLayer:acceptAllMail()
	if RoleBehaviorManager:mailNpcCheck() then
		printWarn(" been blocked when using mail npc function !")
		return
	end
	local list = {}
	local rewardList = {}
	local addPetNum = 0
	for k, data in ipairs(self.mailList) do
		if (#data.goodsIDs > 0 or #data.InstEquips > 0 or #data.InstPets > 0 or #data.glyphs > 0) and data.rewardStat == PublicDefine.MAIL_REWARD_STATE.MailRewardStat_New then
			table.insert(list, data.mailID)
			for k2, v2 in ipairs(data.goodsIDs) do
				local isHave = false
				for k3, v3 in ipairs(rewardList) do
					if v3.goodsID == v2.templateID then
						v3.num = v3.num + v2.num
						isHave = true
					end
				end
				if not isHave then
					local reward = {}
					reward.goodsID = v2.templateID
					reward.num = v2.num
					reward.isGolden = true
					table.insert(rewardList, reward)
				end
			end

			for k2, v2 in ipairs(data.InstEquips) do
				local reward = {}
				reward.goodsID = v2:getId()
				reward.num = v2:getNum()
				reward.isGolden = true
				table.insert(rewardList, reward)
			end

			for k2, v2 in ipairs(data.InstPets) do
				addPetNum = addPetNum + 1
			end

			for k2, v2 in ipairs(data.glyphs) do
				local reward = {}
				reward.goodsID = v2:getId()
				reward.num = v2:getNum()
				reward.isGolden = false
				table.insert(rewardList, reward)
			end
		end
	end

	local GameDataManager = require("app.game.GameDataManager")
	local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(rewardList)
	if not enough and #rewardList > 0 then
		UI.ScrollBar:createByTextID(1110793)
		return
	end

	local petCount = #MasterDataManager:getBagPets()
	if addPetNum > 0 and petCount + addPetNum >= PET_MAC_BAG then
		UI.ScrollBar:createByText(UI.TEXT_1213713)
		return
	end
    
    local isHaveNew = false
	for k, v in ipairs(self.mailList) do
		if Game.MailManager:getInstance():isNewFlagByMailId(v.mailID) then
			Game.MailManager:getInstance():removeNewFlag(v.mailID)
			Avalon.MessageCenter:notice(GameMessage.MC_UI_RETFRESH_ONE_MAIL_INFO, v.mailID)
			isHaveNew = true
		end
	end

	if #list == 0 and not isHaveNew then
		UI.ScrollBar:createByText(UI.TEXT_1212048)
		return
	end
	if #list > 0 then
	    GameManager:sendAcceptAward(list)
	end
end

function MailLayer:refershBanner(bannerList)
	self.bannerList = bannerList 
	if self.bannerLayer ~= nil then
		self.bannerLayer:removeFromParent(true)
	end

	local bannerLayer = UI.BannerLayer:create()
	bannerLayer:init(#self.bannerList, BannerCellSize.width, BannerCellSize.height, handler(self, self.updateCellCallback), handler(self, self.clickCellCallback), self.bannerList)
	bannerLayer:leftBottom(49, 313)
	self.bg:addChild(bannerLayer, 30)
	self.bannerLayer = bannerLayer

	if #self.bannerList == 0 then
		self.noBannerTip:show()
	else
		self.noBannerTip:hide()
	end
end

function MailLayer:refershMailList(mailList)
	self.mailList = mailList
	if #self.mailList == 0 then
		self.noMailTip:show()
		self.readAllButton:hide()
		self.delAllButton:hide()
		if self.exchangeButton then
            self.exchangeButton:centerBottom(51)
        end
        if self.cellState ~= Game.CELL_STATE.NOMAL then
            self:cancleDelMode()
        end
		return
	end
	self.readAllButton:show()
	if self.exchangeButton then
	    self.exchangeButton:leftBottom(97, 51)
	end
	self.delAllButton:show()
	self.noMailTip:hide()
	-- 列表
	if self.mailTableView == nil then
		self.mailTableView = cc.TableView:create(cc.size(655, 200))
		self.mailTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		self.mailTableView:setPosition(cc.p(50, 110))
		self.mailTableView:setDelegate()
		self.mailTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
		self.bg:addChild(self.mailTableView, 20)
		self.mailTableView:initScrollBar()
		self.mailTableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)

		self.mailTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
		self.mailTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
		self.mailTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
		self.mailTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
		self.mailTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
		self.mailTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
		self.mailTableView:registerScriptHandler(handler(self,self.tableCellWillRecycle),cc.TABLECELL_WILL_RECYCLE)

		local point  = self.mailTableView:convertToWorldSpace(cc.p(0,0))
		self.clippingRect = cc.rect(point.x, point.y, self.mailTableView:getViewSize().width, self.mailTableView:getViewSize().height)
		self.mailTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
	else        
		-- local point = self.mailTableView:getContentOffset()
		self.mailTableView:reloadData(false)
		-- self.mailTableView:setContentOffset(point, false)
	end

	if not SceneManager:getInstance():isInTownOrInHome() then
		self.delAllButton:disable()
		self.delAllButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
            UI.ScrollBar:createByText(UI.TEXT_1212899)
  		end)

		self.readAllButton:disable()
		self.readAllButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
            UI.ScrollBar:createByText(UI.TEXT_1212899)
  		end)

		if self.exchangeButton then
			self.exchangeButton:disable()
			self.exchangeButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
            	UI.ScrollBar:createByText(UI.TEXT_1212899)
  			end)
		end
	end
end

function MailLayer:updateCellCallback(index, middleNode, leftNode, rightNode)
	-- print("---MailLayer:updateCellCallback and index = "..index)
	if middleNode ~= nil then
		-- print("middle") 
		middleNode:removeAllChildren()
		local topImage = cc.Sprite:create()
		topImage:setAnchorPoint(0, 0)
		topImage:setPosition(0, 0)
		middleNode:addChild(topImage)
		local data = self.bannerList[index]
		ImageDownLoadUtil:downLoadImage(data.fileName, topImage, function(imgName, localUrl)
			if(not tolua.isnull(topImage) and localUrl and localUrl ~= "") then
				topImage:setTexture(localUrl)
			end
		end)
	end
	if leftNode ~= nil then
		-- print("left") 
		leftNode:removeAllChildren()
		local topImage = cc.Sprite:create()
		topImage:setAnchorPoint(0, 0)
		topImage:setPosition(0, 0)
		leftNode:addChild(topImage)
		local lIndex = (index - 1) % #self.bannerList
		lIndex = lIndex == 0 and #self.bannerList or lIndex 
		local data = self.bannerList[lIndex]
		ImageDownLoadUtil:downLoadImage(data.fileName, topImage, function(imgName, localUrl)
			if(not tolua.isnull(topImage) and localUrl and localUrl ~= "") then
				topImage:setTexture(localUrl)
			end
		end)
	end
	if rightNode ~= nil then
		-- print("right") 
		rightNode:removeAllChildren()
		local topImage = cc.Sprite:create()
		topImage:setAnchorPoint(0, 0)
		topImage:setPosition(0, 0)
		rightNode:addChild(topImage)

		local rIndex = (index + 1) % #self.bannerList
		rIndex = rIndex == 0 and #self.bannerList or rIndex 
		local data = self.bannerList[rIndex]
		ImageDownLoadUtil:downLoadImage(data.fileName, topImage, function(imgName, localUrl)
			if(not tolua.isnull(topImage) and localUrl and localUrl ~= "") then
				topImage:setTexture(localUrl)
			end
		end)
	end
end

function MailLayer:clickCellCallback(index)
	-- print("---MailLayer:clickCellCallback and index = "..index)
	local data = self.bannerList[index]
	if data ~= nil then
		GameManager:openUrl(data.url, function(isClose)
			if data.url ~= nil and data.url ~= "" then
				-- local SdkManager = require"app.game.SdkManager"
				-- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_MailBanner_Click, data.id)
				Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Mailbanner, 3, data.id)
			end
			if isClose and self.closeCallback then
				self:closeCallback()
			end
		end)
	end
end

function MailLayer:closeCallback()
	self:closeWin()    
end

--tableview 相关
function MailLayer:numberOfCellsInTableView(table)
	return #self.mailList
end

function MailLayer:scrollViewDidScroll(view)
end

function MailLayer:scrollViewDidZoom(view)
	
end

function MailLayer:tableCellTouched(tableView,cell)
	local mailCell = cell:getChildByName("cell")
	if mailCell then
		mailCell:showInfoLayer()
	end
end

function MailLayer:tableCellWillRecycle(tableView,cell)
	if cell ~= nil then
		cell:removeChildByName("cell")
	end
end

function MailLayer:cellSizeForTable(table,idx)
	return 650, 90
end

function MailLayer:tableCellAtIndex(tableView,idx)
	-- print("MailLayer:tableCellAtIndex",idx)
	local cell = tableView:dequeueCell()
	if cell == nil then
		cell = cc.TableViewCell:new()
	else
		cell:removeChildByName("cell");
	end
	local data = self.mailList[idx + 1]
	xpcall(function()
		local cellState = self.cellState
		if cellState ~= Game.CELL_STATE.NOMAL then
			if Game.MailManager:getInstance():getOneMailDelSelected(data.mailID) then
				cellState = Game.CELL_STATE.DEL_AND_SELECTED
			else
				cellState = Game.CELL_STATE.DEL_AND_NO_SELECT
			end
		end
		local pMailCell = UI.MailCell:create(data, idx, self.mailTableView, cellState)
		pMailCell:setName("cell")
		pMailCell:leftBottom(0, 0)
		cell:addChild(pMailCell)
		pMailCell:setParentLayer(self)
	end, 
	function(e) 
		printError("------------------MailLayer:tableCellAtIndex-----------------------error", e)
	end, 1)  
	return cell
end
function MailLayer:getClippingRect()
	return self.clippingRect 
end

function MailLayer:revomeMailData(mailId)
	for k, v in ipairs(self.mailList) do
		if v.mailID == mailId then
			table.remove(self.mailList, k)
		end 
	end
	if #self.mailList == 0 then
		 self.noMailTip:show()
	end
end

function MailLayer:setCanAcceptAward(isCanAccept)
	self.isCanAccept = isCanAccept
end

function MailLayer:isCanAcceptAward()
	return self.isCanAccept
end

function MailLayer:openShow()
	self:open()
end
