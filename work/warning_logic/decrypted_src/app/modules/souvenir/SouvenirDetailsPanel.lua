--[[--
视图SouvenirDetailsPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/10/11
--desc	: 
------------------------------------------------------------------------------

local SouvenirDetailsPanel = class("SouvenirDetailsPanel",mvc.GamePanel)
local COM_WIDTH = 528
local COM_HEIGHT = 540
function SouvenirDetailsPanel:init()
	self.alwaysShow = true --不会隐藏上一个界面
	SouvenirDetailsPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function SouvenirDetailsPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:setCloseStartCallBack(function() return false end)  -- 这样写, 点击返回按钮时不会关闭面板, 但是点击返回按钮时会调用closeStartCallBack回调函数
	-- self.ui:enableDebugDraw()
end


function SouvenirDetailsPanel:onExit()

end

return SouvenirDetailsPanel