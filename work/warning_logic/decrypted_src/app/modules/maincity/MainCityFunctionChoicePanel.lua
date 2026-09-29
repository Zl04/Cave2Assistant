--[[--
视图MainCityFunctionChoicePanel
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/10/16
--desc	: 
------------------------------------------------------------------------------

local MainCityFunctionChoicePanel = class("MainCityFunctionChoicePanel",mvc.GamePanel)
local COM_WIDTH = 978
local COM_HEIGHT = 246
function MainCityFunctionChoicePanel:init()
	MainCityFunctionChoicePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function MainCityFunctionChoicePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function MainCityFunctionChoicePanel:onExit()

end

return MainCityFunctionChoicePanel