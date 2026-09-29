--[[--
控制器FestivalController，view已经注入,可以通过mvc.festivalProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: ping.zhengping.zhengping.zheng
-- date	: 2019/08/05
-- desc	: 
------------------------------------------------------------------------------
local FestivalController = class("FestivalController", mvc.GameController)

-- mvc.events.FestivalReward_Quit 处理函数
function FestivalController:noticeFestivalRewardQuit(notification)
    local SceneManager = require('app.game.SceneManager')
    SceneManager:getInstance():leaveWaiting()
end



-- mvc.events.Festival_WeaponSelect 处理函数
function FestivalController:noticeFestivalWeaponSelect(notification, weaponType)
    Net.NetPlaySystem:huluSetEeaponRequest(weaponType)
end



-- mvc.events.Festival_RelicStatistic 处理函数
function FestivalController:noticeFestivalRelicStatistic(notification)

end



-- mvc.events.Festival_OpenCloseExchangeShopView 处理函数
function FestivalController:noticeFestivalOpenCloseExchangeShopView(notification)
    self.festivalExchangeShopView:show()
end



-- mvc.events.Festival_ExchangeShopExchangeResult 处理函数
function FestivalController:noticeFestivalExchangeShopExchangeResult(notification, data)
    print("noticeFestivalExchangeShopExchangeResult=", data)
    if(self.festivalExchangeShopView) then 
        self.festivalExchangeShopView:exchangeResult(data)
    end
    UI.WaitingLayer:hideWaiting()
    if(data.result == "ExchangeShopResult_Ok") then
        local dropDisplayDataArr = nil
        local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_ExchangeShop)
        if(activityData) then
            local exchangeShopArr = activityData:getFestivalExchangeShopData()
            if(exchangeShopArr) then 
                for k, v in ipairs(exchangeShopArr) do 
                    if(v:getID() == data.purchaseId) then 
                        dropDisplayDataArr = {}
                        table.insert(dropDisplayDataArr, v:getGoodsData())
                    end
                end
            end
        end

        if dropDisplayDataArr then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_COMMON_REWARD, dropDisplayDataArr, nil, title, nil, nil, nil, nil, btnStr) 
        end
    end

    local ProtobufUtil = require "utils.ProtobufUtil"
    -- 提示
    GameErrorManager:showError(ProtobufUtil:enum_id("ActivitySystem.ExchangeShopResult", data.result))
end



-- mvc.events.Festival_ExchangeShopExchangeRequest 处理函数
function FestivalController:noticeFestivalExchangeShopExchangeRequest(notification, festivalID, ID)
    Net.NetActivitySystem:requestPurchaseExchangeShop(festivalID, ID)
end



-- mvc.events.Festival_LostRealmRequest 处理函数
function FestivalController:noticeFestivalLostRealmRequest(notification, curTabActData)
    print("Festival_LostRealmRequest", curTabActData)
    local MachineManager = require("app.game.MachineManager")
    local machine = MachineManager:getInstance():getMachine()
    local spriteID = 0
    if(machine) then
        local model = machine:getModel()
        if(model) then 
            local enterModelArr = model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
            if(enterModelArr and #enterModelArr > 0) then 
                spriteID = enterModelArr[1]:getSpriteID()
            end
        end
    end

    Net.NetRoleSystem:heroEnterCaveSceneRequest(
    PublicDefine.GAME_MODE.MODE_SOLO,
    PublicDefine.CAVE_MODE.MODE_ACT,
    PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
    PublicDefine.CONST_DEFINITION.LOST_REALM_MAP_ID,
    spriteID, false, curTabActData.activityID)
end


-- mvc.events.Festival_LostRealmRoleStartMove 处理函数
function FestivalController:noticeFestivalLostRealmRoleStartMove(notification, data)
    print("noticeFestivalLostRealmRoleStartMove", data)
    local command = Command.ControlCommand:create(true)
    command:initForTypeAndData(CommandType.CONTROL_PLAY_LOSTREALM_MOVE, data)
    local SceneManager = require('app.game.SceneManager')
    SceneManager:getInstance():pushCommand(command)
end



return FestivalController