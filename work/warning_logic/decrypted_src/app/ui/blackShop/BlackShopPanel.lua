-- BlackShopPanel.lua
-- Author:zp
-- 2017年7月13日
-- Using:黑市商人

require "app.ui.common.ScrollView"
require "app.ui.common.List.ListView"
require "app.ui.common.GridList.GridList"
require "app.ui.blackShop.BlackShopGrid"
require "app.ui.shoplayer.BagGoodsPanel"
require "app.ui.blackShop.BlackShopInfoArea"
require "app.ui.shieldingLayer.WaitingLayer"

local winSize = cc.Director:getInstance():getWinSize()
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE

local GameDataManager = require("app.game.GameDataManager")
local GameMapManager = require("app.game.GameMapManager")
local LanguageManager = require("app.game.LanguageManager")
local ProtobufUtil = require("utils.ProtobufUtil")

UI = UI or {}

local BlackShopPanel = class("BlackShopPanel", UI.DoorWin)
UI.BlackShopPanel = BlackShopPanel

local DEBUG = true

-- 资源文件
local COM_RES_LIST = {
    "ui_general_shop.plist",
}

local LAYOUT_DESIGN_WIDTH = 1024
local LAYOUT_FUNCTION_HEIGHT = 640

local LAYOUT_SCROLL_WIDTH = 250
local LAYOUT_SCROLL_HEIGHT = 500

local LEFT_WIDTH = 345
local LEFT_HEIGHT = 617

local SHOP_LAYOUT = {
    -- 背包格子初始化信息
    GOODS_GRID_INIT_COLUMN = 5,
    GOODS_GRID_INIT_ROW = 10,
    GOODS_GRID_WIDTH = 70,
    GOODS_GRID_HEIGHT = 70+44,
    GOODS_GRID_HORIZONTAL_SPACE = 32,
    GOODS_GRID_VERTICAL_SPACE = 0,
    GOODS_GRID_PADDING_SPACE = 14
}

local function computeLayoutScale(realAreaWidth, designAreaWidth)
    local areaScale = realAreaWidth / designAreaWidth
    if (areaScale > 1.0) then areaScale = 1.0 end
    return areaScale
end

local function refreshBlackShopData(self, dataList)
    if(dataList) then
        local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_BLACK_SHOP_BUY)
        if(repeatData) then
            for k, goodsData in pairs(dataList) do
                goodsData:setUseNum(0)
                if(repeatData[goodsData:getPos()] ~= nil) then
                    goodsData:setUseNum(1)
                end
            end
        else 
            for k, goodsData in pairs(dataList) do
                goodsData:setUseNum(0)
            end
        end
    end
end

local function buySuccess(self, data)
    print("BlackShopPanel buySuccess")
    -- dump(data)

    if(self._leftGrid)then 
        self._leftGrid:hideSelect()
        self._leftGrid = nil 
    end 

    UI.WaitingLayer:hideWaiting()

    -- 处理一下数据修改
    local goodsID = nil
    self._shopDataList = data

    refreshBlackShopData(self, self._shopDataList)

    if(self._shopDataList) then
        self._shopGridList:setData(self._shopDataList)
        self._shopGridList:scrollToTop()
        if(#self._shopDataList > 0 )then
            self._buyEndLabel:setVisible(false)
        else
            self._buyEndLabel:setVisible(true)
        end
    else
        self._buyEndLabel:setVisible(true)
    end

    self._refresWaitingTime = GameDataManager:getInstance():getBlackShopRefreshWaitingTime()
    self._refresWaitingTime = self._refresWaitingTime + 2
    print("local function buySuccess", self._refresWaitingTime)
    -- self._bagGridList:changeBagIndex(3)
end

function BlackShopPanel:ctor()
    BlackShopPanel.super.ctor(self, UIType.BLACK_SHOP_PANEL, COM_RES_LIST, LEFT_WIDTH, LEFT_HEIGHT)
    self._shopGridList = nil
    self._buyEndLabel = nil
    self._bagGridList = nil
    self._isScrolling = false
    self._isDraging = false
    self._leftGrid = nil 

    self._waitingTime = 0

    self._runTime = 0.2
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_BLACK_SHOP_DATA_CHANGE, self, buySuccess)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_BLACK_SHOP_EXCHANGE_RESULT, self, self.exchangeResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_BLACK_SHOP_ACTIVITY_REFRESH, self, self.onActivityRefresh)  
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.activityRefresh)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.currencyChange)

    -- TODO 优化获取当前楼层
    -- local level = GameMapManager:getInstance():getMapData().level
    -- print(string.format("BlackShopPanel:onInitView() level=%d",level))
    local shopDataList = MasterDataManager:getBlackMarketData()
    self._shopDataList = shopDataList
    refreshBlackShopData(self, self._shopDataList)

    self._refresWaitingTime = GameDataManager:getInstance():getBlackShopRefreshWaitingTime()
    -- 用于及时刷新页面
    if(self._refresWaitingTime > 0) then
        self._refresWaitingTime = self._refresWaitingTime + 2
    end
    print("BlackShopPanel:ctor", self._refresWaitingTime)
    -- self._refresWaitingTime = 10
    if(self._refresWaitingTime <=0) then
        GameManager:refreshBlackShop(self._spriteID)
    else 
        if(self._shopDataList == nil or #self._shopDataList == 0) then
            GameManager:refreshBlackShop(self._spriteID)
        end
    end
    
    Avalon.Scheduler:scheduleUpdate(self, self.refreshTime)
	
end

function BlackShopPanel:dtor()
    BlackShopPanel.super.dtor(self)
    self._shopGridList = nil
    self._buyEndLabel = nil
    self._bagGridList = nil
    self._isScrolling = false
    self._isDraging = false
    self._leftGrid = nil 

    self._waitingTime = 0
    if(not tolua.isnull(self.confirmDialog)) then 
        self.confirmDialog:removeFromParent()
        self.confirmDialog = nil
    end
    
    UI.WaitingLayer:hideWaiting()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_BLACK_SHOP_DATA_CHANGE, self, buySuccess)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_BLACK_SHOP_EXCHANGE_RESULT, self, self.exchangeResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_BLACK_SHOP_ACTIVITY_REFRESH, self, self.onActivityRefresh)  
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.activityRefresh)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.currencyChange)

    Avalon.Scheduler:unscheduleUpdate(self, self.refreshTime)

    GameManager:npcInteractionEnd(self._spriteID)

end

-- public:
-- 初始化
function BlackShopPanel:init(spriteID)
    self:setInterceptTouches(true)
    self:setTouchEnable(true)

    self._spriteID = spriteID

    BlackShopPanel.super.init(self)
end

-- 模版函数：初始化组建的视图
function BlackShopPanel:onInitView()
    local scale = computeLayoutScale(winSize.width, LAYOUT_DESIGN_WIDTH)

    local runTime = self._runTime

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:centerLeft(0)
    contentLayout:setSize(winSize.width, winSize.height)
    contentLayout:setScale(scale)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    --添加左边商店相关数据
    local titleLayout = UI.Component:create()
    titleLayout:init()
    titleLayout:setSize(LEFT_WIDTH, LEFT_HEIGHT)
    titleLayout:centerLeft(0)
    self._contentLayout:addChild(titleLayout)
    self._titleLayout = titleLayout

    -- 背景框
    local shopImageBG = UI.Image:create()
    shopImageBG:init("ui_shop_bg.png")

    shopImageBG:setTouchEnable(true)
    titleLayout:addChild(shopImageBG, 1)

    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:setSize(200, 544)
    leftLayout:leftBottom(47, 18)
    shopImageBG:addChild(leftLayout)

    -- 底部装饰
    local bottomEstrade = UI.Image:create()
    bottomEstrade:init("ui_shop_estrade.png")
    bottomEstrade:centerBottom(0)
    leftLayout:addChild(bottomEstrade)

    -- 左边组件
    local gridList = UI.GridList:create()
    gridList:enableCreateBg(true, "ui_shop_lattice.png")
    gridList:init(UI.BlackShopGrid, 2, 4, SHOP_LAYOUT.GOODS_GRID_WIDTH, SHOP_LAYOUT.GOODS_GRID_HEIGHT, SHOP_LAYOUT.GOODS_GRID_HORIZONTAL_SPACE, SHOP_LAYOUT.GOODS_GRID_VERTICAL_SPACE, SHOP_LAYOUT.GOODS_GRID_PADDING_SPACE)
    gridList:setSize(200 + 28, 471)
    gridList:centerBottom(70)
    gridList:setCallbackForGridDragBegan(self, self.shopDragBeganCallback)
    gridList:setCallbackForGridDragMoved(self, self.shopDragMovedCallback)
    gridList:setCallbackForGridDragEnded(self, self.shopDragEndedCallback)
    gridList:setCallbackForGridClick(self, self.shopClickCallback)
    self._shopGridList = gridList
    leftLayout:addChild(gridList)
    gridList:setScrollBarEnabled(true)
    gridList:setScrollBarWidth(5)
    gridList:setScrollBarColor(UI.SLIDER_COLOR_Light)
    gridList:setCircleVisible(false)

    -- 遮罩
    local mask = UI.Image:create()
    mask:init("ui_shop_gradually_2.png")
    mask:centerBottom(63)
    leftLayout:addChild(mask)

    local gaveLock = UI.Image:create()
    gaveLock:init("ui_shop_gavelock.png")
    gaveLock:centerBottom(0)
    leftLayout:addChild(gaveLock)

    -- 添加售罄的标志
    local buyEndLabel = UI.Text:create()
    buyEndLabel:init(LanguageManager:getInstance():getLocalString(1110251), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_155_155_155)
    -- buyEndLabel:init("1234")
    -- buyEndLabel:leftUp(115, 317)
    -- buyEndLabel:setTextCenter()
    buyEndLabel:centerBottom(328 - buyEndLabel:getContentSize().height/2)
    leftLayout:addChild(buyEndLabel)
    self._buyEndLabel = buyEndLabel
    

    if(#self._shopDataList > 0 )then
        self._buyEndLabel:setVisible(false)
    end
    gridList:setData(self._shopDataList)

    -- TODO 添加倒计时表现处理
    -- 添加倒计时
    -- local titleLabel = UI.Text:create()
    -- titleLabel:init(LanguageManager:getInstance():getLocalString(1110394), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    -- titleLabel:centerBottom(43-titleLabel:getContentSize().height/2)
    -- leftLayout:addChild(titleLabel)

    local clockIcon = AvalonUtil.createClockAnimation()
    clockIcon:centerLeft(- clockIcon:getContentSize().width - 4)
    leftLayout:addChild(clockIcon) 

    -- 倒计时
    local timeLabel = UI.Text:create()
    timeLabel:init("00:00:00", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    -- timeLabel:centerBottom(32-timeLabel:getContentSize().height/2)
    timeLabel:centerLeft(clockIcon:getContentSize().width + 4)
    clockIcon:addChild(timeLabel)
    self._timeLabel = timeLabel

    clockIcon:leftBottom(leftLayout:getContentSize().width /2 - (self._timeLabel:getContentSize().width + clockIcon:getContentSize().width) /2 , 30-timeLabel:getContentSize().height/2)

    --刷新按钮
    self._btnRefresh = UI.Button:create()
    self._btnRefresh:init("ui_btn_businessperson_0.png","ui_btn_businessperson_1.png","ui_btn_businessperson_2.png")
    self._btnRefresh:leftBottom(200, 29)
    self._btnRefresh:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        -- TODO 请求刷新
        -- GameManager:refreshBlackShop(self._spriteID)
        local priceStr = self._refreshCostText:getText()
        if(priceStr and type(priceStr) == "string") then
            local price = tonumber(priceStr)
            local useItemId = tonumber(ConfigManager:getGeneralForKey("BlackMarketReFreshID"))
            local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
            local useItemCost = 1
            if (goodNumber < useItemCost and not Avalon.MathUtil:checkDiamonEnough(price, GameDataManager:getInstance():getDiamond())) then
                -- 钻石不够
                UI.TipsLayer:onDiamondNotEnough()
            else 
                if RoleBehaviorManager:blackShopNpcCheck() then
                    printWarn(" been blocked when using black shop npc function refresh !")
                    return
                end
                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                Net.NetNPCSystem:ManualRefreshBlackMarket(self._spriteID)
            end
        end 
    end)

    local bgAnimation = UI.Animation:create()
    bgAnimation:init("effect_ui_b_5common_businessperson_button.json", "effect_ui_b_5common_businessperson_button.atlas")
    -- bgAnimation:setSize(18, 41)
    bgAnimation:setInnerOffset(-2, -2)
    bgAnimation:center()
    bgAnimation:setAnimation("idle", true)
    self._btnRefresh:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self._btnRefresh, function()
        if(not tolua.isnull(bgAnimation)) then
            bgAnimation:setAnimation("trigger_begin", false)
        end
    end)
    self._btnRefresh:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self._btnRefresh, function()
        -- bgAnimation:setAnimation("trigger_end", false)
        if(not tolua.isnull(bgAnimation)) then
            bgAnimation:setAnimation("idle", true)
        end
    end)
    self._btnRefresh:addEventListener(UI.Event.BUTTON_ENABLE, self._btnRefresh, function()
        if(not tolua.isnull(bgAnimation)) then
            bgAnimation:setAnimation("idle", true)
        end
    end)
    self._btnRefresh:addEventListener(UI.Event.BUTTON_DISABLE, self._btnRefresh, function()
        if(not tolua.isnull(bgAnimation)) then
            bgAnimation:setAnimation("idle", true)
        end
    end)

    self._btnRefresh:addChild(bgAnimation)
    leftLayout:addChild(self._btnRefresh)
    self._btnRefresh:setVisible(false)

    -- 
    local iconSprite = UI.Image:create()
    iconSprite:init("symbol_gaming_diamond.png")
    iconSprite:leftBottom(10,11)
    iconSprite:setScale(0.8)
    self._refreshIconSprite = iconSprite
    self._btnRefresh:addChild(iconSprite, 10)

    local costText = UI.Text:create()
    costText:init("100", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_220_182_80)
    costText:leftBottom(36, 5)
    costText:setAnchorPoint(0, 0.5)
    costText:rotate(5)
    self._refreshCostText = costText
    self._btnRefresh:addChild(costText, 11)

    -- 标签
    local refreshSprite = UI.Image:create()
    refreshSprite:init("ui_btn_refresh_0.png")
    refreshSprite:leftBottom(30,30)
    self._btnRefresh:addChild(refreshSprite, 10)

    -- 右边背包数据
    local bagList = UI.BagGoodsPanel:create(nil,false,false)
    bagList:init(self._spriteID, GameBagUIType.BLACK_SHOP)
    -- bagList:centerRight(-bagList:getSize())
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)

    self._bagGridList = bagList
    self._contentLayout:addChild(bagList,2)
    bagList:setUseLock(false)

    shopImageBG:setTouchEnable(true)

    GameManager:showNPCInfomation(self._spriteID, LanguageManager:getInstance():getLocalString(1110420))

    self:refreshRefreshBtn()

    self:setDoorNode(titleLayout, bagList)
end

function BlackShopPanel:refreshRefreshBtn()
    if(self._btnRefresh) then 
        local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_BlackMarket)
        if(activityData and activityData:isInEffect()) then 
            local blackData = activityData:getBlackData()
            if(blackData and blackData:judgeToEffect()) then 
                self._btnRefresh:setVisible(true)

                local useItemId = tonumber(ConfigManager:getGeneralForKey("BlackMarketReFreshID"))
                local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
                local useItemCost = 1
                if goodNumber >= useItemCost then
                    self._btnRefresh:enable()
                    self._refreshIconSprite:setScale(0.7)
                    self._refreshIconSprite:setVisible(true)
                    self._refreshCostText:setVisible(true)
                    self._refreshCostText:setText(useItemCost)
                    self._refreshCostText:setFontColor(UI.FONT_COLOR_220_182_80)
                    local icon = GoodsDataManager:createLocalGoodsData(useItemId):getSmallIconName()
                    self._refreshIconSprite:setSpriteName(icon)

                    local left = (self._btnRefresh:getContentSize().width - self._refreshIconSprite:getContentSize().width * self._refreshIconSprite:getScale() - self._refreshCostText:getContentSize().width - 8) / 2
                    self._refreshIconSprite:leftBottom(left, 4)
                    self._refreshCostText:leftBottom(self._refreshIconSprite:getLeft() + self._refreshIconSprite:getContentSize().width * self._refreshIconSprite:getScale() + 4, self._refreshCostText:getBottom())
                elseif (blackData:getUseNum() < blackData:getRefreshNum()) then 
                    self._btnRefresh:enable()
                    self._refreshIconSprite:setVisible(true)
                    self._refreshCostText:setVisible(true)
                    self._refreshIconSprite:setScale(0.8)
                    local costDiamond = blackData:getCostDiamond()
                    local cost = 0
                    if(#costDiamond < blackData:getUseNum() + 1) then
                        cost = costDiamond[#costDiamond]
                    else 
                        cost = costDiamond[blackData:getUseNum() + 1]
                    end

                    local color = UI.FONT_COLOR_220_182_80
                    if(not Avalon.MathUtil:checkDiamonEnough(cost, GameDataManager:getInstance():getDiamond())) then 
                        color = UI.FONT_COLOR_NOT_ENOUGH
                    end

                    self._refreshCostText:setText(tostring(cost))
                    self._refreshCostText:setFontColor(color)
                    self._refreshIconSprite:setSpriteName("symbol_gaming_diamond.png")
                    local left = (self._btnRefresh:getContentSize().width - self._refreshIconSprite:getContentSize().width * self._refreshIconSprite:getScale() - self._refreshCostText:getContentSize().width - 8) / 2
                    self._refreshIconSprite:leftBottom(left, 8.5)
                    self._refreshCostText:leftBottom(self._refreshIconSprite:getLeft() + self._refreshIconSprite:getContentSize().width * self._refreshIconSprite:getScale() + 4, self._refreshCostText:getBottom())
                else
                    self._btnRefresh:disable()
                    self._refreshIconSprite:setVisible(false)
                    self._refreshCostText:setVisible(false)
                end 



            else 
                self._btnRefresh:setVisible(false)
            end 
        else 
            self._btnRefresh:setVisible(false)
        end
    end 
end

-- 刷新活动按钮
function BlackShopPanel:onActivityRefresh()
    UI.WaitingLayer:hideWaiting()
    self:refreshRefreshBtn()
end

function BlackShopPanel:activityRefresh()
    self:refreshRefreshBtn()
end

-- 模版函数：组件尺寸更新
function BlackShopPanel:onSizeChanged(originalWidth, originalHeight)

end

-- 更新组件视图
--function BlackShopPanel:updateView(...)
--end

-- 刷新显示
function BlackShopPanel:refreshTime(dt)
    if(self._timeLabel) then
        if(self._refresWaitingTime > 0) then
            self._refresWaitingTime =  self._refresWaitingTime - dt
            self._waitingTime = 0
            if(self._refresWaitingTime <= 0) then
                GameManager:refreshBlackShop(self._spriteID)
            end
        else
            -- 这里处理如果时间到了就每10秒钟请求一次
            self._waitingTime = self._waitingTime + dt
            if(self._waitingTime > 10) then
                self._waitingTime = 0
                self._refresWaitingTime = 0
                -- 触发请求刷新商品消息
                GameManager:refreshBlackShop(self._spriteID)
            end
        end

        local str = "00:00:00"
        if(self._refresWaitingTime > 0) then
            local hour = math.modf(self._refresWaitingTime / SECONDS_ONE_HOUR)
            local yu = self._refresWaitingTime % SECONDS_ONE_HOUR
            local minute = math.modf(yu/60)
            yu = yu % 60
            local second = math.modf(yu/1)
            str = string.format("%d:%d:%d", hour, minute, second)
        end

        self._timeLabel:setText(str)
    end
end

function BlackShopPanel:shopDragBeganCallback(grid, touchPosition)
    -- print("BlackShopPanel:dragBeganCallback")
    self._isDraging = true
    if(not tolua.isnull(grid)) then
        grid:hideSelect()
    end
    if(self._bagGridList) then
        self._bagGridList:showMove()
    end
    -- self.dragSpine:setVisible(true)
    self._bagGridList:setSpineBgVisible(true)
end

function BlackShopPanel:shopDragMovedCallback(grid, touchPosition)
    -- print("BlackShopPanel:dragMovedCallback")
    if(self._shopGridList) then 
        self._shopGridList:changeInSideStatus( not self._shopGridList:checkTouchPosition(touchPosition))
    end
end

function BlackShopPanel:shopDragEndedCallback(grid, touchPosition)
    -- print("BlackShopPanel:dragEndedCallback",grid,touchPosition)
    self._isDraging = false
    if(self._shopGridList) then
        Avalon.AudioManager:playSound("1505")

        if(self._shopGridList:checkTouchPosition(touchPosition) == false) then
            -- 处理购买
            if(grid) then
                local goodsData = grid:getData()
                if(goodsData) then
                    self:sendBuyRequest(goodsData,1, grid)
                end
            end
        end
    end

    if(self._bagGridList) then
        self._bagGridList:hideMove()
    end
    -- self.dragSpine:setVisible(false)
    self._bagGridList:setSpineBgVisible(false)
end

function BlackShopPanel:sendBuyRequest(goodsData,num, grid)
    -- print("BlackShopPanel:sendBuyRequest ",goodsData:getGoodsID(),num)
    if(self._leftGrid)then 
        self._leftGrid:hideSelect()
        self._leftGrid = nil 
    end 

    -- TODO 先判断背包是否够用
    local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
    if(freePacketNum > 0) then
        -- 处理发送购买消息
        price = GameDataManager:getInstance():calculationShopGoldPriceSale(goodsData:getBuyPrice(), goodsData:getCostType())
        
        local useDiamond = false
        local price = price * num
        local enough = true
        if(goodsData:getCostType() == GOODS_COST_TYPE.GOLD) then
            if(price > GameDataManager:getInstance():getCurCoin()) then
                -- 金币不够
                -- UI.UIManager:onGlodNotEnough()
                UI.ScrollBar:createByText(UI.TEXT_1110389)
                enough = false
            end
        elseif (goodsData:getCostType() == GOODS_COST_TYPE.GEM) then
            if(not Avalon.MathUtil:checkDiamonEnough(price, GameDataManager:getInstance():getDiamond())) then
                -- 钻石不够
                UI.TipsLayer:onDiamondNotEnough()
                -- UI.ScrollBar:createByText(UI.TEXT_1110390)
                enough = false
            end
            useDiamond = true
        end
        if(enough) then
            if RoleBehaviorManager:blackShopNpcCheck() then
                printWarn(" been blocked when using black shop npc function buy goods ! goodsId = "..goodsData:getId())
                return
            end
            local isNotice = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.isNoticeDiamondBuyItem..GameDataManager:getInstance():getMasterPK(), true) 
            if useDiamond and isNotice and num == 1 then
                self.confirmDialog = UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(UI.TEXT_1212238, function(isSelect)
                    self.confirmDialog = nil
                    if isSelect then
                        cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeDiamondBuyItem..GameDataManager:getInstance():getMasterPK(), false)  
                    end
                    goodsData:setUseNum(1)
                    MasterDataManager:insertRepeatHandleData(RepeatHandleType.BAG_BLACK_SHOP_BUY, goodsData:getPos(), true)
                    GameManager:sendBlackShopFunction(goodsData, self._spriteID)
                    if(not tolua.isnull(grid)) then
                        grid:updateView()
                    end
                    UI.WaitingLayer:showWaiting(true)
                    Avalon.AudioManager:playSound("1504")
                end, function(isSelect)
                    self.confirmDialog = nil
                end, nil, nil, true, price)
            else
                MasterDataManager:insertRepeatHandleData(RepeatHandleType.BAG_BLACK_SHOP_BUY, goodsData:getPos(), true)
                goodsData:setUseNum(1)
                GameManager:sendBlackShopFunction(goodsData, self._spriteID)
                if(not tolua.isnull(grid)) then
                    grid:updateView()
                end
                if(useDiamond) then
                    UI.WaitingLayer:showWaiting(true)
                end
                Avalon.AudioManager:playSound("1504")
            end
            
        end
    else
        -- local tips = UI.Tips:createTips(LanguageManager:getInstance():getLocalString(1110396) ,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL,UI.TipsButtonType.TEXT_BUTTON)
        -- tips:addEventListener(UIEvent.DIALOG_CONFIRM,tips, function()
        --    --TODO 清理背包

        -- end)
        UI.ScrollBar:createByTextID(1110793)
        -- UI.UIManager.mTipsLayer:onBagIsFullOnlyConfirm()
    end
end

-- 装备详情的touch事件的处理
local function onEquipmentInfoAreaTouchHandler(self,obj,touchPosition)
    if obj and not tolua.isnull(obj:getGoodsGrid())then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

     -- 更新装备对比区域数据
    if(self._equipmentInfoArea) then
        self._equipmentInfoArea:close()
        self._equipmentInfoArea = nil
    end
    if(self._leftGrid)then 
        self._leftGrid:hideSelect()
        self._leftGrid = nil 
    end 
    if (self._selectedBagGrid) then
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end
end

-- 道具详情的touch事件处理    
local function onPropInfoAreaTouchHandler(self,obj,touchPosition)
    if obj and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    self._propInfoArea:close()
    self._propInfoArea = nil
    if(self._leftGrid)then 
        self._leftGrid:hideSelect()
        self._leftGrid = nil 
    end 
    if (self._selectedBagGrid) then
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end
end

-- 材料详情的touch事件处理
local function onMaterialInfoAreaTouchHandler(self,obj,touchPosition)
    if obj and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    self._materialInfoArea:close()
    self._materialInfoArea = nil
    if(self._leftGrid)then 
        self._leftGrid:hideSelect()
        self._leftGrid = nil 
    end 
    if (self._selectedBagGrid) then
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end
end


function BlackShopPanel:shopClickCallback( grid)
    print("BlackShopPanel:shopClickCallback",self._isDraging)
    if(self._isDraging) then
        return
    end

    if(not tolua.isnull(grid)) then
        if(DEBUG) then
            print("BlackShopPanel:shopClickCallback  3")
        end
        grid:showSelect()
        self._leftGrid = grid

        local goodsData = grid:getData()
        if(DEBUG) then
            print("shopClickCallback ",goodsData:getId())
        end
        if (goodsData) then
            local leftX = 180 +20 + 20 + 40
            -- 装备详情
            local equipmentInfoArea = UI.BlackShopInfoArea:create()
            equipmentInfoArea:init(UI.EquipImageBgType.BIG_TYPE)
            equipmentInfoArea:centerLeft(leftX)
            self._contentLayout:addChild(equipmentInfoArea,9999)
            equipmentInfoArea:setGoodsGrid(grid)
            self._equipmentInfoArea = equipmentInfoArea
            self._equipmentInfoArea:setVisible(true)
            self._equipmentInfoArea:updateView(goodsData)
            self._equipmentInfoArea:setIconSprite(goodsData:getIconName())
            self._equipmentInfoArea:setIconName(goodsData:getTypeName())

            self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onEquipmentInfoAreaTouchHandler)
        end
    end
end

function BlackShopPanel:bagDragBeganCallback(grid, touchPosition)
    print("BlackShopPanel:bagDragBeganCallback")
    if(not tolua.isnull(grid)) then
        grid:hideSelect()
    end
    if(self._leftGrid)then 
        self._leftGrid:hideSelect()
        self._leftGrid = nil 
    end

    -- self.dragSpine:setVisible(true)
    self._bagGridList:setSpineBgVisible(true)
end

function BlackShopPanel:bagDragMovedCallback(grid, touchPosition)
    print("BlackShopPanel:bagDragMovedCallback")
end

function BlackShopPanel:bagDragEndedCallback(grid, touchPosition)
    print("BlackShopPanel:bagDragEndedCallback")

    -- self.dragSpine:setVisible(false)
    self._bagGridList:setSpineBgVisible(false)
    
    if(grid == nil or tolua.isnull(grid)) then
        return
    end

    if(grid) then 
        local goodsData = grid:getData()
        if(goodsData and not goodsData:getIsSellOrDestory()) then 
            UI.ScrollBar:createByText(UI.TEXT_1212596)
            return 
        end
    end

    if(self._bagGridList) then
        if (self._bagGridList:checkTouchPosition(touchPosition) == false) then
            -- 处理卖出TIPS
            local goodsData = grid:getData()
            if(goodsData) then
                Avalon.AudioManager:playSound("1504")
                if RoleBehaviorManager:blackShopNpcCheck() then
                    printWarn(" been blocked when using black shop npc function sell goods ! goodsId = "..goodsData:getId())
                    return
                end
                if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                    or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                    UI.TipsLayer:createDestoryGemStoneTips({goodsData}, function() 
                        UI.TipsLayer:createLostEscapeScrollTips({goodsData}, true, function()
                            if (RoleBehaviorManager:blackShopSellItemCheck()) then
                                GameManager:sellGoodsHandler(goodsData,1,self._spriteID, handler(self, function()
                                    goodsData:setUseNum(goodsData:getUseNum() + 1)
                                    grid:updateView()
                                end))
                            end 
                        end)
                    end)
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM or 
                    goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
                    goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE or 
                    goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
                    if(goodsData:getNum() <= 1) then
                        if (RoleBehaviorManager:blackShopSellItemCheck()) then
                            UI.TipsLayer:createLostEscapeScrollTips({goodsData}, true, function()
                                GameManager:sellGoodsHandler(goodsData, 1, self._spriteID, handler(self, function()
                                    goodsData:setUseNum(goodsData:getUseNum() + 1)
                                    grid:updateView()
                                end))
                            end)
                        end 
                    else
                        function okCallback(num)
                            local sellNum = 0
                            if(num ~= nil) then
                                sellNum = num
                            end
                            if (RoleBehaviorManager:blackShopSellItemCheck()) then
                                UI.TipsLayer:createLostEscapeScrollTips({goodsData}, true, function()
                                    GameManager:sellGoodsHandler(goodsData,sellNum,self._spriteID, handler(self, function()
                                        goodsData:setUseNum(goodsData:getUseNum() + sellNum)
                                        grid:updateView()
                                    end))
                                    
                                end)
                            end 
                        end
                        function cancelCallback()
                            
                        end

                        UI.TipsLayer:onBuyAmount(okCallback, cancelCallback, goodsData:getSellPrice(), GOODS_COST_TYPE.GOLD,goodsData:getNum()- goodsData:getUseNum(),false, true)
                        print("goodsData:getNum()--",goodsData:getNum())
                    end
                end
            end
        end
    end
end

function BlackShopPanel:exchangeResult(data)
    print("BlackShopPanel:exchangeResult", data.flag)
    if(not tolua.isnull(self)) then
        GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.ExchangeBlackMarketResultType", data.flag))

        -- 根据和服务器db的联系，出现该异常的时候重新刷新一遍数据
        if(data.flag == "ExchangeBlackMarketResultType_NoGoods") then 
            GameManager:refreshBlackShop(self._spriteID)
        end
    end
end

function BlackShopPanel:currencyChange()
    self:refreshRefreshBtn()
end




