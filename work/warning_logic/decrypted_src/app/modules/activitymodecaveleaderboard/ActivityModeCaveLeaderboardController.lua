--[[--
控制器ActivityModeCaveLeaderboardController，view已经注入,可以通过mvc.activityModeCaveLeaderboardProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2022/11/01
-- desc	: 
------------------------------------------------------------------------------
local ActivityModeCaveLeaderboardController = class("ActivityModeCaveLeaderboardController", mvc.GameController)

function ActivityModeCaveLeaderboardController:updateRankView()
    if self.activityModeCaveLeaderboardView and self.activityModeCaveLeaderboardView._rankingView then
        self.activityModeCaveLeaderboardView._rankingView:updateRankView()
    end
end

function ActivityModeCaveLeaderboardController:rankingViewAction(data)
    if self.activityModeCaveLeaderboardView then
        local data = data or {}
        self.activityModeCaveLeaderboardView:rankingViewAction(data)
    end
end

function ActivityModeCaveLeaderboardController:updateAwardView()
    if self.activityModeCaveLeaderboardView and self.activityModeCaveLeaderboardView._participationRewardsView then
        self.activityModeCaveLeaderboardView._participationRewardsView:updateBtnLayout()
        self.activityModeCaveLeaderboardView._participationRewardsView:updateAwardView(nil,true,true)

        self.activityModeCaveLeaderboardView:refereshRedPoint()
    end
end

return ActivityModeCaveLeaderboardController

