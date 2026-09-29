--[[--
视图FestivalExchangeShopPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2020/05/08
--desc	: 
------------------------------------------------------------------------------

local FestivalExchangeShopPanel = class("FestivalExchangeShopPanel",mvc.GamePanel)
local COM_WIDTH = 760
local COM_HEIGHT = 540
function FestivalExchangeShopPanel:init()
	FestivalExchangeShopPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function FestivalExchangeShopPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function FestivalExchangeShopPanel:onExit()

end

return FestivalExchangeShopPanel