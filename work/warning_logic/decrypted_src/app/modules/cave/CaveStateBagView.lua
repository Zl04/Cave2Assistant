------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2021/02/18
--desc	: 
------------------------------------------------------------------------------

local CaveStateBagView = class("CaveStateBagView", UI.HWBtnComponent)
require "app.modules.cave.CaveStateBagCell"
-- 资源
local COM_RES_LIST = {
    "ui_town_inferno.plist",
    "ui_festival_relic.plist",
    "ui_common_icon_relic.plist"
}

local COM_WIDTH = 915
local COM_HEIGHT = 590

function CaveStateBagView:ctor(caveMode)
    self.caveMode = caveMode
    CaveStateBagView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function CaveStateBagView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.cave", "Cave", false)
    CaveStateBagView.super.init(self, ... )
end

function CaveStateBagView:dtor()
    CaveStateBagView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.cave.CaveStateBagView")
end


function CaveStateBagView:onInitView()
    local mask = AvalonUtil.createDialogMask()
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local bg = UI.Image:create()
    bg:init("ui_bg_box2.png")
    bg:center()
    self:addChild(bg, 1)

    local titleBg  = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    titleBg:centerUp(-8)
    bg:addChild(titleBg)

    -- 标题
    local text
    if self.caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
        text = UI.TEXT_222102
    elseif self.caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then
        text = UI.TEXT_1325503
    elseif self.caveMode == PublicDefine.CAVE_MODE.MODE_VIKING then
        text = UI.TEXT_223802
    else
        text = UI.TEXT_223412
    end
    local title = UI.Text:create()
    title:init(text, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_170_170_170)
    title:center(10)
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

function CaveStateBagView:initTableView(rootNode)
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
            return 830, 390
        else
            return 830, 321
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
            local view = UI.CaveStateBagCell:create(self:getCellLsit(idx), idx % 2 ~= 0)
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

function CaveStateBagView:getCellLsit(index)
    local beginIndex = 0
    local size = 5
    if index % 2 == 0 then
        beginIndex = index / 2 * 9
        size = 5
    else
        beginIndex = math.floor(index / 2) * 9 + 5
        size = 4
    end
    local list = mvc.caveModel:getAllNewCaveRuneByCaveMode(self.caveMode)--getAllInfernoRune()
    local tempList = {}
    for i = beginIndex + 1, beginIndex + size do
        local value = list[i]
        if value then
            table.insert(tempList, value)
        end
    end
    return tempList
end

function CaveStateBagView:getCellNumber()
    local list = mvc.caveModel:getAllNewCaveRuneByCaveMode(self.caveMode)--getAllInfernoRune()
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

function CaveStateBagView:bindModel()

end

function CaveStateBagView:unbindModel()

end

return CaveStateBagView