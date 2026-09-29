--[[--
视图RecastRefinePanel
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/07/25
--desc	: 
------------------------------------------------------------------------------

local RecastRefinePanel = class("RecastRefinePanel",mvc.GamePanel)
local COM_WIDTH = 350
local COM_HEIGHT = 640

function RecastRefinePanel:init()
	RecastRefinePanel.super.init(self, ViewStyle.ViewStyle_DoorWin, mvc.VIEW_TYPE.PANEL)
end

function RecastRefinePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	mvc.send(mvc.events.RecastRefine_ShowContent)
    self.ui:leftBottom(0,0)
end


function RecastRefinePanel:onExit()

end

return RecastRefinePanel