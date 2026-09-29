--[[--
视图TradeActivityCrystalCapturePanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/04/19
--desc	: 
------------------------------------------------------------------------------

local TradeActivityCrystalCapturePanel = class("TradeActivityCrystalCapturePanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function TradeActivityCrystalCapturePanel:init()
	TradeActivityCrystalCapturePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function TradeActivityCrystalCapturePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function TradeActivityCrystalCapturePanel:onExit()

end

return TradeActivityCrystalCapturePanel