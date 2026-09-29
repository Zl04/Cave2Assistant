------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/07/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapMosaicCellView = class("ManorStarMapMosaicCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 130
local COM_HEIGHT = 192

function ManorStarMapMosaicCellView:ctor(cardData,tableView)
    ManorStarMapMosaicCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._cardData = cardData
    self._tableView = tableView

    self._isSelect = false
    self._clickCallback = nil

end

function ManorStarMapMosaicCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapMosaicCellView.super.init(self, ... )
end

function ManorStarMapMosaicCellView:dtor()
    ManorStarMapMosaicCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapMosaicCellView")
end


function ManorStarMapMosaicCellView:onInitView()

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- local bgBtn = UI.Button:create()
    -- bgBtn:init('ui_starmap_book_paper_2.png', 'ui_starmap_book_paper_2.png', 'ui_starmap_book_paper_2.png')
    -- bgBtn:leftBottom(0, 0)
    -- bgBtn:closeClickScale()
    -- bgBtn:setSwallowTouches(false)
    -- bgBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
    --     print("22222222 ")
    --     self:setSelect(not self._isSelect)

    --     if self._clickCallback then
    --         self._clickCallback(self)
    --     end
    -- end)
    -- contentLayout:addChild(bgBtn)


    local bgBtn = UI.Image:create()
    bgBtn:init("ui_starmap_book_paper_2.png")
    bgBtn:leftBottom(0, 0)
    contentLayout:addChild(bgBtn)


    local cardView = mvc.manorStarMapCardCellView:create(self._cardData)
    cardView:init()
    cardView:center(0,-24)
    contentLayout:addChild(cardView)

    local selectBg = UI.Image:create()
    selectBg:init("ui_starmap_checkerebg.png")
    selectBg:rightUp(-3,-3)
    contentLayout:addChild(selectBg)

    self._selectImg = UI.Image:create()
    self._selectImg:init("ui_starmap_checkere_hook.png")
    self._selectImg:center(0,0)
    selectBg:addChild(self._selectImg)

    self:setSelect(self._isSelect)


    local attrData = mvc.manorStarMapModel:getCardAttributesByCardData(self._cardData)

    for k,v in ipairs(attrData) do
        local nowValue,valueType = ToolsUtil:calculationAttrShowValue(v.attrType,v.value)
        if valueType == PublicDefine.VALUE_TYPE.Value then
            local valueNum = tonumber(nowValue)
            if valueNum > 99999 then 
                valueNum = AvalonUtil:getSimpleNumber(valueNum, 4) 
                nowValue = tostring(valueNum)
            end
        end

        local attrIcon = UI.Image:create()
        attrIcon:init(v.icon)
        attrIcon:centerBottom(28 - (k - 1) * 24, -31.5)
        contentLayout:addChild(attrIcon)

        local attrText = UI.Text:create()
        attrText:init(nowValue, UI.FONT_BOLD, UI.FONT_SIZE_14PX, {r=40,g=40,b=42})
        attrText:centerBottom(28 - (k - 1) * 24, 12)
        contentLayout:addChild(attrText)

    end

    self:enableDrage()

end

function ManorStarMapMosaicCellView:enableDrage()
    self:setTouchEnable(true)
    self:setSwallowTouches(false)
    self:setInterceptTouches(false)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, self.onDragBeganByCard)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onDragMoveByCard)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onDragEndedByCard)
end

function ManorStarMapMosaicCellView:setSelect(isSelect)
    self._isSelect = isSelect

    if self._isSelect then
        self._selectImg:show()
    else
        self._selectImg:hide()
    end

end

function ManorStarMapMosaicCellView:setCallBack(callback)
    self._clickCallback = callback
end

function ManorStarMapMosaicCellView:checkGridDraged(selectedGrid, startPosition)
    local check = false

    local localPosition = selectedGrid:convertToNodeSpace(startPosition)
    local size = selectedGrid:getContentSize()
    
    if (localPosition.x >= 0 and 
        localPosition.y >= 0 and 
        localPosition.x <= size.width and 
        localPosition.y <= size.height) then
        check = true
    end
    return check
end

function ManorStarMapMosaicCellView:onDragBeganByCard(grid, touchPosition, touch)
    if (tolua.isnull(self)) then return end
end

function ManorStarMapMosaicCellView:onDragMoveByCard(grid, touchPosition, touch)

end

function ManorStarMapMosaicCellView:onDragEndedByCard(grid, touchPosition, touch)
    
    if self:checkGridDraged(self._tableView,touchPosition) and self:checkGridDraged(self,touchPosition) then
        self:setSelect(not self._isSelect)

        if self._clickCallback then
            self._clickCallback(self)
        end
    end
end


function ManorStarMapMosaicCellView:bindModel()

end


function ManorStarMapMosaicCellView:unbindModel()

end





return ManorStarMapMosaicCellView












