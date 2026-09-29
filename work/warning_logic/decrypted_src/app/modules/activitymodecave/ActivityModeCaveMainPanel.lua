--[[--
视图ActivityModeCaveMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/10/28
--desc	: 
------------------------------------------------------------------------------

local ActivityModeCaveMainPanel = class("ActivityModeCaveMainPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()

function ActivityModeCaveMainPanel:init()
	ActivityModeCaveMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ActivityModeCaveMainPanel:onEnter()
	self.ui:setSize(winSize.width, winSize.height)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ActivityModeCaveMainPanel:onExit()

end

return ActivityModeCaveMainPanel