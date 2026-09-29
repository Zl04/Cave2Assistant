--[[--
视图BigSailIslandBossDmgRankPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/07/18
--desc	: 
------------------------------------------------------------------------------

local BigSailIslandBossDmgRankPanel = class("BigSailIslandBossDmgRankPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigSailIslandBossDmgRankPanel:init()
	BigSailIslandBossDmgRankPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigSailIslandBossDmgRankPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function BigSailIslandBossDmgRankPanel:onExit()

end

return BigSailIslandBossDmgRankPanel