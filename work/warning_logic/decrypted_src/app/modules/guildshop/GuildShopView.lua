------------------------------------------------------------------------------
--author: CMonk
--date	: 2019/05/28
--desc	: 
------------------------------------------------------------------------------

local GuildShopCellRow = require("app.modules.guildshop.GuildShopCellRow")
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GameDataManager = require("app.game.GameDataManager")

local GuildShopView = class("GuildShopView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_general_shopping.plist",
    "ui_town_catfood.plist",
    "ui_town_guild_general.plist",
    "ui_town_guild_shop.plist"
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local LAYOUT_DESIGN_WIDTH = 1136
local LAYOUT_DESIGN_HEIGHT = 640
local MEDAL_ICON = "symbol_guild_contribution_icon_medal.png"
local DIAMOND_ICON = "symbol_gaming_diamond.png"
local animationName = {
    "effect_ui_general_guild_shangdian_lv",
    "effect_ui_general_guild_shangdian_cheng",
    "effect_ui_general_guild_shangdian_zi"
}
local layoutUtil

local UNLOCK_FLAG = PublicDefine.UnlockFunctionType.UnlockFunctionType_PrivateGuildShop

function GuildShopView:ctor(npcID)
    GuildShopView.super.ctor(
    	self,
    	UI.Type.GUILD_SHOP,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._npcID = npcID
    self._data = {}
    self.randomShopInit = false
    self.buyItemIdx = 0
    self.autoRefresh1 = false
    self.autoRefresh2 = false

    Avalon.Scheduler:scheduleUpdate(self, self.update)
    -- layoutUtil = UIUtil:createAutoUILayout("GuildShopView","app.modules.guildshop.GuildShopPosConfig", true)

    performWithDelay(self, function()
        mvc.guildShopController:requestNewInfo(self._npcID)
    end, 0.1)
end

function GuildShopView:dtor()
    GuildShopView.super.dtor(self)
    self:unbindModel()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    reload_script_file_mvc("app.modules.guildshop.GuildShopView")
    -- reload_script_file("app.modules.guildshop.GuildShopCellRow")
    -- reload_script_file("app.modules.guildshop.GuildShopCellItem")
end

function GuildShopView:update(dt)
    -- 刷新倒计时显示
    if self.interval1 ~= nil then
        if self.interval1 > 0 then
            if math.modf(self.interval1 - dt) == math.modf(self.interval1)-1 then
                self.countDown1:setText(UI.TEXT_1213907..self:formatCountDown(math.modf(self.interval1)))
            end
            self.interval1 = self.interval1 - dt
        else
            self.interval1 = 0
            self.countDown1:setText("")

            if not self.autoRefresh1 then
                self.autoRefresh1 = true
                UI.ScrollBar:createByText(UI.TEXT_1213906)
                mvc.guildShopController:requestNewInfo(self._npcID, 1)
            end
        end
    end

    if self.interval2 ~= nil then
        if self.interval2 > 0 then
            if math.modf(self.interval2 - dt) == math.modf(self.interval2)-1 then
                self.countDown2:setText(UI.TEXT_1213907..self:formatCountDown(math.modf(self.interval2)))
            end
            self.interval2 = self.interval2 - dt
        else
            self.interval2 = 0
            self.countDown2:setText("")

            if not self.autoRefresh2 then
                self.autoRefresh2 = true
                mvc.guildShopController:requestNewInfo(self._npcID, 1)
            end
        end
    end
end

function GuildShopView:formatCountDown(countDown)
    local str = "00:00:00"
    local hours = math.modf(countDown/SECONDS_ONE_HOUR)
    local minutes = math.modf((countDown-hours*SECONDS_ONE_HOUR)/SECONDS_ONE_MINUTES)
    local seconds = math.modf(countDown%SECONDS_ONE_MINUTES)
    str = string.format("%02d:%02d:%02d", hours, minutes, seconds)
    return str
end

-- 如果界面在打开状态下，服务器推送商品刷新，在此更新
function GuildShopView:beginStock(shopIdx)
    self:updateRedPoint()
    self:updateCountDown()

    if shopIdx == 2 then
        self.midShopData = mvc.guildShopModel:getRandomShopData(1)

        for i = 1, 3 do
            local itemComponent = self.midShopView:getChildByName("Content"..i)
            self:updateOneItem(itemComponent, self.midShopData[i], i)
        end
    elseif shopIdx == 3 then
        self.bottomShopData = mvc.guildShopModel:getRandomShopData(2)

        for i = 1, 3 do
            local itemComponent = self.bottomShopView:getChildByName("Content"..i)
            self:updateOneItem(itemComponent, self.bottomShopData[i], i)
        end
    end
end


function GuildShopView:onInitView()
    self.tabIndex = 1
    self.oldTabIndex = 1

    self:center(-35, 0)

    ------------------现在使用手动填写的方式-----------------
    -- 背景
    require "app.ui.CommonBgLayer"
    local bg = UI.CommonBgLayer:create(true, true)
    bg:center()
    self:addChild(bg)
    self:setSize(bg:getSize())

    -- 公会贡献排版
    self._contribLayout = UI.Layout:create()
    self._contribLayout:init()
    self._contribLayout:setSize(826, 26)
    self._contribLayout:rightBottom(40, 512)
    self:addChild(self._contribLayout)

    -- 刷新
    local refreshBtn = UI.Button:create()
    refreshBtn:init("ui_btn_refresh_0.png", "ui_btn_refresh_0.png", "ui_btn_refresh_0.png")
    refreshBtn:centerLeft(0)
    -- refreshBtn:closeClickScale()
    refreshBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local shopData = ConfigManager:getGuildRandomShopData()
        local price = 0
        local isAllSoldOut = true
        local shopItems = {}
        if self.tabIndex == 2 then
            price = shopData.price[1]
            shopItems = mvc.guildShopModel:getRandomShopData(1)
        elseif self.tabIndex == 3 then
            price = shopData.price[2]
            shopItems = mvc.guildShopModel:getRandomShopData(2)
        end

        for _, v in ipairs(shopItems) do
            if not v.soldout then
                isAllSoldOut = false
                break
            end
        end

        if isAllSoldOut then
            UI.ScrollBar:createByText(UI.TEXT_1213873)
            return
        end

        UI.TipsLayer:onGuildShopRefresh(price.id, price.num, function()
            local goodsData = GoodsDataManager:createLocalGoodsData(price.id)
            if(goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM 
                and goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemDiamond) then
                if not Avalon.MathUtil:checkDiamonEnough(price.num, GameDataManager:getInstance():getDiamond()) then
                    -- 钻石不足
                    local tips = UI.TipsLayer:onDiamondNotEnough()
                    if(tips) then 
                        tips:setZOrder(UI_ZORDER.MAX)
                    end
                    tips:removeFromParent(false)
                    UI.UIManager:getRootNode():addChild(tips)
                    return
                end

                -- TODO:处理其他货币类型
            end

            mvc.guildShopController:requestNewInfo(self._npcID, self.tabIndex)

            UI.ScrollBar:createByText(UI.TEXT_1213906)
        end, nil)
    end)
    self._contribLayout:addComponent(refreshBtn)
    self.refreshBtn = refreshBtn

    -- 倒计时
    local countDown1 = UI.Text:create()
	countDown1:init(UI.TEXT_1213907 .. "00:00:00",UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_159_10_10)
	countDown1:centerLeft(30)
    self._contribLayout:addComponent(countDown1)
    self.countDown1 = countDown1

    local countDown2 = UI.Text:create()
	countDown2:init(UI.TEXT_1213907 .. "00:00:00",UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_159_10_10)
	countDown2:centerLeft(30)
    self._contribLayout:addComponent(countDown2)
    self.countDown2 = countDown2

    -- 贡献文字
    self._contribNumLabel = UI.Text:create()
	self._contribNumLabel:init("",UI.FONT_STANDARD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_170_170_170)
	self._contribNumLabel:floatRight(0)
	self._contribLayout:addComponent(self._contribNumLabel)

    -- 贡献图标
    local icon = UI.Image:create()
    icon:init(MEDAL_ICON)
    icon:floatRight(3)
    self._contribLayout:addComponent(icon)
    self._contribIcon = icon

    -- 分割线
    local splitter = UI.Image9:create()
    splitter:init("ui_scale9image_banner_line_dark2.png", CCRectMake(2,0,1,1), cc.size(859, 2))
    splitter:leftBottom(29, 504)
    self:addChild(splitter)

    -- 货币组件
    local currencyPanel = UI.CurrencyPanel:create(UI.FONT_COLOR_170_170_170)
    currencyPanel:rightBottom(-40, 0)
    currencyPanel:setShowShopButton(true, 52)
    currencyPanel:setShowGold(false)
    splitter:addChild(currencyPanel)
    self.currencyPanel = currencyPanel

    self:initTopShop()

    local midLayout = UI.Layout:create();
    midLayout:init()
    midLayout:setSize(886, 420)
    midLayout:leftUp(50, 20)
    self:addChild(midLayout)
    -- midLayout:enableDebugDraw()
    self.midShopView = midLayout

    local bottomLayout = UI.Layout:create();
    bottomLayout:init()
    bottomLayout:setSize(886, 420)
    bottomLayout:leftUp(50, 20)
    self:addChild(bottomLayout)
    -- bottomLayout:enableDebugDraw()
    self.bottomShopView = bottomLayout

    -- 列表底部遮罩
    local botCover = UI.Image:create()
    botCover:init("ui_shopping_banner_mask.png")
    botCover:setScaleX(0.925)
    botCover:leftBottom(-35, 17)
    self:addChild(botCover)
    self.botCover = botCover

    -- -- 旗帜动画
    -- local flagRight = UI.Animation:create()
    -- flagRight:init("effect_ui_town_guild_guildstore_flag.json", "effect_ui_town_guild_guildstore_flag.atlas", 1);
    -- flagRight:rightBottom(-45, 505)
    -- self:addChild(flagRight)
    -- flagRight:setAnimation("idle", true)

    -- 蜡烛动画
    local candleRight = UI.Animation:create()
    candleRight:init("effect_ui_town_guild_guildstore_candle.json", "effect_ui_town_guild_guildstore_candle.atlas", 1);
    candleRight:rightBottom(-45, 50)
    self:addChild(candleRight)
    candleRight:setAnimation("idle", true)

    self:initTabList()
    self:updateRedPoint()
    self:updateContribLayout()
end

function GuildShopView:updateContribLayout()
    if self.tabIndex == 1 then
        self.refreshBtn:hide()
        self.countDown1:hide()
        self.countDown2:hide()
        self._contribIcon:show()
        self._contribNumLabel:show()
        self._contribLayout:updateView()
        self.currencyPanel:rightBottom(-4000, 0)
        self.botCover:show()
    elseif self.tabIndex == 2 then
        self.refreshBtn:show()
        self.countDown1:show()
        self.countDown2:hide()
        self._contribIcon:show()
        self._contribNumLabel:show()
        self._contribLayout:updateView()
        self.currencyPanel:rightBottom(-4000, 0)
        self.botCover:hide()
    elseif self.tabIndex == 3 then
        self.refreshBtn:hide()
        self.countDown1:hide()
        self.countDown2:show()
        self._contribIcon:hide()
        self._contribNumLabel:hide()
        self.currencyPanel:rightBottom(-44, -5)
        self.botCover:hide()
    end
end

function GuildShopView:initTopShop()
    -- 商品列表
	self.topShopView = UI.TableView:create({}, 855, 463)
    self.topShopView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.topShopView:leftBottom(37, 31)
    self.topShopView:setDelegate()
    self.topShopView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.topShopView:setBounceable(true) 
    self.topShopView:init()
    self.topShopView:onUpdateCellSize(function ()
        return GuildShopCellRow.ROW_WIDTH, GuildShopCellRow.ROW_HEIGHT
    end) 
    self.topShopView:onUpdateCells(function (tableview, idx)
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.GuildShopCellRow.new(self.topShopView)
            cell:setCallback(function(id)
                mvc.guildShopController:requestBuyItem(id, self.tabIndex, self._npcID)
            end)
        end
        local tempD = {}
        for i = 1, GuildShopCellRow.COLUMN_NUM do
        	table.insert(tempD, self._data[idx * GuildShopCellRow.COLUMN_NUM + i])
        end
        xpcall(function()
            cell:onUpdateView(tempD)
        end, 
        function(e) 
            printInfo("IapShopDiamondLayer:tableCellAtIndex, error")
        end, 1)
        return cell
    end)

    self.topShopView:onUpdateCellNumbers(function ()
        return math.ceil(table.nums(self._data) / GuildShopCellRow.COLUMN_NUM)
    end)
    self:addChild(self.topShopView)
    self.topShopView:reloadData()
end

-- 初始商店数据回来后，第一次初始化商店数据
function GuildShopView:initAllRandomData()
    if self.autoRefresh1 then
        self.autoRefresh1 = false

        self:beginStock(2)
        return
    end

    if self.autoRefresh2 then
        self.autoRefresh2 = false

        self:beginStock(3)
        return
    end


    if self.randomShopInit then
        return
    end

    self.randomShopInit = true

    self:updateCountDown()

    self.midShopData = mvc.guildShopModel:getRandomShopData(1)
    self.bottomShopData = mvc.guildShopModel:getRandomShopData(2)

    self:initMidShop()
    self:initBottomShop()
end

function GuildShopView:updateCountDown()
    local shopData = ConfigManager:getGuildRandomShopData()
    local lastRefreshTime = mvc.guildShopModel:getLastRefreshTime()
    local nowTime = GameManager:getNormalServerTime()
    self.interval1 = lastRefreshTime[1] + shopData.refreshTime - nowTime
    self.interval2 = lastRefreshTime[2] + shopData.refreshTime - nowTime
end

function GuildShopView:initMidShop()
    for i = 1, 3 do
        self:insertOneItem(self.midShopView, i, self.midShopData[i])
    end
end

function GuildShopView:initBottomShop()
    for i = 1, 3 do
        self:insertOneItem(self.bottomShopView, i, self.bottomShopData[i])
    end
end

function GuildShopView:insertOneItem(rootLayer, idx, data)
    if(data == nil) then return end
    local contentLayer = UI.Layout:create();
    contentLayer:init()
    contentLayer:setSize(302, 420)
    contentLayer:leftUp(50, 20)
    contentLayer._innerIdx = idx
    if idx == 1 then
        contentLayer:centerLeft(0);
    elseif idx == 2 then
        contentLayer:center();
    else
        contentLayer:centerRight(0);
    end
    contentLayer:setName("Content"..idx)
    rootLayer:addChild(contentLayer)

    -- bg
    local bg  = UI.Image:create();
    bg:init(string.format("ui_guild_shop_banner_%d_2.png", data.frame));
    bg:center();
    bg:setName("bg")
    contentLayer:addChild(bg, 1);

    
    local bgEff = UI.Animation:create()
    bgEff:init(animationName[data.frame]..".json", animationName[data.frame]..".atlas", 1)
    bgEff:center(0, 31)
    contentLayer:addChild(bgEff, 1)
    bgEff:setName("BgEFF")
    bgEff:setAnimation("idle", true)

    -- name
    local name = UI.Text:create()
    name:init(data.name, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_231_176_57)
    local w1 = name:getContentSize().width
    name:centerUp(62)
    name:setWidth(122)
    name:setTextCenter()
    name:autoAdapt()
    if w1 > 122 then
        name:setFontSize(12)
    else
        name:setFontSize(16)
    end
    name:setLineSpacing(-6)
    name:setName("ItemName")
    contentLayer:addChild(name, 2)

    -- soldout bg
    local soldOutBg = UI.Image:create()
    soldOutBg:init("ui_guild_shop_sold_bg.png")
    soldOutBg:leftUp(88, 198)
    soldOutBg:setName("SoldOutBg")
    contentLayer:addChild(soldOutBg, 2)

    -- goods
    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:centerUp(208)

    local goodsData = GoodsDataManager:createLocalGoodsData(data.id)
    goodsData:setNum(data.num)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(true, false)
    if (num == 0) then
        goodsGrid:hideCountLabel()
    end
    contentLayer:addChild(goodsGrid, 2)
    goodsGrid:setName("GoodsGrid")

    if data.soldout then
        goodsGrid:setIsGray()
    else
        goodsGrid:setNormal()

        local slotEff = UI.Animation:create()
        slotEff:init("effect_ui_general_guild_shangdian_xuanzhuanguang.json", "effect_ui_general_guild_shangdian_xuanzhuanguang.atlas", 1);
        slotEff:center()
        goodsGrid:addChild(slotEff, 10)
        slotEff:setName("SlotRingEff")
        slotEff:setAnimation("idle", true)
    end

    -- soldout mask
    local soldOutMask = UI.Image:create()
    soldOutMask:init("ui_guild_shop_sold_mask.png")
    soldOutMask:centerUp(208)
    soldOutMask:setName("SoldOutMask")
    contentLayer:addChild(soldOutMask, 3)

    -- soldout eff
    local eff = UI.Animation:create()
    eff:init("effect_ui_general_guild_shangdian_gaizhang.json", "effect_ui_general_guild_shangdian_gaizhang.atlas", 1);
    eff:rightBottom(96, 140)
    contentLayer:addChild(eff, 10)
    eff:setName("SoldOutEff")
    eff:setAnimation("begin", false)
    -- data.extraContribution = 1000
    if(data.extraContribution  and data.extraContribution > 0) then
        local addGuildLayout = UI.Layout:create();
        addGuildLayout:init()
        addGuildLayout:enableAutoHeight()
        addGuildLayout:enableAutoWidth()
        addGuildLayout:centerBottom(-20)
        addGuildLayout:setName("addGuildLayout")
        contentLayer:addChild(addGuildLayout, 1)

        local iconName = "symbol_guild_tech_icon_medal.png"
        local icon = UI.Image:create()
        icon:init(iconName)
        icon:floatLeft(0)
        addGuildLayout:addComponent(icon)

        local price = UI.Text:create()
        price:init("+"..tostring(data.extraContribution), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_231_176_57)
        price:floatLeft(2)
        price:setTextLeft()
        price:setName("Price")
        addGuildLayout:addComponent(price)
    end

    local btn = UI.Button:create()
    btn:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    -- btn:centerBottom(-50)
    btn:centerBottom(-70)
    btn:closeClickScale()
    btn.buyIdx = idx
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:buyItem(btn.buyIdx)
    end)
    contentLayer:addChild(btn, 2)
    btn:setName("BuyBtn")

    local soldOutTxt = UI.Text:create()
    soldOutTxt:init(UI.TEXT_1213869, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    soldOutTxt:center()
    soldOutTxt:setName("SoldOutTxt")
    btn:addChild(soldOutTxt, 10)

    local costLayout = UI.Layout:create();
    costLayout:init()
    costLayout:enableAutoHeight()
    costLayout:enableAutoWidth()
    costLayout:center()
    costLayout:setName("CostLayout")
    btn:addChild(costLayout, 10)

    local iconName = MEDAL_ICON
    local goodsData = GoodsDataManager:createLocalGoodsData(data.costType)
    local vType = goodsData:getVirtualType()
    if goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then
        if goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemContrib then
            iconName = MEDAL_ICON
        elseif goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemDiamond then
            iconName = DIAMOND_ICON
        end
            -- TODO:如果有其他类型的消耗，更换图标
    end

    local icon = UI.Image:create()
    icon:init(iconName)
    icon:floatLeft(0)
    costLayout:addComponent(icon)

    local price = UI.Text:create()
    price:init(tostring(data.cost), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    price:floatLeft(8)
    price:setTextLeft()
    price:setName("Price")
    costLayout:addComponent(price)

    if data.discount ~= 0 then
        local redLine = UI.Image9:create()
        redLine:init("ui_scale9image_red.png", CCRectMake(0,0,1,1), cc.size(price:getContentSize().width + 5, 2.5))
        redLine:center()
        price:addChild(redLine)
    
        local originPrice = math.floor(data.cost/(100-data.discount)*100)
        local discountPrice = UI.Text:create()
        discountPrice:init(tostring(data.cost), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        discountPrice:floatLeft(8)
        discountPrice:setTextLeft()
        discountPrice:setName("DiscountPrice")
        costLayout:addComponent(discountPrice)

        price:setText(tostring(originPrice))
    end

    self:updateOneItem(contentLayer, data, idx)
end

function GuildShopView:buyItem(btnIdx)
    local itemData = nil
    if self.tabIndex == 2 then
        itemData = self.midShopData[btnIdx]
    elseif self.tabIndex == 3 then
        itemData = self.bottomShopData[btnIdx]
    end

    if not itemData then
        return
    end

    -- 背包检查
    local goodsArr = {}
    local data = {}
    data.goodsID = itemData.id
    data.num = itemData.num
    data.isGolden = true
    table.insert(goodsArr, data)

    if not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) then
        UI.ScrollBar:createByTextID(1111800)
        return
    end

    -- 检查消耗数据
    local masterData = RoleDataManager:getMaster()
    local contribNum = masterData:getGuildContrib()

    local costData = GoodsDataManager:createLocalGoodsData(itemData.costType)
    if costData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then
        if costData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemContrib then
            if contribNum < itemData.cost then
                UI.ScrollBar:createByText(UI.TEXT_1213897)
                return
            end
        elseif costData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemDiamond then
            if not Avalon.MathUtil:checkDiamonEnough(itemData.cost, GameDataManager:getInstance():getDiamond()) then
                -- 钻石不足
                local tips = UI.TipsLayer:onDiamondNotEnough()
                if(tips) then 
                    tips:setZOrder(UI_ZORDER.MAX)
                end
                tips:removeFromParent(false)
                UI.UIManager:getRootNode():addChild(tips)
                return
            end
        end

            -- TODO:如果有其他类型的消耗，判断其他货币
    end

    UI.TipsLayer:onGuildRandomShopBuy(itemData.costType, itemData.cost, function()
        self.buyItemIdx = btnIdx

        Net.NetNPCSystem:requestGuildShopBuy(itemData.id, itemData.num, itemData.idx, self.tabIndex, self._npcID)
    end, nil)
end

function GuildShopView:updateOneItem(contentLayer, data)
    -- bg
    local bg = contentLayer:getChildByName("bg")
    local bgEff = contentLayer:getChildByName("BgEFF")
    local addGuildLayout = contentLayer:getChildByName("addGuildLayout")
    if data.soldout then
        bg:setSpriteName(string.format("ui_guild_shop_banner_%d_2.png", data.frame));
        bg:show()
        bgEff:hide()
        if(addGuildLayout) then 
            addGuildLayout:hide()
        end
    else
        bg:hide()

        bgEff:setAnimationData(animationName[data.frame]..".json", animationName[data.frame]..".atlas", 1)
        bgEff:setAnimation("idle", true)
        bgEff:show()
        if(addGuildLayout) then 
            addGuildLayout:show()
        end
    end

    -- name
    local name = contentLayer:getChildByName("ItemName")
    name:setText(data.name)
    local w1 = name:getContentSize().width
    if w1 > 122 then
        name:setFontSize(12)
    else
        name:setFontSize(16)
    end

    local goodsData = GoodsDataManager:createLocalGoodsData(data.id)
    goodsData:setNum(data.num)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false

    -- item
    local grid = contentLayer:getChildByName("GoodsGrid")
    grid:setData(goodsData)

    local soldOutBg = contentLayer:getChildByName("SoldOutBg")
    local soldOutMask = contentLayer:getChildByName("SoldOutMask")
    local soldOutEff = contentLayer:getChildByName("SoldOutEff")
    local slotRingEff = grid:getChildByName("SlotRingEff")
    -- buyBtn
    local buyBtn = contentLayer:getChildByName("BuyBtn")
    local soldOutTxt = buyBtn:getChildByName("SoldOutTxt")
    local costLayout = buyBtn:getChildByName("CostLayout")
    local price = costLayout:getChildByName("Price")
    local discountPrice = costLayout:getChildByName("DiscountPrice")
    if data.soldout then
        grid:setIsGray()
        buyBtn:disable()

        soldOutTxt:show()
        soldOutMask:show()
        soldOutEff:show()
        soldOutBg:show()
        costLayout:hide()

        if slotRingEff then
            grid:removeChildByName("SlotRingEff")
        end
    else
        grid:setNormal()
        buyBtn:enable()

        soldOutTxt:hide()
        soldOutMask:hide()
        soldOutEff:hide()
        soldOutBg:hide()
        costLayout:show()

        if slotRingEff then
            slotRingEff:show()
        else
            local slotEff = UI.Animation:create()
            slotEff:init("effect_ui_general_guild_shangdian_xuanzhuanguang.json", "effect_ui_general_guild_shangdian_xuanzhuanguang.atlas", 1);
            slotEff:center()
            grid:addChild(slotEff, 10)
            slotEff:setName("SlotRingEff")
            slotEff:setAnimation("idle", true)
        end

        price:setText(tostring(data.cost))
        if data.discount ~= 0 then
            local originPrice = math.floor(data.cost/(100-data.discount)*100)
            if not discountPrice then
                local redLine = UI.Image9:create()
                redLine:init("ui_scale9image_red.png", CCRectMake(0,0,1,1), cc.size(price:getContentSize().width + 5, 2.5))
                redLine:center()
                price:addChild(redLine)

                discountPrice = UI.Text:create()
                discountPrice:init(tostring(data.cost), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
                discountPrice:floatLeft(8)
                discountPrice:setTextLeft()
                discountPrice:setName("DiscountPrice")
                costLayout:addComponent(discountPrice)
            end

            price:setText(tostring(originPrice))
            discountPrice:setText(tostring(data.cost))
            costLayout:updateView()
        end
    end
    grid:updateView()
end

function GuildShopView:initTabList()
    local btnLayout = UI.Layout:create();
    btnLayout:init()
    btnLayout:setSize(148, 278)
    btnLayout:rightUp(-132, 110)
    self:addChild(btnLayout)
    -- btnLayout:enableDebugDraw()

    local tab1 = UI.Button:create()
    tab1:init("ui_btn_gray2_0.png","ui_btn_gray2_1.png","ui_btn_gray2_0.png")
    tab1:leftUp(0, 0)
    tab1:setText(UI.TEXT_1213870)
    tab1:setTextOffset(5, 0)
    tab1:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_31_30_27)
    tab1:closeClickScale()
    tab1:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.tabIndex == 1 then
            return
        end

        self.tabIndex = 1
        self:updateTabBtnShow()
    end)
    self.tab1 = tab1
    btnLayout:addChild(tab1)

    local tab2 = UI.Button:create()
    tab2:init("ui_btn_gray2_0.png","ui_btn_gray2_1.png","ui_btn_gray2_0.png")
    tab2:leftUp(0, 70)
    tab2:setText(UI.TEXT_1213871)
    tab2:setTextOffset(5, 0)
    tab2:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_31_30_27)
    tab2:closeClickScale()
    tab2:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if not RoleDataManager:isUnlockByFunctionType(UNLOCK_FLAG) then
            Game.FunctionUnlockManager:showLockTips(UNLOCK_FLAG)
            return
        end

        self.tab2:removeNewAction()
        Game.FunctionUnlockManager:getInstance():removeNewFlag(UNLOCK_FLAG)
        mvc.guildShopModel:resetRedPoint(1)
        self.redPoint2:hide()

        if self.tabIndex == 2 then
            return
        end

        self.tabIndex = 2
        self:updateTabBtnShow()
    end)
    self.tab2 = tab2
    btnLayout:addChild(tab2)

    local tab3 = UI.Button:create()
    tab3:init("ui_btn_gray2_0.png","ui_btn_gray2_1.png","ui_btn_gray2_0.png")
    tab3:leftUp(0, 140)
    tab3:setText(UI.TEXT_1213872)
    tab3:setTextOffset(5, 0)
    tab3:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_31_30_27)
    tab3:closeClickScale()
    tab3:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if not RoleDataManager:isUnlockByFunctionType(UNLOCK_FLAG) then
            Game.FunctionUnlockManager:showLockTips(UNLOCK_FLAG)
            return
        end

        self.tab3:removeNewAction()
        Game.FunctionUnlockManager:getInstance():removeNewFlag(UNLOCK_FLAG)
        mvc.guildShopModel:resetRedPoint(2)
        self.redPoint3:hide()

        if self.tabIndex == 3 then
            return
        end

        self.tabIndex = 3
        self:updateTabBtnShow()
    end)
    self.tab3 = tab3
    btnLayout:addChild(tab3)

    self:resolveBtnTextLen()
    self:updateTabBtnShow()

    if not RoleDataManager:isUnlockByFunctionType(UNLOCK_FLAG) then
        ToolsUtil:playUnlockAction(self.tab2, nil, true, 10, 12)
        ToolsUtil:playUnlockAction(self.tab3, nil, true, 10, 12)
        return
    end

    if Game.FunctionUnlockManager:getInstance():isShowUnlockAction(UNLOCK_FLAG) then
        self.tab2:disable()
        ToolsUtil:playUnlockAction(self.tab2, function()
            Game.FunctionUnlockManager:getInstance():removeUnlcokActFlag(UNLOCK_FLAG)
            self.tab2:playNewAction(0.8)
            self.tab2:enable()
        end, false, 10, 12)

        self.tab3:disable()
        ToolsUtil:playUnlockAction(self.tab3, function()
            Game.FunctionUnlockManager:getInstance():removeUnlcokActFlag(UNLOCK_FLAG)
            self.tab3:playNewAction(0.8)
            self.tab3:enable()
        end, false, 10, 12)
    elseif Game.FunctionUnlockManager:getInstance():isShowNewAction(UNLOCK_FLAG) then
        self.tab2:playNewAction(0.8)
        self.tab3:playNewAction(0.8)
    else
        self.tab2:removeNewAction()
        self.tab3:removeNewAction()
    end

    self.redPoint2 = AvalonUtil.createRedPoint(self.tab2, 2, 2)
    self.redPoint2:hide()
    self.redPoint3 = AvalonUtil.createRedPoint(self.tab3, 2, 2)
    self.redPoint3:hide()
end

function GuildShopView:updateRedPoint()
    if not RoleDataManager:isUnlockByFunctionType(UNLOCK_FLAG) then
        return
    end

    if mvc.guildShopModel:getNeedRedPoint(1) then
        self.redPoint2:show()
    else
        self.redPoint2:hide()
    end

    if mvc.guildShopModel:getNeedRedPoint(2) then
        self.redPoint3:show()
    else
        self.redPoint3:hide()
    end
end

function GuildShopView:updateTabBtnShow()
    if self.tabIndex == 1 then
        self.topShopView:leftBottom(37, 31)
        self.midShopView:leftBottom(3000, 20)
        self.bottomShopView:leftBottom(3000, 20)
    elseif self.tabIndex == 2 then
        self.topShopView:leftBottom(3000, 31)
        self.midShopView:leftBottom(20, 102)
        self.bottomShopView:leftBottom(3000, 20)
    elseif self.tabIndex == 3 then
        self.topShopView:leftBottom(3000, 31)
        self.midShopView:leftBottom(3000, 20)
        self.bottomShopView:leftBottom(20, 102)
    end

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

    self:updateContribLayout()

    -- 更新贡献
    local masterData = RoleDataManager:getMaster()
    local contribNum = masterData:getGuildContrib()
    self:updateContrib(contribNum)
end

function GuildShopView:resolveBtnTextLen()
    self.tabArr = {}
    for i = 1, 3 do
        table.insert(self.tabArr, self["tab"..i])
        if self["tab"..i]._text:getContentSize().width > 100 then
            self["tab"..i]:setTextOffset(10, 0)
            self["tab"..i]:setTextWidth(100)
        end
    end
end

function GuildShopView:onUpdateView()
    self:updateItemData()
end


function GuildShopView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_DATA_CHNAGE_GUILD_CONTRIB, self, self.onContribChange)
end


function GuildShopView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_DATA_CHNAGE_GUILD_CONTRIB, self, self.onContribChange)
end

function GuildShopView:onContribChange()
    mvc.guildShopController:refreshView()
end

function GuildShopView:updateItemData(data)
    if (data) then
        self._data = data
    end
    
    if (self.topShopView) then
        self.topShopView:reloadData()
    end
end

function GuildShopView:updateContrib(newContrib)
    if (newContrib and self._contribNumLabel and self._contribLayout) then
        local contribString = AvalonUtil:getCommaNumber(newContrib)
        self._contribNumLabel:setText(contribString)
        self._contribNumLabel:autoAdapt()
        if(self._contribIcon) then
            self._contribIcon:refreshPosition()
        end
        self._contribLayout:updateView()
    end
end

return GuildShopView
