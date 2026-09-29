--[[--
视图SouvenirActiveTipsPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/10/12
--desc	: 
------------------------------------------------------------------------------

local SouvenirActiveTipsPanel = class("SouvenirActiveTipsPanel",mvc.GamePanel)
local COM_WIDTH = 429
local COM_HEIGHT = 327
function SouvenirActiveTipsPanel:init()
	self.alwaysShow = true --不会隐藏上一个界面
	SouvenirActiveTipsPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function SouvenirActiveTipsPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function SouvenirActiveTipsPanel:onExit()

end

return SouvenirActiveTipsPanel