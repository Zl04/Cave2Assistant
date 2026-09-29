--[[--
视图BigCrackCavePanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/11/01
--desc	: 
------------------------------------------------------------------------------

local BigCrackCavePanel = class("BigCrackCavePanel",mvc.GamePanel)

local winSize = cc.Director:getInstance():getWinSize()
function BigCrackCavePanel:init()
	BigCrackCavePanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.MAIN_UI)
end

function BigCrackCavePanel:onEnter()
	self.ui:setSize(winSize.width,winSize.height)
	self.ui:open(nil, true)	
	self.ui:setNoticeShowMainUI(false)
end


function BigCrackCavePanel:onExit()

end

return BigCrackCavePanel