--[[--
视图BarterTablePanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/25
--desc	: 
------------------------------------------------------------------------------

local BarterTablePanel = class("BarterTablePanel",mvc.GamePanel)
local COM_WIDTH = 350
local COM_HEIGHT = 640

function BarterTablePanel:init()
	BarterTablePanel.super.init(self, ViewStyle.ViewStyle_DoorWin, mvc.VIEW_TYPE.PANEL)
end


function BarterTablePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	mvc.send(mvc.events.Barter_Table_ShowContent)
    self.ui:leftBottom(0,0)
end


function BarterTablePanel:onExit()

end

return BarterTablePanel