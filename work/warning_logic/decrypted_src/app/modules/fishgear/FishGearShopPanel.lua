--[[--
视图FishGearShopPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/04/13
--desc	: 
------------------------------------------------------------------------------

local FishGearShopPanel = class("FishGearShopPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function FishGearShopPanel:init()
	FishGearShopPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function FishGearShopPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function FishGearShopPanel:onExit()

end

return FishGearShopPanel