--[[--
视图VoidRiftSelectPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/26
--desc	: 
------------------------------------------------------------------------------

local VoidRiftSelectPanel = class("VoidRiftSelectPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function VoidRiftSelectPanel:init()
	VoidRiftSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function VoidRiftSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function VoidRiftSelectPanel:onExit()

end

return VoidRiftSelectPanel