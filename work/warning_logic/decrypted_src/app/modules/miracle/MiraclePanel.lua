--[[--
视图MiraclePanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2020/12/07
--desc	: 
------------------------------------------------------------------------------

local MiraclePanel = class("MiraclePanel",mvc.GamePanel)
local COM_WIDTH = 880
local COM_HEIGHT = 592
function MiraclePanel:init()
	MiraclePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function MiraclePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function MiraclePanel:onExit()

end

return MiraclePanel