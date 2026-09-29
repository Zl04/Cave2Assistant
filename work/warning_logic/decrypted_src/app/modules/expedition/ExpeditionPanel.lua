--[[--
视图ExpeditionPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/05/09
--desc	: 
------------------------------------------------------------------------------

local ExpeditionPanel = class("ExpeditionPanel",mvc.GamePanel)

local director = cc.Director:getInstance()
local view = director:getOpenGLView()
local winSize = director:getWinSize()

local COM_WIDTH = winSize.width 
local COM_HEIGHT = winSize.height

function ExpeditionPanel:init()
	ExpeditionPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.PANEL)
end

function ExpeditionPanel:onEnter()
	self.ui:setSize(COM_WIDTH, COM_HEIGHT)

	self.ui:open()
end


function ExpeditionPanel:onExit()

end

return ExpeditionPanel