--[[--
视图ActivityModeCaveEntryRewardPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/09
--desc	: 
------------------------------------------------------------------------------

local ActivityModeCaveEntryRewardPanel = class("ActivityModeCaveEntryRewardPanel",mvc.GamePanel)
local COM_WIDTH = 1136
local COM_HEIGHT = 282

function ActivityModeCaveEntryRewardPanel:init()
	ActivityModeCaveEntryRewardPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ActivityModeCaveEntryRewardPanel:onEnter()
	self.ui:setSize(COM_WIDTH, COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ActivityModeCaveEntryRewardPanel:onExit()

end

return ActivityModeCaveEntryRewardPanel