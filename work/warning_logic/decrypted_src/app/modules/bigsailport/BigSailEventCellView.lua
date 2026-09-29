------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/07/13
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailEventCellView = class("BigSailEventCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
}

local COM_WIDTH = 560
local COM_HEIGHT = 70

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
    ExpulsionBack = 12,   --成功将%s船只驱逐回港
    ExpelledBack = 13,   --我方船只被驱逐回赶
    ExpelledMonster = 14,   --我方船只驱逐%s，补给-%s，剩余%s，货币+%s
}

local EventTile = {
    [EventType.SailToIsland] = UI.TEXT_226003,
    [EventType.Expelled] = UI.TEXT_226004,
    [EventType.Expulsion] = UI.TEXT_226004,
    [EventType.OccupyIsland] = UI.TEXT_226005,
    [EventType.CancelOccupy] = UI.TEXT_226006,
    [EventType.SupplyConsumedUp] = UI.TEXT_226006,
    [EventType.AttackBoss] = UI.TEXT_226007,
    [EventType.MarkedIsland] = UI.TEXT_226002,
    [EventType.UnmarkedIsland] = UI.TEXT_226002,
    [EventType.MarkedGuild] = UI.TEXT_226002,
    [EventType.UnmarkedGuild] = UI.TEXT_226002,
    [EventType.ExpulsionBack] = UI.TEXT_226004,
    [EventType.ExpelledBack] = UI.TEXT_226004,
    [EventType.ExpelledMonster] = UI.TEXT_226004,

}

function BigSailEventCellView:ctor(data, isGuild)
    BigSailEventCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.isGuild = isGuild
    self:bindModel()
end

function BigSailEventCellView:init(  )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailport", "BigSailPort", false)
    BigSailEventCellView.super.init(self )
end

function BigSailEventCellView:dtor()
    BigSailEventCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailport.BigSailEventCellView")
end


function BigSailEventCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    -- 背景图片
    -- local bg  = UI.Image:create()
    -- bg:init("ui_bg_paper1.png")
    -- bg:center()
    -- contentLayout:addChild(bg)

    
    local line = UI.Image:create()
    line:init("ui_greatnavigation_line_3.png")
    line:centerBottom(0)
    contentLayout:addChild(line)

    self:initEventContentView()
end

-- message EventDetail {
--     // 事件类型<EventType>
--     optional uint32 type = 1;
--     // 生成时间
--     optional uint64 gameTime = 2;
--     // 事件id
--     optional uint32 eventid = 3;
--     // 岛屿id
--     optional uint32 islandid = 4;
--     // 事件者操作名称
--     optional string myname = 5;
--     // 事件受作用者
--     optional string othername = 6;
--     // format字串
--     repeated int32 format_num = 7;
-- }
function BigSailEventCellView:initEventContentView()
    local config = ConfigManager:getNavigationEventByID(self.data.type)
    local timeStr = GameManager:getNowServerDate("%m.%d %H:%M", self.data.gameTime + GameManager:getEPOCHTime())
    local myboatid = self.data.myboatid or 0
    local boatConfig = ConfigManager:getAllBoatDataByID(myboatid)

    local time = UI.Text:create()
    time:init(timeStr, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    time:leftUp(0, 0)
    self.contentLayout:addChild(time)

    local titleText = UI.Text:create()
    titleText:init(EventTile[self.data.type], UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:leftUp(130, 0)
    self.contentLayout:addChild(titleText)

    local width = time:getContentSize().width + titleText:getContentSize().width 
    local boatImgName = boatConfig and boatConfig.navigationShow or ""
    local boatImg  = UI.Image:create()
    if boatImgName and boatImgName ~= "" then
        boatImg:init(boatImgName)
        boatImg:leftUp(width, -35)
        self.contentLayout:addChild(boatImg)
        boatImg:setScale(0.4)
    end
    
    boatImg:hide()
    
    local desText = self.isGuild and languageManagerInstance:getLocalString(config.eventDesGuild) or languageManagerInstance:getLocalString(config.eventDesPersonal)
    local showDes = ""
    if self.data.type == EventType.SailToIsland then
        local islandConfig = self.data.islandid and ConfigManager:getIslandsByID(self.data.islandid) or {}
        local islandName = islandConfig.name and languageManagerInstance:getLocalString(islandConfig.name) or "island"
        if self.isGuild then
            showDes = string.format(desText, self.data.myname, islandName)
        else
            showDes = string.format(desText, islandName)
            boatImg:show()
        end

    elseif self.data.type == EventType.Expelled then
        if self.isGuild then
            showDes = string.format(desText, self.data.myname, self.data.othername, self.data.format_num[1], self.data.format_num[2])
        else
            showDes = string.format(desText, self.data.othername, self.data.format_num[1], self.data.format_num[2])
            boatImg:show()
        end

        
    elseif self.data.type == EventType.Expulsion then
        if self.isGuild then
            showDes = string.format(desText, self.data.myname, self.data.othername, self.data.format_num[1], self.data.format_num[2])
        else
            showDes = string.format(desText, self.data.othername, self.data.format_num[1], self.data.format_num[2])
            boatImg:show()
        end
    elseif self.data.type == EventType.OccupyIsland then
        local islandConfig = self.data.islandid and ConfigManager:getIslandsByID(self.data.islandid) or {}
        local islandName = islandConfig.name and languageManagerInstance:getLocalString(islandConfig.name) or "island"
        if self.isGuild then
            showDes = string.format(desText, self.data.myname, islandName)
        else
            showDes = string.format(desText, islandName)
            boatImg:show()
        end
    
    elseif self.data.type == EventType.CancelOccupy then
        local islandConfig = self.data.islandid and ConfigManager:getIslandsByID(self.data.islandid) or {}
        local islandName = islandConfig.name and languageManagerInstance:getLocalString(islandConfig.name) or "island"
        if self.isGuild then
            showDes = string.format(desText, self.data.myname, islandName)
        else
            showDes = string.format(desText, islandName)
            boatImg:show()
        end

    elseif self.data.type == EventType.SupplyConsumedUp then
        if self.isGuild then
            showDes = string.format(desText, self.data.myname)
        else
            showDes = desText--string.format(desText)
            boatImg:show()
        end
        
    elseif self.data.type == EventType.AttackBoss then
        if self.isGuild then
            showDes = string.format(desText, self.data.myname, self.data.format_num[1])
        else
            showDes = string.format(desText, self.data.format_num[1])
            boatImg:show()
        end
        

    elseif self.data.type == EventType.MarkedIsland then
        local islandConfig = self.data.islandid and ConfigManager:getIslandsByID(self.data.islandid) or {}
        local islandName = islandConfig.name and languageManagerInstance:getLocalString(islandConfig.name) or "island"
        showDes = string.format(desText, self.data.myname, islandName)

    elseif self.data.type == EventType.UnmarkedIsland then
        local islandConfig = self.data.islandid and ConfigManager:getIslandsByID(self.data.islandid) or {}
        local islandName = islandConfig.name and languageManagerInstance:getLocalString(islandConfig.name) or "island"
        showDes = string.format(desText, self.data.myname, islandName)

    elseif self.data.type == EventType.MarkedGuild then
        local islandConfig = self.data.islandid and ConfigManager:getIslandsByID(self.data.islandid) or {}
        local islandName = islandConfig.name and languageManagerInstance:getLocalString(islandConfig.name) or "island"
        showDes = string.format(desText, self.data.myname, self.data.othername)

    elseif self.data.type == EventType.UnmarkedGuild then
        local islandConfig = self.data.islandid and ConfigManager:getIslandsByID(self.data.islandid) or {}
        local islandName = islandConfig.name and languageManagerInstance:getLocalString(islandConfig.name) or "island"
        showDes = string.format(desText, self.data.myname, self.data.othername)
        
    elseif self.data.type == EventType.ExpulsionBack then
        local islandConfig = self.data.islandid and ConfigManager:getIslandsByID(self.data.islandid) or {}
        local islandName = islandConfig.name and languageManagerInstance:getLocalString(islandConfig.name) or "island"

        if self.isGuild then
            showDes = string.format(desText, self.data.myname, self.data.othername, islandName)
        else
            showDes = string.format(desText, self.data.othername, islandName)
            boatImg:show()
        end
        
    elseif self.data.type == EventType.ExpelledBack then
        local islandConfig = self.data.islandid and ConfigManager:getIslandsByID(self.data.islandid) or {}
        local islandName = islandConfig.name and languageManagerInstance:getLocalString(islandConfig.name) or "island"
        
        if self.isGuild then
            showDes = string.format(desText, self.data.myname, self.data.othername, islandName)
        else
            showDes = string.format(desText, self.data.othername, islandName)
            boatImg:show()
        end
    elseif self.data.type == EventType.ExpelledMonster then
        local monsterConfig = ConfigManager:getIslandMonsterByID(self.data.monsterId)
        local monsterName = languageManagerInstance:getLocalString(monsterConfig.name)
        showDes = string.format(desText, monsterName, self.data.format_num[1], self.data.format_num[2], self.data.format_num[3])
    end

    
    local des = UI.Text:create()
    des:init(showDes, UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    des:leftUp(0, 30)
    self.contentLayout:addChild(des)
end

function BigSailEventCellView:bindModel()

end


function BigSailEventCellView:unbindModel()

end





return BigSailEventCellView











