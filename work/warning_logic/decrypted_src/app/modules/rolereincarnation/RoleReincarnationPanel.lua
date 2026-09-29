--[[--
视图RoleReincarnationPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/03/06
--desc	: 
------------------------------------------------------------------------------

local RoleReincarnationPanel = class("RoleReincarnationPanel",mvc.GamePanel)
local COM_WIDTH = 745
local COM_HEIGHT = 518
function RoleReincarnationPanel:init()
	RoleReincarnationPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function RoleReincarnationPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function RoleReincarnationPanel:onExit()

end

return RoleReincarnationPanel