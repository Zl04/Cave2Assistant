--[[--
视图PurpleUpgradeMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/12/11
--desc	: 
------------------------------------------------------------------------------

local PurpleUpgradeMainPanel = class("PurpleUpgradeMainPanel",mvc.GamePanel)
local COM_WIDTH = 1024
local COM_HEIGHT = 560
function PurpleUpgradeMainPanel:init()
	PurpleUpgradeMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PurpleUpgradeMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PurpleUpgradeMainPanel:onExit()

end

return PurpleUpgradeMainPanel