------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/30
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapPokedexView = class("ManorStarMapPokedexView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 1006
local COM_HEIGHT = 583

function ManorStarMapPokedexView:ctor(mosaicType)
    ManorStarMapPokedexView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._mosaicType = mosaicType
end

function ManorStarMapPokedexView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapPokedexView.super.init(self, ... )
end

function ManorStarMapPokedexView:dtor()
    ManorStarMapPokedexView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapPokedexView")
end


function ManorStarMapPokedexView:onInitView()
    self:center()
    
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local titleBg = UI.Image:create()
    titleBg:init("ui_starmap_title_bg.png")
    titleBg:centerUp(-13)
    self.contentLayout:addChild(titleBg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_222602, UI.FONT_BOLD, UI.FONT_SIZE_26PX, {r=196,g=208,b=214})
    titleText:center()
    titleBg:addChild(titleText)

    local contentBg = UI.Image:create()
    contentBg:init("ui_starmap_book_paper.png")
    contentBg:centerUp(42)
    self.contentLayout:addChild(contentBg)

    local pokedexConfig = {}
    local pokedexConfig2 = ConfigManager:getAllStarMapData()
    for k,v in pairs(pokedexConfig2) do
        if v.starMapType == self._mosaicType then
            table.insert(pokedexConfig, v)
        end
    end

    local tableView = UI.TableView:create({}, 820 + 30, 464)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:centerBottom(14)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setBounceable(true) 
    tableView:init()
    tableView:setScrollBarEnabled(false)
    tableView:setCircleVisible(false)
    tableView:onUpdateCellSize(function (tableview, idx)
        return 820 + 30,192 + 35
    end) 
    tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell then
            cell:removeAllChildren()
            cell:removeFromParent()
            cell = nil
        end
        if cell == nil then
            xpcall(function()
                cell = UI.TableViewCell:create()

                local cardView = mvc.manorStarMapPokedexCellView:create(pokedexConfig[luaIdx].Id)
                cardView:init()
                cardView:leftBottom(15,0)
                cell:addChild(cardView)

                -- self._cardViewTable[luaIdx] = cardView
            end, 
            function(e) 
                printError("------------------------ManorStarMapPokedexView-----------------error", e)
            end, 1)
        end

        return cell
    end)

    tableView:onUpdateCellNumbers(function()
        return table.nums(pokedexConfig)
    end)

    contentBg:addChild(tableView)
    tableView:reloadData()
    self.tableView = tableView
    
    local bannerImg = UI.Image:create()
    bannerImg:init("ui_starmap_banner_up_2.png")
    bannerImg:centerBottom(0)
    contentBg:addChild(bannerImg)

end

function ManorStarMapPokedexView:setMosaicType(MosaicType)
    -- body
    self._mosaicType = MosaicType

    local pokedexConfig = {}
    local pokedexConfig2 = ConfigManager:getAllStarMapData()
    for k,v in pairs(pokedexConfig2) do
        if v.starMapType == self._mosaicType then
            table.insert(pokedexConfig, v)
        end
    end

    self.tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell then
            cell:removeAllChildren()
            cell:removeFromParent()
            cell = nil
        end
        if cell == nil then
            xpcall(function()
                cell = UI.TableViewCell:create()

                local cardView = mvc.manorStarMapPokedexCellView:create(pokedexConfig[luaIdx].Id)
                cardView:init()
                cardView:leftBottom(15,0)
                cell:addChild(cardView)

                -- self._cardViewTable[luaIdx] = cardView
            end, 
            function(e) 
                printError("------------------------ManorStarMapPokedexView-----------------error", e)
            end, 1)
        end

        return cell
    end)


    self.tableView:onUpdateCellNumbers(function()
        return table.nums(pokedexConfig)
    end)
    self.tableView:reloadData()
end


function ManorStarMapPokedexView:bindModel()

end


function ManorStarMapPokedexView:unbindModel()

end





return ManorStarMapPokedexView












