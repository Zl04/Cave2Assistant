--[[--
视图ViKingMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/12/23
--desc	: 
------------------------------------------------------------------------------

local ViKingMainPanel = class("ViKingMainPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ViKingMainPanel:init()
	ViKingMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ViKingMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ViKingMainPanel:onExit()

end

return ViKingMainPanel