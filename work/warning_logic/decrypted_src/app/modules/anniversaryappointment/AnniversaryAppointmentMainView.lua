------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/10/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local AnniversaryAppointmentMainView = class("AnniversaryAppointmentMainView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_activity_anniversary.plist"
}

local COM_WIDTH = 982
local COM_HEIGHT = 614
local INNER_WIDTH = 980
local INNER_HEIGHT = 540
local BTN_CELL_W = 113
local BTN_CELL_H = 68

function AnniversaryAppointmentMainView:ctor()
    AnniversaryAppointmentMainView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function AnniversaryAppointmentMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.anniversaryappointment", "AnniversaryAppointment", false)
    AnniversaryAppointmentMainView.super.init(self, ... )
end

function AnniversaryAppointmentMainView:dtor()
    AnniversaryAppointmentMainView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.anniversaryappointment.AnniversaryAppointmentMainView")
end


function AnniversaryAppointmentMainView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_anniversary_bg.png")
    bg:center()
    contentLayout:addChild(bg)

    -- title
    -- local title  = UI.Image:create()
    -- title:init("ui_navigation_title_1.png")
    -- title:centerUp(-10)
    -- contentLayout:addChild(title)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_223203, UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(15)
    contentLayout:addChild(titleText)

    -- 内部背景图片
    local innerContentLayout = UI.Layout:create();
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:center()
    -- innerContentLayout:enableDebugDraw()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout)

    -- 背景图片
    local left = UI.Image:create()
    left:init("ui_anniversary_decorate_left.png")
    left:leftBottom(50, 30)
    contentLayout:addChild(left)

    -- 背景图片
    local right  = UI.Image:create()
    right:init("ui_anniversary_decorate_right.png")
    right:rightBottom(70, 20)
    contentLayout:addChild(right)

     self:makeTabList()
end

function AnniversaryAppointmentMainView:makeTabList()
    self.btnData = {}
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_223200
    tab1.select = false
    tab1.rootLayer = self.innerContentLayout

    local tab2 = {}
    tab2.idx = 2
    tab2.name = UI.TEXT_223201
    tab2.select = false
    tab2.rootLayer = self.innerContentLayout

    local tab3 = {}
    tab3.idx = 3
    tab3.name = UI.TEXT_223202
    tab3.select = false
    tab3.rootLayer = self.innerContentLayout

    table.insert(self.btnData, tab1)
    table.insert(self.btnData, tab2)
    table.insert(self.btnData, tab3)

    self._tableView = UI.TableView.new({}, BTN_CELL_W + 10, 300);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:rightUp(6, 90)
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(false);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end);

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = UI.TableViewCell:create()
                cell:setContentSize(cc.size(109, 75))
                self.btnData[index].cell = cell

                local image = UI.Image.create()
                image:init("ui_anniversary_bookmark_2.png")
                image:centerBottom(0)
                image:setName("image")
                cell:addChild(image)

                local text = UI.Text:create()
                text:init(self.btnData[index].name, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                text:centerBottom(20)
                text:setWidth(107)
                text:setTextCenter()
                text:setLineSpacing(-6)
                text:setName("cellText")
                cell:addChild(text)

                local redPoint = AvalonUtil.createRedPoint(cell, 2, 2, 100)
                redPoint:setName("redPoint")
                redPoint:hide()

                if self.btnData[index].select then
                    text:setFontColor(UI.FONT_COLOR_41_41_45)
                    image:setSpriteName("ui_anniversary_bookmark_2.png")
                else
                    text:setFontColor(UI.FONT_COLOR_41_41_45)
                    image:setSpriteName("ui_anniversary_bookmark_1.png")
                end
            end,
            function(e) 
                printError("------------------------PetTreasureMainView:tableCellAtIndex-----------------error")
            end, 1);
        else
            if self.btnData[index].select then
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_41_41_45)
                cell:getChildByName("image"):setSpriteName("ui_anniversary_bookmark_2.png")
            else
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_41_41_45)
                cell:getChildByName("image"):setSpriteName("ui_anniversary_bookmark_1.png")
            end

            -- if self.btnData[3].select == false then
            --     if #mvc.petTreasureModel:getFragmentsBag() == mvc.petTreasureModel:getFragmentsTotalNum() 
            --     and GameManager:getNormalServerTime() > mvc.petTreasureModel:getFragmentCompoundTime() then
            --         self.btnData[3].cell:getChildByName("redPoint"):show()
            --     else
            --         self.btnData[3].cell:getChildByName("redPoint"):hide()
            --     end
            -- else
            --     self.btnData[3].cell:getChildByName("redPoint"):hide()
            -- end

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

        mvc.send("AnniversaryAppointment_Click_Tab", clickIndex)
    end)

    self.contentLayout:addChild(self._tableView, 100)
    self._tableView:reloadData(true)
end

function AnniversaryAppointmentMainView:bindModel()

end


function AnniversaryAppointmentMainView:unbindModel()

end





return AnniversaryAppointmentMainView












