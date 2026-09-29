--[[--
视图BetMainPanel
]]

------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2023/12/25
--desc	: 
------------------------------------------------------------------------------

UI.BET_MAIN_TYPE = {
    BET = 1,                -- 投注
    BET_HISTORY = 2,        -- 投注历史
}

UI.BET_HISTORY_TYPE = {
    HISTORY = 1, -- 投注历史
    OUR = 2,     -- 自己投注
}

local BetMainPanel = class("BetMainPanel",mvc.GamePanel)
local COM_WIDTH = 852
local COM_HEIGHT = 534
function BetMainPanel:init()
	BetMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BetMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BetMainPanel:onExit()

end



return BetMainPanel