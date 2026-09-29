--[[--
视图FestivalMazeTeamPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/08/05
--desc	: 
------------------------------------------------------------------------------

local FestivalMazeTeamPanel = class("FestivalMazeTeamPanel",mvc.GamePanel)
local COM_WIDTH = 1060
local COM_HEIGHT = 590
function FestivalMazeTeamPanel:init()
	FestivalMazeTeamPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function FestivalMazeTeamPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function FestivalMazeTeamPanel:onExit()

end

return FestivalMazeTeamPanel