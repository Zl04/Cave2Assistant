------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/04/24
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local LayoutUtil = require "app.ui.UILayoutUtils"
local StarPrayView = class("StarPrayView", UI.HWBtnComponent)
local winSize = cc.Director:getInstance():getWinSize()
local StarPrayBagLayer = require("app.modules.starpray.StarPrayBagLayer")
-- 资源
local COM_RES_LIST = {
    "ui_town_starpray.plist"
}

-- local COM_WIDTH = 852
local COM_WIDTH = 914
local COM_HEIGHT = 534
local LAYOUT_DESIGN_WIDTH = 1136
local LAYOUT_DESIGN_HEIGHT = 640
-- 图片名字
local SPRITE = {
    BUTTON_NORMAL = "ui_btn_gray2_0.png",
    BUTTON_ACTIVE = "ui_btn_gray2_1.png",
    BUTTON_DISABLE = "ui_btn_gray2_2.png"
}

local BAG_GOODS_LAYOUT = {
    -- 物品分类tab
    GOODS_LIST_TAB_BUTTON_SPACE = 17,
    GOODS_LIST_TAB_BUTTON_WIDTH = 56,
    GOODS_LIST_TAB_BUTTON_HEIGHT = 60
}
local SPRITE_GRID_ALL_BOX_NORMAL = "ui_goods_button_bg_down_0.png"
local SPRITE_GRID_ALL_BOX_ACTIVE = "ui_goods_button_bg_down_1.png"

local SPRITE_GRID_ALL_GOODS_BUTTON_NORMAL = "ui_goods_button_all_0.png"
local SPRITE_GRID_ALL_GOODS_BUTTON_ACTIVE = "ui_goods_button_all_1.png"
local SPRITE_GRID_EQUIP_BUTTON_NORMAL = "ui_goods_button_equip_0.png"
local SPRITE_GRID_EQUIP_BUTTON_ACTIVE = "ui_goods_button_equip_1.png"

local LAYOUT = {
    -- TAB_LIST_LEFT = 802,
    TAB_LIST_LEFT = 895,
    TAB_LIST_UP = 80,
    TAB_ITEM_SPACE = 3,
    TAB_ITEM_WIDTH = 114,
    TAB_ITEM_HEIGHT = 64
}

local EQUIP_ITEM_TABLE_WIDTH = 108
local EQUIP_ITEM_TABLE_HEIGHT = 36

local layoutUU
function StarPrayView:ctor(param)
    StarPrayView.super.ctor(self, UI.Type.TIPS, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:bindModel()
    local npcId = param
    self._selectEquipID = 1
    mvc.starPrayModel:setNpcId(npcId)
    layoutUU = UIUtil:createAutoUILayout("StarPrayEquipView", "app.modules.starpray.StarPrayPosConfig", false)
end
function StarPrayView:dtor()
    StarPrayView.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.starpray.StarPrayView")
end

function StarPrayView:createBg()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(LAYOUT_DESIGN_WIDTH, LAYOUT_DESIGN_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    

    local board = UI.Image:create()
    board:init("ui_4package_box_board.png")
    board:leftBottom(77, 16)
    contentLayout:addChild(board, 1)

    local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    centerBg:setContentSize(COM_WIDTH, COM_HEIGHT)
    centerBg:setCapInsets(CCRectMake(304, 141, 1, 1))
    centerBg:setPosition(cc.p(COM_WIDTH / 2 + 95, COM_HEIGHT / 2 + 20))
    contentLayout:addChild(centerBg, 2)

    local upLine = UI.Image:create()
    upLine:init("ui_4package_box_up2.png")
    upLine:centerUp(35)
    contentLayout:addChild(upLine, 12)

    local upLine = UI.Image:create()
    upLine:init("ui_bg_title.png")
    upLine:centerUp(20)
    contentLayout:addChild(upLine, 12)

    local text =
        UIUtil:createAdaptTextComponent(
        UI.TEXT_1212450,
        UI.FONT_BOLD,
        UI.FONT_SIZE_26PX,
        UI.FONT_COLOR_155_155_155,
        200
    )
    text:center()
    upLine:addChild(text)

    local bottomLine = UI.Image:create()
    bottomLine:init("ui_4package_box_down.png")
    bottomLine:leftBottom(15, 0)
    contentLayout:addChild(bottomLine, 12)

    local leftLine = UI.Image:create()
    leftLine:init("ui_4package_box_left.png")
    leftLine:leftBottom(14, 18)
    contentLayout:addChild(leftLine, 11)

    local rightLine = UI.Image:create()
    rightLine:init("ui_4package_box_right.png")
    rightLine:rightBottom(10, 18)
    contentLayout:addChild(rightLine, 4)
    

    return contentLayout
end

function StarPrayView:createTabList()
    -- tab控件
    local tabList = UI.TabList:create()
    tabList:init(LAYOUT.TAB_ITEM_SPACE, LAYOUT.TAB_ITEM_WIDTH, LAYOUT.TAB_ITEM_HEIGHT)
    tabList:leftUp(LAYOUT.TAB_LIST_LEFT, LAYOUT.TAB_LIST_UP)
    tabList:setReverseOrder(true)
    tabList:addEventListener(UIEvent.TAB_ACTIVE, self, self.onActiveTabHandler)
    tabList:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
    for k, textStr in ipairs({UI.TEXT_1212451, UI.TEXT_1212452, UI.TEXT_228204}) do
        local tab = UI.FunctionTabItem:create()
        tab:init(
            SPRITE.BUTTON_NORMAL,
            SPRITE.BUTTON_ACTIVE,
            SPRITE.BUTTON_DISABLE,
            textStr,
            UI.FONT_BOLD,
            UI.FONT_SIZE_20PX
        )
        tabList:addToTab(tab, k)
        tab:setFontColor(UI.FONT_COLOR_48_50_56, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)
        tab.onDisableClick = handler(self, self.tabDisableClick)
    end
    self._tabList = tabList
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(contentLayout, 5)

    self:addChild(tabList)
end

function StarPrayView:createEquipList()

    self.plateIDList = mvc.starPrayModel:getStarPlateListDatasID()

    if #self.plateIDList <= 0 then
        return
    end
    
    self._selectEquipID = self.plateIDList[1]

    --筛选已选择装备的星痕
    self.equipContentLayout = UI.Layout:create()
    self.equipContentLayout:init()
    self.equipContentLayout:leftBottom(397 + 62,471)
    self.equipContentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(self.equipContentLayout, 10)

    local equipItemTableView = UI.TableView.new({}, 386, 440)
    equipItemTableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    equipItemTableView:leftBottom(0, -25)
    equipItemTableView:setDelegate()
    equipItemTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
    equipItemTableView:setBounceable(true)
    equipItemTableView:init()
    equipItemTableView:onUpdateCellSize(function (table,idx)
        local index = idx + 1
        if index == 1 then
            return EQUIP_ITEM_TABLE_WIDTH + 8, EQUIP_ITEM_TABLE_HEIGHT + 8
        else
            return EQUIP_ITEM_TABLE_WIDTH, EQUIP_ITEM_TABLE_HEIGHT
        end
        
    end)

    equipItemTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        if cell then
            cell:removeAllChildren()
            cell = nil
        end
        xpcall(function()
            local index = idx + 1
            local vSize = nil
            if index == 1 then
                vSize = cc.size(EQUIP_ITEM_TABLE_WIDTH + 8, EQUIP_ITEM_TABLE_HEIGHT + 8)
            else
                vSize = cc.size(EQUIP_ITEM_TABLE_WIDTH, EQUIP_ITEM_TABLE_HEIGHT)
            end
            if not cell then
                cell = UI.TableViewCell:create()
                cell:setContentSize(vSize)
            end
            self:updateCellView(index,cell,vSize)
        end, 
        function(e) 
            printError("StarPrayView:createEquipList, error")
        end, 1) 
        return cell
    end)

    equipItemTableView:onUpdateCellNumbers(function ()
        return #self.plateIDList
    end)

    self.equipContentLayout:addChild(equipItemTableView)

    equipItemTableView:reloadData(true)
    self.equipItemTableView = equipItemTableView
    self.equipContentLayout:hide()
    
end

function StarPrayView:updateCellView(index,cell,vSize)

    local cellView = cell:getChildByName("cyout")

    if not cellView then
        local cyout = UI.Layout:create()
        cyout:init()
        cyout:setSize(vSize.width, vSize.height)
        cyout:setName("cyout")
        cell:addChild(cyout)

        local configData = ConfigManager:getStarPlateDataByID(self.plateIDList[index])

        local pButton = UI.Button:create()
        pButton:init('ui_starmarks_title_02.png', 'ui_starmarks_title_01.png', 'ui_starmarks_title_01.png')
        pButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        pButton:setText(LanguageManager:getInstance():getLocalString(configData.name))
        pButton:setName("pButton")
        pButton:setSwallowTouches(false)
        pButton:closeClickScale()
        pButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self._selectEquipID = self.plateIDList[index]
            self:updateBagList()
            self.equipItemTableView:reloadData(true)
        end)
        cyout:addChild(pButton)

        if self._selectEquipID == self.plateIDList[index] then
            pButton:disable()
        else
            pButton:enable()
        end

        if index == 1 then
            local battleAnimation = UI.Animation:create()
            battleAnimation:init("effect_ui_town_guild_guildfuben_fighting.json", "effect_ui_town_guild_guildfuben_fighting.atlas")
            battleAnimation:leftUp(12, 12)
            battleAnimation:setAnimation("idle", true)
            battleAnimation:setScaleX(0.7)
            battleAnimation:setScaleY(0.7)
            cyout:addChild(battleAnimation, 10)

            pButton:leftBottom(8,0)
        else
            pButton:leftBottom(0,0)
        end

    else
        local pButton = cellView:getChildByName("pButton")
        if pButton then
            if self._selectEquipID == index then
                pButton:disable()
            else
                pButton:enable()
            end
        end
    end


end

function StarPrayView:tabDisableClick()
end

function StarPrayView:onActiveTabHandler(index)
    mvc.send("StarPray_ChangeLayer", index)
end

-- 注册监听事件(可选)
function StarPrayView:bindModel()
end

-- 注销监听事件(可选)
function StarPrayView:unbindModel()
end

function StarPrayView:hideRightView()
    if self.bagView then self.bagView:hide() end
    if self.gridImage1 then self.gridImage1:hide() end
    if self.gridImage2 then self.gridImage2:hide() end
    if self.lineUpImage1 then self.lineUpImage1:hide() end
    if self.lineUpImage2 then self.lineUpImage2:hide() end
    if self.gridCountLabel then self.gridCountLabel:hide() end
    self:hideTabList()
end

function StarPrayView:showRightView()
    if self.bagView then self.bagView:show() end
    if self.gridImage1 then self.gridImage1:show() end
    if self.gridImage2 then self.gridImage2:show() end
    if self.lineUpImage1 then self.lineUpImage1:show() end
    if self.lineUpImage2 then self.lineUpImage2:show() end
    if self.gridCountLabel then self.gridCountLabel:show() end
    self:showTabList()
end

function StarPrayView:onInitView()
    self:createBg()
    self:center(0, 0)
    self:createTabList()
    self:createEquipList()
    self._tabIndex = 1

    local bagData = clone(mvc.starPrayModel:getStarPrayData())

    local bagView =
        StarPrayBagLayer:create(
        bagData,
        self,
        self.bagDragBeganCallback,
        self.bagDragMovedCallback,
        self.bagDragEndedCallback,
        390
    )
    bagView:init()
    addChildAuto(layoutUU, self, bagView, "bagView")
    self.bagView = bagView
    self._bagGridList = bagView._bagGridList
    self.bagData = bagData

    local gridImage = UI.Image:create()
    gridImage:init('ui_goods_icon_backpack.png')
    addChildAuto(layoutUU, self, gridImage, 'gridImage')
    self.gridImage1 = gridImage

    local gridImage = UI.Image:create()
    gridImage:init("ui_starpray_banner_mask_1.png")
    addChildAuto(layoutUU, self, gridImage, "gridImage12")
    self.gridImage2 = gridImage

    -- 货币组件
    -- self._currencyPanel = UI.CurrencyPanel:create()
    -- self._currencyPanel:setShowShopButton(true, 52)
    -- addChildAuto(layoutUU, self, self._currencyPanel, "_currencyPanel3", "leftBottom")

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(387, 1.1)
    lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    addChildAuto(layoutUU, self, lineUpImage, "lineUpImage1")
    self.lineUpImage1 = lineUpImage

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(387, 1.1)
    lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    addChildAuto(layoutUU, self, lineUpImage, "lineUpImage2")
    self.lineUpImage2 = lineUpImage

    -- 可用格子
    local gridCountLabel = UI.GridText:create()
    gridCountLabel:init(string.format("%s/%s", 0, 0), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    gridCountLabel:setSize(90, 30)
    addChildAuto(layoutUU, self, gridCountLabel, "gridCountLabel")
    self.gridCountLabel = gridCountLabel

    -- 物品分类按钮
    local goodsTabList = UI.TabList:create()
    goodsTabList:init(
        BAG_GOODS_LAYOUT.GOODS_LIST_TAB_BUTTON_SPACE,
        BAG_GOODS_LAYOUT.GOODS_LIST_TAB_BUTTON_WIDTH,
        BAG_GOODS_LAYOUT.GOODS_LIST_TAB_BUTTON_HEIGHT
    )
    goodsTabList:addEventListener(UIEvent.TAB_ACTIVE, self, self.onActiveGoodsTabHandler)
    addChildAuto(layoutUU, self, goodsTabList, "goodsTabList")
    self._goodsTabList = goodsTabList

    -- 所有物品
    local allGoodsTab = UI.GoodsTabItem:create()
    allGoodsTab:init(
        SPRITE_GRID_ALL_BOX_NORMAL,
        SPRITE_GRID_ALL_BOX_ACTIVE,
        SPRITE_GRID_ALL_GOODS_BUTTON_NORMAL,
        SPRITE_GRID_ALL_GOODS_BUTTON_ACTIVE
    )
    goodsTabList:addTab(allGoodsTab)

    -- 穿戴
    local allGoodsTab = UI.GoodsTabItem:create()
    allGoodsTab:init(
        SPRITE_GRID_ALL_BOX_NORMAL,
        SPRITE_GRID_ALL_BOX_ACTIVE,
        SPRITE_GRID_EQUIP_BUTTON_NORMAL,
        SPRITE_GRID_EQUIP_BUTTON_ACTIVE
    )
    goodsTabList:addTab(allGoodsTab)

    self._gridCountLabel = gridCountLabel

    self._gridCountLabel:setText(tostring(#self.bagData.haveItemArr), tostring(self.bagData.packetBoxBeUseNum))
    self._gridCountLabel:updateView()


    -- local iconAnimation = UI.Animation:create()
    -- iconAnimation:init("effect_ui_town_starpray_tunshi_book.json", "effect_ui_town_starpray_tunshi_book.atlas", 1)
    -- iconAnimation:setAnimation("idle", true)
    -- iconAnimation:setSize(50, 50)
    -- addChildAuto(layoutUU, self, iconAnimation, "BgAnimation1", "center",900210)
    

    local iconAnimation = UI.Animation:create()
    iconAnimation:init("effect_ui_town_starpray_tunshi_candle.json", "effect_ui_town_starpray_tunshi_candle.atlas", 1)
    iconAnimation:setAnimation("idle", true)
    iconAnimation:setSize(50, 50)
    addChildAuto(layoutUU, self, iconAnimation, "BgAnimation2", "center", 100210)
end

-- 选择不同类型的goods
function StarPrayView:onActiveGoodsTabHandler(tabIndex)
    if self.isHideTab then
        return
    end
    self._tabIndex = tabIndex
   
    self:updateBagList()
end
function StarPrayView:bagDragBeganCallback()
    mvc.send("StarPray_Bag_Touch_Begin")
    return true
end

function StarPrayView:bagDragMovedCallback()
end

function StarPrayView:isInScrollView(touchPosition)
    local target = self._bagGridList._scrollView
    local pos = target:convertToWorldSpace(cc.p(0, 0))
    local rect = cc.rect(pos.x, pos.y, target._width, target._height)
    return cc.rectContainsPoint(rect, touchPosition)
end

function StarPrayView:showTabList()
    self._goodsTabList:show()
    self._goodsTabList:activeTab(1)
    self.isHideTab = false
end

function StarPrayView:hideTabList()
    self._tabIndex = 1
    self._goodsTabList:hide()
    self._bagGridList:showItems()
    self.isHideTab = true
    self._gridCountLabel:setText(tostring(#self.bagData.haveItemArr), tostring(self.bagData.packetBoxBeUseNum))
    self._gridCountLabel:updateView()

    if self.equipContentLayout then
        self.equipContentLayout:hide()
    end

    mvc.starPrayModel:resetStarPrayBagGoodsAllData()
end

function StarPrayView:updateBagList(isReset)
    if isReset then
        self.bagView:resetGoodsData()
    end
    self.bagData = clone(mvc.starPrayModel.bagData)
    if self._tabIndex == 1 then
        mvc.starPrayModel:sortBagData()

        if self._bagGridList._goodsData and self._bagGridList._goodsData.haveItemArr then
            self._bagGridList._goodsData.haveItemArr = mvc.starPrayModel.bagData.haveItemArr
        end

        self._bagGridList:showItems()
        self._gridCountLabel:setText(tostring(#self.bagData.haveItemArr), tostring(self.bagData.packetBoxBeUseNum))

        if self.equipContentLayout then
            self.equipContentLayout:hide()
        end
    else
        if self.equipContentLayout then
            self.equipContentLayout:show()
        end
        
        local data = mvc.starPrayModel:getCurStarPlateDatasByBelong(self._selectEquipID)
        -- print("datadatadatadata ==== ",table.nums(data))
        -- dump(data,nil,10)
        if self._bagGridList._goodsData and self._bagGridList._goodsData.haveEquipmentArr then
            self._bagGridList._goodsData.haveEquipmentArr = data
        end

        self._bagGridList:showEquipments()

        -- self._gridCountLabel:setText(tostring(#self.bagData.haveEquipmentArr), 100)
        self._gridCountLabel:setText(tostring(#data), 100)
    end
    self._gridCountLabel:updateView()
end

function StarPrayView:bagDragEndedCallback(grid, touchPosition)
    local curSelectStarPlate = mvc.starPrayModel:getCurStarPlate()
    mvc.send("StarPray_Bag_Touch_End", grid, touchPosition, curSelectStarPlate)
end

return StarPrayView
