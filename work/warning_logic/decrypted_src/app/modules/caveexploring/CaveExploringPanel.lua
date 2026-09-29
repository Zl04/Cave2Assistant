--[[--
视图CaveExploringPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/06/07
--desc	: 
------------------------------------------------------------------------------

local CaveExploringPanel = class("CaveExploringPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function CaveExploringPanel:init()
	CaveExploringPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function CaveExploringPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function CaveExploringPanel:onExit()

end

return CaveExploringPanel