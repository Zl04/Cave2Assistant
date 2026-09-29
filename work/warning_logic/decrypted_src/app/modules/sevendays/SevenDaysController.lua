--[[--
控制器SevenDaysController，view已经注入,可以通过mvc.sevenDaysProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: zhiming.luo
-- date	: 2019/08/16
-- desc	: 
------------------------------------------------------------------------------
local SevenDaysController = class("SevenDaysController", mvc.GameController)

-- mvc.events.SevenDaysUpdateDataAndView 处理函数
function SevenDaysController:noticeSevenDaysUpdateDataAndView(notification)
    if (self.sevenDaysView) then
        self.sevenDaysView:targetPrgUpdate()
    end
end



-- mvc.events.SevenDaysUpdateTitle 处理函数
function SevenDaysController:noticeSevenDaysUpdateTitle(notification)
    if (self.sevenDaysView) then
        self.sevenDaysView:refreshTitle()
    end
end



return SevenDaysController