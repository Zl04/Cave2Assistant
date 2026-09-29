--
-- Author: yueyingsong
-- Date: 2017-11-22 11:21:06
--
require "app.ui.iapshop.IapShopBoxItem"
require "app.ui.common.Layout"

UI = UI or {}

local IapShopBoxCell = class("IapShopBoxCell",UI.TableViewCell)

UI.IapShopBoxCell = IapShopBoxCell

local ROW_WIDTH = 1000
local ROW_HEIGHT = 309
local CELL_HEIGHT = 288
local CELL_SPACING = 22
local COLUMN_NUM = 4

function IapShopBoxCell:ctor(sourceType)
	IapShopBoxCell.super.ctor(self)
	self._items = {}
	self._sourceType = sourceType
	self:onInitView()
end

function IapShopBoxCell:dtor()
	
end

-- 创建行
function IapShopBoxCell:onInitView( ... )
	self:setContentSize(cc.size(ROW_WIDTH, ROW_HEIGHT))

	local row = UI.Layout:create()
	row:init(-CELL_SPACING)
	row:setSize(ROW_WIDTH, CELL_HEIGHT)
	row:leftUp(0, 0)
	self:addChild(row)

	for i = 1, COLUMN_NUM do
		-- 背景
		local item = UI.IapShopBoxItem:create(self._sourceType)
		item:init()
		item:floatLeft(CELL_SPACING)
		row:addComponent(item)
		self._items[i] = item
	end
end

-- 设置计时器
function IapShopBoxCell:schedulerCountDown(dt)
	for i = 1, COLUMN_NUM do
		local item = self._items[i]
		if not tolua.isnull(item) then
			item:schedulerCountDown(dt)
		end
	end
end

-- 填充单元数据
function IapShopBoxCell:onUpdateView(datas)
	for i = 1, COLUMN_NUM do
		local item = self._items[i]
		local data = datas[i]
		if data then
			item:onUpdateView(data)
		end
		item:setVisible(data ~= nil)
		item:setInnerItemsTouchEnabled(data ~= nil)
	end
end

return IapShopBoxCell