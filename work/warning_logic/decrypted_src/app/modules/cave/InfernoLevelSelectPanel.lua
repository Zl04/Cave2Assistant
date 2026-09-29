--[[--
视图InfernoLevelSelectPanel
]]

------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2021/02/02
--desc	: 
------------------------------------------------------------------------------

local InfernoLevelSelectPanel = class("InfernoLevelSelectPanel",mvc.GamePanel)
local COM_WIDTH = 1136
local COM_HEIGHT = 640
function InfernoLevelSelectPanel:init()
	InfernoLevelSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function InfernoLevelSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function InfernoLevelSelectPanel:onExit()

end

return InfernoLevelSelectPanel