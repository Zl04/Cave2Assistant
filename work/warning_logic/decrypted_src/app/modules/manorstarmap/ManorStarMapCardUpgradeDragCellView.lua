------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/07/12
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapCardUpgradeDragCellView = class("ManorStarMapCardUpgradeDragCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_home_starmap.plist",
}

local COM_WIDTH = 130
local COM_HEIGHT = 192

function ManorStarMapCardUpgradeDragCellView:ctor(cardData)
    ManorStarMapCardUpgradeDragCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._cardData = cardData

    self._isDragging = false
    self._touchBeganPosition = nil
end

function ManorStarMapCardUpgradeDragCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapCardUpgradeDragCellView.super.init(self, ... )
end

function ManorStarMapCardUpgradeDragCellView:dtor()
    ManorStarMapCardUpgradeDragCellView.super.dtor(self)
    self:unbindModel()
    self.dragBeginCallback = nil
    self.dragMoveCallback = nil
    self.dragEndCallback = nil
    self.dragOutAreaJudgeNode = nil
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapCardUpgradeDragCellView")
end


function ManorStarMapCardUpgradeDragCellView:onInitView()

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bgBtn = UI.Button:create()
    bgBtn:init('ui_starmap_book_paper_2.png', 'ui_starmap_book_paper_2.png', 'ui_starmap_book_paper_2.png')
    bgBtn:leftBottom(0, 0)
    bgBtn:closeClickScale()
    bgBtn:setSwallowTouches(false)
    bgBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        
    end)
    contentLayout:addChild(bgBtn)

    local cardView = mvc.manorStarMapCardCellView:create(self._cardData)
    cardView:init()
    cardView:center(0,-24)
    contentLayout:addChild(cardView)

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

end

function ManorStarMapCardUpgradeDragCellView:enableDrage()
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
    self:addEventListener(UIEvent.COMPONENT_DRAG_BEGAN, self, self.onDragBeganByCard)
    self:addEventListener(UIEvent.COMPONENT_DRAG_MOVED, self, self.onDragMoveByCard)
    self:addEventListener(UIEvent.COMPONENT_DRAG_ENDED, self, self.onDragEndedByCard)
end

function ManorStarMapCardUpgradeDragCellView:setDragBeginCallback(callback)
    self.dragBeginCallback = callback;
end

function ManorStarMapCardUpgradeDragCellView:setDragMoveCallback(callback)
    self.dragMoveCallback = callback
end

function ManorStarMapCardUpgradeDragCellView:setDragEndCallback(callback)
    self.dragEndCallback = callback
end

function ManorStarMapCardUpgradeDragCellView:setDragOutAreaJudgeNode(node)
    self.dragOutAreaJudgeNode = node
end

function ManorStarMapCardUpgradeDragCellView:createDraggedView()
    local cardView = mvc.manorStarMapCardUpgradeDragCellView:create(self._cardData)
    cardView:init()

    return cardView
end

-- 拖拽格子的条件检测是否成立
function ManorStarMapCardUpgradeDragCellView:checkGridDraged(selectedGrid, startPosition, endPosition)
    local check = false
    local distance = cc.pGetDistance(startPosition, endPosition)
    local distanceEnough =  distance >= COMPONENT_DRAG_DISTANCE

    local localPosition = selectedGrid:convertToNodeSpace(startPosition)
    local size = selectedGrid:getContentSize()

    if (localPosition.x >= 0 and 
        localPosition.y >= 0 and 
        localPosition.x <= size.width and 
        localPosition.y <= size.height) then
        local offsetX = math.abs(startPosition.x - endPosition.x)
        local offsetY = math.abs(startPosition.y - endPosition.y)
        if (offsetX > 0 and offsetY > 0) then
            check = (offsetX / offsetY) >= 1.0
        end
    end
    check = (check and distanceEnough)
    return check
end

function ManorStarMapCardUpgradeDragCellView:onDragBeganByCard(grid, touchPosition, touch)
    if (tolua.isnull(self)) then return end
    
    if self.dragBeginCallback then
        self.mCanDrag = self.dragBeginCallback(self)
        if self.mCanDrag == nil then
            self.mCanDrag = true
        end
    else 
        self.mCanDrag = false
    end
    
    if not self.mCanDrag then
        return
    end

    if (not self._isDragging) then
        self._touchBeganPosition = touchPosition
    end

    
end

function ManorStarMapCardUpgradeDragCellView:onDragMoveByCard(grid, touchPosition, touch)
    if (tolua.isnull(self)) then return end

    if self.mCanDrag == false then
        return
    end

    

    if self:checkGridDraged(self,self._touchBeganPosition,touchPosition) then
        -- 创建一个克隆的节点，放到最上层来拖动，避免层级之间的遮挡
        if self.dragCloneNode == nil then
            self.dragCloneNode = self:createDraggedView();
            UI.UIManager:addToRootNode(self.dragCloneNode, 100000)

            require("app.ui.common.GoodsList.DragFingerAnimation")
            local dragAnimation = UI.DragFingerAnimation:create()
            dragAnimation:init()
            dragAnimation:centerUp(-30)
            self.dragCloneNode:addChild(dragAnimation)
            self._dragAnimation = dragAnimation

            local wPos = self:convertToWorldSpace(self:getAnchorPointInPoints())
            wPos.x = wPos.x - self:getContentSize().width / 2
            wPos.y = wPos.y - self:getContentSize().height / 2
            self.dragCloneNode:setPosition(wPos)
            self:setVisible(false)

            self._isDragging = true
            self:setSwallowTouches(true)
        end

        if self.dragMoveCallback then
            self.dragMoveCallback(self);
        end

    end

    if(not tolua.isnull(self.dragCloneNode)) then
        local x, y = self.dragCloneNode:getPosition();
        local delta = touch:getDelta();
        self.dragCloneNode:setPosition(cc.p(x + delta.x, y + delta.y))
    end

    if self.dragOutAreaJudgeNode == nil then
        assert(false, "setDragOutAreaJudgeNode() not set")
        return
    end

    if(not tolua.isnull(self._dragAnimation)) then
        local pos = self.dragOutAreaJudgeNode:convertToNodeSpace(touchPosition)
        local size = self.dragOutAreaJudgeNode:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        local inSide = cc.rectContainsPoint(rect, pos)

        self._dragAnimation:changeInSideStatus(inSide)

        if self.dragMoveCallback then
            self.dragMoveCallback(self,inSide);
        end
    end
end

function ManorStarMapCardUpgradeDragCellView:onDragEndedByCard(grid, touchPosition, touch)
    if (tolua.isnull(self)) then return end

    if (not tolua.isnull(self.dragCloneNode)) then
        self.dragCloneNode:removeFromParent()
        self.dragCloneNode = nil
    end
    self:setVisible(true)

    if(not tolua.isnull(self._dragAnimation)) then
        self._dragAnimation:removeFromParent(true)
        self._dragAnimation = nil
    end

    

    if self.mCanDrag == false then
        return
    end

    -- 拖动结束时， 必须要有一个父节点来判断是否在某个区域内
    if self.dragOutAreaJudgeNode == nil then
        assert(false, "setDragOutAreaJudgeNode() not set")
        return
    end

    local pos = self.dragOutAreaJudgeNode:convertToNodeSpace(touchPosition)
    local size = self.dragOutAreaJudgeNode:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    local inSide = cc.rectContainsPoint(rect, pos)

    if self.dragEndCallback then
        self.dragEndCallback(self, inSide, self._isDragging);
    end

    if self._isDragging then
        self:setSwallowTouches(false)
        self._isDragging = false
    end
    
    -- Avalon.AudioManager:playSound("1505")
end

function ManorStarMapCardUpgradeDragCellView:bindModel()

end


function ManorStarMapCardUpgradeDragCellView:unbindModel()

end


return ManorStarMapCardUpgradeDragCellView












