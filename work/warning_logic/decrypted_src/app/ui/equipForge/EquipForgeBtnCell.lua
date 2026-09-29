-- EquipForgeBtnCell.lua
-- Author:lzm
-- 2019年3月21日
-- Using:装备锻造btn cell

UI = UI or {}

local EquipForgeBtnCell = class("EquipForgeBtnCell", UI.TableViewCell)
UI.EquipForgeBtnCell = EquipForgeBtnCell

local BTN_CELL_W = 82
local BTN_CELL_H = 60

function EquipForgeBtnCell:ctor()

end

function EquipForgeBtnCell:onEnter()
    EquipForgeBtnCell.super.onEnter(self);
end

function EquipForgeBtnCell:onExit()
    EquipForgeBtnCell.super.onExit(self);
end

function EquipForgeBtnCell:init(data)
    self._data = data;
    self:onInitView();
end

function EquipForgeBtnCell:onInitView()
    self._cellLayout = cc.Layer:create();
    self._cellLayout:setPosition(cc.p(0,0));
    self._cellLayout:setContentSize(cc.size(BTN_CELL_W, BTN_CELL_H));
    self:addChild(self._cellLayout);

    self:initCellData();
end

function EquipForgeBtnCell:initCellData()
    self._bg = UI.Image:create()
    self._bg:init("ui_btn_gray4_0.png")
    self._bg:centerLeft(0)
    self._cellLayout:addChild(self._bg)

    local icon = UI.Image:create()
    self.icon = icon
    icon:init(self._data.icon)
    icon:center()
    self:updateCellShow(self._data.select)
    self._bg:addChild(icon)
end

function EquipForgeBtnCell:updateCellShow(select)
    if select then
        self.icon:setImageColor({ r = 220, g = 211, b = 147 })
        self._bg:setSpriteName("ui_btn_gray4_1.png")
        self._bg:centerLeft(5)
    else
        self.icon:setImageColor({ r = 47, g = 50, b = 55 })
        self._bg:setSpriteName("ui_btn_gray4_0.png")
        self._bg:centerLeft(0)
    end
end
