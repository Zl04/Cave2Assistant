--[[--
视图FestivalRewardPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/08/05
--desc	: 
------------------------------------------------------------------------------

local FestivalRewardPanel = class("FestivalRewardPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = winSize.width 
local COM_HEIGHT = winSize.height
function FestivalRewardPanel:init()
	FestivalRewardPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function FestivalRewardPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function FestivalRewardPanel:onExit()

end

return FestivalRewardPanel