--[[--
视图RelicIntensifyPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/05/19
--desc	: 
------------------------------------------------------------------------------

local RelicIntensifyPanel = class("RelicIntensifyPanel",mvc.GamePanel)
local COM_WIDTH = 482
local COM_HEIGHT = 380
function RelicIntensifyPanel:init()
	RelicIntensifyPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function RelicIntensifyPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function RelicIntensifyPanel:onExit()

end

return RelicIntensifyPanel