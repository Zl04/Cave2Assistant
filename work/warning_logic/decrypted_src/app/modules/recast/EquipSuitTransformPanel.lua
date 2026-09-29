--[[--
视图EquipSuitTransformPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/08/14
--desc	: 
------------------------------------------------------------------------------

local EquipSuitTransformPanel = class("EquipSuitTransformPanel",mvc.GamePanel)
local COM_WIDTH = 350
local COM_HEIGHT = 640
function EquipSuitTransformPanel:init()
	EquipSuitTransformPanel.super.init(self, ViewStyle.ViewStyle_DoorWin, mvc.VIEW_TYPE.PANEL)
end

function EquipSuitTransformPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	mvc.send(mvc.events.Recast_Suit_Transform_Show)
    self.ui:leftBottom(0,0)
end

function EquipSuitTransformPanel:onExit()

end

return EquipSuitTransformPanel