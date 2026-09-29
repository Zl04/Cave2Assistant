--[[--
视图ManorStarMapMosaicPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/07/11
--desc	: 
------------------------------------------------------------------------------

local ManorStarMapMosaicPanel = class("ManorStarMapMosaicPanel",mvc.GamePanel)
local COM_WIDTH = 689
local COM_HEIGHT = 568
function ManorStarMapMosaicPanel:init()
	ManorStarMapMosaicPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ManorStarMapMosaicPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ManorStarMapMosaicPanel:onExit()

end

return ManorStarMapMosaicPanel