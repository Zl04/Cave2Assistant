--[[--
视图GuildSelectFloorPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/05/28
--desc	: 
------------------------------------------------------------------------------

local GuildSelectFloorPanel = class("GuildSelectFloorPanel",mvc.GamePanel)
local COM_WIDTH = 910
local COM_HEIGHT = 610
function GuildSelectFloorPanel:init()
	GuildSelectFloorPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function GuildSelectFloorPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function GuildSelectFloorPanel:onExit()

end

return GuildSelectFloorPanel