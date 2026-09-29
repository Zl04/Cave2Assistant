--
-- Author: yueyingsong
-- Date: 2017-11-20 17:44:38
-- Using: 内购商城界面内的钻石购买界面
require "app.ui.iapshop.IapShopDiamondCell"

local SdkManager = require "app.game.SdkManager"

UI = UI or {}

local IapShopDiamondLayer = class("IapShopDiamondLayer",UI.HWBtnComponent)
UI.IapShopDiamondLayer = IapShopDiamondLayer

local DES_WIDTH = 1136
local DES_HEIGHT = 640
local COLUMN_NUM = 3

function IapShopDiamondLayer:ctor(sourceType)
	IapShopDiamondLayer.super.ctor(self,UIType.IAP_SHOP_DIAMOND_LAYER,RES_LIST,DES_WIDTH,DES_HEIGHT)
	self._tableView = nil;
	self._data 		= {1,1,1,1}
    self._webdata 	= nil;
    self._sourceType = sourceType
	self:registerListener()
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 1, nil, nil, self._sourceType)
end

function IapShopDiamondLayer:dtor()
	self:unRegisterListener()
end

function IapShopDiamondLayer:onInitView()
    -- 商品列表
	self._tableView = UI.TableView:create({}, 968, 496)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftBottom(99, 20)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    -- self._tableView:setScrollBarEnabled(true)
    -- self._tableView:setCircleVisible(false)
    -- self._tableView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    self._tableView:onUpdateCellSize(function ()
        return 1000, 232
    end) 
    self._tableView:onUpdateCells(function (tableview, idx)
        local cell = tableview:dequeueCell()
        xpcall(function()
            if cell == nil then
                cell = UI.IapShopDiamondCell.new()
            end
            local tempD = {}
            for i = 1, COLUMN_NUM do
            	table.insert(tempD,self._data[idx * COLUMN_NUM + i])
            end
            cell:onUpdateView(tempD)
        end, 
        function(e) 
            printInfo("IapShopDiamondLayer:tableCellAtIndex, error")
        end, 1)
        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return math.ceil(table.nums(self._data) / COLUMN_NUM)
    end)
    self:addChild(self._tableView)

    -- 理性娱乐，适度消费
    local shopBoxMsgLayout = UI.Layout:create()
    shopBoxMsgLayout:init()
    shopBoxMsgLayout:enableAutoHeight()
    shopBoxMsgLayout:enableAutoWidth()
    shopBoxMsgLayout:leftUp(140, 81)
    self:addChild(shopBoxMsgLayout)

    local toastImg = UI.Image:create()
    toastImg:init("ui_shopping_banner_prompt.png")
    toastImg:floatLeft(0)
    shopBoxMsgLayout:addComponent(toastImg)

    local toastText = UI.Text:create()
	toastText:init(UI.TEXT_221301, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
	toastText:floatLeft(2)
	toastText:setTextVerticalCenter()
    shopBoxMsgLayout:addComponent(toastText)

    if UI.TEXT_221301 == "" then
        shopBoxMsgLayout:hide();
    end

    -- 列表底部遮罩
    local botCover = UI.Image:create()
    botCover:init("ui_shopping_banner_mask.png")
    botCover:leftBottom(76, 19)
    self:addChild(botCover)
end

function IapShopDiamondLayer:schedulerCountDown(dt)

end

function IapShopDiamondLayer:onUpdateView(datas)
	self._data = {}
	if not datas then return end
	for i,v in ipairs(datas) do
		if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_DIAMOND then
			table.insert(self._data,v)
		end
	end
	self._tableView:reload()
end

function IapShopDiamondLayer:onTouchDialogOutsizeHandler( tips, touchPosition)
    self:close()
end

function IapShopDiamondLayer:registerListener()
	
end

function IapShopDiamondLayer:unRegisterListener()
	
end

return IapShopDiamondLayer
