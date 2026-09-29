--[[--
视图HitRatResultPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/16
--desc	: 
------------------------------------------------------------------------------

local HitRatResultPanel = class("HitRatResultPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
function HitRatResultPanel:init()
	HitRatResultPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TOP_PANEL)
end

function HitRatResultPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function HitRatResultPanel:onExit()

end

return HitRatResultPanel