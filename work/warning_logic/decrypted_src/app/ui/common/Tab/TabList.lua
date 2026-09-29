--[[
    UI - Tab 
]]--

require "app.ui.Component"
require "app.ui.common.Tab.TabItem"

UI = UI or {}

local TabList = class("TabList", UI.HWBtnComponent)
UI.TabList = TabList

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 计算组件坐标
local function computeCompPosition(self, comp)
    local width, height = comp:getSize()

    if (self._type == UI.LayoutArrayType.HORIZONTAL) then
        local posX = self._floatInstance
        local posY = (self._height - height) / 2

        if (self._floatType == UI.LayoutFloatType.FLOAT_LEFT) then
            comp:leftBottom(posX, posY)
        elseif (self._floatType == UI.LayoutFloatType.FLOAT_RIGHT) then
            comp:rightBottom(posX, posY)
        else
            assert(false)
        end

        if (not self._isHideInvisibleTab or (self._isHideInvisibleTab and comp:isVisible())) then
            self._floatInstance = posX + width + self._intervalSpace
        end
    else
        local posX = (self._width - width) / 2
        local posY = self._floatInstance

        if (self._floatType == UI.LayoutFloatType.FLOAT_UP) then
            comp:leftBottom(posX, posY)
        elseif (self._floatType == UI.LayoutFloatType.FLOAT_BOTTOM) then
            comp:rightBottom(posX, posY)
        else
            assert(false)
        end

        if (not self._isHideInvisibleTab or (self._isHideInvisibleTab and comp:isVisible())) then
            self._floatInstance = posY + height + self._intervalSpace
        end
    end
end

-- 处理tab点击
local function onTabItemClickHandler(self, tabItem, noSound)
    if (tabItem) then
        local index = tabItem:getIndex()
        if (DEBUG) then
            print(string.format("TabList onTabItemClickHandler: select the tab %d.", index), self._activeIndex)
        end

        if self.checkClickEnable and (not self.checkClickEnable()) then
            if index ~= self._activeIndex then
                tabItem:restore()
            end
            return
        end
        for k, comp in pairs(self._compList) do
            if (k == index) then
                comp:active()
                if (index ~= self._activeIndex) then
                    local lastIndex = self._activeIndex
                    self._activeIndex = index
                    self:dispatchEvent(UIEvent.TAB_ACTIVE, index, lastIndex, tabItem)
                end
            else
                comp:restore()
            end
        end
    else
        assert(false)
    end
end

function TabList:showPanelByTabIndex(index)
    for k, comp in pairs(self._compList) do
        if (k == index) then
            comp:active()
            if (index ~= self._activeIndex) then
                local lastIndex = self._activeIndex
                self._activeIndex = index
                self:dispatchEvent(UIEvent.TAB_ACTIVE, index, lastIndex, tabItem)
            end
        else
            comp:restore()
        end
    end
end

-- 构造函数
function TabList:ctor()
    TabList.super.ctor(self, UIType.TAB_LIST, nil, 0, 0)

    -- 布局类型
    self._type = UI.LayoutArrayType.HORIZONTAL
    -- tab元素浮动类型
    self._floatType = UI.LayoutFloatType.FLOAT_LEFT
    -- 子节点
    self._compList = {}

    self._floatInstance = 0
    self._intervalSpace = 0
    self._itemWidth = nil
    self._itemHeight = nil

    -- 选中的索引
    self._activeIndex = 0
    -- 默认值
    self._defaultIndex = 1
    self._reverseOrder = false --  是否倒序
end

-- 析构函数
function TabList:dtor()
    self._compList = {}

    TabList.super.dtor(self)
end

-- public:
-- 初始化
function TabList:init(intervalSpace, tabItemWidth, tabItemHeight, isHideInvisibleTab)
    self._intervalSpace = intervalSpace or 0
    self._itemWidth = tabItemWidth
    self._itemHeight = tabItemHeight
    self._isHideInvisibleTab = isHideInvisibleTab
    TabList.super.init(self)
end

-- 设置排列方式
function TabList:setLayout(layoutType, floatType)
    self._type = layoutType
    self._floatType = floatType
end

 -- 向左浮动
function TabList:setItemToFloatLeft()
    self._floatType = LayoutFloatType.FLOAT_LEFT
end

 -- 向右浮动
function TabList:setItemToFloatRight()
    self._floatType = LayoutFloatType.FLOAT_RIGHT
end

-- 添加组件
function TabList:addTab(tabItem)
    assert(tabItem, "TabList addTab: tab is invalid.")

    tabItem:setIndex(table.nums(self._compList) + 1)
    if self._itemWidth and self._itemHeight then
        tabItem:setSize(self._itemWidth, self._itemHeight)
    end
    tabItem:setTouchEnable(true)
    tabItem:addEventListener(UIEvent.TAB_CLICK, self, onTabItemClickHandler)
    tabItem:restore()
    self:addChild(tabItem)

    table.insert(self._compList, tabItem)
    return tabItem;
end

-- 添加组件
function TabList:addToTab(tabItem, index)
    assert(tabItem, "TabList addTab: tab is invalid.")

    tabItem:setIndex(index)
    if self._itemWidth and self._itemHeight then
        tabItem:setSize(self._itemWidth, self._itemHeight)
    end
    tabItem:setTouchEnable(true)
    tabItem:addEventListener(UIEvent.TAB_CLICK, self, onTabItemClickHandler)
    self:addChild(tabItem)

    self._compList[index] = tabItem
end

-- 显示某个tab
function TabList:showTab(tabIndex)
    local tabItem = self._compList[tabIndex]
    if (tabItem) then tabItem:show()
    end
end

-- 隐藏某个tab
function TabList:hideTab(tabIndex)
    local tabItem = self._compList[tabIndex]
    if (tabItem) then tabItem:hide()
    end
end

-- 激活某个tab
function TabList:activeTab(tabIndex)
    local tabItem = self._compList[tabIndex]
    if(tabItem) then
        onTabItemClickHandler(self,tabItem,false)
    end
end

function TabList:restoreTab(tabIndex)
    local tabItem = self._compList[tabIndex]
    if(tabItem) then 
        tabItem:restore()
        self._activeIndex = nil
    end
end
function TabList:removeDisableTab(tabIndex)
    local tabItem = self._compList[tabIndex]
    if(tabItem) then 
        tabItem:removeDisable()
    end
end


function TabList:disableTab(tabIndex)
    local tabItem = self._compList[tabIndex]
    if(tabItem) then 
        tabItem:disable()
    end
end



function TabList:restoreAllTabs()
    for i,v in ipairs(self._compList) do self:restoreTab(i) end
end

function TabList:setDefaultIndex(tabIndex)
    self._defaultIndex = tabIndex
end

-- 获取当前激活的tab的索引值
function TabList:getIndex()
    return self._activeIndex
end

-- 更新视图
function TabList:onUpdateView()
    self:setSize(0, 0)
    self._floatInstance = 0

    local compCount = 0
    for k,comp in pairs(self._compList) do
        if (not self._isHideInvisibleTab or (self._isHideInvisibleTab and comp:isVisible())) then
            compCount = compCount + 1
        end
    end
    if (compCount > 0) then
        local width = 0
        local height = 0
        if (self._type == UI.LayoutArrayType.HORIZONTAL) then
            width = (compCount - 1) * self._intervalSpace
        else
            height = (compCount - 1) * self._intervalSpace
        end
        for k, v in pairs(self._compList) do
            if (not self._isHideInvisibleTab or (self._isHideInvisibleTab and v:isVisible())) then
                if (self._type == UI.LayoutArrayType.HORIZONTAL) then
                    width = width + v:getContentSize().width
                    if height < v:getContentSize().height then
                        height = v:getContentSize().height
                    end
                else
                    height = height + v:getContentSize().height
                    if width < v:getContentSize().width then
                        width = v:getContentSize().width
                    end
                end
            end
        end
        self:setSize(width, height)
        local defaultTabItem = nil
        --排序 key 较小的 先显示
        local tempCompList = {}
        local totleZorder = 1
        for k, comp in pairs(self._compList) do
            if (not self._isHideInvisibleTab or (self._isHideInvisibleTab and comp:isVisible())) then
                local data = {}
                data.key = k
                data.comp = comp
                table.insert(tempCompList, data)
                totleZorder = totleZorder + 1
            end
        end
        table.sort(tempCompList, function(a, b)
            if self._reverseOrder then
                return a.key > b.key
            else 
                return a.key < b.key
            end
        end)
        for k, data in ipairs(tempCompList) do
            computeCompPosition(self, data.comp)
            if (data.key == self._defaultIndex) then
                defaultTabItem = data.comp
            end
            data.comp:setZOrder(totleZorder)
            totleZorder = totleZorder - 1
        end
        if (defaultTabItem) then
            onTabItemClickHandler(self, defaultTabItem, true)
        end
    end
end

function TabList:setReverseOrder(reverseOrder)
    self._reverseOrder = reverseOrder
end