--[[--
视图DeepInWormholeMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/11/28
--desc	: 
------------------------------------------------------------------------------

local DeepInWormholeMainPanel = class("DeepInWormholeMainPanel",mvc.GamePanel)
local COM_WIDTH = 1136
local COM_HEIGHT = 560
function DeepInWormholeMainPanel:init()
	DeepInWormholeMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function DeepInWormholeMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function DeepInWormholeMainPanel:onExit()

end

return DeepInWormholeMainPanel