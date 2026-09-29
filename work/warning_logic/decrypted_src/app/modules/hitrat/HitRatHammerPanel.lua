--[[--
视图HitRatHammerPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/10/16
--desc	: 
------------------------------------------------------------------------------

local HitRatHammerPanel = class("HitRatHammerPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function HitRatHammerPanel:init()
	HitRatHammerPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function HitRatHammerPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open(nil, true)	
	self.ui:setNoticeShowMainUI(false)
    self.ui:rightBottom(20, 150)
	-- self.ui:enableDebugDraw()
end


function HitRatHammerPanel:onExit()

end

return HitRatHammerPanel