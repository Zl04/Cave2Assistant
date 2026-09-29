--[[--
控制器ActivityModeCaveController，view已经注入,可以通过mvc.activityModeCaveProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2022/10/28
-- desc	: 
------------------------------------------------------------------------------
local ActivityModeCaveController = class("ActivityModeCaveController", mvc.GameController)

-- mvc.events.ActivityModeCave_Open_Challenge_View 处理函数
function ActivityModeCaveController:noticeActivityModeCaveOpenChallengeView(notification, data, config)
    if not self.activityModeCaveMainView then
        return 
    end
    mvc.activityModeCaveModel:clearSelctedEntryList()
    local challengeView = mvc.activityModeCaveChallengeView:create(data, config)
    challengeView:init()
    challengeView:center()
    self.activityModeCaveMainView.contentLayout:addChild(challengeView, 299)
    self.challengeView = challengeView
end



-- mvc.events.ActivityModeCave_Open_Main_View 处理函数
function ActivityModeCaveController:noticeActivityModeCaveOpenMainView(notification)
    if self.activityModeCaveMainView and not tolua.isnull(self.activityModeCaveMainView) then
         -- todo
    else
        mvc.openPanel("ActivityModeCave", "ActivityModeCaveMain")
    end
end



-- mvc.events.ActivityModeCave_Request_Cave_Data 处理函数
function ActivityModeCaveController:noticeActivityModeCaveRequestCaveData(notification)
    Net.NetPlaySystem:requestDungeonActivityData()
    if not mvc.activityModeCaveModel:getModeCaveData(PublicDefine.ActivityModeCaveType.TrialLand) then
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    else
        --
        mvc.send("ActivityModeCave_Open_Main_View")
    end
    
end



-- mvc.events.ActivityModeCave_Refresh_EntryDes_View 处理函数
function ActivityModeCaveController:noticeActivityModeCaveRefreshEntryDesView(notification)
    if self.challengeView and not tolua.isnull(self.challengeView) then
        self.challengeView:updateEntryDesView()
    end
end



-- mvc.events.ActivityModeCave_Show_Entry_Reward_View 处理函数
function ActivityModeCaveController:noticeActivityModeCaveShowEntryRewardView(notification, data)
    mvc.openPanel("ActivityModeCave", "ActivityModeCaveEntryReward", data)
end



-- mvc.events.ActivityModeCave_Refresh_Rank_RedPoint 处理函数
function ActivityModeCaveController:noticeActivityModeCaveRefreshRankRedPoint(notification)
    if self.challengeView then
        self.challengeView:updateRankRedPoint()
    end
    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end



return ActivityModeCaveController