--[[--
视图RallyBoatInfoPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2024/01/19
--desc	: 
------------------------------------------------------------------------------

local RallyBoatInfoPanel = class("RallyBoatInfoPanel",mvc.GamePanel)

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

function RallyBoatInfoPanel:init()
	RallyBoatInfoPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TOP_PANEL)
end

function RallyBoatInfoPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function RallyBoatInfoPanel:onExit()

end

return RallyBoatInfoPanel