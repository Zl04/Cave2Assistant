--[[--
视图GuildLogPanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/10/15
--desc	: 
------------------------------------------------------------------------------

local GuildLogPanel = class("GuildLogPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()
function GuildLogPanel:init(params)
	self._initWorldPos = params
	GuildLogPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function GuildLogPanel:onEnter()
	self.ui:setNoticeShowMainUI(false)
	self.ui:setSize(winSize.width, winSize.height)
	self.ui:open()
	-- self.ui:enableDebugDraw()
end


function GuildLogPanel:onExit()

end

return GuildLogPanel