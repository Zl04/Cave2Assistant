--[[--
视图PetGemStoneDevelopmentPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2023/02/09
--desc	: 
------------------------------------------------------------------------------

local PetGemStoneDevelopmentPanel = class("PetGemStoneDevelopmentPanel",mvc.GamePanel)

local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

function PetGemStoneDevelopmentPanel:init()
	PetGemStoneDevelopmentPanel.super.init(self, ViewStyle.ViewStyle_DoorWin, mvc.VIEW_TYPE.PANEL)
end

function PetGemStoneDevelopmentPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:leftBottom(0,0)
	-- self.ui:enableDebugDraw()

end


function PetGemStoneDevelopmentPanel:onExit()

end

return PetGemStoneDevelopmentPanel