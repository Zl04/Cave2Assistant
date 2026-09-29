--[[--
视图SuitTransformationSelectRetrofitPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/07
--desc	: 
------------------------------------------------------------------------------

local SuitTransformationSelectRetrofitPanel = class("SuitTransformationSelectRetrofitPanel",mvc.GamePanel)
local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
function SuitTransformationSelectRetrofitPanel:init()
	SuitTransformationSelectRetrofitPanel.super.init(self, ViewStyle.ViewStyle_CenterWin, mvc.VIEW_TYPE.PANEL)
end

function SuitTransformationSelectRetrofitPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function SuitTransformationSelectRetrofitPanel:onExit()

end

return SuitTransformationSelectRetrofitPanel