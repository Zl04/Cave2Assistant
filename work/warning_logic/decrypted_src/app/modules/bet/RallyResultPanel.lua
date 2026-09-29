--[[--
视图RallyResultPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2024/01/10
--desc	: 
------------------------------------------------------------------------------

local RallyResultPanel = class("RallyResultPanel",mvc.GamePanel)

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

function RallyResultPanel:init()
	RallyResultPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TOP_PANEL)
end

function RallyResultPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function RallyResultPanel:onExit()

end

return RallyResultPanel