--[[--
控制器CaveExploringController，view已经注入,可以通过mvc.caveExploringProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2023/06/07
-- desc	: 
------------------------------------------------------------------------------
local CaveExploringController = class("CaveExploringController", mvc.GameController)

-- mvc.events.CaveExploring_Update_BoxMapView 处理函数
function CaveExploringController:noticeCaveExploringUpdateBoxMapView(notification)
    if self.caveExploringView and not tolua.isnull(self.caveExploringView) then
        self.caveExploringView:updateBoxMapView(true)
    end
end



return CaveExploringController
