
require ("app.ui.activity.ActivityDetailNode")
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local PetListCell = class("PetListCell", UI.HWBtnComponent)
UI.PetListCell = PetListCell

-- 列表点击开始处理器
local function onListViewTouchBeganHandler(self, listView, touchPosition)
    if (not self._isDragging) then
        local grid = self:getGridByPosition(self, touchPosition)
        if (grid) then
            self._selectedGrid = grid
            self._touchBeganPosition_ = touchPosition
            self._touchBeganLocalPosition = grid:convertToNodeSpace(touchPosition)
        end
    end
end

-- 列表点击开始处理器
local function onListViewTouchMovedHandler(self, listView, touchPosition)
    -- print("petsListCell onListViewTouchMovedHandler", self._isDragging, self._enableToDrag, self._selectedGrid ~= nil)
    if (self._enableToDrag and self._selectedGrid) then
        if (self._isDragging) then
            -- 发送拖拽事件
            self:dispatchEvent(UIEvent.LIST_VIEW_GRID_DRAG_MOVED, self._selectedGrid, touchPosition)
        else
            if (self:checkGridDraged(self._selectedGrid, self._touchBeganPosition_, touchPosition)) then
                self:setSwallowTouches(true)
                -- 触发拖拽事件
                self:dispatchEvent(UIEvent.LIST_VIEW_GRID_DRAG_BEGAN, self._selectedGrid, touchPosition, self._touchBeganLocalPosition)
                self._isDragging = true
            end
        end
    end
end

-- 列表点击开始处理器
local function onListViewTouchEndedHandler(self, listView, touchPosition)
    -- 取消拖拽事件
    -- if(self._selectedGrid) then
        if (self._isDragging) then  
            self:setSwallowTouches(false)
            self:dispatchEvent(UIEvent.LIST_VIEW_GRID_DRAG_ENDED, self._selectedGrid, touchPosition)
            self._isDragging = false
        else
            local grid = self:getGridByPosition(self, touchPosition)
            if (grid) then
                if (self._selectedGrid == grid) then
                    -- 发送点击事件
                    self:dispatchEvent(UIEvent.LIST_VIEW_GRID_CLICK, self._selectedGrid, touchPosition)
                    self:trySetTouchClipNode()
                    if self._selectedGrid._data and self:checkTouchPosition(touchPosition) then
                        Avalon.AudioManager:playSound("1503")
                    end
                    -- 发送双击事件
                    if (self._enableToDoubleClick) then
                        if (self._selectedGrid == self._lastSelectedGrid) then
                            local offsetTime = os.time() - self._clickTime
                            if (offsetTime <= 0.5) then
                                self:dispatchEvent(UIEvent.LIST_VIEW_GRID_DOUBLE_CLICK, self._selectedGrid, touchPosition)
                            end
                        end
                    end

                    self._clickTime = os.time()
                    self._lastSelectedGrid = grid
                end
            end
        end
    -- end

    self._selectedGrid = nil
end

function PetListCell:ctor(GridComponent, rowCount, data, width, height, startIndex, minShowGridNum, horizontalSpace, verticalSpace, paddingSpace)
    self._GridCompnentClass = GridComponent
    self.rowCount = rowCount
    self._gridWidth = width
    self._gridHeight = height
    self._startIndex = startIndex
    self._minShowGridNum = minShowGridNum
    self._horizontalSpace = horizontalSpace or 0
    self._verticalSpace = verticalSpace or 0
    self._paddingSpace = paddingSpace or 0
    -- orizontalSpace, verticalSpace, paddingSpace
    -- self._padingSpace = padingSpace or 5
    self._data = data

    PetListCell.super.ctor(self, UIType.ACTIVITY, {}, (width + self._horizontalSpace) * rowCount + self._paddingSpace * 2, height + self._verticalSpace)
    -- 列表中的所有格子对象
    self._gridList = {}
    self.bgImageList = {}
    self._gridCount = 0
    self._usedGridCount = 0
    self.createBg = false;
    -- 当前被选中的格子
    self._selectedGrid = nil
    self._lastSelectedGrid = nil
    -- 是否启用拖拽
    self._enableToDrag = false
    self._touchBeganPosition_ = nil
    self._isDragging = false
    self._lastClickTime = 0
    -- 是否开启双击
    self._enableToDoubleClick = false
    -- 是否显示星级
    self.startFlag = true
    -- 是否显示等级
    self.levelFlag = true

end

function PetListCell:onEnter()
    PetListCell.super.onEnter(self)
    
end

function PetListCell:onExit()
    PetListCell.super.onExit(self)
end

function PetListCell:dtor()
    PetListCell.super.dtor(self)
    self._gridList = {}
end

function PetListCell:init(deleteChoiceArr)
    self.deleteChoiceArr = deleteChoiceArr
    -- self:onInitView()
    PetListCell.super.init(self)
    self:enableToDragGrid()
    -- self:setSwallowTouches(false)
end

function PetListCell:onInitView()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize((self._gridWidth + self._horizontalSpace) * self.rowCount + self._paddingSpace * 2, self._gridHeight + self._verticalSpace)
    self:addChild(layout)
    -- layout:enableDebugDraw()
    -- print("PetListCell:onInitView", self._gridWidth * self.rowCount, self._gridHeight)

    for i=1, self.rowCount, 1 do 
        local grid = self._GridCompnentClass:create()
        grid:init()
        grid:setSize(self._gridWidth, self._gridHeight)
        -- grid:setIndex(self._gridCount + 1)
        layout:addChild(grid)
        if(grid.setCountFlag) then 
            grid:setCountFlag(self.countFlag)
        end
        grid:centerLeft(self._paddingSpace + (self._gridWidth + self._horizontalSpace)* (i - 1))
        -- print("self._gridWidth, self._gridHeight=", self._gridWidth, self._gridHeight)
        grid:setSize(self._gridWidth, self._gridHeight)
        table.insert(self._gridList, grid)
        -- self._gridCount = self._gridCount + 1
    end

    self:refreshView()

    self:setTouchEnable(true)
    self:setSwallowTouches(false)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, onListViewTouchBeganHandler)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, onListViewTouchMovedHandler)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, onListViewTouchEndedHandler)
end

function PetListCell:onUpdateView()

end

function PetListCell:reloadData(data, startIndex, minShowGridNum)
    self._data = data or {}
    self._startIndex = startIndex
    self._minShowGridNum = minShowGridNum

    self:refreshView()
end

function PetListCell:setDeleteChoiceArr(deleteChoiceArr) 
    self.deleteChoiceArr = deleteChoiceArr
end

function PetListCell:refreshView()
    local nowIndex = self._startIndex or 0
    for k, grid in ipairs(self._gridList) do
        grid:setIndex(nowIndex)
        if(self._data[k]) then
            grid:setData(self._data[k])

            if(self._showChoiceStatus) then
                grid:showChoiceStatus()
            else
                grid:hideChoiceStatus()
            end
            -- if(self.deleteChoiceArr) then
            --     for j = 1, #self.deleteChoiceArr do
            --         local petsData = self.deleteChoiceArr[j]
            --         if (petsData == self._data[k]) then
            --             grid:deleteItem()
            --             break
            --         end
            --     end
            -- end
        else
            grid:reset()
            grid:setAvailable(true)
        end
        grid:onUpdateView()
        nowIndex = nowIndex + 1
    end
end

function PetListCell:trySetTouchClipNode()
    if self:getTouchClipNode() == nil then
        local parent = self:getParent()
        while parent ~= nil do
            -- body
            if parent.addInnerNode ~= nil then
                self:setTouchClipNode(parent)
                break;
            end
            parent = parent:getParent()
        end
    end
end

-- 添加格子
function PetListCell:addGrid(gridData)
    assert(gridData, "PetListCell addGrid: grid data is invalid.")
    if (self._usedGridCount < self._gridCount) then
        local emptyGrid = self._gridList[self._usedGridCount + 1]
        if (emptyGrid) then
            emptyGrid:setData(gridData)
            emptyGrid:updateView()

            self._usedGridCount = self._usedGridCount + 1
        else
            assert(false)
        end
    else
        assert(false)
    end
end

-- 获取格子
function PetListCell:getGridByIndex(index)
    assert(type(index) == "number" and index >= 1, "PetListCell getGridByIndex: index is invalid.")

    if (index <= self._gridCount) then
        return self._gridList[index]
    else
        return nil
    end
end

-- 根据坐标获取格子
function PetListCell:getGridByPosition(self, globalPosition)
    local localPosition = self:convertToNodeSpace(globalPosition)
    if(not tolua.isnull(self)) then 
        for k, grid in ipairs(self._gridList) do 
            local boundingbox = grid:getBoundingBox()
            if (cc.rectContainsPoint(boundingbox, localPosition)) then
                return grid

            end
        end
    end

    return nil
end

-- 获取所有格子列表
function PetListCell:getGridList()
    return self._gridList
end

-- 启用格子拖拽
function PetListCell:enableToDragGrid()
    self._enableToDrag = true
end

-- 关闭格子拖拽
function PetListCell:disableToDragGrid()
    self._enableToDrag = false
end

-- 清理所有格子
function PetListCell:clear(removed)
    if (removed) then assert(type(removed) == "boolean", "PetListCell clear: removed flag is invalid.")
    else removed = false
    end

    for i = 1, self._gridCount do
        local grid = self._gridList[i]
        if (removed) then 
            grid:removeFromParent()
            self._gridList[i] = nil
        else
            grid:clear()
        end
    end

    for k, v in pairs(self.bgImageList) do
        v:removeFromParent()
    end

    self.bgImageList = {}


    if (removed) then
        self._gridCount = 0
        self._usedGridCount = 0
    end

    self._selectedGrid = nil
    self._lastSelectedGrid = nil
    self._touchBeganPosition_ = nil
    self._isDragging = false
end

-- 拖拽格子的条件检测是否成立
function PetListCell:checkGridDraged(selectedGrid, startPosition, endPosition)
    local check = false
    if (not selectedGrid:isEmpty()) then

        local distance = cc.pGetDistance(startPosition, endPosition)
        local distanceEnough =  distance >= COMPONENT_DRAG_DISTANCE

        local localPosition = selectedGrid:convertToNodeSpace(startPosition)
        local size = selectedGrid:getContentSize()

        if (localPosition.x >= 0 and 
            localPosition.y >= 0 and 
            localPosition.x <= size.width and 
            localPosition.y <= size.height) then
            local offsetX = math.abs(startPosition.x - endPosition.x)
            local offsetY = math.abs(startPosition.y - endPosition.y)
            if (offsetX > 0 and offsetY > 0) then
                check = (offsetX / offsetY) >= 1.0
            end
        end
        check = (check and distanceEnough)
    end
    return check
end

function PetListCell:showChoiceStatus()
    self._showChoiceStatus = true
    if (self._gridList) then
        for k, grid in ipairs(self._gridList) do 
            grid:showChoiceStatus()
        end
    end
end

function PetListCell:hideChoiceStatus()
    self._showChoiceStatus = false
    if (self._gridList) then
        for k, grid in ipairs(self._gridList) do 
            grid:hideChoiceStatus()
        end
    end
end

-- 启用双击
function PetListCell:enableToDoubleClick()
    self._enableToDoubleClick = true
end

-- 禁用双击
function PetListCell:disableToDoubleClick()
    self._enableToDoubleClick = false
end

function PetListCell:setStartFlag(flag)
    self.startFlag = flag
    if(self._gridList) then
        for k, grid in ipairs(self._gridList) do
            if(grid.setStartFlag) then
                grid:setStartFlag(self.startFlag)
            end
        end
    end
end

function PetListCell:setLevelFlag(flag)
    self.levelFlag = flag
    if(self._gridList) then
        for k, grid in ipairs(self._gridList) do
            if(grid.setLevelFlag) then
                grid:setLevelFlag(self.levelFlag)
            end
        end
    end
end