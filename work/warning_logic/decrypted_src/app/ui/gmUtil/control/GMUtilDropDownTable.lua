--[[
    测试工具  GM工具下拉菜单用的表类 2017/11/27
    by CMonk
]]


-- 模块初始化 --
---------------------------------------
-- 引用
local GMUtilDropDownCell = require("app.ui.gmUtil.control.GMUtilDropDownCell")
-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local GMUtilDropDownTable = class("GMUtilDropDownTable", UI.TableView)
UI.GMUtilDropDownTable = GMUtilDropDownTable

-- 私有变量:
local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local DEBUG_DRAW = true
---------------------------------------
-- eo 模块初始化 --










-- 数据结构 --
---------------------------------------

---------------------------------------
-- eo 数据结构 --










-- 程序逻辑 --
---------------------------------------
-- 设置列表数据
function GMUtilDropDownTable:setData(data)
	-- 目前用一个字符串数组来做数据结构, 见上面数据结构
	self._gmUtilDropDownData = data

	self:updateTableHeight()
	self:reload()
end

-- 根据设置的最大显示高度更新列表高度
function GMUtilDropDownTable:updateTableHeight()
	-- 先获取旧大小
	local oldWidth, oldHeight = self:getSize()

	-- 计算新的内容大小
	local numItem = #self._gmUtilDropDownData
	local contentHeight = numItem * self._cellHeight

	-- 如果新内容大小大于最大大小， 外观大小就设置未最大大小， 否则为内容大小
	local newHeight =  contentHeight
	if (contentHeight > self._maxTableHeight) then
		newHeight = self._maxTableHeight
	end
	self:setSize(oldWidth, newHeight)

	-- 更新视图
	self:updateView()
end

-- 设置单元高度
function GMUtilDropDownTable:setCellHeight(height)
	assert(type(height) == "number" and height > 0)
	self._cellHeight = height
	self:reload()
end

-- 设置列表最大显示高度
function GMUtilDropDownTable:setMaxHeight(height)
	assert(type(height) == "number" and height > 0)
	self._maxTableHeight = height
	self:updateTableHeight()
	self:reload()
end

-- 设置列表宽度
function GMUtilDropDownTable:setTableWidth(width)
	assert(type(width) == "number" and width > 0)
	local oldWidth, oldHeight = self:getSize()
	self:setSize(width, oldHeight)
	self._cellWidth = width
	self:reload()
end

-- 设置列表顺序
function GMUtilDropDownTable:updateVerticalFillOrder(fill)
	GMUtilDropDownTable.super.setVerticalFillOrder(self, fill)
	self._tableView:setVerticalFillOrder(fill)
	self:reload()
end

-- 设置单元点击回调函数
function GMUtilDropDownTable:setOnCellClicked(func)
	self._onCellClickedCallback = func
end

-- 设置高亮回调函数
function GMUtilDropDownTable:setOnCheckHighlighted(func)
	self._onCheckHighlightCallback = func
end
---------------------------------------
-- eo 程序逻辑 --












-- 事件处理 --
---------------------------------------
function GMUtilDropDownTable:updatedCell(tableview, idx)
	-- idx 从 <<<0>>> 开始
    local cell = tableview:dequeueCell()
    if cell == nil then
        cell = UI.GMUtilDropDownCell.new()
        cell:init()
    end

    -- 转换成lua index后调用回调
    local luaIdx = idx + 1
    -- 更新大小
    cell:setSize(self._cellWidth, self._cellHeight)
    -- 更新文字
    cell:setText(self._gmUtilDropDownData[luaIdx])
    -- 更新高亮
    if (self._onCheckHighlightCallback and self._onCheckHighlightCallback(luaIdx)) then
    	cell:setBgHighlighted()
    else
    	cell:setBgNormal()
    end
    -- 更新点击回调
    cell:addClickCallback(function()
    	if(self._onCellClickedCallback)then self._onCellClickedCallback(luaIdx) end
    end)

    return cell
end
---------------------------------------
-- eo 事件处理 --












-- 生命周期 --
---------------------------------------
function GMUtilDropDownTable:ctor()
	GMUtilDropDownTable.super.ctor(self)
	self._maxTableHeight = 0
	self._cellWidth = 0
	self._cellHeight = 0
	self._onCellClickedCallback = nil
	self._onCheckHighlightCallback = nil

	self._gmUtilDropDownData = {}
end

function GMUtilDropDownTable:dtor()
	GMUtilDropDownTable.super.dtor(self)
end

function GMUtilDropDownTable:init(width, maxHeight, cellHeight)
	assert(type(width) == "number" and width > 0)
	assert(type(maxHeight) == "number" and maxHeight > 0)
	assert(type(cellHeight) == "number" and cellHeight > 0)

	GMUtilDropDownTable.super.init(self)

	self._maxTableHeight = maxHeight
	self._cellWidth = width
	self._cellHeight = cellHeight

	self:setSize(width, 0)
	self:onInitView()

	-- self:enableDebugDraw()
end

function GMUtilDropDownTable:onInitView()
	GMUtilDropDownTable.super.onInitView(self)
    self:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
    self:setBounceable(true) 
    
    -- 设置单元数据
    self:onUpdateCells(function (tableview, idx) return self:updatedCell(tableview, idx) end)

    -- 设置单元大小
    self:onUpdateCellSize(function ()
        return self._cellWidth, self._cellHeight
    end)

    -- 设置单元数量
    self:onUpdateCellNumbers(function ()
        return #self._gmUtilDropDownData
    end)
end
---------------------------------------
-- eo 生命周期 --
