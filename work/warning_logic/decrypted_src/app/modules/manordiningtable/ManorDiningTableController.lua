--[[--
控制器ManorDiningTableController，view已经注入,可以通过mvc.manorDiningTableProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2022/08/22
-- desc	: 
------------------------------------------------------------------------------
local ManorDiningTableController = class("ManorDiningTableController", mvc.GameController)

-- mvc.events.Table_Show_Layer 处理函数
function ManorDiningTableController:noticeTableShowLayer(notification, name, parent)
    local layer
    if name == "ManorDiningTableLayer" then
        local manorDiningTableLayer = require "app.modules.manordiningtable.ManorDiningTableLayer"
        self.ManorDiningTableLayer = manorDiningTableLayer:create()
        layer = self.ManorDiningTableLayer

    elseif name == "DockUpgradeLayer" then

        local DockUpgradeLayer = require "app.modules.dock.DockUpgradeLayer"
        self.DockUpgradeLayer = DockUpgradeLayer:create(PublicDefine.ManorBuildID.BuildID_Table, UI.Type.DINNING_TABLE_UPGRADE)
        layer = self.DockUpgradeLayer

    elseif name == "ManorAppearanceLayer" then
        local ManorAppearanceLayer = require "app.modules.manorappearance.ManorAppearanceLayer"
        self.ManorAppearanceLayer = ManorAppearanceLayer:create(PublicDefine.ManorBuildID.BuildID_Table)
        -- self.ManorAppearanceLayer:init(PublicDefine.ManorBuildID.BuildID_Table)
        layer = self.ManorAppearanceLayer
    end

    layer:init()
    layer:center()
    parent.innerContentLayout:addChild(layer)
end



-- mvc.events.Table_Click_Tab 处理函数
function ManorDiningTableController:noticeTableClickTab(notification, clickIndex)
    if not self.manorDiningTableMainView then
        return
    end

    self.manorDiningTableMainView.curTabIndex = clickIndex
    self.manorDiningTableMainView.btnData[self.manorDiningTableMainView.curTabIndex].select = true
    self.manorDiningTableMainView._tableView:updateCellAtIndex(self.manorDiningTableMainView.curTabIndex - 1)

    if self.manorDiningTableMainView.lastTabIndex > 0 then
        if self.manorDiningTableMainView.lastTabIndex == clickIndex then
            return
        end
        self.manorDiningTableMainView.btnData[self.manorDiningTableMainView.lastTabIndex].select = false
        self.manorDiningTableMainView._tableView:updateCellAtIndex(self.manorDiningTableMainView.lastTabIndex - 1)
    end

    local nowPageId = self.manorDiningTableMainView.curTabIndex
    local lastPageId = self.manorDiningTableMainView.lastTabIndex
    printInfo("nowPageId == " .. nowPageId .. "  lastPageId == " .. lastPageId)

    local name = ""
    if nowPageId == 1 then
        name = "ManorDiningTableLayer"
    elseif nowPageId == 2 then
        name = "DockUpgradeLayer"
    elseif nowPageId == 3 then
        name = "ManorAppearanceLayer"
    end
    mvc.send("Table_Show_Layer", name, self.manorDiningTableMainView)

    if lastPageId == 1 and self.ManorDiningTableLayer and not tolua.isnull(self.ManorDiningTableLayer) then
        self.ManorDiningTableLayer:removeFromParent(false)
        self.ManorDiningTableLayer = nil
    elseif lastPageId == 2 and self.DockUpgradeLayer and not tolua.isnull(self.DockUpgradeLayer) then
        self.DockUpgradeLayer:removeFromParent(true)
        self.DockUpgradeLayer = nil
    elseif lastPageId == 3 and self.ManorAppearanceLayer and not tolua.isnull(self.ManorAppearanceLayer) then
        self.ManorAppearanceLayer:removeFromParent(true)
        self.ManorAppearanceLayer = nil
    end

    self.manorDiningTableMainView.lastTabIndex = self.manorDiningTableMainView.curTabIndex
end



-- mvc.events.Table_Open_Main_View 处理函数
function ManorDiningTableController:noticeTableOpenMainView(notification, layerName)
    mvc.openPanel("ManorDiningTable", "ManorDiningTableMain")
    local pageIndex = 1
    if layerName == "ManorDiningTableLayer" then
        pageIndex = 1
    elseif layerName == "DockUpgradeLayer" then
        pageIndex = 2
    elseif layerName == "ManorAppearanceLayer" then
        pageIndex = 3
    end

    mvc.send("Table_Click_Tab", pageIndex)
end



-- mvc.events.Table_Refresh_View 处理函数
function ManorDiningTableController:noticeTableRefreshView(notification)
    if self.ManorDiningTableLayer then
        self.ManorDiningTableLayer:updateTableInfo()
    end
end



return ManorDiningTableController