------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/04/23
--desc	: 
------------------------------------------------------------------------------

require "app.ui.common.Layout"

local CrystalTreatureShopItem = require("app.modules.crystaltreatureshop.CrystalTreatureShopItem")

UI = UI or {}

local CrystalTreatureShopCell = class("CrystalTreatureShopCell",UI.TableViewCell)

UI.CrystalTreatureShopCell = CrystalTreatureShopCell

local ROW_WIDTH = 640
local ROW_HEIGHT = 309
local CELL_HEIGHT = 291
local CELL_SPACING = 10
local COLUMN_NUM = 3

function CrystalTreatureShopCell:ctor(parentTable)
	CrystalTreatureShopCell.super.ctor(self)
	self._items = {}
	self._parentTable = parentTable
	self:onInitView()
end

function CrystalTreatureShopCell:dtor()
	
end

-- 创建行
function CrystalTreatureShopCell:onInitView( ... )
	self:setContentSize(cc.size(ROW_WIDTH, ROW_HEIGHT))

	local row = UI.Layout:create()
	row:init(-CELL_SPACING)
	row:setSize(ROW_WIDTH, CELL_HEIGHT)
	row:leftUp(0, 0)
	self:addChild(row)

	for i = 1, COLUMN_NUM do
		-- 背景
		local item = UI.CrystalTreatureShopItem:create(self._parentTable)
		item:init()
		item:floatLeft(CELL_SPACING)
        item:setCallback(function(id)
			if (self._cb) then self._cb(id) end
		end)
		row:addComponent(item)
		self._items[i] = item
	end
end

-- 填充单元数据
function CrystalTreatureShopCell:onUpdateView(datas)
	for i = 1, COLUMN_NUM do
		local item = self._items[i]
		local data = datas[i]
		if data then
			item:onUpdateView(data)
		end
		item:setVisible(data ~= nil)
	end
end

-- 设置回调
function CrystalTreatureShopCell:setCallback(cb)
	self._cb = cb
end

return CrystalTreatureShopCell