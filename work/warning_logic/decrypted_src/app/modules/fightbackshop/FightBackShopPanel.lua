--[[--
视图FightBackShopPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2021/06/25
--desc	: 
------------------------------------------------------------------------------

local FightBackShopPanel = class("FightBackShopPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function FightBackShopPanel:init()
	FightBackShopPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function FightBackShopPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function FightBackShopPanel:onExit()

end

return FightBackShopPanel