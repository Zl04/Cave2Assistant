--[[--
视图BigSailIslandBossInfoPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/07/17
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandBossInfoPanel = class("BigSailIslandBossInfoPanel",mvc.GamePanel)
local COM_WIDTH = 1061
local COM_HEIGHT = 592
function BigSailIslandBossInfoPanel:init()
	BigSailIslandBossInfoPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailIslandBossInfoPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandBossInfoPanel:onExit()

end

return BigSailIslandBossInfoPanel