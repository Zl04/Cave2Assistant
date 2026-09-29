------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2019/10/17
--desc	: 
------------------------------------------------------------------------------

require("app.modules.bet.BetHistoryCellInfo")

local LanguageManager = require "app.game.LanguageManager"
local ProtobufUtil = require "utils.ProtobufUtil"
local languageManagerInstance = LanguageManager:getInstance()
UI = UI or {}
local BetHistoryCell = class("BetHistoryCell", UI.HWBtnComponent)
UI.BetHistoryCell = BetHistoryCell

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 860
local COM_HEIGHT = 322 -- 292

function BetHistoryCell:ctor()
    BetHistoryCell.super.ctor(
    	self,
    	UI.Type.NORMAL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
end

function BetHistoryCell:init( ... )
    BetHistoryCell.super.init(self, ... )
end

function BetHistoryCell:dtor()
    BetHistoryCell.super.dtor(self)
end

function BetHistoryCell:onInitView()
    self._infoList = {}

    for i=1,4 do 
        local info = UI.BetHistoryCellInfo:create()
        info:init()
        info:leftUp(220 * (i-1), 3)
        self._infoList[i] = info

        self:addChild(info)
    end
end

function BetHistoryCell:onUpdateView()

end

function BetHistoryCell:updateData(data, startIndex, historyType, tableView)
    if(data ~= nil) then 
        -- 刷新数据
        for i=startIndex, startIndex + 3 do 
            local info = self._infoList[i - startIndex + 1]
            if(data[i] == nil) then 
                info:setVisible(false)
            else
                info:setVisible(true)
                info:updateData(data[i], historyType, tableView)
            end
        end
    end
end












