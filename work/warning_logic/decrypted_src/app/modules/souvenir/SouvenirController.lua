--[[--
控制器SouvenirController，view已经注入,可以通过mvc.souvenirProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2024/10/09
-- desc	: 
------------------------------------------------------------------------------
local SouvenirController = class("SouvenirController", mvc.GameController)

-- mvc.events.Souvenir_Resource_Change 处理函数
function SouvenirController:noticeSouvenirResourceChange(notification, data)
    --虚拟货币变更,通知刷新红点
    Avalon.MessageCenter:notice(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, {})
    Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_NEW_CITY_REDPOINT)

    if self.souvenirView and self.souvenirView.updateContent then
        self.souvenirView:updateContent()
    end

    if self.souvenirDetailsView and self.souvenirDetailsView.updateContent and data and data.souvenidID then
        local souvenirData = mvc.souvenirModel:getSouvenirDataByID(data.souvenidID)
        if souvenirData then
            self.souvenirDetailsView:updateContent(souvenirData)
        end
    elseif self.souvenirDetailsView and self.souvenirDetailsView.updateContent then
        self.souvenirDetailsView:updateContent()
    end
end



-- mvc.events.Souvenir_Close_Layer 处理函数
function SouvenirController:noticeSouvenirCloseLayer(notification)
    mvc.closePanel("Souvenir", "SouvenirDetails")
end



return SouvenirController