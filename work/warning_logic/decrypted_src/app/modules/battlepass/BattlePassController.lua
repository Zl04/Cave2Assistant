--[[--
控制器BattlePassController，view已经注入,可以通过mvc.battlePassProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: 
-- date	: 2019/08/01
-- desc	: 
------------------------------------------------------------------------------
local BattlePassController = class("BattlePassController", mvc.GameController)

-- mvc.events.BattlePass_ChangeLayer 处理函数
function BattlePassController:noticeBattlePassChangeLayer(notification)
	local param = notification.params
	print("---notification---", notification)
    if param[1] == 1 then
        self:hideView(self.battlePassShopView, true)
        self:showView(mvc.battlePassPanel, mvc.battlePassRewardView)
    elseif param[1] == 2 then
        self:hideView(self.battlePassRewardView, true)
        self:showView(mvc.battlePassPanel, mvc.battlePassShopView)
    end

end



return BattlePassController
