--[[--
视图WorldBossComfirmPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/05/17
--desc	: 
------------------------------------------------------------------------------

local WorldBossComfirmPanel = class("WorldBossComfirmPanel",mvc.GamePanel)
local COM_WIDTH = 530
local COM_HEIGHT = 390
function WorldBossComfirmPanel:init()
	-- WorldBossComfirmPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
	WorldBossComfirmPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.TIP)
end

function WorldBossComfirmPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open(nil, true)	
	-- self.ui:enableDebugDraw()
end


function WorldBossComfirmPanel:onExit()

end

return WorldBossComfirmPanel