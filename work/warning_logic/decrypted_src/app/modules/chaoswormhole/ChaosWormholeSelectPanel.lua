--[[--
视图ChaosWormholeSelectPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/08/08
--desc	: 
------------------------------------------------------------------------------

local ChaosWormholeSelectPanel = class("ChaosWormholeSelectPanel",mvc.GamePanel)
local COM_WIDTH = 353
local COM_HEIGHT = 310
function ChaosWormholeSelectPanel:init()
	ChaosWormholeSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TIP)
end

function ChaosWormholeSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ChaosWormholeSelectPanel:onExit()

end

return ChaosWormholeSelectPanel