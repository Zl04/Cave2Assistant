-- WarehouseGoodsPanel.lua
-- Author:孟繁东
-- 2017年5月19日
-- Using:简化版仓库组件

local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local WarehouseGoodsPanel = class("WarehouseGoodsPanel", UI.HWBtnComponent)
UI.WarehouseGoodsPanel = WarehouseGoodsPanel

local winSize = cc.Director:getInstance():getWinSize()
local GOODS_RARE = PublicDefine.GOODS_RARE
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE

local DEBUG = true

-- 资源文件
local COM_RES_LIST = {
    
}

-- 尺寸
local COM_WIDTH = 346
local COM_HEIGHT = 514

local BAG_GOODS_LAYOUT = {
    -- 物品分类tab
    GOODS_LIST_TAB_BUTTON_SPACE = 3,
    GOODS_LIST_TAB_BUTTON_WIDTH = 56,
    GOODS_LIST_TAB_BUTTON_HEIGHT = 60,
    GOODS_LIST_TAB_WIDTH = 250,
    GOODS_LIST_TAB_HEIGHT = 60,
    GOODS_LIST_TAB_RIGHT = 78,

}

-- 物品分类的背景图片
local SPRITE_GRID_ALL_BOX_NORMAL = "ui_goods_button_bg_down_0.png"
local SPRITE_GRID_ALL_BOX_ACTIVE = "ui_goods_button_bg_down_1.png"
-- 所有物品分类的图片
local SPRITE_GRID_ALL_GOODS_BUTTON_NORMAL = "ui_goods_button_all_0.png"
local SPRITE_GRID_ALL_GOODS_BUTTON_ACTIVE = "ui_goods_button_all_1.png"
local SPRITE_GRID_EQUIP_BUTTON_NORMAL = "ui_goods_button_equip_0.png"
local SPRITE_GRID_EQUIP_BUTTON_ACTIVE = "ui_goods_button_equip_1.png"
local SPRITE_GRID_EQUIPMENT_BUTTON_NORMAL = "ui_goods_button_quipment_0.png"
local SPRITE_GRID_EQUIPMENT_BUTTON_ACTIVE = "ui_goods_button_quipment_1.png"
local SPRITE_GRID_ITEM_BUTTON_NORMAL = "ui_goods_button_prop_0.png"
local SPRITE_GRID_ITEM_BUTTON_ACTIVE = "ui_goods_button_prop_1.png"
local SPRITE_GRID_MATERIAL_BUTTON_NORMAL = "ui_goods_button_material_0.png"
local SPRITE_GRID_MATERIAL_BUTTON_ACTIVE = "ui_goods_button_material_1.png"
local SPRITE_GRID_GEM_STONE_BUTTON_NORMAL = "ui_goods_button_gem_0.png"
local SPRITE_GRID_GEM_STONE_BUTTON_ACTIVE = "ui_goods_button_gem_1.png"
local SPRITE_GRID_RELIC_BUTTON_NORMAL = "ui_goods_button_relic_0.png"
local SPRITE_GRID_RELIC_BUTTON_ACTIVE = "ui_goods_button_relic_1.png"
-- 功能按钮

local SPRITE_FUNCTION_DUSTBIN_NORMAL = "ui_goods_button_dustbin_0.png"
local SPRITE_FUNCTION_DUSTBIN_ACTIVE = "ui_goods_button_dustbin_1.png"
local SPRITE_FUNCTION_SELL_NORMAL = "ui_goods_button_sell_0.png"
local SPRITE_FUNCTION_SELL_ACTIVE = "ui_goods_button_sell_1.png"
local SPRITE_FUNCTION_CHOICE_NORMAL = "ui_goods_button_choice_0.png"
local SPRITE_FUNCTION_CHOICE_ACTIVE = "ui_goods_button_choice_1.png"

local SPRITE_FUNCTION_CONFIRM = "ui_goods_button_hook.png"

-- 背包格子
local SPRITE_GAME_BACKPACK = "ui_goods_icon_backpack.png"



local ANIMATION_ACTIVE_BAGGRID_LIST = "animation"

-- local ANIMATION_

local function handleRefreshUseData(goodsArr, repeatData)
    local handleKey = 0
    local handleNum = 0
    for i=#goodsArr,1,-1 do
        local goodsData = goodsArr[i]
        local nowKey = goodsData:getGoodsID()..":"..tostring(goodsData:getIsGolden())

        goodsData:setUseNum(0)
        if(repeatData and repeatData[nowKey]) then
            if(handleKey ~= nowKey) then
                handleKey = nowKey
                handleNum = repeatData[nowKey]
            end
            if(goodsData:getNum() >= handleNum) then 
                goodsData:setUseNum(handleNum)
                handleNum = 0
            else 
                goodsData:setUseNum(goodsData:getNum())
                handleNum = handleNum - goodsData:getNum()
            end
        end 
    end
end

local function refreshBagData(self)
    -- 处理过滤相关操作后的数据
    local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE)

    -- 拥有物品装备列表
    for k,goodsData in pairs(self._data.haveEquipmentArr) do
        goodsData:setUseNum(0)
        if(repeatData and repeatData[goodsData:getEntityID()]) then
            goodsData:setUseNum(repeatData[goodsData:getEntityID()])
        end
    end
    if(self._data.havePetEquipmentArr) then
        for k,goodsData in pairs(self._data.havePetEquipmentArr) do
            goodsData:setUseNum(0)
            if(repeatData and repeatData[goodsData:getEntityID()]) then
                goodsData:setUseNum(repeatData[goodsData:getEntityID()])
            end
        end
    end

    handleRefreshUseData(self._data.haveItemArr, repeatData)
    handleRefreshUseData(self._data.haveMaterialArr, repeatData)
    handleRefreshUseData(self._data.haveGemStoneArr, repeatData)
    handleRefreshUseData(self._data.haveRelicArr, repeatData)
    handleRefreshUseData(self._data.haveTreasureArr, repeatData)
    
end


-- 显示物品
local function showGoodsByTabIndex(self, tabIndex)

    if (self._data) then
        self._bagGridList:setData(self._data, self._isUnlockBagFlag)
        if(self._isUnlockBagFlag) then
            self._isUnlockBagFlag = nil
        -- dump(self._data)
        else
            if (tabIndex == 1) then
                self._bagGridList:showAllGoods()
            elseif (tabIndex == 2) then
                self._bagGridList:showEquipments()
            elseif (tabIndex == 3) then
                self._bagGridList:showItems()
            elseif (tabIndex == 4) then
                self._bagGridList:showMaterials()
            elseif (tabIndex == 5) then
                self._bagGridList:showGemStone()
            elseif (tabIndex == 6) then
                self._bagGridList:showRelics()
            else
                assert(false, string.format("RolePanel showGoodsByTabIndex: tab index %d is invalid.", tabIndex))
            end
        end
    end
end


-- 更新整个列表
local function updateGridList(self, data)
    if (data) then
        -- TODO 刷新当前现实内容

        if (self._tabIndex <= 0) then
            self._tabIndex = 1
            showGoodsByTabIndex(self, 1)
        else
            showGoodsByTabIndex(self, self._tabIndex)
        end
        local petEquipNum = 0
        if(data.havePetEquipmentArr) then 
            petEquipNum = #data.havePetEquipmentArr
        end
        local maxCount = data.packetBoxBeUseNum
        local usedCount = #data.haveEquipmentArr + petEquipNum + #data.haveItemArr + #data.haveMaterialArr + #data.haveGemStoneArr + #data.haveRelicArr + #data.haveTreasureArr
        self._gridCountLabel:setText(tostring(usedCount), tostring(maxCount))
        self._gridCountLabel:updateView()

        if (data.heroData:getIsDead()) then
            self._bagGridList:disable()
        end
    end
end

-- 解锁背包格子
local function onUnlockBagGridHandler(self)
    self._data = GameDataManager:getInstance():getWearhouseData()
    refreshBagData(self)

    local data = self._data
    local petEquipNum = 0
    if(data.havePetEquipmentArr) then 
        petEquipNum = #data.havePetEquipmentArr
    end
     -- 更新格子数据
    local availableCount = data.packetBoxBeUseNum
    local usedCount = #data.haveEquipmentArr + petEquipNum + #data.haveItemArr + #data.haveMaterialArr + #data.haveRelicArr + #data.haveTreasureArr
    self._gridCountLabel:setText(tostring(usedCount), tostring(availableCount))
    self._gridCountLabel:updateView()
    self._isUnlockBagFlag = UNLOCK_BAG_FLAG.UNLOCK_BAG_FLAG_WAREHOUSE
    updateGridList(self, self._data)
    self._bagGridList:updateGridCount()
end

-- 选择不同类型的goods
local function onActiveGoodsTabHandler(self, tabIndex)
    if (self._selectedBagGrid) then
        self._selectedBagGrid:hideSelect()
    end

    self._tabIndex = tabIndex
    showGoodsByTabIndex(self, tabIndex)
end

-- 详情的touch事件的处理
local function onInfoAreaTouchHandler(self,obj,touchPosition)

    if obj and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

     -- 更新装备对比区域数据
    if(not tolua.isnull(self._infoArea)) then
        self._infoArea:close()
        self._infoArea = nil
    end
    if (self._selectedBagGrid) then
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end
end


function WarehouseGoodsPanel:ctor(usedType)
    WarehouseGoodsPanel.super.ctor(self, UIType.WAREHOUSE_GOODS_PANEL, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self._contentLayout = nil

    -- 存放要删除的格子
    self._deleteItemTable = {}
    -- 上一次选中的背包格子，上一次选中人物的格子
    self._selectedBagGrid = nil
    self._selectedRoleGrid = nil
    -- 是否正在拖拽
    self._isDraging = false
    -- 是否正在滚动背包
    self._isScrolling = false
    self._tabIndex = 1

    self._goodsTabList = nil
    -- 监听消息

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_WAREHOUSE, self, onUnlockBagGridHandler)

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_WAREHOUSE_CHANGE, self, self.onWarehouseChange)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_RESPONSE, self, self.onUnlockResponse)
end


function WarehouseGoodsPanel:showMove()
    if(self._bagGridList) then
        self._bagGridList:showMove()
    end
end

-- 隐藏移动效果
function WarehouseGoodsPanel:hideMove()
    if(self._bagGridList) then
        self._bagGridList:hideMove()
    end
end



function WarehouseGoodsPanel:dtor()
    WarehouseGoodsPanel.super.dtor(self)
    self._contentLayout = nil

    self._itemdestroy = nil
    self._deleteButton = nil 
    self._selectedBagGrid = nil
    self._selectedRoleGrid = nil

    self._deleteState = false

    self._tabIndex = 1

    self._goodsTabList = nil


    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_WAREHOUSE, self, onUnlockBagGridHandler)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_WAREHOUSE_CHANGE, self, self.onWarehouseChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_RESPONSE, self, self.onUnlockResponse)
end

function WarehouseGoodsPanel:onUnlockResponse()
    UI.WaitingLayer:hideWaiting()
end

--道具改变
function WarehouseGoodsPanel:onWarehouseChange(goodsType)
    local goodsList = GameDataManager:getInstance():getWarehouseGoodsArrForType(goodsType)
    if (goodsList) then
        if goodsType== PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
            self._data.haveEquipmentArr = goodsList
        elseif goodsType== PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
            self._data.havePetEquipmentArr = goodsList
        elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM then
            self._data.haveItemArr = goodsList
        elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
            self._data.haveMaterialArr = goodsList
        elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
            self._data.haveGemStoneArr = goodsList
        elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC then
            self._data.haveRelicArr = goodsList
        elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
            self._data.haveTreasureArr = goodsList
        end

        refreshBagData(self)

        updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        assert(false)
    end
end

-- public:
-- 初始化
function WarehouseGoodsPanel:init(spriteID, type)
    self._tabIndex = 1
    self._spriteID = spriteID
    self._type = type or GameBagUIType.NORMAL

    WarehouseGoodsPanel.super.init(self)
    -- self:setInterceptTouches(true)
end

-- 模版函数：初始化组建的视图
function WarehouseGoodsPanel:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    self:setTouchEnable(true)

    -- 物品分类按钮
    local goodsTabList = UI.TabList:create()
    goodsTabList:init(
        0, 
        BAG_GOODS_LAYOUT.GOODS_LIST_TAB_BUTTON_WIDTH-2, 
        BAG_GOODS_LAYOUT.GOODS_LIST_TAB_BUTTON_HEIGHT
    )
    goodsTabList:leftBottom(4, -50)
    goodsTabList:addEventListener(UIEvent.TAB_ACTIVE, self, onActiveGoodsTabHandler)
    self._contentLayout:addChild(goodsTabList)
    self._goodsTabList = goodsTabList

    -- 所有物品
    local allGoodsTab = UI.GoodsTabItem:create()
    allGoodsTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_ALL_GOODS_BUTTON_NORMAL, SPRITE_GRID_ALL_GOODS_BUTTON_ACTIVE)
    goodsTabList:addTab(allGoodsTab)

    -- -- 穿戴
    -- local allGoodsTab = UI.GoodsTabItem:create()
    -- allGoodsTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_EQUIP_BUTTON_NORMAL, SPRITE_GRID_EQUIP_BUTTON_ACTIVE)
    -- goodsTabList:addTab(allGoodsTab)
    -- -- 装备
    local equipmentTab = UI.GoodsTabItem:create()
    equipmentTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_EQUIPMENT_BUTTON_NORMAL, SPRITE_GRID_EQUIPMENT_BUTTON_ACTIVE)
    goodsTabList:addTab(equipmentTab)
    -- 道具
    local itemTab = UI.GoodsTabItem:create()
    itemTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_ITEM_BUTTON_NORMAL, SPRITE_GRID_ITEM_BUTTON_ACTIVE)
    goodsTabList:addTab(itemTab)
    -- 材料
    local materialTab = UI.GoodsTabItem:create()
    materialTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_MATERIAL_BUTTON_NORMAL, SPRITE_GRID_MATERIAL_BUTTON_ACTIVE)
    goodsTabList:addTab(materialTab)
    -- 宝石
    local gemStoneTab = UI.GoodsTabItem:create()
    gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_GEM_STONE_BUTTON_NORMAL, SPRITE_GRID_GEM_STONE_BUTTON_ACTIVE)
    goodsTabList:addTab(gemStoneTab)
    -- 遗物
    local relicTab = UI.GoodsTabItem:create()
    relicTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_RELIC_BUTTON_NORMAL, SPRITE_GRID_RELIC_BUTTON_ACTIVE)
    goodsTabList:addTab(relicTab)


    -- 背景页面
    local bg = UI.Image:create()
    bg:init("ui_warehouse_paper.png")
    bg:center()
    self._contentLayout:addChild(bg)

    -- 添加右边简洁背包数据
    local bagData = GameDataManager:getInstance():getWearhouseData()
    --克隆背包数据
    self._data = bagData
    refreshBagData(self)
    
    local bagList = UI.GoodsListNew:create(4, true)
    -- bagList:setColumnCount(4)
    bagList:init(bagData, 444)
    bagList:hideBGImageCover()
    bagList:setPos(0, -53 + 11)
    bagList:setCallbackForGridClick(self, self.bagClickCallback)
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    bagList:setCallbackForGridDoubleClick(self, self.bagCellDoubleClickCallback)
    self._bagGridList = bagList
    self._contentLayout:addChild(bagList)

    -- mask 遮罩
    local maskImage = UI.Image:create()
    maskImage:init("ui_warehouse_gradually.png")
    maskImage:centerBottom(51)
    self._contentLayout:addChild(maskImage)
    
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(304, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(24 + lineUpImage:getContentSize().width/2, 40))
    self._contentLayout:addChild(lineUpImage, 4)

    -- 可用格子
    local gridOffsetY = 8
    local gridOffsetX = 52
    local gridImage = UI.Image:create()
    gridImage:init("ui_goods_icon_backpack.png")
    gridImage:leftBottom(gridOffsetX,gridOffsetY)
    self._contentLayout:addChild(gridImage, 4)
    -- 可用格子
    local gridCountLabel = UI.GridText:create()
    gridCountLabel:init(string.format("%s/%s", 0, 0), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    gridCountLabel:leftBottom(gridOffsetX + 45, gridOffsetY + 10)
    gridCountLabel:setSize(90, 30)
    -- gridCountLabel:setTextCenter()
    self._contentLayout:addChild(gridCountLabel, 4)
    self._gridCountLabel = gridCountLabel


    updateGridList(self,self._data)
end

-- 切换到对应的背包页面
function WarehouseGoodsPanel:changeBagIndex(index)
    self._tabIndex= index
    if(self._goodsTabList) then
        self._goodsTabList:activeTab(index)
    end

end

function WarehouseGoodsPanel:changeBagDefaultIndex(index)
    if(self._goodsTabList) then
        self._goodsTabList:setDefaultIndex(index)
    end
end 



-- 注册消息
function WarehouseGoodsPanel:registerMessage()

end

-- 取消注册消息
function WarehouseGoodsPanel:unRegisterMessage()

end


function WarehouseGoodsPanel:bagClickCallback(bagGrid)
    if self._isDraging then 
        return 
    end

    local goodsData = nil
    if (not tolua.isnull(bagGrid)) then
        goodsData = bagGrid:getData()

        -- 把上次点击的关闭
        if self._selectedBagGrid then 
            self._selectedBagGrid:hideSelect()
            self._selectedBagGrid = nil 
        end

        if  self._selectedRoleGrid then 
            self._roleShowArea:unselectEquipment()
            self._selectedRoleGrid = nil 
        end

        if goodsData then 
            if goodsData:getIsNew() then
                -- 如果是新物品，发送消息
                GameManager:bagClickGoodsHandler(goodsData)
            end

            if self._deleteState == false then 
                bagGrid:showSelect()
            end
            local leftX = -274-20

            local worldPos = self._contentLayout:convertToWorldSpace(cc.p(0,0))
            -- leftX = worldPos.x + self._goodsTabList:getContentSize().width + 80 + 25
            leftX = worldPos.x + self._goodsTabList:getContentSize().width + 45

            -- 类型
            if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
                -- 装备详情
                local equipmentInfoArea = UI.EquipmentInfoArea:create()
                if self._tabIndex == 1 then
                    equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                else
                    equipmentInfoArea:init(UI.EquipImageBgType.BIG_TYPE)
                end
                self._infoArea = equipmentInfoArea
                -- 处理试穿对比
                local blackTable = GameDataManager:getInstance():tryEquipment(goodsData)
                equipmentInfoArea:updateInfo(blackTable)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                local equipmentInfoArea = UI.EquipmentPetInfoArea:create()
                if self._tabIndex == 1 then
                    equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                else
                    equipmentInfoArea:init(UI.EquipImageBgType.BIG_TYPE)
                end
                self._infoArea = equipmentInfoArea 
                equipmentInfoArea:updateInfo(goodsData, MasterDataManager:getFightWearEquipmentForEquipmentType(goodsData:getEquipmentType()))
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then 
                -- 道具详情界面
                local itemType = goodsData:getItemType()
                local propInfo = nil;
                if itemType == PublicDefine.ITEM_TYPE.ChooseBag then
                    propInfo = UI.SelectGoodsBagInfoArea:create()
                elseif itemType == PublicDefine.ITEM_TYPE.RandomBag then
                    propInfo = UI.RandomBagInfoArea:create()
                elseif itemType == PublicDefine.ITEM_TYPE.LevelBag then
                    propInfo = UI.LevelBagInfoArea:create()
                    propInfo:lockNextLevelBag()
                    propInfo:disableUse()
                else
                    propInfo = UI.PropInfoArea:create(true)
                end
                propInfo:init(UI.PROP_MATER.PROPINFO)
                self._infoArea = propInfo

            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then 
                -- 材料详情界面
                local materialInfo = nil
                if(goodsData:getMaterialType() ~= PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then
                    materialInfo = UI.PropInfoArea:create(true)
                else 
                    materialInfo = UI.MaterialEquipScrollInfoArea:create()
                end
                materialInfo:init(UI.PROP_MATER.MATERIALINFO)
                self._infoArea = materialInfo
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then 
                local materialInfo = UI.PropInfoArea:create(true)
                materialInfo:init(UI.PROP_MATER.MATERIALINFO)
                self._infoArea = materialInfo
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
                -- 宝石
                local propInfo = UI.GemStoneInfoArea:create()
                propInfo:init(goodsData)
                self._infoArea = propInfo 
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then 
                local propInfo = UI.StarPrayInfoArea:create()
                propInfo:init(goodsData)
                self._infoArea = propInfo
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
                local propInfo = UI.PetStoneInfoArea:create()
                propInfo:init(goodsData)
                self._infoArea = propInfo
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
                local propInfo = UI.RelicInfoArea:create()
                propInfo:init(goodsData)
                self._infoArea = propInfo
            end 
            if self._infoArea then
                self._infoArea:centerLeft(leftX)
                UI.UIManager:addToRootNode(self._infoArea,UI_ZORDER.EQUIPMENTINFO)
                self._infoArea:setGoodsGrid(bagGrid)

                self._infoArea:setVisible(true)
                self._infoArea:updateView(goodsData)
                self._infoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onInfoAreaTouchHandler)
            end
        end
        self._selectedBagGrid = bagGrid
    end
end

function WarehouseGoodsPanel:bagDragBeganCallback(goodsGrid, touchPosition)
    self._isDraging = true

    if (self._targetForDragBegan and self._functionForDragBegan) then
        if(not tolua.isnull(goodsGrid)) then
            local bagGridData = goodsGrid:getData()
            if (bagGridData and bagGridData:getIsNew()) then
                GameManager:bagClickGoodsHandler(bagGridData)
            end
        end

        self._functionForDragBegan(self._targetForDragBegan, goodsGrid, touchPosition)
    end
end

function WarehouseGoodsPanel:bagDragMovedCallback(goodsGrid, touchPosition)
    if (self._targetForDragMoved and self._functionForDragMoved) then
        self._functionForDragMoved(self._targetForDragMoved, goodsGrid, touchPosition)
    end

    local pos = self:convertToNodeSpace(touchPosition)
    local size = self:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    local inSide = cc.rectContainsPoint(rect, pos)
    if(self._bagGridList) then 
        self._bagGridList:changeInSideStatus(not inSide)
    end
end

function WarehouseGoodsPanel:bagDragEndedCallback(goodsGrid, touchPosition)
    self._isDraging = false
    if (self._targetForDragEnded and self._functionForDragEnded) then 
        Avalon.AudioManager:playSound("1505")
        self._functionForDragEnded(self._targetForDragEnded, goodsGrid, touchPosition)
    end
end

function WarehouseGoodsPanel:bagCellDoubleClickCallback(goodsGrid)
    if goodsGrid:getCanUseState() then
        -- local anchor = self:getAnchorPoint()
        -- local wPos = self:Local2Global()
        -- local x = wPos.x - self._width * anchor.x
        -- local y = wPos.y - self._height * anchor.y
        -- local pos = cc.p(x - 50, y + self._height / 2)
        self:bagDragEndedCallback(goodsGrid, cc.p(-10000, -10000))
    end
end

-- 添加拖拽格子开始的处理回调函数
function WarehouseGoodsPanel:setCallbackForGridDragBegan(target, func)
    self._targetForDragBegan = target
    self._functionForDragBegan = func
end

-- 添加拖拽格子的处理回调函数
function WarehouseGoodsPanel:setCallbackForGridDragMoved(target, func)
    self._targetForDragMoved = target
    self._functionForDragMoved = func
end

-- 添加拖拽格子完成的处理回调函数
function WarehouseGoodsPanel:setCallbackForGridDragEnded(target, func)
    self._targetForDragEnded = target
    self._functionForDragEnded = func
end

--刷新视图
function WarehouseGoodsPanel:refreshView()
    updateGridList(self,self._data)
end

function WarehouseGoodsPanel:setSpineBgVisible(visible)
    -- self.dragSpineBag:setVisible(visible)
end


