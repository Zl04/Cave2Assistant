--[[--
视图TradeActivityFirstPayPanel
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/09/15
--desc	: 
------------------------------------------------------------------------------

local TradeActivityFirstPayPanel = class("TradeActivityFirstPayPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function TradeActivityFirstPayPanel:init()
	TradeActivityFirstPayPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function TradeActivityFirstPayPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function TradeActivityFirstPayPanel:onExit()

end

return TradeActivityFirstPayPanel