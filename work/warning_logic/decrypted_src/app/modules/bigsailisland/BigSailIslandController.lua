--[[--
控制器BigSailIslandController，view已经注入,可以通过mvc.bigSailIslandProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: siyu.lin
-- date	: 2023/06/28
-- desc	: 
------------------------------------------------------------------------------
local BigSailIslandController = class("BigSailIslandController", mvc.GameController)

-- mvc.events.BigSailIsland_Info_Layer 处理函数
function BigSailIslandController:noticeBigSailIslandInfoLayer(notification)
	if self.bigSailIslandView and not tolua.isnull(self.bigSailIslandView) then
        self.bigSailIslandView:showIslandInfoLayer(notification)
    end
end



return BigSailIslandController
