--[[--
视图HitRatMatchPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/14
--desc	: 
------------------------------------------------------------------------------

local HitRatMatchPanel = class("HitRatMatchPanel",mvc.GamePanel)

local COM_WIDTH = 800
local COM_HEIGHT = 500
function HitRatMatchPanel:init()
	HitRatMatchPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function HitRatMatchPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function HitRatMatchPanel:onExit()

end

return HitRatMatchPanel