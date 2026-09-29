------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/08/20
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorDiningTableLayer = class("ManorDiningTableLayer", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    -- "ui_common_information.plist",
    -- "ui_common_btn.plist",
    -- "ui_common_symbol.plist",
    -- "ui_general_shopping.plist",
    "ui_manor_cook.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local INNER_WIDTH = 681
local INNER_HEIGHT = 470
local BTN_CELL_W = 210
local BTN_CELL_H = 52
local RIGHT_COM_W = 680
local RIGHT_COM_H = 410

local CELL_WIDTH = 838
local CELL_HEIGHT = 143

function ManorDiningTableLayer:ctor()
    ManorDiningTableLayer.super.ctor(
    	self,
    	UI.Type.DINNING_TABLE_COOK,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.tableCellArr = {}

    self:bindModel()
end

function ManorDiningTableLayer:init( ... )
    ManorDiningTableLayer.super.init(self, ... )
end

function ManorDiningTableLayer:dtor()
    ManorDiningTableLayer.super.dtor(self)
    self:unbindModel()
    self.tableCellArr = {}
    reload_script_file_mvc("app.modules.manordiningtable.ManorDiningTableLayer")
end

function ManorDiningTableLayer:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("ui_navigation_bg_1.png")
    centerBg:center()
    contentLayout:addChild(centerBg)

    -- 装饰
    -- local decorate  = UI.Image:create()
    -- decorate:init("ui_navigation_decorate_left.png")
    -- decorate:leftBottom(-75, 10)
    -- contentLayout:addChild(decorate, 1000)

    -- 装饰
    -- local decorateRight  = UI.Image:create()
    -- decorateRight:init("ui_cook_decorate.png")
    -- decorateRight:rightBottom(-85, 15)
    -- contentLayout:addChild(decorateRight, 1000)
    
    self:createAwardsLayer()
end

function ManorDiningTableLayer:createAwardsLayer(layout)
    self.recipeConfigData = ConfigManager:getAllRecipeData()
    self.recipeTableView = UI.TableView.new({}, CELL_WIDTH+15, 420)
    self.recipeTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.recipeTableView:center()
    -- self.recipeTableView:enableDebugDraw()
    self.recipeTableView:setDelegate()
    self.recipeTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.recipeTableView:setBounceable(true)
    self.recipeTableView:init()
    self.recipeTableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT+20
    end)

    self.recipeTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createAwardCell(self.recipeConfigData[index])
            end,
            function(e)
                printError("------------------------TradeActivityMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local image = cell:getChildByName("recipeCell")
            if image and tolua.isnull(image) then
                image:removeFromParent(true)
                image = nil
            end
            if cell and not tolua.isnull(cell) then
                cell:removeAllChildren(true)
                cell:removeFromParent(true)
                cell = nil
            end
            cell = self:createAwardCell(self.recipeConfigData[index])
        end

        return cell
    end)

    self.recipeTableView:onUpdateCellNumbers(function ()
        return #self.recipeConfigData
    end)

    self.contentLayout:addChild(self.recipeTableView, 100)
    self.recipeTableView:reloadData(true)
end

function ManorDiningTableLayer:createAwardCell(data)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))

    local recipeCell = mvc.manorDiningTableInfoCellView:create(data)
    recipeCell:init()
    recipeCell:center(0, 0)
    recipeCell:setName("recipeCell")
    cell:addChild(recipeCell)


    return cell
end

function ManorDiningTableLayer:updateTableInfo()
    self.recipeTableView:reloadData(true)
end

function ManorDiningTableLayer:close()
    ManorDiningTableLayer.super.close(self)
end

function ManorDiningTableLayer:bindModel()

end

function ManorDiningTableLayer:unbindModel()

end


return ManorDiningTableLayer












