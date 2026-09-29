--[[--
视图SouvenirPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/10/09
--desc	: 
------------------------------------------------------------------------------

local SouvenirPanel = class("SouvenirPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function SouvenirPanel:init()
	SouvenirPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function SouvenirPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function SouvenirPanel:onExit()

end

return SouvenirPanel