------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/06
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailPersonalEventLayer = class("BigSailPersonalEventLayer", UI.HWBtnComponent)
local PetPacketLayer = require("app.modules.pettreasure.common.PetTreasurePacketLayer")
local GameInManorManager = require "app.game.GameInManorManager"

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 671
local COM_HEIGHT = 444
local CELL_WIDTH = 630
local CELL_HEIGHT = 70
local TABLE_WIDTH = 650
local TABLE_HEIGHT = 380

local EventType = {
    SailToIsland = 1, --我方船只被派遣至%s岛屿，其中%s为岛屿名称
    Expelled = 2,   --我方船只被%s驱逐1次，补给-%s，剩余%s，其中第1个%s为驱逐玩家名称，第2个%s为补给消耗数量，第3个%s为补给剩余数量
    Expulsion = 3,   --我方船只驱逐%s的船只1次，补给-%s，剩余%s，其中第1个%s为被驱逐玩家名称，第2个%s为补给消耗数量，第3个%s为补给剩余数量
    OccupyIsland = 4,   --我方船只已成功占领%s岛屿，其中%s为岛屿名称
    CancelOccupy = 5,   --我方船只已取消占领，成功返回港口
    SupplyConsumedUp = 6,   --我方船只补给剩余0，已安全返回港口
    AttackBoss = 7,   --我方船只向终极boss发起攻击，造成伤害%s，其中%s为对boss造成的伤害值
    MarkedIsland = 8,   --%s管理员已标记%s岛屿为集中占领，快去占领岛屿吧！，其中第1个%s为管理员名称，第2个%s为岛屿名称
    UnmarkedIsland = 9,   --%s管理员已取消%s岛屿为集中占领，其中第1个%s为管理员名称，第2个%s为岛屿名称
    MarkedGuild = 10,   --%s管理员已设置%s公会为敌对公会，快去驱逐敌对公会成员吧！，其中第1个%s为管理员名称，第2个%s为被设置为敌对公会的公会名称
    UnmarkedGuild = 11,   --%s管理员已取消%s公会为敌对公会，其中第1个%s为管理员名称，第2个%s为被取消敌对公会的公会名称

}

local EventTile = {
    [EventType.SailToIsland] = UI.TEXT_226003,
    [EventType.Expelled] = UI.TEXT_226004,
    [EventType.Expulsion] = UI.TEXT_226005,
    [EventType.OccupyIsland] = UI.TEXT_226005,
    [EventType.CancelOccupy] = UI.TEXT_226006,
    [EventType.SupplyConsumedUp] = UI.TEXT_226006,
    [EventType.AttackBoss] = UI.TEXT_226007,
    [EventType.MarkedIsland] = UI.TEXT_226002,
    [EventType.UnmarkedIsland] = UI.TEXT_226002,
    [EventType.MarkedGuild] = UI.TEXT_226002,
    [EventType.UnmarkedGuild] = UI.TEXT_226002,

}

function BigSailPersonalEventLayer:bindModel()

end

function BigSailPersonalEventLayer:unbindModel()

end

function BigSailPersonalEventLayer:ctor(data, isGuild)
    BigSailPersonalEventLayer.super.ctor(
    	self,
    	uiType,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.eventData = data
    self.isGuild = isGuild
    self:bindModel()
end

function BigSailPersonalEventLayer:init()
    BigSailPersonalEventLayer.super.init(self)
end

function BigSailPersonalEventLayer:dtor()
    BigSailPersonalEventLayer.super.dtor(self)
    self:unbindModel()
    self.tableCellArr = {}

    reload_script_file_mvc("app.modules.bigsailport.BigSailPersonalEventLayer")
end

function BigSailPersonalEventLayer:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_bg_paper1.png")
    bg:center()
    contentLayout:addChild(bg)

    -- 背景图片
    local line = UI.Image:create()
    line:init("ui_greatnavigation_line_4.png")
    line:centerUp(30)
    contentLayout:addChild(line)

    self:createEventLayer()
end

function BigSailPersonalEventLayer:tabCellClick(index)
    if not index then
        return
    end

    local clickIndex = index

    if self.curTabIndex == clickIndex then
        return
    end

    self.curTabIndex = clickIndex
    self.btnData[self.curTabIndex].select = true
    self._tableView:updateCellAtIndex(self.curTabIndex - 1)

    printInfo("nowPageId == " .. self.curTabIndex .. "  lastPageId == " .. self.lastTabIndex, index)


    self.lastTabIndex = self.curTabIndex
    -- self:updateSailLayer(index)
end

function BigSailPersonalEventLayer:createEventLayer()
    -- local self.eventData = mvc.bigSailPortModel:getEventData().personal

    self.eventListTableView = UI.TableView.new({}, TABLE_WIDTH, TABLE_HEIGHT)
    self.eventListTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.eventListTableView:center(0, 10)
    self.eventListTableView:setDelegate()
    self.eventListTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.eventListTableView:setBounceable(true)
    self.eventListTableView:init()
    -- self.eventListTableView:enableDebugDraw()
    self.eventListTableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT+10
    end)

    self.eventListTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createEventCell(self.eventData[index])
            end,
            function(e)
                printError("------------------------BigSailPersonalEventLayer:tableCellAtIndex-----------------error")
            end, 1)
        else
            local eventCell = cell:getChildByName("eventCell")
            if eventCell and tolua.isnull(eventCell) then
                eventCell:removeFromParent()
                eventCell = nil
            end
            cell = self:createEventCell(self.eventData[index])
        end

        return cell
    end)

    self.eventListTableView:onUpdateCellNumbers(function ()
        return table.nums(self.eventData)
    end)

    self.contentLayout:addChild(self.eventListTableView, 100)
    self.eventListTableView:reloadData(true)
end

function BigSailPersonalEventLayer:createEventCell(data)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))

    local eventCell = mvc.bigSailEventCellView:create(data, self.isGuild)
    eventCell:init()
    eventCell:center()
    eventCell:setName("eventCell")
    cell:addChild(eventCell)

    -- eventCell:enableDebugDraw()

    return cell
end


return BigSailPersonalEventLayer












