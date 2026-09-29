--[[--
视图ActivityAnnivesaryLotteryRewardPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/21
--desc	: 
------------------------------------------------------------------------------

local ActivityAnnivesaryLotteryRewardPanel = class("ActivityAnnivesaryLotteryRewardPanel",mvc.GamePanel)
local COM_WIDTH = 818
local COM_HEIGHT = 282
function ActivityAnnivesaryLotteryRewardPanel:init()
	ActivityAnnivesaryLotteryRewardPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ActivityAnnivesaryLotteryRewardPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ActivityAnnivesaryLotteryRewardPanel:onExit()

end

return ActivityAnnivesaryLotteryRewardPanel