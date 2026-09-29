--[[--
控制器ManorDressUpShelfController，view已经注入,可以通过mvc.manorDressUpShelfProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2022/08/15
-- desc	: 
------------------------------------------------------------------------------
local ManorDressUpShelfController = class("ManorDressUpShelfController", mvc.GameController)

-- mvc.events.Manor_DressUp_Operation_Refresh 处理函数
function ManorDressUpShelfController:noticeManorDressUpOperationRefresh(notification, refreshType)
    if not self.manorDressUpShelfView or not self.manorDressUpShelfView._operationView then
        return
    end
    if refreshType == 1 then
        --刷新选中套装对应的装备列表
        self.manorDressUpShelfView._operationView:updateAllView()

    elseif refreshType == 2 then
        --刷新展示外形layout

    end
end



return ManorDressUpShelfController
