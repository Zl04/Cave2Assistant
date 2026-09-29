-- DreamShopLayer.lua
-- Author:lzm
-- 2019年2月28日
-- Using:梦境商店

local ProtobufUtil = require "utils.ProtobufUtil"
require "app.ui.dream.shop.DreamShopCell"
require "app.ui.dream.shop.DreamShopConfirmLayer"
require "app.ui.dream.shop.DreamVaultCell"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"
local SceneManager = require("app.game.SceneManager")
local scheduler = cc.Director:getInstance():getScheduler()

UI = UI or {}

local DreamShopLayer = class("DreamShopLayer", UI.DownShowWin)
UI.DreamShopLayer = DreamShopLayer

local winSize = cc.Director:getInstance():getWinSize()
local VIEW_WIDTH = 1000;
local VIEW_HEIGHT = 580;

local LIST_VIEW_WIDTH = 700;
local LIST_VIEW_HEIGHT = 400;
local LIST_CELL_WIDTH = 135;
local LIST_CELL_HEIGHT = 200;

local BG_NAME1 = "ui_dreamword_bg_2.png";
-- 关闭按钮
local MENU_CLOSE_SPINE_BG_NAME = "effect_ui_package_title_back_bg"
local MENU_CLOSE_SPINE_ICON_NAME = "effect_ui_package_title_back_icon"

local CELL_SIZE = 5 -- 每排可以容纳的单元数量
local ZOrder = 1

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_general_big_number.plist",
    "ui_common_scale9image.plist",
    "ui_town_dream_common.plist",
    "ui_town_dream_btn.plist",
    "ui_general_shop.plist",
    "ui_town_catfood.plist",
    "ui_town_dream_rank.plist",
    "ui_town_dreamword",
}

--构造函数(必备)
function DreamShopLayer:ctor()
    --窗口大小
    DreamShopLayer.super.ctor(self, UIType.DREAM_SHOP_LAYER, COM_RES_LIST, VIEW_WIDTH, VIEW_HEIGHT)
    self:registerListener();
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self, self.scheduleUpdateTime), 60, false)
end

--虚构函数,destroy时调用(必备)
function DreamShopLayer:dtor()
    DreamShopLayer.super.dtor(self)
    self:unRegisterListener();

    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    reload_script_file("app.ui.dream.shop.DreamShopLayer")
    reload_script_file("app.ui.dream.shop.DreamVaultCell")

    -- local shopRefresh = ConfigManager:getDreamExchangeShopRefresh()
    -- local refreshList = string.split(shopRefresh, ",")
    -- self._maxRefreshCount = #refreshList
    -- self._refreshList = refreshList;

end

-- 初始化(必备)
function DreamShopLayer:init(npcID)
    self.npcID = npcID;

    DreamShopLayer.super.init(self)

    self:setInterceptTouches(true)
    self:setTouchEnable(true)
end

-- 模版函数：初始化组建的视图(必备)
function DreamShopLayer:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init();
    contentLayout:setSize(VIEW_WIDTH, VIEW_HEIGHT);
    contentLayout:center();
    self:addChild(contentLayout);
    self.contentLayout = contentLayout;

    -- 背景图片
    local bg = UI.Image:create();
    bg:init(BG_NAME1);
    bg:center();
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;
    self.bg = bg;

    local exchangePanel = UI.Layout:create()
    exchangePanel:init()
    exchangePanel:setSize(998, 575)
    exchangePanel:center()
    bg:addChild(exchangePanel)
    self.exchangePanel = exchangePanel

    local vaultPanel = UI.Layout:create()
    vaultPanel:init()
    vaultPanel:setSize(998, 575)
    vaultPanel:center()
    bg:addChild(vaultPanel)
    self.vaultPanel = vaultPanel

    self:initTitle(bg)
    self:addUIEffect(bg)
    self:initTagBtns()
    self:onTagClick(1)
    self:initVaultShop(self.vaultPanel)
    Net.NetNPCSystem:reqDreamShop()
    self:scheduleUpdateTime()
end

function DreamShopLayer:initTagBtns()
    local btnNameArr = {UI.TEXT_1212336, UI.TEXT_1212337};
    local distance = {{42, 120}, {33, 187}};
    self.btnArr = {}
    for k, v in ipairs(btnNameArr) do
        local btn = UI.Button:create();
        btn:init("ui_dreamword_rankinglist_btn_0.png","ui_dreamword_rankinglist_btn_1.png","ui_dreamword_rankinglist_btn_1.png");
        btn:rightUp(distance[k][1], distance[k][2]);
        btn.tag = k
        btn:closeClickScale()

        local btnText = UI.Text:create();
        btnText:init(v, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
        btnText:setWidth(80);
        btnText:center();
        btnText:setLineSpacing(-4);
        btnText:setTextCenter()
        btnText:autoAdapt()
        btn:addChild(btnText, 10);

        self.bg:addChild(btn);
        table.insert(self.btnArr, btn)

        btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:onTagClick(k)
        end)
    end
end

function DreamShopLayer:onTagClick(index)
    self._selecetIndex = index
    for k, btn in ipairs(self.btnArr) do
        if k == index then
            btn:setNormal("ui_dreamword_rankinglist_btn_0.png")
            btn:setSelected("ui_dreamword_rankinglist_btn_1.png")
            btn:setDisabled("ui_dreamword_rankinglist_btn_1.png")
            btn:disable()
        else
            btn:setNormal("ui_dreamword_rankinglist_btn_2_0.png")
            btn:setSelected("ui_dreamword_rankinglist_btn_2_0.png")
            btn:setDisabled("ui_dreamword_rankinglist_btn_2_0.png")
            btn:enable()
        end
    end
    if index == 1 then
        self.exchangePanel:hide()
        self.exchangePanel:leftBottom(-1800, -1800)
        self.vaultPanel:show()
        self.vaultPanel:center()
        self.clockIcon:hide()
        self.countDown:hide()
        self._refreshBtn:hide()
    else
        self.vaultPanel:hide()
        self.vaultPanel:leftBottom(-1800, -1800)
        self.exchangePanel:show()
        self.exchangePanel:center()
        self.clockIcon:show()
        self.countDown:show()

        local shopRefresh = ConfigManager:getDreamExchangeShopRefresh()
        local refreshList = string.split(shopRefresh, ",")
        self._maxRefreshCount = #refreshList
        self._refreshList = refreshList;

        if self._refreshCount >= self._maxRefreshCount then
            self._refreshBtn:hide()
        else
            self._refreshBtn:show()
        end
    end
end

function DreamShopLayer:initTitle(rootNode)

    local shopRefresh = ConfigManager:getDreamExchangeShopRefresh()
    local refreshList = string.split(shopRefresh, ",")
    self._maxRefreshCount = #refreshList
    self._refreshList = refreshList;

    -- 关闭按钮
    local closeButton = UI.SpineTabItem:create()
    closeButton:init(
        MENU_CLOSE_SPINE_BG_NAME, 
        MENU_CLOSE_SPINE_ICON_NAME,
        nil,
        nil
    )
    closeButton:setSize(120, 52)
    closeButton:addEventListener(UIEvent.TAB_CLICK, self, function(self)
        self:closeWin()
    end)
    closeButton:rightUp(70, 7)
    closeButton:onActive()
    closeButton:setSingle(true)
    rootNode:addChild(closeButton, -1)

    -- title
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1212300, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_244_172_246)
    titleText:leftUp(420, 38);
    rootNode:addChild(titleText)

    -- 描述
    local tipText = UI.Text:create()
    tipText:init(UI.TEXT_1212301, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_236_213_153)
    tipText:leftBottom(145, 28)
    rootNode:addChild(tipText)

    -- bat
    local bat = UI.Image:create()
    bat:init("ui_dreamword_goods_bg1.png")
    bat:leftUp(32, 42)
    rootNode:addChild(bat)

    -- 梦境等级
    local lvText = UI.Text:create();
    lvText:init(UI.TEXT_1212261, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_236_213_153);
    lvText:leftUp(90, 80);
    rootNode:addChild(lvText);

    -- 碎片图标
    local diamondIcon = UI.Image:create()
    diamondIcon:init("symbol_dreamword.png")
    diamondIcon:rightUp(360, 80)
    rootNode:addChild(diamondIcon)

    -- 碎片数量
    local diamondCost  = UI.Text:create()
    local cost = RoleDataManager:getMaster():getDreamChip()
    diamondCost:init(tostring(cost), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_236_213_153)
    diamondCost:leftBottom(diamondIcon:getContentSize().width + 6, -3)
    diamondCost:floatRight(0)
    diamondIcon:addChild(diamondCost)
    self.diamondCost = diamondCost

    -- 倒计时
    local clockIcon = AvalonUtil.createClockAnimation()
    clockIcon:rightUp(250, 80)
    rootNode:addChild(clockIcon)
    self.clockIcon = clockIcon

    local timeLabel = UI.Text:create()
    timeLabel:init("00:00", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_236_213_153)
    timeLabel:leftBottom(clockIcon:getContentSize().width + 4, 5)
    clockIcon:addChild(timeLabel)
    self.countDown = timeLabel;

    -- 刷新兑换所按钮
    local refreshBtn = UI.Button:create();
    refreshBtn:init("ui_dreamword_change.png","ui_dreamword_change.png","ui_dreamword_change.png");
    refreshBtn:rightUp(140, 50);
    refreshBtn:closeClickScale()
    rootNode:addChild(refreshBtn);
    refreshBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if self._refreshCount < self._maxRefreshCount then
            local cost = self._refreshList[self._refreshCount + 1]
            local buyTips = UI.Tips:createTips(string.format(UI.TEXT_1114106, cost), UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
            buyTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                local curDiamond = RoleDataManager:getMaster():getDiamond()
                if (Avalon.MathUtil:checkDiamonEnough(tonumber(cost), curDiamond)) then
                    if(RoleBehaviorManager:unlockBagSpaceCheck()) then 
                        Net.Helper:sendMessage(NetMessageType.NPC_REQ_DREAM_EXCHANGE_SHOP, {})
                    end 
                else
                    UI.TipsLayer:onDiamondNotEnough()
                end
            end)
        end
    end)
    self._refreshBtn = refreshBtn

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_pink.png")
    splitLine:setContentSize(733, 2)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(100+733/2, 466)
    rootNode:addChild(splitLine)

    -- 梦境等级数值
    local lv = UI.Image:create()
    lv:init("ui_home_banner_lv.png")
    lv:leftUp(90, 58)
    rootNode:addChild(lv)

    local curLv = MasterDataManager:getDreamData().maxLv or 0
    local lvText = cc.LabelAtlas:create(tostring(curLv), "ui_home_unmber.png", 17, 23, 48)
    lvText:setAnchorPoint(cc.p(0, 0.5))
    lvText:setScale(0.8);
    lvText:setPosition(30, 10)
    lv:addChild(lvText)
end

function DreamShopLayer:addUIEffect(rootNode)
    local bianfu = UI.Animation:create()
    bianfu:init("effect_ui_town_dreamword_duihuan_bianfu.json", "effect_ui_town_dreamword_duihuan_bianfu.atlas", 1);
    bianfu:leftBottom(70, 30)
    rootNode:addChild(bianfu)
    bianfu:setAnimation("idle", true)

    local right = UI.Animation:create()
    right:init("effect_ui_town_dreamword_duihuan_right.json", "effect_ui_town_dreamword_duihuan_right.atlas", 1);
    right:rightBottom(90, 40)
    rootNode:addChild(right)
    right:setAnimation("idle", true)
end

function DreamShopLayer:initVaultShop(rootNode)
        -- 任务列表
    self._tableView = UI.TableView:create({}, 705, 386)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftBottom(122, 75)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:onUpdateCellSize(function ()
        return 700, 210
    end) 
    self._tableView:onUpdateCells(function(tableview, idx)
        -- 更新单元
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.TableViewCell:create()
        else
            cell:removeAllChildren()
        end
        xpcall(function()
            local list = NewConfig.DreamVault:getAllDatas()
            local view = UI.DreamVaultCell:create(list[idx + 1], self)
            cell:addChild(view)
            view:leftBottom(0, 0)
        end,
        function(e) 
            printError("------------------------GoodsListNew:tableCellAtIndex-----------------error", e)
        end, 1);
        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return #NewConfig.DreamVault:getAllDatas()
    end)

    rootNode:addChild(self._tableView)
    self._tableView:reloadData()
    
end

function DreamShopLayer:initShopList(rootNode)
    local gridList = UI.GridList:create()

    gridList:init(UI.DreamShopCell, 5, 2, LIST_CELL_WIDTH, LIST_CELL_HEIGHT, 0, 0, 0)
    gridList:setData(self._data);
    gridList:setSize(LIST_VIEW_WIDTH, LIST_VIEW_HEIGHT)
    gridList:leftUp(120, 110)
    gridList:disableToDragGrid()
    gridList:setCallbackForGridClick(self, self.shopClickCallback)
    gridList:setScrollBarEnabled(false)
    gridList:setCircleVisible(false)

    self.shopList = gridList

    rootNode:addChild(gridList, ZOrder)
end

function DreamShopLayer:shopClickCallback(grid, touchPosition)
    grid:checkClick(touchPosition)
end

function DreamShopLayer:scheduleUpdateTime()
    if self.countDown then
        local refresWaitingTime = GameManager:getNowServerTime() % (SECONDS_ONE_DAY)
        refresWaitingTime = 24 * 60 * 60 - refresWaitingTime
        local str = "00:00"
        if(refresWaitingTime > 0) then
            local hour = math.modf(refresWaitingTime / SECONDS_ONE_HOUR)
            local yu = refresWaitingTime % SECONDS_ONE_HOUR
            local minute = math.modf(yu/60)
            yu = yu % 60
            str = string.format("%d:%d", hour, minute)
        else
            Net.NetNPCSystem:reqDreamShop()
        end
        self.countDown:setText(str)
    end
end

function DreamShopLayer:shopListRet(retData)
    local level = retData.level
    local goods = retData.goodsIndex
    local listData = {}
    for k, v in ipairs(goods) do
        local oneData = {}
        oneData.level = level
        oneData.index = v.id
        oneData.isSold = v.isSold
        oneData.npcID = self.npcID
        oneData.rootLayer = self
        listData[k] = oneData
    end

    print("retData ====== ",retData)

    
    self._data = listData;
    self._refreshCount = retData.refreshCount
    self.exchangePanel:removeAllChildren()
    self:initShopList(self.exchangePanel);

    if self._refreshBtn and self._selecetIndex == 2 then
        if self._refreshCount >= self._maxRefreshCount then
            self._refreshBtn:hide()
        else
            self._refreshBtn:show()
        end
    end

end

function DreamShopLayer:buyItemRet(data)
    if data.result ~= 1 then
        UI.ScrollBar:createByText(data.errStr)
        return
    end

    local cost = 0;
    local itemIndex = data.index;
    for k, v in ipairs(self._data) do
        if v.index == data.index then
            v.isSold = true;
            local cfg = Config.Manager:getDreamShopItem(v.level, v.index);
            cost = cfg.cost
            break
        end
    end

    self.shopList:setData(self._data);

    self.diamondCost:setText(tostring(RoleDataManager:getMaster():getDreamChip()-cost))

    local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
    local msg = UI.TEXT_1170601 .. " " .. UI.TEXT_1212355 .. " x" .. cost
    Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, msg, you)
end

-- 注册监听事件(可选)
function DreamShopLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_DREAM_SHOP, self, self.shopListRet)
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_DREAM_SHOP_BUY, self, self.buyItemRet)
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_DREAM_VALUT_SHOP_BUY, self, self.buyValutResult)
end

-- 注销监听事件(可选)
function DreamShopLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_DREAM_SHOP, self, self.shopListRet)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_DREAM_SHOP_BUY, self, self.buyItemRet)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_DREAM_VALUT_SHOP_BUY, self, self.buyValutResult)
end

function DreamShopLayer:openShow()
    self:open()
end

function DreamShopLayer:buyValutResult(data)
    local cfg = NewConfig.DreamVault:getDataById(data.id)
    if cfg == nil then
        print("DreamShopLayer buyValutResult cfg is null and data = ", data)
        return
    end
    local itemId = cfg.equipContent[data.index + 1]
    local number = cfg.equipNum[data.index + 1]
    local itemData = {}
    local goodData = GoodsDataManager:createLocalGoodsData(itemId)
    if (goodData) then
        goodData:setIsNew(false)
        goodData:setNum(number)
        table.insert(itemData, goodData)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD,itemData)
    end
    self.diamondCost:setText(tostring(RoleDataManager:getMaster():getDreamChip() - cfg.equipValue[data.index + 1]))
end
