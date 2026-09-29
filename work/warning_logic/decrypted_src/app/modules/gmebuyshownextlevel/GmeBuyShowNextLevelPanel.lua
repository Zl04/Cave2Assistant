--[[--
视图GmeBuyShowNextLevelPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/12/29
--desc	: 
------------------------------------------------------------------------------

local GmeBuyShowNextLevelPanel = class("GmeBuyShowNextLevelPanel",mvc.GamePanel)
local COM_WIDTH = 671
local COM_HEIGHT = 454
function GmeBuyShowNextLevelPanel:init()
	GmeBuyShowNextLevelPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function GmeBuyShowNextLevelPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
	self.ui.dontShowPanel = true
end


function GmeBuyShowNextLevelPanel:onExit()

end

return GmeBuyShowNextLevelPanel