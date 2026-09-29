--[[--
视图BigCrackReadyPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/11/01
--desc	: 
------------------------------------------------------------------------------

local BigCrackReadyPanel = class("BigCrackReadyPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigCrackReadyPanel:init()
	BigCrackReadyPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigCrackReadyPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
end


function BigCrackReadyPanel:onExit()

end

return BigCrackReadyPanel