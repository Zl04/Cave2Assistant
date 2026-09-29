--[[--
控制器MiracleController，view已经注入,可以通过mvc.miracleProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: ping.zhengping.zhengping.zheng
-- date	: 2020/12/07
-- desc	: 
------------------------------------------------------------------------------
local MiracleController = class("MiracleController", mvc.GameController)

-- mvc.events.Miracle_ResponsePrayer 处理函数
function MiracleController:noticeMiracleResponsePrayer(notification)
    local data = notification.params[1]
    -- 处理刷新逻辑
    if(self.miracleView) then 
        self.miracleView:prayerResponse(data)
    end

    if(data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then 
        UI.ScrollBar:createByErrorID(data.result)
    end
end

return MiracleController
