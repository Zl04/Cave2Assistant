--[[--
视图ActivityModeCaveLeaderboardPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/11/01
--desc	: 
------------------------------------------------------------------------------

local ActivityModeCaveLeaderboardPanel = class("ActivityModeCaveLeaderboardPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ActivityModeCaveLeaderboardPanel:init()
	ActivityModeCaveLeaderboardPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ActivityModeCaveLeaderboardPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ActivityModeCaveLeaderboardPanel:onExit()

end

return ActivityModeCaveLeaderboardPanel