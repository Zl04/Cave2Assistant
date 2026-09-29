--[[
    UI - 宠物背包格子列表（带滚动功能）
]]--

require "app.ui.Component"
require "app.ui.common.PetList.PetListCell"
require "app.ui.common.PetList.PetGrid"

UI = UI or {}

local PetList = class("PetList", UI.HWBtnComponent)
UI.PetList = PetList

-- 选择类型 打赌以后肯定分类型
local CHOICE_TYPE = {
    TYPE_ALL = 1,
}

-- 尺寸
local COM_WIDTH = 400
local COM_HEIGHT = 465
local GRID_WIDTH = 90
local GRID_HEIGHT = 90

local RES_LIST = {
}

local SPRITES = {
    COM_BG = "ui_pets_merge_bg.png",
    COM_SLIDER = "ui_role_slider_00.png",
}

-- 背包格子拖拽开始的处理器
local function onPetsGridDragBeganHandler(self, petsGrid, touchPosition)
    if(petsGrid == nil) then
        return
    end

    if (not self._tableView:checkTouchPosition(touchPosition)) then 
        return
    end

    if self._canDrag == false then
        return
    end

    self:clearDragGrid()

    if not petsGrid:getCanUseState() then
        return
    end

    self._draggedPetsGrid = petsGrid:createDraggedView()
    if (self._draggedPetsGrid) then
        local rootLayer = UI.UIManager:getRootNode()
        rootLayer:addChild(self._draggedPetsGrid, UI.MAX_Z_ORDER)

        local rootLayerLocalPosition = rootLayer:convertToNodeSpace(touchPosition)
        local gridLocalPosition = petsGrid:convertToNodeSpace(touchPosition)
        self._draggedPetsGrid:leftBottom(
            rootLayerLocalPosition.x - gridLocalPosition.x, 
            rootLayerLocalPosition.y - gridLocalPosition.y
        )
        self._girdLocalPosition = gridLocalPosition

        -- petsGrid:hideIcon()

        -- 调用回调函数
        if (self._targetForDragBegan and self._functionForDragBegan) then
            self._functionForDragBegan(self._targetForDragBegan, petsGrid, touchPosition)
        end
    end
end

-- 背包格子拖拽的处理器
local function onPetsGridDragMovedHandler(self, petsGrid, touchPosition)
    if(petsGrid == nil) then  return end

    if self._canDrag == false then
        return
    end
    if self._draggedPetsGrid then
        if not petsGrid:getCanUseState() then
            return
        end
        if (self._draggedPetsGrid) then
            local rootLayer = UI.UIManager:getRootNode()
            local rootLayerLocalPosition = rootLayer:convertToNodeSpace(touchPosition)
            self._draggedPetsGrid:leftBottom(
                rootLayerLocalPosition.x - self._girdLocalPosition.x,
                rootLayerLocalPosition.y - self._girdLocalPosition.y
            )

            if (self._targetForDragMoved and self._functionForDragMoved) then
                self._functionForDragMoved(self._targetForDragMoved, petsGrid, touchPosition)
            end
        end
    end
end

-- 背包格子拖拽结束的处理器
local function onPetsGridDragEndedandler(self, petsGrid, touchPosition)
    if(not tolua.isnull(self._draggedPetsGrid)) then 
        self._draggedPetsGrid:removeChildByName("drag_finger")
    end

    if(petsGrid == nil) then  return end

    if self._canDrag == false then
        return
    end

    if (self._draggedPetsGrid) then
        if not petsGrid:getCanUseState() then
            return
        end

        -- 是否从列表中删除格子
        local removed = false

        -- 调用回调函数（返回值：是否删除格子）
        if (self._targetForDragEnded and self._functionForDragEnded) then 
            removed = self._functionForDragEnded(self._targetForDragEnded, petsGrid, touchPosition)
        end
        if (removed) then 
            -- 删除格子
            self:removeGrid(petsGrid:getData())
        else
            -- 隐藏图标
            -- petsGrid:showIcon()
        end

        self:clearDragGrid()
    end
end

-- 点击格子
local function onPetsGridClickHandler(self, petsGrid, touchPosition)
    if (not self._tableView:checkTouchPosition(touchPosition)) then return end

    self:clearDragGrid()

    if (petsGrid:isUsed()) then
        if (self._selectedPetsGrid) then
            if (not tolua.isnull(self._selectedPetsGrid)) then
                self._selectedPetsGrid:hideSelect()
            else
                self._selectedPetsGrid = nil
            end
        end

        if(petsGrid:isClickShowInfo()) then
            self._selectedPetsGrid = petsGrid
            petsGrid:showSelect()

            if (self._targetForGridClick and self._functionForGridClick) then
                self._functionForGridClick(self._targetForGridClick, petsGrid)
            end
        end

        -- petsGrid:hideNewIcon()
    end
end
-- 双击格子，目前尚未使用
local function onPetsGridDoubleClickHandler(self, petsGrid, touchPosition)
    if (not self._tableView:checkTouchPosition(touchPosition)) then return end
    self:clearDragGrid()

    if (petsGrid:isUsed()) and petsGrid:getCanUseState() then
        if (not petsGrid:isEmpty()) then
            -- 显示格子被点击的效果
            if (self._selectedGrid) then self._selectedGrid:hideSelect() end
            self._selectedGrid = petsGrid
            petsGrid:showSelect()
    
            -- 调用回调函数
            if self.doubleClickAsDragEnd then
                local removed = false
                -- 调用回调函数（返回值：是否删除格子）
                if (self._targetForDragEnded and self._functionForDragEnded) then 
                    removed = self._functionForDragEnded(self._targetForDragEnded, petsGrid, cc.p(-10000, -10000))
                end
                if (removed) then 
                    -- 删除格子
                    self:removeGrid(grid:getData())
                else
                    -- 隐藏图标
                    petsGrid:showIcon()
                end
            else
                if (self._targetForGridDoubleClick and self._functionForGridDoubleClick) then
                    self._functionForGridDoubleClick(self._targetForGridDoubleClick, petsGrid)
                end
            end
        end
    end
end

-- 添加拖拽格子开始的处理回调函数
function PetList:setCallbackForGridDragBegan(target, func)
    self._targetForDragBegan = target
    self._functionForDragBegan = func
end

-- 添加拖拽格子的处理回调函数
function PetList:setCallbackForGridDragMoved(target, func)
    self._targetForDragMoved = target
    self._functionForDragMoved = func
end

-- 添加拖拽格子完成的处理回调函数
function PetList:setCallbackForGridDragEnded(target, func)
    self._targetForDragEnded = target
    self._functionForDragEnded = func
end

-- 添加点击格子的处理回调函数
function PetList:setCallbackForGridClick(target, func)
    self._targetForGridClick = target
    self._functionForGridClick = func
end

-- 添加双击格子的处理回调函数
function PetList:setCallbackForGridDoubleClick(target, func)
    self._targetForGridDoubleClick = target
    self._functionForGridDoubleClick = func
    -- if CONFIG_DOUBLIE_CLICK then
    --     self:enableDoubleClick()
    -- end
end

-- 构造函数
function PetList:ctor(columnCount)
    reload_script_file("app.ui.common.PetList.PetList")
    self.doubleClickAsDragEnd = false
    -- 滚动视图组件
    self._scrollView = nil
    -- 宠物列表组件
    self._petsGridList = nil
    -- 滑块组件
    self._slider = nil
    -- 宠物数据
    self._petsData = nil

    self._viewHeight = nil

    self._choiceType = CHOICE_TYPE.TYPE_ALL

    -- 当前被选中的格子
    self._selectedPetsGrid = nil
    -- 被拖拽的格子
    self._draggedPetsGrid = nil
    -- 格子开始被拖拽时候的格子局部坐标
    self._girdLocalPosition = nil
    -- 事件回调函数
    self._targetForDragBegan = nil
    self._functionForDragBegan = nil
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

    self._columnCount = columnCount or 4

    self._enableToDoubleClick = false

    --能否拖拽
    self._canDrag = true

    self._nowShowPetsData = {}

    self._CellList = {}

    PetList.super.ctor(self, UIType.GOODS_LIST, RES_LIST, GRID_WIDTH * self._columnCount, COM_HEIGHT)
end

-- 析构函数
function PetList:dtor()
    PetList.super.dtor(self)
    self._choiceType = CHOICE_TYPE.TYPE_ALL
    if(self._draggedPetsGrid) then
        self._draggedPetsGrid:setVisible(false)
        self._draggedPetsGrid = nil
    end
    self._CellList = {}
end

-- 初始化
function PetList:init(PetsData, viewHeight, addPadingSpace)
    self._petsData = PetsData
    self._viewHeight = viewHeight
    self._addPadingSpace = addPadingSpace
    PetList.super.init(self)
end

-- 初始化视图
function PetList:onInitView()

    local addPadingSpace = self._addPadingSpace or 6
    self._viewHeight = self._viewHeight or 416
    self._tableView = UI.TableView.new(RES_LIST, GRID_WIDTH * self._columnCount + 30, self._viewHeight)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:init()
    self._tableView:leftBottom(-15, 20)
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:setScrollBarEnabled(true)
    self._tableView:onUpdateCellSize(function (table,idx)
        return (GRID_WIDTH + addPadingSpace) * self._columnCount, GRID_WIDTH + addPadingSpace/2;
    end)
    
    self._tableView:onUpdateCells(function (tableView, idx)
        local cell = tableView:dequeueCell();

        local nowData = {}
        if self._nowShowPetsData then
            for i=1, self._columnCount, 1 do
                if(self._nowShowPetsData[idx * self._columnCount + i]) then 
                    table.insert(nowData, self._nowShowPetsData[idx * self._columnCount + i])
                end
            end
        end

        local minShowGridNum = 0
        if(self._petsData) then
            minShowGridNum = self._petsData.packetMinShowGridNum
        end

        if(self._nowShowPetsData == nil) then
            self._nowShowPetsData = {}
        end

        if(cell == nil) then
            xpcall(function()
                cell = UI.TableViewCell:create()
                cell:init()

                local listCell = UI.PetListCell:create(UI.PetGrid, self._columnCount, nowData, GRID_WIDTH, GRID_HEIGHT, idx * self._columnCount + 1, minShowGridNum, 5, 5, addPadingSpace)
                listCell:init(self.deleteChoiceArr)
                listCell:setName("cell")
                listCell:leftBottom(0, 0)
                cell:addChild(listCell)
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

                listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_BEGAN, self, onPetsGridDragBeganHandler)
                listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_MOVED, self, onPetsGridDragMovedHandler)
                listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_ENDED, self, onPetsGridDragEndedandler)
                listCell:addEventListener(UIEvent.LIST_VIEW_GRID_CLICK, self, onPetsGridClickHandler)
                listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DOUBLE_CLICK, self, onPetsGridDoubleClickHandler)
            end,
            function(e) 
                printError("------------------------PetList:tableCellAtIndex-----------------error")
            end, 1);
        else
            local listCell = cell:getChildByName("cell")
            if(listCell) then
                listCell:setDeleteChoiceArr(self.deleteChoiceArr)
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
                listCell:reloadData(nowData, idx * self._columnCount + 1, minShowGridNum)
            end
        end

        self._CellList[idx] = cell

        return cell;
    end);
    self.testState = 1
    self._tableView:onUpdateCellNumbers(function ()
        local minNum = self._petsData.packetMinShowGridNum
        local totalNum = #self._petsData.petsArr
        if minNum > totalNum then
            return math.ceil(minNum / self._columnCount)
        else
            return math.ceil(#self._petsData.petsArr / self._columnCount)
        end
    end)

    self._tableView:onTableCellTouched(function(tableView, cell)
        -- printInfo("PetsList  onTableCellTouched")
    end)

    self:addChild(self._tableView)
    self._tableView:reloadData()

    -- 格子蒙层
    local bgUpImage = UI.Image:create()
    bgUpImage:init("ui_pets_list_mask.png")
    bgUpImage:leftBottom(-17, 106 - GRID_WIDTH)
    -- bgUpImage:enableDebugDraw()
    bgUpImage:hide()
    self:addChild(bgUpImage)
    self._bgUpImage = bgUpImage
    if(self._bgUpImageShow) then 
        bgUpImage:show()
    end

end

-- 更新视图
function PetList:onUpdateView()
    if (self._petsData) then
        self._nowShowPetsData = {}

        if (self._choiceType == CHOICE_TYPE.TYPE_ALL) then
            self:showAllPets()
        end
    end
end

-- 显示所有宠物
function PetList:showAllPets()
    self:cancelSelectPetsGrid()
    self._choiceType = CHOICE_TYPE.TYPE_ALL

    local allPets = clone(self._petsData.petsArr)

    if self._petsData.packetMinShowGridNum > #allPets then
        local emptyCount = self._petsData.packetMinShowGridNum - #allPets
        for i = 1, emptyCount do
            table.insert(allPets, {emptySlot = true})
        end
    else
        local emptyCount = self._petsData.packetMinShowGridNum * math.ceil(#allPets / self._columnCount) - #allPets
        for i = 1, emptyCount do
            table.insert(allPets, {emptySlot = true})
        end
    end
    self._nowShowPetsData = allPets
    self._tableView:reloadData()
end

--更新是否能拖拽
function PetList:updateCanDrag(var)
    self._canDrag = var
end

function PetList:enableDoubleClick()
    self._enableToDoubleClick = true
    self._tableView:reloadData()
end 

function PetList:disableDoubleClick()
    self._enableToDoubleClick = false
    self._tableView:reloadData()
end

function PetList:showChoiceStatus()
    self._showChoiceStatus = true
    self._tableView:reloadData()
end

function PetList:hideChoiceStatus()
    self._showChoiceStatus = false
    self._tableView:reloadData()
end

function PetList:showMask()
    self._bgUpImageShow = true
    if(self._bgUpImage) then 
        self._bgUpImage:show()
    end
end

function PetList:cancelSelectPetsGrid()
    if(self.__selectedPetsGrid and not tolua.isnull(self.__selectedPetsGrid)) then
        self.__selectedPetsGrid:hideSelect()
        self.__selectedPetsGrid = nil
    end
end

-- 获取格子对象
function PetList:getCellList()
    if(self._CellList) then
        return self._CellList
    end
end

-- 获取tableview对象
function PetList:getTableView()
    if(self._tableView) then
        return self._tableView
    end
end

-- 获取tableview对象
function PetList:getGridByPetIndex(index)
    if not self._CellList or #self._CellList < 0 then
        return nil
    end

    for _, cell in pairs(self._CellList) do
        local listCell = cell:getChildByName("cell")
        for _, grid in pairs(listCell:getGridList()) do
            if grid:getData():getId() == index then
                return grid
            end
        end
    end
end

-- 滑动到指定index的cell处，passNum是额外继续往后滑动的格子数，showMove为true则会动态滑动过去
function PetList:scrollToCell(index, passNum, showMove)
    if(self._tableView) then
        self._tableView:scrollToCell(index, passNum, showMove)
    end
end

function PetList:scrollToTop()
    if(self._tableView) then
        self._tableView:scrollToTop()
    end
end

function PetList:scrollToBottom()
	if(self._tableView) then
		self._tableView:scrollToBottom()
	end
end

-- 设置背包数据
function PetList:setData(PetsData)
    self:cancelSelectPetsGrid()

    self._petsData = PetsData

    -- self._tableView:reloadData()
    self:onUpdateView()
end

-- 清理拖拽对象
function PetList:clearDragGrid()
    if(self._draggedPetsGrid) then
        self._draggedPetsGrid:destroy()
        self._draggedPetsGrid = nil
    end
end

function PetList:refrehDeleteGrid(deleteChoiceArr, forceUpdate)
    self.deleteChoiceArr = deleteChoiceArr
    if(forceUpdate) then
        self._tableView:reloadData()
    end
end
