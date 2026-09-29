--[[--
控制器BetController，view已经注入,可以通过mvc.betProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: ping.zhengping.zhengping.zheng
-- date	: 2023/12/25
-- desc	: 
------------------------------------------------------------------------------
local BetController = class("BetController", mvc.GameController)

-- mvc.events.BetItemNum_Refresh 处理函数
function BetController:noticeBetItemNumRefresh(notification)
    if not self.betMainView then
        return
    end
    self.betMainView:updateBetIntemNum()
end



-- mvc.events.BetBaseInfo_Refresh 处理函数
function BetController:noticeBetBaseInfoRefresh(notification)
    print("BetController:noticeBetBaseInfoRefresh")
    if self.betMainView then
        print("BetController:noticeBetBaseInfoRefresh 1")
        self.betMainView:refreshInfo()
    end

    if self.rallyGameView then
        print("BetController:noticeBetBaseInfoRefresh 2")
        self.rallyGameView:refreshBoatInfo()
    end
end



-- mvc.events.BetBoatInfo_EventUpdate 处理函数
function BetController:noticeBetBoatInfoEventUpdate(notification, events)
    if not self.rallyGameView then
        return
    end
    self.rallyGameView:refreshBoatEvent(events)
end



-- mvc.events.Bet_SkillUpdate 处理函数
function BetController:noticeBetSkillUpdate(notification)

end



-- mvc.events.Bet_SettleResult 处理函数
function BetController:noticeBetSettleResult(notification)
    print("BetController:noticeBetSettleResult")
    if not self.rallyGameView then
        return
    end
    
    mvc.openPanel("Bet", "RallyResult")
end



-- mvc.events.Bet_ShowUseEffect 处理函数
function BetController:noticeBetShowUseEffect(notification, boatID, eventData)
    print("BetController:noticeBetShowUseEffect", boatID, eventData)
    if not self.rallyGameView then
        return
    end

    mvc.openPanel("Bet", "RallyBoatEffect", {boatID = boatID, eventData = eventData})
    -- 刷新技能冷却时间
    self.rallyGameView:refreshSkillCoolDown()
end



-- mvc.events.BetPersionInfo_Refresh 处理函数
function BetController:noticeBetPersionInfoRefresh(notification)
    if not self.betMainView then
        return
    end
    self.betMainView:refreshInfo()
end



return BetController