------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/10/09
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SouvenirView = class("SouvenirView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_souvenir.plist",
    "ui_town_navigation.plist",
    "ui_town_businessactivities.plist",
    "ui_bg_paper3.plist"
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local INNER_WIDTH = 980
local INNER_HEIGHT = 540
local CELL_WIDTH = 824
local CELL_HEIGHT = 264

local winSize = cc.Director:getInstance():getWinSize()

function SouvenirView:ctor()
    SouvenirView.super.ctor(
    	self,
    	UI.Type.SOUVENIR,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    --这里需要重新初始化一下数据, 避免倒计时错误问题
    mvc.souvenirModel:updateSouvenirDatas()
end

function SouvenirView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.souvenir", "Souvenir", false)
    SouvenirView.super.init(self, ... )
end

function SouvenirView:dtor()
    SouvenirView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.souvenir.SouvenirView")
end


function SouvenirView:onInitView()
    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 120))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_businessactivities_bg.png")
    bg:center()
    contentLayout:addChild(bg)

    

    -- 背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("ui_navigation_bg_1.png")
    centerBg:center()
    contentLayout:addChild(centerBg)
    self._centerBg = centerBg

    -- 标题底板
    local titleBg  = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    titleBg:center(0, -288)
    contentLayout:addChild(titleBg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_228400, UI.FONT_BOLD, UI.FONT_SIZE_26PX, {r=155,g=155,b=155})
    titleText:center()
    titleBg:addChild(titleText)

    -- 内部背景图片
    local innerContentLayout = UI.Layout:create();
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:center()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout)

    local leftText = UI.Text:create()
    leftText:init(string.format(UI.TEXT_228401, 0,0), UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r=41,g=41,b=45})
    leftText:leftUp(82,58)
    innerContentLayout:addChild(leftText)
    self._leftText = leftText

    local rightText = UI.Text:create()
    rightText:init(string.format(UI.TEXT_228402, 0,0), UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r=41,g=41,b=45})
    rightText:rightUp(82,58)
    innerContentLayout:addChild(rightText)
    self._rightText = rightText

    local lineImg  = UI.Image:create()
    lineImg:init("ui_navigation_line_4.png")
    lineImg:centerUp(86)
    innerContentLayout:addChild(lineImg)
    

    self:createContent()

    self:updateContent()
end

function SouvenirView:createContent()
    local tableView = UI.TableView.new({}, CELL_WIDTH, 392);
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    tableView:leftUp(70, 88)
    tableView:setDelegate();
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    tableView:setBounceable(true);
    tableView:init();
    self._tableView = tableView

    tableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT;
    end);

    tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            -- xpcall(function()
                cell = self:createCell(index)
            -- end,
            -- function(e)
            --     printError("------------------------SouvenirView:tableCellAtIndex-----------------error")
            -- end, 1)
        else
            if cell and not tolua.isnull(cell) then
                local souvenirCell = cell:getChildByName("souvenirCell")
                if souvenirCell and tolua.isnull(souvenirCell) and souvenirCell.dtor then
                    souvenirCell:dtor()
                end

                cell:removeFromParent(true)
                cell = nil
            end
            cell = self:createCell(index)
        end

        return cell
    end);

    tableView:onUpdateCellNumbers(function ()
        return math.floor((table.nums(mvc.souvenirModel.souvenirData) - 1) / 4) + 1;
    end);

    self.innerContentLayout:addChild(tableView);
end

function SouvenirView:createCell(index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))
    local souvenirCell = mvc.souvenirCellView:create()
    souvenirCell:init(index)
    souvenirCell:center()
    souvenirCell:setName("souvenirCell")
    cell:addChild(souvenirCell)

    cell.onExit = function()
        if souvenirCell and not tolua.isnull(souvenirCell) and souvenirCell.dtor then
            souvenirCell:dtor()
            souvenirCell:removeFromParent(true)
        end
    end

    return cell
end

function SouvenirView:updateContent()
    if self._leftText ~= nil then
        local haveNum = mvc.souvenirModel:havaSouvenirNum()
        local totalNum = table.nums(mvc.souvenirModel.souvenirData)
        self._leftText:setText(string.format(UI.TEXT_228401, haveNum, totalNum))
    end

    if self._rightText ~= nil then
        local activeNum = mvc.souvenirModel:havaSouvenirActivityNum()
        local totaActivelNum = tonumber(ConfigManager:getGeneralForKey("souvenirEffectLim"))
        self._rightText:setText(string.format(UI.TEXT_228402, activeNum, totaActivelNum))
    end

    if self._tableView ~= nil then
        self._tableView:reloadData(true)
    end
end


function SouvenirView:bindModel()

end


function SouvenirView:unbindModel()

end





return SouvenirView












