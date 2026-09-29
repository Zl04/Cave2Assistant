--[[--
视图HitRatRankPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/10/10
--desc	: 
------------------------------------------------------------------------------

local HitRatRankPanel = class("HitRatRankPanel",mvc.GamePanel)

local COM_WIDTH = 250
local COM_HEIGHT = 110

function HitRatRankPanel:init()
	HitRatRankPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.MAIN_UI)
end

function HitRatRankPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open(nil, true)	
	self.ui:setNoticeShowMainUI(false)
    self.ui:rightBottom(20, 150)
end


function HitRatRankPanel:onExit()

end

return HitRatRankPanel