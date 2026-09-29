------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/12/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PurpleUpgradeMainView = class("PurpleUpgradeMainView", UI.HWBtnComponent)

local PurpleUpgradePacketLayer = require "app.modules.purpleupgrade.PurpleUpgradePacketLayer"

-- 资源
local COM_RES_LIST = {
    "ui_town_navigation.plist",
    "ui_town_businessactivities.plist",
    "ui_town_rough.plist"
}

local COM_WIDTH = 1024
local COM_HEIGHT = 560
local INNER_WIDTH = 980
local INNER_HEIGHT = 540
local BTN_CELL_W = 109
local BTN_CELL_H = 70

function PurpleUpgradeMainView:ctor()
    PurpleUpgradeMainView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function PurpleUpgradeMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.purpleupgrade", "PurpleUpgrade", false)
    PurpleUpgradeMainView.super.init(self, ... )
end

function PurpleUpgradeMainView:dtor()
    PurpleUpgradeMainView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.purpleupgrade.PurpleUpgradeMainView")
end


function PurpleUpgradeMainView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
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

    -- title
    local title  = UI.Image:create()
    title:init("ui_navigation_title_1.png")
    title:centerUp(-10)
    contentLayout:addChild(title)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_227500, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_204_204_204)
    titleText:centerUp(3)
    contentLayout:addChild(titleText)
    self.titleText = titleText

    -- 内部背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("ui_navigation_bg_1.png")
    centerBg:center()
    contentLayout:addChild(centerBg)

    local innerContentLayout = UI.Layout:create();
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:center()
    -- innerContentLayout:enableDebugDraw()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout, 2)

     self:makeTabList()
end

function PurpleUpgradeMainView:makeTabList()
    self.btnData = {}
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_227500
    tab1.select = false
    tab1.rootLayer = self.innerContentLayout

    local tab2 = {}
    tab2.idx = 2
    tab2.name = UI.TEXT_227523
    tab2.select = false
    tab2.rootLayer = self.innerContentLayout

    local tab3 = {}
    tab3.idx = 3
    tab3.name = UI.TEXT_227502
    tab3.select = false
    tab3.rootLayer = self.innerContentLayout

    local tab4 = {}
    tab4.idx = 4
    tab4.name = UI.TEXT_227501
    tab4.select = false
    tab4.rootLayer = self.innerContentLayout
    
    

    table.insert(self.btnData, tab1)
    table.insert(self.btnData, tab2)
    table.insert(self.btnData, tab3)
    table.insert(self.btnData, tab4)

    self._tableView = UI.TableView.new({}, BTN_CELL_W + 10, 300);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:rightUp(-58, 60)
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

        mvc.send("PurpleUpgrade_Click_Tab", clickIndex)
    end)

    self.contentLayout:addChild(self._tableView)
    self._tableView:reloadData(true)
end

function PurpleUpgradeMainView:setIsShowPacket(show)
    if self.purpleUpgradePacketLayer then
        self.purpleUpgradePacketLayer:setVisible(show)
    end
end

-- function PurpleUpgradeMainView:setTitle(clickIndex)
--     if clickIndex == 1 then
--         self.titleText:setText(UI.TEXT_227050)
--     elseif clickIndex == 2 then
--         self.titleText:setText(UI.TEXT_227029)
--     elseif clickIndex == 3 then
--         self.titleText:setText(UI.TEXT_227030)
--     end
-- end


function PurpleUpgradeMainView:bindModel()

end


function PurpleUpgradeMainView:unbindModel()

end





return PurpleUpgradeMainView












