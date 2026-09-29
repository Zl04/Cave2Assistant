--[[--
视图StarPrayPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/04/24
--desc	: 
------------------------------------------------------------------------------

local StarPrayPanel = class("StarPrayPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function StarPrayPanel:init()
	StarPrayPanel.super.init(self, ViewStyle.ViewStyle_DownShowWin, mvc.VIEW_TYPE.PANEL)
end

function StarPrayPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()
	-- self.ui:enableDebugDraw()
end


function StarPrayPanel:onExit()

end

return StarPrayPanel