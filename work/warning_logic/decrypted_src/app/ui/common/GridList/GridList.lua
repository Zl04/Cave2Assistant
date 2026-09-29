--[[
    UI - 背包格子列表（带滚动功能）
]]--

require "app.ui.Component"
require "app.ui.common.List.ListView"
require "app.ui.common.ScrollView"

UI = UI or {}

local GridList = class("GridList", UI.HWBtnComponent)
UI.GridList = GridList

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0 
-- 资源
local RES_LIST = nil

-- 检测点击坐标是否在scrollview的范围内
local function checkGridTouch(self, touchPosition)
    if (self._scrollView) then
        return self._scrollView:checkTouchPosition(touchPosition)
    end
    return false
end

-- 背包格子拖拽开始的处理器
local function onGridDragBeganHandler(self, grid, touchPosition)
    if (not checkGridTouch(self, touchPosition)) then return end

    -- 生成拖拽的视图
    self._draggedGrid = grid:createDraggedView()
    if (self._draggedGrid) then
        -- 将可拖拽的视图添加到根节点上
        local rootLayer = UI.UIManager:getRootNode()--UI.UIManager.mActivityLayer--
        rootLayer:addChild(self._draggedGrid, UI.MAX_Z_ORDER)

        -- 设置初始坐标
        local rootLayerLocalPosition = rootLayer:convertToNodeSpace(touchPosition)
        local gridLocalPosition = grid:convertToNodeSpace(touchPosition)
        
        self._draggedGrid:leftBottom(
            rootLayerLocalPosition.x - gridLocalPosition.x, 
            rootLayerLocalPosition.y
        )
        self._girdLocalPosition = gridLocalPosition
        -- self._draggedGrid:leftBottom(
        --     rootLayerLocalPosition.x, 
        --     rootLayerLocalPosition.y
        -- )

        require("app.ui.common.GoodsList.DragFingerAnimation")
        local dragAnimation = UI.DragFingerAnimation:create()
        dragAnimation:init()
        -- local dragAnimation = UI.Animation:create()
        -- dragAnimation:init("effect_ui_common_drag_finger.json", "effect_ui_common_drag_finger.atlas")
        -- dragAnimation:setAnimation("begin",false)
        -- dragAnimation:setAnimation("idle",true)
        dragAnimation:centerUp(-30)
        dragAnimation:setName("drag_finger")
        self._draggedGrid:addChild(dragAnimation)
        self._dragAnimation = dragAnimation

        -- 禁用滚动
        self._scrollView:disableScrolling()
        -- 隐藏图标
        grid:hideIcon()

        -- 调用回调函数
        if (self._targetForDragBegan and self._functionForDragBegan) then
            self._functionForDragBegan(self._targetForDragBegan, grid, touchPosition)
        end
    end
end

-- 背包格子拖拽的处理器
local function onGridDragMovedHandler(self, grid, touchPosition)
    if (self._draggedGrid) then
        -- dump(grid, "----------grid---------------")
        -- 更新拖拽的坐标
        local rootLayer = UI.UIManager:getRootNode()--UI.UIManager.mActivityLayer--
        local rootLayerLocalPosition = rootLayer:convertToNodeSpace(touchPosition)
        local gridLocalPosition = grid:convertToNodeSpace(touchPosition)
        self._draggedGrid:leftBottom(
            rootLayerLocalPosition.x - self._girdLocalPosition.x, 
            rootLayerLocalPosition.y
        )
        -- self._draggedGrid:leftBottom(
        --     rootLayerLocalPosition.x, 
        --     rootLayerLocalPosition.y
        -- )

        -- 调用回调函数
        if (self._targetForDragMoved and self._functionForDragMoved) then
            self._functionForDragMoved(self._targetForDragMoved, grid, touchPosition)
        end
    end
end

-- 背包格子拖拽结束的处理器
local function onGridDragEndedandler(self, grid, touchPosition)
    if (self._draggedGrid) then
        -- 是否从列表中删除格子
        local removed = false

        -- 调用回调函数（返回值：是否删除格子）
        if (self._targetForDragEnded and self._functionForDragEnded) then 
            removed = self._functionForDragEnded(self._targetForDragEnded, grid, touchPosition)
        end
        if (removed) then 
            -- 删除格子
            self:removeGrid(grid:getData())
        else
            -- 隐藏图标
            grid:showIcon()
        end

        -- 销毁拖拽视图
        self._draggedGrid:destroy()
        self._draggedGrid = nil

        -- 启用滚动
        self._scrollView:enableScrolling()
    end
end

-- 点击格子的处理器
local function onGridClickHandler(self, grid, touchPosition)
    if (not checkGridTouch(self, touchPosition)) then return end

    if (not grid:isEmpty()) then
        -- 显示格子被点击的效果
        if (self._selectedGrid) then 
            self._selectedGrid:hideSelect() 
        end
        self._selectedGrid = grid

        if(grid and grid:isClickShowInfo()) then 
            grid:showSelect()
            -- 调用回调函数
            if (self._targetForGridClick and self._functionForGridClick) then
                self._functionForGridClick(self._targetForGridClick, grid, touchPosition)
            end
        end
    end
end

-- 双击格子的处理器
local function onGridDoubleClickHandler(self, grid, touchPosition)
    if (not checkGridTouch(self, touchPosition)) then return end

    if (not grid:isEmpty()) then
        -- 显示格子被点击的效果
        if (self._selectedGrid) then self._selectedGrid:hideSelect() end
        self._selectedGrid = grid
        grid:showSelect()

        -- 调用回调函数
        if self.doubleClickAsDragEnd then
            local removed = false
            -- 调用回调函数（返回值：是否删除格子）
            if (self._targetForDragEnded and self._functionForDragEnded) then 
                removed = self._functionForDragEnded(self._targetForDragEnded, grid, cc.p(-10000, -10000))
            end
            if (removed) then 
                -- 删除格子
                self:removeGrid(grid:getData())
            else
                -- 隐藏图标
                grid:showIcon()
            end
        else
            if (self._targetForGridDoubleClick and self._functionForGridDoubleClick) then
                self._functionForGridDoubleClick(self._targetForGridDoubleClick, grid)
            end
        end
    end
end

-- 构造函数
function GridList:ctor()
    self.doubleClickAsDragEnd = false
    -- 滚动视图组件
    self._scrollView = nil
    -- 列表组件
    self._gridList = nil
    -- 列表数据
    self._gridDataList = nil

    -- 当前被选中的格子
    self._selectedGrid = nil
    -- 被拖拽的格子
    self._draggedGrid = nil
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
    self._targetForGridDoubleClick = nil
    self._functionForGridDoubleClick = nil

    GridList.super.ctor(self, UI.GRID_LIST, RES_LIST, COM_WIDTH, COM_HEIGHT)
end

-- 析构函数
function GridList:dtor()
    GridList.super.dtor(self)

    if(self._draggedGrid) then
        -- self._draggedGrid:destroy()
        self._draggedGrid:setVisible(false)
        self._draggedGrid = nil
    end
end

-- public:
-- 初始化
function GridList:init(GridComponent,
    columnCount, rowCount,
    gridWidth, gridHeight,
    horizontalSpace, verticalSpace, paddingSpace)
    GridList.super.init(self, GridComponent, columnCount, rowCount, gridWidth, gridHeight, horizontalSpace, verticalSpace, paddingSpace)
end

-- 初始化视图
function GridList:onInitView(GridComponent, columnCount, rowCount, gridWidth, gridHeight, horizontalSpace, verticalSpace, paddingSpace)
    -- 背包列表
    local gridList = UI.ListView:create()
    if self.bEnableCreateBg then
        gridList:enableCreateBg(self.bEnableCreateBg, self.bgImageStr);
    end
    gridList:init(GridComponent, 
        columnCount, rowCount,
        gridWidth, gridHeight, 
        horizontalSpace, verticalSpace, paddingSpace
    )
    gridList:disableToDoubleClick()
    gridList:setSwallowTouches(false)
    gridList:enableToDragGrid()
    gridList:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_BEGAN, self, onGridDragBeganHandler)
    gridList:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_MOVED, self, onGridDragMovedHandler)
    gridList:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_ENDED, self, onGridDragEndedandler)
    gridList:addEventListener(UIEvent.LIST_VIEW_GRID_CLICK, self, onGridClickHandler)
    gridList:addEventListener(UIEvent.LIST_VIEW_GRID_DOUBLE_CLICK, self, onGridDoubleClickHandler)
    gridList.checkGridDraged = function(self, selectedGrid, startPosition, endPosition)
        if (selectedGrid and not selectedGrid:isEmpty()) then
            local localPosition = selectedGrid:convertToNodeSpace(endPosition)
            local size = selectedGrid:getContentSize()

            if (localPosition.x >= 0 and 
                localPosition.y >= 0 and 
                localPosition.x <= size.width and 
                localPosition.y <= size.height) then
                local offsetX = math.abs(startPosition.x - endPosition.x)
                local offsetY = math.abs(startPosition.y - endPosition.y)
                if (offsetX > 0) then
                    if (offsetY > 0) then 
                        return (offsetX / offsetY) >= 1.0
                    else
                        return true
                    end
                end
            end
            return false
        end
    end
    self._gridList = gridList
    
    -- 滚动视图
    local scrollView = UI.ScrollView:create()
    scrollView:init(0, 0, 0, 0)
    scrollView:centerLeft(16)
    scrollView:setTouchEnable(true)
    scrollView:addInnerNode(gridList)
    self:addChild(scrollView)
    self._scrollView = scrollView
end

function GridList:getGridList()
    return self._gridList:getGridList()
end

-- 设置列表数据
function GridList:setData(gridDataList)
    self._selectedGrid = nil
    if(self._draggedGrid) then
        self._draggedGrid:destroy()
        self._draggedGrid = nil
    end
    self._gridDataList = gridDataList
    self._gridList:createGridListByDataList(gridDataList)
    self._gridList:updateView()
end

-- 删除一个格子
function GridList:removeGrid(gridData)
    if (self._gridDataList) then
        for i = 1, #self._gridDataList do
            local _gridData = self._gridDataList[i]
            if (_gridData == gridData) then
                table.remove(self._gridDataList, i)
                self._gridList:createGridListByDataList(self._gridDataList)
                self._gridList:updateView()

                break;
            end
        end
    end
end

-- 设置尺寸
function GridList:setSize(width, height)
    self._scrollView:setSize(width, height)
    GridList.super.setSize(self, width, height)
end

-- 添加拖拽格子开始的处理回调函数
function GridList:setCallbackForGridDragBegan(target, func)
    self._targetForDragBegan = target
    self._functionForDragBegan = func
end

-- 添加拖拽格子的处理回调函数
function GridList:setCallbackForGridDragMoved(target, func)
    self._targetForDragMoved = target
    self._functionForDragMoved = func
end

-- 添加拖拽格子完成的处理回调函数
function GridList:setCallbackForGridDragEnded(target, func)
    self._targetForDragEnded = target
    self._functionForDragEnded = func
end

-- 添加点击个字的处理回调函数
function GridList:setCallbackForGridClick(target, func)
    self._targetForGridClick = target
    self._functionForGridClick = func
end

-- 添加双击格子的处理回调函数
function GridList:setCallbackForGridDoubleClick(target, func)
    self._targetForGridDoubleClick = target
    self._functionForGridDoubleClick = func
end

function GridList:setDoubleClickAsDragEnd(enable)
    self.doubleClickAsDragEnd = enable
    if CONFIG_DOUBLIE_CLICK then
        if enable then
            self._gridList:enableToDoubleClick()
        else
            self._gridList:disableToDoubleClick()
        end
    end
end

function GridList:scrollToTop()
    if(self._scrollView) then 
        self._scrollView:scrollToTop()
    end 
end

function GridList:setScrollBarEnabled(enabled)
    if(self._scrollView) then 
        self._scrollView:setScrollBarEnabled(enabled)
    end 
end

function GridList:setScrollBarWidth(width)
    if(self._scrollView) then 
        self._scrollView:setScrollBarWidth(width)
    end 
end

function GridList:setScrollBarColor(color)
    if(self._scrollView) then 
        self._scrollView:setScrollBarColor(color)
    end
end

function GridList:setScrollBarOpacity(opacity)
    if(self._scrollView) then 
        self._scrollView:setScrollBarOpacity(opacity)
    end 
end

function GridList:setCircleVisible(visible)
    if(self._scrollView) then 
        self._scrollView:setCircleVisible(visible)
    end
end

function GridList:scrollToBottom()
    if(self._scrollView) then 
        self._scrollView:scrollToBottom()
    end 
end

function GridList:setBounceEnabled(enable)
    if(self._scrollView) then 
        self._scrollView:setBounceEnabled(enable)
    end 
end

function GridList:scrollToPercentVertical(percent)
    if(self._scrollView) then 
        self._scrollView:scrollToPercentVertical(percent)
    end
end

-- 启用格子拖拽
function GridList:enableToDragGrid()
    if(self._gridList) then 
        self._gridList:enableToDragGrid()
    end 
end

-- 关闭格子拖拽
function GridList:disableToDragGrid()
    if(self._gridList) then 
        self._gridList:disableToDragGrid()
    end 
end

function GridList:enableCreateBg(enable, bgImageStr)
    self.bEnableCreateBg = enable
    self.bgImageStr = bgImageStr
    if self._gridList then
        self._gridList:enableCreateBg(enable, bgImageStr)
    end
end

-- 修改是否处于放置中间
function GridList:changeInSideStatus(inSide)
    if(not tolua.isnull(self._dragAnimation)) then
        self._dragAnimation:changeInSideStatus(inSide)
    end
end