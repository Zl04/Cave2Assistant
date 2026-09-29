--[[--
视图BigCrackResultPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/11/01
--desc	: 
------------------------------------------------------------------------------

local BigCrackResultPanel = class("BigCrackResultPanel",mvc.GamePanel)
local COM_WIDTH = 930
local COM_HEIGHT = 590
function BigCrackResultPanel:init()
	BigCrackResultPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function BigCrackResultPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	self.ui:setCloseStartCallBack(function() return false end)
	-- self.ui:enableDebugDraw()
end


function BigCrackResultPanel:onExit()

end

return BigCrackResultPanel