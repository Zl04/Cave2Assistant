--[[--
视图IdentifyTreasureItemPanel
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2023/02/23
--desc	: 
------------------------------------------------------------------------------

local IdentifyTreasureItemPanel = class("IdentifyTreasureItemPanel",mvc.GamePanel)

local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

function IdentifyTreasureItemPanel:init()
	IdentifyTreasureItemPanel.super.init(self, ViewStyle.ViewStyle_DoorWin, mvc.VIEW_TYPE.PANEL)
end

function IdentifyTreasureItemPanel:onEnter()
	self.ui:setSize(COM_WIDTH,COM_HEIGHT)
	self.ui:open()	
	-- self.ui:enableDebugDraw()
end


function IdentifyTreasureItemPanel:onExit()

end

return IdentifyTreasureItemPanel