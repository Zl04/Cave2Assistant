--[[--
视图ArenaPanel
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/29
--desc	: 
------------------------------------------------------------------------------

local ArenaPanel = class("ArenaPanel",mvc.GamePanel)
local COM_WIDTH = 1136
local COM_HEIGHT = 640
function ArenaPanel:init()
	ArenaPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ArenaPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ArenaPanel:onExit()

end

return ArenaPanel