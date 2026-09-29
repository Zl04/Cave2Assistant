--[[--
视图CaveStateBagPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2021/02/18
--desc	: 
------------------------------------------------------------------------------

local CaveStateBagPanel = class("CaveStateBagPanel",mvc.GamePanel)
local COM_WIDTH = 915
local COM_HEIGHT = 590
function CaveStateBagPanel:init()
	CaveStateBagPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function CaveStateBagPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function CaveStateBagPanel:onExit()

end

return CaveStateBagPanel