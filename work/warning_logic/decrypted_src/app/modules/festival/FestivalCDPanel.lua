--[[--
视图FestivalCDPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/08/15
--desc	: 
------------------------------------------------------------------------------

local FestivalCDPanel = class("FestivalCDPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function FestivalCDPanel:init()
	FestivalCDPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TIP)
end

function FestivalCDPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function FestivalCDPanel:onExit()

end

return FestivalCDPanel