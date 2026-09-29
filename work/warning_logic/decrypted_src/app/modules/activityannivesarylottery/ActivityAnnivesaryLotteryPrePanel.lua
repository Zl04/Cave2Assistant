--[[--
视图ActivityAnnivesaryLotteryPrePanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/21
--desc	: 
------------------------------------------------------------------------------

local ActivityAnnivesaryLotteryPrePanel = class("ActivityAnnivesaryLotteryPrePanel",mvc.GamePanel)
local COM_WIDTH = 593
local COM_HEIGHT = 475
function ActivityAnnivesaryLotteryPrePanel:init()
	ActivityAnnivesaryLotteryPrePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ActivityAnnivesaryLotteryPrePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ActivityAnnivesaryLotteryPrePanel:onExit()

end

return ActivityAnnivesaryLotteryPrePanel