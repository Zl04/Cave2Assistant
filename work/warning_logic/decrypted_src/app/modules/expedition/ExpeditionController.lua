--[[--
控制器ExpeditionController，view已经注入,可以通过mvc.expeditionProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: ping.zheng
-- date	: 2019/05/09
-- desc	: 
------------------------------------------------------------------------------
local ExpeditionController = class("ExpeditionController", mvc.GameController)
local ProtobufUtil = require "utils.ProtobufUtil"
local GameDataManager = require("app.game.GameDataManager")

--函数说明
--notification
function ExpeditionController:noticeExpeditionDataUpdate(notification)
    if(self.expeditionView) then 
        self.expeditionView:dataUpdateRefresh()
    end
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionShowBag(notification)

end



--函数说明
--notification
function ExpeditionController:noticeExpeditionCloseBag(notification)
    if(self.expeditionView) then 
        self.expeditionView:bagClose()
    end
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionStartNorml(notification)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    local data = notification.params[1]
    -- print("noticeExpeditionStartNorml", data)
    Net.NetNPCSystem:reqStartExpedition(nil, data.model, data.level)
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionStartNormlResult(notification)
    UI.WaitingLayer:hideWaiting()
    local data = notification.params[1]

    GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.RspExpedition_result", data.result))
    if(data.result == "RspExpedition_OK") then
        if(not tolua.isnull(self.expeditionView)) then 
            self.expeditionView:normalResult(data)
        else 
            UI.ScrollBar:createByText(UI.TEXT_1213408)
        end
    end
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionStartQuick(notification)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    local data = notification.params[1]

    -- 第一次免费，totalNum赋值为0
    local curTimes = mvc.expeditionModel:getQuickExpeditionNum()
    if not curTimes or curTimes == 0 then
        data.totalNum = 0
    end

    Net.NetNPCSystem:reqQuickExpedition(data.totalNum, data.model, data.level)
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionStartQuickResult(notification)
    UI.WaitingLayer:hideWaiting()
    local data = notification.params[1]
    GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.RspExpedition_result", data.result))

    if(data.result == "RspExpedition_OK") then
        UI.ScrollBar:createByText(UI.TEXT_1212589)
        if(self.expeditionView) then 
            self.expeditionView:quickResult(data)
        end
    end
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionDecompose(notification)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    local data = notification.params[1]
    
    Net.NetNPCSystem:reqNeqNewDecomposeEquip(nil, data.packetType, data.goodsArr)
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionDecomposeResult(notification)
    UI.WaitingLayer:hideWaiting()
    local data = notification.params[1]
    GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.DecomposeResultType", data.result))

    if(self.expeditionView) then 
        self.expeditionView:bagDataUpdate()
    end
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionSellGoods(notification)
    -- print("ExpeditionController:noticeExpeditionSellGoods")
    local data = notification.params[1]
    local goodsDataArr = data.goodsArr
    local packetType = data.packetType
    local callback = data.callback
    local cancelCallBack = data.cancelCallBack

    local isNoticeSell = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.isNoticeSellEquip..GameDataManager:getInstance():getMasterPK(), true)  
    local isHaveGold = false
    for i=1,#goodsDataArr,1  do
        local goodsData = goodsDataArr[i]
        if goodsData:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_GOLDEN_3 then
            isHaveGold = true
            break
        end
    end
    --二次确认
    if isHaveGold and isNoticeSell then 
        UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212236, function(isSelect)
            if isSelect then
                cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeSellEquip..GameDataManager:getInstance():getMasterPK(), false)  
            end
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetNPCSystem:reqNewSellGoods(packetType, goodsDataArr)
            if callback then
                callback()
            end
        end, function(isSelect)
            UI.WaitingLayer:hideWaiting()
            if(cancelCallBack) then 
                cancelCallBack()
            end
        end, nil, nil, true)
    else
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetNPCSystem:reqNewSellGoods(packetType, goodsDataArr)
    end
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionSellGoodsResult(notification)
    local data = notification.params[1]
    UI.WaitingLayer:hideWaiting()
    GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.SellGoodsResultType", data.result))
    if(self.expeditionView) then 
        self.expeditionView:bagDataUpdate()
    end
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionDragGoods(notification)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    local data = notification.params[1]

    Net.NetNPCSystem:reqExpeditionReward(data.packetType, data.goodsArr)
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionDragGoodsResult(notification)
    local data = notification.params[1]
    UI.WaitingLayer:hideWaiting()
    GameErrorManager:showError(ProtobufUtil:enum_id("GoodsSystem.DragGoodsToPacketResult", data.result))

    if(self.expeditionView) then 
        self.expeditionView:bagDataUpdate()
    end
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionStopNorml(notification)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    Net.NetNPCSystem:reqStopExpedition()
end



--函数说明
--notification
function ExpeditionController:noticeExpeditionStopNormlResult(notification)
    UI.WaitingLayer:hideWaiting()
    local data = notification.params[1]
    GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.RspExpedition_result", data.result))

    if(data.result == "RspExpedition_OK") then
        UI.ScrollBar:createByText(UI.TEXT_1212590)
    end

    if(self.expeditionView) then 
        self.expeditionView:stopNormalResult()
    end
end



-- mvc.events.Expedition_Get_Reward 处理函数
function ExpeditionController:noticeExpeditionGetReward(notification)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    local data = notification.params[1]

    Net.NetNPCSystem:reqExpeditionReward(data.packetType, data.goodsArr)
end



-- mvc.events.Expedition_Get_Reward_Result 处理函数
function ExpeditionController:noticeExpeditionGetRewardResult(notification)
    local data = notification.params[1]
    UI.WaitingLayer:hideWaiting()
    GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.RspExpedition_result", data.result))

    if(data.result == "RspExpedition_OK") then
        if(mvc.expeditionModel:getBagHaveGoodsForPacketType(data.fromPacketType) 
            and GameDataManager:getInstance():getFreePacketBoxNum()<=0) then 
            UI.ScrollBar:createByText(UI.TEXT_1212592)
        else 
            UI.ScrollBar:createByText(UI.TEXT_1212026)
        end
    end

    if(self.expeditionView) then 
        self.expeditionView:bagDataUpdate()
    end
end



-- mvc.events.Expedition_Bag_Attr_Change 处理函数
function ExpeditionController:noticeExpeditionBagAttrChange(notification)
    if(self.expeditionView) then 
        self.expeditionView:bagAttrChange()
    end
end



-- mvc.events.Expedition_Select_IDX 处理函数
function ExpeditionController:noticeExpeditionSelectIDX(notification, caveMode)
    print(caveMode)
    if(self.expeditionView) then 
        self.expeditionView:refreshCaveBtn(caveMode)
    end

    mvc.closePanel("Expedition", "ExpeditionSelect")
end



-- mvc.events.Expedition_Show_Select_View 处理函数
function ExpeditionController:noticeExpeditionShowSelectView(notification, caveMode)
    mvc.openPanel("Expedition", "ExpeditionSelect", caveMode)
end



return ExpeditionController