--[[--
视图FestivalPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/08/05
--desc	: 
------------------------------------------------------------------------------

local FestivalPanel = class("FestivalPanel",mvc.GamePanel)
local COM_WIDTH = 960
local COM_HEIGHT = 590
function FestivalPanel:init()
	FestivalPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function FestivalPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function FestivalPanel:onExit()

end

return FestivalPanel