--[[--
控制器RoleReincarnationController，view已经注入,可以通过mvc.roleReincarnationProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2023/03/06
-- desc	: 
------------------------------------------------------------------------------
local RoleReincarnationController = class("RoleReincarnationController", mvc.GameController)

-- mvc.events.RoleReincarnation_Req_Role_Reincarnation 处理函数
function RoleReincarnationController:noticeRoleReincarnationReqRoleReincarnation(notification)
    local master = RoleDataManager:getMaster()
    local reincarnationLv = master:getReincarntionLv()
    local config = ConfigManager:getAllRoleReincarnationDataByID(reincarnationLv+1)
    if config then
        Net.NetRoleSystem:reqRoleReincarnation(config.roleReiLv)
    end
end



-- mvc.events.RoleReincarnation_Show_Detail_Layer 处理函数
function RoleReincarnationController:noticeRoleReincarnationShowDetailLayer(notification, data)
    if self.roleReincarnationView and not tolua.isnull(self.roleReincarnationView) then
        self.roleReincarnationView:showDetailLayer(data)
    end
end



-- mvc.events.RoleReincarnation_Update_Role_Layout 处理函数
function RoleReincarnationController:noticeRoleReincarnationUpdateRoleLayout(notification, isTrigger)
    if self.roleReincarnationView and not tolua.isnull(self.roleReincarnationView) then
        self.roleReincarnationView:updateRoleLayout(isTrigger)
    end
end



return RoleReincarnationController