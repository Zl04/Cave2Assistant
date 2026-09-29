------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/09/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local TradeActivityMainView = class("TradeActivityMainView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_common_information.plist",
    "ui_common_btn.plist",
    "ui_common_symbol.plist",
    "ui_town_businessactivities.plist",
    "ui_general_shopping.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local INNER_WIDTH = 681
local INNER_HEIGHT = 470
local BTN_CELL_W = 210
local BTN_CELL_H = 52

function TradeActivityMainView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_REFRESH_NEW_DAY, self, self.updateTabList)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN, self, self.updateTabList)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_ACTIVITY_REFRESH, self, self.updateTabList)
end

function TradeActivityMainView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_REFRESH_NEW_DAY, self, self.updateTabList)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN, self, self.updateTabList)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_ACTIVITY_REFRESH, self, self.updateTabList)
end

function TradeActivityMainView:ctor(activityID)
    TradeActivityMainView.super.ctor(
    	self,
    	UI.Type.TRADE_ACTIVITY_MAIN,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.activityID = activityID
    self.tableCellArr = {}

    self:bindModel()
end

function TradeActivityMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    TradeActivityMainView.super.init(self, ... )
end

function TradeActivityMainView:dtor()
    TradeActivityMainView.super.dtor(self)
    self:unbindModel()
    self.tableCellArr = {}
    reload_script_file_mvc("app.modules.tradeactivity.TradeActivityMainView")
end

function TradeActivityMainView:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_businessactivities_bg.png")
    bg:center()
    contentLayout:addChild(bg)

    -- 内部活动附着点
    local innerContentLayout = UI.Layout:create()
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:centerRight(0)
    -- innerContentLayout:enableDebugDraw()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout)

    -- 标题背景图片
    local bgTitle  = UI.Image:create()
    bgTitle:init("ui_businessactivities_title.png")
    bgTitle:leftUp(-64, 6)
    contentLayout:addChild(bgTitle)

    -- 标题
    local titleLayout = UI.Layout:create()
    titleLayout:init()
    titleLayout:enableAutoWidth()
    titleLayout:enableAutoHeight()
    titleLayout:center(-10, -100)
    -- titleLayout:enableDebugDraw()
    bgTitle:addChild(titleLayout)

    local leftStar = UI.Image:create()
    leftStar:init("ui_businessactivities_diamond.png")
    leftStar:floatLeft(0)
    leftStar:setRotation(180)
    titleLayout:addComponent(leftStar)

    local title = UI.Text:create()
    title:init(UI.TEXT_1324501, UI.FONT_BOLD, UI.FONT_SIZE_34PX, UI.FONT_COLOR_255_255_255)
    title:floatLeft(6)
    -- title:enableDebugDraw()
    title:setSize(200, 56)
    title:setTextCenter()
    if LanguageManager:getInstance():getLanguage() ~= cc.LANGUAGE_CHINESE then
        title:setFontSize(UI.FONT_SIZE_28PX)
        title:setLineSpacing(-14)

        local titleShadow = UI.Text:create()
        titleShadow:init(UI.TEXT_1324501, UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_0_0_0)
        titleShadow:center(2, 2)
        titleShadow:setSize(200, 56)
        titleShadow:setTextCenter()
        titleShadow:setLineSpacing(-14)
        title:addChild(titleShadow, -10)
    else
        title:setFontSize(UI.FONT_SIZE_34PX)
        title:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(3, -3))
    end
    titleLayout:addComponent(title)

    local rightStar = UI.Image:create()
    rightStar:init("ui_businessactivities_diamond.png")
    rightStar:floatLeft(6)
    titleLayout:addComponent(rightStar)

    --理性娱乐，适度消费

    local toastImg = UI.Image:create()
    toastImg:init("ui_shopping_banner_prompt.png")
    toastImg:leftUp(44, 66)
    titleLayout:addComponent(toastImg)

    local toastText = UI.Text:create()
	toastText:init(UI.TEXT_221301, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
	toastText:leftUp(66, 66)
    titleLayout:addComponent(toastText)

    if UI.TEXT_221301 == "" then
        toastImg:hide();
    end



    -- 左侧树
    local leftImg  = UI.Image:create()
    leftImg:init("ui_bg_tree.png")
    leftImg:leftBottom(-100, 14)
    contentLayout:addChild(leftImg, -10)

    -- 左侧气球
    local leftImg  = UI.Image:create()
    leftImg:init("ui_businessactivities_decoration.png")
    leftImg:leftBottom(-96, 18)
    contentLayout:addChild(leftImg)

    -- 右侧树
    local rightImg  = UI.Image:create()
    rightImg:init("ui_bg_decoration.png")
    rightImg:leftBottom(876, 12)
    contentLayout:addChild(rightImg)

    self:makeTabList()

    if self.activityID then
        for k, v in ipairs(self.btnData) do
            if self.activityID == v.activityID then
                self:tabCellClick(k)
                break
            end
        end
    else
        self:tabCellClick(1)
    end
end

function TradeActivityMainView:makeTabList()
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local openActivityIdList = mvc.tradeActivityModel:getOpenTradeActivityIdList()
    self.btnData = {}
    for k, v in ipairs(openActivityIdList) do
        local activityConfig = ConfigManager:getTradeActivityDataByID(v)
        if activityConfig.type == 16 then
            -- 单独的按钮打开，不添加进缤纷活动列表中
            break
        end

        local tab = {}
        tab.activityID = v
        tab.name = activityConfig.name
        tab.viewName = mvc.tradeActivityModel:getActivityViewNameByID(v)
        tab.select = false
        tab.rootLayer = self.innerContentLayout

        table.insert(self.btnData, tab)
    end

    self._tableView = UI.TableView.new({}, BTN_CELL_W + 10, 410)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftUp(18, 110)
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end)

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createTabCell(index)
            end,
            function(e)
                printError("------------------------TradeActivityMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            cell:removeFromParent()
            cell = self:createTabCell(index)
        end

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end)

    self._tableView:onTableCellTouched(function(table, cell)
        self:tabCellClick(cell:getIdx() + 1)
    end)
    if(GameManager:getIsGooglePlay()) then
        self._tableView:onTableCellHighLight(function(table, cell)
            local endIndex = cell:getIdx() + 1
            if(self.tableCellArr[endIndex]) then 
                self.tableCellArr[endIndex]:hightLight()

                Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                    if(not tolua.isnull(self)) then
                        if(self.tableCellArr[endIndex] and self.curTabIndex ~= endIndex) then 
                            self.tableCellArr[endIndex]:unHightLight()
                        end
                    end
                end, 1)
            end
        end)

        self._tableView:onTableCellUnHighLight(function(table, cell)
            local endIndex = cell:getIdx() + 1
            if(self.tableCellArr[endIndex]) then 
                self.tableCellArr[endIndex]:unHightLight()
            end
        end)
    end

    self.contentLayout:addChild(self._tableView, 100)
    self._tableView:reloadData(true)
end

function TradeActivityMainView:createTabCell(index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(206, 46))

    local image = UI.Image.create()
    image:init("ui_businessactivities_label_01.png")
    image:centerBottom(0)
    image:setName("image")
    cell:addChild(image)

    local text = UI.Text:create()
    text:init(self.btnData[index].name, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    text:center(0, 4)
    text:setWidth(107)
    text:setTextCenter()
    text:setLineSpacing(-6)
    text:setName("cellText")
    cell:addChild(text)

    local redPoint = AvalonUtil.createRedPoint(cell, 2, 2, 100)
    redPoint:setName("redPoint")
    redPoint:hide()

    if self.curTabIndex ~= index then
        if mvc.tradeActivityModel:getTabRedPointIsShow(self.btnData[index].activityID) then
            redPoint:show()
        else
            redPoint:hide()
        end
        text:setFontColor(UI.FONT_COLOR_41_41_45)
        image:setSpriteName("ui_businessactivities_label_01.png")
    else
        text:setFontColor(UI.FONT_COLOR_218_211_154)
        image:setSpriteName("ui_businessactivities_label_02.png")
        redPoint:hide()
    end

    cell.hightLight = function()
        text:setFontColor(UI.FONT_COLOR_218_211_154)
        image:setSpriteName("ui_businessactivities_label_02.png")
        redPoint:hide()
    end

    cell.unHightLight = function()
        text:setFontColor(UI.FONT_COLOR_41_41_45)
        image:setSpriteName("ui_businessactivities_label_01.png")
    end

    self.tableCellArr[index] = cell
    return cell
end

function TradeActivityMainView:tabCellClick(index)
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

    -- 如果没有self.btnData[self.lastTabIndex]可能是活动关闭页签消失了，自动跳转
    if self.lastTabIndex > 0 and self.btnData[self.lastTabIndex] then
        self.btnData[self.lastTabIndex].select = false
        self._tableView:updateCellAtIndex(self.lastTabIndex - 1)
    end

    printInfo("nowPageId == " .. self.curTabIndex .. "  lastPageId == " .. self.lastTabIndex)

    local viewName = self.btnData[self.curTabIndex].viewName

    mvc.tradeActivityModel:setCurActivityID(self.btnData[self.curTabIndex].activityID)
    mvc.send("TradeActivity_Show_View", viewName)

    self.lastTabIndex = self.curTabIndex
end

function TradeActivityMainView:updateTabList()
    local openActivityIdList = mvc.tradeActivityModel:getOpenTradeActivityIdList()

    if table.nums(openActivityIdList) <= 0 then
        mvc.closePanel("TradeActivity", "TradeActivityMain")
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
        return
    end

    local curActivityID = mvc.tradeActivityModel:getCurActivityID()
    self.btnData = {}
    for k, v in ipairs(openActivityIdList) do
        local activityConfig = ConfigManager:getTradeActivityDataByID(v)

        if activityConfig.type == 16 then
            -- 单独的按钮打开，不添加进缤纷活动列表中
            break
        end

        local tab = {}
        tab.activityID = v
        tab.name = activityConfig.name
        tab.viewName = mvc.tradeActivityModel:getActivityViewNameByID(v)
        tab.select = false
        tab.rootLayer = self.innerContentLayout

        table.insert(self.btnData, tab)
    end

    self._tableView:reloadData(true)

    if mvc.tradeActivityModel:getActivityIsOpeningByID(curActivityID) then
        for k, v in ipairs(self.btnData) do
            if curActivityID == v.activityID then
                self:tabCellClick(k)
                break
            end
        end
    else
        self:tabCellClick(1)
    end
end

return TradeActivityMainView












