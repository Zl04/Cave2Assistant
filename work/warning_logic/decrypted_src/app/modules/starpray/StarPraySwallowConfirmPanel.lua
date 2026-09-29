--[[--
视图StarPraySwallowConfirmPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/06/26
--desc	: 
------------------------------------------------------------------------------

local StarPraySwallowConfirmPanel = class("StarPraySwallowConfirmPanel",mvc.GamePanel)
local COM_WIDTH = 429
local COM_HEIGHT = 287
function StarPraySwallowConfirmPanel:init()
	StarPraySwallowConfirmPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function StarPraySwallowConfirmPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
	self.ui:setNoticeShowMainUI(false)
end


function StarPraySwallowConfirmPanel:onExit()

end

return StarPraySwallowConfirmPanel