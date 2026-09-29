--[[--
视图LimitTimePackagePanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/05/07
--desc	: 
------------------------------------------------------------------------------

local LimitTimePackagePanel = class("LimitTimePackagePanel",mvc.GamePanel)
local COM_WIDTH = 650
local COM_HEIGHT = 490
function LimitTimePackagePanel:init()
	LimitTimePackagePanel.super.init(self, ViewStyle.ViewStyle_DownShowWin, mvc.VIEW_TYPE.PANEL)
end

function LimitTimePackagePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()
end


function LimitTimePackagePanel:onExit()

end

return LimitTimePackagePanel