--[[--
视图ManorStarMapGetCardPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/07/18
--desc	: 
------------------------------------------------------------------------------

local ManorStarMapGetCardPanel = class("ManorStarMapGetCardPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
function ManorStarMapGetCardPanel:init()
	ManorStarMapGetCardPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ManorStarMapGetCardPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function ManorStarMapGetCardPanel:onExit()

end

return ManorStarMapGetCardPanel