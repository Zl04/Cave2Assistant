--
-- Author: yueyingsong
-- Date: 2017-11-20 17:52:55
-- Using : 内购钻石界面cell
require "app.ui.iapshop.IapShopDiamondItem"
require "app.ui.common.Layout"

UI = UI or {}

local IapShopDiamondCell = class("IapShopDiamondCell",UI.TableViewCell)

UI.IapShopDiamondCell = IapShopDiamondCell

local ROW_WIDTH = 1000
local ROW_HEIGHT = 232
local CELL_HEIGHT = 210
local CELL_SPACING = 15
local COLUMN_NUM = 3

function IapShopDiamondCell:ctor()
	IapShopDiamondCell.super.ctor(self)
	self._items = {}
	self:onInitView()
end

function IapShopDiamondCell:dtor()

end

-- 创建行
function IapShopDiamondCell:onInitView( ... )
	self:setContentSize(cc.size(ROW_WIDTH, ROW_HEIGHT))

	local row = UI.Layout:create()
	row:init(-CELL_SPACING)
	row:setSize(ROW_WIDTH, CELL_HEIGHT)
	row:leftUp(0, 10)
	self:addChild(row)

	for i = 1, COLUMN_NUM do
		-- 背景
		local item = UI.IapShopDiamondItem:create()
		item:init()
		item:floatLeft(CELL_SPACING)
		row:addComponent(item)
		self._items[i] = item
	end
end

-- 填充单元数据
function IapShopDiamondCell:onUpdateView(datas)
	for i = 1, COLUMN_NUM do
		local item = self._items[i]
		local data = datas[i]
		item:setVisible(data ~= nil)
		if data then
			item:onUpdateView(data)
		end
	end
end

return IapShopDiamondCell