--[[--
视图ManorAppearanceMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/07/21
--desc	: 
------------------------------------------------------------------------------

local ManorAppearanceMainPanel = class("ManorAppearanceMainPanel",mvc.GamePanel)
local COM_WIDTH = 1024
local COM_HEIGHT = 560
function ManorAppearanceMainPanel:init()
	ManorAppearanceMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ManorAppearanceMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ManorAppearanceMainPanel:onExit()

end

return ManorAppearanceMainPanel