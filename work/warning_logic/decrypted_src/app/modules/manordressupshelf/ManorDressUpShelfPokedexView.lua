------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/08/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorDressUpShelfPokedexView = class("ManorDressUpShelfPokedexView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 1111
local COM_HEIGHT = 564

function ManorDressUpShelfPokedexView:ctor(lockingIdex)
    ManorDressUpShelfPokedexView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._lockingIdex = lockingIdex
end

function ManorDressUpShelfPokedexView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manordressupshelf", "ManorDressUpShelf", false)
    ManorDressUpShelfPokedexView.super.init(self, ... )
end

function ManorDressUpShelfPokedexView:dtor()
    ManorDressUpShelfPokedexView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manordressupshelf.ManorDressUpShelfPokedexView")
end


function ManorDressUpShelfPokedexView:onInitView()
    self:center()

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self:refreshPokedexView()
end

function ManorDressUpShelfPokedexView:refreshPokedexView()
    self.contentLayout:removeAllChildren()

    local bg  = UI.Image:create()
    bg:init("ui_illusionstand_bg_2.png")
    bg:center()
    self.contentLayout:addChild(bg)
    self._bg = bg

    local rData = clone(ConfigManager:getAllIllusionRackData())

    local tableView = UI.TableView:create({}, 826 + 15, 471)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:leftBottom(25,5)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setBounceable(true) 
    tableView:init()
    tableView:setScrollBarEnabled(true)
    tableView:setCircleVisible(false)
    tableView:onUpdateCellSize(function (tableview, idx)
        return 826,130
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

                local attrLayout = UI.Layout:create()
                attrLayout:init()
                attrLayout:setSize(826,112)
                attrLayout:leftBottom(0,18)

                local attrBg = UI.Image:create()
                attrBg:init("ui_illusionstand_bg_3.png")
                attrBg:leftBottom(0,0)
                attrLayout:addChild(attrBg)

                local data = rData[luaIdx]
                if data then

                    local isActivate = mvc.manorDressUpShelfModel:checkActivateById(data.ID)

                    local titleText = UI.Text:create()
                    titleText:init(UI.TEXT_222803 .. LanguageManager:getInstance():getLocalString(data.effectName), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=172,g=165,b=159})
                    titleText:leftUp(5,5)
                    attrBg:addChild(titleText)

                    local activateText = UI.Text:create()
                    activateText:init(UI.TEXT_222805, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r=172,g=165,b=159})
                    activateText:rightUp(28,5)
                    attrBg:addChild(activateText)

                    local desText = UI.Text:create()
                    desText:init(LanguageManager:getInstance():getLocalString(data.desc), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
                    desText:leftUp(32,48)
                    desText:setWidth(764)
                    desText:setTextLeftUp()
                    desText:autoAdapt()
                    attrBg:addChild(desText)

                    if isActivate then
                        activateText:setText(UI.TEXT_222804)
                        activateText:setFontColor({r=214,g=177,b=110})
                        desText:setFontColor({r=214,g=177,b=110})
                    end

                end

                if self._lockingIdex == luaIdx then
                    --高亮
                    local selectImg = UI.Image:create()
                    selectImg:init("ui_illusionstand_box_select.png")
                    selectImg:leftBottom(0,0)
                    attrBg:addChild(selectImg)
                end


                cell:addChild(attrLayout)
            end, 
            function(e) 
                printError("------------------------refreshCardLayout-----------------error", e)
            end, 1)
        end

        return cell
    end)

    tableView:onUpdateCellNumbers(function()
        return #rData
    end)
    self._bg:addChild(tableView)
    tableView:reloadData()

    if self._lockingIdex ~= nil and self._lockingIdex >= 1 then
        tableView:scrollToCell(self._lockingIdex, 1.3, true)
    end

end


function ManorDressUpShelfPokedexView:bindModel()

end


function ManorDressUpShelfPokedexView:unbindModel()

end





return ManorDressUpShelfPokedexView












