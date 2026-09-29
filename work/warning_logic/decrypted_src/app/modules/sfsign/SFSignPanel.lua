--[[--
视图SFSignPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2020/01/08
--desc	: 
------------------------------------------------------------------------------

local SFSignPanel = class("SFSignPanel",mvc.GamePanel)
local COM_WIDTH = 988
local COM_HEIGHT = 564
function SFSignPanel:init()
	SFSignPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function SFSignPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function SFSignPanel:onExit()

end

return SFSignPanel