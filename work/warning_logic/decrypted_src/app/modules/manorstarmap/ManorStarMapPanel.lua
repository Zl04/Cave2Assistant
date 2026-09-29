--[[--
视图ManorStarMapPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/27
--desc	: 
------------------------------------------------------------------------------

local ManorStarMapPanel = class("ManorStarMapPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ManorStarMapPanel:init()
	ManorStarMapPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ManorStarMapPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ManorStarMapPanel:onExit()

end

return ManorStarMapPanel