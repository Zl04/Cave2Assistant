--[[--
视图TradeActivityMainPanel
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/09/15
--desc	: 
------------------------------------------------------------------------------

local TradeActivityMainPanel = class("TradeActivityMainPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function TradeActivityMainPanel:init()
	TradeActivityMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function TradeActivityMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function TradeActivityMainPanel:onExit()

end

return TradeActivityMainPanel