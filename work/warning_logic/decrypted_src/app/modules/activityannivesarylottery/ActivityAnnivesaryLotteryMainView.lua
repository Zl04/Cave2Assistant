------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityAnnivesaryLotteryMainView = class("ActivityAnnivesaryLotteryMainView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_activity_anniversary.plist"
}

local COM_WIDTH = 1100
local COM_HEIGHT = 500
local INNER_WIDTH = 620
local INNER_HEIGHT = 500
local BTN_CELL_W = 160
local BTN_CELL_H = 65

function ActivityAnnivesaryLotteryMainView:ctor()
    ActivityAnnivesaryLotteryMainView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ActivityAnnivesaryLotteryMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activityannivesarylottery", "ActivityAnnivesaryLottery", false)
    ActivityAnnivesaryLotteryMainView.super.init(self, ... )

    
end

function ActivityAnnivesaryLotteryMainView:dtor()
    ActivityAnnivesaryLotteryMainView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activityannivesarylottery.ActivityAnnivesaryLotteryMainView")
end


function ActivityAnnivesaryLotteryMainView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_anniversary_bg_2.png")
    bg:center()
    contentLayout:addChild(bg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_223620, UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_41_41_45)
    titleText:center(80, -180)
    contentLayout:addChild(titleText)

    -- 内部背景图片
    local innerContentLayout = UI.Layout:create();
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:center()
    -- innerContentLayout:enableDebugDraw()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout, 100)

    self:makeTabList()
end

function ActivityAnnivesaryLotteryMainView:makeTabList()
    self.btnData = {}
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_223600
    tab1.select = false
    tab1.rootLayer = self.innerContentLayout

    local tab2 = {}
    tab2.idx = 2
    tab2.name = UI.TEXT_223601
    tab2.select = false
    tab2.rootLayer = self.innerContentLayout

    table.insert(self.btnData, tab1)
    table.insert(self.btnData, tab2)

    self._tableView = UI.TableView.new({}, BTN_CELL_W + 10, 150);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:rightUp(17, 130)
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(false);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H+10;
    end);

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = UI.TableViewCell:create()
                cell:setContentSize(cc.size(109, 75))
                self.btnData[index].cell = cell
                local cellX = index == 1 and 11 or 50 
                local image = UI.Image.create()
                image:init("ui_anniversary_bookmark_1_2.png")
                image:center(cellX, 0)
                image:setName("image")
                cell:addChild(image)

                local text = UI.Text:create()
                text:init(self.btnData[index].name, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                text:center(cellX, 0)
                text:setWidth(107)
                text:setTextCenter()
                text:setLineSpacing(-6)
                text:setName("cellText")
                cell:addChild(text)
                local offsetX = index == 1 and 2 or -39
                local redPoint = AvalonUtil.createRedPoint(cell, offsetX, 2, 100)
                redPoint:setName("redPoint")
                redPoint:hide()
                if self.btnData[index].select then
                    text:setFontColor(UI.FONT_COLOR_41_41_45)
                    image:setSpriteName("ui_anniversary_bookmark_2_2.png")
                else
                    text:setFontColor(UI.FONT_COLOR_41_41_45)
                    image:setSpriteName("ui_anniversary_bookmark_1_2.png")
                end
            end,
            function(e) 
                printError("------------------------AnniversaryAppointmentMainView:tableCellAtIndex-----------------error")
            end, 1);
        else
            if self.btnData[index].select then
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_41_41_45)
                cell:getChildByName("image"):setSpriteName("ui_anniversary_bookmark_2_2.png")
            else
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_41_41_45)
                cell:getChildByName("image"):setSpriteName("ui_anniversary_bookmark_1_2.png")
            end

            if mvc.activityAnnivesaryLotteryModel:isShowRedPointInTab(1) then
                self.btnData[1].cell:getChildByName("redPoint"):show()
            elseif mvc.activityAnnivesaryLotteryModel:isShowRedPointInTab(2) then
                self.btnData[2].cell:getChildByName("redPoint"):show()
            else
                cell:getChildByName("redPoint"):hide()
            end

        end

        return cell;
    end);

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end);

    self._tableView:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        local clickIndex = cell:getIdx() + 1

        if self.curTabIndex == clickIndex then
            return
        end

        mvc.send("ActivityAnnivesary_Click_Tab", clickIndex)
    end)

    self.contentLayout:addChild(self._tableView, 1)
    self._tableView:reloadData(true)
end

function ActivityAnnivesaryLotteryMainView:showTip(x, y, isRevert, text)
    local pos = self:convertToNodeSpace(cc.p(x, y))

    -- 提示框
    local tipBG = self:getChildByName("TIP")
    if not tipBG then
        tipBG = UI.Image9:create()
        tipBG:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(0, 0))
        tipBG:setName("TIP")
        self:addChild(tipBG, 10000)
    end
    tipBG:leftBottom(pos.x, pos.y)
    tipBG:setVisible(true)

    local content = tipBG:getChildByName("tipContent")
    if not content then
        content = UI.Text:create()
        content:setName("tipContent")
        content:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_190_190_190)
        content:leftUp(10, 10)
        content:setTextLeft()
        tipBG:addChild(content)
    end
    content:setText(text)
    local textW = content:getContentSize().width
    local textH = content:getContentSize().height
    if textW > 210 then
        content:setWidth(210)
        content:autoAdapt()
        textH = content:getContentSize().height
        tipBG:setSize(220, textH+20)
    else
        tipBG:setSize(textW+20, textH+20)
    end

    local tipArrow  = tipBG:getChildByName("tipArrow")
    if not tipArrow then
        tipArrow = UI.Image:create();
        tipArrow:setName("tipArrow")
        tipArrow:init("ui_information_banner_background2.png")
        tipBG:addChild(tipArrow)
    end
    if isRevert then
        tipArrow:setScaleX(-1)
        tipArrow:centerLeft(-9)
    else
        tipArrow:centerRight(-9)
    end

    tipBG:updateView()
    local w = tipBG:getContentSize().width
    local h = tipBG:getContentSize().height
    if isRevert then
        tipBG:leftBottom(pos.x+60, pos.y-h/2)
    else
        tipBG:leftBottom(pos.x-w-60, pos.y-h/2)
    end
end

function ActivityAnnivesaryLotteryMainView:refreshTab()
    -- self._tableView:reloadData(true)
    if mvc.activityAnnivesaryLotteryModel:isShowRedPointInTab(1) then
        self.btnData[1].cell:getChildByName("redPoint"):show()
    else
        self.btnData[1].cell:getChildByName("redPoint"):hide()
    end

    if mvc.activityAnnivesaryLotteryModel:isShowRedPointInTab(2) then
        self.btnData[2].cell:getChildByName("redPoint"):show()
    else
        self.btnData[2].cell:getChildByName("redPoint"):hide()
    end
end

function ActivityAnnivesaryLotteryMainView:hideTip()
    local tip = self:getChildByName("TIP")
    if tip then
        tip:setVisible(false)
        -- self:removeChildByName("TIP")
    end
end

function ActivityAnnivesaryLotteryMainView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HIDE_PET_INFO_TIP, self, self.hideTip)
end


function ActivityAnnivesaryLotteryMainView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HIDE_PET_INFO_TIP, self, self.hideTip)
end





return ActivityAnnivesaryLotteryMainView












