------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/04/13
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local FishGearShopView = class("FishGearShopView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_fisihing.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 610

local CELL_WIDTH = 685
local CELL_HEIGHT = 155

local BTN_CELL_W = 109
local BTN_CELL_H = 60

-- 黄金，钻石的图片
local SPRITE_GAMING_MOMEY   = "symbol_gaming_money.png"
local SPRITE_GAMING_DIAMOND = "symbol_gaming_diamond.png"
local SPRITE_GAMING_NAVI_GOLD = "symbol_material_navigationgold.png"

function FishGearShopView:ctor(index)
    FishGearShopView.super.ctor(
    	self,
    	UI.Type.MANOR_FISHING_SHOP,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.shopConfig = {}
    self.index = index or 1
    self:bindModel()
end

function FishGearShopView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.fishgear", "FishGear", false)
    FishGearShopView.super.init(self, ... )
end

function FishGearShopView:dtor()
    FishGearShopView.super.dtor(self)
    self:unbindModel()
    self.shopConfig = {}
    self.index = nil
    reload_script_file_mvc("app.modules.fishgear.FishGearShopView")
end


function FishGearShopView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, -30)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_fishing_bg_2.png")
    bg:center()
    contentLayout:addChild(bg)

    -- 标题
    self.title = UI.Text:create()
    self.title:init(UI.TEXT_221603, UI.FONT_BOLD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_97_104_171)
    self.title:setTextLeft()
    self.title:centerUp(50)
    contentLayout:addChild(self.title, 4)

    local y = 110
    -- 黄金
    local momeyImage = UI.Image:create()
    momeyImage:init(SPRITE_GAMING_MOMEY)
    momeyImage:rightUp(350, y)
    self.contentLayout:addChild(momeyImage, 4)
    -- 黄金数量
    self._momey = UI.Text:create()
    self._momey:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_250_229_177)
    self._momey:setTextLeft()
    -- self._momey:leftUp(76 + 28, curreyY)
    self._momey:centerLeft(momeyImage:getContentSize().width + 4)
    momeyImage:addChild(self._momey, 4)

    -- 钻石
    local diamondImage = UI.Image:create()
    diamondImage:init(SPRITE_GAMING_DIAMOND)
    diamondImage:rightUp(500, y)
    self.contentLayout:addChild(diamondImage, 4)
    -- 钻石数量
    self._diamond = UI.Text:create()
    self._diamond:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_250_229_177)
    self._diamond:setTextLeft()
    -- self._diamond:leftUp(220 + 28, curreyY)
    self._diamond:centerLeft(diamondImage:getContentSize().width + 4)
    diamondImage:addChild(self._diamond, 4)

    -- 远航金币
    local naviImage = UI.Image:create()
    naviImage:init(SPRITE_GAMING_NAVI_GOLD)
    naviImage:rightUp(200, y-5)
    self.contentLayout:addChild(naviImage, 4)
    -- 远航金币数量
    self._naviGold = UI.Text:create()
    self._naviGold:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_250_229_177)
    self._naviGold:setTextLeft()
    -- self._naviGold:leftUp(220 + 28, curreyY)
    self._naviGold:centerLeft(naviImage:getContentSize().width + 4)
    naviImage:addChild(self._naviGold, 4)

    

    self:createGoodsView()
    self:addUIEffect()
    self:updateMoneyView()
    self:makeTabList()
    self:tabClicked(self.index)
end

function FishGearShopView:createGoodsView()
    -- local shopConfig = mvc.fishGearModel:getFishShopConfig()
    -- local column = #shopConfig

    self.shopGoodsView = UI.TableView.new({}, CELL_WIDTH+40, CELL_HEIGHT+220)
    self.shopGoodsView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.shopGoodsView:center(0, 50)
    -- self.shopGoodsView:enableDebugDraw()
    self.shopGoodsView:setDelegate()
    self.shopGoodsView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.shopGoodsView:setBounceable(true)
    self.shopGoodsView:init()
    self.shopGoodsView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT+40
    end)

    self.shopGoodsView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        
        if not cell then
            xpcall(function()
                cell = self:createGoodsCell(index, self.shopConfig[index])
            end,
            function(e)
                printError("------------------------TradeActivityMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            if cell and not tolua.isnull(cell) then
                cell:removeFromParent(true)
                cell:removeAllChildren()
                cell = nil
            end
            cell = self:createGoodsCell(index, self.shopConfig[index])
        end

        return cell
    end)
    self.shopGoodsView:onUpdateCellNumbers(function ()
        return table.nums(self.shopConfig)--1--table.nums(shopConfig)
    end)

    self.contentLayout:addChild(self.shopGoodsView, 100)
    self.shopGoodsView:reloadData(true)
end

function FishGearShopView:createGoodsCell(index, data)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT+40))

    local shopCell = mvc.fishGearShopCellView:create()
    shopCell:init(data)
    shopCell:center(20, 10)
    cell:addChild(shopCell)

    return cell
end

function FishGearShopView:updateMoneyView()
    local GameDataManager = require("app.game.GameDataManager")
    self._momey:setText(self._momey:numformat(string.format("%d",GameDataManager:getInstance():getCurCoin())))
    self._momey:updateView()
    self._diamond:setText(self._diamond:numformat(string.format("%d",GameDataManager:getInstance():getDiamond())))
    self._diamond:updateView()
    self._naviGold:setText(self._naviGold:numformat(string.format("%s", RoleDataManager:getMaster():getSailGold())))
    self._naviGold:updateView()
end

-- function FishGearShopView:updateMoneyNum()
--     local pk = RoleDataManager:getMaster():getPK()
--     local dustTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, DUST_ID)
--     self.dustNum:setText(self.dustNum:numformat(string.format("%s", dustTotalNum)))
--     self.dustNum:updateView()
-- end

function FishGearShopView:addUIEffect(rootNode)
    local anime = UI.Animation:create()
    anime:init("effect_ui_fish_toolbox.json", "effect_ui_fish_toolbox.atlas", 1);
    anime:centerBottom(0, 0)
    self.contentLayout:addChild(anime)
    anime:setAnimation("idle", true)

    -- local right = UI.Animation:create()
    -- right:init("effect_ui_town_dreamword_duihuan_right.json", "effect_ui_town_dreamword_duihuan_right.atlas", 1);
    -- right:rightBottom(90, 40)
    -- rootNode:addChild(right)
    -- right:setAnimation("idle", true)
end

function FishGearShopView:makeTabList()
    self.btnData = {}
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_221609
    tab1.select = false

    local tab2 = {}
    tab2.idx = 2
    tab2.name = UI.TEXT_221610
    tab2.select = false

    local tab3 = {}
    tab3.idx = 3
    tab3.name = UI.TEXT_221611
    tab3.select = false

    table.insert(self.btnData, tab1)
    table.insert(self.btnData, tab2)
    table.insert(self.btnData, tab3)

    self._tableView = UI.TableView.new({}, BTN_CELL_W+50, 180);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:rightUp(-63, 100)
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(false);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end);
    -- self._tableView:enableDebugDraw()
    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = UI.TableViewCell:create()
                cell:setContentSize(cc.size(109, 68))
                self.btnData[index].cell = cell

                local image = UI.Image.create()
                image:init("ui_fishing_list_normal.png")
                image:center(14*(index))
                image:setName("image")
                cell:addChild(image)

                local text = UI.Text:create()
                text:init(self.btnData[index].name, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                text:center(14*(index))
                text:setWidth(107)
                text:setTextCenter()
                text:setLineSpacing(-6)
                text:setName("cellText")
                cell:addChild(text)

                -- local redPoint = AvalonUtil.createRedPoint(cell, 2, 2, 100)
                -- redPoint:setName("redPoint")
                -- redPoint:hide()

                if self.btnData[index].select then
                    -- text:setFontColor(UI.FONT_COLOR_218_211_154)
                    image:setSpriteName("ui_fishing_list_checked.png")
                else
                    -- text:setFontColor(UI.FONT_COLOR_41_41_45)
                    image:setSpriteName("ui_fishing_list_normal.png")
                end
            end,
            function(e) 
                printError("------------------------PetTreasureMainView:tableCellAtIndex-----------------error")
            end, 1);
        else
            if self.btnData[index].select then
                -- cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_218_211_154)
                cell:getChildByName("image"):setSpriteName("ui_fishing_list_checked.png")
            else
                -- cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_41_41_45)
                cell:getChildByName("image"):setSpriteName("ui_fishing_list_normal.png")
            end

        end

        return cell;
    end);

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end);

    self._tableView:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        local clickIndex = cell:getIdx() + 1

        if self.curTabIndex == clickIndex then
            return
        end
        self:tabClicked(clickIndex)
    end)

    self.contentLayout:addChild(self._tableView, 100)
    self._tableView:reloadData(true)
end


function FishGearShopView:tabClicked(clickIndex)
    self.curTabIndex = clickIndex
    self.btnData[self.curTabIndex].select = true
    self._tableView:updateCellAtIndex(self.curTabIndex - 1)

    if self.lastTabIndex > 0 then
        if self.lastTabIndex == clickIndex then
            return
        end
        self.btnData[self.lastTabIndex].select = false
        self._tableView:updateCellAtIndex(self.lastTabIndex - 1)
    end
    self:resetConfig()
    self.lastTabIndex = self.curTabIndex
    self.shopGoodsView:reloadData(true)
end

function FishGearShopView:resetConfig()
    self.shopConfig = {}
    local shopConfig = mvc.fishGearModel:getFishShopConfig()
    for k, v in pairs(shopConfig) do
        if v.itemType == self.curTabIndex then
            table.insert(self.shopConfig, v)
        end
    end
end

function FishGearShopView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.updateMoneyView)
end


function FishGearShopView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.updateMoneyView)
end





return FishGearShopView












