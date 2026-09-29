--[[--
视图PetSitePanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2021/10/09
--desc	: 
------------------------------------------------------------------------------

local PetSitePanel = class("PetSitePanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function PetSitePanel:init()
	PetSitePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PetSitePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetSitePanel:onExit()

end

return PetSitePanel