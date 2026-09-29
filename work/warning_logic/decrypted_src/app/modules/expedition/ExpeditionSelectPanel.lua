--[[--
视图ExpeditionSelectPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/07/04
--desc	: 
------------------------------------------------------------------------------

local ExpeditionSelectPanel = class("ExpeditionSelectPanel",mvc.GamePanel)
local COM_WIDTH = 492
local COM_HEIGHT = 513
function ExpeditionSelectPanel:init()
	ExpeditionSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function ExpeditionSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
	self.ui:setNoticeShowMainUI(false)
end


function ExpeditionSelectPanel:onExit()

end

return ExpeditionSelectPanel