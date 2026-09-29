--[[--
视图WorldBossRoomPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/05/16
--desc	: 
------------------------------------------------------------------------------

local WorldBossRoomPanel = class("WorldBossRoomPanel",mvc.GamePanel)
local COM_WIDTH = 916
local COM_HEIGHT = 592
function WorldBossRoomPanel:init()
	WorldBossRoomPanel.super.init(self, ViewStyle.ViewStyle_DownShowWin, mvc.VIEW_TYPE.PANEL)
end

function WorldBossRoomPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function WorldBossRoomPanel:onExit()

end

return WorldBossRoomPanel