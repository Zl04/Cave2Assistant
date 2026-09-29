--[[--
视图ManorDressUpShelfPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/08/15
--desc	: 
------------------------------------------------------------------------------

local ManorDressUpShelfPanel = class("ManorDressUpShelfPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ManorDressUpShelfPanel:init()
	ManorDressUpShelfPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ManorDressUpShelfPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ManorDressUpShelfPanel:onExit()

end

return ManorDressUpShelfPanel