--[[--
视图ActivityAnnivesaryLotteryRewardRosterPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/30
--desc	: 
------------------------------------------------------------------------------

local ActivityAnnivesaryLotteryRewardRosterPanel = class("ActivityAnnivesaryLotteryRewardRosterPanel",mvc.GamePanel)
local COM_WIDTH = 767
local COM_HEIGHT = 379
function ActivityAnnivesaryLotteryRewardRosterPanel:init()
	ActivityAnnivesaryLotteryRewardRosterPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ActivityAnnivesaryLotteryRewardRosterPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ActivityAnnivesaryLotteryRewardRosterPanel:onExit()

end

return ActivityAnnivesaryLotteryRewardRosterPanel