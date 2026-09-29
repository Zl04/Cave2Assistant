--[[--
视图WorldBossWinResultPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/05/22
--desc	: 
------------------------------------------------------------------------------

local WorldBossWinResultPanel = class("WorldBossWinResultPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()

-- 尺寸
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
function WorldBossWinResultPanel:init()
	WorldBossWinResultPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function WorldBossWinResultPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function WorldBossWinResultPanel:onExit()

end

return WorldBossWinResultPanel