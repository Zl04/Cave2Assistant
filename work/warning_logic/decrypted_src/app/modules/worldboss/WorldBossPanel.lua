--[[--
视图WorldBossPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/05/16
--desc	: 
------------------------------------------------------------------------------

local WorldBossPanel = class("WorldBossPanel",mvc.GamePanel)
local COM_WIDTH = 830
local COM_HEIGHT = 580
function WorldBossPanel:init()
	WorldBossPanel.super.init(self, ViewStyle.ViewStyle_DownShowWin, mvc.VIEW_TYPE.PANEL)
end

function WorldBossPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function WorldBossPanel:onExit()

end

return WorldBossPanel