--[[
    UI - 背包中的日志
]]

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local LogLayer = class("LogLayer", UI.HWBtnComponent)
UI.LogLayer = LogLayer

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 852
local COM_HEIGHT = 534
-- 背包资源
local COM_RES_LIST = {
    "ui_package_log.plist",
}

-- 图片名字
local LOG_PANEL_SPRITE = {
    SCROLL_VIEW_SLIDER = "ui_role_slider_00.png",
    MONEY = "symbol_gaming_money.png",
    CRYSTAL = "symbol_gaming_diamond.png",
}

-- 布局
local LOG_PANEL_LAYOUT = {
    -- 面板内容布局
    -- 物品列表
    GOODS_GRID_INIT_COLUMN = 5,
    GOODS_GRID_INIT_ROW = 10,
    GOODS_GRID_WIDTH = 68,
    GOODS_GRID_HEIGHT = 68,
    GOODS_GRID_HORIZONTAL_SPACE = 6,
    GOODS_GRID_VERTICAL_SPACE = 6,
    GOODS_GRID_PADDING_SPACE = 6,
    -- 滚动视图背景
    GOODS_SCROLL_VIEW_BG_LEFT = 420,
    GOODS_SCROLL_VIEW_BG_UP = 94,
    -- 滑块
    GOODS_SCROLL_VIEW_SLIDER_LEFT = 895,
    GOODS_SCROLL_VIEW_SLIDER_UP = 110,
    GOODS_SCROLL_VIEW_SLIDER_WIDTH = 5,
    GOODS_SCROLL_VIEW_SLIDER_HEIGHT = 380,
    -- 战利品按钮
    SBOLIS_BUTTON_LEFT = 0,
    SBOLIS_BUTTON_UP = 0,
    -- 图鉴按钮
    PICTURE_BUTTON_LEFT = 0,
    PICTURE_BUTTON_UP = 0,
    -- 黄金
    MONEY_BG_LEFT = 570,
    MONEY_BG_UP = 92,
    MONEY_ICON_LEFT = 600,
    MONEY_ICON_UP = 63,
    MONEY_TEXT_LEFT = 640,
    MONEY_TEXT_UP = 64,
    -- tab控件
    TAB_LIST_RIGHT = 0,
    TAB_LIST_UP = 60,
    TAB_ITEM_SPACE = 20,
    TAB_ITEM_WIDTH = 114,
    TAB_ITEM_HEIGHT = 64,
    -- 装备详情布局
    EQUIPMENT_INFO_LAYOUT_WIDTH = 342,
    EQUIPMENT_INFO_LAYOUT_HEIGHT = 420,
    -- 装备详情
    EQUIPMENT_INFO_AREA_LEFT = 0,
    EQUIPMENT_INFO_AREA_UP = 4,
    ITEM_INFO_AREA_UP = 4,
    MATERIAL_INFO_AREA_UP = 4,
    GEMSTONE_INFO_AREA_UP = 4,
}



-- 构造函数
function LogLayer:ctor()
    LogLayer.super.ctor(self, UIType.LOG_LAYER, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    self._bagGridList = nil
    self._goodsListSlider = nil
    self._equipmentInfoArea = nil
    self._scrollView = nil
    self._selectedBagGrid = nil
end

-- 析构函数
function LogLayer:dtor()
    LogLayer.super.dtor(self)
end

-- 初始化
function LogLayer:init(logData)
    self._logData = logData
    LogLayer.super.init(self)
end

-- 初始化视图
function LogLayer:onInitView()

    self:createLogLayer()
end


function LogLayer:createLogLayer()
    -- 背景图片
    local bg =  cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png", CCRectMake(303,136,4,2))
    bg:setContentSize(COM_WIDTH, COM_HEIGHT)
    bg:setAnchorPoint(0, 0)
    bg:setPosition(0, 0)
    self:addChild(bg)

    local box = UI.Image:create()
    box:init("ui_log_banner_page_04.png")
    box:leftBottom(250, 50)
    self:addChild(box)

    -- 布局的根节点
    local rootLayout = UI.Layout:create()
    rootLayout:init()
    rootLayout:setSize(COM_WIDTH, COM_HEIGHT)
    rootLayout:leftBottom(0, 0)
    self:addChild(rootLayout)
    self.rootLayout = rootLayout
end

-- 更新视图
function LogLayer:onUpdateView()
    -- 物品列表
    local bagGridList = UI.ListView:create()
    bagGridList:init(
        UI.GoodsGrid,
        LOG_PANEL_LAYOUT.GOODS_GRID_INIT_COLUMN, 
        0,
        LOG_PANEL_LAYOUT.GOODS_GRID_WIDTH, 
        LOG_PANEL_LAYOUT.GOODS_GRID_HEIGHT, 
        LOG_PANEL_LAYOUT.GOODS_GRID_HORIZONTAL_SPACE, 
        LOG_PANEL_LAYOUT.GOODS_GRID_VERTICAL_SPACE, 
        LOG_PANEL_LAYOUT.GOODS_GRID_PADDING_SPACE
    )
    -- bagGridList:enableDebugDraw(UI.RED)
    bagGridList:setSwallowTouches(false)
    bagGridList:addEventListener(UIEvent.LIST_VIEW_GRID_CLICK, self, function(self, bagGrid, touchPosition)
        if (bagGrid) then
            if (self._selectedBagGrid) then
                self._selectedBagGrid:hideSelect()
            end

            local bagGridData = bagGrid:getData()
            if (bagGridData) then
                if (self._equipmentInfoArea) then
                    self._equipmentInfoArea:destroy()
                    self._equipmentInfoArea = nil
                end
                local isHideBg = false
                local goodsType = bagGridData:getGoodsType()
                if (goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
                    if (not self._equipmentInfoArea) then
                        self._equipmentInfoArea = UI.EquipmentInfoArea:create()
                        self._equipmentInfoArea:init(UI.EquipImageBgType.BIG_TYPE, nil, true)
                        self._equipmentInfoArea:leftUp(
                            0, LOG_PANEL_LAYOUT.EQUIPMENT_INFO_AREA_UP)
                        self._equipmentInfoArea:closeLockFlag()
                    end

                    local tryEquipmentDataList = GameDataManager:getInstance():tryEquipment(bagGridData) 
                    self._equipmentInfoArea:updateView(bagGridData)
                    self._equipmentInfoArea:updateInfo(tryEquipmentDataList)
                    isHideBg = true
                elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                    if (not self._equipmentInfoArea) then
                        self._equipmentInfoArea = UI.EquipmentPetInfoArea:create()
                        self._equipmentInfoArea:init(UI.EquipImageBgType.BIG_TYPE, nil, true)
                        self._equipmentInfoArea:leftUp(
                            0, LOG_PANEL_LAYOUT.EQUIPMENT_INFO_AREA_UP)
                        self._equipmentInfoArea:closeLockFlag()
                    end
                    self._equipmentInfoArea:updateInfo(bagGridData, MasterDataManager:getFightWearEquipmentForEquipmentType(bagGridData:getEquipmentType()))
                    self._equipmentInfoArea:updateView(bagGridData)
                    isHideBg = true
                elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM) then
                    if (not self._equipmentInfoArea) then
                        local itemType = bagGridData:getItemType()
                        if itemType == PublicDefine.ITEM_TYPE.ChooseBag then
                            self._equipmentInfoArea = UI.SelectGoodsBagInfoArea:create()
                        elseif itemType == PublicDefine.ITEM_TYPE.RandomBag then
                            self._equipmentInfoArea = UI.RandomBagInfoArea:create()
                        elseif itemType == PublicDefine.ITEM_TYPE.LevelBag then 
                            self._equipmentInfoArea = UI.LevelBagInfoArea:create()
                            self._equipmentInfoArea:lockNextLevelBag()
                            self._equipmentInfoArea:disableUse()
                        else
                            self._equipmentInfoArea = UI.PropInfoArea:create(true)
                        end
                        
                        self._equipmentInfoArea:init(UI.PROP_MATER.PROPINFO,bagGridData)
                        self._equipmentInfoArea:leftUp(0, LOG_PANEL_LAYOUT.ITEM_INFO_AREA_UP)
                        self._equipmentInfoArea:closeLockFlag()
                        isHideBg = true
                    end
                elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then
                    if (not self._equipmentInfoArea) then
                        if(bagGridData:getMaterialType() ~= PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then 
                            self._equipmentInfoArea = UI.PropInfoArea:create(true)
                        else
                            self._equipmentInfoArea = UI.MaterialEquipScrollInfoArea:create()
                        end 
                        self._equipmentInfoArea:init(UI.PROP_MATER.MATERIALINFO,bagGridData)
                        self._equipmentInfoArea:leftUp(0, LOG_PANEL_LAYOUT.MATERIAL_INFO_AREA_UP)
                        self._equipmentInfoArea:closeLockFlag()
                        isHideBg = true
                    end
                elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then 
                    if (not self._equipmentInfoArea) then
                        self._equipmentInfoArea = UI.PropInfoArea:create(true)
                        self._equipmentInfoArea:init(UI.PROP_MATER.MATERIALINFO,bagGridData)
                        self._equipmentInfoArea:leftUp(0, LOG_PANEL_LAYOUT.MATERIAL_INFO_AREA_UP)
                        self._equipmentInfoArea:closeLockFlag()
                        isHideBg = true
                    end
                elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
                    -- 宝石详情界面
                    if (not self._equipmentInfoArea) then
                        self._equipmentInfoArea = UI.GemStoneInfoArea:create()
                        self._equipmentInfoArea:init(bagGridData)
                        self._equipmentInfoArea:centerUp(0, LOG_PANEL_LAYOUT.GEMSTONE_INFO_AREA_UP)
                        self._equipmentInfoArea:closeLockFlag()
                        isHideBg = true
                    end 
                 elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then 
                    if (not self._equipmentInfoArea) then
                        self._equipmentInfoArea = UI.StarPrayInfoArea:create()
                        self._equipmentInfoArea:init(bagGridData)
                        self._equipmentInfoArea:centerUp(0, LOG_PANEL_LAYOUT.GEMSTONE_INFO_AREA_UP)
                        self._equipmentInfoArea:closeLockFlag()
                        isHideBg = true
                    end
                elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
                    if (not self._equipmentInfoArea) then
                        self._equipmentInfoArea = UI.PetStoneInfoArea:create()
                        self._equipmentInfoArea:init(bagGridData)
                        self._equipmentInfoArea:centerUp(0, LOG_PANEL_LAYOUT.GEMSTONE_INFO_AREA_UP)
                        self._equipmentInfoArea:closeLockFlag()
                        isHideBg = true
                    end
                elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC) then 
                    if (not self._equipmentInfoArea) then
                        self._equipmentInfoArea = UI.RelicInfoArea:create()
                        self._equipmentInfoArea:init(bagGridData)
                        self._equipmentInfoArea:centerUp(0, LOG_PANEL_LAYOUT.GEMSTONE_INFO_AREA_UP)
                        self._equipmentInfoArea:closeLockFlag()
                        isHideBg = true
                    end
                elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then 
                    if (not self._equipmentInfoArea) then
                        self._equipmentInfoArea = UI.GlyphInfoArea:create()
                        self._equipmentInfoArea:init(bagGridData)
                        self._equipmentInfoArea:centerUp(0, LOG_PANEL_LAYOUT.GEMSTONE_INFO_AREA_UP)
                        self._equipmentInfoArea:closeLockFlag()
                        isHideBg = true
                    end 
                else

                    assert(false)
                end    

                if (self._equipmentInfoArea) then
                    self._equipmentInfoArea:setInterceptTouches(false)
                    self._equipmentInfoArea:setGlobalZOrder(10000)
                    self._equipmentInfoLayout:addChild(self._equipmentInfoArea, 20)
                end
                if isHideBg then
                    local itemInfoBg = self._equipmentInfoLayout:getChildByName("ItemInfoBg")
                    if itemInfoBg then
                        itemInfoBg:hide()
                    end
                end
                bagGrid:showSelect()
                self._selectedBagGrid = bagGrid  
                self._noDataTips:hide() 
            end
        end
    end)
    self._bagGridList = bagGridList

    -- 滚动视图
    local bagScrollView = UI.BagScrollView:create(412, 352)
    bagScrollView:init(0, 0, 0, 0)
    bagScrollView:leftUp(40, 120)
    bagScrollView:setTouchEnable(true)
    bagScrollView:addInnerNode(bagGridList)
    self.rootLayout:addChild(bagScrollView)
    bagScrollView:setScrollBarEnabled(true)
    self._scrollView = bagScrollView
    self._scrollView:setCircleVisible(false)
    self._scrollView:setScrollBarWidth(5)
    self._scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    -- bagScrollView:enableDebugDraw()
    -- 标题 
    local titleBG = UI.Image:create()
    titleBG:init("ui_log_banner_page_03.png")
    titleBG:leftUp(60, 12)
    self.rootLayout:addChild(titleBG)

    local momeyImage = UI.Image:create()
    momeyImage:init(LOG_PANEL_SPRITE.MONEY)
    momeyImage:leftUp(210, 83)
    momeyImage:setScale(1.2)
    self.rootLayout:addChild(momeyImage)
    self._momeyImage = momeyImage
    -- 黄金数量
    self._momey = UI.Text:create()
    self._momey:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._momey:leftUp(240, 80)
    self._momey:setTextLeft()
    self.rootLayout:addChild(self._momey)
    -- self._momey:enableDebugDraw()
    self:refreshMoneyPos()

    -- local momeyImage = UI.Image:create()
    -- momeyImage:init(LOG_PANEL_SPRITE.CRYSTAL)
    -- momeyImage:leftUp(240, 83)
    -- momeyImage:setScale(1.2)
    -- -- self.rootLayout:addChild(momeyImage)

    -- self._diamond = UI.Text:create()
    -- self._diamond:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    -- self._diamond:leftUp(270, 79)
    -- self._diamond:setSize(130, 30)
    -- self._diamond:setTextLeft()
    -- -- self._diamond:enableDebugDraw()
    -- self.rootLayout:addChild(self._diamond)

    -- 战利品标题
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_111028, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(12+2)
    titleBG:addChild(titleText)

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(365, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(228, 420))
    self.rootLayout:addChild(lineUpImage)

    local lineDownImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineDownImage:setContentSize(365, 1)
    lineDownImage:setCapInsets(CCRectMake(1,0,1,1))
    lineDownImage:setPosition(cc.p(228, 50))
    self.rootLayout:addChild(lineDownImage)

    -- 装备详情布局
    local equipmentInfoLayout = UI.Layout:create()
    equipmentInfoLayout:init()
    equipmentInfoLayout:leftUp(472, 66)
    equipmentInfoLayout:setSize(
        LOG_PANEL_LAYOUT.EQUIPMENT_INFO_LAYOUT_WIDTH,
        LOG_PANEL_LAYOUT.EQUIPMENT_INFO_LAYOUT_HEIGHT
    )
    self.rootLayout:addChild(equipmentInfoLayout)
    self._equipmentInfoLayout = equipmentInfoLayout

    local noGoodsTips = UI.Text:create()
    noGoodsTips:init(UI.TEXT_1170907, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    noGoodsTips:leftUp(100, 175)
    noGoodsTips:setSize(260, 200)
    noGoodsTips:setTextCenter()
    self.rootLayout:addChild(noGoodsTips)

    local itemInfoBg = UI.Image:create()
    itemInfoBg:init("ui_log_itemInfo_bg.png")
    itemInfoBg:leftBottom(0, 0)
    self._equipmentInfoLayout:addChild(itemInfoBg)
    itemInfoBg:setName("ItemInfoBg")

    local itemInfoBg2 = UI.Image:create()
    itemInfoBg2:init("ui_iteminfo_role_banner_box1.png")
    itemInfoBg2:center()
    itemInfoBg:addChild(itemInfoBg2)

    local noDataTips = UI.Text:create()
    noDataTips:init(UI.TEXT_1170908, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    noDataTips:centerUp(180)
    noDataTips:setSize(320, 60)
    noDataTips:setTextCenter()
    itemInfoBg:addChild(noDataTips)
    self._noDataTips = noDataTips
    -- noDataTips:enableDebugDraw()
    if SceneManager:getInstance():isNotInFightScene() then 
        noGoodsTips:setText(UI.TEXT_1170900)
    else
        noGoodsTips:setText(UI.TEXT_1170907)
    end

    if (not (SceneManager:getInstance():isInFightScene() and not SceneManager:getInstance():isInDungeon())) then 
        self._scrollView:setScrollBarEnabled(false)
        return 
    end

    if (self._logData) then
        local allGoodsDataList = {}
        local index = 1
        local equipmentDataList = self._logData.equipmentArr
        if (equipmentDataList) then
            for i = 1, #equipmentDataList do
                table.insert(allGoodsDataList, index, equipmentDataList[i])
                index = index + 1
            end
        end
        local itemDataList = self._logData.itemArr
        if (itemDataList) then
            for i = 1, #itemDataList do
                table.insert(allGoodsDataList, index, itemDataList[i])
                index = index + 1
            end
        end
        local materialDataList = self._logData.materialArr
        if (materialDataList) then
            for i = 1, #materialDataList do
                table.insert(allGoodsDataList, index, materialDataList[i])
                index = index + 1
            end
        end
        local gemStoneDataList = self._logData.gemStoneArr
        if (gemStoneDataList) then
            for i = 1, #gemStoneDataList do
                table.insert(allGoodsDataList, index, gemStoneDataList[i])
                index = index + 1
            end
        end

        self._bagGridList:createGridListByDataList(allGoodsDataList)
        self._bagGridList:updateView()
        local gridList = self._bagGridList:getGridList()
        if (gridList) then
            for i = 1, #gridList do
                local grid = gridList[i]
                grid:hideNewIcon()
            end
        end

        self._momey:setText(self._logData.rewardCoin)
        self:refreshMoneyPos()
        -- self._diamond:setText(self._logData.rewardDiamond or 0)
        if #allGoodsDataList ~= 0 then
            noGoodsTips:hide()
        end
    else
        self._scrollView:setScrollBarEnabled(false)
    end
end


function LogLayer:refreshMoneyPos()
    local left = (self._momeyImage:getContentSize().width + self._momey:getContentSize().width + 10) / 2
    self._momeyImage:leftUp(228 - left, self._momeyImage:getUp())
    self._momey:leftUp(self._momeyImage:getLeft() + self._momeyImage:getContentSize().width + 10 , self._momey:getUp())
end