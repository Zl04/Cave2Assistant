--[[--
视图HitRatHammerInfoPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/10/16
--desc	: 
------------------------------------------------------------------------------

local HitRatHammerInfoPanel = class("HitRatHammerInfoPanel",mvc.GamePanel)

local COM_WIDTH = 400
local COM_HEIGHT = 134
function HitRatHammerInfoPanel:init()
	HitRatHammerInfoPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.MAIN_UI)
end

function HitRatHammerInfoPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open(nil, true)	
	self.ui:setNoticeShowMainUI(false)
    self.ui:centerBottom(30)
	-- self.ui:enableDebugDraw()
end


function HitRatHammerInfoPanel:onExit()

end

return HitRatHammerInfoPanel