------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2020/05/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
require "app.modules.festival.FestivalExchangeShopCell"


local languageManagerInstance = LanguageManager:getInstance()
local FestivalExchangeShopView = class("FestivalExchangeShopView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
	"ui_gaming_choice.plist",
	"ui_town_festival_exchange_shop.plist",
	"ui_town_guild_auction.plist"
}

local COM_WIDTH = 760
local COM_HEIGHT = 540

function FestivalExchangeShopView:ctor()
    FestivalExchangeShopView.super.ctor(
    	self,
    	UI.Type.FESTIVAL_EXCHANGE_SHOP,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function FestivalExchangeShopView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.festival", "Festival", false)
	FestivalExchangeShopView.super.init(self, ... )
	self:initData()
end

function FestivalExchangeShopView:dtor()
    FestivalExchangeShopView.super.dtor(self)
    self:unbindModel()
	reload_script_file_mvc("app.modules.festival.FestivalExchangeShopView")
end


function FestivalExchangeShopView:onInitView()
	self:initData()

    local bg = UI.Image:create()
	bg:init("ui_bg_box1.png")
	bg:center()
	self:addChild(bg)
	self.bg = bg
    
	-- 添加中间的背景
	local paper = UI.Image:create()
	paper:init("ui_bg_paper1.png")
	paper:leftBottom(44, 40)
	bg:addChild(paper)

	local titleBg = UI.Image:create()
	titleBg:init("ui_bg_title.png")
	titleBg:leftUp(bg:getContentSize().width/2 - titleBg:getContentSize().width/2 - 8, -21)
	bg:addChild(titleBg, 10)

	local title = UI.Text:create()
	title:init(UI.TEXT_1324100, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_190_190_190)
	title:centerLeft(56+117 - title:getContentSize().width/2)
	titleBg:addChild(title, 100)
	
	-- 帘子
	local lianImage = UI.Image:create()
	lianImage:init("ui_festival_shop_canopy.png")
	lianImage:centerUp(45)
	bg:addChild(lianImage,9)

	-- 倒计时显示
	local iconImage = UI.Image:create()
	iconImage:init("ui_information_clock_bg.png")
	iconImage:centerLeft(15)
	lianImage:addChild(iconImage,9)

	local timeText = UI.Text:create()
	timeText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
	timeText:centerLeft(45)
	lianImage:addChild(timeText, 100)
	self.timeText = timeText

	-- 滑动内容
	local tableBg = UI.Image:create()
	tableBg:init("ui_festival_shop_bg.png")
	tableBg:leftBottom(44, 40)
	bg:addChild(tableBg, 8)

	local offsetY = 0
    local shopTableView = UI.TableView:create({}, 645, 388)
    shopTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    shopTableView:centerBottom(offsetY)
    shopTableView:setDelegate()
    shopTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    shopTableView:setBounceable(true)
    shopTableView:setOpacityModifyRGB(true)
    shopTableView:init()
    shopTableView:onUpdateCellSize(function (table,idx)
        return 621, 123
    end) 

    shopTableView:onUpdateCells(function (table, idx)
        -- print("shopTableView:onUpdateCells=", idx)
        -- 获取缓存的格子, 如果没有, 就新建
        local reusedCell = table:dequeueCell()
        if (not reusedCell) then
            reusedCell = UI.TableViewCell:create()
            xpcall(function()
                local cellView = UI.FestivalExchangeShopCell:create()
                cellView:init(self.activityID, self._exchangeData[idx + 1])
                cellView:setTouchClipNode(shopTableView)
                cellView:leftBottom(0, 0)
                cellView:setName("cellView")
                reusedCell:addChild(cellView)
                cellView:updateData(self._exchangeData[idx + 1])
            end,
            function(e) 
                printError("------------------------GoodsListNew:tableCellAtIndex-----------------error", e)
            end, 1);
        else 
            local cellView = reusedCell:getChildByName("cellView")
            if (cellView) then
                cellView:updateData(self._exchangeData[idx + 1])
            end
        end

        return reusedCell
    end)

    shopTableView:onUpdateCellNumbers(function ()
        return #self._exchangeData
    end)

    shopTableView:onTableCellTouched(function(table, cell)
        
	end)
	print("FestivalExchangeShopView:Oninitview")
    -- 载入数据
    shopTableView:reloadData()
    shopTableView:fixContentOffset()
	tableBg:addChild(shopTableView)
	self._shopTableView = shopTableView
	
	-- table 蒙层
	local tableMask = UI.Image:create()
	tableMask:init("ui_festival_shop_mask.png")
	tableMask:centerBottom(offsetY)
	tableBg:addChild(tableMask)

	-- 装饰物
	print("effect_ui_town_festival_shop_qiqiu")
	local floatCloud = UI.Animation:create()
	floatCloud:init("effect_ui_town_festival_shop_qiqiu.json", "effect_ui_town_festival_shop_qiqiu.atlas", 1)
	floatCloud:setAnimation("animation", true)
	floatCloud:center()
	bg:addChild(floatCloud, 15)

	self:updateText()
end


function FestivalExchangeShopView:bindModel()
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end


function FestivalExchangeShopView:unbindModel()
	Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

function FestivalExchangeShopView:initData()
	local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_ExchangeShop)
	if(activityData) then
		-- 做一次兑换次数同步
		self._endTime = activityData:getEndTime()
		self._exchangeData = activityData:getFestivalExchangeShopData()
		self.activityID = activityData:getID()
	else
		self._endTime = 0
		self._exchangeData = {}
		self.activityID = 0
		self:close()
	end
	-- self._exchangeData = {}
	-- print("FestivalExchangeShopView:initData", #self._exchangeData)
end

function FestivalExchangeShopView:updateText()
	if(self.timeText) then 
		local endTime = self._endTime
		local timeStr = AvalonUtil:getNewFullFormatTime(endTime, Game.TIME_LEVEL.TIME_LEVEL_HOUR)
		self.timeText:setText(string.format(UI.TEXT_1324101, timeStr))
	end
end

function FestivalExchangeShopView:update(dt)
	if(self._totalTime == nil) then 
		self._totalTime = 0
	end
	if(self._totalTime > 60) then 
		self._totalTime = self._totalTime - 60
		self:updateText()
	end
end

function FestivalExchangeShopView:exchangeResult(data)
	self:initData()
	if(self._shopTableView) then
		self._shopTableView:reloadData()
	end
end

return FestivalExchangeShopView












