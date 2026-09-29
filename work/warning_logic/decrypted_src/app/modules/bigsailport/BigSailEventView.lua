------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/07/13
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailEventView = class("BigSailEventView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_businessactivities.plist",
}

local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = 760
local COM_HEIGHT = 530
local INNER_WIDTH = 671
local INNER_HEIGHT = 444
local BTN_CELL_W = 109
local BTN_CELL_H = 70

function BigSailEventView:ctor()
    BigSailEventView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.tabCell = {}
    self:bindModel()
end

function BigSailEventView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailport", "BigSailPort", false)
    BigSailEventView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:close()
    end)
end

function BigSailEventView:dtor()
    BigSailEventView.super.dtor(self)
    self:unbindModel()
    self.tabCell = {}
    reload_script_file_mvc("app.modules.bigsailport.BigSailEventView")
end


function BigSailEventView:onInitView()
    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

     -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_bg_box1.png")
    bg:center()
    contentLayout:addChild(bg)

    -- title
    local title  = UI.Image:create()
    title:init("ui_bg_title.png")
    title:centerUp(-30)
    contentLayout:addChild(title)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_226000, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_204_204_204)
    titleText:center()
    title:addChild(titleText)

    -- 内部背景图片
    local innerContentLayout = UI.Layout:create();
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:center()
    -- innerContentLayout:enableDebugDraw()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout)

     self:makeTabList()

     self:refreshEventRedPoint()
end

function BigSailEventView:makeTabList()
    self.btnData = {}
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_226001
    tab1.select = false
    tab1.rootLayer = self.innerContentLayout

    local tab2 = {}
    tab2.idx = 2
    tab2.name = UI.TEXT_226002
    tab2.select = false
    tab2.rootLayer = self.innerContentLayout

    table.insert(self.btnData, tab1)
    table.insert(self.btnData, tab2)

    self._tableView = UI.TableView.new({}, BTN_CELL_W + 10, 300);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:rightUp(-98, 60)
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
                cell:setContentSize(cc.size(109, 68))
                self.btnData[index].cell = cell

                local image = UI.Image.create()
                image:init("ui_btn_gray2_1.png")
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
                    text:setFontColor(UI.FONT_COLOR_218_211_154)
                    image:setSpriteName("ui_btn_gray2_1.png")
                else
                    text:setFontColor(UI.FONT_COLOR_41_41_45)
                    image:setSpriteName("ui_btn_gray2_0.png")
                end
            end,
            function(e) 
                printError("------------------------PetTreasureMainView:tableCellAtIndex-----------------error")
            end, 1);
        else
            if self.btnData[index].select then
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_218_211_154)
                cell:getChildByName("image"):setSpriteName("ui_btn_gray2_1.png")
            else
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_41_41_45)
                cell:getChildByName("image"):setSpriteName("ui_btn_gray2_0.png")
            end


        end

        self.tabCell[index] = cell

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

        mvc.send("BigSailPort_Click_Log_Tab", clickIndex, self)
    end)

    self.contentLayout:addChild(self._tableView, 100)
    self._tableView:reloadData(true)

    mvc.send("BigSailPort_Click_Log_Tab", 1, self)
end

function BigSailEventView:refreshEventRedPoint()
    local eventShowRedPointList = mvc.bigSailPortModel:getRedPointIsShow()
    for k, v in pairs(eventShowRedPointList) do
        local evnetRed = self.tabCell[k]:getChildByName("redPoint")
        if evnetRed then
            evnetRed:setVisible(v or false)
        end
    end
end

function BigSailEventView:bindModel()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_REFRESH_EVENT_RED_POINT,self, self.refreshEventRedPoint)
end


function BigSailEventView:unbindModel()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_REFRESH_EVENT_RED_POINT,self, self.refreshEventRedPoint)
end





return BigSailEventView












