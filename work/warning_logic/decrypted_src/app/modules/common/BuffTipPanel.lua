--[[--
视图BuffTipPanel
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/11/11
--desc	: 
------------------------------------------------------------------------------

local BuffTipPanel = class("BuffTipPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()
function BuffTipPanel:init()
	BuffTipPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.TIP)
end

function BuffTipPanel:onEnter()
	self.ui:setSize(winSize.width,winSize.height)
	self.ui:open(nil, true)	
	self.ui:setNoticeShowMainUI(false)
end


function BuffTipPanel:onExit()

end

return BuffTipPanel