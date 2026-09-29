--[[--
视图StarPraySwallowSettingPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/06/26
--desc	: 
------------------------------------------------------------------------------

local StarPraySwallowSettingPanel = class("StarPraySwallowSettingPanel",mvc.GamePanel)
local COM_WIDTH = 537
local COM_HEIGHT = 372
function StarPraySwallowSettingPanel:init()
	StarPraySwallowSettingPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TIP)
end

function StarPraySwallowSettingPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setNoticeShowMainUI(false)
	-- self.ui:enableDebugDraw()
end


function StarPraySwallowSettingPanel:onExit()

end

return StarPraySwallowSettingPanel