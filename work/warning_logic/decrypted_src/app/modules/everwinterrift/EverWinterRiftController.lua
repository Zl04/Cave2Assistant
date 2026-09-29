--[[--
控制器EverWinterRiftController，view已经注入,可以通过mvc.everWinterRiftProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2023/02/16
-- desc	: 
------------------------------------------------------------------------------
local EverWinterRiftController = class("EverWinterRiftController", mvc.GameController)

-- mvc.events.EverWinterRift_Refresh_Info 处理函数
function EverWinterRiftController:noticeEverWinterRiftRefreshInfo(notification, idx)
    if not self.everWinterRiftMainView then
        return
    end
    self.everWinterRiftMainView:updateInfo(idx)
end



-- mvc.events.EverWinterRift_Rsp_Get_Reward 处理函数
function EverWinterRiftController:noticeEverWinterRiftRspGetReward(notification, data)
    if not self.everWinterRiftMainView then
        return
    end
    self.everWinterRiftMainView:updateInfo()
end



return EverWinterRiftController