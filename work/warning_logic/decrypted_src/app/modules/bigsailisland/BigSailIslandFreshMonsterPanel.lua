--[[--
视图BigSailIslandFreshMonsterPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/08/30
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandFreshMonsterPanel = class("BigSailIslandFreshMonsterPanel",mvc.GamePanel)
local COM_WIDTH = 500
local COM_HEIGHT = 300
function BigSailIslandFreshMonsterPanel:init()
	BigSailIslandFreshMonsterPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailIslandFreshMonsterPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandFreshMonsterPanel:onExit()

end

return BigSailIslandFreshMonsterPanel