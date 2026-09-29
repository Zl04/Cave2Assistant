--[[--
视图SevenDaysPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/08/16
--desc	: 
------------------------------------------------------------------------------

local SevenDaysPanel = class("SevenDaysPanel",mvc.GamePanel)
local COM_WIDTH = 1000
local COM_HEIGHT = 600
function SevenDaysPanel:init()
	SevenDaysPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.PANEL)
end

function SevenDaysPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function SevenDaysPanel:onExit()

end

return SevenDaysPanel