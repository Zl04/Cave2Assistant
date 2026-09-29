--[[--
视图ActivityAnnivesaryLotteryMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/17
--desc	: 
------------------------------------------------------------------------------

local ActivityAnnivesaryLotteryMainPanel = class("ActivityAnnivesaryLotteryMainPanel",mvc.GamePanel)
local COM_WIDTH = 1100
local COM_HEIGHT = 500
function ActivityAnnivesaryLotteryMainPanel:init()
	ActivityAnnivesaryLotteryMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ActivityAnnivesaryLotteryMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ActivityAnnivesaryLotteryMainPanel:onExit()

end

return ActivityAnnivesaryLotteryMainPanel