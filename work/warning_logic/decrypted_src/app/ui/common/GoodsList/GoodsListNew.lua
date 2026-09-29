--[[
    UI - 背包格子列表（带滚动功能）
]]--

require "app.ui.Component"
require "app.ui.common.GoodsList.GoodsGrid"
require "app.ui.common.GoodsList.GoodsGridList"
require "app.ui.common.GoodsList.GoodsScrollView"
require "app.ui.common.GoodsList.GoodsListCell"

UI = UI or {}

local GoodsListNew = class("GoodsListNew", UI.HWBtnComponent)
UI.GoodsListNew = GoodsListNew

-- private:
local DEBUG = false
local DEBUG_DRAW = false
local waitingRefresNum = 2

FLITER_TYPE = {
    EQUIPMENT_ALL = 0,            -- 装备过滤，显示所有装备
    EQUIPMENT_ONLY_SHOW_HERO = 1, -- 装备过滤，仅显示主角装备
    EQUIPMENT_ONLY_SHOW_PET = 2,  -- 装备过滤，仅显示宠物装备
    EQUIPMENT_FLITER_FISH = 3,  -- 装备过滤，过滤渔具
    ITEM_IDENTIFY_TREASURE = 4, -- 道具过滤, 只显示宝藏类型道具
}

-- 选择类型
local CHOICE_TYPE = {
    TYPE_ALL = 1,
    TYPE_WEAR = 2,
    TYPE_EQUIPMENTS = 3,
    TYPE_ITEMS = 4,
    TYPE_MATERIAL = 5,
    TYPE_GEM_STONE = 6,
    TYPE_GEM_STONE_WEAR = 7,
    TYPE_GEM_STONE_EQUIP = 8,
    TYPE_WAREHOUSE = 9,
    TYPE_RELIC = 10,
    TYPE_PET_STIONE = 11,
    TYPE_GLYPH = 12,
    TYPE_GLYPH_WEAR = 13,
    TYPE_GLYPH_EQUIP = 14,
    TYPE_GLYPH_ALL = 15,
}

-- 尺寸
local COM_WIDTH = 422
local COM_HEIGHT = 465
-- 资源
local RES_LIST = {
    
}

local SPRITES = {
    COM_BG = "ui_goods_banner_large.png",
    COM_SLIDER = "ui_role_slider_00.png",
}

-- 清理拖拽对象
local function clearDragGrid(self)
    if(self._draggedGoodsGrid) then
        self._draggedGoodsGrid:destroy()
        self._draggedGoodsGrid = nil
    end
end

-- 背包格子拖拽开始的处理器
local function onGoodsGridDragBeganHandler(self, goodsGrid, touchPosition)

    if(goodsGrid == nil) then  return end
    if (not self._tableView:checkTouchPosition(touchPosition)) then return end
    -- print("onGoodsGridDragBeganHandler", self._canDrag)
    if self._canDrag == false then
        return
    end

    clearDragGrid(self)

    if not goodsGrid:getCanUseState() then
        return
    end
    
    self._draggedGoodsGrid = goodsGrid:createDraggedView()
    if (self._draggedGoodsGrid) then
        local rootLayer = UI.UIManager:getRootNode()
        rootLayer:addChild(self._draggedGoodsGrid, UI.MAX_Z_ORDER)

        require("app.ui.common.GoodsList.DragFingerAnimation")
        local dragAnimation = UI.DragFingerAnimation:create()
        dragAnimation:init()
        dragAnimation:centerUp(-30)
        dragAnimation:setName("drag_finger")
        self._draggedGoodsGrid:addChild(dragAnimation)
        self._dragAnimation = dragAnimation


        local rootLayerLocalPosition = rootLayer:convertToNodeSpace(touchPosition)
        local gridLocalPosition = goodsGrid:convertToNodeSpace(touchPosition)
        self._draggedGoodsGrid:leftBottom(
            rootLayerLocalPosition.x - gridLocalPosition.x, 
            rootLayerLocalPosition.y - gridLocalPosition.y
        )
        self._girdLocalPosition = gridLocalPosition

        goodsGrid:hideIcon()

        -- 调用回调函数
        if (self._targetForDragBegan and self._functionForDragBegan) then
            self._functionForDragBegan(self._targetForDragBegan, goodsGrid, touchPosition)
        end
    end
end

-- 背包格子拖拽的处理器
local function onGoodsGridDragMovedHandler(self, goodsGrid, touchPosition)
    if(goodsGrid == nil) then  return end

    if self._canDrag == false then
        return
    end
    if self._draggedGoodsGrid then
        if not goodsGrid:getCanUseState() then
            return
        end
        if (self._draggedGoodsGrid) then
            local rootLayer = UI.UIManager:getRootNode()
            local rootLayerLocalPosition = rootLayer:convertToNodeSpace(touchPosition)
            self._draggedGoodsGrid:leftBottom(
                rootLayerLocalPosition.x - self._girdLocalPosition.x, 
                rootLayerLocalPosition.y - self._girdLocalPosition.y
            )

            if (self._targetForDragMoved and self._functionForDragMoved) then
                self._functionForDragMoved(self._targetForDragMoved, goodsGrid, touchPosition)
            end
        end
    end
end

-- 背包格子拖拽结束的处理器
local function onGoodsGridDragEndedandler(self, goodsGrid, touchPosition)
    if(not tolua.isnull(self._draggedGoodsGrid)) then 
        self._draggedGoodsGrid:removeChildByName("drag_finger")
    end

    if(goodsGrid == nil) then  return end

    if self._canDrag == false then
        return
    end

    if (self._draggedGoodsGrid) then
        if not goodsGrid:getCanUseState() then
            return
        end

        -- 是否从列表中删除格子
        local removed = false

        -- 调用回调函数（返回值：是否删除格子）
        if (self._targetForDragEnded and self._functionForDragEnded) then 
            removed = self._functionForDragEnded(self._targetForDragEnded, goodsGrid, touchPosition)
        end
        if (removed) then 
            -- 删除格子
            self:removeGrid(goodsGrid:getData())
        else
            -- 隐藏图标
            goodsGrid:showIcon()
        end

        clearDragGrid(self)
    end
end

-- 点击格子
local function onGoodsGridClickHandler(self, goodsGrid, touchPosition)
    if (not self._tableView:checkTouchPosition(touchPosition)) then return end

    clearDragGrid(self)

    if (goodsGrid:isUsed()) then
        if (self._selectedGoodsGrid) then
            if (not tolua.isnull(self._selectedGoodsGrid)) then 
                self._selectedGoodsGrid:hideSelect()
            else
                self._selectedGoodsGrid = nil
            end
        end

        if(goodsGrid:isClickShowInfo()) then
            self._selectedGoodsGrid = goodsGrid
            goodsGrid:showSelect()
    
            if (self._targetForGridClick and self._functionForGridClick) then
                self._functionForGridClick(self._targetForGridClick, goodsGrid)
            end
        end

        goodsGrid:hideNewIcon()
    elseif (goodsGrid:isLocked()) then
        Avalon.AudioManager:playSound("1503")
        local GameDataManager = require("app.game.GameDataManager")
        if self._goodsData and self._goodsData.packetType ~= PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE and self._choiceType ~= CHOICE_TYPE.TYPE_WAREHOUSE and (not GameDataManager:goodsDataIsNeedUnlockPacket(self._goodsData)) then
            -- 优先判断是否有打开包裹的道具
            --local GameDataManager = require("app.game.GameDataManager")
            local masterData = RoleDataManager:getMaster()
            local unlockItemData = GameDataManager:getUnlockBagItem()
            if unlockItemData and MasterDataManager:getUnlockBagTimesItem() < tonumber(ConfigManager:getGeneralForKey("itemUnlockPacketBoxSpaceTimes")) then 
                local buyGridsTips = UI.Tips:createTips(string.format(UI.TEXT_1213081, unlockItemData:getName(), Config.General:getValueForKey("itemUnlockPacketBoxSpace")),
                    UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
                buyGridsTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                    Net.NetGoodsSystem:requestUnlockBagSpace(PublicDefine.PACKET_TYPE.PACKET_BAG, unlockItemData:getGoodsID())
                end)
            else 
                if(MasterDataManager:getBoxCanBeUseNum() >= tonumber(ConfigManager:getGeneralForKey("packetBoxMaxNum"))) then
                    UI.ScrollBar:createByText(UI.TEXT_1213080)
                    return
                end
                -- 是否花费钻石，否则话费金币
                local byDiamonds = false
                -- 每次解锁的背包格子数
                local count = Config.General:getValueForKey("unlockPacketBoxSpace")
                -- 话费的数量
                local cost = 0
                -- 获取已经购买的次数
                local boughtTimes = self._goodsData.unlockBagTimes + 1
                if (boughtTimes == 1) then
                    cost = Config.General:getValueForKey("firstTimeUnlockPacketBoxCostGold")
                elseif (boughtTimes == 2) then
                    cost = Config.General:getValueForKey("secondTimeUnlockPacketBoxCostGold")
                elseif (boughtTimes == 3) then
                    cost = Config.General:getValueForKey("thirdTimeUnlockPacketBoxCostGold")
                elseif (boughtTimes >= 4) then
                    byDiamonds = true

                    local increaseEachTime = Config.General:getValueForKey("eachUnlockPacketBoxIncreaseCostDiamond") * 
                        (boughtTimes - 4)
                    local maxCost = Config.General:getValueForKey("unlockPacketBoxCostDiamondMax") 
                    cost = Config.General:getValueForKey("unlockPacketBoxCostDiamond") + increaseEachTime
                    if (tonumber(cost) > tonumber(maxCost)) then
                        cost = maxCost
                    end
                else
                    assert(false)
                end
                local buyGridsTips = UI.Tips:createTips(string.format((not byDiamonds) and UI.TEXT_1110397 or UI.TEXT_1110398, cost, count),
                    UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)

                buyGridsTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                    local hasEnoughCost = false
                    local curCoin = self._goodsData.heroData:getCurCoin()
                    local curDiamond = self._goodsData.heroData:getDiamond()
                    if (byDiamonds) then
                        if (Avalon.MathUtil:checkDiamonEnough(tonumber(cost), curDiamond)) then hasEnoughCost = true end
                    else
                        if (tonumber(cost) <= curCoin) then hasEnoughCost = true end
                    end
                    if (hasEnoughCost) then
                        if RoleBehaviorManager:unlockBagSpaceCheck() then 
                            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                            Net.NetGoodsSystem:requestUnlockBagSpace(PublicDefine.PACKET_TYPE.PACKET_BAG)
                        end 
                    else
                        if (byDiamonds) then
                            -- local buyDiamondsTips = UI.Tips:create()
                            -- buyDiamondsTips:init(UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL, UI.TEXT_1110399)
                            -- buyDiamondsTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                            --     -- TODO 打开商店购买钻石
                            -- end)
                            -- UI.UIManager:addComponent(buyDiamondsTips, UI_ZORDER.TIPS)

                            UI.TipsLayer:onDiamondNotEnough()
                        else
                            UI.ScrollBar:createByText(UI.TEXT_1110389)
                        end
                    end
                end)
            end
        elseif (GameDataManager:goodsDataIsNeedUnlockPacket(self._goodsData)) then
            
        else
            -- 这里在强制有设置为仓库的时候才会有单独的处理逻辑，其余情况self._goodsData 默认为当前使用数据
            local beUseNum = self._goodsData.packetBoxBeUseNum
            local boughtTimes = self._goodsData.unlockBagTimes + 1
            if self._choiceType == CHOICE_TYPE.TYPE_WAREHOUSE then
                beUseNum = self._warehouseInfo.packetBoxBeUseNum
                boughtTimes = self._warehouseInfo.unlockBagTimes + 1
            end

            if beUseNum >= tonumber(Config.General:getValueForKey("packetWarehouseMaxNum")) then
                UI.ScrollBar:createByText(UI.TEXT_110032)
                return
            end

            -- 每次解锁的背包格子数
            local count = Config.General:getValueForKey("unlockPacketWarehouseSpace")
            -- 话费的数量
            local cost = 0

            -- 获取已经购买的次数
            if (boughtTimes == 1) then
                cost = Config.General:getValueForKey("unlockPacketWarehouseCostDiamond")
            elseif (boughtTimes >= 2) then


                local increaseEachTime = Config.General:getValueForKey("eachUnlockPacketWarehouseIncreaseCostDiamond") * 
                    (boughtTimes - 1)
                local maxCost = Config.General:getValueForKey("unlockPacketWarehouseCostDiamondMax") 
                cost = Config.General:getValueForKey("unlockPacketWarehouseCostDiamond") + increaseEachTime
                if (tonumber(cost) > tonumber(maxCost)) then
                    cost = maxCost
                end
            else
                assert(false)
            end

            local buyGridsTips = UI.Tips:createTips(string.format(UI.TEXT_110031, cost, count),
                UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)

            buyGridsTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                local curDiamond = RoleDataManager:getMaster():getDiamond()
                if (Avalon.MathUtil:checkDiamonEnough(tonumber(cost), curDiamond)) then
                    if(RoleBehaviorManager:unlockBagSpaceCheck()) then 
                        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                        Net.NetGoodsSystem:requestUnlockBagSpace(PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE)
                    end 
                else
                    UI.TipsLayer:onDiamondNotEnough()
                end
            end)
        end
    end
end

local function onGoodsGridDoubleClickHandler(self, goodsGrid, touchPosition)
    if (not self._tableView:checkTouchPosition(touchPosition)) then return end

    clearDragGrid(self)

    if (goodsGrid:isUsed()) and goodsGrid:getCanUseState() then
        if (self._selectedGoodsGrid) then self._selectedGoodsGrid:hideSelect() end
        self._selectedGoodsGrid = goodsGrid
        goodsGrid:showSelect()

        if self.doubleClickAsDragEnd then
            local removed = false
            if (self._targetForDragEnded and self._functionForDragEnded) then 
                removed = self._functionForDragEnded(self._targetForDragEnded, goodsGrid, cc.p(-10000, -10000))
            end
            if (removed) then 
                -- 删除格子
                self:removeGrid(goodsGrid:getData())
            else
                -- 隐藏图标
                goodsGrid:showIcon()
            end

        else
            if (self._targetForGridDoubleClick and self._functionForGridDoubleClick) then
                self._functionForGridDoubleClick(self._targetForGridDoubleClick, goodsGrid)
            end
        end
    end
end


-- 背包滚动视图滚动开始的处理器
local function onGoodsScrollViewScrollBeganHandler(self, scrollView)

end

-- 背包滚动视图滚动的处理器
local function onGoodsScrollViewScrollingHandler(self, scrollView, percent)
    self._slider:setPercent(percent)

    if (self._targetForScrolling and self._functionForScrolling) then
        self._functionForScrolling(self._targetForScrolling, percent)
    end
end

-- 背包滚动视图滚动结束的处理器
local function onGoodsScrollViewScrollEndedHandler(self, scrollView)
    self._slider:hide()
end

-- 解锁背包格子
local function onUnlockBagGridHandler(self)
	-- change by zp 这里开启会导致在删除物品的时候，在解锁背包格子，选中的物品表现出错  CO-3227
    -- local GameDataManager = require("app.game.GameDataManager")
    -- self._goodsData = GameDataManager:getInstance():getPacketDataByPacketType(self._goodsData.packetType)

    -- self:updateGridCount(function()
    --     print("GoodsListNew  updateGridCount")
    --     if(self and not tolua.isnull(self)) then
    --         Avalon.Scheduler:scheduleUpdateOnce(self, function()
    --             -- 刷新表现
    --             if(self and not tolua.isnull(self)) then
    --                 self:updateView()
    --             end
    --         end, 0.1)
    --     end
    -- end)
end

local function onUnlockResponse(self)
    UI.WaitingLayer:hideWaiting()
end

-- 构造函数
function GoodsListNew:ctor(columnCount, isWareHouse, isHideUseBtn, fliterType)
    reload_script_file("app.ui.common.GoodsList.GoodsListCell")
    self.doubleClickAsDragEnd = false
    -- 滚动视图组件
    self._scrollView = nil
    -- 物品列表组件
    self._goodsGridList = nil
    -- 滑块组件
    self._slider = nil
    -- 角色的物品数据
    self._goodsData = nil
    self.isWareHouse = isWareHouse

    self._viewHeight = nil

    self._choiceType = CHOICE_TYPE.TYPE_ALL

    -- 当前被选中的格子
    self._selectedGoodsGrid = nil
    -- 被拖拽的格子
    self._draggedGoodsGrid = nil
    -- 格子开始被拖拽时候的格子局部坐标
    self._girdLocalPosition = nil
    -- 事件回调函数
    self._targetForDragBegan = nil
    self._targetForDragMoved = nil
    self._functionForDragMoved = nil
    self._targetForDragEnded = nil
    self._functionForDragEnded = nil
    self._targetForGridClick = nil
    self._functionForGridClick = nil
    self._targetForScrolling = nil
    self._functionForScrolling = nil
    self._targetForGridDoubleClick = nil
    self._functionForGridDoubleClick = nil

    self._columnCount = columnCount or 5

    self._enableToDoubleClick = true

    --能否拖拽
    self._canDrag = true

    self._nowShowGoodsData = {}

    self._isHideUseBtn = isHideUseBtn
    self._fliterType = fliterType or FLITER_TYPE.EQUIPMENT_ALL

    GoodsListNew.super.ctor(self, UIType.GOODS_LIST, RES_LIST, 70 * self._columnCount, COM_HEIGHT)

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_BAG, self, onUnlockBagGridHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_WAREHOUSE, self, onUnlockBagGridHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_RESPONSE, self, onUnlockResponse)
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

-- 析构函数
function GoodsListNew:dtor()
    GoodsListNew.super.dtor(self)
    self._choiceType = CHOICE_TYPE.TYPE_ALL
    if(self._draggedGoodsGrid) then
        self._draggedGoodsGrid:setVisible(false)
        self._draggedGoodsGrid = nil
    end

    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_BAG, self, onUnlockBagGridHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_WAREHOUSE, self, onUnlockBagGridHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_RESPONSE, self, onUnlockResponse)
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

-- public:
-- 初始化
function GoodsListNew:init(goodsData, viewHeight, addPadingSpace, horizontalSpace, verticalSpace)
    self._goodsData = goodsData
    self._viewHeight = viewHeight
    self._addPadingSpace = addPadingSpace
    self.horizontalSpace = horizontalSpace
    self.verticalSpace = verticalSpace
    GoodsListNew.super.init(self)
end

-- 初始化视图
function GoodsListNew:onInitView(GridComponent, gridWidth, gridHeight, horizontalSpace, verticalSpace, paddingSpace)
    local bgImageCover = UI.Image:create()
    bgImageCover:init(SPRITES.COM_BG)
    bgImageCover:centerLeft(0)
    self:addChild(bgImageCover)
    self._bgImageCover = bgImageCover
    local horizontalSpace = self.horizontalSpace or 5
    local verticalSpace = self.verticalSpace or 5
    local horizonOffset = self.horizontalSpace or 0
    local verticalOffset  = self.verticalSpace or 0
    
    local addPadingSpace = self._addPadingSpace or 12
    self._viewHeight = self._viewHeight or 355
    self._tableView = UI.TableView.new(RES_LIST, (74+horizonOffset) * self._columnCount+ 25, self._viewHeight)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:init()
    self._tableView:leftUp(18, 56)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:setScrollBarEnabled(true)
    -- self._tableView:enableDebugDraw()
    self._tableView:onUpdateCellSize(function (table,idx)
        -- print("GoodsList  onUpdateCellSize", idx)
        return (68 + addPadingSpace) * self._columnCount, 68 + addPadingSpace/2+verticalOffset;
    end)

    self._tableView:onUpdateCells(function (tableView, idx)
        local cell = tableView:dequeueCell();
        local nowData = {}
        if self._nowShowGoodsData then 
            for i=1, self._columnCount, 1 do 
                if(self._nowShowGoodsData[idx * self._columnCount + i]) then 
                    table.insert(nowData, self._nowShowGoodsData[idx * self._columnCount + i])
                end
            end
        end

        local maxCount = 0
        if(self._goodsData) then 
            maxCount = self._goodsData.packetBoxBeUseNum

            if self._choiceType == CHOICE_TYPE.TYPE_WAREHOUSE then
                maxCount = self._warehouseInfo.packetBoxBeUseNum
            end
        end
        if(self._nowShowGoodsData == nil) then
            self._nowShowGoodsData = {}
        end
        -- cell = nil
        -- print("GoodsList  onUpdateCells  www=====", idx, #nowData, #self._nowShowGoodsData)
        if(cell == nil) then
            xpcall(function()
                cell = UI.TableViewCell:create()
                cell:init()
                
                local listCell = UI.GoodsListCell:create(UI.GoodsGrid, self._columnCount, nowData, 68, 68, idx * self._columnCount + 1, maxCount, horizontalSpace, verticalSpace, addPadingSpace, self._isHideUseBtn);
                listCell:init(self.deleteChoiceArr)
                listCell:setName("cell")
                listCell:leftBottom(0, 0)
                cell:addChild(listCell)
                listCell:updataGridCanUseState(self._checkItemUseState, self._useLock, self._deleteState, self._usedType)
                if(self._enableToDoubleClick) then 
                    listCell:enableToDoubleClick()
                else 
                    listCell:disableToDoubleClick()
                end
                if(self._showChoiceStatus) then 
                    listCell:showChoiceStatus()
                else 
                    listCell:hideChoiceStatus()
                end
                listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_BEGAN, self, onGoodsGridDragBeganHandler)
                listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_MOVED, self, onGoodsGridDragMovedHandler)
                listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_ENDED, self, onGoodsGridDragEndedandler)
                listCell:addEventListener(UIEvent.LIST_VIEW_GRID_CLICK, self, onGoodsGridClickHandler)
                listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DOUBLE_CLICK, self, onGoodsGridDoubleClickHandler)
            end,
            function(e) 
                printError("------------------------GoodsListNew:tableCellAtIndex-----------------error")
            end, 1);
        else 
            local listCell = cell:getChildByName("cell")
            if(listCell) then 
                listCell:setDeleteChoiceArr(self.deleteChoiceArr)
                listCell:updataGridCanUseState(self._checkItemUseState, self._useLock, self._deleteState, self._usedType)
                if(self._enableToDoubleClick) then 
                    listCell:enableToDoubleClick()
                else 
                    listCell:disableToDoubleClick()
                end
                if(self._showChoiceStatus) then 
                    listCell:showChoiceStatus()
                else 
                    listCell:hideChoiceStatus()
                end
                listCell:reloadData(nowData, idx * self._columnCount + 1, maxCount) 
            end
        end

        return cell;
    end);

    self._tableView:onUpdateCellNumbers(function ()
        local maxCount = 0
        local packetMaxCount = 0
        if(self._goodsData) then 
            maxCount = self._goodsData.packetBoxBeUseNum
            packetMaxCount = self._goodsData.packetBoxMaxNum
        end
        if self._choiceType == CHOICE_TYPE.TYPE_WAREHOUSE then
            maxCount = self._warehouseInfo.packetBoxBeUseNum
            packetMaxCount = self._warehouseInfo.packetBoxMaxNum
        end

        if(packetMaxCount <= maxCount) then 
            return maxCount/self._columnCount
        end

        return maxCount/self._columnCount + 2
    end)

    self._tableView:onTableCellTouched(function(tableView, cell)
        -- print("GoodsList  onTableCellTouched")
    end)

    self:addChild(self._tableView)
    self._waitingReloadData = waitingRefresNum
    -- self._tableView:reloadData()

    -- 格子蒙层
    local bgUpImage = UI.Image:create()
    bgUpImage:init("ui_goods_banner_large_up.png")
    bgUpImage:leftBottom(20,140 - 10 - 80)
    bgUpImage:hide()
    self:addChild(bgUpImage)
    self._bgUpImage = bgUpImage
    if(self._bgUpImageShow) then 
        bgUpImage:show()
    end

    -- 滑块
    local sliderImage = UI.Image:create()
    sliderImage:init(SPRITES.COM_SLIDER)
    sliderImage:fill()
    local slider = UI.Slider:create()
    slider:init(sliderImage)
    slider:leftBottom(74 * self._columnCount + 5+ 24, 42+7)
    slider:setSize(6, self._viewHeight)
    slider:hide()
    self:addChild(slider)
    self._slider = slider
end

-- 更新格子数量
function GoodsListNew:updateGridCount(callback)

end

-- 更新视图
function GoodsListNew:onUpdateView()
    if (self._goodsData) then
        -- print("onUpdateView     eeeeeeeeeeeeeee", self._choiceType, CHOICE_TYPE.TYPE_WEAR)
        self._nowShowGoodsData = self._goodsData.haveEquipmentArr or {}

        if(self._choiceType == CHOICE_TYPE.TYPE_WEAR) then
            self:showEquip()
        elseif (self._choiceType == CHOICE_TYPE.TYPE_ALL) then
            self:showAllGoods()
        elseif (self._choiceType == CHOICE_TYPE.TYPE_EQUIPMENTS) then
            self:showEquipments()
        elseif (self._choiceType == CHOICE_TYPE.TYPE_ITEMS) then
            self:showItems()
        elseif (self._choiceType == CHOICE_TYPE.TYPE_MATERIAL) then
            self:showMaterials()
        elseif (self._choiceType == CHOICE_TYPE.TYPE_GEM_STONE) then
            self:showGemStone()
        elseif (self._choiceType == CHOICE_TYPE.TYPE_RELIC) then
            self:showRelics()
        elseif (self._choiceType == CHOICE_TYPE.TYPE_PET_STIONE) then
            self:showPetStone()
        elseif (self._choiceType == CHOICE_TYPE.TYPE_GLYPH) then
            self:showGlyph()
        elseif (self._choiceType == CHOICE_TYPE.TYPE_GLYPH_WEAR) then
            self:showGlyphWear()
        elseif (self._choiceType == CHOICE_TYPE.TYPE_GLYPH_EQUIP) then
            self:showGlyphEquip()
        elseif (self._choiceType == CHOICE_TYPE.TYPE_GLYPH_ALL) then
            self:showGlyphAll()
        end

        self._waitingReloadData = waitingRefresNum
        -- self._tableView:reloadData()

        -- 更新物品列表的滑块
        local availableCount, maxCount = self._goodsData.packetBoxBeUseNum, self._goodsData.packetBoxMaxNum

        if self._choiceType == CHOICE_TYPE.TYPE_WAREHOUSE then
            maxCount = self._warehouseInfo.packetBoxBeUseNum
            availableCount = self._warehouseInfo.packetBoxMaxNum
        end
        local percent = 0
        if (maxCount ~= 0) then percent = availableCount / maxCount
        end
        local sliderWidth, sliderHeight = self._slider:getSize()
        sliderHeight = sliderHeight * percent
        self._slider:setSliderComSize(sliderWidth, sliderHeight)
    end
end

-- 锁定状态改变
function GoodsListNew:lockStatusChange(data)
    if(self._goodsData) then
        local gridList = self:getGridList()
        if(gridList) then
            for _,gridView in pairs(gridList) do
                local goodsData = gridView:getData()
                if(goodsData) then
                    if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                        or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                        if(goodsData:getEntityID() == data.entityID) then
                            gridView:updateView()
                            break
                        end
                    else
                        -- 判断是否是相同的包裹,然后在判断是否为同一个物品
                        local handle = true
                        if(self._packetType == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE or data.packetType == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE) then
                            if(self._packetType ~= data.packetType) then
                                handle = false
                            end
                        end

                        if(handle) then
                            if(data.templateID == goodsData:getGoodsID()) then
                                gridView:updateView()
                            end
                        end
                    end
                end
            end
        end
    end
end

-- 设置背包数据
function GoodsListNew:setData(goodsData, unlockBagFlag)
    self:cancelSelectGoodsGrid()
    clearDragGrid(self)
    local unlockIndex = 0
    if(self._goodsData) then 
        unlockIndex = self._goodsData.packetBoxBeUseNum + 1
    end
    self._goodsData = goodsData

    if(unlockBagFlag) then 
        self._unlockIndex = unlockIndex
        -- print("MC_UI_REFRESH_UNLOCK_CELL", unlockIndex)
        -- print(debug.traceback())
        if(unlockBagFlag ~= UNLOCK_BAG_FLAG.UNLOCK_BAG_FLAG_WAREHOUSE or self.isWareHouse) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_UNLOCK_CELL, unlockIndex)
        end
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            self._unlockIndex = -1
            if(not tolua.isnull(self._tableView)) then 
                self._waitingReloadData = waitingRefresNum
                -- self._tableView:reloadData()
            end
        end, 1.5)
    else 
        self._waitingReloadData = waitingRefresNum
        -- self._tableView:reloadData()
    end
end

function GoodsListNew:setRefreshFlag(flag)

end

function GoodsListNew:showChoiceStatus()
    self._showChoiceStatus = true
    self._waitingReloadData = waitingRefresNum
    -- self._tableView:reloadData()
end

function GoodsListNew:hideChoiceStatus()
    self._showChoiceStatus = false
    self._waitingReloadData = waitingRefresNum
    -- self._tableView:reloadData()
end

-- 显示所有物品
function GoodsListNew:showAllGoods()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_ALL
    if (self._goodsData) then
        local allGoodsList = {}
        local index = 1

        if (self._fliterType == FLITER_TYPE.ITEM_IDENTIFY_TREASURE) then
            -- 有过滤时的处理
            if(self._goodsData.haveTreasureArr) then
                for i = 1, #self._goodsData.haveTreasureArr do
                    if self._goodsData.haveTreasureArr[i]._changeNum == nil or self._goodsData.haveTreasureArr[i]._changeNum >= 0 then
                        table.insert(allGoodsList, index, self._goodsData.haveTreasureArr[i])
                        index = index + 1
                    end
                end
            end

        else
            if(self._goodsData.haveTreasureArr) then
                for i = 1, #self._goodsData.haveTreasureArr do
                    if self._goodsData.haveTreasureArr[i]._changeNum == nil or self._goodsData.haveTreasureArr[i]._changeNum >= 0 then
                        table.insert(allGoodsList, index, self._goodsData.haveTreasureArr[i])
                        index = index + 1
                    end
                end
            end

            if(self._goodsData.haveEquipmentArr) then
                for i = 1, #self._goodsData.haveEquipmentArr do
                    if self._goodsData.haveEquipmentArr[i]._changeNum == nil or self._goodsData.haveEquipmentArr[i]._changeNum >= 0 then
                        table.insert(allGoodsList, index, self._goodsData.haveEquipmentArr[i])
                        index = index + 1
                    end
                end
            end

            if(self._goodsData.haveItemArr) then
                for i = 1, #self._goodsData.haveItemArr do
                    if self._goodsData.haveItemArr[i]._changeNum == nil or self._goodsData.haveItemArr[i]._changeNum >= 0 then
                        table.insert(allGoodsList, index, self._goodsData.haveItemArr[i])
                        index = index + 1
                    else
                        if self._goodsData.haveItemArr[i]:getNum() + self._goodsData.haveItemArr[i]._changeNum  > 0 then
                            table.insert(allGoodsList, index, self._goodsData.haveItemArr[i])
                            index = index + 1
                        end
                    end
                end
            end

            if(self._goodsData.havePetEquipmentArr) then
                for i = 1, #self._goodsData.havePetEquipmentArr do
                    if self._goodsData.havePetEquipmentArr[i]._changeNum == nil or self._goodsData.havePetEquipmentArr[i]._changeNum >= 0 then
                        table.insert(allGoodsList, index, self._goodsData.havePetEquipmentArr[i])
                        index = index + 1
                    end
                end
            end

            if(self._goodsData.haveMaterialArr) then
                for i = 1, #self._goodsData.haveMaterialArr do
                    if self._goodsData.haveMaterialArr[i]._changeNum == nil or self._goodsData.haveMaterialArr[i]._changeNum == 0 then
                        table.insert(allGoodsList, index, self._goodsData.haveMaterialArr[i])
                        index = index + 1
                    else
                        if self._goodsData.haveMaterialArr[i]:getNum() + self._goodsData.haveMaterialArr[i]._changeNum > 0 then
                            table.insert(allGoodsList, index, self._goodsData.haveMaterialArr[i])
                            index = index + 1
                        end
                    end
                end
            end
            if(self._goodsData.haveGemStoneArr) then
                for i = 1, #self._goodsData.haveGemStoneArr do
                    if self._goodsData.haveGemStoneArr[i]._changeNum == nil or self._goodsData.haveGemStoneArr[i]._changeNum == 0 then
                        table.insert(allGoodsList, index, self._goodsData.haveGemStoneArr[i])
                        index = index + 1
                    else
                        if self._goodsData.haveGemStoneArr[i]:getNum() + self._goodsData.haveGemStoneArr[i]._changeNum > 0 then
                            table.insert(allGoodsList, index, self._goodsData.haveGemStoneArr[i])
                            index = index + 1
                        end
                    end
                end
            end
            if self._goodsData.haveRelicArr and #self._goodsData.haveRelicArr >= 1 then
                for i = 1, #self._goodsData.haveRelicArr do
                    if self._goodsData.haveRelicArr[i]._changeNum == nil or self._goodsData.haveRelicArr[i]._changeNum >= 0 then
                        table.insert(allGoodsList, index, self._goodsData.haveRelicArr[i])
                        index = index + 1
                    end
                end
            end
        end

        self._nowShowGoodsData = allGoodsList
        self._waitingReloadData = waitingRefresNum
        -- self._tableView:reloadData()
    end
end

-- 显示穿戴装备
function GoodsListNew:showEquip()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_WEAR
    if (self._goodsData) then
        local equips = {}

        if(self._fliterType == FLITER_TYPE.EQUIPMENT_ALL 
            or self._fliterType == FLITER_TYPE.EQUIPMENT_ONLY_SHOW_HERO) then
            if(self._goodsData.wearEquipmentArr) then
                for i = 1, #self._goodsData.wearEquipmentArr do
                    if self._goodsData.wearEquipmentArr[i]._changeNum == nil or self._goodsData.wearEquipmentArr[i]._changeNum >= 0 then
                        table.insert(equips, self._goodsData.wearEquipmentArr[i])
                    end
                end
            end
        end

        if(self._fliterType == FLITER_TYPE.EQUIPMENT_ALL 
            or self._fliterType == FLITER_TYPE.EQUIPMENT_ONLY_SHOW_PET) then
            if(self._goodsData.wearPetEquipmentArr) then
                for i = 1, #self._goodsData.wearPetEquipmentArr do
                    if self._goodsData.wearPetEquipmentArr[i]._changeNum == nil or self._goodsData.wearPetEquipmentArr[i]._changeNum >= 0 then
                        table.insert(equips, self._goodsData.wearPetEquipmentArr[i])
                    end
                end
            end
        end

        if(self._fliterType == FLITER_TYPE.EQUIPMENT_FLITER_FISH ) then
            if(self._goodsData.wearEquipmentArr) then
                for i = 1, #self._goodsData.wearEquipmentArr do
                    if self._goodsData.wearEquipmentArr[i]._changeNum == nil or self._goodsData.wearEquipmentArr[i]._changeNum >= 0 and
                    self._goodsData.wearEquipmentArr[i].equipmentType ~= PublicDefine.EQUIPMENT_TYPE.Fish then
                        table.insert(equips, self._goodsData.wearEquipmentArr[i])
                    end
                end
            end
        end

        if (equips) then
            self._nowShowGoodsData = equips
            self._waitingReloadData = waitingRefresNum
            -- self._tableView:reloadData()
        end
    end
end

-- 显示所有装备
function GoodsListNew:showEquipments()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_EQUIPMENTS
    if (self._goodsData) then

        local equipments = {}
        if(self._fliterType == FLITER_TYPE.EQUIPMENT_ALL 
            or self._fliterType == FLITER_TYPE.EQUIPMENT_ONLY_SHOW_HERO) then
            if(self._goodsData.haveEquipmentArr) then
                for i = 1, #self._goodsData.haveEquipmentArr do
                    if self._goodsData.haveEquipmentArr[i]._changeNum == nil or self._goodsData.haveEquipmentArr[i]._changeNum >= 0 then
                        table.insert(equipments, self._goodsData.haveEquipmentArr[i])
                    end
                end
            end
        end

        if(self._fliterType == FLITER_TYPE.EQUIPMENT_ALL 
            or self._fliterType == FLITER_TYPE.EQUIPMENT_ONLY_SHOW_PET) then
            if(self._goodsData.havePetEquipmentArr) then
                for i = 1, #self._goodsData.havePetEquipmentArr do
                    if self._goodsData.havePetEquipmentArr[i]._changeNum == nil or self._goodsData.havePetEquipmentArr[i]._changeNum >= 0 then
                        table.insert(equipments, self._goodsData.havePetEquipmentArr[i])
                    end
                end
            end
        end

        if(self._fliterType == FLITER_TYPE.EQUIPMENT_FLITER_FISH) then
            if(self._goodsData.haveEquipmentArr) then
                for i = 1, #self._goodsData.haveEquipmentArr do
                    if self._goodsData.haveEquipmentArr[i]._changeNum == nil or self._goodsData.haveEquipmentArr[i]._changeNum >= 0 and
                     self._goodsData.haveEquipmentArr[i].equipmentType ~= PublicDefine.EQUIPMENT_TYPE.Fish then

                        table.insert(equipments, self._goodsData.haveEquipmentArr[i])
                    end
                end
            end
        end

        if (equipments) then
            self._nowShowGoodsData = equipments
            self._waitingReloadData = waitingRefresNum
            -- self._tableView:reloadData()
        end
    end
end

-- 显示所有道具
function GoodsListNew:showItems()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_ITEMS
    if (self._goodsData) then
        local items = {}
        for i = 1, #self._goodsData.haveItemArr do
            if self._goodsData.haveItemArr[i]:getNum() + self._goodsData.haveItemArr[i]._changeNum > 0 then
                table.insert(items, self._goodsData.haveItemArr[i])
            end
        end

        if (items) then
            self._nowShowGoodsData = items
            self._waitingReloadData = waitingRefresNum
            -- self._tableView:reloadData()
        end
    end
end

-- 显示所有材料
function GoodsListNew:showMaterials()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_MATERIAL
    if (self._goodsData) then
        local materials = {}
        for i = 1, #self._goodsData.haveMaterialArr do
            if self._goodsData.haveMaterialArr[i]:getNum() + self._goodsData.haveMaterialArr[i]._changeNum > 0 then
                table.insert(materials, self._goodsData.haveMaterialArr[i])
            end
        end

        if (materials) then
            self._nowShowGoodsData = materials
            self._waitingReloadData = waitingRefresNum
            -- self._tableView:reloadData()
        end
    end
end

-- 显示所有遗物
function GoodsListNew:showRelics()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_RELIC
    if (self._goodsData) then
        local relics = {}
        for i = 1, #self._goodsData.haveRelicArr do
            if self._goodsData.haveRelicArr[i]._changeNum == nil or self._goodsData.haveRelicArr[i]._changeNum >= 0 then
                table.insert(relics, self._goodsData.haveRelicArr[i])
            end
        end

        if (relics) then
            self._nowShowGoodsData = relics
            self._waitingReloadData = waitingRefresNum
            -- self._tableView:reloadData()
        end
    end
end

--显示所有宠物宝石
function GoodsListNew:showPetStone()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_PET_STIONE
    local master = RoleDataManager:getMaster()
    if (not master) then return nil end
    local stoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_PET_GEMSTONE,PublicDefine.GOODS_TYPE.GOODS_PET_STONE)
    if stoneArr then
        local relics = {}
        for i = 1, #stoneArr do
            if stoneArr[i]._changeNum == nil or stoneArr[i]._changeNum >= 0 then
                table.insert(relics, stoneArr[i])
            end
        end

        if (relics) then
            self._nowShowGoodsData = relics
            self._waitingReloadData = waitingRefresNum
        end
    end

    self._goodsData.packetBoxBeUseNum = PublicDefine.CONST_DEFINITION.MAX_PET_GEMSTONE_PACKET_NUM
end

function GoodsListNew:getPetEquipmentStoneBySiteId(siteId)
    local relics = {}

    local wearEquipmentArr = self:getPetEquipmentBySiteId(siteId) or {}

    for k,v in pairs(wearEquipmentArr) do
        for m,n in ipairs(v.slots) do
            n.entityID = 0
            local gemData = mvc.petGemStoneDevelopmentModel:createPetStoneData(n,v:getEntityID(),m)
            if gemData then
                gemData:setIsNew(false)
                table.insert(relics, gemData)
            end
        end
    end

    return relics
end

function GoodsListNew:getPetEquipmentBySiteId(siteId)
    local relics = {}

    local pData = MasterDataManager:getFightPetBySiteId(siteId)
    if pData then
        local petData = MasterDataManager:getBagPetById(pData:getPetInstId())
        if petData then
            local wearEquipmentArr = petData:getWearEquipmentArr() or {}

            for k,v in pairs(wearEquipmentArr) do
                if v._changeNum == nil or v._changeNum >= 0 then
                    table.insert(relics, v)
                end
            end
        end
    end

    return relics
end

function GoodsListNew:showPetSlotStoneOne()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_PET_STIONE
    local relics = self:getPetEquipmentStoneBySiteId(0)

    if (relics) then
        self._nowShowGoodsData = relics
        self._waitingReloadData = waitingRefresNum
    end
end

function GoodsListNew:showPetSlotStoneTwo()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_PET_STIONE
    local relics = self:getPetEquipmentStoneBySiteId(1)

    if (relics) then
        self._nowShowGoodsData = relics
        self._waitingReloadData = waitingRefresNum
    end
end

function GoodsListNew:showPetSlotStoneThree()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_PET_STIONE
    local relics = self:getPetEquipmentStoneBySiteId(2)

    if (relics) then
        self._nowShowGoodsData = relics
        self._waitingReloadData = waitingRefresNum
    end
end

function GoodsListNew:showPetEquipmentOne()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_WEAR
    local relics = self:getPetEquipmentBySiteId(0)

    if (relics) then
        self._nowShowGoodsData = relics
        self._waitingReloadData = waitingRefresNum
    end
end

function GoodsListNew:showPetEquipmentTwo()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_WEAR
    local relics = self:getPetEquipmentBySiteId(1)

    if (relics) then
        self._nowShowGoodsData = relics
        self._waitingReloadData = waitingRefresNum
    end
end

function GoodsListNew:showPetEquipmentThree()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_WEAR
    local relics = self:getPetEquipmentBySiteId(2)

    if (relics) then
        self._nowShowGoodsData = relics
        self._waitingReloadData = waitingRefresNum
    end
end


function GoodsListNew:showWareHouse()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_WAREHOUSE
    local master = RoleDataManager:getMaster()
    local bagArr = GoodsDataManager:getPackArrForPK(master:getPK(), PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE)
    self._warehouseInfo = {}
    local master = RoleDataManager:getMaster()
    self._warehouseInfo.packetBoxBeUseNum =  master:getWearhouseCanBeUseNum()
    self._warehouseInfo.unlockBagTimes = master:getUnlockWarehouseTimes()
    local GameDataManager = require("app.game.GameDataManager")
    self._warehouseInfo.packetBoxMaxNum = GameDataManager:getInstance():getPacketWarehouseMaxNum()
    
    local allGoodsList = {}
    if bagArr then
        for _, typeArr in pairs(bagArr) do
            for j = 1, #typeArr do
                if typeArr[j]:getNum() + typeArr[j]._changeNum > 0 then
                    if self._fliterType == FLITER_TYPE.EQUIPMENT_FLITER_FISH then
                        if not typeArr[j].equipmentType or typeArr[j].equipmentType ~= PublicDefine.EQUIPMENT_TYPE.Fish then
                            table.insert(allGoodsList, typeArr[j])
                        end
                    elseif self._fliterType == FLITER_TYPE.ITEM_IDENTIFY_TREASURE then
                        print(" typeArr[j] ==== ",typeArr[j])
                    else
                        table.insert(allGoodsList, typeArr[j])
                    end
                end
            end
        end
    end

    if (allGoodsList) then
        self._nowShowGoodsData = allGoodsList
        self._waitingReloadData = waitingRefresNum
        -- self._tableView:reloadData()
    end
end


function GoodsListNew:showGemStoneWear()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_GEM_STONE_WEAR
    local genStones = {}
    if self.haveGemStoneWearEquipArr then
        for i = 1, #self.haveGemStoneWearEquipArr do
            if self.haveGemStoneWearEquipArr[i]:getNum() + self.haveGemStoneWearEquipArr[i]._changeNum > 0 then
                table.insert(genStones, self.haveGemStoneWearEquipArr[i])
            end
        end
    end

    if (genStones) then
        self._nowShowGoodsData = genStones
        self._waitingReloadData = waitingRefresNum
        -- self._tableView:reloadData()
    end
end

function GoodsListNew:showGemStone()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_GEM_STONE
    if (self._goodsData) then
        local genStones = {}
        for i = 1, #self._goodsData.haveGemStoneArr do
            if self._goodsData.haveGemStoneArr[i]:getNum() + self._goodsData.haveGemStoneArr[i]._changeNum > 0 then
                table.insert(genStones, self._goodsData.haveGemStoneArr[i])
            end
        end

        if self.haveGemStoneEquipArr then
            for i = 1, #self.haveGemStoneEquipArr do
                if self.haveGemStoneEquipArr[i]:getNum() + self.haveGemStoneEquipArr[i]._changeNum > 0 then
                    table.insert(genStones, self.haveGemStoneEquipArr[i])
                end
            end
        end

        if (genStones) then
            self._nowShowGoodsData = genStones
            self._waitingReloadData = waitingRefresNum
            -- self._tableView:reloadData()
        end
    end
end
require "app.datas.goods.GlyphData"
function GoodsListNew:showGlyph()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_GLYPH
    if (self._goodsData) then
        local glyphs = {}
        for i = 1, #self._goodsData.haveGlyphArr do
            if self._goodsData.haveGlyphArr[i]:getNum() + self._goodsData.haveGlyphArr[i]._changeNum > 0 then
                table.insert(glyphs, self._goodsData.haveGlyphArr[i])
            end
        end

        if (glyphs) then
            self._nowShowGoodsData = glyphs
            self._waitingReloadData = waitingRefresNum
            -- self._tableView:reloadData()
        end
    end
end

function GoodsListNew:showGlyphWear()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_GLYPH_WEAR
    local genStones = {}
    if self.haveGlyphWearEquipArr then
        for i = 1, #self.haveGlyphWearEquipArr do
            if self.haveGlyphWearEquipArr[i]:getNum() + self.haveGlyphWearEquipArr[i]._changeNum > 0 then
                table.insert(genStones, self.haveGlyphWearEquipArr[i])
            end
        end
    end

    if (genStones) then
        self._nowShowGoodsData = genStones
        self._waitingReloadData = waitingRefresNum
        -- self._tableView:reloadData()
    end
end

function GoodsListNew:showGlyphEquip()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_GLYPH_EQUIP
    local genStones = {}
    if self.haveGlyphEquipArr then
        for i = 1, #self.haveGlyphEquipArr do
            if self.haveGlyphEquipArr[i]:getNum() + self.haveGlyphEquipArr[i]._changeNum > 0 then
                table.insert(genStones, self.haveGlyphEquipArr[i])
            end
        end
    end

    if (genStones) then
        self._nowShowGoodsData = genStones
        self._waitingReloadData = waitingRefresNum
        -- self._tableView:reloadData()
    end
end

function GoodsListNew:showGlyphAll()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_GLYPH_ALL
    local genStones = {}

    if self.haveGlyphWearEquipArr then
        for i = 1, #self.haveGlyphWearEquipArr do
            if self.haveGlyphWearEquipArr[i]:getNum() + self.haveGlyphWearEquipArr[i]._changeNum > 0 then
                table.insert(genStones, self.haveGlyphWearEquipArr[i])
            end
        end
    end

    if self.haveGlyphEquipArr then
        for i = 1, #self.haveGlyphEquipArr do
            if self.haveGlyphEquipArr[i]:getNum() + self.haveGlyphEquipArr[i]._changeNum > 0 then
                table.insert(genStones, self.haveGlyphEquipArr[i])
            end
        end
    end

    for i = 1, #self._goodsData.haveGlyphArr do
        if self._goodsData.haveGlyphArr[i]:getNum() + self._goodsData.haveGlyphArr[i]._changeNum > 0 then
            table.insert(genStones, self._goodsData.haveGlyphArr[i])
        end
    end

    if (genStones) then
        self._nowShowGoodsData = genStones
        self._waitingReloadData = waitingRefresNum
        -- self._tableView:reloadData()
    end
end

function GoodsListNew:getShowDataArr()
    return self._nowShowGoodsData
end

function GoodsListNew:showMask()
    self._bgUpImageShow = true
    if(self._bgUpImage) then 
        self._bgUpImage:show()
    end
end

function GoodsListNew:showDestory()

end

function GoodsListNew:hideDestory()
    self:cancelSelectGoodsGrid()
end

-- 显示移动的表现效果
function GoodsListNew:showMove()

end

-- 隐藏移动效果
function GoodsListNew:hideMove()

end

-- 修改是否处于放置中间
function GoodsListNew:changeInSideStatus(inSide)
    if(not tolua.isnull(self._dragAnimation)) then
        self._dragAnimation:changeInSideStatus(inSide)
    end
end

function GoodsListNew:cancelSelectGoodsGrid()
    if(self._selectedGoodsGrid and not tolua.isnull(self._selectedGoodsGrid)) then
        self._selectedGoodsGrid:hideSelect()
        self._selectedGoodsGrid = nil
    end
end

-- 获取所有对象列表
function GoodsListNew:getGridList()
    return {}
end

-- 添加拖拽格子开始的处理回调函数
function GoodsListNew:setCallbackForGridDragBegan(target, func)
    self._targetForDragBegan = target
    self._functionForDragBegan = func
end

-- 添加拖拽格子的处理回调函数
function GoodsListNew:setCallbackForGridDragMoved(target, func)
    self._targetForDragMoved = target
    self._functionForDragMoved = func
end

-- 添加拖拽格子完成的处理回调函数
function GoodsListNew:setCallbackForGridDragEnded(target, func)
    self._targetForDragEnded = target
    self._functionForDragEnded = func
end

-- 添加点击个字的处理回调函数
function GoodsListNew:setCallbackForGridClick(target, func)
    self._targetForGridClick = target
    self._functionForGridClick = func
end

-- 添加滚动进度的处理回调函数
function GoodsListNew:setCallbackForScrolling(target, func)
    self._targetForScrolling = target
    self._functionForScrolling = func
end

-- 添加双击格子的处理回调函数
function GoodsListNew:setCallbackForGridDoubleClick(target, func)
    self._targetForGridDoubleClick = target
    self._functionForGridDoubleClick = func
    if CONFIG_DOUBLIE_CLICK then
        self:enableDoubleClick()
    end
end

function GoodsListNew:setDoubleClickAsDragEnd(enable)
    self.doubleClickAsDragEnd = enable
    if CONFIG_DOUBLIE_CLICK then
        if enable then
            self:enableDoubleClick()
        else
            self:disableDoubleClick()
        end
    end
end


--更新是否能拖拽
function GoodsListNew:updateCanDrag(var)
    self._canDrag = var
end

function GoodsListNew:enableDoubleClick()
    self._enableToDoubleClick = true
    self._waitingReloadData = waitingRefresNum
    -- self._tableView:reloadData()
end 

function GoodsListNew:disableDoubleClick()
    self._enableToDoubleClick = false
    self._waitingReloadData = waitingRefresNum
    -- self._tableView:reloadData()
end

-- 滚到到顶部
function GoodsListNew:scrollToTop(timeInSec, attenuated)
    if(self._tableView) then 
        self._tableView:scrollToTop()
    end
end

-- 滚动到底部
function GoodsListNew:scrollToBottom(timeInSec, attenuated)
    if(self._tableView) then 
        self._tableView:scrollToBottom()
    end
end

function GoodsListNew:setColumnCount(columnCount)
    self._columnCount = columnCount
end

function GoodsListNew:hideBGImageCover()
    self._bgImageCover:hide()
end

--获取滑块
function GoodsListNew:getSlider()
    return self._slider
end

--获取是否选择仓库
function GoodsListNew:getIsChoiceWareHouse()
    return self._choiceType == CHOICE_TYPE.TYPE_WAREHOUSE
end

--[[
    改造后处理了相关刷新逻辑
]]
function GoodsListNew:refrehDeleteGrid(deleteChoiceArr, forceUpdate)
    self.deleteChoiceArr = deleteChoiceArr
    if(forceUpdate) then
        self._waitingReloadData = waitingRefresNum
        -- self._tableView:reloadData()
    end
end

--[[
    _checkItemUseState
_useLock
self._deleteState
self._usedType
]]
function GoodsListNew:updataGridCanUseState(checkItemUseState, useLock, deleteState, usedType)
    self._checkItemUseState = checkItemUseState
    self._useLock = useLock
    self._deleteState = deleteState
    self._usedType = usedType

    self._waitingReloadData = waitingRefresNum
    -- self._tableView:reloadData()
end

function GoodsListNew:update(dt)
    if self._waitingReloadData == nil then
        return
    end
    if(self._waitingReloadData > -1) then
        if(self._waitingReloadData == 0) then 
            if(self._tableView) then
                self._tableView:reloadData()
            end
            self._waitingReloadData = -1
        end
        self._waitingReloadData = self._waitingReloadData - 1
    end
end