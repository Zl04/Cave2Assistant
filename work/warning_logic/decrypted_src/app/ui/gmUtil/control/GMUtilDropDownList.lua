--[[
    测试工具  下拉菜单 2017/11/27
    修改基础：    
        DropDownList.lua
        Author:ydli
        2017年8月23日
        Using:下拉框 实现
    by CMonk
]]


-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.common.ButtonS9"
require "app.ui.gmUtil.control.GMUtilDropDownTable"
local GMUtilConfig = require("app.ui.gmUtil.GMUtilConfig")

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local GMUtilDropDownList = class("GMUtilDropDownList", UI.HWBtnComponent)
UI.GMUtilDropDownList = GMUtilDropDownList

-- 私有变量:
local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local DEBUG_DRAW = false
---------------------------------------
-- eo 模块初始化 --










-- 布局 --
---------------------------------------
-- 按钮默认大小
local LAYOUT_FONT_SIZE_OFFSET = GMUtilConfig.LAYOUT_DROPDOWN_FNT_SZ_OFFSET
---------------------------------------
-- eo 布局 --












-- 资源统合 --
---------------------------------------
-- 资源
local COM_RES_LIST = {
    {name = UI.GMUtilConfig.SPRITE_CONTROLS_RES, priority = COM_RES_LEVEL.HIGH}
}

local SPRITE_BUTTON_NORMAL = UI.GMUtilConfig.SPRITE_DROPDOWN_BUTTON_NORMAL
local SPRITE_BUTTON_PRESSED = UI.GMUtilConfig.SPRITE_DROPDOWN_BUTTON_PRESSED
---------------------------------------
-- eo 资源统合 --










-- 数据结构 --
---------------------------------------
-- local GMUtilDropDownData = {
--     [1] = "Label 1"
-- }
---------------------------------------
-- eo 数据结构 --










-- 程序逻辑 --
---------------------------------------
-- 获取当前选中的index
function GMUtilDropDownList:getSelectedIndex()
    return self._selectedIndex
end

--设置选中index
function GMUtilDropDownList:setSelectedIndex(idx)
    assert(type(idx) == "number")
    -- 设置内部指针
    self._selectedIndex = idx
    -- 更改按键文字
    local text = self._data[idx]
    if (text) then self._dropButton:setTitleText(text) end
    -- 更新下拉菜单显示
    self._dropItemTable:reload()
    -- 调用回调
    if (self._onChangedCallback) then self._onChangedCallback(self, idx) end
end

-- 设置显示顺序
function GMUtilDropDownList:setDirection(dir)
    self._direction = dir
    self:updateListDirection()
end

-- 
function GMUtilDropDownList:refreshInnerData()
    self._dropItemTable:setData(self._data)
end

-- 显示下拉列表
function GMUtilDropDownList:showList()
    if (self._isListShown) then return end
    self._isListShown = true
    self:updateListDirection()

    -- 根据方向设置正确的起始位置
    local _, buttonHeight = self._dropButton:getSize()
    if(self._direction == 1) then
        self._dropItemTable:centerBottom(buttonHeight)
    else
        self._dropItemTable:centerUp(buttonHeight)
    end

    -- 注册点击外部关闭下拉列表
    self:registerTouchOutside()
end

-- 隐藏下拉列表
function GMUtilDropDownList:hideList()
    if (not self._isListShown) then return end
    self._isListShown = false

    -- 目前用移动出屏幕外的方式做隐藏
    local listWidth, _ = self._dropItemTable:getSize()
    self._dropItemTable:centerLeft(-winSize.width - listWidth)

    -- 取消点击外部关闭下拉列表的监听
    self:unregisterTouchOutside()
end

-- 往数据中添加一个文字
function GMUtilDropDownList:addText(text)
    assert(type(text) == "string")
    table.insert(self._data, text)
    self:refreshInnerData()
end

-- 设置下拉栏宽度， 默认和按钮一样宽
function GMUtilDropDownList:setDropDownWidth(width)
    assert((type(width) == "number" and width > 0) or width == nil)
    -- nil则默认使用按钮宽度作为物件高度

    self._dropDownItemSize.width = width or self._width
    if (self._dropItemTable) then
        self._dropItemTable:setTableWidth(self._dropDownItemSize.width)
    end
end

-- 设置下拉项高度， 默认和按钮一样高
function GMUtilDropDownList:setDropDownItemHeight(height)
    assert((type(height) == "number" and height > 0) or height == nil)

    -- nil则默认使用按钮高度作为物件高度
    self._dropDownItemSize.height = height or self._height + LAYOUT_FONT_SIZE_OFFSET
    if (self._dropItemTable) then
        self._dropItemTable:setCellHeight(self._dropDownItemSize.height)
    end
end

-- 设置显示列表项目数量
function GMUtilDropDownList:setDropDownItemShowNum(num)
    assert(type(num) == "number" and num > 0)
    self._showDropItemNum = num
    if (self._dropItemTable) then
        self._dropItemTable:setMaxHeight(self._showDropItemNum * self._dropDownItemSize.height)
    end
end

-- 设置填充顺序和起始位置
function GMUtilDropDownList:updateListDirection()
    if (not self._dropItemTable) then return end
    -- 1.根据方向设置正确的下拉列表位置
    -- 2.根据方向设置正确的填充顺序
    if(self._direction == 1) then
        self._dropItemTable:updateVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
        self._dropItemTable:scrollToBottom()
    else
        self._dropItemTable:updateVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
        self._dropItemTable:scrollToTop()
    end
end

-- 设置值改变回调
function GMUtilDropDownList:setOnSelectionChanged(func)
    self._onChangedCallback = func
end
---------------------------------------
-- eo 程序逻辑 --












-- 事件处理 --
---------------------------------------
function GMUtilDropDownList:clickCallback()
    print("DropDownList:clickCallback")
    if (self._isListShown)then
        self:hideList()
    else
        self:showList()
    end
end

function GMUtilDropDownList:touchOutsideCallback()
    print("onTouchDialogOutsizeHandler")
    if (self._isListShown) then self:hideList() end
end

--选中下拉列表后
function GMUtilDropDownList:selectedCallback(idx)
    self:setSelectedIndex(idx)
    self:hideList()
end

-- 注册点击窗口外
function GMUtilDropDownList:registerTouchOutside()
    if (self._touchOutsideRegistered) then return end
    self._touchOutsideRegistered = true
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.touchOutsideCallback)
end

-- 取消注册点击窗口外
function GMUtilDropDownList:unregisterTouchOutside()
    if (not self._touchOutsideRegistered) then return end
    self._touchOutsideRegistered = false
    self:removeEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.touchOutsideCallback)
end


-- 注册监听事件(可选)
function GMUtilDropDownList:registerListener()
end

-- 注销监听事件(可选)
function GMUtilDropDownList:unRegisterListener()
end
---------------------------------------
-- eo 事件处理 --
    
   











-- 生命周期 --
---------------------------------------
-- 构造函数
function GMUtilDropDownList:ctor()
    -- 设置默认大小
    GMUtilDropDownList.super.ctor(self, 0, COM_RES_LIST, 0, 0)

    -- 状态变量初始化
    self._isListShown = true  --是否显示了下拉列表  
    self._selectedIndex = 0 --选中下拉列表的index
    self._direction = 1 -- 1表示向上 -1 表示向下
    self._touchOutsideRegistered = false --点击监听注册状态
    
    -- 下拉显示数量
    self._showDropItemNum = 4
    -- 下拉标签大小
    self._dropDownItemSize = cc.size(0, 0)
    -- 下拉数据
    self._data = {}
    -- 选项改变回调
    self._onChangedCallback = nil

    -- 子组件
    self._dropItemTable = nil
    self._dropButton = nil

    self:setTouchEnable(true);
    self:registerListener()
end

-- 析构函数
function GMUtilDropDownList:dtor()
    self:unRegisterListener()
    GMUtilDropDownList.super.dtor(self)
end

-- 初始化
function GMUtilDropDownList:init(text, width, height, direction, data)
    assert(type(text) == "string")
    assert(type(width) == "number")
    assert(type(height) == "number")
    assert(direction == 1 or direction == -1)
    assert(type(data) == "table" or data == nil)


    -- 在super调用视图初始化之前先初始化视图相关的变量
    -- 初始化大小
    self:setSize(width, height)
    -- 初始化下拉项高度
    self:setDropDownWidth()
    self:setDropDownItemHeight()
    -- self._dropDownItemSize = cc.size(width, height)
    -- 初始化下拉方向
    self._direction = direction
    -- 初始化数据（可选）
    self._data = data and data or {}

    -- super会调用视图初始化
    GMUtilDropDownList.super.init(self)

    -- 初始化按钮文字
    self._dropButton:setTitleText(text)
end

-- 初始化视图
function GMUtilDropDownList:onInitView()
    GMUtilDropDownList.super.onInitView(self)

    -- 生成下拉显示按钮
    self._dropButton = UI.ButtonS9:create(self._width, self._height)
    self._dropButton:init(self._buttonText, SPRITE_BUTTON_NORMAL, SPRITE_BUTTON_PRESSED)
    self._dropButton:setTitleFontSize(self._height + LAYOUT_FONT_SIZE_OFFSET)
    self._dropButton:setTitleColor(UI.FONT_COLOR_42_31_1)
    self._dropButton:setTitleFontName(UI.FONT_ARIAL)
    self._dropButton:setOnClicked(function() self:clickCallback() end)
    self:addChild(self._dropButton);

    -- 生成下拉菜单栏
    self._dropItemTable = UI.GMUtilDropDownTable:create()
    self._dropItemTable:init(
        self._dropDownItemSize.width, 
        self._dropDownItemSize.height * self._showDropItemNum, 
        self._dropDownItemSize.height)

    -- 设置数据
    self:refreshInnerData()

    -- 设置点击回调
    self._dropItemTable:setOnCellClicked(function(idx) 
        self:selectedCallback(idx)
    end)

    -- 设置高亮回调
    self._dropItemTable:setOnCheckHighlighted(function(idx)
        return self._selectedIndex == idx
    end)

    self:hideList()
    self:addChild(self._dropItemTable)
end

-- 更新视图
function GMUtilDropDownList:onUpdateView()
    GMUtilDropDownList.super.onUpdateView(self)
    self._dropButton:setSize(self._width, self._height)
end
---------------------------------------
-- eo 生命周期 --
