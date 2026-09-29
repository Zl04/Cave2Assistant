--[[--
视图FestivalRelicStatisticPanel
]]

------------------------------------------------------------------------------
--author: yudong.li
--date	: 2020/05/11
--desc	: 
------------------------------------------------------------------------------

local FestivalRelicStatisticPanel = class("FestivalRelicStatisticPanel",mvc.GamePanel)
local COM_WIDTH = 915
local COM_HEIGHT = 590
function FestivalRelicStatisticPanel:init()
	FestivalRelicStatisticPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function FestivalRelicStatisticPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function FestivalRelicStatisticPanel:onExit()

end

return FestivalRelicStatisticPanel