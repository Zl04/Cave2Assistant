--[[--
视图ChaosWormholeMainPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/08/08
--desc	: 
------------------------------------------------------------------------------

local ChaosWormholeMainPanel = class("ChaosWormholeMainPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ChaosWormholeMainPanel:init()
	ChaosWormholeMainPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ChaosWormholeMainPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ChaosWormholeMainPanel:onExit()

end

return ChaosWormholeMainPanel