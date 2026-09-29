-- GoldenMineShowBoostPanel.lua
-- Author:linfeng.li

require "app.ui.UIDefine"

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local GoldenMineShowBoostPanel = class("GoldenMineShowBoostPanel", UI.CenterWin)
UI.GoldenMineShowBoostPanel = GoldenMineShowBoostPanel

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local COM_WIDTH = 489;
local COM_HEIGHT = 347;

--资源列表(必备)
local COM_RES_LIST = {
    
}

--构造函数(必备)
function GoldenMineShowBoostPanel:ctor(consumeList,cb)
     GoldenMineShowBoostPanel.super.ctor(
        self, 
        UIType.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self._cb = cb
    self._consumeList = consumeList
    
    self.isNoticeShowMainUI = false
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
    self:open()
end

--虚构函数, destroy时调用(必备)
function GoldenMineShowBoostPanel:dtor()
    GoldenMineShowBoostPanel.super.dtor(self)
    self:unregisterListener()

    reload_script_file("app.ui.home.goldenMine.GoldenMineShowBoostPanel")
end

-- 初始化(必备)
function GoldenMineShowBoostPanel:init()
    GoldenMineShowBoostPanel.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function GoldenMineShowBoostPanel:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0,0,0,128));
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    contentLayout:addChild(mask)

    -- local maskLayout = UI.Layout:create();
    -- maskLayout:init()
    -- maskLayout:setSize(winSize.width * 2, winSize.height * 2)
    -- maskLayout:center()
    -- maskLayout:setTouchEnable(true)
    -- maskLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function() self:closeWin() end)
    -- contentLayout:addChild(maskLayout, 0)

    -- 背景图片
    local bg = UI.Image:create()
    bg:init("ui_common_paper.png")
    bg:center()
    bg:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:closeWin()
    end)
    self:addChild(bg)

    local okBtn = UI.Button:create();
    okBtn:init("ui_btn_yellow2_0.png","ui_btn_yellow2_0.png","ui_btn_yellow2_0.png");
    okBtn:centerBottom(15)
    okBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    okBtn:setText(UI.TEXT_1170211)
    okBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self._cb then
            self._cb()
            self:closeWin()
        end
    end)
    bg:addChild(okBtn)

    local titleImg = UI.Image:create()
    titleImg:init("ui_common_title.png")
    titleImg:centerUp(30)
    bg:addChild(titleImg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_223950, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(21)
    bg:addChild(titleText)

    local titleText2 = UI.Text:create()
    titleText2:init(UI.TEXT_223951, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText2:centerUp(58)
    bg:addChild(titleText2)

    
    local gNum = 5
    local tableview = UI.TableView.new({}, 434, 178)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableview:centerBottom(75)
    tableview:setDelegate()
    -- tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableview:init()
    tableview:setBounceable(true);
    tableview:onUpdateCellSize(function (table,idx)
        return 434, 78;
    end);

    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = UI.TableViewCell:create()
                cell:setContentSize(cc.size(434, 78))
                
                for i = 1 + (index - 1)*gNum, index*gNum do
                    local consumeData = self._consumeList[i]
                    if consumeData then
                        local goodsGridNode = self:createGoodsGrid(consumeData, i - (index - 1)*gNum)
                        -- goodsGridNode:setName("goodsGridNode")
                        cell:addChild(goodsGridNode)
                    end
                end
            end,
            function(e)
                printError("------------------------ActivityModeCaveMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            -- local goodsGridNode = cell:getChildByName("goodsGridNode")
            -- if goodsGridNode and tolua.isnull(goodsGridNode) then
            --     goodsGridNode:removeFromParent()
            --     goodsGridNode = nil
            -- end
            cell:removeFromParent()
            cell = UI.TableViewCell:create()
            cell:setContentSize(cc.size(434, 78))
            
            for i = 1 + (index - 1)*gNum, index*gNum do
                local consumeData = self._consumeList[i]
                if consumeData then
                    local goodsGridNode = self:createGoodsGrid(consumeData, i - (index - 1)*gNum)
                    cell:addChild(goodsGridNode)
                end
            end
        end

        return cell;
    end);

    tableview:onUpdateCellNumbers(function ()
        return math.ceil(table.nums(self._consumeList) / gNum)
    end);


    bg:addChild(tableview)
    tableview:reloadData(true)
    self.tableview = tableview

end

function GoldenMineShowBoostPanel:createGoodsGrid(consumeData, idx)
    local goodsLayout = UI.Layout:create();
    goodsLayout:init()
    goodsLayout:centerLeft( 41 + (idx - 1) * 88)

    local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(consumeData.id))

    if goodsData then
        goodsData:setNum(consumeData.count)
        goodsData:setIsNew(false)

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init(goodsData)
        goodsGrid:center()
        -- goodsGrid:setInfoArea(true, false)
        goodsGrid:showInfoArea()
        goodsLayout:addChild(goodsGrid)

    end

    return goodsLayout
end

function GoldenMineShowBoostPanel:registerListener()
end

function GoldenMineShowBoostPanel:unregisterListener()
end
---------------------------------------
-- eo 事件处理 --
