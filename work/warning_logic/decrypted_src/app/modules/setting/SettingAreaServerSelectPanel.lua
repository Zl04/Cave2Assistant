--[[--
视图SettingAreaServerSelectPanel
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/21
--desc	: 
------------------------------------------------------------------------------

local SettingAreaServerSelectPanel = class("SettingAreaServerSelectPanel",mvc.GamePanel)
local COM_WIDTH = 700
local COM_HEIGHT = 485
function SettingAreaServerSelectPanel:init()
	SettingAreaServerSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function SettingAreaServerSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
	self.ui:setNoticeShowMainUI(false)
end


function SettingAreaServerSelectPanel:onExit()

end

return SettingAreaServerSelectPanel