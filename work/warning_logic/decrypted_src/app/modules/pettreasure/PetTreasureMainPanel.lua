--[[--
视图PetTreasureMainPanel
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/24
--desc	: 
------------------------------------------------------------------------------

local PetTreasureMainPanel = class("PetTreasureMainPanel",mvc.GamePanel)
local COM_WIDTH = 920
local COM_HEIGHT = 580
function PetTreasureMainPanel:init()
	PetTreasureMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetTreasureMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetTreasureMainPanel:onExit()

end

return PetTreasureMainPanel