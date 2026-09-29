--[[--
视图ActivityPointPanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/06/26
--desc	: 
------------------------------------------------------------------------------

local ActivityPointPanel = class("ActivityPointPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ActivityPointPanel:init()
	ActivityPointPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ActivityPointPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ActivityPointPanel:onExit()

end

return ActivityPointPanel