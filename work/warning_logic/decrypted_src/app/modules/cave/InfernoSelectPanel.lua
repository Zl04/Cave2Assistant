--[[--
视图InfernoSelectPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2021/02/03
--desc	: 
------------------------------------------------------------------------------

local InfernoSelectPanel = class("InfernoSelectPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function InfernoSelectPanel:init()
	InfernoSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function InfernoSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function InfernoSelectPanel:onExit()

end

return InfernoSelectPanel