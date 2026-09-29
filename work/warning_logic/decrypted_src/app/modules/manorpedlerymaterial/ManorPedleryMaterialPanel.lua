--[[--
视图ManorPedleryMaterialPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2023/01/31
--desc	: 
------------------------------------------------------------------------------

local ManorPedleryMaterialPanel = class("ManorPedleryMaterialPanel",mvc.GamePanel)
local COM_WIDTH = 486
local COM_HEIGHT = 356
function ManorPedleryMaterialPanel:init()
	ManorPedleryMaterialPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ManorPedleryMaterialPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ManorPedleryMaterialPanel:onExit()

end

return ManorPedleryMaterialPanel