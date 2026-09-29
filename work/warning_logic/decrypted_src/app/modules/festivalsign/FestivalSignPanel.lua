--[[--
视图FestivalSignPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2021/08/24
--desc	: 
------------------------------------------------------------------------------

local FestivalSignPanel = class("FestivalSignPanel",mvc.GamePanel)
local COM_WIDTH = 1000
local COM_HEIGHT = 600
function FestivalSignPanel:init()
	FestivalSignPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function FestivalSignPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function FestivalSignPanel:onExit()

end

return FestivalSignPanel