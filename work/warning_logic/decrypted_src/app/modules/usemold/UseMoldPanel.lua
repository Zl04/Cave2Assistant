--[[--
视图UseMoldPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/25
--desc	: 
------------------------------------------------------------------------------

local UseMoldPanel = class("UseMoldPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = 350
local COM_HEIGHT = 440

function UseMoldPanel:init()
	UseMoldPanel.super.init(self, ViewStyle.ViewStyle_DoorWin, mvc.VIEW_TYPE.PANEL)
end

function UseMoldPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	mvc.send(mvc.events.UseMold_ShowContent)
    self.ui:leftBottom(0,0)
	-- self.ui:enableDebugDraw()
end


function UseMoldPanel:onExit()

end

return UseMoldPanel