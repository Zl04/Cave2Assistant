--[[
    UI - 背包格子列表（带滚动功能）
]]--

require "app.ui.Component"
require "app.ui.common.GoodsList.GoodsGrid"
require "app.ui.common.GoodsList.GoodsGridList"
require "app.ui.common.GoodsList.GoodsScrollView"

UI = UI or {}

local GoodsList = class("GoodsList", UI.HWBtnComponent)
UI.GoodsList = GoodsList

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 选择类型
local CHOICE_TYPE = {
    TYPE_ALL = 1,
    TYPE_WEAR = 2,
    TYPE_EQUIPMENTS = 3,
    TYPE_ITEMS = 4,
    TYPE_MATERIAL = 5,
    TYPE_GEM_STONE = 6,
    TYPE_GEM_STONE_WEAR = 7,
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
    if (not self._scrollView:checkTouchPosition(touchPosition)) then return end

    if self._canDrag == false then
        return
    end

    clearDragGrid(self)

    if not goodsGrid:getCanUseState() then
        return
    end

    self._draggedGoodsGrid = goodsGrid:createDraggedView()
    if (self._draggedGoodsGrid) then
        self._goodsGridList:takeGoodsGrid(goodsGrid:getData())

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

        self._scrollView:disableScrolling()

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

        self._scrollView:enableScrolling()
    end
end

-- 点击格子
local function onGoodsGridClickHandler(self, goodsGrid, touchPosition)
    if (not self._scrollView:checkTouchPosition(touchPosition)) then return end

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
    elseif (goodsGrid:isLocked()) then
        Avalon.AudioManager:playSound("1503")
        local GameDataManager = require("app.game.GameDataManager")
        if self._goodsData and self._goodsData.packetType ~= PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE and (not GameDataManager:goodsDataIsNeedUnlockPacket(self._goodsData)) then
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
        elseif (not GameDataManager:goodsDataIsNeedUnlockPacket(self._goodsData)) then

            if self._goodsData.packetBoxBeUseNum >= tonumber(Config.General:getValueForKey("packetWarehouseMaxNum")) then
                UI.ScrollBar:createByText(UI.TEXT_110032)
                return
            end

            -- 每次解锁的背包格子数
            local count = Config.General:getValueForKey("unlockPacketWarehouseSpace")
            -- 话费的数量
            local cost = 0
            -- 获取已经购买的次数
            local boughtTimes = self._goodsData.unlockBagTimes + 1
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
                        Net.NetGoodsSystem:requestUnlockBagSpace(self._goodsData.packetType)
                    end 
                else
                    UI.TipsLayer:onDiamondNotEnough()
                end
            end)
        end
    end
end

local function onGoodsGridDoubleClickHandler(self, goodsGrid, touchPosition)
    if (not self._scrollView:checkTouchPosition(touchPosition)) then return end

    clearDragGrid(self)

    if (goodsGrid:isUsed()) then
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
    -- self._slider:show()
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
    --     print("GoodsList  updateGridCount")
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
function GoodsList:ctor(columnCount)
    self.doubleClickAsDragEnd = false
    -- 滚动视图组件
    self._scrollView = nil
    -- 物品列表组件
    self._goodsGridList = nil
    -- 滑块组件
    self._slider = nil
    -- 角色的物品数据
    self._goodsData = nil

    self._viewHeight = nil

    self._choiceType = CHOICE_TYPE.TYPE_ALL

    -- 当前被选中的格子
    self._selectedGoodsGrid = nil
    -- 被拖拽的格子
    self._draggedGoodsGrid = nil
    -- 格子开始被拖拽时候的格子局部坐标
    self._girdLocalPosition = nil
    -- 事件回调函数
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

    --能否拖拽
    self._canDrag = true



    GoodsList.super.ctor(self, UIType.GOODS_LIST, RES_LIST, 70 * self._columnCount, COM_HEIGHT)

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_BAG, self, onUnlockBagGridHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_WAREHOUSE, self, onUnlockBagGridHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_RESPONSE, self, onUnlockResponse)
    
end

-- 析构函数
function GoodsList:dtor()
    GoodsList.super.dtor(self)
    self._choiceType = CHOICE_TYPE.TYPE_ALL
    if(self._draggedGoodsGrid) then
        self._draggedGoodsGrid:setVisible(false)
        self._draggedGoodsGrid = nil
    end

    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_BAG, self, onUnlockBagGridHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_WAREHOUSE, self, onUnlockBagGridHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_RESPONSE, self, onUnlockResponse)
end

-- public:
-- 初始化
function GoodsList:init(goodsData, viewHeight, addPadingSpace)
    self._goodsData = goodsData
    self._viewHeight = viewHeight
    self._addPadingSpace = addPadingSpace
    GoodsList.super.init(self)
end

-- 初始化视图
function GoodsList:onInitView(GridComponent, gridWidth, gridHeight, horizontalSpace, verticalSpace, paddingSpace)
    local bgImageCover = UI.Image:create()
    bgImageCover:init(SPRITES.COM_BG)
    bgImageCover:centerLeft(0)
    self:addChild(bgImageCover)
    self._bgImageCover = bgImageCover

    -- 背包列表
    local addPadingSpace = self._addPadingSpace or 12
    local goodsGridList = UI.GoodsGridList:create()
    goodsGridList:init(UI.GoodsGrid, 
        self._columnCount, 0,
        68, 68, 
        6, 6, 6+ addPadingSpace
    )
    goodsGridList:disableToDoubleClick()
    goodsGridList:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_BEGAN, self, onGoodsGridDragBeganHandler)
    goodsGridList:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_MOVED, self, onGoodsGridDragMovedHandler)
    goodsGridList:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_ENDED, self, onGoodsGridDragEndedandler)
    goodsGridList:addEventListener(UIEvent.LIST_VIEW_GRID_CLICK, self, onGoodsGridClickHandler)
    goodsGridList:addEventListener(UIEvent.LIST_VIEW_GRID_DOUBLE_CLICK, self, onGoodsGridDoubleClickHandler)
    self._goodsGridList = goodsGridList
    
    -- 滚动视图
    local scrollView = UI.BagScrollView:create()
    scrollView:init(0, 0, 0, 0)
    -- scrollView:centerLeft(9)
    scrollView:leftUp(18 - addPadingSpace,42+7 + 7)
    -- scrollView:setSize(80 * self._columnCount+5,360)
    self._viewHeight = self._viewHeight or 355
    scrollView:setSize(74 * self._columnCount+5 + 28 + addPadingSpace, self._viewHeight)
    scrollView:setTouchEnable(true)
    scrollView:setRestorePositiion(true)
    scrollView:addInnerNode(goodsGridList)
    scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLL_BEGAN, self, onGoodsScrollViewScrollBeganHandler)
    scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLLING, self, onGoodsScrollViewScrollingHandler)
    scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLL_ENDED, self, onGoodsScrollViewScrollEndedHandler)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    scrollView:setScrollBarWidth(5)
    scrollView:setCircleVisible(false)

    self:addChild(scrollView)
    self._scrollView = scrollView

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
function GoodsList:updateGridCount(callback)
    self._goodsGridList:addGridCount(self._goodsData.packetBoxBeUseNum, self._goodsData.packetBoxMaxNum, callback) 

    -- 更新物品列表的滑块
    local availableCount, maxCount = self._goodsData.packetBoxBeUseNum, self._goodsData.packetBoxMaxNum
    local percent = 0
    if (maxCount ~= 0) then percent = availableCount / maxCount
    end
    local sliderWidth, sliderHeight = self._slider:getSize()
    sliderHeight = sliderHeight * percent
    self._slider:setSliderComSize(sliderWidth, sliderHeight)
end

-- 更新视图
function GoodsList:onUpdateView()
    if (self._goodsData) then
        self._goodsGridList:setGridCount(self._goodsData.packetBoxBeUseNum, self._goodsData.packetBoxMaxNum) 
        -- self._goodsGridList:setDataList(self._goodsData.haveEquipmentArr)
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
        end

        -- self._goodsGridList:updateView()

        -- 更新物品列表的滑块
        local availableCount, maxCount = self._goodsData.packetBoxBeUseNum, self._goodsData.packetBoxMaxNum
        local percent = 0
        if (maxCount ~= 0) then percent = availableCount / maxCount
        end
        local sliderWidth, sliderHeight = self._slider:getSize()
        sliderHeight = sliderHeight * percent
        self._slider:setSliderComSize(sliderWidth, sliderHeight)
    end
end

-- 锁定状态改变
function GoodsList:lockStatusChange(data)
    if(self._goodsData) then
        local gridList = self:getGridList()
        if(gridList) then
            for _,gridView in pairs(gridList) do
                local goodsData = gridView:getData()
                if(goodsData) then
                    if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
                        if(goodsData:getEntityID() == data.entityID) then
                            gridView:updateView()
                            break
                        end
                    else
                        -- TODO 判断是否是相同的包裹,然后在判断是否为同一个物品
                        local handle = true
                        if(self._packetType == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE or data.packetType == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE) then
                            if(self._packetType ~= data.packetType) then
                                handle = false
                            end
                        end

                        if(handle) then
                            if(data.templateID == goodsData:getGoodsID()) then
                                -- print("GoodsList:lockStatusChange prop ", data.isLock, goodsData:getIsLock())
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
function GoodsList:setData(goodsData)
    self:cancelSelectGoodsGrid()
    clearDragGrid(self)

    self._goodsData = goodsData
end

function GoodsList:setRefreshFlag(flag)
    if(self._goodsGridList) then 
        self._goodsGridList:setRefreshFlag(flag)
    end
end

function GoodsList:showChoiceStatus()
    if(self._goodsGridList) then 
        self._goodsGridList:showChoiceStatus()
    end
end

function GoodsList:hideChoiceStatus()
    if(self._goodsGridList) then 
        self._goodsGridList:hideChoiceStatus()
    end
end

-- 显示所有物品
function GoodsList:showAllGoods()
    -- print("GoodsList:showAllGoods 1")
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_ALL
    if (self._goodsData) then
        local allGoodsList = {}
        local index = 1
        for i = 1, #self._goodsData.haveEquipmentArr do
            if self._goodsData.haveEquipmentArr[i]._changeNum == nil or self._goodsData.haveEquipmentArr[i]._changeNum >= 0 then
                table.insert(allGoodsList, index, self._goodsData.haveEquipmentArr[i])
                index = index + 1
            end
        end
        for i = 1, #self._goodsData.haveItemArr do
            if self._goodsData.haveItemArr[i]._changeNum == nil or self._goodsData.haveItemArr[i]._changeNum >= 0 then
                table.insert(allGoodsList, index, self._goodsData.haveItemArr[i])
                index = index + 1
            else
                -- self._goodsData.haveItemArr[i]:setNum(self._goodsData.haveItemArr[i]:getNum() + self._goodsData.haveItemArr[i]._changeNum )
                if self._goodsData.haveItemArr[i]:getNum() + self._goodsData.haveItemArr[i]._changeNum  > 0 then
                    table.insert(allGoodsList, index, self._goodsData.haveItemArr[i])
                    index = index + 1
                end
            end
        end
        for i = 1, #self._goodsData.haveMaterialArr do
            if self._goodsData.haveMaterialArr[i]._changeNum == nil or self._goodsData.haveMaterialArr[i]._changeNum == 0 then
                table.insert(allGoodsList, index, self._goodsData.haveMaterialArr[i])
                index = index + 1
            else
                -- self._goodsData.haveMaterialArr[i]:setNum(self._goodsData.haveMaterialArr[i]:getNum() + self._goodsData.haveMaterialArr[i]._changeNum )
                if self._goodsData.haveMaterialArr[i]:getNum() + self._goodsData.haveMaterialArr[i]._changeNum > 0 then
                    table.insert(allGoodsList, index, self._goodsData.haveMaterialArr[i])
                    index = index + 1
                end
            end
        end
        for i = 1, #self._goodsData.haveGemStoneArr do
            if self._goodsData.haveGemStoneArr[i]._changeNum == nil or self._goodsData.haveGemStoneArr[i]._changeNum == 0 then
                table.insert(allGoodsList, index, self._goodsData.haveGemStoneArr[i])
                index = index + 1
            else
                -- self._goodsData.haveGemStoneArr[i]:setNum(self._goodsData.haveGemStoneArr[i]:getNum() + self._goodsData.haveGemStoneArr[i]._changeNum )
                if self._goodsData.haveGemStoneArr[i]:getNum() + self._goodsData.haveGemStoneArr[i]._changeNum > 0 then
                    table.insert(allGoodsList, index, self._goodsData.haveGemStoneArr[i])
                    index = index + 1
                end
            end
        end

        self._goodsGridList:setDataList(allGoodsList)
        self._goodsGridList:updateView()
    end
end

-- 显示穿戴装备
function GoodsList:showEquip()
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_WEAR
    if (self._goodsData) then
        local equips = {}

        for i = 1, #self._goodsData.wearEquipmentArr do
            if self._goodsData.wearEquipmentArr[i]._changeNum == nil or self._goodsData.wearEquipmentArr[i]._changeNum >= 0 then
                table.insert(equips, self._goodsData.wearEquipmentArr[i])
            end
        end

        --local equips = self._goodsData.wearEquipmentArr
        -- print("GoodsList:showEquip 1")
        if (equips) then
            self._goodsGridList:setDataList(equips)
            self._goodsGridList:updateView()
        end
    end
end

-- 显示所有装备
function GoodsList:showEquipments()
    -- print("GoodsList:showEquipments 1")
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_EQUIPMENTS
    if (self._goodsData) then

        local equipments = {}
        for i = 1, #self._goodsData.haveEquipmentArr do
            if self._goodsData.haveEquipmentArr[i]._changeNum == nil or self._goodsData.haveEquipmentArr[i]._changeNum >= 0 then
                table.insert(equipments, self._goodsData.haveEquipmentArr[i])
            end
        end

        -- local equipments = self._goodsData.haveEquipmentArr
        if (equipments) then
            self._goodsGridList:setDataList(equipments)
            self._goodsGridList:updateView()
        end
    end
end

-- 显示所有道具
function GoodsList:showItems()
    -- print("GoodsList:showItems 1")
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_ITEMS
    if (self._goodsData) then
        local items = {}
        for i = 1, #self._goodsData.haveItemArr do
            -- if self._goodsData.haveItemArr[i]._changeNum == nil or self._goodsData.haveItemArr[i]._changeNum == 0 then
            -- else
            --     self._goodsData.haveItemArr[i]:setNum(self._goodsData.haveItemArr[i]:getNum() + self._goodsData.haveItemArr[i]._changeNum )

            -- end

            if self._goodsData.haveItemArr[i]:getNum() + self._goodsData.haveItemArr[i]._changeNum > 0 then
                table.insert(items, self._goodsData.haveItemArr[i])
            end
        end

        if (items) then
            self._goodsGridList:setDataList(items)
            self._goodsGridList:updateView()
        end
    end
end

-- 显示所有材料
function GoodsList:showMaterials()
    -- print("GoodsList:showMaterials 1")
    self:cancelSelectGoodsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_MATERIAL
    if (self._goodsData) then
        local materials = {}
        for i = 1, #self._goodsData.haveMaterialArr do
            -- if self._goodsData.haveMaterialArr[i]._changeNum == nil or self._goodsData.haveMaterialArr[i]._changeNum == 0 then
            -- else
            --     self._goodsData.haveMaterialArr[i]:setNum(self._goodsData.haveMaterialArr[i]:getNum() + self._goodsData.haveMaterialArr[i]._changeNum )

            -- end

            if self._goodsData.haveMaterialArr[i]:getNum() + self._goodsData.haveMaterialArr[i]._changeNum > 0 then
                table.insert(materials, self._goodsData.haveMaterialArr[i])
            end
        end


        -- local materials = self._goodsData.haveMaterialArr
        if (materials) then
            self._goodsGridList:setDataList(materials)
            self._goodsGridList:updateView()
        end
    end
end

function GoodsList:showGemStoneWear()
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
        self._goodsGridList:setDataList(genStones)
        self._goodsGridList:updateView()
    end
end

function GoodsList:showGemStone()
    -- print("GoodsList:showGemStone 1")
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
            self._goodsGridList:setDataList(genStones)
            self._goodsGridList:updateView()
        end
    end
end

function GoodsList:showMask()
    self._bgUpImageShow = true
    if(self._bgUpImage) then 
        self._bgUpImage:show()
    end
end

function GoodsList:showDestory()
    -- self._itemdestroy:setAnimation("animation3", true)
    -- self._itemdestroy:show()
end

function GoodsList:hideDestory()
    self:cancelSelectGoodsGrid()
    
    -- self._itemdestroy:hide()
end

-- 显示移动的表现效果
function GoodsList:showMove()
    -- self._itemdestroy:setAnimation("animation4", true)
    -- self._itemdestroy:show()
end

-- 隐藏移动效果
function GoodsList:hideMove()
    -- self._itemdestroy:hide()
end

-- 修改是否处于放置中间
function GoodsList:changeInSideStatus(inSide)
    if(not tolua.isnull(self._dragAnimation)) then
        self._dragAnimation:changeInSideStatus(inSide)
    end
end

function GoodsList:cancelSelectGoodsGrid()
    if(self._selectedGoodsGrid and not tolua.isnull(self._selectedGoodsGrid)) then
        self._selectedGoodsGrid:hideSelect()
        self._selectedGoodsGrid = nil
    end
end

-- 获取所有对象列表
function GoodsList:getGridList()
    return self._goodsGridList:getGridList()
end

-- 添加拖拽格子开始的处理回调函数
function GoodsList:setCallbackForGridDragBegan(target, func)
    self._targetForDragBegan = target
    self._functionForDragBegan = func
end

-- 添加拖拽格子的处理回调函数
function GoodsList:setCallbackForGridDragMoved(target, func)
    self._targetForDragMoved = target
    self._functionForDragMoved = func
end

-- 添加拖拽格子完成的处理回调函数
function GoodsList:setCallbackForGridDragEnded(target, func)
    self._targetForDragEnded = target
    self._functionForDragEnded = func
end

-- 添加点击个字的处理回调函数
function GoodsList:setCallbackForGridClick(target, func)
    self._targetForGridClick = target
    self._functionForGridClick = func
end

-- 添加滚动进度的处理回调函数
function GoodsList:setCallbackForScrolling(target, func)
    self._targetForScrolling = target
    self._functionForScrolling = func
end

-- 添加双击格子的处理回调函数
function GoodsList:setCallbackForGridDoubleClick(target, func)
    self._targetForGridDoubleClick = target
    self._functionForGridDoubleClick = func
    if CONFIG_DOUBLIE_CLICK then
        self:enableDoubleClick()
    end
end

function GoodsList:setDoubleClickAsDragEnd(enable)
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
function GoodsList:updateCanDrag(var)
    self._canDrag = var
end

function GoodsList:enableDoubleClick()
    self._goodsGridList:enableToDoubleClick()
end 

function GoodsList:disableDoubleClick()
    self._goodsGridList:disableToDoubleClick()
end



-- 滚到到顶部
function GoodsList:scrollToTop(timeInSec, attenuated)
    self._scrollView:scrollToTop(timeInSec, attenuated)
end

-- 滚动到底部
function GoodsList:scrollToBottom(timeInSec, attenuated)
    self._scrollView:scrollToBottom(timeInSec, attenuated)
end

function GoodsList:setColumnCount(columnCount)
    self._columnCount = columnCount
end

function GoodsList:hideBGImageCover()
    self._bgImageCover:hide()
end

--获取滑块
function GoodsList:getSlider()
    return self._slider
end