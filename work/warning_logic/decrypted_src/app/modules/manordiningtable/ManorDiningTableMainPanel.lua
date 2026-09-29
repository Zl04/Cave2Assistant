--[[--
视图ManorDiningTableMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/08/22
--desc	: 
------------------------------------------------------------------------------

local ManorDiningTableMainPanel = class("ManorDiningTableMainPanel",mvc.GamePanel)
local COM_WIDTH = 1024
local COM_HEIGHT = 560
function ManorDiningTableMainPanel:init()
	ManorDiningTableMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ManorDiningTableMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ManorDiningTableMainPanel:onExit()

end

return ManorDiningTableMainPanel