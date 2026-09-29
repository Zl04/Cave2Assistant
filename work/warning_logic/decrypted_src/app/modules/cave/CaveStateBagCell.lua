------------------------------------------------------------------------------
------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2021/02/18
--desc	: 
------------------------------------------------------------------------------
local CaveStateBagCell = class("CaveStateBagCell", UI.HWBtnComponent)
require "app.modules.cave.InfernoSelectCell"
UI = UI or {}
UI.CaveStateBagCell = CaveStateBagCell
-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 830
local COM_HEIGHT = 321

function CaveStateBagCell:ctor(list, isSingular)
    CaveStateBagCell.super.ctor(self, 0,COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self.list = list
    self.isSingular = isSingular
    self:init()
end

function CaveStateBagCell:init( ... )
    CaveStateBagCell.super.init(self, ... )
end

function CaveStateBagCell:dtor()
    CaveStateBagCell.super.dtor(self)
    reload_script_file_mvc("app.modules.cave.CaveStateBagCell")
end


function CaveStateBagCell:onInitView()
    local beginX = 0
    if self.isSingular then
        beginX = 168 / 2
    end
    for k, v in ipairs(self.list) do
        local view = UI.InfernoSelectCell:create(false, self.list[k])
        view:setScale(0.8)
        view:leftUp(beginX + (k - 1) * (view:getContentSize().width - 1), -30)
        self:addChild(view)
    end
end


return CaveStateBagCell