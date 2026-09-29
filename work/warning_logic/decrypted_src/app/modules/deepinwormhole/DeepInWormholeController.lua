--[[--
控制器DeepInWormholeController，view已经注入,可以通过mvc.deepInWormholeProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2023/11/28
-- desc	: 
------------------------------------------------------------------------------
local DeepInWormholeController = class("DeepInWormholeController", mvc.GameController)

-- mvc.events.DeepInWormhole_Refresh_Info 处理函数
function DeepInWormholeController:noticeDeepInWormholeRefreshInfo(notification)
    if not self.deepInWormholeMainView then
        return
    end
    self.deepInWormholeMainView:updateInfo(idx)
end



return DeepInWormholeController
