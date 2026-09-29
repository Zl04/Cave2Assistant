--[[--
控制器GemConnectController，view已经注入,可以通过mvc.gemConnectProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2024/03/19
-- desc	: 
------------------------------------------------------------------------------
local GemConnectController = class("GemConnectController", mvc.GameController)

-- mvc.events.GemView_Refresh 处理函数
function GemConnectController:noticeGemViewRefresh(notification,isBreak)
    
    if not self.gemConnectView then
        UI.WaitingLayer:hideWaiting()
        return
    end

    local func = function()
        if self.gemConnectView._mainRuneGoodsGrid and self.gemConnectView._mainRuneGoodsGrid:getData() then
            self.gemConnectView:refreshGemGridData(self.gemConnectView._mainRuneGoodsGrid,self.gemConnectView._mainRuneGoodsGrid:getData(),true)
        end

        if isBreak and self.gemConnectView._connectRuneGoodsGrid then
            self.gemConnectView._connectRuneGoodsGrid:reset()
            self.gemConnectView:refreshGoodsGrid(self.gemConnectView._connectRuneGoodsGrid)
        end

        if self.gemConnectView._bagGridList then
            self.gemConnectView._bagGridList:refreshView()
        end

        
        self.gemConnectView:refreshGoodsGrid(self.gemConnectView._mainRuneGoodsGrid)
        self.gemConnectView:refreshLeftLayer()

        UI.WaitingLayer:hideWaiting()
    end

    if not isBreak then
        self.gemConnectView:runLinkAnimation(func)
    else
        func()
    end

end



return GemConnectController
