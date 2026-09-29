------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2020/03/02
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GuildAuctionView = class("GuildAuctionView", UI.HWBtnComponent)
require "app.modules.guildauction.GuildAuctionSellCell"


-- 资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    "ui_town_guild_auction.plist",
}

local COM_WIDTH = 918
local COM_HEIGHT = 590
local zOrder = 1

local StateDefine = {
    CLOSE = 1,
    PROMO = 2,
    OPEN = 3,
    RESULT = 4,
}


function GuildAuctionView:ctor(npcSpriteID)
    GuildAuctionView.super.ctor(
    	self,
    	UI.Type.GUILD_AUCTION,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._npcSpriteID = npcSpriteID

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_AUCTION_INFO_UPDATE, self, self.refreshView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_AUCTION_BUY_UPDATE, self, self.getNewDataFromSvr)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_AUCTION_BUY_SYNC, self, self.getNewDataFromSvr)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_AUCTION_LOG_UPDATE, self, self.refreshView)

    Avalon.Scheduler:scheduleUpdate(self, self.update)

    Net.NetNPCSystem:requestGuildAuctionInfo(self._npcSpriteID)

    performWithDelay(self, function()
        Net.NetNPCSystem:requestGuildAuctionLog(self._npcSpriteID)
    end, 0.1)
end

function GuildAuctionView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.guildauction", "GuildAuction", false)
    GuildAuctionView.super.init(self, ... )
end

function GuildAuctionView:dtor()
    GuildAuctionView.super.dtor(self)
    self:unbindModel()

    Avalon.Scheduler:unscheduleUpdate(self, self.update)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_AUCTION_INFO_UPDATE, self, self.refreshView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_AUCTION_BUY_UPDATE, self, self.getNewDataFromSvr)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_AUCTION_BUY_SYNC, self, self.getNewDataFromSvr)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_AUCTION_LOG_UPDATE, self, self.refreshView)

    reload_script_file_mvc("app.modules.guildauction.GuildAuctionView")
    reload_script_file("app.modules.guildauction.GuildAuctionSellCell")
end

function GuildAuctionView:update(dt)
    -- 刷新倒计时显示
    if self.interval ~= nil then
        if self.interval > 0 then
            if math.modf(self.interval - dt) == math.modf(self.interval)-1 then
                self:processCountDownShow()
            end
            self.interval = self.interval - dt
        else
            self.interval = nil
            self.countDown:setText("")

            Net.NetNPCSystem:requestGuildAuctionInfo(self._npcSpriteID)
        end
    end
end

function GuildAuctionView:processCountDownShow()
    local status = mvc.guildAuctionModel:getClientCurStatus()
    if self.tabIndex == 1 then
        if status == StateDefine.PROMO then
            self.countDown:setText(string.format(UI.TEXT_1213909, self:formatCountDown(math.modf(self.interval))))
        elseif status == StateDefine.OPEN then
            self.countDown:setText(string.format(UI.TEXT_1213886, self:formatCountDown(math.modf(self.interval))))
        end
    elseif self.tabIndex == 2 then
        if status == StateDefine.OPEN then
            self.countDown:setText(string.format(UI.TEXT_1213886, self:formatCountDown(math.modf(self.interval))))
        end
    end
end

function GuildAuctionView:formatCountDown(countDown)
    local str = "00:00:00"
    local hours = math.modf(countDown/SECONDS_ONE_HOUR)
    local minutes = math.modf((countDown-hours*SECONDS_ONE_HOUR)/SECONDS_ONE_MINUTES)
    local seconds = math.modf(countDown%SECONDS_ONE_MINUTES)
    str = string.format("%02d:%02d:%02d", hours, minutes, seconds)
    return str
end

function GuildAuctionView:initStaticData()
    self.tabIndex = 1
    self.oldTabIndex = 1

    self.titleTxt = {
        {UI.TEXT_1213880, UI.TEXT_1213881, UI.TEXT_1213882},
        {UI.TEXT_1213883, UI.TEXT_1213884, UI.TEXT_1213885},
        {"", "", ""},
    }
end


function GuildAuctionView:onInitView()
    self:initStaticData()
    self:resetItemData()
    self.originItemDataLen = #self.itemData

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    require "app.ui.CommonBgLayer"
    local bg = UI.CommonBgLayer:create(true, true, true)
    bg:leftUp(-6, -52)
    contentLayout:addChild(bg, zOrder)
    zOrder = zOrder+1

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(822, 2))
    splitLine:centerUp(82)
    contentLayout:addChild(splitLine, zOrder)
    zOrder = zOrder+1

    -- 倒计时
    local countDown = UI.Text:create()
    countDown:init("",UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_95_10_10)
    countDown:leftBottom(48, 8)
    splitLine:addChild(countDown)
    countDown:hide()
    self.countDown = countDown

    -- 货币组件
    self.currencyPanel = UI.CurrencyPanel:create()
    self.currencyPanel:rightBottom(-50, 0)
    self.currencyPanel:setShowShopButton(true, 52)
    self.currencyPanel:setShowGold(false)
    splitLine:addChild(self.currencyPanel)

    -- 状态提示
    local statusTip = UI.Text:create()
    statusTip:init("",UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_95_10_10)
    statusTip:center(0, 100)
    self.contentLayout:addChild(statusTip, 10)
    self.statusTip = statusTip

    -- title
    self:initTitleTxt(splitLine)
    self:updateTitleTxt()

    self:initTabList()

    self:initItemList()

    self.interval = mvc.guildAuctionModel:getCloseTime()
    self:setToMainView()
end

function GuildAuctionView:initTitleTxt(rootLayer)
    self.titles = {}

    local titleTxt1 = UI.Text:create()
    titleTxt1:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_BLACK)
    titleTxt1:setSize(200, 20)
    titleTxt1:setTextCenter()
    titleTxt1:leftUp(120, 14)
    -- titleTxt1:enableDebugDraw()
    rootLayer:addChild(titleTxt1)

    local titleTxt2 = UI.Text:create()
    titleTxt2:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_BLACK)
    titleTxt2:setSize(200, 20)
    titleTxt2:setTextCenter()
    titleTxt2:leftUp(285, 14)
    -- titleTxt2:enableDebugDraw()
    rootLayer:addChild(titleTxt2)

    local titleTxt3 = UI.Text:create()
    titleTxt3:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_BLACK)
    titleTxt3:setSize(200, 20)
    titleTxt3:setTextCenter()
    titleTxt3:rightUp(90, 14)
    -- titleTxt3:enableDebugDraw()
    rootLayer:addChild(titleTxt3)

    table.insert(self.titles, titleTxt1)
    table.insert(self.titles, titleTxt2)
    table.insert(self.titles, titleTxt3)
end

function GuildAuctionView:updateTitleTxt()
    for k, v in ipairs(self.titles) do
        v:setText(self.titleTxt[self.tabIndex][k])
    end
end

function GuildAuctionView:initTabList()
    local btnIdx = 1
    local btnLayout = UI.Layout:create();
    btnLayout:init()
    btnLayout:setSize(148, 278)
    btnLayout:rightUp(-122, 50)
    self.contentLayout:addChild(btnLayout, zOrder)
    zOrder = zOrder+1
    -- btnLayout:enableDebugDraw()

    local tab1 = UI.Button:create()
    tab1:init("ui_btn_gray2_0.png","ui_btn_gray2_1.png","ui_btn_gray2_0.png")
    tab1:leftUp(0, 0)
    tab1:setText(UI.TEXT_1213887)
    tab1:setTextOffset(5, 0)
    tab1:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_31_30_27)
    tab1:closeClickScale()
    tab1:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.tabIndex == 1 then
            return
        end

        self.tabIndex = 1
        self:updateTabBtnShow()
        self:refreshView()
    end)
    self.tab1 = tab1
    btnLayout:addChild(tab1)

    local tab2 = UI.Button:create()
    tab2:init("ui_btn_gray2_0.png","ui_btn_gray2_1.png","ui_btn_gray2_0.png")
    tab2:leftUp(0, 70)
    tab2:setText(UI.TEXT_1213888)
    tab2:setTextOffset(5, 0)
    tab2:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_31_30_27)
    tab2:closeClickScale()
    tab2:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.tabIndex == 2 then
            return
        end

        self.tabIndex = 2
        self:updateTabBtnShow()
        self:refreshView()
    end)
    self.tab2 = tab2
    btnLayout:addChild(tab2)

    local tab3 = UI.Button:create()
    tab3:init("ui_btn_gray2_0.png","ui_btn_gray2_1.png","ui_btn_gray2_0.png")
    tab3:leftUp(0, 140)
    tab3:setText(UI.TEXT_1213889)
    tab3:setTextOffset(5, 0)
    tab3:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_31_30_27)
    tab3:closeClickScale()
    tab3:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.tabIndex == 3 then
            return
        end

        self.tabIndex = 3
        self:updateTabBtnShow()
        self:refreshView()
    end)
    self.tab3 = tab3
    btnLayout:addChild(tab3)

    self:resolveBtnTextLen()
    self:updateTabBtnShow()
end

function GuildAuctionView:resolveBtnTextLen()
    self.tabArr = {}
    for i = 1, 3 do
        table.insert(self.tabArr, self["tab"..i])
        if self["tab"..i]._text:getContentSize().width > 100 then
            self["tab"..i]:setTextOffset(10, 0)
            self["tab"..i]:setTextWidth(100)
        end
    end
end

function GuildAuctionView:updateTabBtnShow()
    for k, v in ipairs(self.tabArr) do
        if k == self.tabIndex then
            v:press(false)
            v._text:setFontColor(UI.FONT_COLOR_220_211_147)
        else
            v:release()
            v._text:setFontColor(UI.FONT_COLOR_31_30_27)
        end
    end

    self.oldTabIndex = self.tabIndex
end

function GuildAuctionView:initItemList()
    local itemList = UI.TableView.new({}, 814, 420);
    itemList:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    itemList:centerBottom(5000)
    itemList:setDelegate();
    itemList:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    itemList:setBounceable(true);
    itemList:init(0);
    itemList:onUpdateCellSize(function (table,idx)
        return 814, 84;
    end);

    itemList:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.GuildAuctionSellCell.new();
            cell:init(self._npcSpriteID, self.itemData[idx+1], self.tabIndex, self);
        end,
        function(e) 
            printError("------------------------rewardListView2:tableCellAtIndex-----------------error")
        end, 1);

        return cell;
    end);

    itemList:onUpdateCellNumbers(function ()
        return #self.itemData
    end);

    itemList:onTableCellTouched(function(table, cell)
        
    end);

    self.contentLayout:addChild(itemList, zOrder);
    zOrder = zOrder+1

    itemList:reloadData(true);
    -- itemList:enableDebugDraw()

    self.itemList = itemList
end

function GuildAuctionView:refreshView()
    self.interval = mvc.guildAuctionModel:getCloseTime()
    self:resetItemData()
    self:updateTitleTxt()

    if self.tabIndex == 1 then
        self:setToMainView()
    elseif self.tabIndex == 2 then
        self:setToMineView()
    elseif self.tabIndex == 3 then
        self:setToLogView()
    end
end

function GuildAuctionView:resetItemData()
    self.itemData = {}

    if self.tabIndex == 1 then
        self.itemData = mvc.guildAuctionModel:getItemList()
    elseif self.tabIndex == 2 then
        local allItems = mvc.guildAuctionModel:getItemList()
        for k, v in ipairs(allItems) do
            if v.selfPrice > 0 then
                table.insert(self.itemData, v)
            end
        end
    elseif self.tabIndex == 3 then
        self.itemData = mvc.guildAuctionModel:getLogData()
    end
end

function GuildAuctionView:showSellItems()
    local offsetX = {36, 144, 254, 362, 470}
    local bg = self.contentLayout:getChildByName("NotOpenBg")
    if bg then
        bg:center()

        if #self.itemData > self.originItemDataLen then
            for i = 1, 5 do
                local itemBg = bg:getChildByName("ItemBg" .. i)
                local goodsGrid = itemBg:getChildByName("GoodsGrid")
                local question = itemBg:getChildByName("Question")

                if goodsGrid then
                    local goodsData = GoodsDataManager:createLocalGoodsData(self.itemData[i].id)
                    goodsData:setNum(self.itemData[i].num)
                    goodsData:setIsNew(false)
                    goodsData.isHaveGet = false
                    goodsGrid:setData(goodsData)
                    goodsGrid:updateView()
                elseif self.itemData[i] and question then
                    question:removeFromParent()

                    local newGoodsGrid = UI.GoodsGrid:create()
                    newGoodsGrid:center()
                
                    local goodsData = GoodsDataManager:createLocalGoodsData(self.itemData[i].id)
                    goodsData:setNum(self.itemData[i].num)
                    goodsData:setIsNew(false)
                    goodsData.isHaveGet = false
                    newGoodsGrid:init(goodsData)
                    newGoodsGrid:showInfoArea(false, false)
                    newGoodsGrid:setName("GoodsGrid")
                    itemBg:addChild(newGoodsGrid, 1)
                end
            end

            self.originItemDataLen = #self.itemData
        end
    else
        local notOpenBg  = UI.Image:create();
        notOpenBg:init("ui_guild_auction_closed_box.png");
        notOpenBg:center();
        notOpenBg:setName("NotOpenBg")
        self.contentLayout:addChild(notOpenBg, zOrder);
        zOrder = zOrder+1
        self.notOpenBg = notOpenBg

        for i = 1, 5 do
            local itembg = UI.Image:create()
            itembg:init("ui_guild_auction_box_0.png")
            itembg:centerLeft(offsetX[i])
            itembg:setName("ItemBg" .. i)
            self.notOpenBg:addChild(itembg)

            if self.itemData[i] then
                local goodsGrid = UI.GoodsGrid:create()
                goodsGrid:center()
            
                local goodsData = GoodsDataManager:createLocalGoodsData(self.itemData[i].id)
                goodsData:setNum(self.itemData[i].num)
                goodsData:setIsNew(false)
                goodsData.isHaveGet = false
                goodsGrid:init(goodsData)
                goodsGrid:showInfoArea(false, false)
                goodsGrid:setName("GoodsGrid")
                itembg:addChild(goodsGrid, 1)
            else
                local question = UI.Image:create()
                question:init("ui_guild_auction_nothing.png")
                question:center()
                question:setName("Question")
                itembg:addChild(question)
            end
        end
    end
end

function GuildAuctionView:setToMainView()
    local status = mvc.guildAuctionModel:getClientCurStatus()
    if status == StateDefine.CLOSE then
        self:showSellItems()

        self.currencyPanel:hide()
        self.countDown:hide()

        self.statusTip:center(0, 100)
        self.statusTip:show()
        self.statusTip:setText(UI.TEXT_1213890)

        self.itemList:centerBottom(5000)
        for k, v in ipairs(self.titles) do
            v:hide()
        end
    elseif status == StateDefine.PROMO then
        self:showSellItems()

        self.statusTip:hide()
        self.itemList:centerBottom(5000)

        for k, v in ipairs(self.titles) do
            v:hide()
        end

        -- 具体值在update里面处理
        self.countDown:show()
    elseif status == StateDefine.OPEN or status == StateDefine.RESULT then
        local bg = self.contentLayout:getChildByName("NotOpenBg")
        -- 检查入会的时间
        local startTime = mvc.guildAuctionModel:getCurStartTime()
        local guildData = MasterDataManager:getGuildData()
        if guildData.joinTime > startTime then
            self.countDown:hide()
            self.currencyPanel:hide()
            for k, v in ipairs(self.titles) do
                v:hide()
            end

            self.statusTip:center()
            self.statusTip:show()
            self.statusTip:setText(UI.TEXT_1213913)

            self.itemList:centerBottom(5000)

            if bg then
                bg:center(0, 1000)
            end

            return
        end

        if #self.itemData > 0 then
            for k, v in ipairs(self.titles) do
                v:show()
            end
            self.statusTip:hide()

            -- 具体值在update里面处理
            self.countDown:show()

            self.currencyPanel:show()

            self.itemList:centerBottom(50)
            self.itemList:reloadData(true)

            if bg then
                bg:center(0, 1000)
            end
        else
            self.statusTip:center()
            self.statusTip:show()
            self.statusTip:setText(UI.TEXT_1213910)

            self.itemList:centerBottom(5000)

            if bg then
                bg:center()
            else
                local notOpenBg  = UI.Image:create();
                notOpenBg:init("ui_guild_auction_closed_box.png");
                notOpenBg:center();
                notOpenBg:setName("NotOpenBg")
                self.contentLayout:addChild(notOpenBg, 9);
            end

            for k, v in ipairs(self.titles) do
                v:hide()
            end
        end

        if status == StateDefine.RESULT then
            self.countDown:setText(UI.TEXT_1213891)
            self.currencyPanel:hide()
        end
    end
end

function GuildAuctionView:setToMineView()
    local status = mvc.guildAuctionModel:getClientCurStatus()
    local bg = self.contentLayout:getChildByName("NotOpenBg")
    if bg then
        bg:center(0, 1000)
    end

    if status == StateDefine.CLOSE or status == StateDefine.PROMO then
        self.statusTip:center()
        self.statusTip:show()
        self.statusTip:setText(UI.TEXT_1212339)

        self.countDown:hide()
        self.currencyPanel:hide()
        self.itemList:centerBottom(5000)
    elseif status == StateDefine.OPEN or status == StateDefine.RESULT then
        -- 是否有自己的出价
        if #self.itemData == 0 then
            self.itemList:centerBottom(5000)
            for k, v in ipairs(self.titles) do
                v:hide()
            end

            self.statusTip:center()
            self.statusTip:show()
            self.statusTip:setText(UI.TEXT_1212339)
            return
        end

        self.statusTip:hide()
        self.countDown:show()
        self.itemList:centerBottom(50)
        self.itemList:reloadData(true)
    end
end

function GuildAuctionView:setToLogView()
    self.countDown:hide()
    self.currencyPanel:hide()
    self.statusTip:hide()

    local bg = self.contentLayout:getChildByName("NotOpenBg")
    if bg then
        bg:center(0, 1000)
    end

    if #self.itemData == 0 then
        self.itemList:centerBottom(5000)
        for k, v in ipairs(self.titles) do
            v:hide()
        end

        self.statusTip:center()
        self.statusTip:show()
        self.statusTip:setText(UI.TEXT_1212339)
        return
    end

    self.itemList:centerBottom(50)
    self.itemList:reloadData(true)
end

function GuildAuctionView:getNewDataFromSvr()
    Net.NetNPCSystem:requestGuildAuctionInfo(self._npcSpriteID)
end

function GuildAuctionView:bindModel()

end


function GuildAuctionView:unbindModel()

end

return GuildAuctionView
