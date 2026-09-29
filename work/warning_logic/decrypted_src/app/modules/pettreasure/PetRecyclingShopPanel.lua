--[[--
视图PetRecyclingShopPanel
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/06/08
--desc	: 
------------------------------------------------------------------------------

local PetRecyclingShopPanel = class("PetRecyclingShopPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function PetRecyclingShopPanel:init()
	PetRecyclingShopPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetRecyclingShopPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetRecyclingShopPanel:onExit()

end

return PetRecyclingShopPanel