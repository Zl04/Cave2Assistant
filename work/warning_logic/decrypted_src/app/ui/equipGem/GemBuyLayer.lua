-- GemBuyLayer.lua
-- Author:ydli
-- 2018年6月19日
-- Using:宝石购买 
require("app.ui.common.CurrencyPanel")
require "app.ui.shoplayer.BagGoodsPanel"
require "app.ui.equipGem.GemBuyCell"

local ProtobufUtil = require "utils.ProtobufUtil"
require("app.config.ConfigManager")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local model = require("app.uiExport.GemBuyModel")
local FishGearShopCellView = require("app.modules.fishgear.FishGearShopCellView")
UI = UI or {}

local GemBuyLayer = class("GemBuyLayer", UI.BaseWin)--UI.DownShowWin)
UI.GemBuyLayer = GemBuyLayer
local winSize = cc.Director:getInstance():getWinSize()
local layoutSize = cc.size(764, 531)
local GEM_BUY_CELL_COUNT_NUMBER = 3--一个tablecell 放入的元素个数
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_gemshop.plist", 
    "ui_common_btn.plist",
    "ui_town_fisihing.plist",
    "ui_general_shopping.plist",
}

local BTN_CELL_W = 109
local BTN_CELL_H = 70

local CELL_WIDTH = 685
local CELL_HEIGHT = 155

--构造函数(必备)
function GemBuyLayer:ctor(spriteID)
    --窗口大小
    GemBuyLayer.super.ctor(
    self,UIType.EQUIP_GEM_BUY,
    COM_RES_LIST,
    winSize.width,    
    winSize.height
    )
    self._spriteID = spriteID
    self.cellList = {}
    -- self.dataList = ConfigManager:getAllGemStoneShopData()
    self:refreshDataList()
    self:init();
    self:registerListener();

end

--虚构函数,destroy时调用(必备)
function GemBuyLayer:dtor()
    GemBuyLayer.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化(必备)
function GemBuyLayer:init()
    GemBuyLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function GemBuyLayer:onInitView()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 110))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- self:createGBShopView()
    self:createGemBuyView()

    self:createGBShopView()
    

    self:makeTabList()

    self:tabClicked(1)
    
end

function GemBuyLayer:createGBShopView()

    self.modelShop = model.create("modelShop")
    self.bg2 = self.modelShop.root
    self.bg2:center(10);
    self:addChild(self.bg2)

    local currentLayout = UI.CurrencyPanel:create(UI.FONT_COLOR_255_255_255,nil,PublicDefine.CurrencyPanelType.RunesCave)
    currentLayout:rightUp(-127, 35)
    self.modelShop.bg:addChild(currentLayout)

    self.shopConfig = ConfigManager:getAllProfileIntegralShopData()

    self.shopGoodsView = UI.TableView.new({}, CELL_WIDTH+40, CELL_HEIGHT+280)
    self.shopGoodsView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.shopGoodsView:center(22, 20)
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
                printError("------------------------createGBShopView:tableCellAtIndex-----------------error")
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

    self.modelShop.bg:addChild(self.shopGoodsView)
    self.shopGoodsView:reloadData(true)

end

function GemBuyLayer:createGoodsCell(index, data)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT+40))

    local shopCell = FishGearShopCellView:create()
    shopCell:init(data,PublicDefine.CommonShopType.RunesCave)
    shopCell:center(10, 10)
    shopCell:setScale(0.95)
    cell:addChild(shopCell)

    return cell
end

function GemBuyLayer:createGemBuyView()
    self.gemModel = model.create("modelLayer")
    self.bg = self.gemModel.root
    self.bg:center(10);
    self:addChild(self.bg)

    local currentLayout = UI.CurrencyPanel:create(UI.FONT_COLOR_255_255_255)
    currentLayout:rightUp(27, -40)
    self.gemModel.paper:addChild(currentLayout)

    self:createCell(self.gemModel.contentLayer1, 1)
    self:createCell(self.gemModel.contentLayer2, 2)
    self:createCell(self.gemModel.contentLayer3, 3)

    self:open(self.bg)
    require("app.utils.PushUtil")
    if (not PushUtil:isAuthenticated()) then
        PushUtil:requestNotiAuthWithGemDialog()
    end
    if(CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) then
    else
        local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_GemStone_1)
        if adsData and adsData.isOpen then
            GameManager:loadAds(PublicDefine.AdsPlaceId.GemLuckDrop, PublicDefine.AdvertFuncType.AdvertFuncType_GemStone_1)
        end

        local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_GemStone_2)
        if adsData and adsData.isOpen then
            GameManager:loadAds(PublicDefine.AdsPlaceId.GemLuckDrop, PublicDefine.AdvertFuncType.AdvertFuncType_GemStone_2)
        end

        local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_GemStone_3)
        if adsData and adsData.isOpen then
            GameManager:loadAds(PublicDefine.AdsPlaceId.GemLuckDrop, PublicDefine.AdvertFuncType.AdvertFuncType_GemStone_3)
        end
    end

    self.gemModel.nextGemBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(param, sender, touch) 
        mvc.openPanel("GmeBuyShowNextLevel", "GmeBuyShowNextLevel")
    end)

    self:updateLevelContent()

end

function GemBuyLayer:updateLevelContent()
    if self.gemModel and self.gemModel.ptimer then
        local exploreLv = MasterDataManager:getGemstoneExploreLv()
        local allLevelConf = ConfigManager:getAllProfileGemstoneCaveData()
        local maxLevel = allLevelConf[#allLevelConf].caveLV
        self.gemModel.levelText:setText(tostring(exploreLv))

        if exploreLv >= maxLevel then
            self.gemModel.ptimer:setPercentage(100)
            self.gemModel.expText:setText("MAX")
            -- self.gemModel.expMaxSp:show()
            -- self.gemModel.expText:hide()
        else
            -- self.gemModel.expMaxSp:hide()
            -- self.gemModel.expText:show()

            local exploreLeftExp = MasterDataManager:getGemstoneExploreLeftExp()
            local localConfig = ConfigManager:getAllProfileGemstoneCaveDataByID(exploreLv)
            local nextExp = localConfig.expToNextLV
            self.gemModel.ptimer:setPercentage(exploreLeftExp / nextExp * 100)

            local upExp = nextExp
            local curExp = exploreLeftExp

            local maxStr = tostring(upExp)
            local curStr = tostring(curExp)
            if upExp > 99999 then maxStr = AvalonUtil:getSimpleNumber(upExp, 5) end
            if curExp > 99999 then curStr = AvalonUtil:getSimpleNumber(curExp, 5) end
            self.gemModel.expText:setText(curStr .. "/" .. maxStr)
        end
    end
end

function GemBuyLayer:makeTabList()
    self.btnData = {}
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_223900
    tab1.select = false

    local tab2 = {}
    tab2.idx = 2
    tab2.name = UI.TEXT_223901
    tab2.select = false

    table.insert(self.btnData, tab1)
    table.insert(self.btnData, tab2)

    self._tableView = UI.TableView.new({}, BTN_CELL_W+50, 180);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:center(437, -124)
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
                image:init("ui_btn_gray2_0.png")
                image:center()
                image:setName("image")
                cell:addChild(image)

                local text = UI.Text:create()
                text:init(self.btnData[index].name, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                text:center()
                text:setWidth(107)
                text:setTextCenter()
                text:setLineSpacing(-6)
                text:setName("cellText")
                cell:addChild(text)

                -- local redPoint = AvalonUtil.createRedPoint(cell, 2, 2, 100)
                -- redPoint:setName("redPoint")
                -- redPoint:hide()

                if self.btnData[index].select then
                    text:setFontColor(UI.FONT_COLOR_218_211_154)
                    image:setSpriteName("ui_btn_gray2_1.png")
                else
                    text:setFontColor(UI.FONT_COLOR_41_41_45)
                    image:setSpriteName("ui_btn_gray2_0.png")
                end
            end,
            function(e) 
                printError("------------------------PetTreasureMainView:tableCellAtIndex-----------------error")
            end, 1);
        else
            if self.btnData[index].select then
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_218_211_154)
                cell:getChildByName("image"):setSpriteName("ui_btn_gray2_1.png")
            else
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_41_41_45)
                cell:getChildByName("image"):setSpriteName("ui_btn_gray2_0.png")
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

    self:addChild(self._tableView, 100)
    self._tableView:reloadData(true)
end

function GemBuyLayer:tabClicked(clickIndex)

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

    self.lastTabIndex = self.curTabIndex

    if clickIndex == 1 then
        self.gemModel.bg:show()
        self.bg2:hide()
    else
        self.gemModel.bg:hide()
        self.bg2:show()
    end
end

function GemBuyLayer:createCell(parentNode, idx)
    local cell = UI.GemBuyCell:create(self._spriteID, self.dataList[idx], idx)
    parentNode:addChild(cell)

    local cellData = {}
    cellData.cell = cell;
    cellData.idx = idx
    table.insert( self.cellList, cellData)
end

-- 模版函数：更新组建的视图(必备)
function GemBuyLayer:onUpdateView()
    Avalon.AudioManager:playSound("1111111")
    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110426)) 
end

-- 注册监听事件(可选)
function GemBuyLayer:buySuccessCallback(data)
    UI.WaitingLayer:hideWaiting()
    if data.result == ProtobufUtil:enum_id("NPCSystem.GemstoneBuyResult", "GemstoneBuyResult_Succeed") then
        Avalon.AudioManager:playSound("1111111")
        --show ward UI
        --处理堆叠
        local tempGemstoneID = {}
        for k, gemstoneID in ipairs(data.gemstoneID) do
            local num = tempGemstoneID[gemstoneID] or 0
            tempGemstoneID[gemstoneID] = num + 1
        end

        local goodsDataList = {}
        for k, value in pairs(tempGemstoneID) do
            local gemstoneData =  GoodsDataManager:createLocalGoodsData(k)
            if(gemstoneData) then
                gemstoneData:setNum(value)
                table.insert(goodsDataList, gemstoneData)
            end
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, goodsDataList)
        -- self.dataList = ConfigManager:getAllGemStoneShopData()
        self:refreshDataList()
        self:refreshView()
        self.confirmCallback()
    else
        GameErrorManager:showError(data.result)
    end
end

function GemBuyLayer:refreshDataList()
    self.dataList = {}
    local exploreLv = MasterDataManager:getGemstoneExploreLv()
    local levelConf = ConfigManager:getAllProfileGemstoneCaveDataByID(exploreLv)
    local gemstoneCaveId = levelConf.gemstoneCaveId

    for k,v in ipairs(gemstoneCaveId) do
        local dConf = ConfigManager:getAllProfileGemStoneShopDataByID(v)
        table.insert(self.dataList, dConf)
    end

end

function GemBuyLayer:refreshView()
    for k, v in pairs(self.cellList) do
        v.cell:reload(self.dataList[v.idx])
    end

    self:updateLevelContent()

    if self.shopGoodsView then
        self.shopGoodsView:reloadData(true)
    end
end 

function GemBuyLayer:confirmCallback()

end 

-- 注册监听事件(可选)
function GemBuyLayer:registerListener()
    --购买结果
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_GEM_SHOP_BUY, self, self.buySuccessCallback)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_ADVERT_STATUS, self, self.refreshView)
end

-- 注销监听事件(可选)
function GemBuyLayer:unRegisterListener()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_GEM_SHOP_BUY, self, self.buySuccessCallback)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_ADVERT_STATUS, self, self.refreshView)
end

function GemBuyLayer:getCloseAnimation()
    return nil
end
