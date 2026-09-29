--[[--
视图BattlePassChargePanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/08/06
--desc	: 
------------------------------------------------------------------------------

local BattlePassChargePanel = class("BattlePassChargePanel",mvc.GamePanel)
local COM_WIDTH = 775
local COM_HEIGHT = 410
function BattlePassChargePanel:init()
	BattlePassChargePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function BattlePassChargePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setNoticeShowMainUI(false)
	-- self.ui:enableDebugDraw()
end


function BattlePassChargePanel:onExit()

end

return BattlePassChargePanel