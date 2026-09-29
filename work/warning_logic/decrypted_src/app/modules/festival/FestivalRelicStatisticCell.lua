------------------------------------------------------------------------------
------------------------------------------------------------------------------
--author: yudong.li
--date	: 2020/05/11
--desc	: 
------------------------------------------------------------------------------
local FestivalRelicStatisticCell = class("FestivalRelicStatisticCell", UI.HWBtnComponent)
require "app.modules.festival.FestivalRelicCell"
UI = UI or {}
UI.FestivalRelicStatisticCell = FestivalRelicStatisticCell
-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 830
local COM_HEIGHT = 291

function FestivalRelicStatisticCell:ctor(list, isSingular)
    FestivalRelicStatisticCell.super.ctor(self, 0,COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self.list = list
    self.isSingular = isSingular
    self:init()
end

function FestivalRelicStatisticCell:init( ... )
    FestivalRelicStatisticCell.super.init(self, ... )
end

function FestivalRelicStatisticCell:dtor()
    FestivalRelicStatisticCell.super.dtor(self)
    reload_script_file_mvc("app.modules.festival.FestivalRelicStatisticCell")
end


function FestivalRelicStatisticCell:onInitView()
    local beginX = 0
    if self.isSingular then
        beginX = 168 / 2
    end
    for k, v in ipairs(self.list) do
        local view = UI.FestivalRelicCell:create(false, self.list[k])
        view:setScale(0.8)
        view:leftUp(beginX + (k - 1) * (view:getContentSize().width - 1), -30)
        self:addChild(view)
    end
end


return FestivalRelicStatisticCell












