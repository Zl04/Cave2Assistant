--[[--
控制器ManorStarMapController，view已经注入,可以通过mvc.manorStarMapProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2022/06/27
-- desc	: 
------------------------------------------------------------------------------
local ManorStarMapController = class("ManorStarMapController", mvc.GameController)

function ManorStarMapController:respRefreshBuildStarMapView(addExp)
    if self.manorStarMapView and self.manorStarMapView._cardView then
        self.manorStarMapView._cardView:refreshBuildStarMapView(addExp)
    end
end

function ManorStarMapController:respRefreshCardLayout()
    if self.manorStarMapView and self.manorStarMapView._cardView then
        self.manorStarMapView._cardView:refreshCardLayout()
    end
end

function ManorStarMapController:respRefreshAboutEquipCardLayout(cardId)
    if self.manorStarMapView and self.manorStarMapView._cardView then
        self.manorStarMapView._cardView:refreshStarMapLayout(cardId)
        self.manorStarMapView._cardView:refreshCardLayout()
        self.manorStarMapView._cardView:refreshAttributesView()
    end
end

function ManorStarMapController:respRefreshCardUpgradeLayout()
    if self.manorStarMapView and self.manorStarMapView._upgradeView then
        self.manorStarMapView._upgradeView:createAndRefreshLeftUpgradePanel()
        self.manorStarMapView._upgradeView:refreshRightCardBoxPanel()
    end
end


return ManorStarMapController

