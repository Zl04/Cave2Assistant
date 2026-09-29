--[[--
视图StarPrayShopPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/04/25
--desc	: 
------------------------------------------------------------------------------

local StarPrayShopPanel = class("StarPrayShopPanel",mvc.GamePanel)

local COM_WIDTH = 965
local COM_HEIGHT = 555
function StarPrayShopPanel:init()
	StarPrayShopPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function StarPrayShopPanel:onEnter()
    -- local winSize = cc.Director:getInstance():getWinSize()
	self.ui:setSize(COM_WIDTH, COM_HEIGHT)
	self.ui:open()
end


function StarPrayShopPanel:onExit()

end

return StarPrayShopPanel