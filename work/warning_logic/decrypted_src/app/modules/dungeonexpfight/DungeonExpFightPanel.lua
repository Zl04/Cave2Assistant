--[[--
视图DungeonExpFightPanel
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/08/07
--desc	: 
------------------------------------------------------------------------------

local DungeonExpFightPanel = class("DungeonExpFightPanel",mvc.GamePanel)
local COM_WIDTH = 610
local COM_HEIGHT = 560
function DungeonExpFightPanel:init()
	DungeonExpFightPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function DungeonExpFightPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function DungeonExpFightPanel:onExit()

end

return DungeonExpFightPanel