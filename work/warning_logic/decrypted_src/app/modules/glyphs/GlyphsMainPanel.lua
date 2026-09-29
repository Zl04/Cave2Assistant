--[[--
视图GlyphsMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/10/19
--desc	: 
------------------------------------------------------------------------------

local GlyphsMainPanel = class("GlyphsMainPanel",mvc.GamePanel)
local COM_WIDTH = 1024
local COM_HEIGHT = 560
function GlyphsMainPanel:init()
	GlyphsMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function GlyphsMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function GlyphsMainPanel:onExit()

end

return GlyphsMainPanel