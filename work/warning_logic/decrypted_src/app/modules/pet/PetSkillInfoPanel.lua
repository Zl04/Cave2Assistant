--[[--
视图PetSkillInfoPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/30
--desc	: 
------------------------------------------------------------------------------

local PetSkillInfoPanel = class("PetSkillInfoPanel",mvc.GamePanel)
local COM_WIDTH = 315
local COM_HEIGHT = 365
function PetSkillInfoPanel:init()
	PetSkillInfoPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function PetSkillInfoPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function PetSkillInfoPanel:onExit()

end

return PetSkillInfoPanel