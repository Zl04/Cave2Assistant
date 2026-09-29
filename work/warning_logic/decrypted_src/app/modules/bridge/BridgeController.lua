--[[--
控制器BridgeController，proxy,view已经注入,可以通过cc.BridgeProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
]]
local GameController = require(mvc.PACKAGE_APP_CORE..".GameController")

local BridgeController = class("BridgeController",GameController)

function BridgeController:onRegister()
    BridgeController.super.onRegister(self)

    self:registerLisetener()
end

function BridgeController:onRemove()
    BridgeController.super.onRemove(self)

    self:unRegisterLisetener()
end

function BridgeController:registerShowMianLayer()

end

function BridgeController:registerHideMianLayer()
    
end

function BridgeController:registerLisetener()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_SHOW_MAINUI_LAYER, self, self.registerShowMianLayer)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_HIDE_MAINUI_LAYER, self, self.registerHideMianLayer)
end

function BridgeController:unRegisterLisetener()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_SHOW_MAINUI_LAYER, self, self.registerShowMianLayer)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_HIDE_MAINUI_LAYER, self, self.registerHideMianLayer)
end


--函数说明
--notification
function BridgeController:noticeBridgeShowMainLayer(notification)
    print("noticeBridgeShowMainLayer", table.unpack(notification.params))
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, table.unpack(notification.params))
end



--函数说明
--notification
function BridgeController:noticeBridgeHideMainLayer(notification)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER, table.unpack(notification.params))
end



-- mvc.events.Bridge_Close_All_Panel_Layer 处理函数
function BridgeController:noticeBridgeCloseAllPanelLayer(notification)

end



return BridgeController