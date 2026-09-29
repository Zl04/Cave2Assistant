--[[--
视图QuickSideBarPanel
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/09/06
--desc	: 
------------------------------------------------------------------------------

local QuickSideBarPanel = class("QuickSideBarPanel",mvc.GamePanel)
local COM_WIDTH = 230
local COM_HEIGHT = 264
function QuickSideBarPanel:init()
	QuickSideBarPanel.super.init(self, ViewStyle.ViewStyle_BaseWin, mvc.VIEW_TYPE.SUB_PANEL)
end

function QuickSideBarPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	

    self.ui:centerLeft(0)
	-- self.ui:enableDebugDraw()

	-- FIXME:最后要打开这里
	self.ui:setInterceptTouches(false)
	self.ui:setSwallowTouches(false)
	self.ui:setTouchEnabled(false)
	self.ui:setCloseStartCallBack(function() 
		-- 此处接管关闭窗口的操作
		return false
	end)
end


function QuickSideBarPanel:onExit()

end

return QuickSideBarPanel