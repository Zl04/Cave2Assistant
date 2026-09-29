--[[--
视图FullScreeenEffectPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2020/05/06
--desc	: 
------------------------------------------------------------------------------

local FullScreeenEffectPanel = class("FullScreeenEffectPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function FullScreeenEffectPanel:init()
	FullScreeenEffectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.MAX)
end

function FullScreeenEffectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function FullScreeenEffectPanel:onExit()

end

return FullScreeenEffectPanel