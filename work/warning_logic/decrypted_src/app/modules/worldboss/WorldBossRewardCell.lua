-- WorldBossRewardCell.lua
-- Author:lzm
-- 2019年5月17日
-- Using:world boss reward cell

UI = UI or {}

local GameDataManager = require("app.game.GameDataManager")

local WorldBossRewardCell = class("WorldBossRewardCell", UI.TableViewCell)
UI.WorldBossRewardCell = WorldBossRewardCell

local CELL_W = 80
local CELL_H = 72

function WorldBossRewardCell:ctor()

end

function WorldBossRewardCell:onEnter()
    WorldBossRewardCell.super.onEnter(self);
end

function WorldBossRewardCell:onExit()
    WorldBossRewardCell.super.onExit(self);
end

function WorldBossRewardCell:init(data)
    self._data = data;
    self:onInitView();
end

function WorldBossRewardCell:onInitView()
    self._cellLayout = cc.Layer:create();
    self._cellLayout:setPosition(cc.p(0,0));
    self._cellLayout:setContentSize(cc.size(CELL_W, CELL_H));
    self:addChild(self._cellLayout);

    self:initCellData();
end

function WorldBossRewardCell:initCellData()
    local contentLayout = UI.Layout:create();
    contentLayout:init();
    contentLayout:setSize(CELL_W, CELL_H);
    contentLayout:center()
    self._cellLayout:addChild(contentLayout, 1)

    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:setTouchClipNode(contentLayout)
    goodsGrid:center()
    local goodsData = GoodsDataManager:createLocalGoodsData(self._data.id)
    goodsData:setNum(self._data.num)
    goodsData:setIsNew(false)
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(true, false)
    goodsGrid:setSwallowTouches(false)
    contentLayout:addChild(goodsGrid)
end
