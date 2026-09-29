--[[--
控制器BigSailPortController，view已经注入,可以通过mvc.bigSailPortProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: siyu.lin
-- date	: 2023/06/14
-- desc	: 
------------------------------------------------------------------------------
local BigSailPortController = class("BigSailPortController", mvc.GameController)

-- mvc.events.BigSailPort_Supply_Layer 处理函数
function BigSailPortController:noticeBigSailPortSupplyLayer(notification)
	if self.bigSailPortView and not tolua.isnull(self.bigSailPortView) then
        self.bigSailPortView:showSupplyLayer(notification)
    end

end



-- mvc.events.BigSailPort_Merchant_Layer 处理函数
function BigSailPortController:noticeBigSailPortMerchantLayer(notification)
    if self.bigSailPortView and not tolua.isnull(self.bigSailPortView) then
        self.bigSailPortView:showMerchantLayer(notification)
    end
end



-- mvc.events.BigSailPort_Task_Layer 处理函数
function BigSailPortController:noticeBigSailPortTaskLayer(notification)
    if self.bigSailPortView and not tolua.isnull(self.bigSailPortView) then
        self.bigSailPortView:showTaskLayer(notification)
    end
end



-- mvc.events.BigSailPort_Click_Log_Tab 处理函数
function BigSailPortController:noticeBigSailPortClickLogTab(notification, clickIndex, mainView)
    if not self.eventMainView or tolua.isnull(self.eventMainView) and mainView then
        self.eventMainView = mainView
    end
    if clickIndex == 1 then
        Net.NetBigSailSystem:reqEventData()
    else
        Net.NetBigSailSystem:reqGuildEventData()
    end
    
    
    if not self.eventMainView then
        print("BigSailPort_Click_Log_Tab have not mainView")
        return
    end

    self.eventMainView.curTabIndex = clickIndex
    self.eventMainView.btnData[self.eventMainView.curTabIndex].select = true
    self.eventMainView._tableView:updateCellAtIndex(self.eventMainView.curTabIndex - 1)

    if self.eventMainView.lastTabIndex > 0 then
        if self.eventMainView.lastTabIndex == clickIndex then
            return
        end
        self.eventMainView.btnData[self.eventMainView.lastTabIndex].select = false
        self.eventMainView._tableView:updateCellAtIndex(self.eventMainView.lastTabIndex - 1)
    end

    local nowPageId = self.eventMainView.curTabIndex
    local lastPageId = self.eventMainView.lastTabIndex
    printInfo("nowPageId == " .. nowPageId .. "  lastPageId == " .. lastPageId)

    local name = ""
    if nowPageId == 1 then
        name = "BigSailPersonalEventLayer"
    elseif nowPageId == 2 then
        name = "BigSailGuildEventLayer"
    end
    mvc.send("BigSailPort_Show_Log_Layer", name, self.eventMainView)

    if lastPageId == 1 and self.BigSailPersonalEventLayer and not tolua.isnull(self.BigSailPersonalEventLayer) then
        self.BigSailPersonalEventLayer:removeFromParent(true)
        self.BigSailPersonalEventLayer = nil
    elseif lastPageId == 2 and self.BigSailGuildEventLayer and not tolua.isnull(self.BigSailGuildEventLayer) then
        self.BigSailGuildEventLayer:removeFromParent(true)
        self.BigSailGuildEventLayer = nil
    end

    self.eventMainView.lastTabIndex = self.eventMainView.curTabIndex
end



-- mvc.events.BigSailPort_Show_Log_Layer 处理函数
function BigSailPortController:noticeBigSailPortShowLogLayer(notification, name, parent)
    local layer
    local eventData = mvc.bigSailPortModel:getEventData()
    if name == "BigSailPersonalEventLayer" then
        local BigSailPersonalEventLayer = require "app.modules.bigsailport.BigSailPersonalEventLayer"
        self.BigSailPersonalEventLayer = BigSailPersonalEventLayer:create(eventData.personal or {}, false)
        layer = self.BigSailPersonalEventLayer

        self:saveLastEventTime(eventData.personal, 1)
    elseif name == "BigSailGuildEventLayer" then
        local BigSailGuildEventLayer = require "app.modules.bigsailport.BigSailPersonalEventLayer"
        self.BigSailGuildEventLayer = BigSailGuildEventLayer:create(eventData.guild or {}, true)
        layer = self.BigSailGuildEventLayer

        self:saveLastEventTime(eventData.guild, 2)
        
    end

    layer:init()
    layer:center()
    parent.innerContentLayout:addChild(layer)
end

function BigSailPortController:saveLastEventTime(data, eventType)
    local GameDataManager = require("app.game.GameDataManager")
    local lastGameTime = data[1] and data[1].gameTime or 0
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.SailEventRedPointLastRefreshTime..eventType..GameDataManager:getInstance():getMasterPK(), lastGameTime)

    mvc.bigSailPortModel:setRedPointIsShow(eventType, false)
end



return BigSailPortController