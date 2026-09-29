--[[--
控制器ActivityAnnivesaryLotteryController，view已经注入,可以通过mvc.activityAnnivesaryLotteryProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2022/11/17
-- desc	: 
------------------------------------------------------------------------------
local ActivityAnnivesaryLotteryController = class("ActivityAnnivesaryLotteryController", mvc.GameController)

-- mvc.events.ActivityAnnivesary_Show_Layer 处理函数
function ActivityAnnivesaryLotteryController:noticeActivityAnnivesaryShowLayer(notification, name, parent)
    local layer
    if name == "ActivityAnnivesaryLottery" then
        self.ActivityAnnivesaryLottery = mvc.activityAnnivesaryLotteryView:create()
        layer = self.ActivityAnnivesaryLottery

    elseif name == "ActivityAnnivesaryLotteryAdvancedView" then
        self.ActivityAnnivesaryLotteryAdvancedView = mvc.activityAnnivesaryLotteryAdvancedView:create()
        layer = self.ActivityAnnivesaryLotteryAdvancedView
    end

    layer:init()
    layer:center()
    parent.innerContentLayout:addChild(layer)
end



-- mvc.events.ActivityAnnivesary_Click_Tab 处理函数
function ActivityAnnivesaryLotteryController:noticeActivityAnnivesaryClickTab(notification, clickIndex)
    if not self.activityAnnivesaryLotteryMainView then
        return
    end

    if not mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryData(clickIndex) then
        UI.ScrollBar:createByText(UI.TEXT_223614)
        return
    end

    self.activityAnnivesaryLotteryMainView.curTabIndex = clickIndex
    self.activityAnnivesaryLotteryMainView.btnData[self.activityAnnivesaryLotteryMainView.curTabIndex].select = true
    self.activityAnnivesaryLotteryMainView._tableView:updateCellAtIndex(self.activityAnnivesaryLotteryMainView.curTabIndex - 1)

    if self.activityAnnivesaryLotteryMainView.lastTabIndex > 0 then
        if self.activityAnnivesaryLotteryMainView.lastTabIndex == clickIndex then
            return
        end
        self.activityAnnivesaryLotteryMainView.btnData[self.activityAnnivesaryLotteryMainView.lastTabIndex].select = false
        self.activityAnnivesaryLotteryMainView._tableView:updateCellAtIndex(self.activityAnnivesaryLotteryMainView.lastTabIndex - 1)
    end

    local nowPageId = self.activityAnnivesaryLotteryMainView.curTabIndex
    local lastPageId = self.activityAnnivesaryLotteryMainView.lastTabIndex
    printInfo("nowPageId == " .. nowPageId .. "  lastPageId == " .. lastPageId)

    local name = ""
    if nowPageId == 1 then
        name = "ActivityAnnivesaryLottery"
    elseif nowPageId == 2 then
        name = "ActivityAnnivesaryLotteryAdvancedView"
    end
    mvc.send("ActivityAnnivesary_Show_Layer", name, self.activityAnnivesaryLotteryMainView)

    if lastPageId == 1 and self.ActivityAnnivesaryLottery and not tolua.isnull(self.ActivityAnnivesaryLottery) then
        self.ActivityAnnivesaryLottery:removeFromParent(true)
        self.ActivityAnnivesaryLottery = nil
    elseif lastPageId == 2 and self.ActivityAnnivesaryLotteryAdvancedView and not tolua.isnull(self.ActivityAnnivesaryLotteryAdvancedView) then
        self.ActivityAnnivesaryLotteryAdvancedView:removeFromParent(true)
        self.ActivityAnnivesaryLotteryAdvancedView = nil
    end

    self.activityAnnivesaryLotteryMainView.lastTabIndex = self.activityAnnivesaryLotteryMainView.curTabIndex
end



-- mvc.events.ActivityAnnivesary_Open_Main_View 处理函数
function ActivityAnnivesaryLotteryController:noticeActivityAnnivesaryOpenMainView(notification, layerName)
    local data = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)--mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryData()
    if not data then
        return
    end
    local lotteryData = data:getAnniversaryLotteryData()
    mvc.openPanel("ActivityAnnivesaryLottery", "ActivityAnnivesaryLotteryMain")
    local pageIndex = lotteryData.signType
    if layerName == "ActivityAnnivesaryLottery" then
        pageIndex = 1
    elseif layerName == "ActivityAnnivesaryLotteryAdvancedView" then
        pageIndex = 2
    end

    mvc.send("ActivityAnnivesary_Click_Tab", pageIndex)

    cc.UserDefault:getInstance():setBoolForKey("annivesaryLotteryRedPontShow", true)
end



-- mvc.events.ActivityAnnivesary_refresh_Lottery_View 处理函数
function ActivityAnnivesaryLotteryController:noticeActivityAnnivesaryrefreshLotteryView(notification)
    if self.ActivityAnnivesaryLottery and not tolua.isnull(self.ActivityAnnivesaryLottery) then
        self.ActivityAnnivesaryLottery:updateJoinBtn()
    end

    if self.ActivityAnnivesaryLotteryAdvancedView and not tolua.isnull(self.ActivityAnnivesaryLotteryAdvancedView) then
        self.ActivityAnnivesaryLotteryAdvancedView:updateJoinBtn()
    end

    if self.activityAnnivesaryLotteryMainView and not tolua.isnull(self.activityAnnivesaryLotteryMainView) then
        self.activityAnnivesaryLotteryMainView:refreshTab()
    end
end



-- mvc.events.ActivityAnnivesary_Show_PreView 处理函数
function ActivityAnnivesaryLotteryController:noticeActivityAnnivesaryShowPreView(notification, annivesaryLotteryData)
    mvc.openPanel("ActivityAnnivesaryLottery", "ActivityAnnivesaryLotteryPre", annivesaryLotteryData)
end



-- mvc.events.ActivityAnnivesary_Show_Reward_View 处理函数
function ActivityAnnivesaryLotteryController:noticeActivityAnnivesaryShowRewardView(notification, data)
    mvc.openPanel("ActivityAnnivesaryLottery", "ActivityAnnivesaryLotteryReward", data)
end



-- mvc.events.ActivityAnnivesary_Show_Reward_Roster_View 处理函数
function ActivityAnnivesaryLotteryController:noticeActivityAnnivesaryShowRewardRosterView(notification, data)
    mvc.openPanel("ActivityAnnivesaryLottery", "ActivityAnnivesaryLotteryRewardRoster", data)
end



return ActivityAnnivesaryLotteryController