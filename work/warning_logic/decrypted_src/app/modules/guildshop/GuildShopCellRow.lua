--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:CMonk
    time:2019-06-02 17:26:51
]]

require "app.ui.common.Layout"

local GuildShopCellItem = require("app.modules.guildshop.GuildShopCellItem")

UI = UI or {}

local GuildShopCellRow = class("GuildShopCellRow",UI.TableViewCell)
UI.GuildShopCellRow = GuildShopCellRow

GuildShopCellRow.ROW_WIDTH = 1000
GuildShopCellRow.ROW_HEIGHT = GuildShopCellItem.DES_HEIGHT + 20
GuildShopCellRow.CELL_SPACING = 15
GuildShopCellRow.COLUMN_NUM = 4
local CELL_HEIGHT = 210

function GuildShopCellRow:ctor(parentTable)
	GuildShopCellRow.super.ctor(self)
    self._items = {}
    self._parentTable = parentTable
    self:onInitView()
end

function GuildShopCellRow:dtor()

end

-- 创建行
function GuildShopCellRow:onInitView( ... )
	self:setContentSize(cc.size(GuildShopCellRow.ROW_WIDTH, GuildShopCellRow.ROW_HEIGHT))

	local row = UI.Layout:create()
	row:init(-GuildShopCellRow.CELL_SPACING)
    row:setSize(GuildShopCellRow.ROW_WIDTH, GuildShopCellItem.DES_HEIGHT)
	row:leftUp(0, 0)
	self:addChild(row)

	for i = 1, GuildShopCellRow.COLUMN_NUM do
		-- 背景
		local item = GuildShopCellItem:create(self._parentTable)
		item:init()
		item:floatLeft(GuildShopCellRow.CELL_SPACING)
		item:setCallback(function(id)
			if (self._cb) then self._cb(id) end
		end)
		row:addComponent(item)
		self._items[i] = item
	end
end

-- 填充单元数据
function GuildShopCellRow:onUpdateView(datas)
	for i = 1, GuildShopCellRow.COLUMN_NUM do
		local item = self._items[i]
		local data = datas[i]
		item:setVisible(data ~= nil)
		if data then
			item:onUpdateView(data)
		end
	end
end

-- 设置回调
function GuildShopCellRow:setCallback(cb)
	self._cb = cb
end

return GuildShopCellRow