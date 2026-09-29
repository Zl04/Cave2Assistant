--[[--
视图RuneMoldPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/20
--desc	: 
------------------------------------------------------------------------------

local RuneMoldPanel = class("RuneMoldPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 1024--winSize.width
local COM_HEIGHT = 560
function RuneMoldPanel:init()
	RuneMoldPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function RuneMoldPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function RuneMoldPanel:onExit()

end

return RuneMoldPanel