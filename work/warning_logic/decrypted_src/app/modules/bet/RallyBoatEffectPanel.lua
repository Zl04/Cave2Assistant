--[[--
视图RallyBoatEffectPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2024/01/18
--desc	: 
------------------------------------------------------------------------------

local RallyBoatEffectPanel = class("RallyBoatEffectPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
function RallyBoatEffectPanel:init()
	RallyBoatEffectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TOP_PANEL)
end

function RallyBoatEffectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function RallyBoatEffectPanel:onExit()

end

return RallyBoatEffectPanel