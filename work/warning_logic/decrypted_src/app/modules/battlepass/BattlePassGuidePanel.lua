--[[--
视图BattlePassGuidePanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/08/07
--desc	: 
------------------------------------------------------------------------------

local BattlePassGuidePanel = class("BattlePassGuidePanel",mvc.GamePanel)
local COM_WIDTH = 330
local COM_HEIGHT = 465
function BattlePassGuidePanel:init()
	BattlePassGuidePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function BattlePassGuidePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setNoticeShowMainUI(false)
end


function BattlePassGuidePanel:onExit()

end

return BattlePassGuidePanel