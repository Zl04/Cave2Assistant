--[[--
视图CrystalTreatureShopPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/04/23
--desc	: 
------------------------------------------------------------------------------

local CrystalTreatureShopPanel = class("CrystalTreatureShopPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function CrystalTreatureShopPanel:init()
	CrystalTreatureShopPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function CrystalTreatureShopPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function CrystalTreatureShopPanel:onExit()

end

return CrystalTreatureShopPanel