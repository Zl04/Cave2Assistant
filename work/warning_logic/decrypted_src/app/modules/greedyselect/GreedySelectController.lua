--[[--
控制器GreedySelectController，view已经注入,可以通过mvc.greedySelectProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: hongjian.yang
-- date	: 2019/09/19
-- desc	: 
------------------------------------------------------------------------------
local GreedySelectController = class("GreedySelectController", mvc.GameController)



-- 客户端分享消息
function GreedySelectController:sendGreedySelect(isSelect, idx)
    local messageData = {}
    messageData.isGot = isSelect
    messageData.index = idx or 0
    print(messageData)
    Net.Helper:sendMessage(NetMessageType.ROLE_GREEDY_SELECT_REQ,messageData)
end




-- mvc.events.GREEDY_SELECT_DO_SELECT 处理函数
function GreedySelectController:noticeGREEDYSELECTDOSELECT(notification, isSelect, idx)
    self:sendGreedySelect(isSelect, idx)
end



return GreedySelectController
