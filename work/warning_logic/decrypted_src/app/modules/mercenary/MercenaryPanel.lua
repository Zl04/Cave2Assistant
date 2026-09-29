--[[--
视图MercenaryPanel
]]

------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2021/04/07
--desc	: 
------------------------------------------------------------------------------

local MercenaryPanel = class("MercenaryPanel",mvc.GamePanel)
local COM_WIDTH = 510
local COM_HEIGHT = 592
function MercenaryPanel:init()
	MercenaryPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TOP_PANEL)
end

function MercenaryPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function MercenaryPanel:onExit()

end

return MercenaryPanel