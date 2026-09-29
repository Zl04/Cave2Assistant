--[[--
视图ComebackPackagePanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/05/26
--desc	: 
------------------------------------------------------------------------------

local ComebackPackagePanel = class("ComebackPackagePanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ComebackPackagePanel:init()
	ComebackPackagePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ComebackPackagePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ComebackPackagePanel:onExit()

end

return ComebackPackagePanel