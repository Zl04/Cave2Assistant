--[[
    幻化滚动页面
    by CMonk

    进度备注: 滚动加载和卸载还未完成, 现在处于滚动加载和延迟卸载的混合阶段, 目前进度:
        延迟加载 - 向下滚动加载 (需要和向下卸载一起做向上滚动加载)
        延迟卸载 - 关闭时延迟卸载 (需要做上下滚动卸载)
    滚动加载卸载完成过后可以保证顺滑, 并且加入单位复用降低内存消耗.
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.datas.EquipIllusionDataManager"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local EquipIllusionCellView = require("app.ui.equipIllusionLayer.EquipIllusionCellView")

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local EquipIllusionListPanel = class("EquipIllusionListPanel", UI.HWBtnComponent)
UI.EquipIllusionListPanel = EquipIllusionListPanel


local SCROLL_WIDTH = 300
local SCROLL_HEIGHT = 400
local SCROLL_CONTENT_TOP_PADDING = 10
local ENTRY_HEIGHT = 67
local DELAY_INIT_INTERVAL = 0
local DELAY_INIT_STEP = 1
---------------------------------------
-- eo 模块初始化 --






-- 资源统合 --
---------------------------------------
---------------------------------------
-- eo 资源统合 --




-- 生命周期 --
---------------------------------------
-- 构造函数
function EquipIllusionListPanel:ctor(host)
    EquipIllusionListPanel.super.ctor(
        self, 
        UIType.SETTINGS_BASIC_PANEL,
        COM_RES_LIST,
        0, -- 这里的大小不起作用, 背景图加载过后会重新设置
        0)
    self._hostLayer = host
    self:registerListener()
end

-- 析构函数
function EquipIllusionListPanel:dtor()
    EquipIllusionListPanel.super.dtor(self)
    -- reload_script_file("app.ui.equipIllusionLayer.EquipIllusionListPanel")
    -- reload_script_file("app.ui.equipIllusionLayer.EquipIllusionCellView")

    self:unregisterListener()
end

-- 初始化
function EquipIllusionListPanel:init(equipType, width, height)
    self:setSize(width, height)

    -- 显示类型
    self._equipType = equipType or 0

    -- 内容数据结构
    self._groupList = {}

    -- 勾选了的数据选项
    self._trialEntryTableByIllusionID = {}

    -- 是否为只显示特殊外观物品
    self._displaySpecialItemsOnly = false

    EquipIllusionListPanel.super.init(self)
end

-- 表现初始化
function EquipIllusionListPanel:onInitView(...)
    EquipIllusionListPanel.super.onInitView(self, ...)

    -- 列表
    self._tableView = UI.TableView:create({}, SCROLL_WIDTH + 12, SCROLL_HEIGHT)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftBottom(533, 63)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:setScrollBarEnabled(true)
    self._tableView:setCircleVisible(false)
    self._tableView:onUpdateCellSize(function (tableview, idx)
        local luaIdx = idx + 1
        return self:getTableCellSizeForIdx(luaIdx)
    end) 
    self._tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell == nil then
            xpcall(function()
                cell = UI.TableViewCell:create()
        
                local cellView = EquipIllusionCellView:create()
                cellView:init()
                cellView:leftBottom(0, 0)
                cellView:setName("cellView")
                cell:addChild(cellView)
            end, 
            function(e) 
                printError("------------------------ActivityPanel:tableCellAtIndex-----------------error", e)
            end, 1)
        end

        local cellView = cell:getChildByName("cellView")
        if (cellView) then
            local cellWidth, cellHeight = self:getTableCellSizeForIdx(luaIdx)
            cell:setContentSize(cellWidth, cellHeight)
            cellView:setSize(cellWidth, cellHeight)
            cellView:updateCallback(function(callbackType, itemIdx, isChecked)
                if (callbackType == 1) then
                    self:setItemCheckStatus(luaIdx, itemIdx, isChecked)
                elseif (callbackType == 2) then
                    local currentEntry = self._groupList[luaIdx]
                    currentEntry.isExpandedLastTime = currentEntry.isExpanded
                    currentEntry.isExpanded = isChecked
                    self:reloadDataAndView()
                end
            end)
            cellView:updateData(self._groupList[luaIdx])
        end
        return cell
    end)

    self._tableView:onUpdateCellNumbers(function()
        return #self._groupList
    end)
    self:addChild(self._tableView)
    self._tableView:reloadData()

    self._touchCover = UI.Component:create()
    self._touchCover:init()
    self._touchCover:setSize(self._tableView:getSize())
    self._touchCover:leftBottom(self._tableView._left, self._tableView._bottom)
    self._touchCover:setTouchEnable(true)
    self._touchCover:setSwallowTouches(false)
    self:addChild(self._touchCover)
end

-- updateView只更新状态, 不会刷新数据, 保证操作顺畅. 重新加载数据使用 reloadDataAndView
function EquipIllusionListPanel:onUpdateView(isScrollToTop)
    if (self._uninitStarted) then return end
    self._tableView:reloadData()

    if (isScrollToTop) then
        self._tableView:scrollToTop()
        self._tableView:stopScrolling()
    end
end
---------------------------------------
-- eo 生命周期 --





-- 通用逻辑 --
---------------------------------------
-- 获取表格大小
function EquipIllusionListPanel:getTableCellSizeForIdx(idx)
    local groupEntry = self._groupList[idx]
    if (not groupEntry) then 
        return EquipIllusionCellView.CELL_WIDTH, EquipIllusionCellView.CELL_HEIGHT
    end

    if (groupEntry.isExpanded) then
        return EquipIllusionCellView.CELL_WIDTH, EquipIllusionCellView.CELL_HEIGHT * (#groupEntry.itemList + 1)
    else
        return EquipIllusionCellView.CELL_WIDTH, EquipIllusionCellView.CELL_HEIGHT
    end
end

-- 设置是否只显示特殊外观
function EquipIllusionListPanel:setDisplaySpecialItemsOnly(b)
    self._displaySpecialItemsOnly = b
    self:reloadDataAndView(nil, nil, nil, true)
end

-- 重新加载数据并更新视图, 会清除所有扩展和滚动位置
function EquipIllusionListPanel:reloadDataAndView(trialEntryTable, equipType, isInitReload, isGetNewDisplayData)
    -- 初始化过后才能加载数据, 否则其他的加载都不做任何事情
    if (isInitReload) then self._isInitReload = true end
    if (not self._isInitReload) then return end

    -- 更新数据
    local isScrollToTop = false
    if (equipType) then self._equipType = equipType end
    if (isInitReload or isGetNewDisplayData) then
        self._groupList = EquipIllusionDataManager:getInfoForDisplayByEquipmentType(self._equipType, self._displaySpecialItemsOnly)
        isScrollToTop = true
    end

    -- 并入试穿数据
    self:reloadTrialData(trialEntryTable)

    -- 刷新列表
    self:updateView(isScrollToTop)
end

-- 并入试穿数据
function EquipIllusionListPanel:reloadTrialData(trialEntryTable)
    if (trialEntryTable) then self._trialEntryTableByIllusionID = trialEntryTable end
    if (self._trialEntryTableByIllusionID) then
        for i,groupEntry in ipairs(self._groupList) do
            for i,itemEntry in ipairs(groupEntry.itemList) do
                if (self._trialEntryTableByIllusionID[itemEntry.itemIllusionID]) then
                    itemEntry.itemIsChecked = true
                else
                    itemEntry.itemIsChecked = false
                end
            end
        end
    end
end

-- 设置某个装备的勾选框
function EquipIllusionListPanel:setItemCheckStatus(groupIdx, itemIdx, isChecked)
    local groupEntry = self._groupList[groupIdx]
    if (not groupEntry or not groupEntry.itemList) then return end

    -- 创建更新列表
    local itemEntryList = {}
    if (itemIdx) then
        local itemEntry = groupEntry.itemList[itemIdx]
        if (itemEntry) then
            table.insert(itemEntryList, itemEntry)
        end
    else
        local equipTypesAlreadyChecked = {}
        for j,itemEntry in ipairs(groupEntry.itemList) do
            if (itemEntry.itemIsUnlocked and AvalonUtil.equipTypesAndDuplicationFilter(itemEntry.itemEquipID)) then
                local equipTypeToCheck = AvalonUtil.getEquipmentTypeFromID(itemEntry.itemEquipID)
                if (not equipTypesAlreadyChecked[equipTypeToCheck]) then
                    equipTypesAlreadyChecked[equipTypeToCheck] = true
                    table.insert(itemEntryList, itemEntry)
                end
            end
        end
    end

    for i,itemEntry in ipairs(itemEntryList) do
        -- 清除新标签
        EquipIllusionDataManager:setIllusionIsNew(itemEntry.itemIllusionID, false)

        -- 添加和取消试穿
        if (isChecked) then
            self:addItemEntry(itemEntry)
        else
            self:removeItemEntry(itemEntry)
        end
    end

    -- 更新展示
    self._hostLayer:updateView()
end

-- 通过数据添加一个装备到试穿
function EquipIllusionListPanel:addItemEntry(itemEntry)
    self._hostLayer:addTrialEquipData(itemEntry)
end

-- 通过数据移除一个装备到试穿
function EquipIllusionListPanel:removeItemEntry(itemEntry)
    self._hostLayer:removeTrialEquipData(itemEntry)
end

-- 设置一个幻化ID的购买状态
function EquipIllusionListPanel:setBoughtForIllusionID(illusionId, isBought)
    for i,groupEntry in ipairs(self._groupList) do
        for i,itemEntry in ipairs(groupEntry.itemList) do
            if (itemEntry.itemIllusionID == illusionId) then
                itemEntry.itemIsBought = isBought
            end
        end
    end
end
---------------------------------------
-- eo 通用逻辑 --







-- 事件处理 --
---------------------------------------

function EquipIllusionListPanel:registerListener()
end

function EquipIllusionListPanel:unregisterListener()

end
---------------------------------------
-- eo 事件处理 --