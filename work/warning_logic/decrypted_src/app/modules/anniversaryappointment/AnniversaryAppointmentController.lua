--[[--
控制器AnniversaryAppointmentController，view已经注入,可以通过mvc.anniversaryAppointmentProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2022/10/17
-- desc	: 
------------------------------------------------------------------------------
local AnniversaryAppointmentController = class("AnniversaryAppointmentController", mvc.GameController)

-- mvc.events.AnniversaryAppointment_Show_Layer 处理函数
function AnniversaryAppointmentController:noticeAnniversaryAppointmentShowLayer(notification, name, parent)
    local layer
    if name == "AnniversaryAppointmentTargetView" then
        -- local PetPacketLayer = require "app.modules.anniversaryappointment.AnniversaryAppointmentTargetView"
        self.AnniversaryAppointmentTargetView = mvc.anniversaryAppointmentTargetView:create()--PetPacketLayer:create()
        layer = self.AnniversaryAppointmentTargetView

    elseif name == "AnniversaryAppointmentCoinRewardView" then
        -- local AnniversaryAppointmentCoinRewardView = require "app.modules.anniversaryappointment.AnniversaryAppointmentCoinRewardView"
        self.AnniversaryAppointmentCoinRewardView = mvc.anniversaryAppointmentCoinRewardView:create()
        layer = self.AnniversaryAppointmentCoinRewardView

    elseif name == "AnniversaryAppointmentServerRewardView" then
        -- local AnniversaryAppointmentServerRewardView = require "app.modules.manorappearance.AnniversaryAppointmentServerRewardView"
        self.AnniversaryAppointmentServerRewardView = mvc.anniversaryAppointmentServerRewardView:create()
        layer = self.AnniversaryAppointmentServerRewardView
    end

    layer:init()
    layer:center()
    parent.innerContentLayout:addChild(layer)
end



-- mvc.events.AnniversaryAppointment_Click_Tab 处理函数
function AnniversaryAppointmentController:noticeAnniversaryAppointmentClickTab(notification, clickIndex)
    if not self.anniversaryAppointmentMainView then
        return
    end

    self.anniversaryAppointmentMainView.curTabIndex = clickIndex
    self.anniversaryAppointmentMainView.btnData[self.anniversaryAppointmentMainView.curTabIndex].select = true
    self.anniversaryAppointmentMainView._tableView:updateCellAtIndex(self.anniversaryAppointmentMainView.curTabIndex - 1)

    if self.anniversaryAppointmentMainView.lastTabIndex > 0 then
        if self.anniversaryAppointmentMainView.lastTabIndex == clickIndex then
            return
        end
        self.anniversaryAppointmentMainView.btnData[self.anniversaryAppointmentMainView.lastTabIndex].select = false
        self.anniversaryAppointmentMainView._tableView:updateCellAtIndex(self.anniversaryAppointmentMainView.lastTabIndex - 1)
    end

    local nowPageId = self.anniversaryAppointmentMainView.curTabIndex
    local lastPageId = self.anniversaryAppointmentMainView.lastTabIndex
    printInfo("nowPageId == " .. nowPageId .. "  lastPageId == " .. lastPageId)

    local name = ""
    if nowPageId == 1 then
        name = "AnniversaryAppointmentTargetView"
    elseif nowPageId == 2 then
        name = "AnniversaryAppointmentCoinRewardView"
    elseif nowPageId == 3 then
        name = "AnniversaryAppointmentServerRewardView"
    end
    mvc.send("AnniversaryAppointment_Show_Layer", name, self.anniversaryAppointmentMainView)

    if lastPageId == 1 and self.AnniversaryAppointmentTargetView and not tolua.isnull(self.AnniversaryAppointmentTargetView) then
        self.AnniversaryAppointmentTargetView:removeFromParent(true)
        self.AnniversaryAppointmentTargetView = nil
    elseif lastPageId == 2 and self.AnniversaryAppointmentCoinRewardView and not tolua.isnull(self.AnniversaryAppointmentCoinRewardView) then
        self.AnniversaryAppointmentCoinRewardView:removeFromParent(true)
        self.AnniversaryAppointmentCoinRewardView = nil
    elseif lastPageId == 3 and self.AnniversaryAppointmentServerRewardView and not tolua.isnull(self.AnniversaryAppointmentServerRewardView) then
        self.AnniversaryAppointmentServerRewardView:removeFromParent(true)
        self.AnniversaryAppointmentServerRewardView = nil
    end

    self.anniversaryAppointmentMainView.lastTabIndex = self.anniversaryAppointmentMainView.curTabIndex
end



-- mvc.events.AnniversaryAppointment_Open_Main_View 处理函数
function AnniversaryAppointmentController:noticeAnniversaryAppointmentOpenMainView(notification, layerName)
    
    mvc.openPanel("AnniversaryAppointment", "AnniversaryAppointmentMain")
    mvc.anniversaryAppointmentModel:packServerRewardConfig()
    local pageIndex = 1
    if layerName == "AnniversaryAppointmentTargetView" then
        pageIndex = 1
    elseif layerName == "AnniversaryAppointmentCoinRewardView" then
        pageIndex = 2
    elseif layerName == "AnniversaryAppointmentServerRewardView" then
        pageIndex = 3
    end

    mvc.send("AnniversaryAppointment_Click_Tab", pageIndex)
    cc.UserDefault:getInstance():setBoolForKey("anniversaryAppointment", true)
end



-- mvc.events.AnniversaryAppointment_Refresh_Sever_Reward_Btn 处理函数
function AnniversaryAppointmentController:noticeAnniversaryAppointmentRefreshSeverRewardBtn(notification)
    if self.AnniversaryAppointmentServerRewardView then

    end
end



-- mvc.events.AnniversaryAppointment_Refresh_Coin_Number 处理函数
function AnniversaryAppointmentController:noticeAnniversaryAppointmentRefreshCoinNumber(notification)
    if self.AnniversaryAppointmentServerRewardView and not tolua.isnull(self.AnniversaryAppointmentServerRewardView) then
        self.AnniversaryAppointmentServerRewardView:updateCoinNum()
    end
    if self.AnniversaryAppointmentTargetView and not tolua.isnull(self.AnniversaryAppointmentTargetView) then
        self.AnniversaryAppointmentTargetView:updateCoinNum()
    end
    if self.AnniversaryAppointmentCoinRewardView and not tolua.isnull(self.AnniversaryAppointmentCoinRewardView)  then
        self.AnniversaryAppointmentCoinRewardView:updateCoinNum()
    end
end



return AnniversaryAppointmentController