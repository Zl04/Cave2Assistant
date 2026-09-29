--[[--
视图GhostabyssLevelSelectPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2021/10/18
--desc	: 
------------------------------------------------------------------------------

local GhostabyssLevelSelectPanel = class("GhostabyssLevelSelectPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function GhostabyssLevelSelectPanel:init()
	GhostabyssLevelSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function GhostabyssLevelSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function GhostabyssLevelSelectPanel:onExit()

end

return GhostabyssLevelSelectPanel