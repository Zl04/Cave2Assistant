-- DreamShopCell.lua
-- Author:lzm
-- 2019年2月28日
-- Using:梦境商店cell

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local DreamShopCell = class("DreamShopCell", UI.ListGrid)
UI.DreamShopCell = DreamShopCell

local COM_WIDTH = 135
local COM_HEIGHT = 200

--构造函数(必备)
function DreamShopCell:ctor()
    DreamShopCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function DreamShopCell:dtor()
    DreamShopCell.super.dtor(self)
end

-- 初始化(必备)
function DreamShopCell:init(data)
    DreamShopCell.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function DreamShopCell:onInitView()
end

function DreamShopCell:getData()
    return self._data;
end

function DreamShopCell:isClickShowInfo()
    return true
end

function DreamShopCell:onUpdateView(data)
    if not self._data then
        return
    end

    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self:addChild(cellLayout)

    self.itemCfg = Config.Manager:getDreamShopItem(self._data.level, self._data.index);
    if not self.itemCfg.id then
        return
    end

    self.goodsData = GoodsDataManager:createLocalGoodsData(self.itemCfg.id);
    self._data.itemCfg = self.itemCfg;

    -- 背景
    local bg = UI.Image:create()
    bg:init("ui_dreamword_paper_2.png")
    bg:centerUp(10)
    cellLayout:addChild(bg)

    if self._data.isSold then
        local sellOut = UI.Layout:create()
        sellOut:init()
        sellOut:setSize(COM_WIDTH, COM_HEIGHT)
        sellOut:centerUp(-15)
        cellLayout:addChild(sellOut);

        local edibledImage = UI.Image:create()
        edibledImage:init("ui_catfood_seal.png")
        edibledImage:center()
        sellOut:addChild(edibledImage)
    
        local edibled  = UI.Text:create()
        edibled:init(UI.TEXT_1212304, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_154_21_30)
        edibled:setAnchorPoint(0.5, 0.5)
        edibled:rotate(15)
        edibled:center()
        sellOut:addChild(edibled, -1)
    else
        -- 物品图标
        local itemIcon = UI.Image:create()
        itemIcon:init(self.goodsData:getIconName())
        itemIcon:centerUp(50)
        cellLayout:addChild(itemIcon)

        local diamondCost  = UI.Text:create()
        diamondCost:init("x" .. tostring(self.itemCfg.num), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        diamondCost:floatLeft(0);
        diamondCost:rightBottom(15, 10)
        bg:addChild(diamondCost, 2)
    end

    local touch = UI.Layout:create()
    touch:init()
    touch:setSize(135, 150)
    touch:centerUp(0)
    self.touch = touch
    cellLayout:addChild(touch)

    local btn = UI.Button:create();
    btn:init("ui_btn_purple_0.png","ui_btn_purple_1.png","ui_btn_purple_2.png");
    btn:centerBottom(0);
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.isBuying then
            return
        end

        if self._data.isSold then
            UI.ScrollBar:createByText(UI.TEXT_1212304)
            return
        end

        local cur = RoleDataManager:getMaster():getDreamChip()
        if cur < self.itemCfg.cost then
            UI.ScrollBar:createByText(UI.TEXT_1212305)
            return
        end

        local dreamShopConfirmLayer = UI.DreamShopConfirmLayer:create()
        dreamShopConfirmLayer:center(0)
        dreamShopConfirmLayer:init(self._data.itemCfg.cost)
        dreamShopConfirmLayer:setName("DreamShopConfirmLayer")
        self._data.rootLayer.contentLayout:addChild(dreamShopConfirmLayer, 20);
        dreamShopConfirmLayer:openShow()
        -- dreamShopConfirmLayer:setGoBackWin()
        dreamShopConfirmLayer:setCallback(handler(self, function()
            if (GameDataManager:getFreePacketBoxNum() <= 0) then
                UI.ScrollBar:createByText(UI.TEXT_1212306)
                return
            end
            Net.NetNPCSystem:reqDreamShopBuy(self._data.index, self._data.npcID)
        end))

        performWithDelay(self, function()
            self.isBuying = false
        end, 0.5)
        self.isBuying = true
    end)

    cellLayout:addChild(btn)

    local innerLayer = UI.Layout:create()
    innerLayer:init()
    innerLayer:setSize(10, 10)
    innerLayer:center()
    btn:addChild(innerLayer, 1)

    local diamondIcon = UI.Image:create()
    diamondIcon:init("symbol_dreamword.png")
    diamondIcon:centerLeft(0)
    innerLayer:addChild(diamondIcon, 1)

    -- 花费的碎片数量
    local diamondCost  = UI.Text:create()
    diamondCost:init(tostring(self.itemCfg.cost), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    diamondCost:floatRight(0);
    local w1, h1 = diamondIcon:getSize()
    diamondCost:centerLeft(w1+5)
    innerLayer:addChild(diamondCost, 2)

    local w2, h2 = diamondCost:getSize()
    innerLayer:setSize(w1 + w2 + 5, h1)
end

function DreamShopCell:checkClick(touchPosition)
    if not self.itemCfg.id then
        return
    end

    if self.touch:checkTouchPosition(touchPosition) then
        self:onShowInfoAreaHandler(touchPosition)
    end
end

function DreamShopCell:onShowInfoAreaHandler(point)
    local pInfoArea = nil;
    local goodsData = self.goodsData
    if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
        -- 装备详情
        pInfoArea = UI.EquipmentInfoArea:create()
        pInfoArea:init(UI.EquipImageBgType.NO_GET_TYPE)
        pInfoArea:hideCompInfo()
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
        -- 装备详情
        pInfoArea = UI.EquipmentPetInfoArea:create()
        pInfoArea:init(UI.EquipImageBgType.NO_GET_TYPE)
        pInfoArea:hideCompInfo()
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then 
        -- 道具详情界面
        local itemType = goodsData:getItemType()
        if itemType == PublicDefine.ITEM_TYPE.ChooseBag then
            pInfoArea = UI.SelectGoodsBagInfoArea:create()
        elseif itemType == PublicDefine.ITEM_TYPE.RandomBag then
            pInfoArea = UI.RandomBagInfoArea:create()
        elseif itemType == PublicDefine.ITEM_TYPE.LevelBag then
            pInfoArea = UI.LevelBagInfoArea:create()
            pInfoArea:lockNextLevelBag()
            pInfoArea:disableUse()
        else
            pInfoArea = UI.PropInfoArea:create(true)
        end
        pInfoArea:init(UI.PROP_MATER.PROPINFO)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then 
        -- 材料详情界面
        if(goodsData:getMaterialType() ~= PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then 
            pInfoArea = UI.PropInfoArea:create(true)
        else 
            pInfoArea = UI.MaterialEquipScrollInfoArea:create()
        end
        pInfoArea:init(UI.PROP_MATER.MATERIALINFO)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then 
        -- 虚拟物品详情界面
        if(goodsData:getCanBeView()) then 
            pInfoArea = UI.PropInfoArea:create(true)
            pInfoArea:init(UI.PROP_MATER.VIRTUALITEM_INFO)
            pInfoArea:setHideLink(true)
        else
            return
        end
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
        -- 宝石详情界面
        pInfoArea = UI.GemStoneInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then 
        -- 宝石详情界面
        pInfoArea = UI.StarPrayInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
        pInfoArea = UI.PetStoneInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then 
        -- 遗物详情界面
        pInfoArea = UI.RelicInfoArea:create()
        pInfoArea:init(goodsData)
    else
        return
    end

    pInfoArea:setVisible(true)
    pInfoArea:updateView(goodsData)
    pInfoArea:closeLockFlag()
    pInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        pInfoArea:close();
    end)

    local winSize = cc.Director:getInstance():getWinSize()
    local size = pInfoArea:getContentSize()
    local delta = 0
    if point.x > winSize.width*2/3 then
        delta = size.width + 20
    end
    pInfoArea:leftBottom(point.x+10-delta, point.y)
    
    if point.y + size.height > winSize.height then
        pInfoArea:leftBottom(pInfoArea:getLeft(), winSize.height - size.height - 50)
    end
    pInfoArea:setName("INFO_AREA")

    UI.UIManager:addToRootNode(pInfoArea, UI_ZORDER.TIPS)
end
