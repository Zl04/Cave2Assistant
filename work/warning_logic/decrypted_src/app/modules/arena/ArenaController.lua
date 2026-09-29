--[[--
控制器ArenaController，view已经注入,可以通过mvc.arenaProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: hongyi.yan
-- date	: 2020/07/29
-- desc	: 
------------------------------------------------------------------------------
local ArenaController = class("ArenaController", mvc.GameController)

-- mvc.events.Arena_ResponseArenaData 处理函数
function ArenaController:noticeArenaResponseArenaData(notification)
    if(self.arenaView) then 
        self.arenaView:refreshArenaData()
    end
end

-- mvc.events.Arena_ResponseEnemyData 处理函数
function ArenaController:noticeArenaResponseEnemyData(notification)
    if(self.arenaView) then 
        self.arenaView:refreshEnemyData()
    end
end



return ArenaController