--[[--
视图WorldBossFightCDPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/06/05
--desc	: 
------------------------------------------------------------------------------

local WorldBossFightCDPanel = class("WorldBossFightCDPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function WorldBossFightCDPanel:init()
	WorldBossFightCDPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.TIP)
end

function WorldBossFightCDPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open(nil, true)	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function WorldBossFightCDPanel:onExit()

end

return WorldBossFightCDPanel