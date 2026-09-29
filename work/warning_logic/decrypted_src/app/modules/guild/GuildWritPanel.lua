--[[--
视图GuildWritPanel
]]

------------------------------------------------------------------------------
--author: yudong.li
--date	: 2020/02/28
--desc	: 
------------------------------------------------------------------------------

local GuildWritPanel = class("GuildWritPanel",mvc.GamePanel)
local COM_WIDTH = 951
local COM_HEIGHT = 592
function GuildWritPanel:init()
	GuildWritPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function GuildWritPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function GuildWritPanel:onExit()

end

return GuildWritPanel