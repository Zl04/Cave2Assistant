--[[--
视图PuzzleResultPanel
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/08/03
--desc	: 
------------------------------------------------------------------------------

local PuzzleResultPanel = class("PuzzleResultPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
function PuzzleResultPanel:init()
	PuzzleResultPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function PuzzleResultPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PuzzleResultPanel:onExit()

end

return PuzzleResultPanel