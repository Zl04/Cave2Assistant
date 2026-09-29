--[[
    UI - 列表格子
]]--

require "app.ui.Component"

UI = UI or {}

local ListGrid = class("ListGrid", UI.HWBtnComponent)
UI.ListGrid = ListGrid

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 构造函数
function ListGrid:ctor(resList, width, height)
    ListGrid.super.ctor(self, UIType.LIST_GRID, resList, width, height)

    -- 格子索引
    self._index = 0
    -- 格子数据
    self._data = nil
end

-- 析构函数
function ListGrid:dtor()
    ListGrid.super.dtor(self)
end

-- public:
-- 初始化
function ListGrid:init(data)
    if (data) then
        self._data = data
    end

    ListGrid.super.init(self)
end

-- 初始化视图
function ListGrid:onInitView()
    assert(false, "ListGrid onInitView: this method should be overrided.")
end

-- 更新视图
function ListGrid:onUpdateView()
    assert(false, "ListGrid onUpdateView: this method should be overrided.")
end

-- 设置编号
function ListGrid:setIndex(index)
    self._index = index
end

-- 获取索引编号
function ListGrid:getIndex(index)
    return self._index
end

-- 设置数据
function ListGrid:setData(data)
    self._data = data
end

-- 清理
function ListGrid:clear()
    self._data = nil
end

-- 格子是否为空
function ListGrid:isEmpty()
    return self._data == nil
end

-- 获取拖拽的视图
function ListGrid:createDraggedView()
    return nil
end

-- 格子被选中的效果
function ListGrid:showSelect()
end

-- 格子取消选中
function ListGrid:hideSelect()
end

-- 显示格子中的图标
function ListGrid:showIcon()
end

-- 隐藏格子中的图标（不隐藏背景）
function ListGrid:hideIcon()
end