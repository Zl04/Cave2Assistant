------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/25
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local UseMoldToolBoxGridView = class("UseMoldToolBoxGridView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 80
local COM_HEIGHT = 80

function UseMoldToolBoxGridView:ctor()
    UseMoldToolBoxGridView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self._isDragging = false
    self._touchBeganPosition = nil
    self:bindModel()
end

function UseMoldToolBoxGridView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.usemold", "UseMold", false)
    UseMoldToolBoxGridView.super.init(self, ... )
end

function UseMoldToolBoxGridView:dtor()
    UseMoldToolBoxGridView.super.dtor(self)
    self:unbindModel()
    self.dragBeginCallback = nil
    self.dragMoveCallback = nil
    self.dragEndCallback = nil
    self.dragOutAreaJudgeNode = nil
    reload_script_file_mvc("app.modules.usemold.UseMoldToolBoxGridView")
end


function UseMoldToolBoxGridView:onInitView()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self:addChild(cellLayout)
    -- cellLayout:enableDebugDraw()
    cellLayout:setTouchEnable(true)
    -- self:setInterceptTouches(false)

    -- 背景
    -- local bg = UI.Image:create()
    -- bg:init("box_quality_2_3.png")
    -- bg:center()
    -- cellLayout:addChild(bg)
end

function UseMoldToolBoxGridView:createDraggedView()
    local cardView = mvc.UseMoldToolBoxGridView:create(self._cardData)
    cardView:init()

    return cardView
end

function UseMoldToolBoxGridView:enableDrage()
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
    self:addEventListener(UIEvent.COMPONENT_DRAG_BEGAN, self, self.onDragBeganByBox)
    self:addEventListener(UIEvent.COMPONENT_DRAG_MOVED, self, self.onDragMoveByBox)
    self:addEventListener(UIEvent.COMPONENT_DRAG_ENDED, self, self.onDragEndedByBox)
end

function UseMoldToolBoxGridView:setDragBeginCallback(callback)
    self.dragBeginCallback = callback;
end

function UseMoldToolBoxGridView:setDragMoveCallback(callback)
    self.dragMoveCallback = callback
end

function UseMoldToolBoxGridView:setDragEndCallback(callback)
    self.dragEndCallback = callback
end

function UseMoldToolBoxGridView:setDragOutAreaJudgeNode(node)
    self.dragOutAreaJudgeNode = node
end

-- 拖拽格子的条件检测是否成立
function UseMoldToolBoxGridView:checkGridDraged(selectedGrid, startPosition, endPosition)
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

function UseMoldToolBoxGridView:onDragBeganByBox(grid, touchPosition, touch)
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

function UseMoldToolBoxGridView:onDragMoveByBox(grid, touchPosition, touch)
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

function UseMoldToolBoxGridView:onDragEndedByBox(grid, touchPosition, touch)
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

function UseMoldToolBoxGridView:bindModel()

end


function UseMoldToolBoxGridView:unbindModel()

end





return UseMoldToolBoxGridView












