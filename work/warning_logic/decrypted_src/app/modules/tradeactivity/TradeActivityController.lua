--[[--
控制器TradeActivityController，view已经注入,可以通过mvc.tradeActivityProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: hongyi.yan
-- date	: 2020/09/15
-- desc	: 
------------------------------------------------------------------------------
local SdkManager = require "app.game.SdkManager"
local TradeActivityController = class("TradeActivityController", mvc.GameController)

-- mvc.events.TradeActivity_Show_View 处理函数
function TradeActivityController:noticeTradeActivityShowView(notification, viewName)
    if not self.tradeActivityMainView or tolua.isnull(self.tradeActivityMainView) then
        return
    end

    local openView = require("app.modules.tradeactivity."..viewName.."View")
    self[viewName.."View"] = openView:create()
    local layer = self[viewName.."View"]

    layer:init()
    if viewName == "TradeActivityFightBack" or viewName == "TradeActivityTimeLimitedFightBack" then
        layer:center(0,-15)
    else
        layer:center()
    end
    self.tradeActivityMainView.innerContentLayout:addChild(layer, 10)

    if self.curShowView and not tolua.isnull(self.curShowView) then
        self.curShowView:removeFromParent()
        self.curShowView = nil
    end
    self.curShowView = layer
end


-- mvc.events.TradeActivity_Update_Layer 处理函数
function TradeActivityController:noticeTradeActivityUpdateLayer(notification)

end



-- mvc.events.TradeActivity_Send_Buy_DailyGiftBag 处理函数
function TradeActivityController:noticeTradeActivitySendBuyDailyGiftBag(notification, productInfo, slotID)
    UI.WaitingLayer:showWaiting(true, nil, 5)

    SdkManager:getInstance():getOrder(productInfo, 1, nil, slotID)
end



-- mvc.events.TradeActivity_Handle_Role_Level_Up 处理函数
function TradeActivityController:noticeTradeActivityHandleRoleLevelUp(notification, oldLevel)
    if not mvc.tradeActivityModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityGrowFund) then
        return
    end

    if not mvc.tradeActivityModel:getGrowFundIsBuy() then
        local SceneManager = require("app.game.SceneManager")
        local roleLevel = RoleDataManager:getMaster():getLevel()
        local configData = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityGrowFund)

        for k, v in ipairs(configData.exchange) do
            if oldLevel < v and roleLevel >= v then
                if not (SceneManager:getInstance():isNotInFightScene()) then
                    mvc.tradeActivityModel:setGrowFundTipsShow(v)
                else
                    mvc.tradeActivityModel:setGrowFundTipsShow(0)
                    require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                    local agTips = UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityGrowFund)
                    agTips.cancelCallback = function()
                        Avalon.Scheduler:setDelayForUpdateOnce(self, function()
                            if not mvc.tradeActivityModel:getNewGrowFundIsBuy() then
                                local configData2 = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund)
    
                                for k, v in ipairs(configData2.exchange) do
                                    if oldLevel < v and roleLevel >= v then
                                        if not (SceneManager:getInstance():isNotInFightScene()) then
                                            mvc.tradeActivityModel:setNewGrowFundTipsShow(v)
                                        else
                                            mvc.tradeActivityModel:setNewGrowFundTipsShow(0)
                                            require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                                            UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund)
                                        end
                                        break
                                    end
                                end
                            end
                        end, 1)
                    end
                end
                break
            end
        end
    elseif not mvc.tradeActivityModel:getNewGrowFundIsBuy() then
        local configData = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund)
        local SceneManager = require("app.game.SceneManager")
        local roleLevel = RoleDataManager:getMaster():getLevel()
        
        for k, v in ipairs(configData.exchange) do
            if oldLevel < v and roleLevel >= v then
                if not (SceneManager:getInstance():isNotInFightScene()) then
                    mvc.tradeActivityModel:setNewGrowFundTipsShow(v)
                else
                    mvc.tradeActivityModel:setNewGrowFundTipsShow(0)
                    require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                    UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund)
                end
                break
            end
        end
    elseif mvc.tradeActivityModel:newGrowFundTwoCanBeOpened() then
        local configData = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo)
        local SceneManager = require("app.game.SceneManager")
        local roleLevel = RoleDataManager:getMaster():getLevel()
        
        for k, v in ipairs(configData.exchange) do
            if oldLevel < v and roleLevel >= v then
                if not (SceneManager:getInstance():isNotInFightScene()) then
                    mvc.tradeActivityModel:setNewGrowFundTwoTipsShow(v)
                else
                    mvc.tradeActivityModel:setNewGrowFundTwoTipsShow(0)
                    require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                    UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo)
                end
                break
            end
        end
    elseif mvc.tradeActivityModel:getGrowFundIsBuy() and not mvc.tradeActivityModel:getGrowFundIIIsBuy() then
        local configData = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityGrowFundII)
        local SceneManager = require("app.game.SceneManager")
        local roleLevel = RoleDataManager:getMaster():getLevel()
        
        for k, v in ipairs(configData.exchange) do
            if oldLevel < v and roleLevel >= v then
                if not (SceneManager:getInstance():isNotInFightScene()) then
                    mvc.tradeActivityModel:setNewGrowFundIITipsShow(v)
                else
                    mvc.tradeActivityModel:setNewGrowFundIITipsShow(0)
                    require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                    UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityGrowFundII)
                end
                break
            end
        end
    elseif mvc.tradeActivityModel:getGrowFundIIIsBuy() and not mvc.tradeActivityModel:getGrowFund3IsBuy() then
        local configData = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityGrowFund3)
        local SceneManager = require("app.game.SceneManager")
        local roleLevel = RoleDataManager:getMaster():getLevel()
        
        for k, v in ipairs(configData.exchange) do
            if oldLevel < v and roleLevel >= v then
                if not (SceneManager:getInstance():isNotInFightScene()) then
                    mvc.tradeActivityModel:setNewGrowFund3TipsShow(v)
                else
                    mvc.tradeActivityModel:setNewGrowFund3TipsShow(0)
                    require("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
                    UI.tradeActivityGrowFundTips.show(PublicDefine.TradeActivityIDList.TradeActivityGrowFund3)
                end
                break
            end
        end
    end

    
end


-- mvc.events.TradeActivity_Update_TradeActivity_TabList 处理函数
function TradeActivityController:noticeTradeActivityUpdateTradeActivityTabList(notification)
    if self.tradeActivityMainView and not tolua.isnull(self.tradeActivityMainView) then
        self.tradeActivityMainView:updateTabList()
    end
end



return TradeActivityController