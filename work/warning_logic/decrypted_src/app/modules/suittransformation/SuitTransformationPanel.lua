--[[--
视图SuitTransformationPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/05/30
--desc	: 
------------------------------------------------------------------------------

local SuitTransformationPanel = class("SuitTransformationPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function SuitTransformationPanel:init()
	SuitTransformationPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function SuitTransformationPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function SuitTransformationPanel:onExit()

end

return SuitTransformationPanel