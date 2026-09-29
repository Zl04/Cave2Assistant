--[[--
控制器CaveController，view已经注入,可以通过mvc.caveProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: ping.zheng
-- date	: 2021/02/02
-- desc	: 
------------------------------------------------------------------------------
local CaveController = class("CaveController", mvc.GameController)

-- mvc.events.ShowGhostabyssDiffcultyChoice 处理函数
function CaveController:noticeShowGhostabyssDiffcultyChoice(notification)
    local data = notification.params[1]

    self:showView(mvc.ghostabyssLevelSelectPanel, mvc.ghostabyssDiffcultyChoiceView, 1000)
end



-- mvc.events.ShowGhostabyssChoiceLevel 处理函数
function CaveController:noticeShowGhostabyssChoiceLevel(notification)
    local data = notification.params[1]

    self:showView(mvc.ghostabyssLevelSelectPanel, mvc.ghostabyssChoiceLevelView, 1000)
end



-- mvc.events.CloseGhostabyssDiffcultyChoice 处理函数
function CaveController:noticeCloseGhostabyssDiffcultyChoice(notification)
    if(self.ghostabyssDiffcultyChoiceView) then
        self:hideView(self.ghostabyssDiffcultyChoiceView, true)
    end
end



-- mvc.events.CloseGhostabyssChoiceLevel 处理函数
function CaveController:noticeCloseGhostabyssChoiceLevel(notification)
    if(self.ghostabyssChoiceLevelView) then
        self:hideView(self.ghostabyssChoiceLevelView, true)
    end
    if(self.ghostabyssLevelSelectView) then
        self.ghostabyssLevelSelectView:refreshChoiceLevel()
    end
end



-- mvc.events.RefeshGhostabyssShop 处理函数
function CaveController:noticeRefeshGhostabyssShop(notification)
    if(self.ghostabyssShopView) then
        self.ghostabyssShopView:refreshExp()
    end
end



-- mvc.events.GhostabyssShopExchangeResponse 处理函数
function CaveController:noticeGhostabyssShopExchangeResponse(notification)
    local data = notification.params[1]
    if(self.ghostabyssShopView) then
        self.ghostabyssShopView:exchangeResponse(data)
    end
end



-- mvc.events.GhostabyssSelectResponse 处理函数
function CaveController:noticeGhostabyssSelectResponse(notification)
    local data = notification.params[1]
    if(self.ghostabyssSelectView) then
        self.ghostabyssSelectView:extractResponse(data)
    end
end



return CaveController