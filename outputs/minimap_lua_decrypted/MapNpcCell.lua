-- MapNpcCell.lua
-- Author:zp
-- 2019年6月30日
-- Using:地图NPCcell

UI = UI or {}

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"

local MapNpcCell = class("MapNpcCell", UI.TableViewCell)
UI.MapNpcCell = MapNpcCell

local CELL_W = 151
local CELL_H = 53

function MapNpcCell:ctor()

end

function MapNpcCell:onEnter()
    MapNpcCell.super.onEnter(self);
end

function MapNpcCell:onExit()
    MapNpcCell.super.onExit(self);
end

function MapNpcCell:init(data)
    self._data = data;
    self:onInitView();
end

function MapNpcCell:onInitView()
    self._cellLayout = cc.Layer:create();
    self._cellLayout:setPosition(cc.p(0,0));
    self._cellLayout:setContentSize(cc.size(CELL_W, CELL_H));
    self:addChild(self._cellLayout);

    self:initCellData();
end

function MapNpcCell:initCellData()
    if(self._data == nil) then 
        return 
    end
    local contentLayout = UI.Layout:create();
    contentLayout:init();
    contentLayout:setSize(CELL_W, CELL_H);
    contentLayout:center()
    self._cellLayout:addChild(contentLayout, 1)

    local roleSpriteName, elementSpriteName, hasRole, hasElement = UI.MapGrid:getIconName(self._data, true)
    if(elementSpriteName) then
        local iconImage = UI.Image:create()
        iconImage:init(elementSpriteName)
        iconImage:centerLeft(10)
        contentLayout:addChild(iconImage)
    end

    local npcName = UI.Text:create()
    npcName:init(LanguageManager:getInstance():getLocalString(self._data.iconMap.name), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 245, g = 225, b = 195})
    npcName:centerLeft(64)
    contentLayout:addChild(npcName)
end
