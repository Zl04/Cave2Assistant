--[[--
控制器GemDecomposeController，view已经注入,可以通过mvc.gemDecomposeProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2024/04/26
-- desc	: 
------------------------------------------------------------------------------
local GemDecomposeController = class("GemDecomposeController", mvc.GameController)

-- mvc.events.GemDecomposeView_Refresh 处理函数
function GemDecomposeController:noticeGemDecomposeViewRefresh(notification,simpleGoodsID)
    if not self.gemDecomposeView then
        UI.WaitingLayer:hideWaiting()
        return
    end

    local func = function()

        if self.gemDecomposeView._mainRuneGoodsGrid then
            self.gemDecomposeView._mainRuneGoodsGrid:reset()
            self.gemDecomposeView:refreshGoodsGrid(self.gemDecomposeView._mainRuneGoodsGrid)
        end

        if self.gemDecomposeView._bagGridList then
            self.gemDecomposeView._bagGridList:refreshView()
        end
        self.gemDecomposeView:refreshLeftLayer()

        UI.WaitingLayer:hideWaiting()

        if simpleGoodsID then
            local templateID = simpleGoodsID.templateID
            local num = simpleGoodsID.num or 1
            if templateID then
                local itemData = {}
                local goodData = GoodsDataManager:createLocalGoodsData(templateID)
                if (goodData) then
                    goodData:setIsNew(false)
                    goodData:setNum(num)
                    table.insert(itemData, goodData)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD,itemData)
                end
            end
        end
    end

    self.gemDecomposeView:runDecomposeAnimation(func)
end



return GemDecomposeController
