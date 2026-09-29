--[[--
视图GuildInfoPanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/10/08
--desc	: 
------------------------------------------------------------------------------

local GuildInfoPanel = class("GuildInfoPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function GuildInfoPanel:init()
	GuildInfoPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function GuildInfoPanel:onEnter()
	self.ui:setNoticeShowMainUI(false)
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function GuildInfoPanel:onExit()

end

return GuildInfoPanel