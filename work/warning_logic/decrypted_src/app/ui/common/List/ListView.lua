--[[
    UI - 列表视图
]]--

require "app.ui.Component"

UI = UI or {}

local ListView = class("ListView", UI.HWBtnComponent)
UI.ListView = ListView

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 根据全局坐标选择格子
local function getGridByPosition(self, globalPosition)
    local localPosition = self:convertToNodeSpace(globalPosition)

    local columnIndex = math.ceil((localPosition.x - self._paddingSpace) / (self._gridWidth + self._horizontalSpace))
    local rowIndex = math.ceil(((self._height - localPosition.y) - self._paddingSpace) / (self._gridHeight + self._verticalSpace))
    local index = (rowIndex - 1) * self._columnCount + columnIndex

    local grid = nil
    if (index >= 1) then
        grid = self:getGridByIndex(index)
    end
    if (grid) then
        local boundingbox = grid:getBoundingBox()
        if (cc.rectContainsPoint(boundingbox, localPosition)) then
            if (DEBUG) then
                print(string.format("ListView getGridByPosition: select the grid %d.", index))
            end
            return grid
        end
    end
    return nil
end

-- 列表点击开始处理器
local function onListViewTouchBeganHandler(self, listView, touchPosition)
    if (not self._isDragging) then
        local grid = getGridByPosition(self, touchPosition)
        if (grid) then
            self._selectedGrid = grid
            self._touchBeganPosition_ = touchPosition
            self._touchBeganLocalPosition = grid:convertToNodeSpace(touchPosition)
        end
    end
end

-- 列表点击开始处理器
local function onListViewTouchMovedHandler(self, listView, touchPosition)
    if (self._enableToDrag and self._selectedGrid) then
        if (self._isDragging) then
            -- 发送拖拽事件
            self:dispatchEvent(UIEvent.LIST_VIEW_GRID_DRAG_MOVED, self._selectedGrid, touchPosition)
        else
            if (self:checkGridDraged(self._selectedGrid, self._touchBeganPosition_, touchPosition)) then
                if (DEBUG) then
                    print(string.format("ListView onListViewTouchMovedHandler: start to drag grid %d.", self._selectedGrid:getIndex()))
                end

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
            if (DEBUG) then
                print(string.format("ListView onListViewTouchEndedHandler: stop dragging grid %d.", self._selectedGrid:getIndex()))
            end

            self:dispatchEvent(UIEvent.LIST_VIEW_GRID_DRAG_ENDED, self._selectedGrid, touchPosition)
            self._isDragging = false
        else
            local grid = getGridByPosition(self, touchPosition)
            if (grid) then
                if (self._selectedGrid == grid) then
                    if (DEBUG) then
                        print(string.format("ListView onListViewTouchEndedHandler: select grid %d.", self._selectedGrid:getIndex()))
                    end
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
                                if (DEBUG) then
                                    print(string.format("ListView onListViewTouchEndedHandler: dobule click grid %d.", self._selectedGrid:getIndex()))
                                end

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

function ListView:trySetTouchClipNode()
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
-- 构造函数
function ListView:ctor()
    ListView.super.ctor(self, UIType.LIST_VIEW, nil, 0, 0)

    -- 列表布局数据
    self._columnCount = 0
    self._rowCount = 0
    self._gridWidth = 0
    self._gridHeight = 0
    self._paddingSpace = 0
    self._horizontalSpace = 0
    self._verticalSpace = 0

    -- 格子类
    self._GridCompnentClass = nil
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
    -- 是否禁用双击
    self._enableToDoubleClick = true
    -- 是否显示数量
    self.countFlag = true
end

-- 析构函数
function ListView:dtor()
    self._GridCompnentClass = nil
    self._gridList = nil
    self._selectedGrid = nil
    self._touchBeganPosition_ = nil

    ListView.super.dtor(self)
end

-- public:
-- 初始化
function ListView:init(GridCompnentClass, columnCount, rowCount, gridWith, gridHeight, horizontalSpace, verticalSpace, paddingSpace, isNoGet, showEquipComp)
    assert(type(GridCompnentClass) == "table", "ListView constructor: Grid Component is invalid.")
    if (columnCount) then assert(type(columnCount) == "number", "[ERROR] BagGridList constructor: column count is invalid.") end
    if (rowCount) then assert(type(rowCount) == "number", "[ERROR] BagGridList constructor: row count is invalid.") end
    if (gridWith) then assert(type(gridWith) == "number", "[ERROR] BagGridList constructor: grid width is invalid.") end
    if (gridHeight) then assert(type(gridHeight) == "number", "[ERROR] BagGridList constructor: grid height is invalid.") end
    if (horizontalSpace) then assert(type(horizontalSpace) == "number", "[ERROR] BagGridList constructor: horizontal space is invalid.") end
    if (verticalSpace) then assert(type(verticalSpace) == "number", "[ERROR] BagGridList constructor: vertical space is invalid.") end
    if (paddingSpace) then assert(type(paddingSpace) == "number", "[ERROR] BagGridList constructor: padding space is invalid.") end

    self._GridCompnentClass = GridCompnentClass
    self._columnCount = columnCount or 0
    self._rowCount = rowCount or 0
    self._gridWidth = gridWith or 0
    self._gridHeight = gridHeight or 0
    self._horizontalSpace = horizontalSpace or 0
    self._verticalSpace = verticalSpace or 0
    self._paddingSpace = paddingSpace or 0
    self._isNoGet = isNoGet
    self._showEquipComp = showEquipComp

    ListView.super.init(self)

    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, onListViewTouchBeganHandler)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, onListViewTouchMovedHandler)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, onListViewTouchEndedHandler)
end

-- 初始化视图
function ListView:onInitView()
    local totalCount = self._rowCount * self._columnCount
    if (totalCount > 0) then
        local GridCompnentClass = self._GridCompnentClass
        for i = 1, totalCount do 
            if self.createBg and self.bgImageStr then
                local bg = UI.Image:create();
                bg:init(self.bgImageStr)
                self:addChild(bg)
                table.insert(self.bgImageList, bg)
            end
            local grid = GridCompnentClass:create()
            grid:init()
            if(grid.setCountFlag) then 
                grid:setCountFlag(self.countFlag)
            end
            grid:setSize(self._gridWidth, self._gridHeight)
            grid:setIndex(self._gridCount + 1)
            if grid.showInfoArea then
                grid:showInfoArea(self._isNoGet, self._showEquipComp)
            end
            self:addChild(grid)

            table.insert(self._gridList, grid)
            self._gridCount = self._gridCount + 1
        end
    end
end

-- 更新视图
function ListView:onUpdateView()
    local gridList = self._gridList
    local gridCount = self._gridCount
    local columnCount = self._columnCount
    local rowCount = self._rowCount

    -- 更新尺寸
    local width, height = 0, 0
    if (columnCount > 0) then width = columnCount * self._gridWidth + (columnCount - 1) * self._horizontalSpace + 2 * self._paddingSpace 
    end
    if (rowCount > 0) then height = rowCount * self._gridHeight + (rowCount - 1) * self._verticalSpace + 2 * self._paddingSpace 
    end
    self:setSize(width, height)

    -- 更新坐标
    if (gridCount) then
        for i = 1, gridCount do
            local rowIndex, columnIndex = 0, 0
            if (columnCount >= 1) then
                rowIndex = math.ceil(i / columnCount)
                columnIndex = i - (rowIndex - 1) * columnCount
            end
            local posX = (columnIndex - 1) * (self._gridWidth + self._horizontalSpace) + self._paddingSpace
            local posY = ((rowIndex - 1) * self._verticalSpace + (rowIndex - 1) * self._gridHeight + self._paddingSpace)
            -- local posY = 0
            -- if rowIndex - 1 ~= 0 then
            --     posY = ((rowIndex - 1) * self._verticalSpace + (rowIndex - 1) * self._gridHeight + self._paddingSpace)
            -- end
            local listGrid = gridList[i]
            listGrid:setPos(posX, posY)

            local bgImage = self.bgImageList[i]
            if bgImage then
                bgImage:setPos(posX, posY)
            end
            if (DEBUG) then
                print(string.format("ListView onUpdateView: list grid pos: %f %f.", posX, posY))
            end
        end
    end

    if (DEBUG) then
        print(string.format("ListView onUpdateView: list view size: %f %f.", width, height))
    end
end

-- 创建所有的格子
function ListView:createGridList(rowCount, columnCount)
    assert(type(rowCount) == "number" and rowCount >= 0, "ListView createGridList: row count is invalid.")
    assert(type(columnCount) == "number" and columnCount >= 0, "ListView createGridList: column count is invalid.")

    -- 先清理旧的格子列表
   self:clear(true)

    -- 创建新的格子
    self._rowCount = rowCount
    self._columnCount = columnCount

    local totalCount = self._rowCount * self._columnCount
    if (totalCount > 0) then
        local GridCompnentClass = self._GridCompnentClass
        for i = 1, totalCount do 
            local grid = GridCompnentClass:create()
            grid:init()
            grid:setSize(self._gridWidth, self._gridHeight)
            grid:setIndex(self._gridCount + 1)
            self:addChild(grid)
            if(grid.setCountFlag) then 
                grid:setCountFlag(self.countFlag)
            end

            table.insert(self._gridList, grid)
            self._gridCount = self._gridCount + 1
        end
    end
end

-- 添加新的格子
function ListView:addGridsByRow(newRowCount)
    assert(type(newRowCount) == "number", "ListView addGridsByRow: row count is invalid.")

    self._rowCount = self._rowCount + newRowCount

    local newCount = newRowCount * self._columnCount
    if (newCount > 0) then
        local GridCompnentClass = self._GridCompnentClass
        for i = 1, newCount do 
            local grid = GridCompnentClass:create()
            grid:init()
            grid:setSize(self._gridWidth, self._gridHeight)
            grid:setIndex(self._gridCount + 1)
            self:addChild(grid)
            if(grid.setCountFlag) then 
                grid:setCountFlag(self.countFlag)
            end

            table.insert(self._gridList, grid)
            self._gridCount = self._gridCount + 1
        end
    else
        for i = newCount, -1 do
            local index = self._gridCount 
            local grid = self._gridList[index]
            grid:destroy()
            
            self._gridList[index] = nil
            self._gridCount = self._gridCount - 1
        end
    end
end

-- 创建格子
function ListView:createGridListByDataList(dataList)
    assert(dataList, "ListView createGridListByDataList: data list in invalid.")

    -- 先清理旧的格子列表
    self:clear(true)

    -- 创建新的格子列表
    local totalCount = #dataList
    if (totalCount > 0) then
        local GridCompnentClass = self._GridCompnentClass
        for i = 1, totalCount do 
            if self.createBg and self.bgImageStr then
                local bg = UI.Image:create();
                bg:init(self.bgImageStr)
                self:addChild(bg)
                table.insert(self.bgImageList, bg)
            end

            local grid = GridCompnentClass:create()
            grid:init()
            grid:setData(dataList[i])
            grid:setSize(self._gridWidth, self._gridHeight)
            grid:setIndex(self._gridCount + 1)
            self:addChild(grid)
            if(grid.setCountFlag) then 
                grid:setCountFlag(self.countFlag)
            end

            table.insert(self._gridList, grid)
            self._gridCount = self._gridCount + 1
            self._usedGridCount = self._usedGridCount + 1
        end

        if (self._columnCount > 0) then
            self._rowCount = math.ceil(totalCount / self._columnCount)
        else
            assert(false)
        end
    end
end

-- 添加格子
function ListView:addGrid(gridData)
    assert(gridData, "ListView addGrid: grid data is invalid.")

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

-- 获取背包格子
function ListView:getGridByIndex(index)
    assert(type(index) == "number" and index >= 1, "ListView getGridByIndex: index is invalid.")

    if (index <= self._gridCount) then
        return self._gridList[index]
    else
        return nil
    end
end

-- 根据坐标获取格子
function ListView:getGridByPosition(globalPosition)
    return getGridByPosition(self, globalPosition)
end

-- 获取所有格子列表
function ListView:getGridList()
    return self._gridList
end

-- 启用格子拖拽
function ListView:enableToDragGrid()
    self._enableToDrag = true
end

-- 关闭格子拖拽
function ListView:disableToDragGrid()
    self._enableToDrag = false
end

-- 清理所有格子
function ListView:clear(removed)
    if (removed) then assert(type(removed) == "boolean", "ListView clear: removed flag is invalid.")
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
function ListView:checkGridDraged(selectedGrid, startPosition, endPosition)
    if (not selectedGrid:isEmpty()) then
        local distance = cc.pGetDistance(
            startPosition,
            endPosition
        )
        return distance >= COMPONENT_DRAG_DISTANCE
    end
    return false
end

-- 启用双击
function ListView:enableToDoubleClick()
    self._enableToDoubleClick = true
end

-- 禁用双击
function ListView:disableToDoubleClick()
    self._enableToDoubleClick = false
end

function ListView:enableCreateBg(enable, bgImageStr)
    self.createBg = enable
    self.bgImageStr = bgImageStr
end

function ListView:setCountFlag(flag)
    self.countFlag = flag
    if(self._gridList) then 
        for k,grid in ipairs(self._gridList) do 
            if(grid.setCountFlag) then 
                grid:setCountFlag(self.countFlag)
            end
        end
    end
end
