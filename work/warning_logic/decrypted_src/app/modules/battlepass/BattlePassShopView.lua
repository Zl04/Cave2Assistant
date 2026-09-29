------------------------------------------------------------------------------
--author: 
--date	: 2019/08/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BattlePassShopView = class("BattlePassShopView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 850
local COM_HEIGHT = 420
local layoutUU
function BattlePassShopView:ctor()
    BattlePassShopView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self:leftBottom(20, 10)
    layoutUU = UIUtil:createAutoUILayout("BattlePassShopView","app.modules.battlepass.BattlePassPosConfig", false)
end

function BattlePassShopView:dtor()
    BattlePassShopView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.battlepass.BattlePassShopView")
end


function BattlePassShopView:onInitView()
     --tableview
    local tableview = UI.TableView.new({}, 815, 400)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableview:leftBottom(27, 15)
    tableview:setDelegate()
    tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableview:init(0)
    tableview:setBounceable(true);
    tableview:setScrollBarEnabled(true)
    tableview:onUpdateCellSize(function (table,idx)
        return 800, 275;
    end);

    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.BattlePassShopCell.new();
            cell:init(idx + 1, tableview);
        end,
        function(e) 
            printError("------------------------BattlePassShopView:tableCellAtIndex-----------------error")
        end, 1);

        return cell;
    end);

    local size = #mvc.battlePassModel:getShopDatas()
    if size % 4 == 0 then
        size = size / 4
    else
        size = math.ceil(size / 4)
    end
    tableview:onUpdateCellNumbers(function ()
        return size
    end);

    self:addChild(tableview)
    tableview:reloadData(true)
    self.tableview = tableview
end


function BattlePassShopView:bindModel()
    mvc.battlePassModel:bind("PassShopData", self, self.refreshDataCallback)
    mvc.battlePassModel:bind("BattlePassIcon", self, self.refreshDataCallback)
end


function BattlePassShopView:unbindModel()
    mvc.battlePassModel:unbind("PassShopData", self, self.refreshDataCallback)
    mvc.battlePassModel:unbind("BattlePassIcon", self, self.refreshDataCallback)
end

function BattlePassShopView:refreshDataCallback()
    print("-----BattlePassShopView:refreshDataCallback()--")
    self.tableview:reloadData(false)
end

---tablecell--begin----------
local BattlePassShopCell = class("BattlePassShopCell", UI.TableViewCell)
UI.BattlePassShopCell = BattlePassShopCell


function BattlePassShopCell:ctor()
    self.itemList = {}
end

function BattlePassShopCell:onEnter()
    BattlePassShopCell.super.onEnter(self);
end

function BattlePassShopCell:onExit()
    BattlePassShopCell.super.onExit(self);
end

function BattlePassShopCell:init(idx, tableview)
    self._tableView = tableview
    local list = mvc.battlePassModel:getShopDatas()
    self.dataList = {} 
    for k, v in ipairs(list) do
        if (idx - 1) * 4 < k and k <= idx * 4 then
            table.insert(self.dataList, v)
        end
    end 
    self:onInitView();
end

function BattlePassShopCell:onInitView()
    local layout = UI.TouchLayout:create()
    layout:init()
    layout:setSize(800, 275)
    layout:leftBottom(0, 0)
    layout:addTouchEvents(self)
    self:addChild(layout)

    for k, v in ipairs(self.dataList) do
        local panel = self:createOne(v)
        panel:leftBottom(200 * (k - 1), 0)
        self:addChild(panel)
    end
end

function BattlePassShopCell:createOne(data)
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(180, 275)
    layout:leftBottom(0, 0)

    local bg = UI.Image:create()
    bg:init("ui_passcheck_paper.png")
    bg:centerUp(0)
    layout:addChild(bg)

    local aniBtn = UI.Layout:create()
    aniBtn:init()
    aniBtn:setSize(180, 54)
    bg:addChild(aniBtn)
    aniBtn:setTag(data.ID)
    aniBtn:leftBottom(0, -54)

    local bottom = cc.Sprite:createWithSpriteFrameName("ui_passcheck_btn_3.png")
    bottom:setAnchorPoint(1, 1)
    bottom:setPosition(182, 53)
    aniBtn:addChild(bottom)

    local goodsData = GoodsDataManager:createLocalGoodsData(data.itemID)
    if goodsData == nil then
        return
    end
    goodsData:setIsNew(false)
    aniBtn:setTouchEnable(true)
    aniBtn:addEventListener(UIEvent.COMPONENT_CLICK, self, self.buyClick)

    --name
    local name = UI.Text:create()
    name:init(goodsData:getName(), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    name:leftUp(10, 8)
    bg:addChild(name, 10)
    name:setWidth(163)
    name:autoAdapt()
    name:setLineSpacing(-5)

    --count
    if data.quarterLimit ~= 0 then
        local count = UI.Text:create()
        count:init(string.format(UI.TEXT_1212906, data.quarterLimit - data.buyNum), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
        count:leftUp(10, name:getUp() + name:getContentSize().height)
        bg:addChild(count, 10)
    end

     --icon
    local iconPanel = UI.Layout:create()
    iconPanel:init()
    iconPanel:setSize(185, 59)
    iconPanel:center(0, 0)
    bottom:addChild(iconPanel)

    local passIcon = UI.Image:create()
    passIcon:init("symbol_gaming_passcheck.png")
    passIcon:center()
    iconPanel:addChild(passIcon)

    local iconNum = UI.Text:create()
    iconNum:init(data.consume.."", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    iconNum:center()
    iconPanel:addChild(iconNum, 10)
    local left = (iconPanel:getContentSize().width - passIcon:getContentSize().width - iconNum:getContentSize().width - 10) / 2
    passIcon:centerLeft(left)
    iconNum:centerLeft(left + passIcon:getContentSize().width + 10)
    if RoleDataManager:getMaster():getBattlePassCoin() < data.consume then
        iconNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    end

    if data.quarterLimit == 0 or data.quarterLimit - data.buyNum > 0 then
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init(goodsData)
        goodsGrid:centerUp(90)
        goodsGrid:setInfoArea(true, false)
        bg:addChild(goodsGrid, 10)
        goodsGrid:setName("GoodsGrid")
        local level = mvc.battlePassModel:getBattlePassLvAndExp()
        if data.battlePassLevel > level then
            local grayCap = UI.Image:create()
            grayCap:init("ui_passcheck_paper_mack.png")
            grayCap:centerUp(0)
            bg:addChild(grayCap, 10)

            local tip = UI.Text:create()
            tip:init(string.format(UI.TEXT_1212916, data.battlePassLevel), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_WHITE)
            tip:setWidth(150)
            tip:autoAdapt()
            tip:center()
            tip:setTextCenter()
            grayCap:addChild(tip, 1)
            bottom:setSpriteFrame("ui_passcheck_btn_3.png")
        else
            bottom:setSpriteFrame("ui_passcheck_btn_1.png")
        end
        table.insert(self.itemList, goodsGrid)
    else
        local edibledImage = UI.Image:create()
        edibledImage:init("ui_catfood_seal.png")
        edibledImage:centerUp(80)
        bg:addChild(edibledImage)

        local edibled  = UI.Text:create()
        edibled:init(UI.TEXT_1170826, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_154_21_30)
        edibled:setAnchorPoint(0.5, 0.5)
        edibled:rotate(15)
        edibled:center()
        edibledImage:addChild(edibled, -1)
        iconPanel:hide()
        if data.isChange then
            bottom:setSpriteFrame("ui_passcheck_btn_2.png")
            local rotateAct1 = cc.RotateBy:create(0.1, -2.5)
            self.bottom = bottom
            bottom:runAction(cc.Sequence:create(rotateAct1, cc.CallFunc:create(function()  
                data.isChange = false
                self.bottom:rotate(0)
                self.bottom:setSpriteFrame("ui_passcheck_btn_4.png")
                bottom:setPosition(184, 54)
            end))) 
        else
            bottom:setSpriteFrame("ui_passcheck_btn_4.png")
            bottom:setPosition(185, 54)
        end
    end

    return layout
end

function BattlePassShopCell:buyClick(sender)
    -- print("--buyClick---", sender:getTag())
    local data = mvc.battlePassModel:getShopDataById(sender:getTag())
    if data == nil then
        return
    end

    local level = mvc.battlePassModel:getBattlePassLvAndExp()
    if data.battlePassLevel > level then
        UI.ScrollBar:createByText(string.format(UI.TEXT_1212916, data.battlePassLevel))
        return
    end

    if data.quarterLimit ~= 0 then
        if data.quarterLimit - data.buyNum <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_1170826)
            return
        end
    end

    if RoleDataManager:getMaster():getBattlePassCoin() < data.consume then
        UI.ScrollBar:createByText(UI.TEXT_1212917)
        return
    end

    local number =  math.floor(RoleDataManager:getMaster():getBattlePassCoin() / data.consume)
    if data.quarterLimit ~= 0 then
        number = number < (data.quarterLimit - data.buyNum) and number or (data.quarterLimit - data.buyNum)
    end

    -- 判断背包是否满了
    local goodsArr = {}
    local dataItem = {}
    dataItem.goodsID = data.itemID
    dataItem.num = 1
    dataItem.isGolden = true--goods.isGolden
    table.insert(goodsArr, dataItem)

    local GameDataManager = require("app.game.GameDataManager")
    local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
    if not enough then
        UI.ScrollBar:createByTextID(1110793)
        return false
    end

    UI.TipsLayer:onBuyAmount(function(number)   -- 确认回调
        if not tolua.isnull(self) then
            self:_buyClick(data.ID, data.itemID, number)
        end
    end, nil, data.consume, PublicDefine.GOODS_COST_TYPE.BATTLE_PASS_ICON, number, false, true)
end


function BattlePassShopCell:_buyClick(id, itemId, number)
    -- 判断背包是否满了
    local goodsArr = {}
    local dataItem = {}
    dataItem.goodsID = itemId
    dataItem.num = number
    dataItem.isGolden = true--goods.isGolden
    table.insert(goodsArr, dataItem)

    local GameDataManager = require("app.game.GameDataManager")
    local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
    if not enough then
        UI.ScrollBar:createByTextID(1110793)
        return false
    end 
    Net.NetLogicSystem:requestBpShopBuy(id, number)
end

function BattlePassShopCell:onTouchBegan(touch, event)
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location
    local point = self._tableView:convertToWorldSpace(cc.p(0,0))
    local size = self._tableView:getViewSize()
    local rect = cc.rect(point.x, point.y, size.width, size.height)
    if not AvalonUtil:isRectContainsPoint(self._tableView, location) then
        return
    end  

    for k, node in ipairs(self.itemList) do
        if AvalonUtil:isRectContainsPoint(node, location) then
            self.selectIndex = k
            break
        end
    end
end

function BattlePassShopCell:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 
    --检查是否在可点击区域 邮件活动区域
    if not AvalonUtil:isRectContainsPoint(self._tableView, location) then
        return
    end 

    for k, node in ipairs(self.itemList) do
        if AvalonUtil:isRectContainsPoint(node, location) and self.selectIndex == k then
            node:onShowInfoAreaHandler(true)
            break
        end
    end
end
----tablecell--end----------


return BattlePassShopView












