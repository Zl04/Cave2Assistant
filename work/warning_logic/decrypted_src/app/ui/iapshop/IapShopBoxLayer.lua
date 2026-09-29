--
-- Author: yueyingsong
-- Date: 2017-11-22 11:19:47
-- Using: 内购商城界面内的宝箱购买界面
require "app.ui.iapshop.IapShopBoxCell"

local SdkManager = require "app.game.SdkManager"
local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require("utils.ProtobufUtil")
UI = UI or {}

local IapShopBoxLayer = class("IapShopBoxLayer",UI.HWBtnComponent)
UI.IapShopBoxLayer = IapShopBoxLayer

local RES_LIST = {
    "ui_town_gemshop.plist", 
}

local DES_WIDTH = 1136
local DES_HEIGHT = 640
local COLUMN_NUM = 4

function IapShopBoxLayer:ctor(sourceType,lType)
	IapShopBoxLayer.super.ctor(self,UIType.IAP_SHOP_BOX_LAYER,RES_LIST,DES_WIDTH,DES_HEIGHT)
	self._tableView = nil;
    self._data 		= {1,1,1,1}
    self._sourceType = sourceType
    self._lType = lType
    self._cells     = {}
    self:registerListener()
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 2, 0, nil, self._sourceType)
end

function IapShopBoxLayer:dtor()
	self:unRegisterListener()
end

function IapShopBoxLayer:onInitView()
	-- 商品列表
    self._tableView = UI.TableView:create({}, 906, 479)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftBottom(135, 35)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:setScrollBarEnabled(true)
    self._tableView:setCircleVisible(false)
    self._tableView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    self._tableView:onUpdateCellSize(function ()
        return 224, 309
    end) 
    self._tableView:onUpdateCells(function (tableview, idx)
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.IapShopBoxCell.new(self._sourceType)
            table.insert(self._cells, cell)
        end
        local tempD = {}
        for i = 1, COLUMN_NUM do
        	table.insert(tempD,self._data[idx * COLUMN_NUM + i])
        end
        xpcall(function()
            cell:onUpdateView(tempD)
        end, 
        function(e) 
            printInfo("IapShopBoxLayer:tableCellAtIndex, error")
        end, 1) 
        
        return cell
    end)
    self._tableView:onUpdateCellNumbers(function ()
        return math.ceil(table.nums(self._data) / COLUMN_NUM)
    end)
    self:addChild(self._tableView)
    
    -- 洞窟内不能买宝箱提示
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
	toastText:init(UI.TEXT_1170842, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
	toastText:floatLeft(2)
	toastText:setTextVerticalCenter()
    shopBoxMsgLayout:addComponent(toastText)
    
    -- 列表底部遮罩
    local botCover = UI.Image:create()
    botCover:init("ui_shopping_banner_mask.png")
    botCover:leftBottom(76, 19)
    self:addChild(botCover)
end

function IapShopBoxLayer:onUpdateView(datas)
	self._data = {}
    if not datas then return end
    
    

    -- 过滤购买条件限制
    local needs = {}
    local types = {}
	for i,v in ipairs(datas) do
		-- if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_TREASURE then
        if v.label == self._lType then

            local isComebackTreasure = false
            if ProtobufUtil:checkFieldIsInit(v, "ext") and v.ext ~= nil and v.ext ~= "'" then
                xpcall(function()
                    local extParam = json.decode(v.ext)
                    if extParam.show and extParam.tradeActivityId == PublicDefine.TradeActivityIDList.TradeActivityComeback then
                        isComebackTreasure = true
                    end
                end, 
                function(e) 
                end, 1)
            end

            if not isComebackTreasure then
                table.insert(self._data,v)
                local limitedType = v.limitedType
                if limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Daily  
                or limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Weekly  
                or limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Total  then
                    table.insert( needs, v.productID)
                    types[tostring(v.productID)]= limitedType
                end
            end
        end
    end


    -- 用Web条件过滤一下数据
    SdkManager:getInstance():filterDataWithWebCondition(self._data)
    
    -- 过滤购买数据
    self:onGetBoughtResp()
    
    -- 
    local boughts = SdkManager:getInstance():getBoughts()
    if boughts == nil then
        SdkManager:getInstance():reqBoughtNum(needs,types)
    else
        for i,v in ipairs(needs) do
            local find = false
            for i1,v1 in ipairs(boughts) do
                if v == v1.productID then
                    find = true;
                    break;
                end
            end
            if not find then
                SdkManager:getInstance():reqBoughtNum(needs,types)
                break;
            end
        end
    end
end

function IapShopBoxLayer:onGetBoughtResp(data)
    local purchaseData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.PURCHASE, GameDataManager:getInstance():getSaveUserKey())
    local products = purchaseData:getProducts()
    -- 删除已经下架的 和已经售完 并且标示了隐藏的
    -- 如果大于0  说明有服务器总数限购，显示剩余的
    local size = table.nums(self._data)
    for i= size,1, -1 do
        local item = self._data[i]
        local limitedNum = item.limitedNum
        local limitedType = item.limitedType
        local buyNum = 0;
        for i,v in ipairs(products) do
            if v.productID == item.productID then
                buyNum = v.boughtNum
                break
            end
        end
        -- print("是否在购买完毕之后下架",item.name,item.productID,item.hideWhenSoldOut)
        -- 角色个人限购的
        if ((limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Daily  
            or limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Weekly
            or limitedType == PublicDefine.PurchaseLimitType.PurchaseLimitType_Total
            ) and limitedNum - buyNum <= 0 and item.hideWhenSoldOut == true) 
        -- 服务器总数量限购 可购买的 减去 已经卖出去的
        or (item.saleNum > 0 and item.saleNum - item.buyNum <= 0 and item.hideWhenSoldOut == true)
            then
            -- print("从本地删除")
            table.remove(self._data,i)
        end
        
    end
    self._tableView:reload()
end

function IapShopBoxLayer:onTouchDialogOutsizeHandler( tips, touchPosition)
    self:close()
end

function IapShopBoxLayer:schedulerCountDown(dt)
    for i, cell in ipairs(self._cells) do
        if not tolua.isnull(cell) then
            cell:schedulerCountDown(dt)
        end
    end
end

function IapShopBoxLayer:registerListener()
    self.mSchedulerID = 0;
    local scheduler=cc.Director:getInstance():getScheduler()
    self.mSchedulerID = scheduler:scheduleScriptFunc(handler(self, self.schedulerCountDown), 1, false)

    Avalon.MessageCenter:bind(GameMessage.MC_GET_BOUGHT_RESP, self, self.onGetBoughtResp)
    Avalon.MessageCenter:bind(GameMessage.MC_UPDATE_IAPBOX_LAYER, self, self.onGetBoughtResp)
    

end

function IapShopBoxLayer:unRegisterListener()
    local scheduler=cc.Director:getInstance():getScheduler()
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
    end
    Avalon.MessageCenter:unbind(GameMessage.MC_GET_BOUGHT_RESP, self, self.onGetBoughtResp)
    Avalon.MessageCenter:unbind(GameMessage.MC_UPDATE_IAPBOX_LAYER, self, self.onGetBoughtResp)
end

return IapShopBoxLayer
