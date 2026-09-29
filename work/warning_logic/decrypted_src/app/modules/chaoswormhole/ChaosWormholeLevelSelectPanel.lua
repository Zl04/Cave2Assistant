--[[--
视图ChaosWormholeLevelSelectPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/08/08
--desc	: 
------------------------------------------------------------------------------

local ChaosWormholeLevelSelectPanel = class("ChaosWormholeLevelSelectPanel",mvc.GamePanel)
local COM_WIDTH = 1136
local COM_HEIGHT = 640
function ChaosWormholeLevelSelectPanel:init()
	ChaosWormholeLevelSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ChaosWormholeLevelSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ChaosWormholeLevelSelectPanel:onExit()

end

return ChaosWormholeLevelSelectPanel