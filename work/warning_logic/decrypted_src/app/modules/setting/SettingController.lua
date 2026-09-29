--[[--
控制器SettingController，view已经注入,可以通过mvc.settingProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: hongyi.yan
-- date	: 2020/07/21
-- desc	: 
------------------------------------------------------------------------------
local SettingController = class("SettingController", mvc.GameController)

-- mvc.events.Setting_Area_Server_HandleChangeArea 处理函数
function SettingController:noticeSettingAreaServerHandleChangeArea(notification)
    local data = notification.params[1]

    local gameLoginManager = require("app.game.GameLoginManager")
    gameLoginManager:getInstance():setAreaID(data.areaID)

    gameLoginManager:getInstance():changeServerArea()
end



-- mvc.events.Setting_Area_Server_ReqAreaList 处理函数
function SettingController:noticeSettingAreaServerReqAreaList(notification)

    Net.NetLoginSystem:reqAreaList()
end



-- mvc.events.Setting_Area_Server_RespAreaList 处理函数
function SettingController:noticeSettingAreaServerRespAreaList(notification)
    local data = notification.params[1]
    UI.WaitingLayer:hideWaiting()
    -- GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.RspExpedition_result", data.result))
    if(data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then 
        GameErrorManager:showError(data.result)
        return
    end

    mvc.settingModel:handleAreaListData(data)

    if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
        if(self.settingAreaServerSelectView) then
            self.settingAreaServerSelectView:responseAreaList()
        end
    end
end



return SettingController