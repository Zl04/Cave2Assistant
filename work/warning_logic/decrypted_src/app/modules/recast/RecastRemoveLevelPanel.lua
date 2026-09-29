--[[--
视图RecastRemoveLevelPanel
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/07/19
--desc	: 
------------------------------------------------------------------------------

local RecastRemoveLevelPanel = class("RecastRemoveLevelPanel",mvc.GamePanel)
local COM_WIDTH = 0
local COM_HEIGHT = 0
function RecastRemoveLevelPanel:init()
	RecastRemoveLevelPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.PANEL)
end

function RecastRemoveLevelPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:centerLeft(0)
	self.ui:enableDebugDraw()
	-- self.ui:enableDebugDraw()
end


function RecastRemoveLevelPanel:onExit()

end

return RecastRemoveLevelPanel