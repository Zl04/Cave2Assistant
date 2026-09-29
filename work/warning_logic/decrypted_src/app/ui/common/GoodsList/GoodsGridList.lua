--[[
    UI - 背包格子列表
]]--

require "app.ui.Component"

UI = UI or {}

local GoodsGridList = class("GoodsGridList", UI.ListView)
UI.GoodsGridList = GoodsGridList

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 更新背包格子的处理器
local function onUpdateBagGridHandler(self, goodsDataId)
    -- print(string.format("GoodsGridList onUpdateBagGridHandler: goods data id %d.", goodsDataId))
    if(self._refreshFlag) then 
        if (self._dataList) then
            for i = 1, self._gridCount do
                local bagGrid = self._gridList[i]
                if (bagGrid:isUsed()) then
                    local goodsData = bagGrid:getData()
                    if (goodsData:getGoodsID() == goodsDataId) then
                        local isVisible = bagGrid:isIconVisible()
                        bagGrid:updateView()
                        if (isVisible) then
                            bagGrid:showIcon()
                        else
                            bagGrid:hideIcon()
                        end
                    end
                end 
            end
        end
    end
end

-- 构造函数
function GoodsGridList:ctor()
    GoodsGridList.super.ctor(self, UIType.GOODS_GRID_LIST)

    -- 背包可用的格子数量
    self._availableCount = 0
    -- 背包最大的格子数量
    self._maxCount = 0
    -- 可见的格子数量
    self._visibleMaxCount = 0
    -- 可见的行数
    self._visibleRowCount = 0
    -- 目前真正的行数
    self._realRowCount = 0

    -- 数据列表
    self._dataList = nil
    self._selectedIndex = 0
    self._selectedGoodsData = nil

    self._refreshFlag = true

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_GOODSDATA_REFRESH, self, onUpdateBagGridHandler)
end

-- 析构函数
function GoodsGridList:dtor()
    self._dataList = nil
    self._gridList = nil
    self._activeBagGrid = nil

    Avalon.MessageCenter:unbindForTarget(self)

    GoodsGridList.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_GOODSDATA_REFRESH, self, onUpdateBagGridHandler)
end

-- public:
-- 初始化
function GoodsGridList:init(GridComponent, columnCount, rowCount, gridWith, gridHeight, horizontalSpace, verticalSpace, paddingSpace)
    print("GoodsGridList init:")

    self._availableCount = 0
    self._maxCount = columnCount * rowCount
    self._clickTime = 0

    GoodsGridList.super.init(self, GridComponent, columnCount, rowCount, gridWith, gridHeight, horizontalSpace, verticalSpace, paddingSpace)

    self:setSwallowTouches(false)
    self:enableToDragGrid()
end

-- 初始化视图
function GoodsGridList:onInitView()

end

-- 更新视图
function GoodsGridList:onUpdateView()
    GoodsGridList.super.onUpdateView(self)

    local visibleHeight = 0
    local visibleRowCount = self._visibleRowCount
    if (visibleRowCount > 0) then visibleHeight = visibleRowCount * self._gridHeight + (visibleRowCount - 1) * self._verticalSpace + 2 * self._paddingSpace
    end
    self:setSize(self._width, visibleHeight)
end

function GoodsGridList:setRefreshFlag(flag)
    if(flag == true) then 
        self._refreshFlag = flag
    else 
        self._refreshFlag = false
    end
end

-- 增加背包格子
function GoodsGridList:addGridCount(availableCount, maxCount, callback)
    assert(type(availableCount) == "number" and availableCount >= 0, "GoodsGridList setMaxGridCount: count is invalid.")
    assert(type(maxCount) == "number" and maxCount >= 0, "GoodsGridList setMaxGridCount: count is invalid.")
    assert(maxCount >= availableCount, "GoodsGridList setGridCount: max count should be greater than available coutn.")
    if (DEBUG) then
        print(string.format("GoodsGridList setGridCount: available count:%d, max count:%d.", availableCount, maxCount))
    end

    local lastRealRowCount = self._realRowCount

    local availableRowCount = math.ceil(availableCount / self._columnCount)
    local maxRowCount = math.ceil(maxCount / self._columnCount)
    local realRowCount = (availableRowCount + 2 > maxRowCount) and maxRowCount or (availableRowCount + 2)
    local visibleRowCount = (availableRowCount + 1 > maxRowCount) and maxRowCount or (availableRowCount + 1)
    local visibleMaxCount = realRowCount * self._columnCount
    if (visibleMaxCount >= maxCount) then
        visibleMaxCount = maxCount
    end

    self._availableCount = availableCount
    self._maxCount = maxCount
    self._visibleRowCount = visibleRowCount
    self._visibleMaxCount = visibleMaxCount
    self._realRowCount = realRowCount

    -- 添加新的格子
    local newRowCount = realRowCount - lastRealRowCount
    self:addGridsByRow(newRowCount)

    -- 设置背包格子是否可用
    local gridCount = self._gridCount
    local isCall = false
    for i = 1, gridCount do
        local bagGrid = self._gridList[i]
        -- 如果是可用格子
        if (i <= availableCount) then
            if (bagGrid:isLocked()) then
                if(isCall == false) then
                    bagGrid:unlock(callback)
                    isCall = true
                else
                    bagGrid:unlock()
                end
            end
        end
    end

    self:updateView()
end

-- 设置背包格子的最大数量
function GoodsGridList:setGridCount(availableCount, maxCount)
    assert(type(availableCount) == "number" and availableCount >= 0, "GoodsGridList setMaxGridCount: count is invalid.")
    assert(type(maxCount) == "number" and maxCount >= 0, "GoodsGridList setMaxGridCount: count is invalid.")
    assert(maxCount >= availableCount, "GoodsGridList setGridCount: max count should be greater than available coutn.")
    if (DEBUG) then
        print(string.format("GoodsGridList setGridCount: available count:%d, max count:%d.", availableCount, maxCount))
    end

    local availableRowCount = math.ceil(availableCount / self._columnCount)
    local maxRowCount = math.ceil(maxCount / self._columnCount)
    local realRowCount = (availableRowCount + 2 > maxRowCount) and maxRowCount or (availableRowCount + 2)
    local visibleRowCount = (availableRowCount + 1 > maxRowCount) and maxRowCount or (availableRowCount + 1)
    local visibleMaxCount = realRowCount * self._columnCount
    if (visibleMaxCount >= maxCount) then
        visibleMaxCount = maxCount
    end

    self._availableCount = availableCount
    self._maxCount = maxCount
    self._visibleRowCount = visibleRowCount
    self._visibleMaxCount = visibleMaxCount
    self._realRowCount = realRowCount

    -- 创建背包格子
    self:createGridList(realRowCount, self._columnCount)

    -- 设置背包格子是否可用
    local gridCount = self._gridCount
    for i = 1, gridCount do
        local bagGrid = self._gridList[i]
        bagGrid:setAvailable(i <= availableCount)
        bagGrid:updateView()
    end

    self:updateView()
end

-- 获取可用格子和总格子数量
function GoodsGridList:getAvailableAndMaxGridCount()
    return self._availableCount, self._maxCount
end

-- 背包是否已满
function GoodsGridList:isFull()
    print(string.format("GoodsGridList isFull: used grid count %d, available grid count %d.", self._usedGridCount, self._availableCount))

    if (self._usedGridCount >= self._availableCount) then return true
    end
    return false
end

-- 设置背包格子数据
function GoodsGridList:setDataList(dataList)
    assert(type(dataList) == "table", "GoodsGridList setDataList: data list is invalid.")
    if (DEBUG) then
        print(string.format("GoodsGridList setDataList: data list count %d.", #dataList))
    end
    
    self._dataList = dataList
    self._usedGridCount = 0

    local gridCount = self._gridCount
    local dataCount = #dataList
    for i = 1, gridCount do
        local bagGrid = self._gridList[i]
        bagGrid:reset()
        bagGrid:setAvailable(i <= self._availableCount)

        if (i <= dataCount) then
            if (bagGrid:isAvailable()) then
                local bagGridData = dataList[i]
                bagGrid:setData(bagGridData)

                self._usedGridCount = self._usedGridCount + 1
            else
                print(string.format("GoodsGridList setDataList: grid %d is not available.", i))
            end
        end

        bagGrid:updateView()
    end
end

-- 获取背包格子
function GoodsGridList:getBagGridByData(goodsData)
    for i = 1, self._gridCount do
        local bagGrid = self._gridList[i]
        if (bagGrid:getData() == goodsData) then
            return bagGrid
        end
    end
    return nil
end

-- 更新当个背包格子
function GoodsGridList:updateBagGrid(goodsData)
    local bagGrid = self:getBagGridByData(goodsData)
    if (bagGrid) then
        print(string.format("GoodsGridList updateBagGrid: goods data id:%d.", goodsData:getGoodsID()))

        bagGrid:updateView()
    else
        assert(false)
    end
end

-- 移除一个格子数据
function GoodsGridList:takeGoodsGrid(goodsData)
    print(string.format("GoodsGridList takeBagGrid: take one goods data %d from list. %s", goodsData:getGoodsID(), goodsData))

    local found = false
    if (goodsData and self._dataList) then
        local dataCount = #self._dataList
        for i = 1, dataCount do
            local data = self._dataList[i]
            if (goodsData == data) then
                self._selectedIndex = i
                self._selectedGoodsData = goodsData

                found = true
                break;
            end
        end
    else
        assert(false)
    end
    if (found) then
        if (self._selectedIndex <= self._gridCount) then
            local bagGrid = self._gridList[self._selectedIndex]
            bagGrid:hideIcon()
        else
            assert(false)
        end
    else
        assert(false)
    end
end

-- 将格子放回背包
function GoodsGridList:putGoodsGrid(goodsData)
    print(string.format("GoodsGridList putBagGrid: put one goods data %d into list. %s", goodsData:getGoodsID(), goodsData))

    if (goodsData and self._dataList) then
        if (self._selectedIndex >= 1 and self._selectedGoodsData == goodsData) then
            if (self._selectedIndex <= self._gridCount) then
                local bagGrid = self._gridList[self._selectedIndex]
                bagGrid:showAllIcon()
            else
                assert(false)
            end
        else
            self._dataList[#self._dataList + 1] = goodsData
            self:setDataList(self._dataList)
            self:updateView()
        end

        self._selectedIndex = 0
        self._selectedGoodsData = nil
    else
        assert(false)
    end
end

-- 移出一个格子
function GoodsGridList:removeGoodsGrid(goodsData)
    print(string.format("GoodsGridList removeGoodsGrid: remove one goods data %d into list. %s", goodsData:getGoodsID(), goodsData))

    if (goodsData) then
        for i = 1, self._dataList do
            if (self._dataList[i] == goodsData) then
                table.remove(self._dataList, i)
                break;
            end
        end
        self:setDataList(self._dataList)

        if (self._selectedGoodsData == goodsData) then 
            self._selectedIndex = 0 
            self._selectedGoodsData = nil
        end
    else
        assert(false)
    end
end

-- 拖拽格子的条件检测是否成立
function GoodsGridList:checkGridDraged(selectedGrid, startPosition, endPosition)
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


-- 禁用道具
function GoodsGridList:disable()
    self:disableToDoubleClick()
end

function GoodsGridList:showChoiceStatus()
    if (self._dataList) then
        for i = 1, self._gridCount do
            local bagGrid = self._gridList[i]
            if (bagGrid) then
                bagGrid:showChoiceStatus()
            end 
        end
    end
end

function GoodsGridList:hideChoiceStatus()
    if (self._dataList) then
        for i = 1, self._gridCount do
            local bagGrid = self._gridList[i]
            if (bagGrid) then
                bagGrid:hideChoiceStatus()
            end 
        end
    end
end

