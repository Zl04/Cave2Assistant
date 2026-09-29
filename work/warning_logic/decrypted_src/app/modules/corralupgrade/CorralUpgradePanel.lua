--[[--
视图CorralUpgradePanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/05/10
--desc	: 
------------------------------------------------------------------------------

local CorralUpgradePanel = class("CorralUpgradePanel",mvc.GamePanel)
local COM_WIDTH = 429
local COM_HEIGHT = 287
function CorralUpgradePanel:init()
	self.alwaysShow = true
	CorralUpgradePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function CorralUpgradePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function CorralUpgradePanel:onExit()

end

return CorralUpgradePanel