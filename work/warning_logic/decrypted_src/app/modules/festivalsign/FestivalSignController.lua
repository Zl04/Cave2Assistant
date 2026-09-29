--[[--
控制器FestivalSignController，view已经注入,可以通过mvc.festivalSignProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2021/08/24
-- desc	: 
------------------------------------------------------------------------------
local FestivalSignController = class("FestivalSignController", mvc.GameController)

-- mvc.events.FestivalSignUpdateDataAndView 处理函数
function FestivalSignController:noticeFestivalSignUpdateDataAndView(notification)
    if (self.festivalSignView) then
        self.festivalSignView:targetPrgUpdate()
    end
end



-- mvc.events.FestivalSignUpdateTitle 处理函数
function FestivalSignController:noticeFestivalSignUpdateTitle(notification)
    if (self.festivalSignView) then
        self.festivalSignView:refreshTitle()
    end
end



return FestivalSignController
