--[[
    UI - 布局
]]--

require "app.ui.Component"

UI = UI or {}
local Layout = class("Layout", UI.HWBtnComponent)
UI.Layout = Layout

-- private:
local DEBUG = false
local DEBUG_DRAW = true

local COM_LAYOUT_TYPE = UI.LayoutDefaultType 

-- 计算组件坐标
local function computeCompPosition(self, comp)
    if (not comp:isVisible()) then
        return 
    end

    local width, height = comp:getSize()
    -- 自动大小启动时跟踪最大组件大小， 计算自动大小时使用
    if (self:isAutoSize()) then
        self._compMaxWidth = math.max(width, self._compMaxWidth)
        self._compMaxHeight = math.max(height, self._compMaxHeight)
    end

    local layoutType = comp:getFloatType()
    if (layoutType == LayoutFloatType.FLOAT_LEFT) then
        local left = comp:getLeft()
        left = left + self._floatLeftTracker
        comp:centerLeft(left)

        self._floatLeftTracker = left + width
    elseif (layoutType == LayoutFloatType.FLOAT_RIGHT) then
        local right = comp:getRight()
        right = right + self._floatRightTracker
        comp:centerRight(right)

        self._floatRightTracker = right + width
    elseif (layoutType == LayoutFloatType.FLOAT_UP) then
        local up = comp:getUp()
        up = up + self._floatUpTracker
        comp:centerUp(up)

        self._floatUpTracker = up + height
    elseif (layoutType == LayoutFloatType.FLOAT_BOTTOM) then
        local bottom = comp:getBottom()
        bottom = bottom + self._floatBottomTracker
        comp:centerBottom(bottom)

        self._floatBottomTracker = bottom + height
    elseif (layoutType == LayoutFloatType.FLOAT_LEFT_UP) then
        local left = comp:getLeft()
        local up = comp:getUp()
        left = left + self._floatLeftTracker
        up = up + self._floatUpTracker
        comp:leftUp(left, up)

        self._floatLeftTracker = left + width
        self._floatUpTracker = up + height
    elseif (layoutType == LayoutFloatType.FLOAT_LEFT_BOTTOM) then
        local left = comp:getLeft()
        local bottom = comp:getBottom()
        left = left + self._floatLeftTracker
        bottom = bottom + self._floatBottomTracker
        comp:leftBottom(left, bottom)

        self._floatLeftTracker = left + width
        self._floatBottomTracker = bottom + height
    elseif (layoutType == LayoutFloatType.FLOAT_RIGHT_UP) then
        local right = comp:getRight()
        local up = comp:getUp()
        right = right + self._floatRightTracker
        up = up + self._floatUpTracker
        comp:rightUp(right, up)

        self._floatRightTracker = right + width
        self._floatUpTracker = up + height
    elseif (layoutType == LayoutFloatType.FLOAT_RIGHT_BOTTOM) then
        local right = comp:getRight()
        local bottom = comp:getBottom()
        right = right + self._floatRightTracker
        bottom = bottom + self._floatBottomTracker
        comp:rightBottom(right, bottom)

        self._floatRightTracker = right + width
        self._floatBottomTracker = bottom + height
    else
        layoutType = comp:getLayoutType()
        -- 左上角（默认）
        if (layoutType == COM_LAYOUT_TYPE.DEFAULT) then
            local posX, posY = comp:getPos()
            posX = posX + self._leftPadding
            posY = posY + self._upPadding
            comp:setPos(posX, posY)
        -- 居中
        elseif (layoutType == COM_LAYOUT_TYPE.CENTER) then 
            local realWidth = self._width - self._leftPadding - self._rightPadding
            local realHeight = self._height - self._upPadding - self._bottomPadding
            local compWidth, compHeight = comp:getSize()
            local posX, posY = (realWidth - compWidth) / 2, (realHeight - compHeight) / 2
            posX = posX + self._leftPadding
            posY = posY + self._bottomPadding
            comp:setPosition(posX, posY)
        -- 左上
        elseif (layoutType == COM_LAYOUT_TYPE.LEFT_UP) then
            local left = comp:getLeft()
            local up = comp:getUp()
            left = left + self._leftPadding
            up = up + self._upPadding
            comp:leftUp(left, up)
        -- 左下
        elseif (layoutType == COM_LAYOUT_TYPE.LEFT_BOTTOM) then
            local left = comp:getLeft()
            local bottom = comp:getBottom()
            left = left + self._leftPadding
            bottom = bottom + self._bottomPadding
            comp:leftBottom(left, bottom)
        -- 右上
        elseif (layoutType == COM_LAYOUT_TYPE.RIGHT_UP) then
            local right = comp:getRight()
            local up = comp:getUp()
            right = right + self._rightPadding
            up = up + self._upPadding
            comp:rightUp(right, up)
        -- 右下
        elseif (layoutType == COM_LAYOUT_TYPE.RIGHT_BOTTOM) then
            local right = comp:getRight()
            local bottom = comp:getBottom()
            right = right + self._rightPadding
            bottom = bottom + self._bottomPadding
            comp:rightBottom(right, bottom)
        -- 中上
        elseif (layoutType == COM_LAYOUT_TYPE.CENTER_UP) then
            local realWidth = self._width - self._leftPadding - self._rightPadding
            local realHeight = self._height - self._upPadding - self._bottomPadding
            local compWidth, compHeight = comp:getSize()
            local up = comp:getUp()
            local posX, posY = (realWidth - compWidth) / 2, (realHeight - compHeight - up)
            posX = posX + self._leftPadding
            posY = posY + self._bottomPadding
            comp:setPosition(posX, posY)
        -- 中下
        elseif (layoutType == COM_LAYOUT_TYPE.CENTER_BOTTOM) then
            local realWidth = self._width - self._leftPadding - self._rightPadding
            local realHeight = self._height - self._upPadding - self._bottomPadding
            local compWidth, compHeight = comp:getSize()
            local bottom = comp:getBottom()
            local posX, posY = (realWidth - compWidth) / 2, bottom
            posX = posX + self._leftPadding
            posY = posY + self._bottomPadding
            comp:setPosition(posX, posY)
        -- 中左
        elseif (layoutType == COM_LAYOUT_TYPE.CENTER_LEFT) then
            local realWidth = self._width - self._leftPadding - self._rightPadding
            local realHeight = self._height - self._upPadding - self._bottomPadding
            local compWidth, compHeight = comp:getSize()
            local left = comp:getLeft()
            local posX, posY = left, (realHeight - compHeight) / 2
            posX = posX + self._leftPadding
            posY = posY + self._bottomPadding
            comp:setPosition(posX, posY)
        -- 中右
        elseif (layoutType == COM_LAYOUT_TYPE.CENTER_RIGHT) then
            local realWidth = self._width - self._leftPadding - self._rightPadding
            local realHeight = self._height - self._upPadding - self._bottomPadding
            local compWidth, compHeight = comp:getSize()
            local right = comp:getRight()
            local posX, posY = realWidth - compWidth - right, (realHeight - compHeight) / 2
            posX = posX + self._leftPadding
            posY = posY + self._upPadding
            comp:setPosition(posX, posY)
        else
            assert(false)
        end
    end
end

-- 构造函数
function Layout:ctor()
    Layout.super.ctor(self, UIType.LAYOUT, nil, 0, 0)

    -- 子节点
    self._compList = {}

    -- 自动大小, 只在使用浮动布局时有用, 使用内部浮动计量器来计算自身大小
    -- 横向浮动或竖向浮动时需要以最大组件大小作为垂直于浮动方向的自身大小
    -- 例: 内部组件横向浮动, 竖向浮动计量器为0, 就需要用最大组件高度来做自身大小
    self._autoWidth = false
    self._autoHeight = false
    self._compMaxHeight = 0
    self._compMaxWidth = 0
    
    -- 浮动布局的当前位置
    -- by CMonk, 和Component的floatXXXX变量重复, 故改名
    -- self._floatLeft = 0
    -- self._floatRight = 0
    -- self._floatUp = 0
    -- self._floatBottom = 0
    self._floatLeftTracker = 0
    self._floatRightTracker = 0
    self._floatUpTracker = 0
    self._floatBottomTracker = 0
    -- eo CMonk

    -- 内部的空白
    self._leftPadding = 0
    self._rightPadding = 0
    self._upPadding = 0
    self._bottomPadding = 0
end

-- 析构函数
function Layout:dtor()
    self._compList = {}

    Layout.super.dtor(self)
end

-- public:
-- 初始化
function Layout:init(leftPadding, rightPaddind, upPadding, bottomPadding)
    if (leftPadding) then assert(type(leftPadding) == "number", "Layout init: left padding is invalid.") end
    if (rightPaddind) then assert(type(rightPaddind) == "number", "Layout init: right padding is invalid.") end
    if (upPadding) then assert(type(upPadding) == "number", "Layout init: up padding is invalid.") end
    if (bottomPadding) then assert(type(bottomPadding) == "number", "Layout init: bottom padding is invalid.") end

    self._leftPadding = leftPadding or 0
    self._rightPadding = rightPaddind or 0
    self._upPadding = upPadding or 0
    self._bottomPadding = bottomPadding or 0

    Layout.super.init(self)
end

-- 添加组件
function Layout:addComponent(comp, zorder)
    assert(comp and type(comp) == "userdata", "Layout addComponent: comp is invalid.")

    self:addChild(comp, zorder or 0)
    table.insert(self._compList, comp)

    computeCompPosition(self, comp)
    self:updateAutoSize()
end

-- 清除自动排版项目
function Layout:clearComponentList()
    self._compList = {}
end

-- 自动高度, 只在使用浮动布局时有用
function Layout:enableAutoHeight()
    self._autoHeight = true
    self:updateView()
end

-- 是否已经开启自动高度
function Layout:isAutoHeight()
    return self._autoHeight
end

-- 自动宽度, 只在使用浮动布局时有用
function Layout:enableAutoWidth()
    self._autoWidth = true
    self:updateView()
end

-- 是否已经开启自动宽度
function Layout:isAutoWidth()
    return self._autoWidth
end

-- 方便方法检测自当高或自动宽之一是否开启
function Layout:isAutoSize()
    return self:isAutoWidth() or self:isAutoHeight()
end

-- 初始化视图
function Layout:onInitView()

end

-- 更新视图
function Layout:onUpdateView()
    self._floatLeftTracker = self._leftPadding
    self._floatRightTracker = self._rightPadding
    self._floatUpTracker = self._upPadding
    self._floatBottomTracker = self._bottomPadding
    self._compMaxWidth = 0
    self._compMaxHeight = 0
    
    for i = 1, #self._compList do
        local comp = self._compList[i]
        computeCompPosition(self, comp)
    end
    self:updateAutoSize()
end

-- 计算自动大小
function Layout:updateAutoSize()
    -- 检查开关和初始化变量
    if(not self:isAutoSize()) then return end
    local oldWidth, oldHeight = self:getSize()
    local newWidth, newHeight = oldWidth, oldHeight

    -- 计算自动宽高， 横向浮动或竖向浮动时需要以最大组件作为垂直浮动方向的大小
    if (self._autoWidth) then
        newWidth = math.max(
            self._floatLeftTracker + self._floatRightTracker,
            self._leftPadding + self._rightPadding + self._compMaxWidth)
        newWidth = math.max(newWidth, 0)
    end
    if (self._autoHeight) then
        newHeight = math.max(
            self._floatUpTracker + self._floatBottomTracker,
            self._upPadding + self._bottomPadding + self._compMaxHeight)
        newHeight = math.max(newHeight, 0)
    end

    -- 如果自动缩放宽高和原宽高一样， 不做任何动作
    if (oldWidth == newWidth and oldHeight == newHeight) then return end

    -- 更新自身大小
    self:setSize(newWidth, newHeight)

    -- 如果父节点为一个Layout并且开启了自动大小， 更新其大小
    local parent = self:getParent()
    if (parent and 
        parent.getType and 
        parent:getType() == UIType.LAYOUT and
        (parent:isAutoSize())) 
    then 
        parent:updateView()
    end
end

function Layout:printParam()
    print("--witdh param ", self._autoWidth, self._floatLeftTracker, self._floatRightTracker, self._leftPadding, self._rightPadding, self._compMaxWidth)
    -- print("--height param " ,  self._floatUpTracker , self._floatBottomTracker, self._upPadding, self._bottomPadding, self._compMaxHeight)
end

function Layout:onSizeChanged(width, height)
    self:updateView()
end

function Layout:setPadding(leftPadding, rightPaddind, upPadding, bottomPadding)
    assert(type(leftPadding) == "number" and leftPadding >= 0, "Layout init: left padding is invalid.")
    assert(type(rightPaddind) == "number" and rightPaddind >= 0, "Layout init: right padding is invalid.")
    assert(type(upPadding) == "number" and upPadding >= 0, "Layout init: up padding is invalid.")
    assert(type(bottomPadding) == "number" and bottomPadding >= 0, "Layout init: bottom padding is invalid.")

    self._leftPadding = leftPadding
    self._rightPadding = rightPaddind
    self._upPadding = upPadding
    self._bottomPadding = bottomPadding

    self:updateView()
end