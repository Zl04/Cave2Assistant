------------------------------------------------------------------------------
------------------------------------------------------------------------------
--author: yudong.li
--date	: 2020/05/11
--desc	: 
------------------------------------------------------------------------------
local FestivalRelicStatisticView = class("FestivalRelicStatisticView", UI.HWBtnComponent)
require "app.modules.festival.FestivalRelicStatisticCell"
-- 资源
local COM_RES_LIST = {
    "ui_festival_relic.plist",
    "ui_common_icon_relic.plist"
}

local COM_WIDTH = 915
local COM_HEIGHT = 590

function FestivalRelicStatisticView:ctor()
    FestivalRelicStatisticView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function FestivalRelicStatisticView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.festival", "Festival", false)
    FestivalRelicStatisticView.super.init(self, ... )
end

function FestivalRelicStatisticView:dtor()
    FestivalRelicStatisticView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.festival.FestivalRelicStatisticView")
end


function FestivalRelicStatisticView:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_bg_box2.png")
    bg:center()
    self:addChild(bg, 1)

    local titleBg  = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    titleBg:centerUp(-8)
    bg:addChild(titleBg)

    -- 标题
    local title = UI.Text:create()
    title:init(UI.TEXT_1324050, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_170_170_170)
    title:center()
    titleBg:addChild(title)
    
    -- 分割线
    local splitter = UI.Image9:create()
    splitter:init("ui_scale9image_banner_line_dark2.png", CCRectMake(2,0,1,1), cc.size(859, 2))
    splitter:leftUp(101, 56)
    bg:addChild(splitter)

    local flagLeft = UI.Image:create()
    flagLeft:init("ui_festival_relic_choice_decorate1.png")
    flagLeft:leftBottom(-9, -9)
    bg:addChild(flagLeft, 20)

    local flagCenter = UI.Image:create()
    flagCenter:init("ui_festival_relic_pattern.png")
    flagCenter:center(0, 30)
    bg:addChild(flagCenter)

    local flagRight = UI.Image:create()
    flagRight:init("ui_festival_relic_choice_decorate2.png")
    flagRight:rightBottom(20, -9)
    bg:addChild(flagRight, 20)

    local flagBottom = UI.Image:create()
    flagBottom:init("ui_festival_relic_mask.png")
    flagBottom:center(-8, 255)
    bg:addChild(flagBottom, 10)

    self:initTableView(bg)
end

function FestivalRelicStatisticView:initTableView(rootNode)
        -- 任务列表
    self._tableView = UI.TableView:create({}, 850, 510)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftBottom(115, 21)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:setScrollBarEnabled(true)
    self._tableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    self._tableView:setCircleVisible(false)
    self._tableView:setScrollBarWidth(8)

    self._tableView:onUpdateCellSize(function(table,idx)
        if idx == self:getCellNumber() - 1 then
            return 830, 360
        else
            return 830, 291
        end
    end) 

    self._tableView:onUpdateCells(function(tableview, idx)
        -- 更新单元
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.TableViewCell:create()
        else
            cell:removeAllChildren()
        end
        xpcall(function()
            local view = UI.FestivalRelicStatisticCell:create(self:getCellLsit(idx), idx % 2 ~= 0)
            cell:addChild(view)
            if idx == self:getCellNumber() - 1 then
                view:leftBottom(0, 69)
            else
                view:leftBottom(0, 0)
            end
        end,
        function(e) 
            printError("------------------------GoodsListNew:tableCellAtIndex-----------------error", e)
        end, 1);
        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return self:getCellNumber()
    end)

    rootNode:addChild(self._tableView)
    self._tableView:reloadData()
end

function FestivalRelicStatisticView:getCellLsit(index)
    local beginIndex = 0
    local size = 5
    if index % 2 == 0 then
        beginIndex = index / 2 * 9
        size = 5
    else
        beginIndex = math.floor(index / 2) * 9 + 5
        size = 4
    end
    local list = mvc.festivalModel:getLegacyArr()
    local tempList = {}
    for i = beginIndex + 1, beginIndex + size do
        local value = list[i]
        if value then
            table.insert(tempList, value)
        end
    end
    return tempList
end

function FestivalRelicStatisticView:getCellNumber()
    local list = mvc.festivalModel:getLegacyArr()
    local size = #list
    local mainSize = math.floor(#list / 9) * 2
    local subSize = #list % 9
    if subSize <= 5 and subSize > 0 then
        subSize = 1
    elseif subSize > 5 then
        subSize = 2
    else
        subSize = 0
    end
    return mainSize + subSize
end

function FestivalRelicStatisticView:bindModel()

end

function FestivalRelicStatisticView:unbindModel()

end

return FestivalRelicStatisticView












