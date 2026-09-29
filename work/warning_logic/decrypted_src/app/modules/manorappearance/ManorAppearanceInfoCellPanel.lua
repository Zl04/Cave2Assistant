--[[--
视图ManorAppearanceInfoCellPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/07/25
--desc	: 
------------------------------------------------------------------------------

local ManorAppearanceInfoCellPanel = class("ManorAppearanceInfoCellPanel",mvc.GamePanel)
local COM_WIDTH = 385
local COM_HEIGHT = 488
function ManorAppearanceInfoCellPanel:init()
	ManorAppearanceInfoCellPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function ManorAppearanceInfoCellPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setNoticeShowMainUI(false)
	-- self.ui:enableDebugDraw()
end


function ManorAppearanceInfoCellPanel:onExit()

end

return ManorAppearanceInfoCellPanel