--[[--
视图HitRatRewardPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/10/10
--desc	: 
------------------------------------------------------------------------------

local HitRatRewardPanel = class("HitRatRewardPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function HitRatRewardPanel:init()
	HitRatRewardPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function HitRatRewardPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function HitRatRewardPanel:onExit()

end

return HitRatRewardPanel