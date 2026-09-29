--[[--
视图GuildTechOrSkillPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/09/27
--desc	: 
------------------------------------------------------------------------------

local GuildTechOrSkillPanel = class("GuildTechOrSkillPanel",mvc.GamePanel)
local COM_WIDTH = 920
local COM_HEIGHT = 640
function GuildTechOrSkillPanel:init()
	GuildTechOrSkillPanel.super.init(self, ViewStyle.ViewStyle_DownShowWin, mvc.VIEW_TYPE.PANEL)
end

function GuildTechOrSkillPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function GuildTechOrSkillPanel:onExit()

end

return GuildTechOrSkillPanel