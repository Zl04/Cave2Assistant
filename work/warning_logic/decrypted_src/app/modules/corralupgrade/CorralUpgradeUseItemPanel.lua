--[[--
视图CorralUpgradeUseItemPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/05/11
--desc	: 
------------------------------------------------------------------------------

local CorralUpgradeUseItemPanel = class("CorralUpgradeUseItemPanel",mvc.GamePanel)
local COM_WIDTH = 429
local COM_HEIGHT = 287
function CorralUpgradeUseItemPanel:init()
	self.alwaysShow = true
	CorralUpgradeUseItemPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function CorralUpgradeUseItemPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function CorralUpgradeUseItemPanel:onExit()

end

return CorralUpgradeUseItemPanel