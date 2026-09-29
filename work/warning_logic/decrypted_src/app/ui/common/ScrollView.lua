--[[
    UI - 背包滑动组件
]]--

require "app.ui.Component"
require "app.ui.common.CustomScrollBar"

UI = UI or {}

local ScrollView = class("ScrollView", UI.HWBtnComponent)
UI.ScrollView = ScrollView

-- 滚动模式
UI.ScrollType = {
    VERTICAL = 1,   -- 垂直滚动
    HORIZONTAL = 2  -- 横向滚动
}

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- z序
local ZORDER_BG = 1
local ZORDER_SCROLL_VIEW = 2
local ZORDER_SLIDER_BG = 3
local ZORDER_SLIDER = 4

-- 将内部节点添加到滑动视图上
local function addInnerNode(self, node)    
    local size = node:getContentSize()
    if (DEBUG) then
        print(string.format("ScrollView addInnerNode: inner node size:(%f,%f).", size.width, size.height))
        print(string.format("ScrollView addInnerNode: node size:(%f,%f).", self._width, self._height))
    end

    self._scrollView:addChild(node)
    self._scrollView:setInnerContainerSize(size)

    -- 监听内部节点尺寸改变的消息
    node:addEventListener(UIEvent.COMPONENT_SIZE_CHANGED, self, function(self, innerNode)
        local size = innerNode:getContentSize()
        if (DEBUG) then
            print(string.format("ScrollView addInnerNode: (COMPONENT_SIZE_CHANGED) inner node size:(%f,%f).", size.width, size.height))
            print(string.format("ScrollView addInnerNode: (COMPONENT_SIZE_CHANGED) node size:(%f,%f).", self._width, self._height))
        end

        self:stopScroll()
        -- print("node:addEventListener  run")
        self._isSizeChanged = true

        -- 更新内部节点的位置和尺寸
        self._scrollView:setInnerContainerSize(size)
        self:updateView()

        self._isSizeChanged = false
    end)
end

function ScrollView:refresh()
    local size = self._innerNode:getContentSize()
    self:stopScroll()
    self._scrollView:setInnerContainerSize(size)
    self:updateView()
end
-- 构造函数
function ScrollView:ctor(resList, width, height)
    ScrollView.super.ctor(self, UIType.SCROLL_VIEW, resList, width or 0, height or 0)

    -- 左右上下的间距
    self._leftPadding = 0
    self._rightPadding = 0
    self._upPadding = 0
    self._bottomPadding = 0
    -- 滚动模式
    self._scrollType = UI.ScrollType.VERTICAL
    -- 滚动视图的尺寸
    self._scrollViewWidth = 0
    self._scrollViewHeight = 0
    -- 滑动百分比
    self._scrollPercent = 0.0
    -- 滚动坐标
    self._scrollPosX = 0.0
    self._scrollPosY = 0.0

    -- 滚动视图节点
    self._scrollView = nil
    -- 内部节点
    self._innerNode = nil

    -- 是否正在滚动
    self._isScrolling = false

    -- 是否在保持上次的滚动位置
    self._enableRestorePosition = true
    self._restorePosition = false
    self._isSizeChanged = false
    self._currrentPositionX = 0
    self._currrentPositionY = 0

    self.customScrollBar = nil
end

-- 析构函数
function ScrollView:dtor()
    self._scrollView = nil
    self._innerNode = nil

    ScrollView.super.dtor(self)
end

-- public:
-- 初始化
function ScrollView:init(leftPadding, rightPadding, upPadding, bottomPadding)
    if (leftPadding) then assert(type(leftPadding) == "number", "ScrollView init: left padding is invalid.") end
    if (rightPadding) then assert(type(rightPadding) == "number", "ScrollView init: right padding is invalid.") end
    if (upPadding) then assert(type(upPadding) == "number", "ScrollView init: up padding is invalid.") end
    if (bottomPadding) then assert(type(bottomPadding) == "number", "ScrollView init: bottom padding is invalid.") end

    self._leftPadding = leftPadding or 0
    self._rightPadding = rightPadding or 0
    self._upPadding = upPadding or 0
    self._bottomPadding = bottomPadding or 0

    ScrollView.super.init(self)

    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(_, __)
        if (self._isScrolling) then
            self._isScrolling = false
            -- todo 暂时不知道之前为什么要这样处理,先注释掉 岳溁松
            -- self:dispatchEvent(UIEvent.SCROLL_VIEW_SCROLL_ENDED, self)
        end
    end)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(_, __)
        -- self:dispatchEvent(UIEvent.SCROLL_VIEW_SCROLL_ENDED, self)
    end)
end

-- 设置滚动模式
function ScrollView:setScrollType(scrollType)
    assert(type(scrollType) == "number", "ScrollView setScrollType: scroll type is invalid.")

    self._scrollType = scrollType
end

-- 添加子节点
function ScrollView:addInnerNode(node)
    if (node) then
        self._innerNode = node
        if (self._scrollView) then addInnerNode(self, node)
        else assert(false)
        end
    else
        assert(false)
    end
end

-- 获取滚动百分比
function ScrollView:getScrollPercent()
    return self._scrollPercent
end

-- 获取滚动坐标x
function ScrollView:getScrollPosX()
    return self._scrollPosX
end

-- 获取滚动坐标y
function ScrollView:getScrollPosY()
    return self._scrollPosY
end

-- 初始化视图
function ScrollView:onInitView()
    -- 滚动组件
    self._scrollView = ccui.ScrollView:create()
    self._scrollView:setBounceEnabled(true)
    self._scrollView:setScrollBarEnabled(false)
    self._scrollView:setInertiaScrollEnabled(true)
    self._scrollView:setSwallowTouches(false)
    self._scrollView:addEventListener(function(sender, eventType)
        if (self._innerNode) then
            local currentPostion = self._scrollView:getInnerContainerPosition()
            local innerNodeWidth, innerNodeHeight = self._innerNode:getSize()

            -- 计算滚动相关数据
            local posX, posY = 0.0, 0.0
            local percent = 0.0
            if (self._scrollType == UI.ScrollType.VERTICAL) then
                local visibleContentHeight = innerNodeHeight - self._height + (self._upPadding + self._bottomPadding)
                if (visibleContentHeight < 0) then visibleContentHeight = 0
                end
                posY = currentPostion.y
   
                if (visibleContentHeight == 0) then percent = 0
                else percent = 1 + posY / visibleContentHeight
                end
            elseif (self._scrollType == UI.ScrollType.HORIZONTAL) then
                local visibleContentWidth = innerNodeWidth - self._width + (self._leftPadding + self._rightPadding)
                if (visibleContentWidth < 0) then visibleContentWidth = 0
                end
                posX = currentPostion.x
  
                if (visibleContentWidth == 0) then percent = 0
                else percent = 1 + posX / visibleContentWidth
                end
            else
                assert(false)
            end
            self._scrollPosX = posX
            self._scrollPosY = posY
            self._scrollPercent = percent

            if (DEBUG) then
                print(string.format("ScrollView onInitView: scroll percent:%f position:(%f,%f).", percent, posX, posY))
            end
            if (eventType == 10) then 
                self._isScrolling = false
                self:dispatchEvent(UIEvent.SCROLL_VIEW_SCROLL_ENDED, self)

                self._currrentPositionX = currentPostion.x
                self._currrentPositionY = currentPostion.y
                if (self._scrollType == UI.ScrollType.VERTICAL) then
                    self._currrentPositionY = innerNodeHeight + currentPostion.y
                end
                self._restorePosition = true
            elseif (eventType == 12) then 
                self:dispatchEvent(UIEvent.SCROLL_VIEW_AUTOSCROLL_ENDED, self)
            else
                if (not self._isScrolling) then  
                    self._isScrolling = true
                    self:dispatchEvent(UIEvent.SCROLL_VIEW_SCROLL_BEGAN, self)
                else
                    if (not self._isSizeChanged) then
                        self._currrentPositionX = currentPostion.x
                        self._currrentPositionY = currentPostion.y
                        if (self._scrollType == UI.ScrollType.VERTICAL) then
                            self._currrentPositionY = innerNodeHeight + currentPostion.y
                        end
                        self._restorePosition = true
                    end
                end
                if(eventType == 9) then
                    if self.customScrollBar then
                        self.customScrollBar:scrollBar(percent)
                    end
                    self:dispatchEvent(UIEvent.SCROLL_VIEW_SCROLLING, self, percent, currentPostion)
                end
            end

        end
    end)
    if (self._innerNode) then
        addInnerNode(self, self._innerNode)
    end
    self:addChild(self._scrollView, ZORDER_SCROLL_VIEW)
end

-- 更新视图
function ScrollView:onUpdateView(data, isForbidDispatch)
    -- 计算滚动视图的尺寸
    if isForbidDispatch == nil then
        isForbidDispatch = false
    end
    self._scrollViewWidth = self._width - (self._leftPadding + self._rightPadding)
    self._scrollViewHeight = self._height - (self._upPadding + self._bottomPadding)

    -- 设置滚动视图的位置和尺寸Ø
    self._scrollView:setPosition(self._leftPadding, self._bottomPadding)
    self._scrollView:setContentSize(self._scrollViewWidth, self._scrollViewHeight)

    -- 更新内部节点的位置
    if (self._innerNode) then
        local innerNodeSize = self._innerNode:getContentSize()
        local innerNodeLeft, innerNodeBottom = 0, 0
        local scrollViewLeft, scrollViewBottom = 0, 0
        local scrollViewWidth, scrollViewHeight = 0, 0

        -- 设置滚动模式
        if (self._scrollType == UI.ScrollType.VERTICAL) then 
            self._scrollView:setDirection(SCROLLVIEW_DIR_VERTICAL)

            innerNodeLeft = 0
            if (innerNodeSize.height <= self._scrollViewHeight) then 
                innerNodeBottom = (self._scrollViewHeight - innerNodeSize.height)
            else 
                innerNodeBottom = 0
            end
        elseif (self._scrollType == UI.ScrollType.HORIZONTAL) then 
            self._scrollView:setDirection(SCROLLVIEW_DIR_HORIZONTAL)

            innerNodeLeft = 0
            innerNodeBottom = 0
        else 
            assert(false)
        end

        if self.scrollBarPositionFromCornerForVertical then
            self:setScrollBarPositionFromCornerForVertical(self.scrollBarPositionFromCornerForVertical)
        end

        self._innerNode:setPosition(innerNodeLeft, innerNodeBottom)

        -- 恢复到滚动的位置
        -- print("ScrollView:onUpdateView ", self._enableRestorePosition, self._restorePosition, self._currrentPositionX, self._currrentPositionY)
        if (self._enableRestorePosition and self._restorePosition) then
            -- local posX = 0
            -- local posY = 0
            -- print("crollView:onUpdateView  ", self._currrentPositionY, innerNodeSize.height, self._scrollViewHeight)
            -- posX = self._currrentPositionX
            -- posY = self._currrentPositionY
            -- if (self._scrollType == UI.ScrollType.HORIZONTAL) then
            --     if (innerNodeSize.width <= self._scrollViewWidth) then
            --         posX = 0
            --     else
            --         if (posX > 0) then
            --             posX = 0
            --         end
            --     end
            -- elseif (self._scrollType == UI.ScrollType.VERTICAL) then
            --     if (innerNodeSize.height <= self._scrollViewHeight) then
            --         posY = 0
            --     else
                    

            --         if (posY > 0) then
            --             posY = 0
            --         end
            --     end
            -- end
            local posX = 0
            local posY = 0

            if(self._scrollType == UI.ScrollType.HORIZONTAL) then
                if (innerNodeSize.width <= self._scrollViewWidth) then
                    posX = 0
                else
                    posX = self._currrentPositionX
                    if (posX > 0) then
                        posX = 0
                    end
                end

            elseif (self._scrollType == UI.ScrollType.VERTICAL) then
                if (innerNodeSize.height <= self._scrollViewHeight) then
                    posY = 0
                else
                    posY = self._currrentPositionY - innerNodeSize.height
                    if (posY > 0) then
                        posY = 0
                    end
                end

                -- print("------------ ", self._currrentPositionY, posY)
            end
            if not isForbidDispatch then
                self._scrollView:setInnerContainerPosition({
                    x = posX,
                    y = posY
                })
            end
        end
    end

    -- 修复滚动控件的问题
    self._isScrolling = false
    self:dispatchEvent(UIEvent.SCROLL_VIEW_SCROLL_ENDED, self)

    if(self._scrollBarWidth) then 
        self._scrollView:setScrollBarWidth(self._scrollBarWidth)
    end

    if(self._circleVisible ~= nil) then
        self._scrollView:setCircleVisible(self._circleVisible)
    end
end

-- 禁止滚动
function ScrollView:disableScrolling()
    self._innerNode:setSwallowTouches(true)
end

-- 启用滚动
function ScrollView:enableScrolling()
    self._innerNode:setSwallowTouches(false)
end

function ScrollView:createCustomScrollBar(imageName, posType, color)
    self._scrollView:setSwallowTouches(true)
    self.customScrollBar = UI.CustomScrollBar:create(self, imageName, posType)
    if color then
        self.customScrollBar:setScrollBarColor(cc.c3b(color.r, color.g, color.b))
    end
end

-- 禁用
function ScrollView:setBounceEnabled(enabled)
    self._scrollView:setBounceEnabled(enabled)
end

function ScrollView:setScrollBarEnabled(enabled)
    self._scrollView:setScrollBarEnabled(enabled)
end

function ScrollView:setScrollBarColor(color)
    self._scrollView:setScrollBarColor(color)
end

function ScrollView:setScrollBarOpacity(opacity)
    self._scrollView:setScrollBarOpacity(opacity)
end

function ScrollView:setScrollBarWidth(width)
    self._scrollBarWidth = width
    self._scrollView:setScrollBarWidth(width)
end
-- 滚到到顶部
function ScrollView:scrollToTop(timeInSec, attenuated)
    timeInSec = timeInSec or 0
    attenuated = attenuated or false

    self._scrollView:scrollToTop(timeInSec, attenuated)
end

-- 滚动到底部
function ScrollView:scrollToBottom(timeInSec, attenuated)
    timeInSec = timeInSec or 0
    attenuated = attenuated or false

    self._scrollView:scrollToBottom(timeInSec, attenuated)
end

-- 滚到到左侧
function ScrollView:scrollToLeft(timeInSec, attenuated)
    timeInSec = timeInSec or 0
    attenuated = attenuated or false

    self._scrollView:scrollToLeft(timeInSec, attenuated)
end

-- 滚到到左侧
function ScrollView:scrollToRight(timeInSec, attenuated)
    timeInSec = timeInSec or 0
    attenuated = attenuated or false

    self._scrollView:scrollToRight(timeInSec, attenuated)
end


function ScrollView:scrollToPercentVertical(percent, timeInSec, attenuated)
    timeInSec = timeInSec or 0
    attenuated = attenuated or false
    self._scrollView:scrollToPercentVertical(percent, timeInSec, attenuated)
end

function ScrollView:scrollToPercentHorizontal(percent, timeInSec, attenuated)
    timeInSec = timeInSec or 0
    attenuated = attenuated or false
    self._scrollView:scrollToPercentHorizontal(percent, timeInSec, attenuated)
end

function ScrollView:getScrolledPercentVertical()
    return self._scrollView:getScrolledPercentVertical()
end

-- 停止滚动
function ScrollView:stopScroll()
    self._scrollView:stopAutoScroll()
    
    if (self._isScrolling) then
        self._isScrolling = false
        self:dispatchEvent(UIEvent.SCROLL_VIEW_SCROLL_ENDED, self)
    end
end

-- 设置在更新的时候，是否恢复到之前的坐标
function ScrollView:setRestorePositiion(restrored)
    self._enableRestorePosition = restrored
end

function ScrollView:getViewBarBody()
    return self._scrollView:getViewBarBody()
end

--去掉 滑块两边的圆角
function ScrollView:setCircleVisible(visible)
    self._circleVisible = visible
    self._scrollView:setCircleVisible(visible)
end

--滑块位置偏移调整
function ScrollView:setScrollBarPositionFromCornerForVertical(offset)
    self.scrollBarPositionFromCornerForVertical = offset
    self._scrollView:setScrollBarPositionFromCornerForVertical(offset)
end

function ScrollView:useDefaultScrollBar(color)
    local color = color or UI.SLIDER_COLOR_Light
    local width = 5
    self:setScrollBarEnabled(true)
    self:setScrollBarPositionFromCornerForVertical(cc.p(width, 0));
    self:setScrollBarWidth(width)
    self:setCircleVisible(false)
    self:setScrollBarColor(color)
end

function ScrollView:setMaxBound(bound)
    if self._scrollView.setMaxBound then
        self._scrollView:setMaxBound(bound)
    end
end

function ScrollView:setScrollViewTouchEnabled(bound)
    self._scrollView:setTouchEnabled(bound)
end

function ScrollView:setContentOffset(offset)
    self._scrollView:setInnerContainerPosition(offset)
end

function ScrollView:getContentOffset()
    return self._scrollView:getInnerContainerPosition()
end

function ScrollView:getInnerSize()
    return self._scrollView:getInnerContainerSize()
end