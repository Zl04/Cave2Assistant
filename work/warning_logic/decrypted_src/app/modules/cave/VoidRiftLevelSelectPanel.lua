--[[--
视图VoidRiftLevelSelectPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/26
--desc	: 
------------------------------------------------------------------------------

local VoidRiftLevelSelectPanel = class("VoidRiftLevelSelectPanel",mvc.GamePanel)
local COM_WIDTH = 1136
local COM_HEIGHT = 640
function VoidRiftLevelSelectPanel:init()
	VoidRiftLevelSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function VoidRiftLevelSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function VoidRiftLevelSelectPanel:onExit()

end

return VoidRiftLevelSelectPanel