--[[--
视图BigSailIslandFightSelectPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/07/24
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandFightSelectPanel = class("BigSailIslandFightSelectPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigSailIslandFightSelectPanel:init()
	BigSailIslandFightSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailIslandFightSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandFightSelectPanel:onExit()

end

return BigSailIslandFightSelectPanel