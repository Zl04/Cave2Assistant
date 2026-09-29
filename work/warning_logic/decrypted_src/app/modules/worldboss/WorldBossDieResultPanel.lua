--[[--
视图WorldBossDieResultPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/05/22
--desc	: 
------------------------------------------------------------------------------

local WorldBossDieResultPanel = class("WorldBossDieResultPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()

-- 尺寸
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
function WorldBossDieResultPanel:init()
	WorldBossDieResultPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function WorldBossDieResultPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open(nil, true)	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function WorldBossDieResultPanel:onExit()

end

return WorldBossDieResultPanel