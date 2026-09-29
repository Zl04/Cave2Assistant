--[[--
视图ViKingSelectPanel
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/12/23
--desc	: 
------------------------------------------------------------------------------

local ViKingSelectPanel = class("ViKingSelectPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function ViKingSelectPanel:init()
	ViKingSelectPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function ViKingSelectPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function ViKingSelectPanel:onExit()

end

return ViKingSelectPanel