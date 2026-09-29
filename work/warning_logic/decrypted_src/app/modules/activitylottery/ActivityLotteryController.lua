--[[--
控制器ActivityLotteryController，view已经注入,可以通过mvc.activityLotteryProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: 
-- date	: 2019/05/17
-- desc	: 
------------------------------------------------------------------------------
local ActivityLotteryController = class("ActivityLotteryController", mvc.GameController)

--函数说明
--notification
function ActivityLotteryController:noticeShowActivityLottery(notification)
    local param = notification.params
    self:showView(mvc.activityLottery, mvc.activityLotteryView)
end



return ActivityLotteryController
