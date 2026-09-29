--[[--
控制器UseMoldController，view已经注入,可以通过mvc.useMoldProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2023/04/25
-- desc	: 
------------------------------------------------------------------------------
local UseMoldController = class("UseMoldController", mvc.GameController)

-- mvc.events.UseMold_ShowContent 处理函数
function UseMoldController:noticeUseMoldShowContent(notification)
    self:showView(mvc.useMoldPanel, mvc.useMoldView)
    self:showView(mvc.useMoldPanel, mvc.useMoldBagContentView, nil)
    mvc.useMoldPanel.ui:setDoorNode(self.useMoldView, self.useMoldBagContentView, true)
end



-- mvc.events.UseMold_Bag_Drag_Began 处理函数
function UseMoldController:noticeUseMoldBagDragBegan(notification)
    
end



-- mvc.events.UseMold_Bag_Drag_Moved 处理函数
function UseMoldController:noticeUseMoldBagDragMoved(notification)

end



-- mvc.events.UseMold_Bag_Drag_Ended 处理函数
function UseMoldController:noticeUseMoldBagDragEnded(notification)

end



-- mvc.events.UseMold_Grid_Drag_Out 处理函数
function UseMoldController:noticeUseMoldGridDragOut(notification)

end



-- mvc.events.UseMold_On_Mold_Used 处理函数
function UseMoldController:noticeUseMoldOnMoldUsed(notification)
    
end



return UseMoldController