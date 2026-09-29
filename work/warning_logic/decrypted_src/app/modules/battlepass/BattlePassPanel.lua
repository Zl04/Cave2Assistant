--[[--
视图BattlePassPanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/08/01
--desc	: 
------------------------------------------------------------------------------

local BattlePassPanel = class("BattlePassPanel",mvc.GamePanel)
local COM_WIDTH = 915
local COM_HEIGHT = 590
function BattlePassPanel:init()
	BattlePassPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BattlePassPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BattlePassPanel:onExit()

end

return BattlePassPanel