--[[--
视图RallySkillTargetChoicePanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2024/01/11
--desc	: 
------------------------------------------------------------------------------

local RallySkillTargetChoicePanel = class("RallySkillTargetChoicePanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

function RallySkillTargetChoicePanel:init()
	RallySkillTargetChoicePanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TOP_PANEL)
end

function RallySkillTargetChoicePanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function RallySkillTargetChoicePanel:onExit()

end

return RallySkillTargetChoicePanel