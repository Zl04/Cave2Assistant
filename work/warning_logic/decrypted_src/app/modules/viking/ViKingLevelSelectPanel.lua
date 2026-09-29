--[[--
视图ViKingLevelSelectPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/12/23
--desc	: 
------------------------------------------------------------------------------

local ViKingLevelSelectPanel = class("ViKingLevelSelectPanel",mvc.GamePanel)
local COM_WIDTH = 1136
local COM_HEIGHT = 640
function ViKingLevelSelectPanel:init()
	ViKingLevelSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ViKingLevelSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ViKingLevelSelectPanel:onExit()

end

return ViKingLevelSelectPanel