--[[--
视图ActivityLotteryPanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/05/17
--desc	: 
------------------------------------------------------------------------------

local ActivityLotteryPanel = class("ActivityLotteryPanel",mvc.GamePanel)
local COM_WIDTH = 938
local COM_HEIGHT = 569
function ActivityLotteryPanel:init()
	ActivityLotteryPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ActivityLotteryPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
	 Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
end


function ActivityLotteryPanel:onExit()
     Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER)
end

return ActivityLotteryPanel