--[[--
视图FestivalRelicsSelectPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2020/05/11
--desc	: 
------------------------------------------------------------------------------

local FestivalRelicsSelectPanel = class("FestivalRelicsSelectPanel",mvc.GamePanel)
local COM_WIDTH = 852
local COM_HEIGHT = 534
function FestivalRelicsSelectPanel:init()
	FestivalRelicsSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function FestivalRelicsSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function FestivalRelicsSelectPanel:onExit()

end

return FestivalRelicsSelectPanel