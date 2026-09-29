-- GoodsListCell.lua
-- Author:zp
-- 2019年8月28日
-- Using:物品列表cell

require ("app.ui.activity.ActivityDetailNode")
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local GoodsListCell = class("GoodsListCell", UI.HWBtnComponent)
UI.GoodsListCell = GoodsListCell

local DEBUG = true

-- 根据全局坐标选择格子
local function getGridByPosition(self, globalPosition)
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

function GoodsListCell:ctor(GridComponent, rowCount, data, width, height, startIndex, totalCount, horizontalSpace, verticalSpace, paddingSpace, isHideUseBtn)
    self._GridCompnentClass = GridComponent
    self.rowCount = rowCount
    self._gridWidth = width
    self._gridHeight = height
    self._startIndex = startIndex
    self._availableCount = totalCount
    self._horizontalSpace = horizontalSpace or 0
    self._verticalSpace = verticalSpace or 0
    self._paddingSpace = paddingSpace or 0
    -- orizontalSpace, verticalSpace, paddingSpace
    -- self._padingSpace = padingSpace or 5
    self._data = data

    GoodsListCell.super.ctor(self, UIType.ACTIVITY, {}, (width + self._horizontalSpace) * rowCount + self._paddingSpace * 2, height + self._verticalSpace)
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

    self.isHideUseBtn = isHideUseBtn

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_UNLOCK_CELL, self, self.onUnlockCell)
end

function GoodsListCell:onEnter()
    GoodsListCell.super.onEnter(self)
    
end

function GoodsListCell:onExit()
    GoodsListCell.super.onExit(self)
    -- print("GoodsListCell:onExit")
    -- self._gridList = {}
end

function GoodsListCell:dtor()
    GoodsListCell.super.dtor(self)
    self._gridList = {}
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_UNLOCK_CELL, self, onUnlockCell)
end

function GoodsListCell:init(deleteChoiceArr)
    self.deleteChoiceArr = deleteChoiceArr
    -- self:onInitView()
    GoodsListCell.super.init(self)
    self:enableToDragGrid()
    -- self:setSwallowTouches(false)
end


-- 列表点击开始处理器
local function onListViewTouchBeganHandler(self, listView, touchPosition)
    -- print("GoodsListCell onListViewTouchBeganHandler", self._isDragging)
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
    -- print("GoodsListCell onListViewTouchMovedHandler", self._isDragging, self._enableToDrag, self._selectedGrid ~= nil)
    if (self._enableToDrag and self._selectedGrid) then
        if (self._isDragging) then
            -- 发送拖拽事件
            self:dispatchEvent(UIEvent.LIST_VIEW_GRID_DRAG_MOVED, self._selectedGrid, touchPosition)
        else
            if (self:checkGridDraged(self._selectedGrid, self._touchBeganPosition_, touchPosition)) then
                if (DEBUG) then
                    print(string.format("ListView onListViewTouchMovedHandler: start to drag grid %d.", self._selectedGrid:getIndex()))
                end
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
            if (DEBUG) then
                print(string.format("ListView onListViewTouchEndedHandler: stop dragging grid %d.", self._selectedGrid:getIndex()))
            end
            self:setSwallowTouches(false)
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

function GoodsListCell:onInitView()
    local layout = UI.Layout:create()
    layout:init()
    -- self:setSize(self._gridWidth * self.rowCount, self._gridHeight)
    layout:setSize((self._gridWidth + self._horizontalSpace) * self.rowCount + self._paddingSpace * 2, self._gridHeight + self._verticalSpace)
    self:addChild(layout)
    -- layout:enableDebugDraw()
    -- print("GoodsListCell:onInitView", self._gridWidth * self.rowCount, self._gridHeight)

    for i=1, self.rowCount, 1 do 
        local grid = self._GridCompnentClass:create()
        if grid.setIsHideUseBtn then
            grid:setIsHideUseBtn(self.isHideUseBtn)
        end
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

function GoodsListCell:onUpdateView(data, startIndex, totalCount)
    -- self._data = data or {}
    -- self._startIndex = startIndex
    -- self._availableCount = totalCount
    
    -- self:refreshView()
end

function GoodsListCell:reloadData(data, startIndex, totalCount)
    self._data = data or {}
    self._startIndex = startIndex
    self._availableCount = totalCount

    if(self._unlockIndex ~= self._startIndex) then
        for _, grid in ipairs(self._gridList) do 
            grid:removeUnlockAnimation()
        end 
    end
    -- print("GoodsListCell:reloadData, ")
    self:refreshView()
end

function GoodsListCell:setDeleteChoiceArr(deleteChoiceArr) 
    self.deleteChoiceArr = deleteChoiceArr
end

function GoodsListCell:refreshView()
    local nowIndex = self._startIndex or 0
    for k, grid in ipairs(self._gridList) do 
        -- print("GoodsListCell:refreshView, ", nowIndex, k, self._data[k] ~= nil)
        grid:setIndex(nowIndex)
        if(self._data[k]) then 
            grid:setData(self._data[k])

            self:_updataGridCanUseState(grid)
            if(self._showChoiceStatus) then 
                grid:showChoiceStatus()
            else 
                grid:hideChoiceStatus()
            end
            if(self.deleteChoiceArr) then 
                for j = 1, #self.deleteChoiceArr do
                    local goodsData = self.deleteChoiceArr[j]
                    if (goodsData == self._data[k]) then
                        grid:deleteItem()
                        break
                    end
                end
            end
        else 
            grid:reset()
            grid:setAvailable(nowIndex <= self._availableCount)
        end
        grid:updateView()
        nowIndex = nowIndex + 1
    end
end

function GoodsListCell:trySetTouchClipNode()
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
function GoodsListCell:addGrid(gridData)
    assert(gridData, "GoodsListCell addGrid: grid data is invalid.")
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
function GoodsListCell:getGridByIndex(index)
    assert(type(index) == "number" and index >= 1, "GoodsListCell getGridByIndex: index is invalid.")

    if (index <= self._gridCount) then
        return self._gridList[index]
    else
        return nil
    end
end

-- 根据坐标获取格子
function GoodsListCell:getGridByPosition(globalPosition)
    return getGridByPosition(self, globalPosition)
end

-- 获取所有格子列表
function GoodsListCell:getGridList()
    return self._gridList
end

-- 启用格子拖拽
function GoodsListCell:enableToDragGrid()
    self._enableToDrag = true
end

-- 关闭格子拖拽
function GoodsListCell:disableToDragGrid()
    self._enableToDrag = false
end

function GoodsListCell:onUnlockCell(unlockIndex)
    -- print("GoodsListCell:onUnlockCell", unlockIndex, self._startIndex)
    if(unlockIndex == self._startIndex) then 
        self._unlockIndex = unlockIndex
        for k, bagGrid in ipairs(self._gridList) do
            if (bagGrid:isLocked()) then
                -- if(isCall == false) then
                --     bagGrid:unlock(callback)
                --     isCall = true
                -- else
                    bagGrid:unlock()
                -- end
            end
        end
    end
end

-- 清理所有格子
function GoodsListCell:clear(removed)
    if (removed) then assert(type(removed) == "boolean", "GoodsListCell clear: removed flag is invalid.")
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
function GoodsListCell:checkGridDraged(selectedGrid, startPosition, endPosition)
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

-- 启用双击
function GoodsListCell:enableToDoubleClick()
    self._enableToDoubleClick = true
end

-- 禁用双击
function GoodsListCell:disableToDoubleClick()
    self._enableToDoubleClick = false
end

function GoodsListCell:enableCreateBg(enable, bgImageStr)
    self.createBg = enable
    self.bgImageStr = bgImageStr
end

function GoodsListCell:setCountFlag(flag)
    self.countFlag = flag
    if(self._gridList) then 
        for k,grid in ipairs(self._gridList) do 
            if(grid.setCountFlag) then 
                grid:setCountFlag(self.countFlag)
            end
        end
    end
end

function GoodsListCell:showChoiceStatus()
    self._showChoiceStatus = true
    if (self._gridList) then
        for k, grid in ipairs(self._gridList) do 
            grid:showChoiceStatus()
        end
    end
end

function GoodsListCell:hideChoiceStatus()
    self._showChoiceStatus = false
    if (self._gridList) then
        for k, grid in ipairs(self._gridList) do 
            grid:hideChoiceStatus()
        end
    end
end

function GoodsListCell:updataGridCanUseState(checkItemUseState, useLock, deleteState, usedType)
    self._checkItemUseState = checkItemUseState
    self._useLock = useLock
    self._deleteState = deleteState
    self._usedType = usedType
    
    if (self._gridList) then
        for k, grid in ipairs(self._gridList) do 
            self:_updataGridCanUseState(grid)
        end
    end
end

--[[
_checkItemUseState
_useLock
self._deleteState
self._usedType
]]
function GoodsListCell:_updataGridCanUseState(grid)
    local gridData = grid:getData()
    if gridData == nil then
        return
    end

    --大秘境锁 钥匙
    if GameDataManager:getInstance():getLockDungeonKey() == gridData:getGoodsID() then
        grid:updateCanUseState(false)
        return
    end
    if gridData and self._useLock == false and gridData:getIsLock() == true then
        grid:updateCanUseState(false)
    else
        if self._checkItemUseState then
            local isItem = gridData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_ITEM
            if (isItem and not grid:canUse()) then
                grid:updateCanUseState(false)
                return
            else
                grid:updateCanUseState(true)
            end
        end

        if(self._deleteState and gridData and not gridData:getIsSellOrDestory()) then 
            grid:updateCanUseState(false)
            return 
        end

        if(self._usedType == nil) then
            grid:updateCanUseState(true)
            return 
        end

        if gridData and gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
            local mark = false
            for j = 1,#self._usedType do
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
                    if self._usedType[j].type == 0 or gridData:getEquipmentType() == self._usedType[j].type then
                        if self._usedType[j].rare == nil or gridData:getGoodsRare() < self._usedType[j].rare then
                            if self._usedType[j].needConvert then
                                if Config.Manager:getEquipConvert(gridData:getId()) then
                                    mark = true 
                                end
                            elseif self._usedType[j].needRecast then
                                if gridData:getEquipRecastData() ~= nil then
                                    mark = true 
                                end
                            elseif self._usedType[j].needRemoveLevel then 
                                if(gridData:getIsRemoveLevel() and not gridData:getLvRemove()) then 
                                    mark = true
                                end
                            elseif self._usedType[j].needRefineFunc then
                                mark = self._usedType[j].needRefineFunc(gridData)
                            elseif self._usedType[j].needPurpleFunc then
                                mark = self._usedType[j].needPurpleFunc(gridData)
                            else
                                mark = true    
                            end
                            
                            break
                        end
                    end
                end
            end
            if mark == false then
                grid:updateCanUseState(false)
            else
                grid:updateCanUseState(true)
            end
        elseif gridData and gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
            local mark = false
            for j = 1,#self._usedType do
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT or self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE then
                    if self._usedType[j].type == 0 or gridData:getEquipmentType() == self._usedType[j].type then
                        if self._usedType[j].rare == nil or gridData:getGoodsRare() < self._usedType[j].rare then
                            mark = true    
                            break
                        end
                    end
                end
            end
            if mark == false then
                grid:updateCanUseState(false)
            else
                grid:updateCanUseState(true)
            end
        elseif gridData and gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM then
            local mark = false
            for j = 1,#self._usedType do
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_ITEM then
                    if self._usedType[j].type == 0 or gridData:getItemType() == self._usedType[j].type then
                        if self._usedType[j].rare == nil or gridData:getGoodsRare() < self._usedType[j].rare then
                            mark = true
                            break
                        end
                    end
                end
            end
            if mark == false then
                grid:updateCanUseState(false)
            else
                grid:updateCanUseState(true)
            end
        elseif gridData and gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
                gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
            local mark = false
            for j = 1,#self._usedType do
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
                        self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
                    if self._usedType[j].type == 0 or gridData:getMaterialType() == self._usedType[j].type then
                        if self._usedType[j].rare == nil or gridData:getGoodsRare() < self._usedType[j].rare then
                            mark = true
                            break
                        end
                    end
                end
            end
            if mark == false then
                grid:updateCanUseState(false)
            else
                grid:updateCanUseState(true)
            end
        elseif gridData and gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
            local mark = false
            for j = 1,#self._usedType do
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then

                    if self._usedType[j].onlyGemConnectView then
                        if gridData._localConfig and gridData._localConfig.connectAttrRatio and #gridData._localConfig.connectAttrRatio > 0 then
                            if (self._usedType[j].stoneShowLV == nil or self._usedType[j].stoneShowLV >= gridData:getStoneLV()) then
                                if (self._usedType[j].gemStoneType == nil or self._usedType[j].gemStoneType == gridData._localConfig.gemstoneType) then
                                    if (self._usedType[j].isEquiped == nil or self._usedType[j].isEquiped == gridData.isEquiped) then
                                        mark = true
                                    end
                                end
                            end

                            if gridData.isEquiped then
                                mark = true
                            end
                        end
                    elseif self._usedType[j].onlyGemDecomposeView then
                        if gridData._localConfig and gridData._localConfig.previousLVID and gridData._localConfig.previousLVID > 0 then
                            if (self._usedType[j].stoneShowLV == nil or self._usedType[j].stoneShowLV <= gridData:getStoneLV()) then
                                mark = true
                            end
                        end
                    else
                        if self._usedType[j].type == 0 or gridData:getGemStoneType() == self._usedType[j].type then
                            if self._usedType[j].rare == nil or gridData:getGoodsRare() < self._usedType[j].rare then
                                if(self._usedType[j].heroLevel == nil or gridData:getRequireLevel() <= self._usedType[j].heroLevel) then
                                    -- if(self._usedType[j].stoneLV == nil or gridData:getStoneLV() <= self._usedType[j].stoneLV) then
                                    if (self._usedType[j].stoneLockMaxLV == nil or gridData:getNextLVID() ~= 0) then
                                        -- print("gridData:getNextLVID() ----- = "..gridData:getNextLVID())
                                        if (self._usedType[j].stoneShowLV == nil or self._usedType[j].stoneShowLV == gridData:getStoneLV() ) then
                                            if (self._usedType[j].transDropGroupID == nil or self._usedType[j].transDropGroupID == gridData:getTransDropGroupID()) then 
                                                if (self._usedType[j].gemStoneType == nil or self._usedType[j].gemStoneType == gridData:getGemStoneType()) then 
                                                    mark = true
                                                end
                                            end
                                        end 
                                    end 
                                end
                            end
                        end
                    end
                    if mark then
                        if self._usedType[j].needCheckEquiped then 
                            if( gridData.isEquiped) then 
                                mark = false
                            end
                        end
                        break
                    end
                end
            end
            if mark == false then
                grid:updateCanUseState(false)
            else
                grid:updateCanUseState(true)
            end
        elseif gridData and gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC then
            local mark = false
            for j = 1,#self._usedType do
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_RELIC then
                    if self._usedType[j].type == 0 or gridData:getRelicType() == self._usedType[j].type then
                        if self._usedType[j].rare == nil or gridData:getGoodsRare() < self._usedType[j].rare then
                            mark = true
                            break
                        end
                    end
                end
            end
            if mark == false then
                grid:updateCanUseState(false)
            else
                grid:updateCanUseState(true)
            end
        end
    end
end